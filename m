Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E672FB9
	for <mptcp@lists.linux.dev>; Thu, 10 Jun 2021 22:59:52 +0000 (UTC)
IronPort-SDR: oJpliyk+1N83Sh88+zfwC9zylqK9l/q1ShQKwJJ67wkJ28nKMXvK7URx53E6C+19eT1qRWCgdh
 wd1pZsoLPMbA==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="266575619"
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="266575619"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 15:59:50 -0700
IronPort-SDR: kkcBhYAt3ouJSzhZt8r08lksxvnNk0o834OgOa7mxLeyvt2PoP6riqDsi0xfKz9xYLI2+gq85+
 HIOFI78zSBSA==
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="441387035"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.70.185])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 15:59:49 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	fw@strlen.de,
	dcaratti@redhat.com,
	cpaasch@apple.com,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net 3/5] mptcp: do not warn on bad input from the network
Date: Thu, 10 Jun 2021 15:59:42 -0700
Message-Id: <20210610225944.351224-4-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210610225944.351224-1-mathew.j.martineau@linux.intel.com>
References: <20210610225944.351224-1-mathew.j.martineau@linux.intel.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

warn_bad_map() produces a kernel WARN on bad input coming
from the network. Use pr_debug() to avoid spamming the system
log.

Additionally, when the right bound check fails, warn_bad_map() reports
the wrong ssn value, let's fix it.

Fixes: 648ef4b88673 ("mptcp: Implement MPTCP receive path")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/107
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/subflow.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index ebb898acd65a..e05e05ec9687 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -784,10 +784,10 @@ static u64 expand_seq(u64 old_seq, u16 old_data_len, u64 seq)
 	return seq | ((old_seq + old_data_len + 1) & GENMASK_ULL(63, 32));
 }
 
-static void warn_bad_map(struct mptcp_subflow_context *subflow, u32 ssn)
+static void dbg_bad_map(struct mptcp_subflow_context *subflow, u32 ssn)
 {
-	WARN_ONCE(1, "Bad mapping: ssn=%d map_seq=%d map_data_len=%d",
-		  ssn, subflow->map_subflow_seq, subflow->map_data_len);
+	pr_debug("Bad mapping: ssn=%d map_seq=%d map_data_len=%d",
+		 ssn, subflow->map_subflow_seq, subflow->map_data_len);
 }
 
 static bool skb_is_fully_mapped(struct sock *ssk, struct sk_buff *skb)
@@ -812,13 +812,13 @@ static bool validate_mapping(struct sock *ssk, struct sk_buff *skb)
 		/* Mapping covers data later in the subflow stream,
 		 * currently unsupported.
 		 */
-		warn_bad_map(subflow, ssn);
+		dbg_bad_map(subflow, ssn);
 		return false;
 	}
 	if (unlikely(!before(ssn, subflow->map_subflow_seq +
 				  subflow->map_data_len))) {
 		/* Mapping does covers past subflow data, invalid */
-		warn_bad_map(subflow, ssn + skb->len);
+		dbg_bad_map(subflow, ssn);
 		return false;
 	}
 	return true;
-- 
2.32.0

