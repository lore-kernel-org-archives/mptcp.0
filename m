Content-Type: multipart/mixed; boundary="===============8721508256333567294=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v6 mptcp-next 2/5] mptcp: unify RM_ADDR and
 RM_SUBFLOW receiving
Date: Thu, 04 Mar 2021 17:33:33 +0800
Message-ID: <0ecdb12a8f1ae31c1619b91deee561697e538872.1614849685.git.geliangtang@gmail.com>
In-Reply-To: 04bd4e4280974266f9942474df19b48bc2d6bd8b.1614849685.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 8018

--===============8721508256333567294==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There are some duplicate code in mptcp_pm_nl_rm_addr_received and
mptcp_pm_nl_rm_subflow_received. This patch unifies them into a new
function named mptcp_pm_nl_rm_addr_or_subflow. In it, use the input
parameter rm_type to identify it's now removing an address or a subflow.

Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 82 +++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 49 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 12e75ad29dc4..2bd61d55186b 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -594,45 +594,68 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *m=
sk,
 	return -EINVAL;
 }
 =

-static void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk)
+static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
+					   const struct mptcp_rm_list *rm_list,
+					   enum linux_mptcp_mib_field rm_type)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
 	struct sock *sk =3D (struct sock *)msk;
 	u8 i;
 =

-	pr_debug("address rm_list_nr %d", msk->pm.rm_list_rx.nr);
+	pr_debug("%s rm_list_nr %d",
+		 rm_type =3D=3D MPTCP_MIB_RMADDR ? "address" : "subflow", rm_list->nr);
 =

 	msk_owned_by_me(msk);
 =

-	if (!msk->pm.rm_list_rx.nr)
+	if (!rm_list->nr)
 		return;
 =

 	if (list_empty(&msk->conn_list))
 		return;
 =

-	for (i =3D 0; i < msk->pm.rm_list_rx.nr; i++) {
+	for (i =3D 0; i < rm_list->nr; i++) {
 		list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
 			struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
 			int how =3D RCV_SHUTDOWN | SEND_SHUTDOWN;
+			u8 id =3D subflow->local_id;
+
+			if (rm_type =3D=3D MPTCP_MIB_RMADDR)
+				id =3D subflow->remote_id;
 =

-			if (msk->pm.rm_list_rx.ids[i] !=3D subflow->remote_id)
+			if (rm_list->ids[i] !=3D id)
 				continue;
 =

-			pr_debug(" -> address rm_list_ids[%d]=3D%u", i, msk->pm.rm_list_rx.ids[=
i]);
+			pr_debug(" -> %s rm_list_ids[%d]=3D%u local_id=3D%u remote_id=3D%u",
+				 rm_type =3D=3D MPTCP_MIB_RMADDR ? "address" : "subflow",
+				 i, rm_list->ids[i], subflow->local_id, subflow->remote_id);
 			spin_unlock_bh(&msk->pm.lock);
 			mptcp_subflow_shutdown(sk, ssk, how);
 			mptcp_close_ssk(sk, ssk, subflow);
 			spin_lock_bh(&msk->pm.lock);
 =

-			msk->pm.add_addr_accepted--;
+			if (rm_type =3D=3D MPTCP_MIB_RMADDR) {
+				msk->pm.add_addr_accepted--;
+				WRITE_ONCE(msk->pm.accept_addr, true);
+			} else if (rm_type =3D=3D MPTCP_MIB_RMSUBFLOW) {
+				msk->pm.local_addr_used--;
+			}
 			msk->pm.subflows--;
-			WRITE_ONCE(msk->pm.accept_addr, true);
-
-			__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMADDR);
+			__MPTCP_INC_STATS(sock_net(sk), rm_type);
 		}
 	}
 }
 =

+static void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk)
+{
+	mptcp_pm_nl_rm_addr_or_subflow(msk, &msk->pm.rm_list_rx, MPTCP_MIB_RMADDR=
);
+}
+
+void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
+				     const struct mptcp_rm_list *rm_list)
+{
+	mptcp_pm_nl_rm_addr_or_subflow(msk, rm_list, MPTCP_MIB_RMSUBFLOW);
+}
+
 void mptcp_pm_nl_work(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_data *pm =3D &msk->pm;
@@ -666,45 +689,6 @@ void mptcp_pm_nl_work(struct mptcp_sock *msk)
 	spin_unlock_bh(&msk->pm.lock);
 }
 =

-void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
-				     const struct mptcp_rm_list *rm_list)
-{
-	struct mptcp_subflow_context *subflow, *tmp;
-	struct sock *sk =3D (struct sock *)msk;
-	u8 i;
-
-	pr_debug("subflow rm_list_nr %d", rm_list->nr);
-
-	msk_owned_by_me(msk);
-
-	if (!rm_list->nr)
-		return;
-
-	if (list_empty(&msk->conn_list))
-		return;
-
-	for (i =3D 0; i < rm_list->nr; i++) {
-		list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
-			struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
-			int how =3D RCV_SHUTDOWN | SEND_SHUTDOWN;
-
-			if (rm_list->ids[i] !=3D subflow->local_id)
-				continue;
-
-			pr_debug(" -> subflow rm_list_ids[%d]=3D%u", i, rm_list->ids[i]);
-			spin_unlock_bh(&msk->pm.lock);
-			mptcp_subflow_shutdown(sk, ssk, how);
-			mptcp_close_ssk(sk, ssk, subflow);
-			spin_lock_bh(&msk->pm.lock);
-
-			msk->pm.local_addr_used--;
-			msk->pm.subflows--;
-
-			__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMSUBFLOW);
-		}
-	}
-}
-
 static bool address_use_port(struct mptcp_pm_addr_entry *entry)
 {
 	return (entry->addr.flags &
-- =

2.29.2

--===============8721508256333567294==--
