Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848922CB1
	for <mptcp@lists.linux.dev>; Fri,  7 Jan 2022 00:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641514853; x=1673050853;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UwyHRhqCE9vfS2IPGZKp6JoedrSmWlD+chvKutXd8no=;
  b=i9+AA1B5aTMLwILFW0lF3lv2kOD2enE0AO6IjR5KuA9SqIhiKvDR1cy8
   IaJMBzUAw23dYYUv5VP85Ah4Xxp04V778HTUv4tLsCGLptpODwAYjTQfk
   iBIDVV7dGtmVtYZSkZagExUW8vb1TXIfqez1FIWupo06y35Ajw6zQoDFq
   VL5LB0pYuvjDqOXRubridA9uXVhSRB7Mzpx5iBJdu+KDdz9L4iVnnfFw8
   kpp08ruQtBbElz0jeTgkEt0zv2HT+/o7fAUA+oZEcen+ASC5Z3O8Qwopl
   zwIjpSHvxiu8f7ph97m5Vuffmn8QhaFk9bEejDf51g8L8Me8YOyeJFRaJ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="329111056"
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="329111056"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 16:20:37 -0800
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="618508518"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.94.200])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 16:20:36 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 11/13] selftests: mptcp: add tests for subflow creation failure
Date: Thu,  6 Jan 2022 16:20:24 -0800
Message-Id: <20220107002026.375427-12-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107002026.375427-1-mathew.j.martineau@linux.intel.com>
References: <20220107002026.375427-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

Verify that, when multiple endpoints are available, subflows
creation proceed even when the first additional subflow creation
fails - due to packet drop on the relevant link

Co-developed-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 tools/testing/selftests/net/mptcp/config      |  1 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 78 ++++++++++++++++++-
 2 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index d548bc139b5d..d36b7da5082a 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -17,4 +17,5 @@ CONFIG_NFT_TPROXY=m
 CONFIG_NFT_SOCKET=m
 CONFIG_IP_ADVANCED_ROUTER=y
 CONFIG_IP_MULTIPLE_TABLES=y
+CONFIG_IP_NF_TARGET_REJECT=m
 CONFIG_IPV6_MULTIPLE_TABLES=y
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index bbafa4cf5453..3165bd1a43cc 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -937,6 +937,22 @@ chk_link_usage()
 	fi
 }
 
+wait_for_tw()
+{
+	local timeout_ms=$((timeout_poll * 1000))
+	local time=0
+	local ns=$1
+
+	while [ $time -lt $timeout_ms ]; do
+		local cnt=$(ip netns exec $ns ss -t state time-wait |wc -l)
+
+		[ "$cnt" = 1 ] && return 1
+		time=$((time + 100))
+		sleep 0.1
+	done
+	return 1
+}
+
 subflows_tests()
 {
 	reset
@@ -994,6 +1010,61 @@ subflows_tests()
 	chk_join_nr "single subflow, dev" 1 1 1
 }
 
+subflows_error_tests()
+{
+	# If a single subflow is configured, and matches the MPC src
+	# address, no additional subflow should be created
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.1.2 flags subflow
+	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+	chk_join_nr "no MPC reuse with single endpoint" 0 0 0
+
+	# multiple subflows, with subflow creation error
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
+	ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j REJECT
+	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+	chk_join_nr "multi subflows, with failing subflow" 1 1 1
+
+	# multiple subflows, with subflow timeout on MPJ
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
+	ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j DROP
+	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+	chk_join_nr "multi subflows, with subflow timeout" 1 1 1
+
+	# multiple subflows, check that the endpoint corresponding to
+	# closed subflow (due to reset) is not reused if additional
+	# subflows are added later
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j REJECT
+	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow &
+
+	# updates in the child shell do not have any effect here, we
+	# need to bump the test counter for the above case
+	TEST_COUNT=$((TEST_COUNT+1))
+
+	# mpj subflow will be in TW after the reset
+	wait_for_tw $ns2
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
+	wait
+
+	# additional subflow could be created only if the PM select
+	# the later endpoint, skipping the already used one
+	chk_join_nr "multi subflows, fair usage on close" 1 1 1
+}
+
 signal_address_tests()
 {
 	# add_address, unused
@@ -1805,6 +1876,7 @@ fullmesh_tests()
 all_tests()
 {
 	subflows_tests
+	subflows_error_tests
 	signal_address_tests
 	link_failure_tests
 	add_addr_timeout_tests
@@ -1824,6 +1896,7 @@ usage()
 {
 	echo "mptcp_join usage:"
 	echo "  -f subflows_tests"
+	echo "  -e subflows_error_tests"
 	echo "  -s signal_address_tests"
 	echo "  -l link_failure_tests"
 	echo "  -t add_addr_timeout_tests"
@@ -1872,11 +1945,14 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
 
-while getopts 'fsltra64bpkdmchCS' opt; do
+while getopts 'fesltra64bpkdmchCS' opt; do
 	case $opt in
 		f)
 			subflows_tests
 			;;
+		e)
+			subflows_error_tests
+			;;
 		s)
 			signal_address_tests
 			;;
-- 
2.34.1

