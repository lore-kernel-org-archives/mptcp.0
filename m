Content-Type: multipart/mixed; boundary="===============7076532507865019301=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 06/11] mptcp: remove multi subflows in PM
Date: Fri, 12 Mar 2021 17:16:16 -0800
Message-ID: <20210313011621.211661-7-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20210313011621.211661-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 8137

--===============7076532507865019301==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Geliang Tang <geliangtang(a)gmail.com>

This patch dealt with removing multi subflows in PM:

In mptcp_pm_remove_subflow, changed the input parameter local_id as an
list of removing address ids, and passed the list to
mptcp_pm_nl_rm_subflow_received.

In mptcp_pm_nl_rm_subflow_received, iterated each address id from the
received ids list. Then shut down and closed each address id's subsocket.

In mptcp_nl_remove_subflow_and_signal_addr, put the single address id into
an ids list, and passed it to mptcp_pm_remove_subflow.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/pm.c         |  6 +++---
 net/mptcp/pm_netlink.c | 42 +++++++++++++++++++++++++-----------------
 net/mptcp/protocol.h   |  5 +++--
 3 files changed, 31 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index a47436205d88..4cfd80f90003 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -56,12 +56,12 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const =
struct mptcp_rm_list *rm_
 	return 0;
 }
 =

-int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 local_id)
+int mptcp_pm_remove_subflow(struct mptcp_sock *msk, const struct mptcp_rm_=
list *rm_list)
 {
-	pr_debug("msk=3D%p, local_id=3D%d", msk, local_id);
+	pr_debug("msk=3D%p, rm_list_nr=3D%d", msk, rm_list->nr);
 =

 	spin_lock_bh(&msk->pm.lock);
-	mptcp_pm_nl_rm_subflow_received(msk, local_id);
+	mptcp_pm_nl_rm_subflow_received(msk, rm_list);
 	spin_unlock_bh(&msk->pm.lock);
 	return 0;
 }
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index e8135702af39..769a05d836da 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -645,39 +645,44 @@ void mptcp_pm_nl_work(struct mptcp_sock *msk)
 	spin_unlock_bh(&msk->pm.lock);
 }
 =

-void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk, u8 rm_id)
+void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
+				     const struct mptcp_rm_list *rm_list)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
 	struct sock *sk =3D (struct sock *)msk;
+	u8 i;
 =

-	pr_debug("subflow rm_id %d", rm_id);
+	pr_debug("subflow rm_list_nr %d", rm_list->nr);
 =

 	msk_owned_by_me(msk);
 =

-	if (!rm_id)
+	if (!rm_list->nr)
 		return;
 =

 	if (list_empty(&msk->conn_list))
 		return;
 =

-	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
-		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
-		int how =3D RCV_SHUTDOWN | SEND_SHUTDOWN;
+	for (i =3D 0; i < rm_list->nr; i++) {
+		list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
+			struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+			int how =3D RCV_SHUTDOWN | SEND_SHUTDOWN;
 =

-		if (rm_id !=3D subflow->local_id)
-			continue;
+			if (rm_list->ids[i] !=3D subflow->local_id)
+				continue;
 =

-		spin_unlock_bh(&msk->pm.lock);
-		mptcp_subflow_shutdown(sk, ssk, how);
-		mptcp_close_ssk(sk, ssk, subflow);
-		spin_lock_bh(&msk->pm.lock);
+			pr_debug(" -> subflow rm_list_ids[%d]=3D%u", i, rm_list->ids[i]);
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

@@ -1094,9 +1099,12 @@ static int mptcp_nl_remove_subflow_and_signal_addr(s=
truct net *net,
 {
 	struct mptcp_sock *msk;
 	long s_slot =3D 0, s_num =3D 0;
+	struct mptcp_rm_list list =3D { .nr =3D 0 };
 =

 	pr_debug("remove_id=3D%d", addr->id);
 =

+	list.ids[list.nr++] =3D addr->id;
+
 	while ((msk =3D mptcp_token_iter_next(net, &s_slot, &s_num)) !=3D NULL) {
 		struct sock *sk =3D (struct sock *)msk;
 		bool remove_subflow;
@@ -1110,7 +1118,7 @@ static int mptcp_nl_remove_subflow_and_signal_addr(st=
ruct net *net,
 		remove_subflow =3D lookup_subflow_by_saddr(&msk->conn_list, addr);
 		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow);
 		if (remove_subflow)
-			mptcp_pm_remove_subflow(msk, addr->id);
+			mptcp_pm_remove_subflow(msk, &list);
 		release_sock(sk);
 =

 next:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 5324fbe40528..1111a99b024f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -664,7 +664,7 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
 			   bool echo, bool port);
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_lis=
t *rm_list);
-int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 local_id);
+int mptcp_pm_remove_subflow(struct mptcp_sock *msk, const struct mptcp_rm_=
list *rm_list);
 =

 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		 const struct sock *ssk, gfp_t gfp);
@@ -728,7 +728,8 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struc=
t sock_common *skc);
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_data_init(struct mptcp_sock *msk);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
-void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk, u8 rm_id);
+void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
+				     const struct mptcp_rm_list *rm_list);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *s=
kc);
 unsigned int mptcp_pm_get_add_addr_signal_max(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_accept_max(struct mptcp_sock *msk);
-- =

2.30.2

--===============7076532507865019301==--
