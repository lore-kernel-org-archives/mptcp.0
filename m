Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E64211E
	for <mptcp@lists.linux.dev>; Tue, 29 Mar 2022 11:35:42 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1nZA8T-0004uY-31; Tue, 29 Mar 2022 13:35:41 +0200
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp-next v3 3/4] mptcp: listen diag dump support
Date: Tue, 29 Mar 2022 13:35:22 +0200
Message-Id: <20220329113523.19793-4-fw@strlen.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220329113523.19793-1-fw@strlen.de>
References: <20220329113523.19793-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

makes 'ss -Ml' show mptcp listen sockets.

Iterate over the tcp listen sockets and pick those that have mptcp ulp
info attached.

mptcp_diag_get_info() is modified to prefer msk->first for mptcp sockets
in listen state.  This reports accurate number for recv and send queue
(pending / max connection backlog counters).

Sample output:
ss -Mil
State        Recv-Q Send-Q Local Address:Port  Peer Address:Port
LISTEN       0      20     127.0.0.1:12000     0.0.0.0:*
         subflows_max:2

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 Changes:
  - init nlattr *bc properly
  - fix sock_put indentation



 net/mptcp/mptcp_diag.c | 91 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
index c4992eeb67d8..dbb6d876a203 100644
--- a/net/mptcp/mptcp_diag.c
+++ b/net/mptcp/mptcp_diag.c
@@ -69,8 +69,83 @@ static int mptcp_diag_dump_one(struct netlink_callback *cb,
 struct mptcp_diag_ctx {
 	long s_slot;
 	long s_num;
+	unsigned int l_slot;
+	unsigned int l_num;
 };
 
+static void mptcp_diag_dump_listeners(struct sk_buff *skb, struct netlink_callback *cb,
+				      const struct inet_diag_req_v2 *r,
+				      bool net_admin)
+{
+	struct inet_diag_dump_data *cb_data = cb->data;
+	struct mptcp_diag_ctx *diag_ctx = (void *)cb->ctx;
+	struct nlattr *bc = cb_data->inet_diag_nla_bc;
+	struct net *net = sock_net(skb->sk);
+	int i;
+
+	for (i = diag_ctx->l_slot; i < INET_LHTABLE_SIZE; i++) {
+		struct inet_listen_hashbucket *ilb;
+		struct hlist_nulls_node *node;
+		struct sock *sk;
+		int num = 0;
+
+		ilb = &tcp_hashinfo.listening_hash[i];
+
+		rcu_read_lock();
+		spin_lock(&ilb->lock);
+		sk_nulls_for_each(sk, node, &ilb->nulls_head) {
+			const struct mptcp_subflow_context *ctx = mptcp_subflow_ctx(sk);
+			struct inet_sock *inet = inet_sk(sk);
+			int ret;
+
+			if (num < diag_ctx->l_num)
+				goto next_listen;
+
+			if (!ctx || strcmp(inet_csk(sk)->icsk_ulp_ops->name, "mptcp"))
+				goto next_listen;
+
+			sk = ctx->conn;
+			if (!sk || !net_eq(sock_net(sk), net))
+				goto next_listen;
+
+			if (r->sdiag_family != AF_UNSPEC &&
+			    sk->sk_family != r->sdiag_family)
+				goto next_listen;
+
+			if (r->id.idiag_sport != inet->inet_sport &&
+			    r->id.idiag_sport)
+				goto next_listen;
+
+			if (!refcount_inc_not_zero(&sk->sk_refcnt))
+				goto next_listen;
+
+			ret = sk_diag_dump(sk, skb, cb, r, bc, net_admin);
+
+			sock_put(sk);
+
+			if (ret < 0) {
+				spin_unlock(&ilb->lock);
+				rcu_read_unlock();
+				diag_ctx->l_slot = i;
+				diag_ctx->l_num = num;
+				return;
+			}
+			diag_ctx->l_num = num + 1;
+			num = 0;
+next_listen:
+			++num;
+		}
+		spin_unlock(&ilb->lock);
+		rcu_read_unlock();
+
+		cond_resched();
+		diag_ctx->l_num = 0;
+	}
+
+	diag_ctx->l_num = 0;
+	diag_ctx->l_slot = i;
+}
+
 static void mptcp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 			    const struct inet_diag_req_v2 *r)
 {
@@ -114,6 +189,9 @@ static void mptcp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 		}
 		cond_resched();
 	}
+
+	if ((r->idiag_states & TCPF_LISTEN) && r->id.idiag_dport == 0)
+		mptcp_diag_dump_listeners(skb, cb, r, net_admin);
 }
 
 static void mptcp_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
@@ -124,6 +202,19 @@ static void mptcp_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
 
 	r->idiag_rqueue = sk_rmem_alloc_get(sk);
 	r->idiag_wqueue = sk_wmem_alloc_get(sk);
+
+	if (inet_sk_state_load(sk) == TCP_LISTEN) {
+		struct sock *lsk = READ_ONCE(msk->first);
+
+		if (lsk) {
+			/* override with settings from tcp listener,
+			 * so Send-Q will show accept queue.
+			 */
+			r->idiag_rqueue = READ_ONCE(lsk->sk_ack_backlog);
+			r->idiag_wqueue = READ_ONCE(lsk->sk_max_ack_backlog);
+		}
+	}
+
 	if (!info)
 		return;
 
-- 
2.35.1

