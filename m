Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D548D1FC7
	for <mptcp@lists.linux.dev>; Thu, 24 Mar 2022 13:58:19 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1nXNyk-000702-1d; Thu, 24 Mar 2022 14:58:18 +0100
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp-next 3/4] mptcp: listen diag dump support
Date: Thu, 24 Mar 2022 14:57:52 +0100
Message-Id: <20220324135753.25182-4-fw@strlen.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220324135753.25182-1-fw@strlen.de>
References: <20220324135753.25182-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

makes 'ss -Ml' show mptcp listen sockets.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/mptcp/mptcp_diag.c | 67 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
index c4992eeb67d8..6a6dfc7eac33 100644
--- a/net/mptcp/mptcp_diag.c
+++ b/net/mptcp/mptcp_diag.c
@@ -69,6 +69,8 @@ static int mptcp_diag_dump_one(struct netlink_callback *cb,
 struct mptcp_diag_ctx {
 	long s_slot;
 	long s_num;
+	unsigned int l_slot;
+	unsigned int l_num;
 };
 
 static void mptcp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
@@ -114,6 +116,71 @@ static void mptcp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 		}
 		cond_resched();
 	}
+
+	if (r->idiag_states & TCPF_LISTEN) {
+		int i;
+
+		for (i = diag_ctx->l_slot; i < INET_LHTABLE_SIZE; i++) {
+			struct inet_listen_hashbucket *ilb;
+			struct hlist_nulls_node *node;
+			struct sock *sk;
+			int num = 0;
+
+			ilb = &tcp_hashinfo.listening_hash[i];
+
+			rcu_read_lock();
+			spin_lock(&ilb->lock);
+			sk_nulls_for_each(sk, node, &ilb->nulls_head) {
+				const struct mptcp_subflow_context *ctx = mptcp_subflow_ctx(sk);
+				struct inet_sock *inet = inet_sk(sk);
+				int ret;
+
+				if (num < diag_ctx->l_num)
+					goto next_listen;
+
+				if (!ctx || strcmp(inet_csk(sk)->icsk_ulp_ops->name, "mptcp"))
+					goto next_listen;
+
+				sk = ctx->conn;
+				if (!sk || !net_eq(sock_net(sk), net))
+					goto next_listen;
+
+				if (r->sdiag_family != AF_UNSPEC &&
+				    sk->sk_family != r->sdiag_family)
+					goto next_listen;
+
+				if (r->id.idiag_sport != inet->inet_sport &&
+				    r->id.idiag_sport)
+					goto next_listen;
+
+				if (!refcount_inc_not_zero(&sk->sk_refcnt))
+					goto next_listen;
+
+				ret = sk_diag_dump(sk, skb, cb, r, bc, net_admin);
+				sock_put(sk);
+
+				if (ret < 0) {
+					spin_unlock(&ilb->lock);
+					rcu_read_unlock();
+					diag_ctx->l_slot = i;
+					diag_ctx->l_num = num;
+					return;
+				}
+				diag_ctx->l_num = num + 1;
+				num = 0;
+next_listen:
+				++num;
+			}
+			spin_unlock(&ilb->lock);
+			rcu_read_unlock();
+
+			cond_resched();
+			diag_ctx->l_num = 0;
+		}
+
+		diag_ctx->l_num = 0;
+		diag_ctx->l_slot = i;
+	}
 }
 
 static void mptcp_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
-- 
2.34.1

