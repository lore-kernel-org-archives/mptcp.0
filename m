Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BC98AD0
	for <mptcp@lists.linux.dev>; Tue, 15 Nov 2022 22:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668550254; x=1700086254;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/+J2SJGFfiOnwickjgrCYZT4bEgVNKrrWZZlc0+2ECI=;
  b=lF1/GtnERm1SM2GeIlvz74HKio0UX7dPK/37ClO4IYm+Fi8lLMnO+cVU
   Y3aZbMZAhgfj2kDAxHv3n6MpMDOsSGedFWq5Kzr0czEbjrFtkCw+fdimj
   mK5+F4ms0mmvglDQS49Js4gbE8CrHZ0PgaZMbIah4OKoRQXYZADNMeawA
   J1Mc8ch+i500hc/LTQ9UHIkTVUqt2lwvb7bss/blSG4oBk2YhCTptTkPI
   aURYNtxIMTi89I+POwY0q/rKtlPJRQdI6ePfkgZJ4ajKeQU5LL7FZSS6Z
   u8w/cPe0lgSf5gItVPS/RFBqcYNVHgt0z2OcK5xhMoHGVtgijpmsMjZPZ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="292089836"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="292089836"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 14:10:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="616917990"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="616917990"
Received: from imunagan-mobl.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.21.103])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 14:10:51 -0800
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
Subject: [PATCH net 1/3] selftests: mptcp: gives slow test-case more time
Date: Tue, 15 Nov 2022 14:10:44 -0800
Message-Id: <20221115221046.20370-2-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221115221046.20370-1-mathew.j.martineau@linux.intel.com>
References: <20221115221046.20370-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

On slow or busy VM, some test-cases still fail because the
data transfer completes before the endpoint manipulation
actually took effect.

Address the issue by artificially increasing the runtime for
the relevant test-cases.

Fixes: ef360019db40 ("selftests: mptcp: signal addresses testcases")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/309
Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f3dd5f2a0272..2eeaf4aca644 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2152,7 +2152,7 @@ remove_tests()
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 -2 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 -1 -2 speed_10
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 2 2
@@ -2165,7 +2165,7 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 0 -3 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 -3 0 speed_10
 		chk_join_nr 3 3 3
 		chk_add_nr 3 3
 		chk_rm_nr 3 3 invert
@@ -2178,7 +2178,7 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 0 -3 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 -3 0 speed_10
 		chk_join_nr 1 1 1
 		chk_add_nr 3 3
 		chk_rm_nr 3 1 invert
-- 
2.38.1

