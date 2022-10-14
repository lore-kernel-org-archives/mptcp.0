Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10AE361
	for <mptcp@lists.linux.dev>; Fri, 14 Oct 2022 20:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1665779957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Q6OmSOVC32RNR32Jt6veRT/fuAw7gqm8YWkDQIwxhzY=;
	b=P9NH6YA0tezZSYErTnoY5yyzkCm4eRDexm6Q1uju6E6yUxNEyNDxQ1/uJaIQCPGJp1t2BD
	AdYu9em04W8tZLq4Gn9F3zJW7BxhTsQyeBLhPTAA/tpHKg9z+kvkIPciG0Elt73D5m7AV8
	3J9NQBDQbM994mON/hEw1utkpwXLWk0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-YfsJrEq-OAuZBBFdBhXBNQ-1; Fri, 14 Oct 2022 16:39:13 -0400
X-MC-Unique: YfsJrEq-OAuZBBFdBhXBNQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 779128582B9
	for <mptcp@lists.linux.dev>; Fri, 14 Oct 2022 20:39:13 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.6])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B1BCF42479A
	for <mptcp@lists.linux.dev>; Fri, 14 Oct 2022 20:39:12 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [RFC PATCH] selftests: mptcp: set test-case parameters consistently
Date: Fri, 14 Oct 2022 22:39:06 +0200
Message-Id: <2abed554f2050c7626dede74c92a181506a92682.1665779933.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The mptcp_join test-cases depend on several parameters. The caller
provide most of them as command line arguments for the main test
function. That makes the test-cases are do read.

Additionally we sometimes need to add more parameters, which currently
is currently error prone and makes the test-cases even more hard to
follow.

Refactor the infrastructure to pass test-case parameters as enviromental
variables, and update all the existing tests accordingly.

Suggested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 342 +++++++++++-------
 1 file changed, 215 insertions(+), 127 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f3dd5f2a0272..4d1af42cb749 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -35,8 +35,6 @@ TEST_COUNT=0
 TEST_NAME=""
 nr_blank=40
 
-export FAILING_LINKS=""
-
 # generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) == 0x30) ||
 #				  (ip6 && (ip6[74] & 0xf0) == 0x30)'"
 CBPF_MPTCP_SUBOPTION_ADD_ADDR="14,
@@ -80,7 +78,6 @@ init_partial()
 
 	check_invert=0
 	validate_checksum=$checksum
-	FAILING_LINKS=""
 
 	#  ns1         ns2
 	# ns1eth1    ns2eth1
@@ -393,13 +390,13 @@ link_failure()
 {
 	local ns="$1"
 
-	if [ -z "$FAILING_LINKS" ]; then
+	if [ -z "$failing_links" ]; then
 		l=$((RANDOM%4))
-		FAILING_LINKS=$((l+1))
+		failing_links=$((l+1))
 	fi
 
 	local l
-	for l in $FAILING_LINKS; do
+	for l in $failing_links; do
 		local veth="ns1eth$l"
 		ip -net "$ns" link set "$veth" down
 	done
@@ -663,11 +660,6 @@ do_transfer()
 	local cl_proto="$3"
 	local srv_proto="$4"
 	local connect_addr="$5"
-	local test_link_fail="$6"
-	local addr_nr_ns1="$7"
-	local addr_nr_ns2="$8"
-	local speed="$9"
-	local sflags="${10}"
 
 	local port=$((10000 + TEST_COUNT - 1))
 	local cappid
@@ -677,6 +669,12 @@ do_transfer()
 	local evts_ns2
 	local evts_ns2_pid
 
+	link_fail="${link_fail:-0}"
+	file_size="${file_size:-0}"
+	addr_nr_ns1="${addr_nr_ns1:-0}"
+	addr_nr_ns2="${addr_nr_ns2:-0}"
+	speed="${speed:-fast}"
+
 	:> "$cout"
 	:> "$sout"
 	:> "$capout"
@@ -721,30 +719,30 @@ do_transfer()
 	local extra_cl_args=""
 	local extra_srv_args=""
 	local trunc_size=""
-	if [[ "${addr_nr_ns2}" = "fastclose_"* ]]; then
-		if [ ${test_link_fail} -le 1 ]; then
-			echo "fastclose tests need test_link_fail argument"
+	if [[ -n "${fastclose}" ]]; then
+		if [ ${file_size} -eq 0 ]; then
+			echo "fastclose tests need file_size argument"
 			fail_test
 			return 1
 		fi
 
 		# disconnect
-		trunc_size=${test_link_fail}
-		local side=${addr_nr_ns2:10}
+		trunc_size=${file_size}
 
-		if [ ${side} = "client" ]; then
-			extra_cl_args="-f ${test_link_fail}"
+		if [ ${fastclose} = "client" ]; then
+			extra_cl_args="-f ${file_size}"
 			extra_srv_args="-f -1"
-		elif [ ${side} = "server" ]; then
-			extra_srv_args="-f ${test_link_fail}"
+		elif [ ${fastclose} = "server" ]; then
+			extra_srv_args="-f ${file_size}"
 			extra_cl_args="-f -1"
 		else
-			echo "wrong/unknown fastclose spec ${side}"
+			echo "wrong/unknown fastclose spec ${fastclose}"
 			fail_test
 			return 1
 		fi
-		addr_nr_ns2=0
-	elif [[ "${addr_nr_ns2}" = "userspace_"* ]]; then
+	fi
+
+	if [[ "${addr_nr_ns2}" = "userspace_"* ]]; then
 		userspace_pm=1
 		addr_nr_ns2=${addr_nr_ns2:10}
 	elif [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
@@ -770,8 +768,10 @@ do_transfer()
 		local_addr="0.0.0.0"
 	fi
 
+	local used_sin=$sin
 	extra_srv_args="$extra_args $extra_srv_args"
-	if [ "$test_link_fail" -gt 1 ];then
+	if [ "$link_fail" -eq 2 -o "$file_size" -gt 0 ];then
+		used_sin=$sinfail
 		timeout ${timeout_test} \
 			ip netns exec ${listener_ns} \
 				./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
@@ -787,12 +787,14 @@ do_transfer()
 	wait_local_port_listen "${listener_ns}" "${port}"
 
 	extra_cl_args="$extra_args $extra_cl_args"
-	if [ "$test_link_fail" -eq 0 ];then
+	local used_cin=$cinsent
+	if [ "$link_fail" -eq 0 -a "$file_size" -eq 0 ];then
+		used_cin=$cin
 		timeout ${timeout_test} \
 			ip netns exec ${connector_ns} \
 				./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
 					$extra_cl_args $connect_addr < "$cin" > "$cout" &
-	elif [ "$test_link_fail" -eq 1 ] || [ "$test_link_fail" -eq 2 ];then
+	elif [ "$link_fail" -eq 1 ] || [ "$link_fail" -eq 2 ];then
 		( cat "$cinfail" ; sleep 2; link_failure $listener_ns ; cat "$cinfail" ) | \
 			tee "$cinsent" | \
 			timeout ${timeout_test} \
@@ -1005,17 +1007,9 @@ do_transfer()
 		return 1
 	fi
 
-	if [ "$test_link_fail" -gt 1 ];then
-		check_transfer $sinfail $cout "file received by client" $trunc_size
-	else
-		check_transfer $sin $cout "file received by client" $trunc_size
-	fi
+	check_transfer $used_sin $cout "file received by client" $trunc_size
 	retc=$?
-	if [ "$test_link_fail" -eq 0 ];then
-		check_transfer $cin $sout "file received by server" $trunc_size
-	else
-		check_transfer $cinsent $sout "file received by server" $trunc_size
-	fi
+	check_transfer $used_cin $sout "file received by server" $trunc_size
 	rets=$?
 
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ];then
@@ -1024,6 +1018,7 @@ do_transfer()
 	fi
 
 	cat "$capout"
+	fail_test
 	return 1
 }
 
@@ -1044,26 +1039,27 @@ run_tests()
 	local listener_ns="$1"
 	local connector_ns="$2"
 	local connect_addr="$3"
-	local test_linkfail="${4:-0}"
-	local addr_nr_ns1="${5:-0}"
-	local addr_nr_ns2="${6:-0}"
-	local speed="${7:-fast}"
-	local sflags="${8:-""}"
 
 	local size
 
-	# The values above 2 are reused to make test files
-	# with the given sizes (KB)
-	if [ "$test_linkfail" -gt 2 ]; then
-		size=$test_linkfail
+	file_size="${file_size:-0}"
+	link_fail="${link_fail:-0}"
 
+	# create the input file for the failure test when
+	# the first failure test run
+	if [ "$file_size" -gt 0 ]; then
 		if [ -z "$cinfail" ]; then
 			cinfail=$(mktemp)
 		fi
-		make_file "$cinfail" "client" $size
-	# create the input file for the failure test when
-	# the first failure test run
-	elif [ "$test_linkfail" -ne 0 ] && [ -z "$cinfail" ]; then
+		make_file "$cinfail" "client" $file_size
+
+		if [ -z "$sinfail" ]; then
+			sinfail=$(mktemp)
+		fi
+		make_file "$sinfail" "server" $file_size
+	fi
+
+	if [ "$link_fail" -ne 0 ] && [ -z "$cinfail" ]; then
 		# the client file must be considerably larger
 		# of the maximum expected cwin value, or the
 		# link utilization will be not predicable
@@ -1076,14 +1072,7 @@ run_tests()
 		make_file "$cinfail" "client" $size
 	fi
 
-	if [ "$test_linkfail" -gt 2 ]; then
-		size=$test_linkfail
-
-		if [ -z "$sinfail" ]; then
-			sinfail=$(mktemp)
-		fi
-		make_file "$sinfail" "server" $size
-	elif [ "$test_linkfail" -eq 2 ] && [ -z "$sinfail" ]; then
+	if [ "$link_fail" -eq 2 ] && [ -z "$sinfail" ]; then
 		size=$((RANDOM%16))
 		size=$((size+1))
 		size=$((size*2048))
@@ -1092,8 +1081,7 @@ run_tests()
 		make_file "$sinfail" "server" $size
 	fi
 
-	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} \
-		${test_linkfail} ${addr_nr_ns1} ${addr_nr_ns2} ${speed} ${sflags}
+	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr}
 }
 
 dump_stats()
@@ -1828,7 +1816,7 @@ subflows_error_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		speed=slow run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
 	fi
 
@@ -1839,7 +1827,7 @@ subflows_error_tests()
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 		filter_tcp_from $ns1 10.0.3.2 REJECT
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		speed=slow run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 	fi
 
@@ -1850,7 +1838,7 @@ subflows_error_tests()
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 		filter_tcp_from $ns1 10.0.3.2 DROP
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		speed=slow run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 	fi
 
@@ -1862,7 +1850,7 @@ subflows_error_tests()
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		filter_tcp_from $ns1 10.0.3.2 REJECT
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow &
+		speed=slow run_tests $ns1 $ns2 10.0.1.1 &
 
 		# mpj subflow will be in TW after the reset
 		wait_attempt_fail $ns2
@@ -1960,7 +1948,7 @@ signal_address_tests()
 
 		# the peer could possibly miss some addr notification, allow retransmission
 		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		speed=slow run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 3 3 3
 
 		# the server will not signal the address terminating
@@ -1985,7 +1973,7 @@ link_failure_tests()
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 dev ns2eth4 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 1
+		link_fail=1 run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_stale_nr $ns2 1 5 1
@@ -2000,7 +1988,7 @@ link_failure_tests()
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 dev ns2eth4 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 2
+		link_fail=2 run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_stale_nr $ns2 1 -1 1
@@ -2013,9 +2001,10 @@ link_failure_tests()
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
 		pm_nl_set_limits $ns2 1 2
-		FAILING_LINKS="1"
 		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 1
+		failing_links="1"	\
+		link_fail=1		\
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_link_usage $ns2 ns2eth3 $cinsent 0
@@ -2029,8 +2018,9 @@ link_failure_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
 		pm_nl_set_limits $ns2 1 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
-		FAILING_LINKS="1 2"
-		run_tests $ns1 $ns2 10.0.1.1 1
+		failing_links="1 2"	\
+		link_fail=1		\
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_stale_nr $ns2 2 4 2
@@ -2045,8 +2035,9 @@ link_failure_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
-		FAILING_LINKS="1 2"
-		run_tests $ns1 $ns2 10.0.1.1 2
+		failing_links="1 2"	\
+		link_fail=2		\
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_stale_nr $ns2 1 -1 2
@@ -2061,7 +2052,7 @@ add_addr_timeout_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		speed=slow run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_add_nr 4 0
 	fi
@@ -2071,7 +2062,7 @@ add_addr_timeout_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
+		speed=slow run_tests $ns1 $ns2 dead:beef:1::1
 		chk_join_nr 1 1 1
 		chk_add_nr 4 0
 	fi
@@ -2082,7 +2073,7 @@ add_addr_timeout_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_set_limits $ns2 2 2
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10
+		speed=speed_10 run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
 		chk_add_nr 8 0
 	fi
@@ -2093,7 +2084,7 @@ add_addr_timeout_tests()
 		pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_set_limits $ns2 2 2
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10
+		speed=speed_10 run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_add_nr 8 0
 	fi
@@ -2106,7 +2097,9 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
+		speed=slow		\
+		addr_nr_ns2=-1		\
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_rm_nr 1 1
 	fi
@@ -2117,7 +2110,9 @@ remove_tests()
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 -2 slow
+		speed=slow		\
+		addr_nr_ns2=-2		\
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
 		chk_rm_nr 2 2
 	fi
@@ -2127,7 +2122,9 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
+		speed=slow		\
+		addr_nr_ns1=-1		\
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
@@ -2139,7 +2136,10 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 -1 slow
+		speed=slow		\
+		addr_nr_ns1=-1		\
+		addr_nr_ns2=-1		\
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_rm_nr 1 1
@@ -2152,7 +2152,10 @@ remove_tests()
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 -2 slow
+		speed=slow		\
+		addr_nr_ns1=-1		\
+		addr_nr_ns2=-2		\
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 2 2
@@ -2165,7 +2168,9 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 0 -3 0 slow
+		speed=slow		\
+		addr_nr_ns1=-3		\
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 3 3 3
 		chk_add_nr 3 3
 		chk_rm_nr 3 3 invert
@@ -2178,7 +2183,9 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 0 -3 0 slow
+		speed=slow		\
+		addr_nr_ns1=-3		\
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_add_nr 3 3
 		chk_rm_nr 3 1 invert
@@ -2191,7 +2198,10 @@ remove_tests()
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
+		speed=slow		\
+		addr_nr_ns1=-8		\
+		addr_nr_ns2=-8		\
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 1 3 invert simult
@@ -2204,7 +2214,10 @@ remove_tests()
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow id 150
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
+		speed=slow		\
+		addr_nr_ns1=-8		\
+		addr_nr_ns2=-8		\
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 3 3 3
 		chk_rm_nr 0 3 simult
 	fi
@@ -2216,7 +2229,10 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
+		speed=slow		\
+		addr_nr_ns1=-8		\
+		addr_nr_ns2=-8		\
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 3 3 3
 		chk_add_nr 3 3
 		chk_rm_nr 3 3 invert simult
@@ -2229,7 +2245,9 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 0 -8 0 slow
+		speed=slow		\
+		addr_nr_ns1=-8		\
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_add_nr 3 3
 		chk_rm_nr 3 1 invert
@@ -2240,7 +2258,9 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 -9 slow
+		speed=slow		\
+		addr_nr_ns2=-9		\
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_rm_nr 1 1
 	fi
@@ -2250,7 +2270,9 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 -9 0 slow
+		speed=slow		\
+		addr_nr_ns1=-9		\
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
@@ -2263,7 +2285,9 @@ add_tests()
 	if reset "add single subflow"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow
+		speed=slow		\
+		addr_nr_ns2=1		\
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 	fi
 
@@ -2271,7 +2295,9 @@ add_tests()
 	if reset "add signal address"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
+		speed=slow		\
+		addr_nr_ns1=1		\
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 	fi
@@ -2280,7 +2306,9 @@ add_tests()
 	if reset "add multiple subflows"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
-		run_tests $ns1 $ns2 10.0.1.1 0 0 2 slow
+		speed=slow		\
+		addr_nr_ns2=2		\
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
 	fi
 
@@ -2288,7 +2316,9 @@ add_tests()
 	if reset "add multiple subflows IPv6"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 2 slow
+		speed=slow		\
+		addr_nr_ns2=2		\
+			run_tests $ns1 $ns2 dead:beef:1::1
 		chk_join_nr 2 2 2
 	fi
 
@@ -2296,7 +2326,9 @@ add_tests()
 	if reset "add multiple addresses IPv6"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 2 2
-		run_tests $ns1 $ns2 dead:beef:1::1 0 2 0 slow
+		speed=slow		\
+		addr_nr_ns1=2		\
+			run_tests $ns1 $ns2 dead:beef:1::1
 		chk_join_nr 2 2 2
 		chk_add_nr 2 2
 	fi
@@ -2309,14 +2341,14 @@ ipv6_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 dead:beef:3::2 dev ns2eth3 flags subflow
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
+		speed=slow run_tests $ns1 $ns2 dead:beef:1::1
 		chk_join_nr 1 1 1
 	fi
 
 	# add_address, unused IPv6
 	if reset "unused signal address IPv6"; then
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
+		speed=slow run_tests $ns1 $ns2 dead:beef:1::1
 		chk_join_nr 0 0 0
 		chk_add_nr 1 1
 	fi
@@ -2326,7 +2358,7 @@ ipv6_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
+		speed=slow run_tests $ns1 $ns2 dead:beef:1::1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 	fi
@@ -2336,7 +2368,9 @@ ipv6_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 dead:beef:1::1 0 -1 0 slow
+		speed=slow		\
+		addr_nr_ns1=-1		\
+			run_tests $ns1 $ns2 dead:beef:1::1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
@@ -2348,7 +2382,10 @@ ipv6_tests()
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 		pm_nl_set_limits $ns2 1 2
 		pm_nl_add_endpoint $ns2 dead:beef:3::2 dev ns2eth3 flags subflow
-		run_tests $ns1 $ns2 dead:beef:1::1 0 -1 -1 slow
+		speed=slow		\
+		addr_nr_ns1=-1		\
+		addr_nr_ns2=-1		\
+			run_tests $ns1 $ns2 dead:beef:1::1
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_rm_nr 1 1
@@ -2449,7 +2486,9 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup
+		speed=slow		\
+		sflags=nobackup		\
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_prio_nr 0 1
 	fi
@@ -2459,7 +2498,9 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		speed=slow		\
+		sflags=backup		\
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_prio_nr 1 1
@@ -2470,7 +2511,9 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		speed=slow		\
+		sflags=backup		\
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_prio_nr 1 1
@@ -2478,7 +2521,7 @@ backup_tests()
 
 	if reset "mpc backup"; then
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		speed=slow run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
 		chk_prio_nr 0 1
 	fi
@@ -2486,14 +2529,16 @@ backup_tests()
 	if reset "mpc backup both sides"; then
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow,backup
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		speed=slow run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
 		chk_prio_nr 1 1
 	fi
 
 	if reset "mpc switch to backup"; then
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		speed=slow		\
+		sflags=backup		\
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
 		chk_prio_nr 0 1
 	fi
@@ -2501,7 +2546,9 @@ backup_tests()
 	if reset "mpc switch to backup both sides"; then
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		speed=slow		\
+		sflags=backup		\
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
 		chk_prio_nr 1 1
 	fi
@@ -2535,7 +2582,9 @@ add_addr_ports_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
+		speed=slow		\
+		addr_nr_ns1=-1		\
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1 1
 		chk_rm_nr 1 1 invert
@@ -2547,7 +2596,10 @@ add_addr_ports_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 -1 slow
+		speed=slow		\
+		addr_nr_ns1=-1		\
+		addr_nr_ns2=-1		\
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1 1
 		chk_rm_nr 1 1
@@ -2560,7 +2612,10 @@ add_addr_ports_tests()
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -8 -2 slow
+		speed=slow		\
+		addr_nr_ns1=-8		\
+		addr_nr_ns2=-2		\
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 1 3 invert simult
@@ -2762,7 +2817,9 @@ fullmesh_tests()
 		pm_nl_set_limits $ns2 1 4
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,fullmesh
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,fullmesh
-		run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
+		speed=slow		\
+		addr_nr_ns1=1		\
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 4 4 4
 		chk_add_nr 1 1
 	fi
@@ -2774,7 +2831,9 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 1 3
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_1 slow
+		speed=slow		\
+		addr_nr_ns2=fullmesh_1	\
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 	fi
@@ -2786,7 +2845,9 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 2 5
 		pm_nl_set_limits $ns2 1 5
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
+		speed=slow		\
+		addr_nr_ns2=fullmesh_2	\
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 5 5 5
 		chk_add_nr 1 1
 	fi
@@ -2799,7 +2860,9 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 2 4
 		pm_nl_set_limits $ns2 1 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
+		speed=slow		\
+		addr_nr_ns2=fullmesh_2	\
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 4 4 4
 		chk_add_nr 1 1
 	fi
@@ -2809,7 +2872,10 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
 		pm_nl_set_limits $ns2 4 4
-		run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow fullmesh
+		speed=slow		\
+		addr_nr_ns2=1		\
+		sflags=fullmesh		\
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
 		chk_rm_nr 0 1
 	fi
@@ -2819,7 +2885,10 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow,fullmesh
 		pm_nl_set_limits $ns2 4 4
-		run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_1 slow nofullmesh
+		speed=slow		\
+		addr_nr_ns2=fullmesh_1	\
+		sflags=nofullmesh	\
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
 		chk_rm_nr 0 1
 	fi
@@ -2829,7 +2898,10 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
 		pm_nl_set_limits $ns2 4 4
-		run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow backup,fullmesh
+		speed=slow		\
+		addr_nr_ns2=1		\
+		sflags=backup,fullmesh	\
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
 		chk_prio_nr 0 1
 		chk_rm_nr 0 1
@@ -2840,7 +2912,9 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_set_limits $ns2 4 4
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,backup,fullmesh
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup,nofullmesh
+		speed=slow			\
+		sflags=nobackup,nofullmesh	\
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
 		chk_prio_nr 0 1
 		chk_rm_nr 0 1
@@ -2850,14 +2924,18 @@ fullmesh_tests()
 fastclose_tests()
 {
 	if reset "fastclose test"; then
-		run_tests $ns1 $ns2 10.0.1.1 1024 0 fastclose_client
+		file_size=1024		\
+		fastclose=client	\
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1
 		chk_rst_nr 1 1 invert
 	fi
 
 	if reset "fastclose server test"; then
-		run_tests $ns1 $ns2 10.0.1.1 1024 0 fastclose_server
+		file_size=1024		\
+		fastclose=server	\
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1 invert
 		chk_rst_nr 1 1
@@ -2875,7 +2953,7 @@ fail_tests()
 {
 	# single subflow
 	if reset_with_fail "Infinite map" 1; then
-		run_tests $ns1 $ns2 10.0.1.1 128
+		file_size=128 run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0 +1 +0 1 0 1 "$(pedit_action_pkts)"
 		chk_fail_nr 1 -1 invert
 	fi
@@ -2886,7 +2964,7 @@ fail_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 1024
+		file_size=1024 run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1 1 0 1 1 0 "$(pedit_action_pkts)"
 	fi
 }
@@ -2941,7 +3019,9 @@ userspace_tests()
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		speed=slow		\
+		sflags=backup		\
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 0
 		chk_prio_nr 0 0
 	fi
@@ -2953,7 +3033,9 @@ userspace_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
+		speed=slow		\
+		addr_nr_ns2=-1		\
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
 		chk_rm_nr 0 0
 	fi
@@ -2962,7 +3044,9 @@ userspace_tests()
 	if reset "userspace pm add & remove address"; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 userspace_1 0 slow
+		speed=slow		\
+		addr_nr_ns1=userspace_1	\
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
@@ -2972,7 +3056,9 @@ userspace_tests()
 	if reset "userspace pm create destroy subflow"; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 userspace_1 slow
+		speed=slow		\
+		addr_nr_ns2=userspace_1	\
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_rm_nr 0 1
 	fi
@@ -2985,7 +3071,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns1 2 2
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow &
+		speed=slow run_tests $ns1 $ns2 10.0.1.1 &
 
 		wait_mpj $ns1
 		pm_nl_check_endpoint 1 "creation" \
@@ -3005,7 +3091,9 @@ endpoint_tests()
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 4 0 0 slow &
+		speed=slow		\
+		file_size=4		\
+			run_tests $ns1 $ns2 10.0.1.1 &
 
 		wait_mpj $ns2
 		pm_nl_del_endpoint $ns2 2 10.0.2.2
-- 
2.37.3

