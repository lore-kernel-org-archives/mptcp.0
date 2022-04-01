Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319597C
	for <mptcp@lists.linux.dev>; Fri,  1 Apr 2022 19:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648841839; x=1680377839;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H8ub+OtMb/EBBfD3kFQgTNZAb3K+GmRnL7EQ/sNLxXE=;
  b=Rcn0TCT64VxCj2E0xo8gbnU6PYe0sKv/lZhpnl/A2esOSqCOqRkv3b3d
   1GnoKJbhqOiRIMsKW08V7dlVQGh5As2giOtPMbEcMt9bNBrj8kYWf8+DP
   f1zzN5P/DxZHAUrZbGVj9FMdQHIfS+CtG47PekZ6+88C+mxCLpODfYZq6
   N/stu7ztA92oD7RH2rZqsCGyNZ4Psq1iT6+0mSC3Vx2cNV+sGuv1/j4/C
   9yvIJYJA+pCHm8Jdf3M+Pfsbx85prRvHwWgggkkwZ+GVsFB9lpaz+cJcn
   A24r7AsjrFfSJ5q4ez3e8uD++T+FySvUKgztpYBUKC1yL6z868EwkR5p9
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="242358950"
X-IronPort-AV: E=Sophos;i="5.90,228,1643702400"; 
   d="scan'208";a="242358950"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 12:37:16 -0700
X-IronPort-AV: E=Sophos;i="5.90,228,1643702400"; 
   d="scan'208";a="640638793"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.187.34])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 12:37:16 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: kishen.maloor@intel.com
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 1/2] Squash-to: selftests: mptcp: Add tests for userspace PM type
Date: Fri,  1 Apr 2022 12:37:13 -0700
Message-Id: <20220401193714.10268-2-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220401193714.10268-1-mathew.j.martineau@linux.intel.com>
References: <20220329021401.1196466-3-kishen.maloor@intel.com>
 <20220401193714.10268-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove invalid test.

Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 375b087edc7b..650bb062f612 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2729,17 +2729,6 @@ userspace_tests()
 		chk_add_nr 0 0
 	fi
 
-	# userspace pm type echoes add_addr
-	if reset "userspace pm type echoes add_addr"; then
-		set_userspace_pm $ns2
-		pm_nl_set_limits $ns1 0 2
-		pm_nl_set_limits $ns2 0 2
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 0 0 0
-		chk_add_nr 1 1
-	fi
-
 	# userspace pm type rejects join
 	if reset "userspace pm type rejects join"; then
 		set_userspace_pm $ns1
-- 
2.35.1

