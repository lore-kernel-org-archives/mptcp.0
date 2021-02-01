Content-Type: multipart/mixed; boundary="===============2913207357994458298=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next 4/7] mptcp: remove multi subflows
 in PM
Date: Mon, 01 Feb 2021 15:11:13 +0800
Message-ID: <2eddb38602dd1282e55242231795f1ebcbaa196f.1612163150.git.geliangtang@gmail.com>
In-Reply-To: 3a9a9afec779338214b950c0bbba9c470ea4cbdc.1612163150.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7547

--===============2913207357994458298==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch dealt with removing multi subflows in PM:

In mptcp_pm_remove_subflow, changed the input parameter local_id as an
array of removing address ids, and passed the array to
mptcp_pm_nl_rm_subflow_received.

In mptcp_pm_nl_rm_subflow_received, iterated each address id from the
received ids array. Then shut down and closed each address id's subsocket.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm.c         |  6 +++---
 net/mptcp/pm_netlink.c | 41 ++++++++++++++++++++++++-----------------
 net/mptcp/protocol.h   |  4 ++--
 3 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index f4d7f3afd1e5..611863beb48f 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -56,12 +56,12 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, u8 loc=
al_ids[])
 	return 0;
 }
 =

-int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 local_id)
+int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 local_ids[])
 {
-	pr_debug("msk=3D%p, local_id=3D%d", msk, local_id);
+	pr_debug("msk=3D%p, local_ids_nr=3D%d", msk, mptcp_get_rm_ids_nr(local_id=
s));
 =

 	spin_lock_bh(&msk->pm.lock);
-	mptcp_pm_nl_rm_subflow_received(msk, local_id);
+	mptcp_pm_nl_rm_subflow_received(msk, local_ids);
 	spin_unlock_bh(&msk->pm.lock);
 	return 0;
 }
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 228cf5dfddd7..dea5cf328ad4 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -646,39 +646,45 @@ void mptcp_pm_nl_work(struct mptcp_sock *msk)
 	spin_unlock_bh(&msk->pm.lock);
 }
 =

-void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk, u8 rm_id)
+void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk, u8 rm_ids[])
 {
 	struct mptcp_subflow_context *subflow, *tmp;
 	struct sock *sk =3D (struct sock *)msk;
+	u8 i, nr;
+
+	nr =3D mptcp_get_rm_ids_nr(rm_ids);
 =

-	pr_debug("subflow rm_id %d", rm_id);
+	pr_debug("subflow rm_ids_nr %d", nr);
 =

 	msk_owned_by_me(msk);
 =

-	if (!rm_id)
+	if (!nr)
 		return;
 =

 	if (list_empty(&msk->conn_list))
 		return;
 =

-	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
-		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
-		int how =3D RCV_SHUTDOWN | SEND_SHUTDOWN;
+	for (i =3D 0; i < MPTCP_RM_IDS_MAX && rm_ids[i]; i++) {
+		list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
+			struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+			int how =3D RCV_SHUTDOWN | SEND_SHUTDOWN;
 =

-		if (rm_id !=3D subflow->local_id)
-			continue;
+			if (rm_ids[i] !=3D subflow->local_id)
+				continue;
 =

-		spin_unlock_bh(&msk->pm.lock);
-		mptcp_subflow_shutdown(sk, ssk, how);
-		mptcp_close_ssk(sk, ssk, subflow);
-		spin_lock_bh(&msk->pm.lock);
+			pr_debug(" -> subflow rm_ids[%d]=3D%u", i, rm_ids[i]);
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

@@ -1091,6 +1097,7 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_so=
ck *msk,
 static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 						   struct mptcp_addr_info *addr)
 {
+	u8 ids[MPTCP_RM_IDS_MAX] =3D { addr->id, 0, 0, 0, 0, 0, 0, 0 };
 	struct mptcp_sock *msk;
 	long s_slot =3D 0, s_num =3D 0;
 =

@@ -1109,7 +1116,7 @@ static int mptcp_nl_remove_subflow_and_signal_addr(st=
ruct net *net,
 		remove_subflow =3D lookup_subflow_by_saddr(&msk->conn_list, addr);
 		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow);
 		if (remove_subflow)
-			mptcp_pm_remove_subflow(msk, addr->id);
+			mptcp_pm_remove_subflow(msk, ids);
 		release_sock(sk);
 =

 next:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 5adf85e3fd15..3a043eadd3f2 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -675,7 +675,7 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
 			   bool echo, bool port);
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, u8 local_ids[]);
-int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 local_id);
+int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 local_ids[]);
 =

 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		 const struct sock *ssk, gfp_t gfp);
@@ -730,7 +730,7 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struc=
t sock_common *skc);
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_data_init(struct mptcp_sock *msk);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
-void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk, u8 rm_id);
+void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk, u8 rm_ids[]);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *s=
kc);
 unsigned int mptcp_pm_get_add_addr_signal_max(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_accept_max(struct mptcp_sock *msk);
-- =

2.29.2

--===============2913207357994458298==--
