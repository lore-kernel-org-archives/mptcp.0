Content-Type: multipart/mixed; boundary="===============6751533158447714329=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v3 mptcp-next 2/4] mptcp: add the outgoing
 RM_ADDR support
Date: Wed, 29 Jul 2020 17:02:44 +0800
Message-ID: <8eb5862b1f33bcd766c2bffdc2a91fda1deb1f34.1596012283.git.geliangtang@gmail.com>
In-Reply-To: cover.1596012283.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5364

--===============6751533158447714329==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added a new signal named rm_addr_signal in PM. On outgoing path,
we called mptcp_pm_should_rm_signal to check if rm_addr_signal has been
set. If it has been, we sent out the RM_ADDR option.

Suggested-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/options.c  | 29 +++++++++++++++++++++++++++++
 net/mptcp/pm.c       | 24 ++++++++++++++++++++++++
 net/mptcp/protocol.h |  9 +++++++++
 3 files changed, 62 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index c0e2b233f2f1..f067980dc49a 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -615,6 +615,31 @@ static bool mptcp_established_options_add_addr(struct =
sock *sk,
 	return true;
 }
 =

+static bool mptcp_established_options_rm_addr(struct sock *sk,
+					      unsigned int *size,
+					      unsigned int remaining,
+					      struct mptcp_out_options *opts)
+{
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
+	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
+	u8 rm_id;
+
+	if (!mptcp_pm_should_rm_signal(msk) ||
+	    !(mptcp_pm_rm_addr_signal(msk, remaining, &rm_id)))
+		return false;
+
+	if (remaining < TCPOLEN_MPTCP_RM_ADDR_BASE)
+		return false;
+
+	*size =3D TCPOLEN_MPTCP_RM_ADDR_BASE;
+	opts->suboptions |=3D OPTION_MPTCP_RM_ADDR;
+	opts->rm_id =3D rm_id;
+
+	pr_debug("rm_id=3D%d", opts->rm_id);
+
+	return true;
+}
+
 bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 			       unsigned int *size, unsigned int remaining,
 			       struct mptcp_out_options *opts)
@@ -645,6 +670,10 @@ bool mptcp_established_options(struct sock *sk, struct=
 sk_buff *skb,
 		*size +=3D opt_size;
 		remaining -=3D opt_size;
 		ret =3D true;
+	} else if (mptcp_established_options_rm_addr(sk, &opt_size, remaining, op=
ts)) {
+		*size +=3D opt_size;
+		remaining -=3D opt_size;
+		ret =3D true;
 	}
 =

 	return ret;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index ce12b8b26ad2..91b74ca47fa1 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -174,6 +174,29 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, =
unsigned int remaining,
 	return ret;
 }
 =

+bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remainin=
g,
+			     u8 *rm_id)
+{
+	int ret =3D false;
+
+	spin_lock_bh(&msk->pm.lock);
+
+	/* double check after the lock is acquired */
+	if (!mptcp_pm_should_rm_signal(msk))
+		goto out_unlock;
+
+	if (remaining < TCPOLEN_MPTCP_RM_ADDR_BASE)
+		goto out_unlock;
+
+	*rm_id =3D msk->pm.rm_id;
+	WRITE_ONCE(msk->pm.rm_addr_signal, false);
+	ret =3D true;
+
+out_unlock:
+	spin_unlock_bh(&msk->pm.lock);
+	return ret;
+}
+
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 {
 	return mptcp_pm_nl_get_local_id(msk, skc);
@@ -187,6 +210,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 	msk->pm.subflows =3D 0;
 	WRITE_ONCE(msk->pm.work_pending, false);
 	WRITE_ONCE(msk->pm.add_addr_signal, false);
+	WRITE_ONCE(msk->pm.rm_addr_signal, false);
 	WRITE_ONCE(msk->pm.accept_addr, false);
 	WRITE_ONCE(msk->pm.accept_subflow, false);
 	msk->pm.status =3D 0;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 10bf4daecd92..b673e741f192 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -161,6 +161,7 @@ struct mptcp_pm_data {
 	spinlock_t	lock;		/*protects the whole PM data */
 =

 	bool		add_addr_signal;
+	bool		rm_addr_signal;
 	bool		server_side;
 	bool		work_pending;
 	bool		accept_addr;
@@ -174,6 +175,7 @@ struct mptcp_pm_data {
 	u8		local_addr_max;
 	u8		subflows_max;
 	u8		status;
+	u8		rm_id;
 };
 =

 struct mptcp_data_frag {
@@ -429,6 +431,11 @@ static inline bool mptcp_pm_should_add_signal(struct m=
ptcp_sock *msk)
 	return READ_ONCE(msk->pm.add_addr_signal);
 }
 =

+static inline bool mptcp_pm_should_rm_signal(struct mptcp_sock *msk)
+{
+	return READ_ONCE(msk->pm.rm_addr_signal);
+}
+
 static inline unsigned int mptcp_add_addr_len(int family)
 {
 	if (family =3D=3D AF_INET)
@@ -438,6 +445,8 @@ static inline unsigned int mptcp_add_addr_len(int famil=
y)
 =

 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaini=
ng,
 			      struct mptcp_addr_info *saddr);
+bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remainin=
g,
+			     u8 *rm_id);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 =

 void __init mptcp_pm_nl_init(void);
-- =

2.17.1

--===============6751533158447714329==--
