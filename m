Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36779370
	for <mptcp@lists.linux.dev>; Tue, 28 Jun 2022 01:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656378171; x=1687914171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5hf/zUwtyP1xs7psY5r6yP8mmqKKeCfRL8bQ2qhiE1Q=;
  b=CZm0bzY4/xiYhsSq2G98mTn9oYC/YNIOOVaU0llS/XPmRltDqE189Uyw
   CN6aQTdBERhEELZJfsjRX5gtIaf9pU+kBd6om7+uIKacM8mK9XF84b1tC
   y8hfzEmIvaO1rCgx+nVIGxRZyrVjTpMJIkWeoRC5lWoRuXdXqI8HNcOM5
   0uiIkLRsFFxQ9wjuIPgWM+fO8dZHQmQiR1cYC3Xy8EmHnZIHsLgDAF3D6
   4emPBMTDJCN9XkeZwLZR4rpG6oCeBnGZ4+8bY1BCcsMbE5dAPlz2d7QAg
   9WgH/rYLyQLtm11XMyOa1ew4D7tJXanU0zyJ3xurQ94hCahcWsxsfiti1
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="270347712"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="270347712"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 18:02:49 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="692867361"
Received: from cgarner-mobl1.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.251.0.217])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 18:02:49 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	fw@strlen.de,
	geliang.tang@suse.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net 1/9] mptcp: fix error mibs accounting
Date: Mon, 27 Jun 2022 18:02:35 -0700
Message-Id: <20220628010243.166605-2-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220628010243.166605-1-mathew.j.martineau@linux.intel.com>
References: <20220628010243.166605-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

The current accounting for MP_FAIL and FASTCLOSE is not very
accurate: both can be increased even when the related option is
not really sent. Move the accounting into the correct place.

Fixes: eb7f33654dc1 ("mptcp: add the mibs for MP_FAIL")
Fixes: 1e75629cb964 ("mptcp: add the mibs for MP_FASTCLOSE")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/options.c | 5 +++--
 net/mptcp/pm.c      | 1 -
 net/mptcp/subflow.c | 4 +---
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index be3b918a6d15..2a6351d55a7d 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -765,6 +765,7 @@ static noinline bool mptcp_established_options_rst(struct sock *sk, struct sk_bu
 	opts->suboptions |= OPTION_MPTCP_RST;
 	opts->reset_transient = subflow->reset_transient;
 	opts->reset_reason = subflow->reset_reason;
+	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPRSTTX);
 
 	return true;
 }
@@ -788,6 +789,7 @@ static bool mptcp_established_options_fastclose(struct sock *sk,
 	opts->rcvr_key = msk->remote_key;
 
 	pr_debug("FASTCLOSE key=%llu", opts->rcvr_key);
+	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFASTCLOSETX);
 	return true;
 }
 
@@ -809,6 +811,7 @@ static bool mptcp_established_options_mp_fail(struct sock *sk,
 	opts->fail_seq = subflow->map_seq;
 
 	pr_debug("MP_FAIL fail_seq=%llu", opts->fail_seq);
+	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILTX);
 
 	return true;
 }
@@ -833,13 +836,11 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 		    mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
 			*size += opt_size;
 			remaining -= opt_size;
-			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFASTCLOSETX);
 		}
 		/* MP_RST can be used with MP_FASTCLOSE and MP_FAIL if there is room */
 		if (mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) {
 			*size += opt_size;
 			remaining -= opt_size;
-			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPRSTTX);
 		}
 		return true;
 	}
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 59a85220edc9..91a62b598de4 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -310,7 +310,6 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 		pr_debug("send MP_FAIL response and infinite map");
 
 		subflow->send_mp_fail = 1;
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILTX);
 		subflow->send_infinite_map = 1;
 	} else if (!sock_flag(sk, SOCK_DEAD)) {
 		pr_debug("MP_FAIL response received");
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8841e8cd9ad8..50ad19adc003 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -958,10 +958,8 @@ static enum mapping_status validate_data_csum(struct sock *ssk, struct sk_buff *
 				 subflow->map_data_csum);
 	if (unlikely(csum)) {
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DATACSUMERR);
-		if (subflow->mp_join || subflow->valid_csum_seen) {
+		if (subflow->mp_join || subflow->valid_csum_seen)
 			subflow->send_mp_fail = 1;
-			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPFAILTX);
-		}
 		return subflow->mp_join ? MAPPING_INVALID : MAPPING_DUMMY;
 	}
 
-- 
2.37.0

