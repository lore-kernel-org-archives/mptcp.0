Content-Type: multipart/mixed; boundary="===============4068735639271063523=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v4 mptcp-next 4/9] mptcp: use rm_ids_rx array
 in mptcp_pm_data
Date: Fri, 05 Feb 2021 22:24:28 +0800
Message-ID: <242379f38b7038fc14cd0397449bd782237639af.1612534634.git.geliangtang@gmail.com>
In-Reply-To: 6aa788764dc5d769523835ebdec053c8ee391eec.1612534634.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7641

--===============4068735639271063523==
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
index 67be36df042c..8d7551a871ce 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -232,7 +232,7 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, =
u8 rm_ids[])
 =

 	spin_lock_bh(&pm->lock);
 	mptcp_pm_schedule_work(msk, MPTCP_PM_RM_ADDR_RECEIVED);
-	pm->rm_id =3D rm_ids[0];
+	memcpy(pm->rm_ids_rx, rm_ids, MPTCP_RM_IDS_MAX);
 	spin_unlock_bh(&pm->lock);
 }
 =

@@ -309,6 +309,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 	msk->pm.local_addr_used =3D 0;
 	msk->pm.subflows =3D 0;
 	memset(msk->pm.rm_ids_tx, MAX_ADDR_ID, MPTCP_RM_IDS_MAX);
+	memset(msk->pm.rm_ids_rx, MAX_ADDR_ID, MPTCP_RM_IDS_MAX);
 	WRITE_ONCE(msk->pm.work_pending, false);
 	WRITE_ONCE(msk->pm.addr_signal, 0);
 	WRITE_ONCE(msk->pm.accept_addr, false);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 52ee579a176c..dba9e9d4385b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -208,6 +208,7 @@ struct mptcp_pm_data {
 	u8		subflows;
 	u8		status;
 	u8		rm_ids_tx[MPTCP_RM_IDS_MAX];
+	u8		rm_ids_rx[MPTCP_RM_IDS_MAX];
 	u8		rm_id;
 };
 =

-- =

2.29.2

--===============4068735639271063523==--
