Content-Type: multipart/mixed; boundary="===============2377503043097197760=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v3 mptcp-next 4/9] mptcp: use rm_ids_rx array
 in mptcp_pm_data
Date: Tue, 02 Feb 2021 15:20:55 +0800
Message-ID: <3931d93a110faab2f0450e3a1fa6c0b11b6c3e05.1612250255.git.geliangtang@gmail.com>
In-Reply-To: 098e4b48d30601d1714b36f6839f5b7d5ff0a4c6.1612250255.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7583

--===============2377503043097197760==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added a new member rm_ids_rx for struct mptcp_pm_data as an
array of the removing address ids on the incoming direction. Used memset
to initialize it, and memcpy to copy it.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm.c       | 3 ++-
 net/mptcp/protocol.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 88bc35303f73..265fbbedd099 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -217,7 +217,7 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, =
u8 rm_ids[])
 =

 	spin_lock_bh(&pm->lock);
 	mptcp_pm_schedule_work(msk, MPTCP_PM_RM_ADDR_RECEIVED);
-	pm->rm_id =3D rm_ids[0];
+	memcpy(pm->rm_ids_rx, rm_ids, MPTCP_RM_IDS_MAX);
 	spin_unlock_bh(&pm->lock);
 }
 =

@@ -294,6 +294,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 	msk->pm.local_addr_used =3D 0;
 	msk->pm.subflows =3D 0;
 	memset(msk->pm.rm_ids_tx, 0, MPTCP_RM_IDS_MAX);
+	memset(msk->pm.rm_ids_rx, 0, MPTCP_RM_IDS_MAX);
 	WRITE_ONCE(msk->pm.work_pending, false);
 	WRITE_ONCE(msk->pm.addr_signal, 0);
 	WRITE_ONCE(msk->pm.accept_addr, false);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index aeb589384824..6d103e67bca7 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -206,6 +206,7 @@ struct mptcp_pm_data {
 	u8		subflows;
 	u8		status;
 	u8		rm_ids_tx[MPTCP_RM_IDS_MAX];
+	u8		rm_ids_rx[MPTCP_RM_IDS_MAX];
 	u8		rm_id;
 };
 =

-- =

2.29.2

--===============2377503043097197760==--
