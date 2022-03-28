Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188BC3202
	for <mptcp@lists.linux.dev>; Mon, 28 Mar 2022 12:49:26 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1nYooG-00068r-57; Mon, 28 Mar 2022 14:49:24 +0200
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp-next v2 1/3] mptcp: diag: switch to context structure
Date: Mon, 28 Mar 2022 14:49:11 +0200
Message-Id: <20220328124913.29768-2-fw@strlen.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220328124913.29768-1-fw@strlen.de>
References: <20220328124913.29768-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Raw access to cb->arg[] is deprecated, use a context structure.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/mptcp/mptcp_diag.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
index f44125dd6697..c4992eeb67d8 100644
--- a/net/mptcp/mptcp_diag.c
+++ b/net/mptcp/mptcp_diag.c
@@ -66,20 +66,28 @@ static int mptcp_diag_dump_one(struct netlink_callback *cb,
 	return err;
 }
 
+struct mptcp_diag_ctx {
+	long s_slot;
+	long s_num;
+};
+
 static void mptcp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 			    const struct inet_diag_req_v2 *r)
 {
 	bool net_admin = netlink_net_capable(cb->skb, CAP_NET_ADMIN);
+	struct mptcp_diag_ctx *diag_ctx = (void *)cb->ctx;
 	struct net *net = sock_net(skb->sk);
 	struct inet_diag_dump_data *cb_data;
 	struct mptcp_sock *msk;
 	struct nlattr *bc;
 
+	BUILD_BUG_ON(sizeof(cb->ctx) < sizeof(*diag_ctx));
+
 	cb_data = cb->data;
 	bc = cb_data->inet_diag_nla_bc;
 
-	while ((msk = mptcp_token_iter_next(net, &cb->args[0], &cb->args[1])) !=
-	       NULL) {
+	while ((msk = mptcp_token_iter_next(net, &diag_ctx->s_slot,
+					    &diag_ctx->s_num)) != NULL) {
 		struct inet_sock *inet = (struct inet_sock *)msk;
 		struct sock *sk = (struct sock *)msk;
 		int ret = 0;
@@ -101,7 +109,7 @@ static void mptcp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 		sock_put(sk);
 		if (ret < 0) {
 			/* will retry on the same position */
-			cb->args[1]--;
+			diag_ctx->s_num--;
 			break;
 		}
 		cond_resched();
-- 
2.35.1

