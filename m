Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632472F27
	for <mptcp@lists.linux.dev>; Thu,  3 Feb 2022 01:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643850231; x=1675386231;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/9eQohXqMEYwESVU7hdbMNneG33BX8HfDAWFeLSdjic=;
  b=T2xV8xnaAfdoDKGR7ZxYpLXGABHv1SqJgugMcJKoZqzFuxf0SfSpiXBB
   dY25DL4dYloWpczkhUq2bmGXAbSooEvb5g4o/yMbMb/Bqk6XO/AHTeAnn
   8vCaDeuxC5FoHR1AHcA46DZ66NW78JyxJ7MJftpaCgMP2rrgK7KEqC5Hq
   NdtdyMR5bxvR5b5lMWrmT7zDSXySQ3AVIAS0CZgIBTquYiDbNF1cn6nH3
   rRoybnPurcYaCnGA5rsSDghbdkvwH27GtzlVHZtZZ5/7fhtlcDCuvIZdx
   FQtTQEnGgEcyWvpA8Z8++IAsB1K6Tde33bIqNAiG4Ik83ICAY5T63mx5K
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="228023382"
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="228023382"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 17:03:48 -0800
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="483070828"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.251.1.6])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 17:03:48 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 1/7] mptcp: move the declarations of ssk and subflow
Date: Wed,  2 Feb 2022 17:03:37 -0800
Message-Id: <20220203010343.113421-2-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220203010343.113421-1-mathew.j.martineau@linux.intel.com>
References: <20220203010343.113421-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

Move the declarations of ssk and subflow in MP_FAIL and MP_PRIO to the
beginning of the function mptcp_write_options().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/options.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 645dd984fef0..5d0b3c3e4655 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1264,10 +1264,10 @@ static u16 mptcp_make_csum(const struct mptcp_ext *mpext)
 void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 			 struct mptcp_out_options *opts)
 {
-	if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions)) {
-		const struct sock *ssk = (const struct sock *)tp;
-		struct mptcp_subflow_context *subflow;
+	const struct sock *ssk = (const struct sock *)tp;
+	struct mptcp_subflow_context *subflow;
 
+	if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions)) {
 		subflow = mptcp_subflow_ctx(ssk);
 		subflow->send_mp_fail = 0;
 
@@ -1489,9 +1489,6 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 	}
 
 	if (OPTION_MPTCP_PRIO & opts->suboptions) {
-		const struct sock *ssk = (const struct sock *)tp;
-		struct mptcp_subflow_context *subflow;
-
 		subflow = mptcp_subflow_ctx(ssk);
 		subflow->send_mp_prio = 0;
 
-- 
2.35.1

