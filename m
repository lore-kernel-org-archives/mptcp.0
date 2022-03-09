Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3775117
	for <mptcp@lists.linux.dev>; Wed,  9 Mar 2022 19:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646853408; x=1678389408;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KjwpKHKPk6DxsM4E4JAU6Iqx3U6k1OqYhwwTVEAH2c4=;
  b=egABPi+9MyhatTBfKaq4Ktfz28TeJqIyy2OG9dPwIzi/NrAnLog4Jcr0
   N3lvWXBDgsjuLTxAS7t+gUIEyIUzAptQXOC25qY63YVJgEQxEsDI50vZB
   pjc2f0tdgblOQ9ZY+iE6S25p9hPdOs1tFSdUU8ialozQw50A1stm0BcuN
   mhoNB++blutjDklAzjrXicm5CtQhbikSwx+Xrbptc6W8jEPOXIxsiiL3k
   ynpBr40wwMLDJL1pxham6TDqk/6rqiqM6vVmxMKmuuYO05PZGkAojzz4Q
   OpzpTPXyYd0k8hcJ/gALyuJcdGTlJDFnRVSruCUN4lsnU7ull2axJ4Ggp
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="255011971"
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; 
   d="scan'208";a="255011971"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 11:16:46 -0800
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; 
   d="scan'208";a="495957052"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.194.198])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 11:16:45 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 01/10] selftests: mptcp: drop msg argument of chk_csum_nr
Date: Wed,  9 Mar 2022 11:16:27 -0800
Message-Id: <20220309191636.258232-2-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220309191636.258232-1-mathew.j.martineau@linux.intel.com>
References: <20220309191636.258232-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

This patch dropped the msg argument of chk_csum_nr, to unify chk_csum_nr
with other chk_*_nr functions.

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 26 +++++++++----------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ee435948d130..194c4420220e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -16,6 +16,7 @@ capture=0
 checksum=0
 ip_mptcp=0
 check_invert=0
+validate_checksum=0
 init=0
 
 TEST_COUNT=0
@@ -60,6 +61,7 @@ init_partial()
 	done
 
 	check_invert=0
+	validate_checksum=$checksum
 
 	#  ns1              ns2
 	# ns1eth1    ns2eth1
@@ -192,6 +194,8 @@ reset_with_checksum()
 
 	ip netns exec $ns1 sysctl -q net.mptcp.checksum_enabled=$ns1_enable
 	ip netns exec $ns2 sysctl -q net.mptcp.checksum_enabled=$ns2_enable
+
+	validate_checksum=1
 }
 
 reset_with_allow_join_id0()
@@ -853,9 +857,8 @@ dump_stats()
 
 chk_csum_nr()
 {
-	local msg=${1:-""}
-	local csum_ns1=${2:-0}
-	local csum_ns2=${3:-0}
+	local csum_ns1=${1:-0}
+	local csum_ns2=${2:-0}
 	local count
 	local dump_stats
 	local allow_multi_errors_ns1=0
@@ -870,12 +873,7 @@ chk_csum_nr()
 		csum_ns2=${csum_ns2:1}
 	fi
 
-	if [ ! -z "$msg" ]; then
-		printf "%03u" "$TEST_COUNT"
-	else
-		echo -n "   "
-	fi
-	printf " %-36s %s" "$msg" "sum"
+	printf "%-${nr_blank}s %s" " " "sum"
 	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}'`
 	[ -z "$count" ] && count=0
 	if [ "$count" != $csum_ns1 -a $allow_multi_errors_ns1 -eq 0 ] ||
@@ -1064,7 +1062,7 @@ chk_join_nr()
 	fi
 	[ "${dump_stats}" = 1 ] && dump_stats
 	if [ $checksum -eq 1 ]; then
-		chk_csum_nr "" $csum_ns1 $csum_ns2
+		chk_csum_nr $csum_ns1 $csum_ns2
 		chk_fail_nr $fail_nr $fail_nr
 		chk_rst_nr $rst_nr $rst_nr
 	fi
@@ -2181,28 +2179,28 @@ checksum_tests()
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 0 1
 	run_tests $ns1 $ns2 10.0.1.1
-	chk_csum_nr "checksum test 0 0"
+	chk_join_nr "checksum test 0 0" 0 0 0
 
 	# checksum test 1 1
 	reset_with_checksum 1 1
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 0 1
 	run_tests $ns1 $ns2 10.0.1.1
-	chk_csum_nr "checksum test 1 1"
+	chk_join_nr "checksum test 1 1" 0 0 0
 
 	# checksum test 0 1
 	reset_with_checksum 0 1
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 0 1
 	run_tests $ns1 $ns2 10.0.1.1
-	chk_csum_nr "checksum test 0 1"
+	chk_join_nr "checksum test 0 1" 0 0 0
 
 	# checksum test 1 0
 	reset_with_checksum 1 0
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 0 1
 	run_tests $ns1 $ns2 10.0.1.1
-	chk_csum_nr "checksum test 1 0"
+	chk_join_nr "checksum test 1 0" 0 0 0
 }
 
 deny_join_id0_tests()
-- 
2.35.1

