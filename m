Content-Type: multipart/mixed; boundary="===============4670913153265245895=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v8 mptcp-next 3/8] mptcp: implementing
 mptcp_pm_remove_subflow
Date: Mon, 24 Aug 2020 19:36:16 +0800
Message-ID: <28b149a285e6463b0aae95188c494d843a30b22e.1598267961.git.geliangtang@gmail.com>
In-Reply-To: cover.1598267961.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5608

--===============4670913153265245895==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Like mptcp_pm_rm_addr_received and the related functions, we implemented
the remove subflow logic.

We use mptcp_pm_remove_subflow to remove a local subflow, so change it's
argument from remote_id to local_id.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm.c       | 19 +++++++++++++++++--
 net/mptcp/protocol.c |  4 ++++
 net/mptcp/protocol.h |  4 +++-
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 57227ab816fd..5c6b087c68b8 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -31,9 +31,12 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, u8 loca=
l_id)
 	return 0;
 }
 =

-int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 remote_id)
+int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 local_id)
 {
-	return -ENOTSUPP;
+	pr_debug("%s msk=3D%p, local_id=3D%d", __func__, msk, local_id);
+
+	mptcp_pm_rm_subflow_received(msk, local_id);
+	return 0;
 }
 =

 /* path manager event handlers */
@@ -165,6 +168,18 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,=
 u8 rm_id)
 	spin_unlock_bh(&pm->lock);
 }
 =

+void mptcp_pm_rm_subflow_received(struct mptcp_sock *msk, u8 rm_id)
+{
+	struct mptcp_pm_data *pm =3D &msk->pm;
+
+	pr_debug("msk=3D%p local_id=3D%d", msk, rm_id);
+
+	spin_lock_bh(&pm->lock);
+	mptcp_pm_schedule_work(msk, MPTCP_PM_RM_SUBFLOW_RECEIVED);
+	pm->rm_id =3D rm_id;
+	spin_unlock_bh(&pm->lock);
+}
+
 /* path manager helpers */
 =

 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaini=
ng,
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index bd02c568c4b9..e8b84a693bf6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1695,6 +1695,10 @@ static void pm_work(struct mptcp_sock *msk)
 		pm->status &=3D ~BIT(MPTCP_PM_RM_ADDR_RECEIVED);
 		mptcp_pm_nl_rm_addr_received(msk);
 	}
+	if (pm->status & BIT(MPTCP_PM_RM_SUBFLOW_RECEIVED)) {
+		pm->status &=3D ~BIT(MPTCP_PM_RM_SUBFLOW_RECEIVED);
+		mptcp_pm_nl_rm_subflow_received(msk);
+	}
 	if (pm->status & BIT(MPTCP_PM_ESTABLISHED)) {
 		pm->status &=3D ~BIT(MPTCP_PM_ESTABLISHED);
 		mptcp_pm_nl_fully_established(msk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2849e1c8769b..a2d575901cd6 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -153,6 +153,7 @@ struct mptcp_addr_info {
 enum mptcp_pm_status {
 	MPTCP_PM_ADD_ADDR_RECEIVED,
 	MPTCP_PM_RM_ADDR_RECEIVED,
+	MPTCP_PM_RM_SUBFLOW_RECEIVED,
 	MPTCP_PM_ESTABLISHED,
 	MPTCP_PM_SUBFLOW_ESTABLISHED,
 };
@@ -441,11 +442,12 @@ void mptcp_pm_subflow_closed(struct mptcp_sock *msk, =
u8 id);
 void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr);
 void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, u8 rm_id);
+void mptcp_pm_rm_subflow_received(struct mptcp_sock *msk, u8 rm_id);
 =

 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr);
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, u8 local_id);
-int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 remote_id);
+int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 local_id);
 =

 static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
 {
-- =

2.17.1

--===============4670913153265245895==--
