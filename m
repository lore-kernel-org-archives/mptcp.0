Content-Type: multipart/mixed; boundary="===============2704618210985331774=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 1/2] mptcp: remove address when
 netlink flush addrs
Date: Mon, 30 Nov 2020 14:48:21 +0800
Message-ID: <a826061f6342d5618337b0bc1914cd5ab967c487.1606718512.git.geliangtang@gmail.com>
In-Reply-To: cover.1606718512.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6980

--===============2704618210985331774==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When the PM netlink flushs the addresses, invoke the remove address
function mptcp_nl_remove_subflow_and_signal_addr to remove the addresses
and the subflows.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ba31065ef462..4f1b7f44c03b 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -962,13 +962,14 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb,=
 struct genl_info *info)
 	return ret;
 }
 =

-static void __flush_addrs(struct pm_nl_pernet *pernet)
+static void __flush_addrs(struct net *net, struct list_head *list)
 {
-	while (!list_empty(&pernet->local_addr_list)) {
+	while (!list_empty(list)) {
 		struct mptcp_pm_addr_entry *cur;
 =

-		cur =3D list_entry(pernet->local_addr_list.next,
+		cur =3D list_entry(list->next,
 				 struct mptcp_pm_addr_entry, list);
+		mptcp_nl_remove_subflow_and_signal_addr(net, &cur->addr);
 		list_del_rcu(&cur->list);
 		kfree_rcu(cur, rcu);
 	}
@@ -985,11 +986,13 @@ static void __reset_counters(struct pm_nl_pernet *per=
net)
 static int mptcp_nl_cmd_flush_addrs(struct sk_buff *skb, struct genl_info =
*info)
 {
 	struct pm_nl_pernet *pernet =3D genl_info_pm_nl(info);
+	LIST_HEAD(free_list);
 =

 	spin_lock_bh(&pernet->lock);
-	__flush_addrs(pernet);
+	list_splice_init(&pernet->local_addr_list, &free_list);
 	__reset_counters(pernet);
 	spin_unlock_bh(&pernet->lock);
+	__flush_addrs(sock_net(skb->sk), &free_list);
 	return 0;
 }
 =

@@ -1253,10 +1256,12 @@ static void __net_exit pm_nl_exit_net(struct list_h=
ead *net_list)
 	struct net *net;
 =

 	list_for_each_entry(net, net_list, exit_list) {
+		struct pm_nl_pernet *pernet =3D net_generic(net, pm_nl_pernet_id);
+
 		/* net is removed from namespace list, can't race with
 		 * other modifiers
 		 */
-		__flush_addrs(net_generic(net, pm_nl_pernet_id));
+		__flush_addrs(net, &pernet->local_addr_list);
 	}
 }
 =

-- =

2.26.2

--===============2704618210985331774==--
