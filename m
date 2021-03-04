Content-Type: multipart/mixed; boundary="===============7268813152973328402=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 5/6] Squash to "mptcp: remove multi
 subflows in PM"
Date: Thu, 04 Mar 2021 14:42:47 +0800
Message-ID: <20210304064248.9636-6-geliangtang@gmail.com>
In-Reply-To: 20210304064248.9636-1-geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 8014

--===============7268813152973328402==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch changed the type of argument rm_list from "struct mptcp_rm_list
rm_list" to "const struct mptcp_rm_list *rm_list".

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm.c         |  4 ++--
 net/mptcp/pm_netlink.c | 15 ++++++++-------
 net/mptcp/protocol.h   |  5 +++--
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index c9598856d2a8..0a06d5947a73 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -56,9 +56,9 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const st=
ruct mptcp_rm_list *rm_
 	return 0;
 }
 =

-int mptcp_pm_remove_subflow(struct mptcp_sock *msk, struct mptcp_rm_list r=
m_list)
+int mptcp_pm_remove_subflow(struct mptcp_sock *msk, const struct mptcp_rm_=
list *rm_list)
 {
-	pr_debug("msk=3D%p, rm_list_nr=3D%d", msk, rm_list.nr);
+	pr_debug("msk=3D%p, rm_list_nr=3D%d", msk, rm_list->nr);
 =

 	spin_lock_bh(&msk->pm.lock);
 	mptcp_pm_nl_rm_subflow_received(msk, rm_list);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 7deddf63be03..000d64c92717 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -668,31 +668,32 @@ void mptcp_pm_nl_work(struct mptcp_sock *msk)
 	spin_unlock_bh(&msk->pm.lock);
 }
 =

-void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk, struct mptcp_=
rm_list rm_list)
+void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
+				     const struct mptcp_rm_list *rm_list)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
 	struct sock *sk =3D (struct sock *)msk;
 	u8 i;
 =

-	pr_debug("subflow rm_list_nr %d", rm_list.nr);
+	pr_debug("subflow rm_list_nr %d", rm_list->nr);
 =

 	msk_owned_by_me(msk);
 =

-	if (!rm_list.nr)
+	if (!rm_list->nr)
 		return;
 =

 	if (list_empty(&msk->conn_list))
 		return;
 =

-	for (i =3D 0; i < rm_list.nr; i++) {
+	for (i =3D 0; i < rm_list->nr; i++) {
 		list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
 			struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
 			int how =3D RCV_SHUTDOWN | SEND_SHUTDOWN;
 =

-			if (rm_list.ids[i] !=3D subflow->local_id)
+			if (rm_list->ids[i] !=3D subflow->local_id)
 				continue;
 =

-			pr_debug(" -> subflow rm_list_ids[%d]=3D%u", i, rm_list.ids[i]);
+			pr_debug(" -> subflow rm_list_ids[%d]=3D%u", i, rm_list->ids[i]);
 			spin_unlock_bh(&msk->pm.lock);
 			mptcp_subflow_shutdown(sk, ssk, how);
 			mptcp_close_ssk(sk, ssk, subflow);
@@ -1140,7 +1141,7 @@ static int mptcp_nl_remove_subflow_and_signal_addr(st=
ruct net *net,
 		remove_subflow =3D lookup_subflow_by_saddr(&msk->conn_list, addr);
 		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow);
 		if (remove_subflow)
-			mptcp_pm_remove_subflow(msk, list);
+			mptcp_pm_remove_subflow(msk, &list);
 		release_sock(sk);
 =

 next:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4100b5238f01..e9a54816f6f8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -663,7 +663,7 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
 			   bool echo);
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_lis=
t *rm_list);
-int mptcp_pm_remove_subflow(struct mptcp_sock *msk, struct mptcp_rm_list r=
m_list);
+int mptcp_pm_remove_subflow(struct mptcp_sock *msk, const struct mptcp_rm_=
list *rm_list);
 =

 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		 const struct sock *ssk, gfp_t gfp);
@@ -726,7 +726,8 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struc=
t sock_common *skc);
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_data_init(struct mptcp_sock *msk);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
-void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk, struct mptcp_=
rm_list rm_list);
+void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
+				     const struct mptcp_rm_list *rm_list);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *s=
kc);
 unsigned int mptcp_pm_get_add_addr_signal_max(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_accept_max(struct mptcp_sock *msk);
-- =

2.29.2

--===============7268813152973328402==--
