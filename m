Content-Type: multipart/mixed; boundary="===============4328788957660903171=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v7 mptcp-next 04/11] mptcp: add rm_list_rx in
 mptcp_pm_data
Date: Wed, 10 Feb 2021 10:19:53 +0800
Message-ID: <b603a2a3bb01bf68b4caab3bbdc3d2e7c93917d2.1612922705.git.geliangtang@gmail.com>
In-Reply-To: 86af9b2958301bb4d0bb3e5d1013ba871c2d3fbd.1612922705.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7734

--===============4328788957660903171==
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
index 75e1651b5e9f..3d2eccd71c2f 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -217,7 +217,7 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, =
struct mptcp_rm_list rm_l
 =

 	spin_lock_bh(&pm->lock);
 	mptcp_pm_schedule_work(msk, MPTCP_PM_RM_ADDR_RECEIVED);
-	pm->rm_id =3D rm_list.ids[0];
+	pm->rm_list_rx =3D rm_list;
 	spin_unlock_bh(&pm->lock);
 }
 =

@@ -294,6 +294,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 	msk->pm.local_addr_used =3D 0;
 	msk->pm.subflows =3D 0;
 	msk->pm.rm_list_tx.nr =3D 0;
+	msk->pm.rm_list_rx.nr =3D 0;
 	WRITE_ONCE(msk->pm.work_pending, false);
 	WRITE_ONCE(msk->pm.addr_signal, 0);
 	WRITE_ONCE(msk->pm.accept_addr, false);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8783f1b428a5..8cfa59d378c0 100644
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

--===============4328788957660903171==--
