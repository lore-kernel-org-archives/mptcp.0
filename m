Content-Type: multipart/mixed; boundary="===============5567021039665252582=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 04/11] mptcp: add rm_list_rx in mptcp_pm_data
Date: Fri, 12 Mar 2021 17:16:14 -0800
Message-ID: <20210313011621.211661-5-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20210313011621.211661-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 8132

--===============5567021039665252582==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Geliang Tang <geliangtang(a)gmail.com>

This patch added a new member rm_list_rx for struct mptcp_pm_data as an
list of the removing address ids on the incoming direction. Initialized
its nr field to zero in mptcp_pm_data_init.

In mptcp_pm_rm_addr_received, set it as the input rm_list.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/pm.c       | 3 ++-
 net/mptcp/protocol.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 7553f82076ca..a47436205d88 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -218,7 +218,7 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 =

 	spin_lock_bh(&pm->lock);
 	mptcp_pm_schedule_work(msk, MPTCP_PM_RM_ADDR_RECEIVED);
-	pm->rm_id =3D rm_list->ids[0];
+	pm->rm_list_rx =3D *rm_list;
 	spin_unlock_bh(&pm->lock);
 }
 =

@@ -300,6 +300,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 	msk->pm.local_addr_used =3D 0;
 	msk->pm.subflows =3D 0;
 	msk->pm.rm_list_tx.nr =3D 0;
+	msk->pm.rm_list_rx.nr =3D 0;
 	WRITE_ONCE(msk->pm.work_pending, false);
 	WRITE_ONCE(msk->pm.addr_signal, 0);
 	WRITE_ONCE(msk->pm.accept_addr, false);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d7daf7e0d5d2..82a63abf2c7e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -208,6 +208,7 @@ struct mptcp_pm_data {
 	u8		subflows;
 	u8		status;
 	struct mptcp_rm_list rm_list_tx;
+	struct mptcp_rm_list rm_list_rx;
 	u8		rm_id;
 };
 =

-- =

2.30.2

--===============5567021039665252582==--
