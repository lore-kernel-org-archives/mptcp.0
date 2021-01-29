Content-Type: multipart/mixed; boundary="===============8470610242977507728=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 5/8] mptcp: implement
 mptcp_nl_remove_addrs_and_subflows
Date: Fri, 29 Jan 2021 18:26:49 +0800
Message-ID: <fcfce1fc8b924f427f682c8ca534dd2a4a1c66c0.1611914854.git.geliangtang@gmail.com>
In-Reply-To: afb328bb77ea380d4171500cc0e4d3dc7702f2ee.1611914854.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7528

--===============8470610242977507728==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch implemented a new function named
mptcp_nl_remove_addrs_and_subflows, which had a input parameter rm_ids
as a ids map.

If the msk->conn_list is empty, only invoke mptcp_pm_remove_anno_addrs
to remove the announced addresses. If it's not empty, invoke
mptcp_pm_remove_anno_addrs_and_subflows to remove the announced
addresses and the subflows.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm.c         |  6 +--
 net/mptcp/pm_netlink.c | 85 ++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h   |  2 +-
 3 files changed, 89 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 117ba05f60c0..63be14625457 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -56,12 +56,12 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, u64 lo=
cal_ids)
 	return 0;
 }
 =

-int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 local_id)
+int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u64 local_ids)
 {
-	pr_debug("msk=3D%p, local_id=3D%d", msk, local_id);
+	pr_debug("msk=3D%p, local_ids=3D%llu", msk, local_ids);
 =

 	spin_lock_bh(&msk->pm.lock);
-	mptcp_pm_nl_rm_subflow_received(msk, local_id);
+	mptcp_pm_nl_rm_subflow_received(msk, local_ids);
 	spin_unlock_bh(&msk->pm.lock);
 	return 0;
 }
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d6da874e6179..e5d36814909c 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1192,6 +1192,91 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb=
, struct genl_info *info)
 	return ret;
 }
 =

+static void mptcp_pm_remove_anno_addrs(struct mptcp_sock *msk, u64 rm_ids)
+{
+	struct sock *sk =3D (struct sock *)msk;
+	struct net *net =3D sock_net(sk);
+	struct pm_nl_pernet *pernet;
+	u8 *p, *ptr, id, nr;
+	u64 active_ids =3D 0;
+
+	pernet =3D net_generic(net, pm_nl_pernet_id);
+	p =3D (u8 *)&active_ids;
+	spin_lock_bh(&pernet->lock);
+	mptcp_for_each_id(rm_ids, nr, ptr, id) {
+		struct mptcp_pm_addr_entry *entry;
+
+		entry =3D __lookup_addr_by_id(pernet, id);
+		if (entry && remove_anno_list_by_saddr(msk, &entry->addr))
+			*p++ =3D id;
+	}
+	spin_unlock_bh(&pernet->lock);
+
+	if (!active_ids)
+		return;
+
+	spin_lock_bh(&msk->pm.lock);
+	mptcp_pm_remove_addr(msk, active_ids);
+	spin_unlock_bh(&msk->pm.lock);
+}
+
+static void mptcp_pm_remove_anno_addrs_and_subflows(struct mptcp_sock *msk=
, u64 local_ids)
+{
+	struct sock *sk =3D (struct sock *)msk;
+	struct net *net =3D sock_net(sk);
+	struct pm_nl_pernet *pernet;
+	u8 *p, *ptr, id, nr;
+	u64 active_ids =3D 0;
+
+	pernet =3D net_generic(net, pm_nl_pernet_id);
+	p =3D (u8 *)&active_ids;
+	spin_lock_bh(&pernet->lock);
+	mptcp_for_each_id(local_ids, nr, ptr, id) {
+		struct mptcp_pm_addr_entry *entry;
+
+		entry =3D __lookup_addr_by_id(pernet, id);
+		if (entry && lookup_subflow_by_saddr(&msk->conn_list, &entry->addr))
+			*p++ =3D id;
+	}
+	spin_unlock_bh(&pernet->lock);
+
+	if (!active_ids)
+		return;
+
+	spin_lock_bh(&msk->pm.lock);
+	mptcp_pm_remove_addr(msk, active_ids);
+	spin_unlock_bh(&msk->pm.lock);
+	mptcp_pm_remove_subflow(msk, active_ids);
+}
+
+static void mptcp_nl_remove_addrs_and_subflows(struct net *net, u64 rm_ids)
+{
+	long s_slot =3D 0, s_num =3D 0;
+	struct mptcp_sock *msk;
+
+	pr_debug("rm_ids=3D%llu", rm_ids);
+
+	if (!rm_ids)
+		return;
+
+	while ((msk =3D mptcp_token_iter_next(net, &s_slot, &s_num)) !=3D NULL) {
+		struct sock *sk =3D (struct sock *)msk;
+
+		if (list_empty(&msk->conn_list)) {
+			mptcp_pm_remove_anno_addrs(msk, rm_ids);
+			goto next;
+		}
+
+		lock_sock(sk);
+		mptcp_pm_remove_anno_addrs_and_subflows(msk, rm_ids);
+		release_sock(sk);
+
+next:
+		sock_put(sk);
+		cond_resched();
+	}
+}
+
 static void __flush_addrs(struct net *net, struct list_head *list)
 {
 	while (!list_empty(list)) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 02bb9c882041..9dd276cb1f71 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -669,7 +669,7 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
 			   bool echo, bool port);
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, u64 local_ids);
-int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 local_id);
+int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u64 local_ids);
 =

 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		 const struct sock *ssk, gfp_t gfp);
-- =

2.29.2

--===============8470610242977507728==--
