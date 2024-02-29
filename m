Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80FD6214F
	for <mptcp@lists.linux.dev>; Thu, 29 Feb 2024 09:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709200292; cv=none; b=N9VTpAJvgpH4aUsthIlTG990zhBOXnY9fxPg3rGAEdS0dHDop5p1TLkMwB6odfOTWP/WbLHQubDFAwSUGsnVjU1pIhve8LZcwC7oYnhZRp3FDr8PZVtPDTybo4qbm2mBrIaEkkLCFlbtYUWaWrYKYhXga/yaiBc5RVY5CeVsu0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709200292; c=relaxed/simple;
	bh=3aXl6GpvJDrr8xEkI8GCGGYP45vcPy+Oh/B3J7VbaEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VK3M+U6tA9jqu2y9hIyBKAkAZPwmTNv0q+ayIIwyeeKeJ37zTiuXVzeAAxtQsW5adBVUrUaf5q/OXRc1acAYjp3NqYw4G7R65ACErvnjx8eyRP8kCbSkg4nukFeAtoPQ3m5RoQeiXIuK14OQrYLR9DPn/9CLzj5nuqEFITs5ccI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDm21zl9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDm21zl9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2985BC433F1;
	Thu, 29 Feb 2024 09:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709200292;
	bh=3aXl6GpvJDrr8xEkI8GCGGYP45vcPy+Oh/B3J7VbaEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gDm21zl9nEOX5pOJVhrU+YoNzt3F5r3X9ZtFqxFBioKDgI91GP1KxT2VRdXou3rSO
	 pIvN1N2dYz61N7mbP+5KBAYlbR+0gWqcL615sZYIBQGW7y+IAVho3h1EE5mG8lXzX2
	 9gs/qiyEy1avwmVULA8J8CF7HMu/4nxnfv1VPEXyLMaR6sJf5/na+xQAp0/FQVtLxf
	 s8VgvFKv6G931xgRVOaF1g778qEcolrdfw1jEJF0pO3HheqzPd6h671kidHxGapSA7
	 I79hc1OMAXxGcdeKniCSCAcc0cJbhKsNJAnyf6N+1AFLKn0JFD7JSV7E8K1RJuih/G
	 XPJk8V8HW0Hkg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 7/8] selftests: mptcp: print test results with counters
Date: Thu, 29 Feb 2024 17:51:10 +0800
Message-Id: <2328092277b37a0b02084860109840f91f128137.1709200070.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1709200070.git.tanggeliang@kylinos.cn>
References: <cover.1709200070.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new helper mptcp_lib_print_title(), a wrapper of
mptcp_lib_inc_test_counter() and mptcp_lib_pr_title_counter(), to
print out test counter in each test result and increase the counter.
Use this helper to print out test counters for every tests in diag.sh,
mptcp_connect.sh, mptcp_sockopt.sh, pm_netlink.sh, simult_flows.sh,
and userspace_pm.sh.

diag.sh:

01 no msk on netns creation                          [  ok  ]
02 listen match for dport 10000                      [  ok  ]
03 listen match for sport 10000                      [  ok  ]
04 listen match for saddr and sport                  [  ok  ]
05 all listen sockets                                [  ok  ]

mptcp_connect.sh:

01 New MPTCP socket can be blocked via sysctl                       [ OK ]
02 Validating network environment with pings                        [ OK ]
INFO: Using loss of 0.85% delay 31 ms reorder .. with delay 7ms on ns3eth4
03 ns1 MPTCP -> ns1 (10.0.1.1:10000  ) MPTCP     (duration    69ms) [ OK ]
04 ns1 MPTCP -> ns1 (10.0.1.1:10001  ) TCP       (duration    20ms) [ OK ]
05 ns1 TCP   -> ns1 (10.0.1.1:10002  ) MPTCP     (duration    16ms) [ OK ]

mptcp_sockopt.sh:

01 Transfer v4                                       [ OK ]
02 Mark v4                                           [ OK ]
03 Transfer v6                                       [ OK ]
04 Mark v6                                           [ OK ]
05 SOL_MPTCP sockopt v4                              [ OK ]

pm_netlink.sh:

01 defaults addr list                                [ OK ]
02 simple add/get addr                               [ OK ]
03 dump addrs                                        [ OK ]
04 simple del addr                                   [ OK ]
05 dump addrs after del                              [ OK ]

simult_flows.sh:

01 balanced bwidth                                     7391 max 8456 [ OK ]
02 balanced bwidth - reverse direction                 7403 max 8456 [ OK ]
03 balanced bwidth with unbalanced delay               7429 max 8456 [ OK ]
04 balanced bwidth with unbalanced delay - reverse dir 7485 max 8456 [ OK ]
05 unbalanced bwidth                                   7549 max 8456 [ OK ]

userspace_pm.sh:

01 Created network namespaces ns1, ns2                               [ OK ]
INFO: Make connections
02 Established IPv4 MPTCP Connection ns2 => ns1                      [ OK ]
03 Established IPv6 MPTCP Connection ns2 => ns1                      [ OK ]
INFO: Announce tests
04 ADD_ADDR 10.0.2.2 (ns2) => ns1, invalid token                     [ OK ]
05 ADD_ADDR id:67 10.0.2.2 (ns2) => ns1, reuse port                  [ OK ]

Having test counters helps to quickly identify issues when looking at a
long list of output logs and results.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/diag.sh     |  7 ++-----
 .../selftests/net/mptcp/mptcp_connect.sh      | 10 +++++-----
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  5 +++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 20 ++++++++++---------
 .../testing/selftests/net/mptcp/pm_netlink.sh |  5 +++--
 .../selftests/net/mptcp/simult_flows.sh       | 14 ++++++++-----
 .../selftests/net/mptcp/userspace_pm.sh       |  3 ++-
 7 files changed, 37 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index ff02b699840d..74b19b89d6e6 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -9,7 +9,6 @@
 . "$(dirname "${0}")/mptcp_lib.sh"
 
 ns=""
-test_cnt=1
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 ret=0
@@ -55,7 +54,7 @@ __chk_nr()
 
 	nr=$(eval $command)
 
-	printf "%-50s" "$msg"
+	mptcp_lib_print_title "$msg"
 	if [ "$nr" != "$expected" ]; then
 		if [ "$nr" = "$skip" ] && ! mptcp_lib_expect_all_features; then
 			echo "[ skip ] Feature probably not supported"
@@ -69,7 +68,6 @@ __chk_nr()
 		echo "[  ok  ]"
 		mptcp_lib_result_pass "${msg}"
 	fi
-	test_cnt=$((test_cnt+1))
 }
 
 __chk_msk_nr()
@@ -114,7 +112,7 @@ wait_msk_nr()
 		sleep 1
 	done
 
-	printf "%-50s" "$msg"
+	mptcp_lib_print_title "$msg"
 	if [ $i -ge $timeout ]; then
 		echo "[ fail ] timeout while expecting $expected max $max last $nr"
 		mptcp_lib_result_fail "${msg} # timeout"
@@ -127,7 +125,6 @@ wait_msk_nr()
 		echo "[  ok  ]"
 		mptcp_lib_result_pass "${msg}"
 	fi
-	test_cnt=$((test_cnt+1))
 }
 
 chk_msk_fallback_nr()
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 77b0b9d5aca0..096ff8941c5b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -131,7 +131,6 @@ ns2=""
 ns3=""
 ns4=""
 
-TEST_COUNT=0
 TEST_GROUP=""
 
 # This function is used in the cleanup trap
@@ -253,6 +252,7 @@ check_mptcp_disabled()
 	local disabled_ns
 	mptcp_lib_ns_init disabled_ns
 
+	mptcp_lib_print_title "New MPTCP socket can be blocked via sysctl"
 	# net.mptcp.enabled should be enabled by default
 	if [ "$(ip netns exec ${disabled_ns} sysctl net.mptcp.enabled | awk '{ print $3 }')" -ne 1 ]; then
 		echo -e "net.mptcp.enabled sysctl is not 1 by default\t\t[ FAIL ]"
@@ -274,7 +274,6 @@ check_mptcp_disabled()
 		return 1
 	fi
 
-	printf "%-69s" "New MPTCP socket can be blocked via sysctl"
 	echo "[ OK ]"
 	mptcp_lib_result_pass "New MPTCP socket can be blocked via sysctl"
 	return 0
@@ -317,7 +316,6 @@ do_transfer()
 
 	local port
 	port=$((10000+PORT++))
-	TEST_COUNT=$((TEST_COUNT+1))
 
 	if [ "$rcvbuf" -gt 0 ]; then
 		extra_args="$extra_args -R $rcvbuf"
@@ -344,7 +342,7 @@ do_transfer()
 	addr_port=$(printf "%s:%d" ${connect_addr} ${port})
 	local result_msg
 	result_msg="$(printf "%.3s %-5s -> %.3s (%-20s) %-5s" ${connector_ns} ${cl_proto} ${listener_ns} ${addr_port} ${srv_proto})"
-	printf "%-50s" "${result_msg}"
+	mptcp_lib_print_title "${result_msg}"
 
 	if $capture; then
 		local capuser
@@ -830,6 +828,7 @@ stop_if_error()
 	fi
 }
 
+MPTCP_LIB_TEST_FORMAT="%02u %-69s"
 make_file "$cin" "client"
 make_file "$sin" "server"
 
@@ -837,7 +836,7 @@ check_mptcp_disabled
 
 stop_if_error "The kernel configuration is not valid for MPTCP"
 
-printf "%-69s" "Validating network environment with pings"
+mptcp_lib_print_title "Validating network environment with pings"
 for sender in "$ns1" "$ns2" "$ns3" "$ns4";do
 	do_ping "$ns1" $sender 10.0.1.1
 	do_ping "$ns1" $sender dead:beef:1::1
@@ -860,6 +859,7 @@ mptcp_lib_result_code "${ret}" "ping tests"
 
 stop_if_error "Could not even run ping tests"
 echo "[ OK ]"
+MPTCP_LIB_TEST_FORMAT="%02u %-50s"
 
 [ -n "$tc_loss" ] && tc -net "$ns2" qdisc add dev ns2eth3 root netem loss random $tc_loss delay ${tc_delay}ms
 echo -n "INFO: Using loss of $tc_loss "
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index cbf0dd2cc4cb..358d5b77fc0f 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -428,3 +428,8 @@ mptcp_lib_pr_title_counter() {
 
 	printf "${MPTCP_LIB_TEST_FORMAT}" "${MPTCP_LIB_TEST_COUNTER}" "${*}"
 }
+
+mptcp_lib_print_title() {
+	mptcp_lib_inc_test_counter
+	mptcp_lib_pr_title_counter "${*}"
+}
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index ae59136b5bb4..a797e13d3fe7 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -161,6 +161,7 @@ do_transfer()
 	wait $spid
 	local rets=$?
 
+	mptcp_lib_print_title "Transfer ${ip}"
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		echo " client exit code $retc, server $rets" 1>&2
 		echo -e "\nnetns ${listener_ns} socket stat for ${port}:" 1>&2
@@ -174,7 +175,9 @@ do_transfer()
 		ret=1
 		return 1
 	fi
+	echo "[ OK ]"
 
+	mptcp_lib_print_title "Mark ${ip}"
 	if [ $local_addr = "::" ];then
 		check_mark $listener_ns 6 || retc=1
 		check_mark $connector_ns 6 || retc=1
@@ -190,8 +193,10 @@ do_transfer()
 	mptcp_lib_result_code "${rets}" "transfer ${ip}"
 
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ];then
+		echo "[ OK ]"
 		return 0
 	fi
+	echo "FAIL: Mark ${ip}"
 
 	return 1
 }
@@ -220,23 +225,27 @@ do_mptcp_sockopt_tests()
 	ip netns exec "$ns_sbox" ./mptcp_sockopt
 	lret=$?
 
+	mptcp_lib_print_title "SOL_MPTCP sockopt v4"
 	if [ $lret -ne 0 ]; then
 		echo "FAIL: SOL_MPTCP getsockopt" 1>&2
 		mptcp_lib_result_fail "sockopt v4"
 		ret=$lret
 		return
 	fi
+	echo "[ OK ]"
 	mptcp_lib_result_pass "sockopt v4"
 
 	ip netns exec "$ns_sbox" ./mptcp_sockopt -6
 	lret=$?
 
+	mptcp_lib_print_title "SOL_MPTCP sockopt v6"
 	if [ $lret -ne 0 ]; then
 		echo "FAIL: SOL_MPTCP getsockopt (v6)" 1>&2
 		mptcp_lib_result_fail "sockopt v6"
 		ret=$lret
 		return
 	fi
+	echo "[ OK ]"
 	mptcp_lib_result_pass "sockopt v6"
 }
 
@@ -259,6 +268,7 @@ run_tests()
 
 do_tcpinq_test()
 {
+	mptcp_lib_print_title "TCP_INQ cmsg/ioctl $*"
 	ip netns exec "$ns_sbox" ./mptcp_inq "$@"
 	local lret=$?
 	if [ $lret -ne 0 ];then
@@ -268,7 +278,7 @@ do_tcpinq_test()
 		return $lret
 	fi
 
-	echo "PASS: TCP_INQ cmsg/ioctl $*"
+	echo "[ OK ]"
 	mptcp_lib_result_pass "TCP_INQ: $*"
 	return $lret
 }
@@ -314,15 +324,7 @@ trap cleanup EXIT
 run_tests $ns1 $ns2 10.0.1.1
 run_tests $ns1 $ns2 dead:beef:1::1
 
-if [ $ret -eq 0 ];then
-	echo "PASS: all packets had packet mark set"
-fi
-
 do_mptcp_sockopt_tests
-if [ $ret -eq 0 ];then
-	echo "PASS: SOL_MPTCP getsockopt has expected information"
-fi
-
 do_tcpinq_tests
 
 mptcp_lib_result_print_all_tap
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 427fc5c70b3c..5b9bc25dfef4 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -53,7 +53,7 @@ check()
 	local msg="$3"
 	local rc=0
 
-	printf "%-50s" "$msg"
+	mptcp_lib_print_title "$msg"
 	mptcp_lib_check_output "${err}" "${cmd}" "${expected}" || rc=${?}
 	if [ ${rc} -eq 2 ]; then
 		mptcp_lib_result_fail "${msg} # error ${rc}"
@@ -189,7 +189,8 @@ subflow,backup,fullmesh 10.0.1.1" "          (backup,fullmesh)"
 else
 	for st in fullmesh nofullmesh backup,fullmesh; do
 		st="          (${st})"
-		printf "%-50s%s\n" "${st}" "[SKIP]"
+		mptcp_lib_print_title "${st}"
+		echo "[SKIP]"
 		mptcp_lib_result_skip "${st}"
 	done
 fi
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index d5f8521b88d5..212782301c6f 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -14,7 +14,6 @@ ns3=""
 capture=false
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
-test_cnt=1
 ret=0
 bail=0
 slack=50
@@ -126,8 +125,7 @@ do_transfer()
 	local sin=$2
 	local max_time=$3
 	local port
-	port=$((10000+test_cnt))
-	test_cnt=$((test_cnt+1))
+	port=$((10000+MPTCP_LIB_TEST_COUNTER))
 
 	:> "$cout"
 	:> "$sout"
@@ -205,6 +203,12 @@ do_transfer()
 	return 1
 }
 
+print_title()
+{
+	MPTCP_LIB_TEST_FORMAT="%02u %-55s"
+	mptcp_lib_print_title "${*}"
+}
+
 run_test()
 {
 	local rate1=$1
@@ -239,7 +243,7 @@ run_test()
 	# completion (see mptcp_connect): 200ms on each side, add some slack
 	time=$((time + 400 + slack))
 
-	printf "%-60s" "$msg"
+	print_title "$msg"
 	do_transfer $small $large $time
 	lret=$?
 	mptcp_lib_result_code "${lret}" "${msg}"
@@ -249,7 +253,7 @@ run_test()
 	fi
 
 	msg+=" - reverse direction"
-	printf "%-60s" "$(echo -n ${msg} | cut -c1-54)"
+	print_title "$(echo -n ${msg} | cut -c1-54)"
 	do_transfer $large $small $time
 	lret=$?
 	mptcp_lib_result_code "${lret}" "${msg}"
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index b0cce8f065d8..62e059e3fb24 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -69,7 +69,8 @@ print_test()
 {
 	test_name="${1}"
 
-	_printf "%-68s" "${test_name}"
+	MPTCP_LIB_TEST_FORMAT="%02u %-68s"
+	mptcp_lib_print_title "${test_name}"
 }
 
 print_results()
-- 
2.40.1

