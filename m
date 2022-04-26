Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36E633DC
	for <mptcp@lists.linux.dev>; Tue, 26 Apr 2022 21:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651010248; x=1682546248;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h1mVzQU2WcuajxA3wv/PeAoW8RekmBvFh10Ws+eVVTo=;
  b=GXHBB2BhW6IPSV2AUuhPMjhV4XWnE9yOXDcCqJT/SxIK4Nx1vGwgkoBL
   M4aQeb1qrGKd6iNKGCQWOpqMgfN5Ddu02J3wKUqVgMoTI6pve7hTNWtfz
   xUaV5DkL3J3YJu60znX9SVFKFOGcw02PFkA+mmoU5sRxK+XU9kBAEiAjj
   7wK29BH0E3ARMsbHvH33BsYKbc+vP8zyyWm4odmew/zBRjUISDifJ+CXW
   lQdOpM8wJbNVaDQ0xUhrdggk6n+3/Fc9CpXL6rBmXppvOD4Pu4BoiFVrH
   ACrFK8jwe6FapJQBxns0597UxU0CCzhLoAzIyKPHyOiP3Juw2kGAOPu2g
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="326222721"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="326222721"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 14:57:23 -0700
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="532878100"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.10.176])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 14:57:23 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 6/7] selftests: mptcp: check MP_FAIL response mibs
Date: Tue, 26 Apr 2022 14:57:16 -0700
Message-Id: <20220426215717.129506-7-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220426215717.129506-1-mathew.j.martineau@linux.intel.com>
References: <20220426215717.129506-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

This patch extends chk_fail_nr to check the MP_FAIL response mibs.

Add a new argument invert for chk_fail_nr to allow it can check the
MP_FAIL TX and RX mibs from the opposite direction.

When the infinite map is received before the MP_FAIL response, the
response will be lost. A '-' can be added into fail_tx or fail_rx to
represent that MP_FAIL response TX or RX can be lost when doing the
checks.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 38 +++++++++++++++++--
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 34152a50a3e2..8023c0773d95 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1054,13 +1054,38 @@ chk_fail_nr()
 {
 	local fail_tx=$1
 	local fail_rx=$2
+	local ns_invert=${3:-""}
 	local count
 	local dump_stats
+	local ns_tx=$ns1
+	local ns_rx=$ns2
+	local extra_msg=""
+	local allow_tx_lost=0
+	local allow_rx_lost=0
+
+	if [[ $ns_invert = "invert" ]]; then
+		ns_tx=$ns2
+		ns_rx=$ns1
+		extra_msg=" invert"
+	fi
+
+	if [[ "${fail_tx}" = "-"* ]]; then
+		allow_tx_lost=1
+		fail_tx=${fail_tx:1}
+	fi
+	if [[ "${fail_rx}" = "-"* ]]; then
+		allow_rx_lost=1
+		fail_rx=${fail_rx:1}
+	fi
 
 	printf "%-${nr_blank}s %s" " " "ftx"
-	count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPFailTx | awk '{print $2}')
+	count=$(ip netns exec $ns_tx nstat -as | grep MPTcpExtMPFailTx | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$fail_tx" ]; then
+		extra_msg="$extra_msg,tx=$count"
+	fi
+	if { [ "$count" != "$fail_tx" ] && [ $allow_tx_lost -eq 0 ]; } ||
+	   { [ "$count" -gt "$fail_tx" ] && [ $allow_tx_lost -eq 1 ]; }; then
 		echo "[fail] got $count MP_FAIL[s] TX expected $fail_tx"
 		fail_test
 		dump_stats=1
@@ -1069,17 +1094,23 @@ chk_fail_nr()
 	fi
 
 	echo -n " - failrx"
-	count=$(ip netns exec $ns2 nstat -as | grep MPTcpExtMPFailRx | awk '{print $2}')
+	count=$(ip netns exec $ns_rx nstat -as | grep MPTcpExtMPFailRx | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$fail_rx" ]; then
+		extra_msg="$extra_msg,rx=$count"
+	fi
+	if { [ "$count" != "$fail_rx" ] && [ $allow_rx_lost -eq 0 ]; } ||
+	   { [ "$count" -gt "$fail_rx" ] && [ $allow_rx_lost -eq 1 ]; }; then
 		echo "[fail] got $count MP_FAIL[s] RX expected $fail_rx"
 		fail_test
 		dump_stats=1
 	else
-		echo "[ ok ]"
+		echo -n "[ ok ]"
 	fi
 
 	[ "${dump_stats}" = 1 ] && dump_stats
+
+	echo "$extra_msg"
 }
 
 chk_fclose_nr()
@@ -2654,6 +2685,7 @@ fail_tests()
 	if reset_with_fail "Infinite map" 1; then
 		run_tests $ns1 $ns2 10.0.1.1 128
 		chk_join_nr 0 0 0 +1 +0 1 0 1 "$(pedit_action_pkts)"
+		chk_fail_nr 1 -1 invert
 	fi
 }
 
-- 
2.36.0

