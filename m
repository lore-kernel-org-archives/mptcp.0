Content-Type: multipart/mixed; boundary="===============3556328062506713037=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 4/8] mptcp: add removing multi addrs
 support in netlink
Date: Fri, 29 Jan 2021 18:26:48 +0800
Message-ID: <afb328bb77ea380d4171500cc0e4d3dc7702f2ee.1611914854.git.geliangtang@gmail.com>
In-Reply-To: 349ecc242d794e1c9bdfc65f958caeab33af238c.1611914854.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7527

--===============3556328062506713037==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In mptcp_pm_nl_rm_addr_received and mptcp_pm_nl_rm_subflow_received,
used mptcp_for_each_id to iterate out each addree id from the received
ids map. Then shut down and closed each addree id's subsocket.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 68 +++++++++++++++++++++++-------------------
 net/mptcp/protocol.h   |  2 +-
 2 files changed, 39 insertions(+), 31 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index aa0c471b82c4..d6da874e6179 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -574,6 +574,7 @@ static void mptcp_pm_nl_rm_addr_received(struct mptcp_s=
ock *msk)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
 	struct sock *sk =3D (struct sock *)msk;
+	u8 *ptr, id, nr;
 =

 	pr_debug("address rm_ids %llu", msk->pm.rm_ids);
 =

@@ -585,25 +586,28 @@ static void mptcp_pm_nl_rm_addr_received(struct mptcp=
_sock *msk)
 	if (list_empty(&msk->conn_list))
 		return;
 =

-	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
-		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
-		int how =3D RCV_SHUTDOWN | SEND_SHUTDOWN;
+	mptcp_for_each_id(msk->pm.rm_ids, nr, ptr, id) {
+		list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
+			struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+			int how =3D RCV_SHUTDOWN | SEND_SHUTDOWN;
 =

-		if (msk->pm.rm_ids !=3D subflow->remote_id)
-			continue;
+			if (id !=3D subflow->remote_id)
+				continue;
 =

-		spin_unlock_bh(&msk->pm.lock);
-		mptcp_subflow_shutdown(sk, ssk, how);
-		mptcp_close_ssk(sk, ssk, subflow);
-		spin_lock_bh(&msk->pm.lock);
+			pr_debug("address rm_id=3D%u", id);
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

@@ -640,39 +644,43 @@ void mptcp_pm_nl_work(struct mptcp_sock *msk)
 	spin_unlock_bh(&msk->pm.lock);
 }
 =

-void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk, u8 rm_id)
+void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk, u64 rm_ids)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
 	struct sock *sk =3D (struct sock *)msk;
+	u8 *ptr, id, nr;
 =

-	pr_debug("subflow rm_id %d", rm_id);
+	pr_debug("subflow rm_ids %llu", rm_ids);
 =

 	msk_owned_by_me(msk);
 =

-	if (!rm_id)
+	if (!rm_ids)
 		return;
 =

 	if (list_empty(&msk->conn_list))
 		return;
 =

-	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
-		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
-		int how =3D RCV_SHUTDOWN | SEND_SHUTDOWN;
+	mptcp_for_each_id(rm_ids, nr, ptr, id) {
+		list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
+			struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+			int how =3D RCV_SHUTDOWN | SEND_SHUTDOWN;
 =

-		if (rm_id !=3D subflow->local_id)
-			continue;
+			if (id !=3D subflow->local_id)
+				continue;
 =

-		spin_unlock_bh(&msk->pm.lock);
-		mptcp_subflow_shutdown(sk, ssk, how);
-		mptcp_close_ssk(sk, ssk, subflow);
-		spin_lock_bh(&msk->pm.lock);
+			pr_debug("subflow rm_id=3D%u", id);
+			spin_unlock_bh(&msk->pm.lock);
+			mptcp_subflow_shutdown(sk, ssk, how);
+			mptcp_close_ssk(sk, ssk, subflow);
+			spin_lock_bh(&msk->pm.lock);
 =

-		msk->pm.local_addr_used--;
-		msk->pm.subflows--;
+			msk->pm.local_addr_used--;
+			msk->pm.subflows--;
 =

-		__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMSUBFLOW);
+			__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMSUBFLOW);
 =

-		break;
+			break;
+		}
 	}
 }
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c5a3950a25e3..02bb9c882041 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -724,7 +724,7 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struc=
t sock_common *skc);
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_data_init(struct mptcp_sock *msk);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
-void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk, u8 rm_id);
+void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk, u64 rm_ids);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *s=
kc);
 unsigned int mptcp_pm_get_add_addr_signal_max(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_accept_max(struct mptcp_sock *msk);
-- =

2.29.2

--===============3556328062506713037==--
