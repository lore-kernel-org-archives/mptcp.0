Content-Type: multipart/mixed; boundary="===============0922435977776113875=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 2/6] Squash-to: "mptcp: Add path manager interface"
Date: Tue, 11 Feb 2020 19:12:09 +0100
Message-ID: <d62fdfef647801bac3445fa4f210d4aacc0e5991.1581444137.git.pabeni@redhat.com>
In-Reply-To: cover.1581444137.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3617

--===============0922435977776113875==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Factor out PM addr info to simplify PM data definition and
simplify the PM hooks/APIs.

The PM will carry a single local and remote addrs - the one
currently being processed, if any. It's up to the PM impl,
e.g. netlink, maintain additional per msk data, if needed.

Account the number of created subflow and received addresses,
to enforce limits.

Add a spinlock to protect PM datas, so that we can manipulate
them from subflow BH.

Delegate events handling to a workqueue, so that PM events can
be processed with both the above spinlock and the msk socket
lock held. The PM impl should hook inside the worker.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/options.c  |  45 +++++++++---------
 net/mptcp/pm.c       | 109 +++++++++++++------------------------------
 net/mptcp/protocol.c |   2 +
 net/mptcp/protocol.h |  96 ++++++++++++++++++++++---------------
 4 files changed, 117 insertions(+), 135 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 6a2d6cea7d54..13fe6245cfcf 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -432,34 +432,30 @@ static bool mptcp_established_options_addr(struct soc=
k *sk,
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
-	struct sockaddr_storage saddr;
-	u8 id;
+	struct mptcp_addr_info saddr;
+	int len;
 =

 	if (!msk)
 		return false;
 =

-	if (!msk->pm.fully_established)
+	if (!mptcp_pm_should_signal(msk) ||
+	    !(mptcp_pm_addr_signal(msk, remaining, &saddr)))
 		return false;
 =

-	if (mptcp_pm_addr_signal(msk, &id, &saddr))
+	len =3D mptcp_add_addr_len(saddr.family);
+	if (remaining < len)
 		return false;
 =

-	if (saddr.ss_family =3D=3D AF_INET) {
-		if (remaining < TCPOLEN_MPTCP_ADD_ADDR)
-			return false;
+	*size =3D len;
+	opts->addr_id =3D saddr.id;
+	if (saddr.family =3D=3D AF_INET) {
 		opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
-		opts->addr_id =3D id;
-		opts->addr =3D ((struct sockaddr_in *)&saddr)->sin_addr;
-		*size =3D TCPOLEN_MPTCP_ADD_ADDR;
+		opts->addr =3D saddr.addr;
 	}
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-	else if (saddr.ss_family =3D=3D AF_INET6) {
-		if (remaining < TCPOLEN_MPTCP_ADD_ADDR6)
-			return false;
+	else if (saddr.family =3D=3D AF_INET6) {
 		opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR6;
-		opts->addr_id =3D id;
-		opts->addr6 =3D ((struct sockaddr_in6 *)&saddr)->sin6_addr;
-		*size =3D TCPOLEN_MPTCP_ADD_ADDR6;
+		opts->addr6 =3D saddr.addr6;
 	}
 #endif
 =

@@ -557,13 +553,20 @@ void mptcp_incoming_options(struct sock *sk, struct s=
k_buff *skb,
 		return;
 =

 	if (msk && mp_opt->add_addr) {
-		if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_4)
-			mptcp_pm_add_addr(msk, &mp_opt->addr, mp_opt->addr_id);
+		struct mptcp_addr_info addr;
+
+		addr.id =3D mp_opt->addr_id;
+		if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_4) {
+			addr.family =3D AF_INET;
+			addr.addr =3D mp_opt->addr;
+		}
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-		else if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_6)
-			mptcp_pm_add_addr6(msk, &mp_opt->addr6,
-					   mp_opt->addr_id);
+		else if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_6) {
+			addr.family =3D AF_INET6;
+			addr.addr6 =3D mp_opt->addr6;
+		}
 #endif
+		mptcp_pm_add_addr(msk, &addr);
 		mp_opt->add_addr =3D 0;
 	}
 =

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index c9f508451f2e..654a985261f6 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -8,38 +8,22 @@
 #include <net/mptcp.h>
 #include "protocol.h"
 =

-/* path manager command handlers */
-
-int mptcp_pm_announce_addr(u32 token, u8 local_id, struct in_addr *addr)
-{
-	return -ENOTSUPP;
-}
-
-#if IS_ENABLED(CONFIG_MPTCP_IPV6)
-int mptcp_pm_announce_addr6(u32 token, u8 local_id, struct in6_addr *addr)
-{
-	return -ENOTSUPP;
-}
-#endif
+static struct workqueue_struct *pm_wq;
 =

-int mptcp_pm_remove_addr(u32 token, u8 local_id)
-{
-	return -ENOTSUPP;
-}
+/* path manager command handlers */
 =

-int mptcp_pm_create_subflow(u32 token, u8 remote_id, struct in_addr *addr)
+int mptcp_pm_announce_addr(struct mptcp_sock *msk,
+			   const struct mptcp_addr_info *addr)
 {
 	return -ENOTSUPP;
 }
 =

-#if IS_ENABLED(CONFIG_MPTCP_IPV6)
-int mptcp_pm_create_subflow6(u32 token, u8 remote_id, struct in6_addr *add=
r)
+int mptcp_pm_remove_addr(struct mptcp_sock *msk, u8 local_id)
 {
 	return -ENOTSUPP;
 }
-#endif
 =

-int mptcp_pm_remove_subflow(u32 token, u8 remote_id)
+int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 remote_id)
 {
 	return -ENOTSUPP;
 }
@@ -50,10 +34,9 @@ void mptcp_pm_new_connection(struct mptcp_sock *msk, int=
 server_side)
 {
 	struct mptcp_pm_data *pm =3D &msk->pm;
 =

-	pr_debug("msk=3D%p, token=3D%u", msk, msk->token);
+	pr_debug("msk=3D%p, token=3D%u side=3D%d", msk, msk->token, server_side);
 =

-	pm->server_side =3D server_side;
-	pm->token =3D msk->token;
+	WRITE_ONCE(pm->server_side, server_side);
 }
 =

 void mptcp_pm_fully_established(struct mptcp_sock *msk)
@@ -61,8 +44,6 @@ void mptcp_pm_fully_established(struct mptcp_sock *msk)
 	struct mptcp_pm_data *pm =3D &msk->pm;
 =

 	pr_debug("msk=3D%p", msk);
-
-	pm->fully_established =3D 1;
 }
 =

 void mptcp_pm_connection_closed(struct mptcp_sock *msk)
@@ -70,7 +51,8 @@ void mptcp_pm_connection_closed(struct mptcp_sock *msk)
 	pr_debug("msk=3D%p", msk);
 }
 =

-void mptcp_pm_subflow_established(struct mptcp_sock *msk, u8 id)
+void mptcp_pm_subflow_established(struct mptcp_sock *msk,
+				  struct mptcp_subflow_context *subflow)
 {
 	pr_debug("msk=3D%p", msk);
 }
@@ -80,71 +62,46 @@ void mptcp_pm_subflow_closed(struct mptcp_sock *msk, u8=
 id)
 	pr_debug("msk=3D%p", msk);
 }
 =

-void mptcp_pm_add_addr(struct mptcp_sock *msk, const struct in_addr *addr,
-		       u8 id)
+void mptcp_pm_add_addr(struct mptcp_sock *msk,
+		       const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_data *pm =3D &msk->pm;
 =

-	pr_debug("msk=3D%p, addr=3D%x, remote_id=3D%d", msk, addr->s_addr, id);
-
-	pm->remote_addr =3D *addr;
-	pm->remote_id =3D id;
-	pm->remote_family =3D AF_INET;
-	pm->remote_valid =3D 1;
-}
-
-void mptcp_pm_add_addr6(struct mptcp_sock *msk, const struct in6_addr *add=
r,
-			u8 id)
-{
-	pr_debug("msk=3D%p", msk);
+	pr_debug("msk=3D%p, remote_id=3D%d", msk, addr->id);
 }
 =

 /* path manager helpers */
 =

-int mptcp_pm_addr_signal(struct mptcp_sock *msk, u8 *id,
-			 struct sockaddr_storage *saddr)
+int mptcp_pm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
+			 struct mptcp_addr_info *saddr)
 {
-#if IS_ENABLED(CONFIG_MPTCP_IPV6)
-	struct sockaddr_in6 *addr6 =3D (struct sockaddr_in6 *)saddr;
-#endif
-	struct sockaddr_in *addr =3D (struct sockaddr_in *)saddr;
-
-	if (!msk->pm.local_valid)
-		return -1;
-
-	if (msk->pm.local_family =3D=3D AF_INET) {
-		addr->sin_family =3D msk->pm.local_family;
-		addr->sin_addr =3D msk->pm.local_addr;
-#if IS_ENABLED(CONFIG_MPTCP_IPV6)
-	} else if (msk->pm.local_family =3D=3D AF_INET6) {
-		addr6->sin6_family =3D msk->pm.local_family;
-		addr6->sin6_addr =3D msk->pm.local_addr6;
-#endif
-	} else {
-		return -1;
-	}
-	*id =3D msk->pm.local_id;
-
 	return 0;
 }
 =

-int mptcp_pm_get_local_id(struct request_sock *req, struct sock *sk,
-			  const struct sk_buff *skb)
+int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 {
-	struct mptcp_subflow_request_sock *subflow_req =3D mptcp_subflow_rsk(req);
-	struct mptcp_sock *msk =3D mptcp_sk(sk);
-
-	if (!msk->pm.local_valid)
-		return -1;
+	return 0;
+}
 =

-	/* @@ check if address actually matches... */
+static void pm_worker(struct work_struct *work)
+{
+}
 =

-	pr_debug("msk=3D%p, addr_id=3D%d", msk, msk->pm.local_id);
-	subflow_req->local_id =3D msk->pm.local_id;
+void mptcp_pm_data_init(struct mptcp_sock *msk)
+{
+	WRITE_ONCE(msk->pm.add_addr_signaled, 0);
+	WRITE_ONCE(msk->pm.add_addr_accepted, 0);
+	WRITE_ONCE(msk->pm.local_addr_used, 0);
+	msk->pm.fully_established =3D false;
+	msk->pm.status =3D MPTCP_PM_IDLE;
 =

-	return 0;
+	spin_lock_init(&msk->pm.lock);
+	INIT_WORK(&msk->pm.work, pm_worker);
 }
 =

 void mptcp_pm_init(void)
 {
+	pm_wq =3D alloc_workqueue("pm_wq", WQ_UNBOUND | WQ_MEM_RECLAIM, 8);
+	if (!pm_wq)
+		panic("Failed to allocate workqueue");
 }
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 620af9d1c6bc..a30d26661b61 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -605,6 +605,8 @@ static int __mptcp_init_sock(struct sock *sk)
 =

 	msk->first =3D NULL;
 =

+	mptcp_pm_data_init(msk);
+
 	return 0;
 }
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1d658d9aac36..3e08d38549e3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -76,32 +76,45 @@ static inline __be32 mptcp_option(u8 subopt, u8 len, u8=
 nib, u8 field)
 		     ((nib & 0xF) << 8) | field);
 }
 =

-struct mptcp_pm_data {
-	u8	local_valid;
-	u8	local_id;
-	sa_family_t local_family;
-	union {
-		struct in_addr local_addr;
-#if IS_ENABLED(CONFIG_MPTCP_IPV6)
-		struct in6_addr local_addr6;
-#endif
-	};
-	u8	remote_valid;
-	u8	remote_id;
-	sa_family_t remote_family;
+#define MPTCP_PM_MAX_ADDR	4
+
+struct mptcp_addr_info {
+	sa_family_t		family;
+	__be16			port;
+	u8			id;
 	union {
-		struct in_addr remote_addr;
+		struct in_addr addr;
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-		struct in6_addr remote_addr6;
+		struct in6_addr addr6;
 #endif
 	};
-	u8	server_side : 1,
-		fully_established : 1;
+};
 =

-	/* for interim path manager */
-	struct	work_struct addr_work;
-	struct	work_struct subflow_work;
-	u32	token;
+enum mptcp_pm_status {
+	MPTCP_PM_IDLE,
+	MPTCP_PM_ADD_ADDR,
+	MPTCP_PM_ESTABLISHED,
+	MPTCP_PM_SUBFLOW_ESTABLISHED,
+};
+
+struct mptcp_pm_data {
+	struct mptcp_addr_info local;
+	struct mptcp_addr_info remote;
+
+	spinlock_t	lock;
+
+	bool		addr_signal;
+	bool		server_side;
+	bool		fully_established;
+	enum mptcp_pm_status status;
+	u8		add_addr_signaled;
+	u8		add_addr_accepted;
+	u8		local_addr_used;
+	u8		add_addr_signal_max;
+	u8		add_addr_accept_max;
+	u8		local_addr_max;
+
+	struct		work_struct work;
 };
 =

 /* MPTCP connection sock */
@@ -273,29 +286,36 @@ void mptcp_crypto_hmac_sha(u64 key1, u64 key2, u32 no=
nce1, u32 nonce2,
 			   void *hash_out);
 =

 void mptcp_pm_init(void);
+void mptcp_pm_data_init(struct mptcp_sock *msk);
 void mptcp_pm_new_connection(struct mptcp_sock *msk, int server_side);
 void mptcp_pm_fully_established(struct mptcp_sock *msk);
 void mptcp_pm_connection_closed(struct mptcp_sock *msk);
-void mptcp_pm_subflow_established(struct mptcp_sock *msk, u8 id);
+void mptcp_pm_subflow_established(struct mptcp_sock *msk,
+				  struct mptcp_subflow_context *subflow);
 void mptcp_pm_subflow_closed(struct mptcp_sock *msk, u8 id);
-void mptcp_pm_add_addr(struct mptcp_sock *msk, const struct in_addr *addr,
-		       u8 id);
-void mptcp_pm_add_addr6(struct mptcp_sock *msk, const struct in6_addr *add=
r,
-			u8 id);
+void mptcp_pm_add_addr(struct mptcp_sock *msk,
+		       const struct mptcp_addr_info *addr);
 =

-int mptcp_pm_announce_addr(u32 token, u8 local_id, struct in_addr *addr);
-int mptcp_pm_create_subflow(u32 token, u8 remote_id, struct in_addr *addr);
-#if IS_ENABLED(CONFIG_MPTCP_IPV6)
-int mptcp_pm_announce_addr6(u32 token, u8 local_id, struct in6_addr *addr);
-int mptcp_pm_create_subflow6(u32 token, u8 remote_id, struct in6_addr *add=
r);
-#endif
-int mptcp_pm_remove_addr(u32 token, u8 local_id);
-int mptcp_pm_remove_subflow(u32 token, u8 remote_id);
+int mptcp_pm_announce_addr(struct mptcp_sock *msk,
+			     const struct mptcp_addr_info *addr);
+int mptcp_pm_remove_addr(struct mptcp_sock *msk, u8 local_id);
+int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 remote_id);
+
+static inline bool mptcp_pm_should_signal(struct mptcp_sock *msk)
+{
+	return READ_ONCE(msk->pm.addr_signal);
+}
+
+static inline unsigned mptcp_add_addr_len(int family)
+{
+	if (family =3D=3D AF_INET)
+		return OPTION_MPTCP_ADD_ADDR;
+	return OPTION_MPTCP_ADD_ADDR6;
+}
 =

-int mptcp_pm_addr_signal(struct mptcp_sock *msk, u8 *id,
-			 struct sockaddr_storage *saddr);
-int mptcp_pm_get_local_id(struct request_sock *req, struct sock *sk,
-			  const struct sk_buff *skb);
+int mptcp_pm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
+			 struct mptcp_addr_info *saddr);
+int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 =

 static inline struct mptcp_ext *mptcp_get_ext(struct sk_buff *skb)
 {
-- =

2.21.1

--===============0922435977776113875==--
