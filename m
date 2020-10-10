Content-Type: multipart/mixed; boundary="===============0508955699237986714=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v4 mptcp-next 1/3] mptcp: change
 add_addr_signal type
Date: Sat, 10 Oct 2020 18:07:23 +0800
Message-ID: <4e6e17e8ca4879f101c7e649031fe1b174ee4c1d.1602323760.git.geliangtang@gmail.com>
In-Reply-To: cover.1602323760.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6279

--===============0508955699237986714==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch changed the 'add_addr_signal' type from bool to char, so that
we could encode the addr type there.

Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm.c       | 12 ++++++------
 net/mptcp/protocol.h | 10 +++++++---
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index f9c88e2abb8e..5f453db36e54 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -19,8 +19,9 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 	pr_debug("msk=3D%p, local_id=3D%d", msk, addr->id);
 =

 	msk->pm.local =3D *addr;
-	WRITE_ONCE(msk->pm.add_addr_echo, echo);
-	WRITE_ONCE(msk->pm.add_addr_signal, true);
+	msk->pm.add_addr_signal |=3D BIT(MPTCP_ADD_ADDR_SIGNAL);
+	if (echo)
+		msk->pm.add_addr_signal |=3D BIT(MPTCP_ADD_ADDR_ECHO);
 	return 0;
 }
 =

@@ -182,13 +183,13 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk,=
 unsigned int remaining,
 	if (!mptcp_pm_should_add_signal(msk))
 		goto out_unlock;
 =

-	*echo =3D READ_ONCE(msk->pm.add_addr_echo);
+	*echo =3D msk->pm.add_addr_signal & BIT(MPTCP_ADD_ADDR_ECHO);
 =

 	if (remaining < mptcp_add_addr_len(msk->pm.local.family, *echo))
 		goto out_unlock;
 =

 	*saddr =3D msk->pm.local;
-	WRITE_ONCE(msk->pm.add_addr_signal, false);
+	msk->pm.add_addr_signal =3D 0;
 	ret =3D true;
 =

 out_unlock:
@@ -232,11 +233,10 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 	msk->pm.subflows =3D 0;
 	msk->pm.rm_id =3D 0;
 	WRITE_ONCE(msk->pm.work_pending, false);
-	WRITE_ONCE(msk->pm.add_addr_signal, false);
+	msk->pm.add_addr_signal =3D 0;
 	WRITE_ONCE(msk->pm.rm_addr_signal, false);
 	WRITE_ONCE(msk->pm.accept_addr, false);
 	WRITE_ONCE(msk->pm.accept_subflow, false);
-	WRITE_ONCE(msk->pm.add_addr_echo, false);
 	msk->pm.status =3D 0;
 =

 	spin_lock_init(&msk->pm.lock);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 746413ab4f18..9eb2b1bff7f5 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -165,6 +165,11 @@ enum mptcp_pm_status {
 	MPTCP_PM_SUBFLOW_ESTABLISHED,
 };
 =

+enum mptcp_add_addr_status {
+	MPTCP_ADD_ADDR_SIGNAL,
+	MPTCP_ADD_ADDR_ECHO,
+};
+
 struct mptcp_pm_data {
 	struct mptcp_addr_info local;
 	struct mptcp_addr_info remote;
@@ -172,13 +177,12 @@ struct mptcp_pm_data {
 =

 	spinlock_t	lock;		/*protects the whole PM data */
 =

-	bool		add_addr_signal;
+	u8		add_addr_signal;
 	bool		rm_addr_signal;
 	bool		server_side;
 	bool		work_pending;
 	bool		accept_addr;
 	bool		accept_subflow;
-	bool		add_addr_echo;
 	u8		add_addr_signaled;
 	u8		add_addr_accepted;
 	u8		local_addr_used;
@@ -507,7 +511,7 @@ int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 =
local_id);
 =

 static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
 {
-	return READ_ONCE(msk->pm.add_addr_signal);
+	return msk->pm.add_addr_signal & BIT(MPTCP_ADD_ADDR_SIGNAL);
 }
 =

 static inline bool mptcp_pm_should_rm_signal(struct mptcp_sock *msk)
-- =

2.26.2

--===============0508955699237986714==--
