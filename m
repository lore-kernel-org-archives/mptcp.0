Content-Type: multipart/mixed; boundary="===============8698770454063551080=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/9] Extend path manager interface
Date: Wed, 17 Jul 2019 15:12:48 -0700
Message-ID: <20190717221256.7358-2-peter.krystad@linux.intel.com>
In-Reply-To: 20190717221256.7358-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1512

--===============8698770454063551080==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A little more functionality and some comments clarifying
which routines are for a path manager to call and which are
callbacks.

squashto: Add path manager interface

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/options.c  | 19 +++++++++--
 net/mptcp/pm.c       | 77 ++++++++++++++++++++++++++++++++++++++++----
 net/mptcp/protocol.c |  5 +--
 net/mptcp/protocol.h | 35 ++++++++++++++++----
 4 files changed, 117 insertions(+), 19 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 58215f19829a..0d0d47f84adb 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -412,10 +412,10 @@ static bool mptcp_established_options_addr(struct soc=
k *sk,
 	struct subflow_context *subflow =3D subflow_ctx(sk);
 	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
 =

-	if (subflow->fourth_ack)
-		return pm_addr_signal(msk, size, remaining, opts);
+	if (!msk)
+		return false;
 =

-	return false;
+	return pm_addr_signal(msk, size, remaining, opts);
 }
 =

 bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
@@ -479,11 +479,20 @@ bool mptcp_synack_options(const struct request_sock *=
req, unsigned int *size,
 void mptcp_attach_dss(struct sock *sk, struct sk_buff *skb,
 		      struct tcp_options_received *opt_rx)
 {
+	struct subflow_context *subflow =3D subflow_ctx(sk);
+	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
 	struct mptcp_options_received *mp_opt;
 	struct mptcp_ext *mpext;
 =

 	mp_opt =3D &opt_rx->mptcp;
 =

+	if (mp_opt->add_addr && mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_4) {
+		if (msk) {
+			pm_add_addr(msk, &mp_opt->addr, mp_opt->addr_id);
+			mp_opt->add_addr =3D 0;
+		}
+	}
+
 	if (!mp_opt->dss)
 		return;
 =

@@ -510,6 +519,10 @@ void mptcp_attach_dss(struct sock *sk, struct sk_buff =
*skb,
 	}
 =

 	mpext->data_fin =3D mp_opt->data_fin;
+
+	if (msk)
+		pm_fully_established(msk);
+
 }
 =

 void mptcp_write_options(__be32 *ptr, struct mptcp_out_options *opts)
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 9e9c681a4544..0d53a0f23d2d 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -8,14 +8,42 @@
 #include <net/mptcp.h>
 #include "protocol.h"
 =

-void pm_new_connection(struct mptcp_sock *msk)
+/* path manager command handlers */
+
+int pm_announce_addr(u32 token, sa_family_t family, u8 id, struct in_addr =
*addr)
+{
+	return -ENOTSUPP;
+}
+
+int pm_remove_addr(u32 token, u8 id)
+{
+	return -ENOTSUPP;
+}
+
+int pm_create_subflow(u32 token, u8 local_id, u8 remote_id)
+{
+	return -ENOTSUPP;
+}
+
+int pm_remove_subflow(u32 token, u8 local_id, u8 remote_id)
+{
+	return -ENOTSUPP;
+}
+
+/* path manager event handlers */
+
+void pm_new_connection(struct mptcp_sock *msk, int server_side)
 {
 	pr_debug("msk=3D%p", msk);
+
+	msk->pm.server_side =3D server_side;
 }
 =

 void pm_fully_established(struct mptcp_sock *msk)
 {
 	pr_debug("msk=3D%p", msk);
+
+	msk->pm.fully_established =3D 1;
 }
 =

 void pm_connection_closed(struct mptcp_sock *msk)
@@ -35,7 +63,13 @@ void pm_subflow_closed(struct mptcp_sock *msk, u8 id)
 =

 void pm_add_addr(struct mptcp_sock *msk, const struct in_addr *addr, u8 id)
 {
-	pr_debug("msk=3D%p", msk);
+	pr_debug("msk=3D%p, addr=3D%x, remote_id=3D%d", msk, addr->s_addr, id);
+
+	msk->pm.remote_valid =3D 1;
+	msk->pm.remote_token =3D msk->token;
+	msk->pm.remote_addr.s_addr =3D addr->s_addr;
+	msk->pm.remote_id =3D id;
+	msk->pm.remote_family =3D AF_INET;
 }
 =

 void pm_add_addr6(struct mptcp_sock *msk, const struct in6_addr *addr, u8 =
id)
@@ -48,19 +82,48 @@ void pm_rm_addr(struct mptcp_sock *msk, u8 id)
 	pr_debug("msk=3D%p", msk);
 }
 =

+/* path manager helpers */
+
 bool pm_addr_signal(struct mptcp_sock *msk, unsigned int *size,
 		    unsigned int remaining, struct mptcp_out_options *opts)
 {
-	if (!msk || !msk->addr_signal)
+	if (!msk->pm.fully_established || !msk->addr_signal)
 		return false;
 =

-	if (msk->pm.family =3D=3D AF_INET && remaining < TCPOLEN_MPTCP_ADD_ADDR)
+	if (!msk->pm.local_valid)
 		return false;
 =

-	pr_debug("msk=3D%p", msk);
+	if (msk->pm.local_family =3D=3D AF_INET &&
+	    remaining < TCPOLEN_MPTCP_ADD_ADDR)
+		return false;
+
+	pr_debug("msk=3D%p, addr_id=3D%d", msk, msk->pm.local_id);
 	opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
-	opts->addr_id =3D msk->pm.addr_id;
-	opts->addr.s_addr =3D msk->pm.addr.s_addr;
+	opts->addr_id =3D msk->pm.local_id;
+	opts->addr.s_addr =3D msk->pm.local_addr.s_addr;
+	*size =3D TCPOLEN_MPTCP_ADD_ADDR;
+	msk->addr_signal =3D 0;
 =

 	return true;
 }
+
+int pm_get_local_id(struct request_sock *req, struct sock *sk,
+		    const struct sk_buff *skb)
+{
+	struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+
+	if (!msk->pm.local_valid)
+		return -1;
+
+	/* @@ check if address actually matches... */
+
+	pr_debug("msk=3D%p, addr_id=3D%d", msk, msk->pm.local_id);
+	subflow_req->local_id =3D msk->pm.local_id;
+
+	return 0;
+}
+
+void pm_init(void)
+{
+}
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 774ed25d3b6d..a56085742cf7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -632,7 +632,7 @@ static struct sock *mptcp_accept(struct sock *sk, int f=
lags, int *err,
 		token_update_accept(new_sock->sk, new_mptcp_sock);
 		msk->subflow =3D NULL;
 =

-		pm_new_connection(msk);
+		pm_new_connection(msk, 1);
 =

 		crypto_key_sha1(msk->remote_key, NULL, &ack_seq);
 		msk->write_seq =3D subflow->idsn + 1;
@@ -759,7 +759,7 @@ void mptcp_finish_connect(struct sock *sk, int mp_capab=
le)
 		msk->token =3D subflow->token;
 		pr_debug("msk=3D%p, token=3D%u", msk, msk->token);
 =

-		pm_new_connection(msk);
+		pm_new_connection(msk, 0);
 =

 		crypto_key_sha1(msk->remote_key, NULL, &ack_seq);
 		msk->write_seq =3D subflow->idsn + 1;
@@ -1008,6 +1008,7 @@ void __init mptcp_init(void)
 	token_init();
 	crypto_init();
 	subflow_init();
+	pm_init();
 =

 	if (proto_register(&mptcp_prot, 1) !=3D 0)
 		panic("Failed to register MPTCP proto.\n");
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7f15f6aab93d..8c04774ea2ec 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -77,15 +77,33 @@ static inline u32 mptcp_option(u8 subopt, u8 len, u8 ni=
b, u8 field)
 		     ((nib & 0xF) << 8) | field);
 }
 =

-struct pm_data {
-	u8 addr_id;
-	sa_family_t family;
+struct mptcp_pm_data {
+	u8	local_valid;
+	u8	local_id;
+	sa_family_t local_family;
+	union {
+		struct in_addr local_addr;
+#if IS_ENABLED(CONFIG_IPV6)
+		struct in6_addr local_addr6;
+#endif
+	};
+	u8	remote_valid;
+	u8	remote_id;
+	sa_family_t remote_family;
 	union {
-		struct in_addr addr;
+		struct in_addr remote_addr;
 #if IS_ENABLED(CONFIG_IPV6)
-		struct in6_addr addr6;
+		struct in6_addr remote_addr6;
 #endif
 	};
+	u32	remote_token;
+	u8	server_side : 1,
+		fully_established : 1;
+
+	/* for interim path manager */
+	struct	work_struct addr_work;
+	struct	work_struct subflow_work;
+	u32	token;
 };
 =

 /* MPTCP connection sock */
@@ -99,7 +117,7 @@ struct mptcp_sock {
 	u32		token;
 	struct list_head conn_list;
 	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
-	struct pm_data	pm;
+	struct mptcp_pm_data	pm;
 	u8		addr_signal;
 };
 =

@@ -222,7 +240,8 @@ void crypto_key_sha1(u64 key, u32 *token, u64 *idsn);
 void crypto_hmac_sha1(u64 key1, u64 key2, u32 *hash_out,
 		      int arg_num, ...);
 =

-void pm_new_connection(struct mptcp_sock *msk);
+void pm_init(void);
+void pm_new_connection(struct mptcp_sock *msk, int server_side);
 void pm_fully_established(struct mptcp_sock *msk);
 void pm_connection_closed(struct mptcp_sock *msk);
 void pm_subflow_established(struct mptcp_sock *msk, u8 id);
@@ -232,6 +251,8 @@ void pm_add_addr6(struct mptcp_sock *msk, const struct =
in6_addr *addr, u8 id);
 void pm_rm_addr(struct mptcp_sock *msk, u8 id);
 bool pm_addr_signal(struct mptcp_sock *msk, unsigned int *size,
 		    unsigned int remaining, struct mptcp_out_options *opts);
+int pm_get_local_id(struct request_sock *req, struct sock *sk,
+		    const struct sk_buff *skb);
 =

 static inline struct mptcp_ext *mptcp_get_ext(struct sk_buff *skb)
 {
-- =

2.17.2


--===============8698770454063551080==--
