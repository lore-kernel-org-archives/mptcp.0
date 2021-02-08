Content-Type: multipart/mixed; boundary="===============7518863698690736919=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v5 mptcp-next 4/9] mptcp: add rm_list_rx in
 mptcp_pm_data
Date: Mon, 08 Feb 2021 22:54:12 +0800
Message-ID: <42b788d34d194418ca7fe4223bc5b0c534830783.1612795651.git.geliangtang@gmail.com>
In-Reply-To: e41d536d8c33632fb56a82eec5fbcd8e15283de7.1612795651.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7677

--===============7518863698690736919==
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
index c8b7295cb522..6ee6d3340ed5 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -232,7 +232,7 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, =
struct mptcp_rm_list rm_l
 =

 	spin_lock_bh(&pm->lock);
 	mptcp_pm_schedule_work(msk, MPTCP_PM_RM_ADDR_RECEIVED);
-	pm->rm_id =3D rm_list.ids[0];
+	pm->rm_list_rx =3D rm_list;
 	spin_unlock_bh(&pm->lock);
 }
 =

@@ -309,6 +309,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 	msk->pm.local_addr_used =3D 0;
 	msk->pm.subflows =3D 0;
 	msk->pm.rm_list_tx.nr =3D 0;
+	msk->pm.rm_list_rx.nr =3D 0;
 	WRITE_ONCE(msk->pm.work_pending, false);
 	WRITE_ONCE(msk->pm.addr_signal, 0);
 	WRITE_ONCE(msk->pm.accept_addr, false);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f24482242f9e..5a2b59d055e9 100644
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

2.29.2

--===============7518863698690736919==--
