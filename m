Content-Type: multipart/mixed; boundary="===============1765543576587934111=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 05/11] mptcp: remove multi addresses in PM
Date: Fri, 12 Mar 2021 17:16:15 -0800
Message-ID: <20210313011621.211661-6-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20210313011621.211661-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 8136

--===============1765543576587934111==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Geliang Tang <geliangtang(a)gmail.com>

This patch dropped the member rm_id of struct mptcp_pm_data. Use
rm_list_rx in mptcp_pm_nl_rm_addr_received instead of using rm_id.

In mptcp_pm_nl_rm_addr_received, iterated each address id from
pm.rm_list_rx, then shut down and closed each address id's subsocket.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/pm_netlink.c | 36 ++++++++++++++++++++----------------
 net/mptcp/protocol.h   |  1 -
 2 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 1eb9d0139267..e8135702af39 100644
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
index 82a63abf2c7e..5324fbe40528 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -209,7 +209,6 @@ struct mptcp_pm_data {
 	u8		status;
 	struct mptcp_rm_list rm_list_tx;
 	struct mptcp_rm_list rm_list_rx;
-	u8		rm_id;
 };
 =

 struct mptcp_data_frag {
-- =

2.30.2

--===============1765543576587934111==--
