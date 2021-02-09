Content-Type: multipart/mixed; boundary="===============6714019580088007716=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v6 mptcp-next 4/9] mptcp: add rm_list_rx in
 mptcp_pm_data
Date: Tue, 09 Feb 2021 23:03:45 +0800
Message-ID: <3bd008531ad3fdef7d4bb17ec9101b4e74326e47.1612882689.git.geliangtang@gmail.com>
In-Reply-To: bcbdd1c200a3258752b73262e571db79dc59a36e.1612882689.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7718

--===============6714019580088007716==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added a new member rm_list_rx for struct mptcp_pm_data as an
list of the removing address ids on the incoming direction. Initialized
its nr field to zero in mptcp_pm_data_init.

In mptcp_pm_rm_addr_received, set it as the input rm_list.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm.c       | 3 ++-
 net/mptcp/protocol.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 578696a53328..0e24fb1a795a 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -235,7 +235,7 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, =
struct mptcp_rm_list rm_l
 =

 	spin_lock_bh(&pm->lock);
 	mptcp_pm_schedule_work(msk, MPTCP_PM_RM_ADDR_RECEIVED);
-	pm->rm_id =3D rm_list.ids[0];
+	pm->rm_list_rx =3D rm_list;
 	spin_unlock_bh(&pm->lock);
 }
 =

@@ -312,6 +312,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 	msk->pm.local_addr_used =3D 0;
 	msk->pm.subflows =3D 0;
 	msk->pm.rm_list_tx.nr =3D 0;
+	msk->pm.rm_list_rx.nr =3D 0;
 	WRITE_ONCE(msk->pm.work_pending, false);
 	WRITE_ONCE(msk->pm.addr_signal, 0);
 	WRITE_ONCE(msk->pm.accept_addr, false);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 76b97e672970..c0918fde9827 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -207,6 +207,7 @@ struct mptcp_pm_data {
 	u8		subflows;
 	u8		status;
 	struct mptcp_rm_list rm_list_tx;
+	struct mptcp_rm_list rm_list_rx;
 	u8		rm_id;
 };
 =

-- =

2.29.2

--===============6714019580088007716==--
