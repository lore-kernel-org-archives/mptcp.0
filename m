Content-Type: multipart/mixed; boundary="===============0741427472447997564=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v7 mptcp-next 1/4] mptcp: send out ADD_ADDR
 with echo flag
Date: Fri, 28 Aug 2020 15:16:01 +0800
Message-ID: <4bf1636a362ac487d5bd2abae78e78b9f91294f1.1598598749.git.geliangtang@gmail.com>
In-Reply-To: cover.1598598749.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5654

--===============0741427472447997564==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When the ADD_ADDR suboption has been received, we need to send out the same
ADD_ADDR suboption with echo-flag=3D1, and no HMAC.

Suggested-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/options.c    | 27 ++++++++++++++++-----------
 net/mptcp/pm.c         | 18 +++++++++---------
 net/mptcp/pm_netlink.c |  4 +++-
 net/mptcp/protocol.h   |  6 ++++--
 4 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index a52a05effac9..a41996e6c6d7 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -242,7 +242,7 @@ static void mptcp_parse_option(const struct sk_buff *sk=
b,
 		mp_opt->add_addr =3D 1;
 		mp_opt->port =3D 0;
 		mp_opt->addr_id =3D *ptr++;
-		pr_debug("ADD_ADDR: id=3D%d", mp_opt->addr_id);
+		pr_debug("ADD_ADDR: id=3D%d, echo=3D%d", mp_opt->addr_id, mp_opt->echo);
 		if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_4) {
 			memcpy((u8 *)&mp_opt->addr.s_addr, (u8 *)ptr, 4);
 			ptr +=3D 4;
@@ -579,10 +579,11 @@ static bool mptcp_established_options_add_addr(struct=
 sock *sk,
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
 	struct mptcp_addr_info saddr;
+	bool echo;
 	int len;
 =

 	if (!mptcp_pm_should_add_signal(msk) ||
-	    !(mptcp_pm_add_addr_signal(msk, remaining, &saddr)))
+	    !(mptcp_pm_add_addr_signal(msk, remaining, &saddr, &echo)))
 		return false;
 =

 	len =3D mptcp_add_addr_len(saddr.family);
@@ -594,22 +595,26 @@ static bool mptcp_established_options_add_addr(struct=
 sock *sk,
 	if (saddr.family =3D=3D AF_INET) {
 		opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
 		opts->addr =3D saddr.addr;
-		opts->ahmac =3D add_addr_generate_hmac(msk->local_key,
-						     msk->remote_key,
-						     opts->addr_id,
-						     &opts->addr);
+		if (!echo) {
+			opts->ahmac =3D add_addr_generate_hmac(msk->local_key,
+							     msk->remote_key,
+							     opts->addr_id,
+							     &opts->addr);
+		}
 	}
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	else if (saddr.family =3D=3D AF_INET6) {
 		opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR6;
 		opts->addr6 =3D saddr.addr6;
-		opts->ahmac =3D add_addr6_generate_hmac(msk->local_key,
-						      msk->remote_key,
-						      opts->addr_id,
-						      &opts->addr6);
+		if (!echo) {
+			opts->ahmac =3D add_addr6_generate_hmac(msk->local_key,
+							      msk->remote_key,
+							      opts->addr_id,
+							      &opts->addr6);
+		}
 	}
 #endif
-	pr_debug("addr_id=3D%d, ahmac=3D%llu", opts->addr_id, opts->ahmac);
+	pr_debug("addr_id=3D%d, ahmac=3D%llu, echo=3D%d", opts->addr_id, opts->ah=
mac, echo);
 =

 	return true;
 }
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 558462d87eb3..39a76620d0a5 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -13,11 +13,13 @@
 /* path manager command handlers */
 =

 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
-			   const struct mptcp_addr_info *addr)
+			   const struct mptcp_addr_info *addr,
+			   bool echo)
 {
 	pr_debug("msk=3D%p, local_id=3D%d", msk, addr->id);
 =

 	msk->pm.local =3D *addr;
+	WRITE_ONCE(msk->pm.add_addr_echo, echo);
 	WRITE_ONCE(msk->pm.add_addr_signal, true);
 	return 0;
 }
@@ -135,15 +137,11 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *ms=
k,
 	pr_debug("msk=3D%p remote_id=3D%d accept=3D%d", msk, addr->id,
 		 READ_ONCE(pm->accept_addr));
 =

-	/* avoid acquiring the lock if there is no room for fouther addresses */
-	if (!READ_ONCE(pm->accept_addr))
-		return;
-
 	spin_lock_bh(&pm->lock);
 =

-	/* be sure there is something to signal re-checking under PM lock */
-	if (READ_ONCE(pm->accept_addr) &&
-	    mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED))
+	if (!READ_ONCE(pm->accept_addr))
+		mptcp_pm_announce_addr(msk, addr, true);
+	else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED))
 		pm->remote =3D *addr;
 =

 	spin_unlock_bh(&pm->lock);
@@ -164,7 +162,7 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, =
u8 rm_id)
 /* path manager helpers */
 =

 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaini=
ng,
-			      struct mptcp_addr_info *saddr)
+			      struct mptcp_addr_info *saddr, bool *echo)
 {
 	int ret =3D false;
 =

@@ -178,6 +176,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, u=
nsigned int remaining,
 		goto out_unlock;
 =

 	*saddr =3D msk->pm.local;
+	*echo =3D READ_ONCE(msk->pm.add_addr_echo);
 	WRITE_ONCE(msk->pm.add_addr_signal, false);
 	ret =3D true;
 =

@@ -226,6 +225,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 	WRITE_ONCE(msk->pm.rm_addr_signal, false);
 	WRITE_ONCE(msk->pm.accept_addr, false);
 	WRITE_ONCE(msk->pm.accept_subflow, false);
+	WRITE_ONCE(msk->pm.add_addr_echo, false);
 	msk->pm.status =3D 0;
 =

 	spin_lock_init(&msk->pm.lock);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ad7232a1d9f1..54fd9db6fb7a 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -188,7 +188,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(stru=
ct mptcp_sock *msk)
 =

 		if (local) {
 			msk->pm.add_addr_signaled++;
-			mptcp_pm_announce_addr(msk, &local->addr);
+			mptcp_pm_announce_addr(msk, &local->addr, false);
 		} else {
 			/* pick failed, avoid fourther attempts later */
 			msk->pm.local_addr_used =3D msk->pm.add_addr_signal_max;
@@ -256,6 +256,8 @@ void mptcp_pm_nl_add_addr_received(struct mptcp_sock *m=
sk)
 	spin_unlock_bh(&msk->pm.lock);
 	__mptcp_subflow_connect((struct sock *)msk, &local, &remote);
 	spin_lock_bh(&msk->pm.lock);
+
+	mptcp_pm_announce_addr(msk, &remote, true);
 }
 =

 void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4b8a5308aeed..3718d6c287fe 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -169,6 +169,7 @@ struct mptcp_pm_data {
 	bool		work_pending;
 	bool		accept_addr;
 	bool		accept_subflow;
+	bool		add_addr_echo;
 	u8		add_addr_signaled;
 	u8		add_addr_accepted;
 	u8		local_addr_used;
@@ -443,7 +444,8 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, u8 rm_id);
 =

 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
-			   const struct mptcp_addr_info *addr);
+			   const struct mptcp_addr_info *addr,
+			   bool echo);
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, u8 local_id);
 int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 remote_id);
 =

@@ -465,7 +467,7 @@ static inline unsigned int mptcp_add_addr_len(int famil=
y)
 }
 =

 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaini=
ng,
-			      struct mptcp_addr_info *saddr);
+			      struct mptcp_addr_info *saddr, bool *echo);
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remainin=
g,
 			     u8 *rm_id);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
-- =

2.17.1

--===============0741427472447997564==--
