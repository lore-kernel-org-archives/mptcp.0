Content-Type: multipart/mixed; boundary="===============4123266524772974070=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v5 mptcp-next 6/9] mptcp: remove multi subflows
 in PM
Date: Mon, 08 Feb 2021 22:54:14 +0800
Message-ID: <2d4a5f5a435373043b30f5b7bc495480fe796e4a.1612795651.git.geliangtang@gmail.com>
In-Reply-To: 893b28cde7b77ea302ae1e33b8e7a33212647cf9.1612795651.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7679

--===============4123266524772974070==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch dealt with removing multi subflows in PM:

In mptcp_pm_remove_subflow, changed the input parameter local_id as an
list of removing address ids, and passed the list to
mptcp_pm_nl_rm_subflow_received.

In mptcp_pm_nl_rm_subflow_received, iterated each address id from the
received ids list. Then shut down and closed each address id's subsocket.

In mptcp_nl_remove_subflow_and_signal_addr, put the single address id into
an ids list, and passed it to mptcp_pm_remove_subflow.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm.c         |  6 +++---
 net/mptcp/pm_netlink.c | 41 ++++++++++++++++++++++++-----------------
 net/mptcp/protocol.h   |  4 ++--
 3 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 6ee6d3340ed5..be36901864aa 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -56,12 +56,12 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, struct=
 mptcp_rm_list rm_list)
 	return 0;
 }
 =

-int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 local_id)
+int mptcp_pm_remove_subflow(struct mptcp_sock *msk, struct mptcp_rm_list r=
m_list)
 {
-	pr_debug("msk=3D%p, local_id=3D%d", msk, local_id);
+	pr_debug("msk=3D%p, rm_list_nr=3D%d", msk, rm_list.nr);
 =

 	spin_lock_bh(&msk->pm.lock);
-	mptcp_pm_nl_rm_subflow_received(msk, local_id);
+	mptcp_pm_nl_rm_subflow_received(msk, rm_list);
 	spin_unlock_bh(&msk->pm.lock);
 	return 0;
 }
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ac0601f428ae..f43794d22b47 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -654,39 +654,43 @@ void mptcp_pm_nl_work(struct mptcp_sock *msk)
 	spin_unlock_bh(&msk->pm.lock);
 }
 =

-void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk, u8 rm_id)
+void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk, struct mptcp_=
rm_list rm_list)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
 	struct sock *sk =3D (struct sock *)msk;
+	u8 i;
 =

-	pr_debug("subflow rm_id %d", rm_id);
+	pr_debug("subflow rm_list_nr %d", rm_list.nr);
 =

 	msk_owned_by_me(msk);
 =

-	if (!rm_id)
+	if (!rm_list.nr)
 		return;
 =

 	if (list_empty(&msk->conn_list))
 		return;
 =

-	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
-		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
-		int how =3D RCV_SHUTDOWN | SEND_SHUTDOWN;
+	for (i =3D 0; i < rm_list.nr; i++) {
+		list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
+			struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+			int how =3D RCV_SHUTDOWN | SEND_SHUTDOWN;
 =

-		if (rm_id !=3D subflow->local_id)
-			continue;
+			if (rm_list.ids[i] !=3D subflow->local_id)
+				continue;
 =

-		spin_unlock_bh(&msk->pm.lock);
-		mptcp_subflow_shutdown(sk, ssk, how);
-		mptcp_close_ssk(sk, ssk, subflow);
-		spin_lock_bh(&msk->pm.lock);
+			pr_debug(" -> subflow rm_list_ids[%d]=3D%u", i, rm_list.ids[i]);
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

@@ -1103,9 +1107,12 @@ static int mptcp_nl_remove_subflow_and_signal_addr(s=
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
@@ -1119,7 +1126,7 @@ static int mptcp_nl_remove_subflow_and_signal_addr(st=
ruct net *net,
 		remove_subflow =3D lookup_subflow_by_saddr(&msk->conn_list, addr);
 		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow);
 		if (remove_subflow)
-			mptcp_pm_remove_subflow(msk, addr->id);
+			mptcp_pm_remove_subflow(msk, list);
 		release_sock(sk);
 =

 next:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8b5bdb7c5779..78fc98fafc59 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -674,7 +674,7 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
 			   bool echo, bool port);
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, struct mptcp_rm_list rm_l=
ist);
-int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 local_id);
+int mptcp_pm_remove_subflow(struct mptcp_sock *msk, struct mptcp_rm_list r=
m_list);
 =

 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		 const struct sock *ssk, gfp_t gfp);
@@ -729,7 +729,7 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struc=
t sock_common *skc);
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_data_init(struct mptcp_sock *msk);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
-void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk, u8 rm_id);
+void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk, struct mptcp_=
rm_list rm_list);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *s=
kc);
 unsigned int mptcp_pm_get_add_addr_signal_max(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_accept_max(struct mptcp_sock *msk);
-- =

2.29.2

--===============4123266524772974070==--
