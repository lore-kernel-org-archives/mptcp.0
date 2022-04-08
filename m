Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF292CA2
	for <mptcp@lists.linux.dev>; Fri,  8 Apr 2022 19:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649447171; x=1680983171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t6VdNUbE9ZxhADIvxQwrdlpYEV9mOXXWVZlnKfEDQU8=;
  b=JjTrX+Do4GgoqKNF3Lqd1LunY8J66hpmcg45C3oDdpdHWPRAJ1B4BVTl
   kuwPWD/5kpB55SLWumeQmURbRITOwufIaW2Rlx752Ljz8B350Kz+HgVAt
   B1EwoINLEG2DYCrTxT0fFf0+oeb0AL+tu8hHjsqlUgQ2mPdduxhh8M3UP
   u60yW9qd7HJkbr40YJ4fdoK91NwGn+JZTONis0EaNbqjvtbf9/8wvW+uv
   k5A7QB24umusF42NKd4DIgXd1PEAIkfjDuVCtiaQrLpU6QIE5gBXItLZv
   PLc4bbkO8xCrv2WKaAloYSRhRS2I74Q4Sj6Jy6V3zJIeFkrikNzMAHQ+d
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="322365306"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="322365306"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 12:46:10 -0700
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="659602162"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.134.75.99])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 12:46:09 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 5/8] mptcp: diag: switch to context structure
Date: Fri,  8 Apr 2022 12:45:58 -0700
Message-Id: <20220408194601.305969-6-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220408194601.305969-1-mathew.j.martineau@linux.intel.com>
References: <20220408194601.305969-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

Raw access to cb->arg[] is deprecated, use a context structure.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
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

