Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B443291C
	for <mptcp@lists.linux.dev>; Thu, 17 Feb 2022 14:25:55 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1nKhj9-0004Da-Qv; Thu, 17 Feb 2022 15:25:47 +0100
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp-next v2 1/5] mptcp: check netns in mptcp_token_exists
Date: Thu, 17 Feb 2022 15:25:34 +0100
Message-Id: <20220217142538.7849-2-fw@strlen.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220217142538.7849-1-fw@strlen.de>
References: <20220217142538.7849-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will be used by a followup patch to check if the token
specified in mp_join option exists in the current netns.

At this time, tokens are unique across all namespaces, but
we need to treat a token that exists in netns x as 'does not exist'
when doing existence check from netns y.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/mptcp/protocol.h | 2 +-
 net/mptcp/subflow.c  | 4 +++-
 net/mptcp/token.c    | 5 +++--
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 18ca0248c084..c43ca46dbc27 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -725,7 +725,7 @@ void mptcp_token_destroy_request(struct request_sock *req);
 int mptcp_token_new_connect(struct sock *sk);
 void mptcp_token_accept(struct mptcp_subflow_request_sock *r,
 			struct mptcp_sock *msk);
-bool mptcp_token_exists(u32 token);
+bool mptcp_token_exists(const struct net *net, u32 token);
 struct mptcp_sock *mptcp_token_get_sock(struct net *net, u32 token);
 struct mptcp_sock *mptcp_token_iter_next(const struct net *net, long *s_slot,
 					 long *s_num);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index e727d838da0e..be43077fe76e 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -176,10 +176,12 @@ static int subflow_check_req(struct request_sock *req,
 		} while (subflow_req->local_key == 0);
 
 		if (unlikely(req->syncookie)) {
+			const struct net *net = read_pnet(&inet_rsk(req)->ireq_net);
+
 			mptcp_crypto_key_sha(subflow_req->local_key,
 					     &subflow_req->token,
 					     &subflow_req->idsn);
-			if (mptcp_token_exists(subflow_req->token)) {
+			if (mptcp_token_exists(net, subflow_req->token)) {
 				if (retries-- > 0)
 					goto again;
 				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_TOKENFALLBACKINIT);
diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index f52ee7b26aed..0593c83385e0 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -203,7 +203,7 @@ void mptcp_token_accept(struct mptcp_subflow_request_sock *req,
 	spin_unlock_bh(&bucket->lock);
 }
 
-bool mptcp_token_exists(u32 token)
+bool mptcp_token_exists(const struct net *net, u32 token)
 {
 	struct hlist_nulls_node *pos;
 	struct token_bucket *bucket;
@@ -216,7 +216,8 @@ bool mptcp_token_exists(u32 token)
 again:
 	sk_nulls_for_each_rcu(sk, pos, &bucket->msk_chain) {
 		msk = mptcp_sk(sk);
-		if (READ_ONCE(msk->token) == token)
+		if (READ_ONCE(msk->token) == token &&
+		    net_eq(sock_net(sk), net))
 			goto found;
 	}
 	if (get_nulls_value(pos) != (token & token_mask))
-- 
2.34.1

