Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F28642BA
	for <mptcp@lists.linux.dev>; Fri,  4 Mar 2022 19:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646422608; x=1677958608;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qpWcgTy9FY6xxmHVlOf7EsIb68lZRNZlVMoMSI/G4m8=;
  b=My2PKxV0IhDyVQQum+lsz50oe8Ni6Uz4dwVXjnoG09Wu+rSFn7ynZ3uM
   stDWrn4D+W0uImgtSBbhm1eXG4s6rV4CYSKiAYv7vMhXZjoH0n0xsf/Ob
   NxXnyBrK0IL9bGgD3cg+TcBypX4izMoVYrwy9uFrxU+yUlGN3C8VLIWkB
   qXXCRutw7cUc7u4kJY3UDa/tCkLI3+LKxq5Kcz/6B2qOZGptJnorP5uVU
   VN3dEn/wt6+WxxnuHhYZTMGGEb6aM98puBMPrV4gb0T5jWZUc6zIArljP
   1kYGVGZWwfKimkXOOQ9xnJlx+uwG1e7M0MHYG46s23+9qvzxBdwail45b
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10276"; a="278739508"
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="278739508"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 11:36:43 -0800
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="552340790"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.225.124])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 11:36:43 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 07/11] selftests: mptcp: reuse linkfail to make given size files
Date: Fri,  4 Mar 2022 11:36:32 -0800
Message-Id: <20220304193636.219315-8-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304193636.219315-1-mathew.j.martineau@linux.intel.com>
References: <20220304193636.219315-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

This patch reused the test_linkfail values above 2 to make test files with
the given sizes (KB) for both the client side and the server side. It's
useful for the test cases using different file sizes.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 32 ++++++++++++++++---
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 84c21282ee46..1fda29d5d69f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -459,7 +459,7 @@ do_transfer()
 		local_addr="0.0.0.0"
 	fi
 
-	if [ "$test_link_fail" -eq 2 ];then
+	if [ "$test_link_fail" -gt 1 ];then
 		timeout ${timeout_test} \
 			ip netns exec ${listener_ns} \
 				./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
@@ -479,13 +479,19 @@ do_transfer()
 			ip netns exec ${connector_ns} \
 				./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
 					$extra_args $connect_addr < "$cin" > "$cout" &
-	else
+	elif [ "$test_link_fail" -eq 1 ] || [ "$test_link_fail" -eq 2 ];then
 		( cat "$cinfail" ; sleep 2; link_failure $listener_ns ; cat "$cinfail" ) | \
 			tee "$cinsent" | \
 			timeout ${timeout_test} \
 				ip netns exec ${connector_ns} \
 					./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
 						$extra_args $connect_addr > "$cout" &
+	else
+		cat "$cinfail" | tee "$cinsent" | \
+			timeout ${timeout_test} \
+				ip netns exec ${connector_ns} \
+					./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
+						$extra_args $connect_addr > "$cout" &
 	fi
 	cpid=$!
 
@@ -645,7 +651,7 @@ do_transfer()
 		return 1
 	fi
 
-	if [ "$test_link_fail" -eq 2 ];then
+	if [ "$test_link_fail" -gt 1 ];then
 		check_transfer $sinfail $cout "file received by client"
 	else
 		check_transfer $sin $cout "file received by client"
@@ -690,9 +696,18 @@ run_tests()
 	speed="${7:-fast}"
 	sflags="${8:-""}"
 
+	# The values above 2 are reused to make test files
+	# with the given sizes (KB)
+	if [ "$test_linkfail" -gt 2 ]; then
+		size=$test_linkfail
+
+		if [ -z "$cinfail" ]; then
+			cinfail=$(mktemp)
+		fi
+		make_file "$cinfail" "client" $size
 	# create the input file for the failure test when
 	# the first failure test run
-	if [ "$test_linkfail" -ne 0 -a -z "$cinfail" ]; then
+	elif [ "$test_linkfail" -ne 0 -a -z "$cinfail" ]; then
 		# the client file must be considerably larger
 		# of the maximum expected cwin value, or the
 		# link utilization will be not predicable
@@ -705,7 +720,14 @@ run_tests()
 		make_file "$cinfail" "client" $size
 	fi
 
-	if [ "$test_linkfail" -eq 2 -a -z "$sinfail" ]; then
+	if [ "$test_linkfail" -gt 2 ]; then
+		size=$test_linkfail
+
+		if [ -z "$sinfail" ]; then
+			sinfail=$(mktemp)
+		fi
+		make_file "$sinfail" "server" $size
+	elif [ "$test_linkfail" -eq 2 -a -z "$sinfail" ]; then
 		size=$((RANDOM%16))
 		size=$((size+1))
 		size=$((size*2048))
-- 
2.35.1

