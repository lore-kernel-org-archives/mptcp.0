Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04C61FA5
	for <mptcp@lists.linux.dev>; Wed, 16 Feb 2022 02:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644977512; x=1676513512;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MA9QxId7X9d5GQsDAfk2riHjF8ntAdWskyCHH8+Bcyc=;
  b=TjkVK9dvuhKj0VYoxjbOi2nrLQ5BaHJUNlc0W6VzwgvVdD3phGn6hCFi
   DxGHvlaQ3fT/I9Hu+SiqaU1JcEAuscbDPJx+/ALB4lWJVHTWzTT3p1/6D
   Ob1z6Go1nakIImV5uzimtJYrtPfh/mPYu2IDbn1b+T3INxY+s6OZbz9B0
   6/5jELcaXrA6FvRPSj3slxRXIrUu7jW/Ddop5Q8bXRm2hj+OtUjPzJTey
   +5agBog5k7qsPdLY10qD02D4lGiOUjyBSTW3D3yUQy7hyc9c/yeg7ta+2
   3Y2x/O0REglVv2WXVaqosW3jckrG4d4auZZriDEvXqjZycWr32i9Jk346
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="313778513"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="313778513"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 18:11:37 -0800
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="571088819"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.9.181])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 18:11:36 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH net-next 3/8] mptcp: drop unused sk in mptcp_get_options
Date: Tue, 15 Feb 2022 18:11:25 -0800
Message-Id: <20220216021130.171786-4-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220216021130.171786-1-mathew.j.martineau@linux.intel.com>
References: <20220216021130.171786-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

The parameter 'sk' became useless since the code using it was dropped
from mptcp_get_options() in the commit 8d548ea1dd15 ("mptcp: do not set
unconditionally csum_reqd on incoming opt"). Let's drop it.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/options.c  |  5 ++---
 net/mptcp/protocol.h |  3 +--
 net/mptcp/subflow.c  | 10 +++++-----
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 3e82ac24d548..a10536d7c84b 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -355,8 +355,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 	}
 }
 
-void mptcp_get_options(const struct sock *sk,
-		       const struct sk_buff *skb,
+void mptcp_get_options(const struct sk_buff *skb,
 		       struct mptcp_options_received *mp_opt)
 {
 	const struct tcphdr *th = tcp_hdr(skb);
@@ -1114,7 +1113,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 		return true;
 	}
 
-	mptcp_get_options(sk, skb, &mp_opt);
+	mptcp_get_options(skb, &mp_opt);
 
 	/* The subflow can be in close state only if check_fully_established()
 	 * just sent a reset. If so, tell the caller to ignore the current packet.
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 85317ce38e3f..a23694ad69e7 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -643,8 +643,7 @@ int __init mptcp_proto_v6_init(void);
 struct sock *mptcp_sk_clone(const struct sock *sk,
 			    const struct mptcp_options_received *mp_opt,
 			    struct request_sock *req);
-void mptcp_get_options(const struct sock *sk,
-		       const struct sk_buff *skb,
+void mptcp_get_options(const struct sk_buff *skb,
 		       struct mptcp_options_received *mp_opt);
 
 void mptcp_finish_connect(struct sock *sk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index bea47a1180dc..0d6a4109add1 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -153,7 +153,7 @@ static int subflow_check_req(struct request_sock *req,
 		return -EINVAL;
 #endif
 
-	mptcp_get_options(sk_listener, skb, &mp_opt);
+	mptcp_get_options(skb, &mp_opt);
 
 	opt_mp_capable = !!(mp_opt.suboptions & OPTIONS_MPTCP_MPC);
 	opt_mp_join = !!(mp_opt.suboptions & OPTIONS_MPTCP_MPJ);
@@ -250,7 +250,7 @@ int mptcp_subflow_init_cookie_req(struct request_sock *req,
 	int err;
 
 	subflow_init_req(req, sk_listener);
-	mptcp_get_options(sk_listener, skb, &mp_opt);
+	mptcp_get_options(skb, &mp_opt);
 
 	opt_mp_capable = !!(mp_opt.suboptions & OPTIONS_MPTCP_MPC);
 	opt_mp_join = !!(mp_opt.suboptions & OPTIONS_MPTCP_MPJ);
@@ -410,7 +410,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 	subflow->ssn_offset = TCP_SKB_CB(skb)->seq;
 	pr_debug("subflow=%p synack seq=%x", subflow, subflow->ssn_offset);
 
-	mptcp_get_options(sk, skb, &mp_opt);
+	mptcp_get_options(skb, &mp_opt);
 	if (subflow->request_mptcp) {
 		if (!(mp_opt.suboptions & OPTIONS_MPTCP_MPC)) {
 			MPTCP_INC_STATS(sock_net(sk),
@@ -663,7 +663,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 		 * reordered MPC will cause fallback, but we don't have other
 		 * options.
 		 */
-		mptcp_get_options(sk, skb, &mp_opt);
+		mptcp_get_options(skb, &mp_opt);
 		if (!(mp_opt.suboptions & OPTIONS_MPTCP_MPC)) {
 			fallback = true;
 			goto create_child;
@@ -673,7 +673,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 		if (!new_msk)
 			fallback = true;
 	} else if (subflow_req->mp_join) {
-		mptcp_get_options(sk, skb, &mp_opt);
+		mptcp_get_options(skb, &mp_opt);
 		if (!(mp_opt.suboptions & OPTIONS_MPTCP_MPJ) ||
 		    !subflow_hmac_valid(req, &mp_opt) ||
 		    !mptcp_can_accept_new_subflow(subflow_req->msk)) {
-- 
2.35.1

