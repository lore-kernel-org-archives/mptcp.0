Content-Type: multipart/mixed; boundary="===============4369826612691740510=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v6 mptcp-next 3/9] mptcp: release the listening
 socket
Date: Wed, 25 Nov 2020 11:01:10 +0800
Message-ID: <97eb2990741ef64d6a83232fec404308ed6111b0.1606272852.git.geliangtang@gmail.com>
In-Reply-To: a9094a27297f9782b7bf8063e9f41a0eb3a81871.1606272852.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6910

--===============4369826612691740510==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch releases the listening socket when the address is removed or
the addresses are flushed by PM netlink.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 22 +++++++++++++++++-----
 net/mptcp/protocol.h   |  1 +
 net/mptcp/subflow.c    |  2 +-
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 39a91fcac403..2b4e7b077bc9 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -908,18 +908,26 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb,=
 struct genl_info *info)
 	spin_unlock_bh(&pernet->lock);
 =

 	mptcp_nl_remove_subflow_and_signal_addr(sock_net(skb->sk), &entry->addr);
+	if (entry->lsk) {
+		subflow_drop_ctx(entry->lsk->sk);
+		sock_release(entry->lsk);
+	}
 	kfree_rcu(entry, rcu);
 =

 	return ret;
 }
 =

-static void __flush_addrs(struct pm_nl_pernet *pernet)
+static void __flush_addrs(struct list_head *list)
 {
-	while (!list_empty(&pernet->local_addr_list)) {
+	while (!list_empty(list)) {
 		struct mptcp_pm_addr_entry *cur;
 =

-		cur =3D list_entry(pernet->local_addr_list.next,
+		cur =3D list_entry(list->next,
 				 struct mptcp_pm_addr_entry, list);
+		if (cur->lsk) {
+			subflow_drop_ctx(cur->lsk->sk);
+			sock_release(cur->lsk);
+		}
 		list_del_rcu(&cur->list);
 		kfree_rcu(cur, rcu);
 	}
@@ -936,11 +944,13 @@ static void __reset_counters(struct pm_nl_pernet *per=
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
+	__flush_addrs(&free_list);
 	return 0;
 }
 =

@@ -1202,10 +1212,12 @@ static void __net_exit pm_nl_exit_net(struct list_h=
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
+		__flush_addrs(&pernet->local_addr_list);
 	}
 }
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 38001b7b0bf6..adf5944ec5c4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -456,6 +456,7 @@ int mptcp_is_enabled(struct net *net);
 unsigned int mptcp_get_add_addr_timeout(struct net *net);
 void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
 				     struct mptcp_options_received *mp_opt);
+void subflow_drop_ctx(struct sock *ssk);
 bool mptcp_subflow_data_available(struct sock *sk);
 void __init mptcp_subflow_init(void);
 void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 6053a88c176f..9a8341eb7a4d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -468,7 +468,7 @@ static void subflow_ulp_fallback(struct sock *sk,
 	tcp_sk(sk)->is_mptcp =3D 0;
 }
 =

-static void subflow_drop_ctx(struct sock *ssk)
+void subflow_drop_ctx(struct sock *ssk)
 {
 	struct mptcp_subflow_context *ctx =3D mptcp_subflow_ctx(ssk);
 =

-- =

2.26.2

--===============4369826612691740510==--
