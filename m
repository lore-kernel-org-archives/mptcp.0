Content-Type: multipart/mixed; boundary="===============3029537176616063348=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v5 mptcp-next 1/3] mptcp: change
 add_addr_signal type
Date: Wed, 21 Oct 2020 15:19:51 +0800
Message-ID: <2755693ec1ea78bc07088977175a73ae3bf0493d.1603264085.git.geliangtang@gmail.com>
In-Reply-To: cover.1603264085.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6382

--===============3029537176616063348==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch changed the 'add_addr_signal' type from bool to char, so that
we could encode the addr type there.

Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm.c       | 15 +++++++++------
 net/mptcp/protocol.h | 10 +++++++---
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index f9c88e2abb8e..bc6619670d37 100644
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
+	*echo =3D READ_ONCE(msk->pm.add_addr_signal) & BIT(MPTCP_ADD_ADDR_ECHO);
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
index 24a361c684f4..0bcfbc71631b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -166,6 +166,11 @@ enum mptcp_pm_status {
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
@@ -173,13 +178,12 @@ struct mptcp_pm_data {
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
@@ -517,7 +521,7 @@ int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 =
local_id);
 =

 static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
 {
-	return READ_ONCE(msk->pm.add_addr_signal);
+	return READ_ONCE(msk->pm.add_addr_signal) & BIT(MPTCP_ADD_ADDR_SIGNAL);
 }
 =

 static inline bool mptcp_pm_should_rm_signal(struct mptcp_sock *msk)
-- =

2.26.2

--===============3029537176616063348==--
