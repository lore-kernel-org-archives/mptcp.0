Content-Type: multipart/mixed; boundary="===============4653011804925097208=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v4 mptcp-next 5/9] mptcp: remove multi
 addresses in PM
Date: Fri, 05 Feb 2021 22:24:29 +0800
Message-ID: <3cf42c12a72c462884a26d6c5fe6721c66070fc7.1612534634.git.geliangtang@gmail.com>
In-Reply-To: 242379f38b7038fc14cd0397449bd782237639af.1612534634.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7642

--===============4653011804925097208==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch dropped the member rm_id of struct mptcp_pm_data. Use
rm_ids_rx in mptcp_pm_nl_rm_addr_received instead of using rm_id.

In mptcp_pm_nl_rm_addr_received, iterated each address id from
pm.rm_ids_rx, then shut down and closed each address id's subsocket.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 38 ++++++++++++++++++++++----------------
 net/mptcp/protocol.h   |  1 -
 2 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index f26453b3cb01..c883b010c4c6 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -574,36 +574,42 @@ static void mptcp_pm_nl_rm_addr_received(struct mptcp=
_sock *msk)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
 	struct sock *sk =3D (struct sock *)msk;
+	u8 i, nr;
 =

-	pr_debug("address rm_id %d", msk->pm.rm_id);
+	nr =3D mptcp_get_rm_ids_nr(msk->pm.rm_ids_rx);
+
+	pr_debug("address rm_ids_nr %d", nr);
 =

 	msk_owned_by_me(msk);
 =

-	if (!msk->pm.rm_id)
+	if (!nr)
 		return;
 =

 	if (list_empty(&msk->conn_list))
 		return;
 =

-	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
-		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
-		int how =3D RCV_SHUTDOWN | SEND_SHUTDOWN;
+	for (i =3D 0; i < MPTCP_RM_IDS_MAX && msk->pm.rm_ids_rx[i] !=3D MAX_ADDR_=
ID; i++) {
+		list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
+			struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+			int how =3D RCV_SHUTDOWN | SEND_SHUTDOWN;
 =

-		if (msk->pm.rm_id !=3D subflow->remote_id)
-			continue;
+			if (msk->pm.rm_ids_rx[i] !=3D subflow->remote_id)
+				continue;
 =

-		spin_unlock_bh(&msk->pm.lock);
-		mptcp_subflow_shutdown(sk, ssk, how);
-		mptcp_close_ssk(sk, ssk, subflow);
-		spin_lock_bh(&msk->pm.lock);
+			pr_debug(" -> address rm_ids[%d]=3D%u", i, msk->pm.rm_ids_rx[i]);
+			spin_unlock_bh(&msk->pm.lock);
+			mptcp_subflow_shutdown(sk, ssk, how);
+			mptcp_close_ssk(sk, ssk, subflow);
+			spin_lock_bh(&msk->pm.lock);
 =

-		msk->pm.add_addr_accepted--;
-		msk->pm.subflows--;
-		WRITE_ONCE(msk->pm.accept_addr, true);
+			msk->pm.add_addr_accepted--;
+			msk->pm.subflows--;
+			WRITE_ONCE(msk->pm.accept_addr, true);
 =

-		__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMADDR);
+			__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMADDR);
 =

-		break;
+			break;
+		}
 	}
 }
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index dba9e9d4385b..d4209ee9f913 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -209,7 +209,6 @@ struct mptcp_pm_data {
 	u8		status;
 	u8		rm_ids_tx[MPTCP_RM_IDS_MAX];
 	u8		rm_ids_rx[MPTCP_RM_IDS_MAX];
-	u8		rm_id;
 };
 =

 struct mptcp_data_frag {
-- =

2.29.2

--===============4653011804925097208==--
