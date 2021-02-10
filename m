Content-Type: multipart/mixed; boundary="===============8687814661797345134=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v7 mptcp-next 05/11] mptcp: remove multi
 addresses in PM
Date: Wed, 10 Feb 2021 10:19:54 +0800
Message-ID: <7e9fcb57aaf036889d8e77e437b1291011867373.1612922705.git.geliangtang@gmail.com>
In-Reply-To: b603a2a3bb01bf68b4caab3bbdc3d2e7c93917d2.1612922705.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7735

--===============8687814661797345134==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch dropped the member rm_id of struct mptcp_pm_data. Use
rm_list_rx in mptcp_pm_nl_rm_addr_received instead of using rm_id.

In mptcp_pm_nl_rm_addr_received, iterated each address id from
pm.rm_list_rx, then shut down and closed each address id's subsocket.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 36 ++++++++++++++++++++----------------
 net/mptcp/protocol.h   |  1 -
 2 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 7457826eda63..4dd0b45e22b3 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -575,36 +575,40 @@ static void mptcp_pm_nl_rm_addr_received(struct mptcp=
_sock *msk)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
 	struct sock *sk =3D (struct sock *)msk;
+	u8 i;
 =

-	pr_debug("address rm_id %d", msk->pm.rm_id);
+	pr_debug("address rm_list_nr %d", msk->pm.rm_list_rx.nr);
 =

 	msk_owned_by_me(msk);
 =

-	if (!msk->pm.rm_id)
+	if (!msk->pm.rm_list_rx.nr)
 		return;
 =

 	if (list_empty(&msk->conn_list))
 		return;
 =

-	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
-		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
-		int how =3D RCV_SHUTDOWN | SEND_SHUTDOWN;
+	for (i =3D 0; i < msk->pm.rm_list_rx.nr; i++) {
+		list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
+			struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+			int how =3D RCV_SHUTDOWN | SEND_SHUTDOWN;
 =

-		if (msk->pm.rm_id !=3D subflow->remote_id)
-			continue;
+			if (msk->pm.rm_list_rx.ids[i] !=3D subflow->remote_id)
+				continue;
 =

-		spin_unlock_bh(&msk->pm.lock);
-		mptcp_subflow_shutdown(sk, ssk, how);
-		mptcp_close_ssk(sk, ssk, subflow);
-		spin_lock_bh(&msk->pm.lock);
+			pr_debug(" -> address rm_list_ids[%d]=3D%u", i, msk->pm.rm_list_rx.ids[=
i]);
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
index 8cfa59d378c0..6c3a1a9dbe47 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -208,7 +208,6 @@ struct mptcp_pm_data {
 	u8		status;
 	struct mptcp_rm_list rm_list_tx;
 	struct mptcp_rm_list rm_list_rx;
-	u8		rm_id;
 };
 =

 struct mptcp_data_frag {
-- =

2.29.2

--===============8687814661797345134==--
