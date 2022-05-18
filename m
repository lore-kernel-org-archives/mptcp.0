Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF3633C1
	for <mptcp@lists.linux.dev>; Wed, 18 May 2022 22:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652911493; x=1684447493;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GVWGQpvg+UyEHqjI+bX3d9iFhUdLescrDXVKmRlkUj0=;
  b=GDnjcLAvYSGXSji+F6zi7TouczKYx86lQr0ScJGczQYgp9QF8HmNuK80
   G3iD10CPVjsqmQWUQkoULiWxrF1NR9bAXnMh+8xsUq/D3fbhZ9sK9aVVo
   oVwPECIERv5Fra7xi8eccmbYgLR+GacYEv2y/jEsCTk5JcVjazHC9FABo
   mTOomCJM3qEnMndIR2hD8hTKxJ24XOHCWbP2Up0HLHwCb3ogTuHX5u6tg
   Gj7PjU57W9ddu4tDZO8sx5AP0KJMOr42Tj7CSSw1wEUAFrmmz5XloPvvg
   BUcEULVpyIysMiLBn6BK8jCF2YOzhqOQWA+z/767g012x4xVGuGo26wAu
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="271865361"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="271865361"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 15:04:51 -0700
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="598075438"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.36.18])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 15:04:51 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH net-next 2/4] mptcp: Check for orphaned subflow before handling MP_FAIL timer
Date: Wed, 18 May 2022 15:04:44 -0700
Message-Id: <20220518220446.209750-3-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220518220446.209750-1-mathew.j.martineau@linux.intel.com>
References: <20220518220446.209750-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MP_FAIL timeout (waiting for a peer to respond to an MP_FAIL with
another MP_FAIL) is implemented using the MPTCP socket's sk_timer. That
timer is also used at MPTCP socket close, so it's important to not have
the two timer users interfere with each other.

At MPTCP socket close, all subflows are orphaned before sk_timer is
manipulated. By checking the SOCK_DEAD flag on the subflows, each
subflow can determine if the timer is safe to alter without acquiring
any MPTCP-level lock. This replaces code that was using the
mptcp_data_lock and MPTCP-level socket state checks that did not
correctly protect the timer.

Fixes: 49fa1919d6bc ("mptcp: reset subflow when MP_FAIL doesn't respond")
Reviewed-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm.c      |  7 ++-----
 net/mptcp/subflow.c | 12 ++++--------
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index a3f9bf8e8912..e4ce2bdd2b07 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -313,13 +313,10 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 		subflow->send_mp_fail = 1;
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILTX);
 		subflow->send_infinite_map = 1;
-	} else if (s && inet_sk_state_load(s) != TCP_CLOSE) {
+	} else if (!sock_flag(sk, SOCK_DEAD)) {
 		pr_debug("MP_FAIL response received");
 
-		mptcp_data_lock(s);
-		if (inet_sk_state_load(s) != TCP_CLOSE)
-			sk_stop_timer(s, &s->sk_timer);
-		mptcp_data_unlock(s);
+		sk_stop_timer(s, &s->sk_timer);
 	}
 }
 
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 1e07b4d7ee7b..cb6e54fd401e 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1013,12 +1013,9 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 		pr_debug("infinite mapping received");
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
 		subflow->map_data_len = 0;
-		if (sk && inet_sk_state_load(sk) != TCP_CLOSE) {
-			mptcp_data_lock(sk);
-			if (inet_sk_state_load(sk) != TCP_CLOSE)
-				sk_stop_timer(sk, &sk->sk_timer);
-			mptcp_data_unlock(sk);
-		}
+		if (!sock_flag(ssk, SOCK_DEAD))
+			sk_stop_timer(sk, &sk->sk_timer);
+
 		return MAPPING_INVALID;
 	}
 
@@ -1226,9 +1223,8 @@ static bool subflow_check_data_avail(struct sock *ssk)
 				tcp_send_active_reset(ssk, GFP_ATOMIC);
 				while ((skb = skb_peek(&ssk->sk_receive_queue)))
 					sk_eat_skb(ssk, skb);
-			} else {
+			} else if (!sock_flag(ssk, SOCK_DEAD)) {
 				WRITE_ONCE(subflow->mp_fail_response_expect, true);
-				/* The data lock is acquired in __mptcp_move_skbs() */
 				sk_reset_timer((struct sock *)msk,
 					       &((struct sock *)msk)->sk_timer,
 					       jiffies + TCP_RTO_MAX);
-- 
2.36.1

