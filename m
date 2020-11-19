Content-Type: multipart/mixed; boundary="===============2333325920765882654=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 06/10] mptcp: change add_addr_signal type
Date: Thu, 19 Nov 2020 11:45:59 -0800
Message-ID: <20201119194603.103158-7-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20201119194603.103158-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 6845

--===============2333325920765882654==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Geliang Tang <geliangtang(a)gmail.com>

This patch changed the 'add_addr_signal' type from bool to char, so that
we could encode the addr type there.

Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
Acked-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/pm.c       | 15 +++++++++------
 net/mptcp/protocol.h | 15 ++++++++++++---
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index f9c88e2abb8e..c2c12f02a263 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -16,11 +16,15 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
 			   bool echo)
 {
+	u8 add_addr =3D READ_ONCE(msk->pm.add_addr_signal);
+
 	pr_debug("msk=3D%p, local_id=3D%d", msk, addr->id);
 =

 	msk->pm.local =3D *addr;
-	WRITE_ONCE(msk->pm.add_addr_echo, echo);
-	WRITE_ONCE(msk->pm.add_addr_signal, true);
+	add_addr |=3D BIT(MPTCP_ADD_ADDR_SIGNAL);
+	if (echo)
+		add_addr |=3D BIT(MPTCP_ADD_ADDR_ECHO);
+	WRITE_ONCE(msk->pm.add_addr_signal, add_addr);
 	return 0;
 }
 =

@@ -182,13 +186,13 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk,=
 unsigned int remaining,
 	if (!mptcp_pm_should_add_signal(msk))
 		goto out_unlock;
 =

-	*echo =3D READ_ONCE(msk->pm.add_addr_echo);
+	*echo =3D mptcp_pm_should_add_signal_echo(msk);
 =

 	if (remaining < mptcp_add_addr_len(msk->pm.local.family, *echo))
 		goto out_unlock;
 =

 	*saddr =3D msk->pm.local;
-	WRITE_ONCE(msk->pm.add_addr_signal, false);
+	WRITE_ONCE(msk->pm.add_addr_signal, 0);
 	ret =3D true;
 =

 out_unlock:
@@ -232,11 +236,10 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 	msk->pm.subflows =3D 0;
 	msk->pm.rm_id =3D 0;
 	WRITE_ONCE(msk->pm.work_pending, false);
-	WRITE_ONCE(msk->pm.add_addr_signal, false);
+	WRITE_ONCE(msk->pm.add_addr_signal, 0);
 	WRITE_ONCE(msk->pm.rm_addr_signal, false);
 	WRITE_ONCE(msk->pm.accept_addr, false);
 	WRITE_ONCE(msk->pm.accept_subflow, false);
-	WRITE_ONCE(msk->pm.add_addr_echo, false);
 	msk->pm.status =3D 0;
 =

 	spin_lock_init(&msk->pm.lock);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7affaf0b1941..a62ffae621c2 100644
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
@@ -516,7 +520,12 @@ int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8=
 local_id);
 =

 static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
 {
-	return READ_ONCE(msk->pm.add_addr_signal);
+	return READ_ONCE(msk->pm.add_addr_signal) & BIT(MPTCP_ADD_ADDR_SIGNAL);
+}
+
+static inline bool mptcp_pm_should_add_signal_echo(struct mptcp_sock *msk)
+{
+	return READ_ONCE(msk->pm.add_addr_signal) & BIT(MPTCP_ADD_ADDR_ECHO);
 }
 =

 static inline bool mptcp_pm_should_rm_signal(struct mptcp_sock *msk)
-- =

2.29.2

--===============2333325920765882654==--
