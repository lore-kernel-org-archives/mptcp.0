Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1668D15E89
	for <mptcp@lists.linux.dev>; Tue,  5 Dec 2023 07:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Rz8jO197"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701759817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N0g3PLWAVYL817HRUbQFSci936+suGjRFRQPPgkxZ04=;
	b=Rz8jO197Q+8EunSv82FIKL2Gf3pCNiicsOq0qUY72NimnKPT488SrC8w2MYnqBqGL+Kjcq
	zsvRvK11Im5QfO4y9S5BaEXkT4WKzLdqzW7TQ1WwjATtMU86QkVC7nhwGIhOVOt3fkg8zh
	qOcv+sWzbygXIV3VQp0DBGQ+cRlUJxU=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v5 18/33] selftests: mptcp: connect: print out test counter
Date: Tue,  5 Dec 2023 15:01:05 +0800
Message-Id: <4aef05b71603926f73624d2b2771c3a1fab2cf9f.1701759405.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1701759405.git.geliang.tang@linux.dev>
References: <cover.1701759405.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch prints out TEST_COUNT for every tests in mptcp_connect.sh.
The output looks like:

 01 New MPTCP socket can be blocked via sysctl                      [ OK ]
 INFO: validating network environment with pings
 02 ping tests                                                      [ OK ]
 INFO: Using loss of 0.16% delay 25 ms reorder .. with delay 6ms on ns3eth4
 03 ns1 MPTCP -> ns1 (10.0.1.1:10000      ) MPTCP  (duration 116ms) [ OK ]
 04 ns1 MPTCP -> ns1 (10.0.1.1:10001      ) TCP    (duration  33ms) [ OK ]
 05 ns1 TCP   -> ns1 (10.0.1.1:10002      ) MPTCP  (duration  25ms) [ OK ]
 06 ns1 MPTCP -> ns1 (dead:beef:1::1:10003) MPTCP  (duration 128ms) [ OK ]
 07 ns1 MPTCP -> ns1 (dead:beef:1::1:10004) TCP    (duration  31ms) [ OK ]

Having test counters helps to quickly identify issues when looking at a
long list of output logs and results.

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 .../selftests/net/mptcp/mptcp_connect.sh      | 22 ++++++++++++++-----
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 8e28e9859415..011980ec6b6f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -264,7 +264,7 @@ check_mptcp_disabled()
 		return 1
 	fi
 
-	echo -n -e "New MPTCP socket can be blocked via sysctl\t\t"
+	echo -n -e "0${TEST_COUNT} New MPTCP socket can be blocked via sysctl\t\t"
 	mptcp_lib_print_ok "\t\t   [ OK ]"
 	mptcp_lib_result_pass "New MPTCP socket can be blocked via sysctl"
 	return 0
@@ -334,7 +334,8 @@ do_transfer()
 	local addr_port
 	addr_port=$(printf "%s:%d" ${connect_addr} ${port})
 	local result_msg
-	result_msg="$(printf "%.3s %-5s -> %.3s (%-20s) %-5s" ${connector_ns} ${cl_proto} ${listener_ns} ${addr_port} ${srv_proto})"
+	result_msg="$(printf "%02u %.3s %-5s -> %.3s (%-20s) %-5s" \
+		${TEST_COUNT} ${connector_ns} ${cl_proto} ${listener_ns} ${addr_port} ${srv_proto})"
 	printf "%s\t" "${result_msg}"
 
 	if $capture; then
@@ -638,7 +639,8 @@ run_test_transparent()
 	# following function has been exported (T). Not great but better than
 	# checking for a specific kernel version.
 	if ! mptcp_lib_kallsyms_has "T __ip_sock_set_tos$"; then
-		echo "INFO: ${msg} not supported by the kernel: SKIP"
+		TEST_COUNT=$((TEST_COUNT+1))
+		echo "${TEST_COUNT} INFO: ${msg} not supported by the kernel: SKIP"
 		mptcp_lib_result_skip "${TEST_GROUP}"
 		return
 	fi
@@ -655,7 +657,8 @@ table inet mangle {
 }
 EOF
 	if [ $? -ne 0 ]; then
-		echo "SKIP: $msg, could not load nft ruleset"
+		TEST_COUNT=$((TEST_COUNT+1))
+		echo "${TEST_COUNT} SKIP: $msg, could not load nft ruleset"
 		mptcp_lib_fail_if_expected_feature "nft rules"
 		mptcp_lib_result_skip "${TEST_GROUP}"
 		return
@@ -671,8 +674,9 @@ EOF
 
 	ip -net "$listener_ns" $r6flag rule add fwmark 1 lookup 100
 	if [ $? -ne 0 ]; then
+		TEST_COUNT=$((TEST_COUNT+1))
 		ip netns exec "$listener_ns" nft flush ruleset
-		echo "SKIP: $msg, ip $r6flag rule failed"
+		echo "${TEST_COUNT} SKIP: $msg, ip $r6flag rule failed"
 		mptcp_lib_fail_if_expected_feature "ip rule"
 		mptcp_lib_result_skip "${TEST_GROUP}"
 		return
@@ -680,9 +684,10 @@ EOF
 
 	ip -net "$listener_ns" route add local $local_addr/0 dev lo table 100
 	if [ $? -ne 0 ]; then
+		TEST_COUNT=$((TEST_COUNT+1))
 		ip netns exec "$listener_ns" nft flush ruleset
 		ip -net "$listener_ns" $r6flag rule del fwmark 1 lookup 100
-		echo "SKIP: $msg, ip route add local $local_addr failed"
+		echo "${TEST_COUNT} SKIP: $msg, ip route add local $local_addr failed"
 		mptcp_lib_fail_if_expected_feature "ip route"
 		mptcp_lib_result_skip "${TEST_GROUP}"
 		return
@@ -811,10 +816,12 @@ stop_if_error()
 make_file "$cin" "client"
 make_file "$sin" "server"
 
+TEST_COUNT=$((TEST_COUNT+1))
 check_mptcp_disabled
 
 stop_if_error "The kernel configuration is not valid for MPTCP"
 
+TEST_COUNT=$((TEST_COUNT+1))
 mptcp_lib_print_info "INFO: validating network environment with pings"
 for sender in "$ns1" "$ns2" "$ns3" "$ns4";do
 	do_ping "$ns1" $sender 10.0.1.1
@@ -838,6 +845,9 @@ mptcp_lib_result_code "${ret}" "ping tests"
 
 stop_if_error "Could not even run ping tests"
 
+echo -n -e "0${TEST_COUNT} ping tests\t\t"
+mptcp_lib_print_ok "\t\t\t\t\t\t   [ OK ]"
+
 [ -n "$tc_loss" ] && tc -net "$ns2" qdisc add dev ns2eth3 root netem loss random $tc_loss delay ${tc_delay}ms
 echo -n "INFO: Using loss of $tc_loss "
 test "$tc_delay" -gt 0 && echo -n "delay $tc_delay ms "
-- 
2.35.3

