Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCA77C
	for <mptcp@lists.linux.dev>; Fri,  4 Mar 2022 19:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646422607; x=1677958607;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1/uBy4xIN/f39gpA+6947idem3xzKvCmx+kAxXLkkUY=;
  b=YpTEJKp1XFn9PYWF2C10ZNSizcEJJ0Ee0kq563rgC7ZV0FMwGRF45xDy
   NUxdahQL4C0H/WK/5gqnze5sHHSO/P9CRjqdUOmuIP7dYS6Q2zDZJp++C
   fmbb91HzXT+j6dtLjuyC31mhnn4TKdxX6Ff2bgnoDpsXrHn1uDHEvOGro
   OvbTy6yATxFEFXQZSa25lzhavGKmtryFRXOvG8ZqKYi4rJ8DZVYCfYeM1
   L2g4oZa1Ja48BDW4gs0rToNMDypkov81pIHeOprMTQS9Q0T0R6mcMFgEB
   oOVFey9B5pFnGo98FqbgS1RLy+iKlMCC2iVrHZyrsPva4SH1vdOFufnaS
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10276"; a="278739507"
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="278739507"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 11:36:43 -0800
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="552340789"
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
Subject: [PATCH net-next 06/11] selftests: mptcp: add extra_args in do_transfer
Date: Fri,  4 Mar 2022 11:36:31 -0800
Message-Id: <20220304193636.219315-7-mathew.j.martineau@linux.intel.com>
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

Instead of using a global variable mptcp_connect, this patch added
a new local variable extra_args in do_transfer() to store the extra
arguments passing to the mptcp_connect commands.

This patch also renamed the speed level 'least' to 'speed_*'. This
more flexible way can avoid the need to add new speed levels in the
future.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 12008640d9f4..84c21282ee46 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -12,7 +12,6 @@ cout=""
 ksft_skip=4
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
-mptcp_connect=""
 capture=0
 checksum=0
 ip_mptcp=0
@@ -444,12 +443,13 @@ do_transfer()
 	NSTAT_HISTORY=/tmp/${connector_ns}.nstat ip netns exec ${connector_ns} \
 		nstat -n
 
+	local extra_args
 	if [ $speed = "fast" ]; then
-		mptcp_connect="./mptcp_connect -j"
+		extra_args="-j"
 	elif [ $speed = "slow" ]; then
-		mptcp_connect="./mptcp_connect -r 50"
-	elif [ $speed = "least" ]; then
-		mptcp_connect="./mptcp_connect -r 10"
+		extra_args="-r 50"
+	elif [[ $speed = "speed_"* ]]; then
+		extra_args="-r ${speed:6}"
 	fi
 
 	local local_addr
@@ -462,13 +462,13 @@ do_transfer()
 	if [ "$test_link_fail" -eq 2 ];then
 		timeout ${timeout_test} \
 			ip netns exec ${listener_ns} \
-				$mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
-					${local_addr} < "$sinfail" > "$sout" &
+				./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
+					$extra_args ${local_addr} < "$sinfail" > "$sout" &
 	else
 		timeout ${timeout_test} \
 			ip netns exec ${listener_ns} \
-				$mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
-					${local_addr} < "$sin" > "$sout" &
+				./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
+					$extra_args ${local_addr} < "$sin" > "$sout" &
 	fi
 	spid=$!
 
@@ -477,15 +477,15 @@ do_transfer()
 	if [ "$test_link_fail" -eq 0 ];then
 		timeout ${timeout_test} \
 			ip netns exec ${connector_ns} \
-				$mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
-					$connect_addr < "$cin" > "$cout" &
+				./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
+					$extra_args $connect_addr < "$cin" > "$cout" &
 	else
 		( cat "$cinfail" ; sleep 2; link_failure $listener_ns ; cat "$cinfail" ) | \
 			tee "$cinsent" | \
 			timeout ${timeout_test} \
 				ip netns exec ${connector_ns} \
-					$mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
-						$connect_addr > "$cout" &
+					./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
+						$extra_args $connect_addr > "$cout" &
 	fi
 	cpid=$!
 
@@ -1507,7 +1507,7 @@ add_addr_timeout_tests()
 	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 	pm_nl_set_limits $ns2 2 2
-	run_tests $ns1 $ns2 10.0.1.1 0 0 0 least
+	run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10
 	chk_join_nr "signal addresses, ADD_ADDR timeout" 2 2 2
 	chk_add_nr 8 0
 
@@ -1517,7 +1517,7 @@ add_addr_timeout_tests()
 	pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
 	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 	pm_nl_set_limits $ns2 2 2
-	run_tests $ns1 $ns2 10.0.1.1 0 0 0 least
+	run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10
 	chk_join_nr "invalid address, ADD_ADDR timeout" 1 1 1
 	chk_add_nr 8 0
 }
-- 
2.35.1

