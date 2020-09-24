Content-Type: multipart/mixed; boundary="===============5650164492538361746=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH net-next 01/16] mptcp: rename addr_signal and
 the related functions
Date: Thu, 24 Sep 2020 08:29:47 +0800
Message-ID: <bfecdd638bb74a02de1c3f1c84239911e304fcc3.1600853093.git.geliangtang@gmail.com>
In-Reply-To: cover.1600853093.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5997

--===============5650164492538361746==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch renamed addr_signal and the related functions with the explicit
word "add".

Suggested-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/options.c  | 14 +++++++-------
 net/mptcp/pm.c       | 12 ++++++------
 net/mptcp/protocol.h | 10 +++++-----
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 7fa822b55c34..ee0cb0546324 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -571,18 +571,18 @@ static u64 add_addr6_generate_hmac(u64 key1, u64 key2=
, u8 addr_id,
 }
 #endif
 =

-static bool mptcp_established_options_addr(struct sock *sk,
-					   unsigned int *size,
-					   unsigned int remaining,
-					   struct mptcp_out_options *opts)
+static bool mptcp_established_options_add_addr(struct sock *sk,
+					       unsigned int *size,
+					       unsigned int remaining,
+					       struct mptcp_out_options *opts)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
 	struct mptcp_addr_info saddr;
 	int len;
 =

-	if (!mptcp_pm_should_signal(msk) ||
-	    !(mptcp_pm_addr_signal(msk, remaining, &saddr)))
+	if (!mptcp_pm_should_add_signal(msk) ||
+	    !(mptcp_pm_add_addr_signal(msk, remaining, &saddr)))
 		return false;
 =

 	len =3D mptcp_add_addr_len(saddr.family);
@@ -640,7 +640,7 @@ bool mptcp_established_options(struct sock *sk, struct =
sk_buff *skb,
 =

 	*size +=3D opt_size;
 	remaining -=3D opt_size;
-	if (mptcp_established_options_addr(sk, &opt_size, remaining, opts)) {
+	if (mptcp_established_options_add_addr(sk, &opt_size, remaining, opts)) {
 		*size +=3D opt_size;
 		remaining -=3D opt_size;
 		ret =3D true;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index a8ad20559aaa..ce12b8b26ad2 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -18,7 +18,7 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 	pr_debug("msk=3D%p, local_id=3D%d", msk, addr->id);
 =

 	msk->pm.local =3D *addr;
-	WRITE_ONCE(msk->pm.addr_signal, true);
+	WRITE_ONCE(msk->pm.add_addr_signal, true);
 	return 0;
 }
 =

@@ -151,22 +151,22 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *ms=
k,
 =

 /* path manager helpers */
 =

-bool mptcp_pm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
-			  struct mptcp_addr_info *saddr)
+bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaini=
ng,
+			      struct mptcp_addr_info *saddr)
 {
 	int ret =3D false;
 =

 	spin_lock_bh(&msk->pm.lock);
 =

 	/* double check after the lock is acquired */
-	if (!mptcp_pm_should_signal(msk))
+	if (!mptcp_pm_should_add_signal(msk))
 		goto out_unlock;
 =

 	if (remaining < mptcp_add_addr_len(msk->pm.local.family))
 		goto out_unlock;
 =

 	*saddr =3D msk->pm.local;
-	WRITE_ONCE(msk->pm.addr_signal, false);
+	WRITE_ONCE(msk->pm.add_addr_signal, false);
 	ret =3D true;
 =

 out_unlock:
@@ -186,7 +186,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 	msk->pm.local_addr_used =3D 0;
 	msk->pm.subflows =3D 0;
 	WRITE_ONCE(msk->pm.work_pending, false);
-	WRITE_ONCE(msk->pm.addr_signal, false);
+	WRITE_ONCE(msk->pm.add_addr_signal, false);
 	WRITE_ONCE(msk->pm.accept_addr, false);
 	WRITE_ONCE(msk->pm.accept_subflow, false);
 	msk->pm.status =3D 0;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 493bd2c13bc6..91adc9a19757 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -162,7 +162,7 @@ struct mptcp_pm_data {
 =

 	spinlock_t	lock;		/*protects the whole PM data */
 =

-	bool		addr_signal;
+	bool		add_addr_signal;
 	bool		server_side;
 	bool		work_pending;
 	bool		accept_addr;
@@ -438,9 +438,9 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, u8 local_id);
 int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 remote_id);
 =

-static inline bool mptcp_pm_should_signal(struct mptcp_sock *msk)
+static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
 {
-	return READ_ONCE(msk->pm.addr_signal);
+	return READ_ONCE(msk->pm.add_addr_signal);
 }
 =

 static inline unsigned int mptcp_add_addr_len(int family)
@@ -450,8 +450,8 @@ static inline unsigned int mptcp_add_addr_len(int famil=
y)
 	return TCPOLEN_MPTCP_ADD_ADDR6;
 }
 =

-bool mptcp_pm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
-			  struct mptcp_addr_info *saddr);
+bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaini=
ng,
+			      struct mptcp_addr_info *saddr);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 =

 void __init mptcp_pm_nl_init(void);
-- =

2.17.1

--===============5650164492538361746==--
