Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A8269306
	for <mptcp@lists.linux.dev>; Fri,  1 Mar 2024 06:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709275629; cv=none; b=axmO4pkf5uo+pqdgpEjxZlYRyFBTg7VMVw+7fZuk/jVErBc2ghENpDnk4jUv50Zdqkq/gUgvmB8r5VIvcTBO3VbyxKkGCdwt7Pi04/euVnm0FTomq9HGFuPUX1a3xm/GX+iAqe7l23h2VTZ9zuM0ZcLiZFC2xrWFFx04cG0mhNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709275629; c=relaxed/simple;
	bh=vt6pAdzM+e07Btt8BsmGXcf5yxQKx458blxHjpQbuVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H+l6RLqZ45KIU0RMzRLtnAP73lj+/TSmnxCF+lE/xe4oq0jWuzZmTMzSmTyjy3/xdIzzeTGNZN0JXH3ybAap36bOQPs8FpUZ6zLd9MS7z77OEAfEKCl4njH1qt3O0Mu8snrkecXggBvi8IxL22mWREiSrNcjBQ0z82mX//lt7xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMX/OdfU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMX/OdfU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5DB9C433B2;
	Fri,  1 Mar 2024 06:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709275628;
	bh=vt6pAdzM+e07Btt8BsmGXcf5yxQKx458blxHjpQbuVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jMX/OdfU7nJJXgp6oMFjPakRx+XeaTNXJJmtbY43w9+01JW32XtEHs4iSdvFOzmja
	 8aoimWL6IqFFTfhmafLyxl/D91RpgtdGIWksIpH+FchSID9eyJD6Bs4RKQP+M5jf2h
	 Ji28YyoPVlxGA1H993YEVZ0ZnQKK0xa40PCBQ3pkrUcQbmHOrMKM0T184CFRvHIHfE
	 iF2bJk6QFhhS9KoAQEBFhmU/SeO+WYGu+Bc0zwdWYZEmAyFBzix7m3hwPGPWfS9mMx
	 nSA15a7G5E6p/zs/TPqKWthbWQsTAkyU+nH7WR++mCRGfhRaFSZYZhJdhEE7OyqxiX
	 oVqYrgOdHRELQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 5/6] selftests: mptcp: print test results with counters
Date: Fri,  1 Mar 2024 14:46:35 +0800
Message-Id: <43d66d0c11e1d86ca58358a16a7698a260cbb59e.1709275290.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1709275290.git.tanggeliang@kylinos.cn>
References: <cover.1709275290.git.tanggeliang@kylinos.cn>
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

'mptcp_sockopt.sh' now display more detailed results + why (what you had
in a former patch from v6, merged here). It no longer displays 'PASS:',
because it is duplicated info now that the detailed are displayed.

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
04 balanced bwidth with unbalanced delay - reverse ... 7485 max 8456 [ OK ]
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
 tools/testing/selftests/net/mptcp/diag.sh     |  7 ++---
 .../selftests/net/mptcp/mptcp_connect.sh      |  7 +++--
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 26 ++++++++++---------
 .../testing/selftests/net/mptcp/pm_netlink.sh |  5 ++--
 .../selftests/net/mptcp/simult_flows.sh       | 10 +++----
 .../selftests/net/mptcp/userspace_pm.sh       |  4 ++-
 6 files changed, 30 insertions(+), 29 deletions(-)

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
index be598e1e25f5..a94655493cdc 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -131,7 +131,6 @@ ns2=""
 ns3=""
 ns4=""
 
-TEST_COUNT=0
 TEST_GROUP=""
 
 # This function is used in the cleanup trap
@@ -250,7 +249,8 @@ fi
 
 print_larger_title() {
 	# here we don't have the time, a bit longer for the alignment
-	printf "%-69s" "${@}"
+	MPTCP_LIB_TEST_FORMAT="%02u %-69s" \
+		mptcp_lib_print_title "${@}"
 }
 
 check_mptcp_disabled()
@@ -322,7 +322,6 @@ do_transfer()
 
 	local port
 	port=$((10000+PORT++))
-	TEST_COUNT=$((TEST_COUNT+1))
 
 	if [ "$rcvbuf" -gt 0 ]; then
 		extra_args="$extra_args -R $rcvbuf"
@@ -349,7 +348,7 @@ do_transfer()
 	addr_port=$(printf "%s:%d" ${connect_addr} ${port})
 	local result_msg
 	result_msg="$(printf "%.3s %-5s -> %.3s (%-20s) %-5s" ${connector_ns} ${cl_proto} ${listener_ns} ${addr_port} ${srv_proto})"
-	printf "%-50s" "${result_msg}"
+	mptcp_lib_print_title "${result_msg}"
 
 	if $capture; then
 		local capuser
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index bf22174c022c..4aa60e8b2db1 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -162,6 +162,7 @@ do_transfer()
 	wait $spid
 	local rets=$?
 
+	mptcp_lib_print_title "Transfer ${ip:2}"
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		echo " client exit code $retc, server $rets" 1>&2
 		echo -e "\nnetns ${listener_ns} socket stat for ${port}:" 1>&2
@@ -175,7 +176,9 @@ do_transfer()
 		ret=1
 		return 1
 	fi
+	echo "[ OK ]"
 
+	mptcp_lib_print_title "Mark ${ip:2}"
 	if [ $local_addr = "::" ];then
 		check_mark $listener_ns 6 || retc=1
 		check_mark $connector_ns 6 || retc=1
@@ -191,8 +194,10 @@ do_transfer()
 	mptcp_lib_result_code "${rets}" "transfer ${ip}"
 
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ];then
+		echo "[ OK ]"
 		return 0
 	fi
+	echo "[FAIL]"
 
 	return 1
 }
@@ -221,23 +226,27 @@ do_mptcp_sockopt_tests()
 	ip netns exec "$ns_sbox" ./mptcp_sockopt
 	lret=$?
 
+	mptcp_lib_print_title "SOL_MPTCP sockopt v4"
 	if [ $lret -ne 0 ]; then
-		echo "FAIL: SOL_MPTCP getsockopt"
+		echo "[FAIL]"
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
-		echo "FAIL: SOL_MPTCP getsockopt (ipv6)"
+		echo "[FAIL]"
 		mptcp_lib_result_fail "sockopt v6"
 		ret=$lret
 		return
 	fi
+	echo "[ OK ]"
 	mptcp_lib_result_pass "sockopt v6"
 }
 
@@ -260,16 +269,17 @@ run_tests()
 
 do_tcpinq_test()
 {
+	mptcp_lib_print_title "TCP_INQ cmsg/ioctl $*"
 	ip netns exec "$ns_sbox" ./mptcp_inq "$@"
 	local lret=$?
 	if [ $lret -ne 0 ];then
 		ret=$lret
-		echo "FAIL: mptcp_inq $*"
+		echo "[FAIL]"
 		mptcp_lib_result_fail "TCP_INQ: $*"
 		return $lret
 	fi
 
-	echo "PASS: TCP_INQ cmsg/ioctl $*"
+	echo "[ OK ]"
 	mptcp_lib_result_pass "TCP_INQ: $*"
 	return $lret
 }
@@ -315,15 +325,7 @@ trap cleanup EXIT
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
index 467feb17e07b..03fd08e8e044 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -14,7 +14,8 @@ ns3=""
 capture=false
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
-test_cnt=1
+# a bit more space: because we have more to display
+MPTCP_LIB_TEST_FORMAT="%02u %-60s"
 ret=0
 bail=0
 slack=50
@@ -126,8 +127,7 @@ do_transfer()
 	local sin=$2
 	local max_time=$3
 	local port
-	port=$((10000+test_cnt))
-	test_cnt=$((test_cnt+1))
+	port=$((10000+MPTCP_LIB_TEST_COUNTER))
 
 	:> "$cout"
 	:> "$sout"
@@ -239,7 +239,7 @@ run_test()
 	# completion (see mptcp_connect): 200ms on each side, add some slack
 	time=$((time + 400 + slack))
 
-	printf "%-60s" "$msg"
+	mptcp_lib_print_title "$msg"
 	do_transfer $small $large $time
 	lret=$?
 	mptcp_lib_result_code "${lret}" "${msg}"
@@ -249,7 +249,7 @@ run_test()
 	fi
 
 	msg+=" - reverse direction"
-	printf "%-60s" "${msg}"
+	mptcp_lib_print_title "${msg}"
 	do_transfer $large $small $time
 	lret=$?
 	mptcp_lib_result_code "${lret}" "${msg}"
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index b0cce8f065d8..ca238592baee 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -54,6 +54,8 @@ ns1=""
 ns2=""
 ret=0
 test_name=""
+# a bit more space: because we have more to display
+MPTCP_LIB_TEST_FORMAT="%02u %-68s"
 
 _printf() {
 	stdbuf -o0 -e0 printf "${@}"
@@ -69,7 +71,7 @@ print_test()
 {
 	test_name="${1}"
 
-	_printf "%-68s" "${test_name}"
+	mptcp_lib_print_title "${test_name}"
 }
 
 print_results()
-- 
2.40.1

