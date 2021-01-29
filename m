Content-Type: multipart/mixed; boundary="===============6251732480109391989=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 6/8] mptcp: remove a list of addrs
 when flushing
Date: Fri, 29 Jan 2021 18:26:50 +0800
Message-ID: <dcc70e8d56c91dca07917343fe81eaa075b1f378.1611914854.git.geliangtang@gmail.com>
In-Reply-To: fcfce1fc8b924f427f682c8ca534dd2a4a1c66c0.1611914854.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7529

--===============6251732480109391989==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch invoked mptcp_nl_remove_addrs_and_subflows to remove a list
of addresses when the netlink flushes addresses, instead of using
mptcp_nl_remove_subflow_and_signal_addr to remove them one by one.

Since mptcp_nl_remove_subflow_and_signal_addr was dropped from
__flush_addrs, __flush_addrs could be invoked under the locks. So
dropped the useless free_list in mptcp_nl_cmd_flush_addrs and the unused
parameter net in __flush_addrs.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index e5d36814909c..3801931ab9ea 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1277,14 +1277,13 @@ static void mptcp_nl_remove_addrs_and_subflows(stru=
ct net *net, u64 rm_ids)
 	}
 }
 =

-static void __flush_addrs(struct net *net, struct list_head *list)
+static void __flush_addrs(struct list_head *list)
 {
 	while (!list_empty(list)) {
 		struct mptcp_pm_addr_entry *cur;
 =

 		cur =3D list_entry(list->next,
 				 struct mptcp_pm_addr_entry, list);
-		mptcp_nl_remove_subflow_and_signal_addr(net, &cur->addr);
 		list_del_rcu(&cur->list);
 		mptcp_pm_free_addr_entry(cur);
 	}
@@ -1301,15 +1300,25 @@ static void __reset_counters(struct pm_nl_pernet *p=
ernet)
 static int mptcp_nl_cmd_flush_addrs(struct sk_buff *skb, struct genl_info =
*info)
 {
 	struct pm_nl_pernet *pernet =3D genl_info_pm_nl(info);
-	LIST_HEAD(free_list);
+	struct mptcp_pm_addr_entry *entry;
+	u64 rm_ids =3D 0;
+	u8 *id;
+
+	id =3D (u8 *)&rm_ids;
+	spin_lock_bh(&pernet->lock);
+	list_for_each_entry(entry, &pernet->local_addr_list, list) {
+		if (entry->addr.id)
+			*id++ =3D entry->addr.id;
+	}
+	spin_unlock_bh(&pernet->lock);
+	mptcp_nl_remove_addrs_and_subflows(sock_net(skb->sk), rm_ids);
 =

 	spin_lock_bh(&pernet->lock);
-	list_splice_init(&pernet->local_addr_list, &free_list);
+	__flush_addrs(&pernet->local_addr_list);
 	__reset_counters(pernet);
 	pernet->next_id =3D 1;
 	bitmap_zero(pernet->id_bitmap, MAX_ADDR_ID + 1);
 	spin_unlock_bh(&pernet->lock);
-	__flush_addrs(sock_net(skb->sk), &free_list);
 	return 0;
 }
 =

@@ -1906,7 +1915,7 @@ static void __net_exit pm_nl_exit_net(struct list_hea=
d *net_list)
 		/* net is removed from namespace list, can't race with
 		 * other modifiers
 		 */
-		__flush_addrs(net, &pernet->local_addr_list);
+		__flush_addrs(&pernet->local_addr_list);
 	}
 }
 =

-- =

2.29.2

--===============6251732480109391989==--
