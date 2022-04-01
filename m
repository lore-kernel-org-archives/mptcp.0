Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4861D1391
	for <mptcp@lists.linux.dev>; Fri,  1 Apr 2022 19:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648841839; x=1680377839;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D5mYbNug0Tp4CDRa4bzF+QM94sQAGsqW/XfmDuaHSAo=;
  b=TAtZ6dpJNm21dF0X3jppUXmZcTnbXCCTHmtlxI2kWY6xaQ22m+Mkg3z5
   EEYFYRD3reawDAZO/bU7kwjwTZXX8Vye6VK1Mz4KB6t8t/RF32BRJ90Im
   4pd9CnXFG+EqE/kZMiczb0727rnwJKJvc0tlQkxJbTkewBnQuBdhHs7/u
   wnkxUTSJ7WJUqQzVMghSp5R30CPmTKSecIq8K2Dz/e7aI/HWqvR56/9Jq
   eHNyL8SsyIYpuSoGSjj9mcrTBteuRT3LCag94whVvPsXir5NrCSCtxhqU
   j53NkTWXyrNrsOf4Uy/8k8tsREHZSZgfsjFSnGwKb5X0rOqwyx5rrO4Dz
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="242358952"
X-IronPort-AV: E=Sophos;i="5.90,228,1643702400"; 
   d="scan'208";a="242358952"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 12:37:16 -0700
X-IronPort-AV: E=Sophos;i="5.90,228,1643702400"; 
   d="scan'208";a="640638796"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.187.34])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 12:37:16 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: kishen.maloor@intel.com
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 2/2] selftests: mptcp: ADD_ADDR echo test with missing userspace daemon
Date: Fri,  1 Apr 2022 12:37:14 -0700
Message-Id: <20220401193714.10268-3-mathew.j.martineau@linux.intel.com>
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

Check userspace PM behavior to ensure ADD_ADDR echoes are only sent when
there is an active userspace daemon. If the daemon is restarting or
hasn't loaded yet, the missing echo will cause the peer to retransmit
the ADD_ADDR - and hopefully the daemon will be ready to receive it at
that later time.

Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 650bb062f612..469cd544a8d2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2729,6 +2729,17 @@ userspace_tests()
 		chk_add_nr 0 0
 	fi
 
+	# userspace pm type does not echo add_addr without daemon
+	if reset "userspace pm no echo w/o daemon"; then
+		set_userspace_pm $ns2
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 0 2
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		run_tests $ns1 $ns2 10.0.1.1
+		chk_join_nr 0 0 0
+		chk_add_nr 1 0
+	fi
+
 	# userspace pm type rejects join
 	if reset "userspace pm type rejects join"; then
 		set_userspace_pm $ns1
-- 
2.35.1

