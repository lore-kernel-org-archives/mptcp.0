Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91F57A
	for <mptcp@lists.linux.dev>; Tue, 28 Jun 2022 19:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656443053; x=1687979053;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9oafj8IEchmde+4lypiQotwbsnPAYCakx9LD9twZoQs=;
  b=BfBUq1nzsPMO8/d92Leqdd+Zs23k+WNZyDPnjz1GPembMeaX6ce/ucWc
   oA1CdDpxMN5wYKuFbJ9ULa9pnZqzE7HcPeRN1aaInkX/X3Pv3hzsO5nng
   lLp/TDe4oMLMRAhKn6GEUAYKAVqU7++XsOoSP1mdjGX5rSEZUsdOdF4Z7
   2l9sG3b8P/7eLJLwpzT3mQQmEu8jnruHjLQ8RrDLZakgq6ewYVq+PF7AI
   TuO8xBUoZJ+rwoT+Pm4+jqFBB0f3BIn+XrSO8rr0iFK+XO6wNLH+eSBGr
   rDsYFOY2LrVg3yCSL+ODG0AyWGLd8lSre254ZAGisKJuRAIh7xJtu1edv
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="343514649"
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="343514649"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 12:04:01 -0700
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="917294954"
Received: from gwbruss-mobl1.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.112.228])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 12:04:01 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-net 3/3] mptcp: Acquire the subflow socket lock before modifying MP_PRIO flags
Date: Tue, 28 Jun 2022 12:03:56 -0700
Message-Id: <20220628190356.326233-4-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220628190356.326233-1-mathew.j.martineau@linux.intel.com>
References: <20220628190356.326233-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When setting up a subflow's flags for sending MP_PRIO MPTCP options, the
subflow socket lock was not held while reading and modifying several
struct members that are also read and modified in mptcp_write_options().

Acquire the subflow socket lock earlier and send the MP_PRIO ACK with
that lock already acquired.

Fixes: 067065422fcd ("mptcp: add the outgoing MP_PRIO support")
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm_netlink.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d04b34fc9a8e..05c6a95e9c28 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -729,11 +729,13 @@ static int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		struct sock *sk = (struct sock *)msk;
 		struct mptcp_addr_info local;
+		bool slow;
 
 		local_address((struct sock_common *)ssk, &local);
 		if (!mptcp_addresses_equal(&local, addr, addr->port))
 			continue;
 
+		slow = lock_sock_fast(ssk);
 		if (subflow->backup != bkup)
 			msk->last_snd = NULL;
 		subflow->backup = bkup;
@@ -742,7 +744,8 @@ static int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 		__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPPRIOTX);
 
 		pr_debug("send ack for mp_prio");
-		mptcp_subflow_send_ack(ssk);
+		__mptcp_subflow_send_ack(ssk);
+		unlock_sock_fast(ssk, slow);
 
 		return 0;
 	}
-- 
2.37.0

