Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D38160
	for <mptcp@lists.linux.dev>; Thu, 12 May 2022 00:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652314994; x=1683850994;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7mQ6R5Ulv48fnBfoZXfWl9bRJyQaAKqF/vgwCD0c/6E=;
  b=ArNN+tb1UgavDbEIcKSe++cjAIjhWE4FpL3YI/7VplxYIXzbzLZRUcgs
   lTy6aRz7EnN9Y9beAJjPZdgi6ivUw5zFfZkVvMGtFl5j5q/WuirVi9vB1
   wlQ12hixlM1xhUyZAmk15FpStxPk4RzCDq+VpRxm3nZ8V8dTxyIfEmdm9
   PQVUo9XclhH3HHqZWFH4ucjjbYx8DIKry+IQ1hCh0JKF06uJvxkBvQ4Od
   m5Ial7RayOaRfz3oirEVVPfvJOzHBx5I5Se6Qdm5jCs4adglJ4rnoaGs2
   cLYp+6m3JSkN3qidE3Lx0tgSHo/cWqSv+e8+DQXW9dRvk46n+ofzPAV7n
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="295093406"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="295093406"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 17:23:13 -0700
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="658378725"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.225.213])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 17:23:13 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next 1/2] mptcp: Check for orphaned subflow before handling MP_FAIL timer
Date: Wed, 11 May 2022 17:23:07 -0700
Message-Id: <20220512002308.445416-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.1
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
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm.c      |  7 ++-----
 net/mptcp/subflow.c | 12 ++++--------
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 8ba51120f35b..59a85220edc9 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -312,13 +312,10 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
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
index f693544e16ff..4adf0ad63478 100644
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

