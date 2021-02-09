Content-Type: multipart/mixed; boundary="===============3431087907209812311=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v6 mptcp-next 8/9] mptcp: remove a list of
 addrs when flushing
Date: Tue, 09 Feb 2021 23:03:49 +0800
Message-ID: <2fa4aa29c8c7fa21adcb70da92fb72045752b7ca.1612882689.git.geliangtang@gmail.com>
In-Reply-To: 5ba221ebdd8db02357c1c8e786df7bce5b180eb0.1612882689.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7722

--===============3431087907209812311==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch invoked mptcp_nl_remove_addrs_list to remove a list of addresses
when the netlink flushes addresses, instead of using
mptcp_nl_remove_subflow_and_signal_addr to remove them one by one.

And dropped the unused parameter net in __flush_addrs too.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index c29774347c4a..02a69d885230 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1247,14 +1247,13 @@ static void mptcp_nl_remove_addrs_list(struct net *=
net,
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
@@ -1279,7 +1278,8 @@ static int mptcp_nl_cmd_flush_addrs(struct sk_buff *s=
kb, struct genl_info *info)
 	pernet->next_id =3D 1;
 	bitmap_zero(pernet->id_bitmap, MAX_ADDR_ID + 1);
 	spin_unlock_bh(&pernet->lock);
-	__flush_addrs(sock_net(skb->sk), &free_list);
+	mptcp_nl_remove_addrs_list(sock_net(skb->sk), &free_list);
+	__flush_addrs(&free_list);
 	return 0;
 }
 =

@@ -1876,7 +1876,7 @@ static void __net_exit pm_nl_exit_net(struct list_hea=
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

--===============3431087907209812311==--
