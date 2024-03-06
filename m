Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C702CA7
	for <mptcp@lists.linux.dev>; Wed,  6 Mar 2024 01:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709689277; cv=none; b=BTBVmGKoNMS/ezsJjC2YxkwiJ1fYhorhP0agWxjyo5VWGF1PEbM6wCRz5iM5vG84z3S57uX3P18hZvwucohLD4z3+0SUMdYEe/L0J2Tu3g+6IeMviyFcFXTjjws2eS+zdko4Cfc2COLJ8eKBb29ZLjBurZnUSN3E16TFPZvemVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709689277; c=relaxed/simple;
	bh=+sK0wTaehYThqndiPHqx9kbd/99rtW7d1DSUy4y4dYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NdJO0SVccBsbhQzekRbQYr+70yIRNdF8KNpgKpCkzRO/o2s58oeB3NEGy8LLclQJTCx9CoJnRGwrZvRaTNuJO5UB0NZI+KeR1E6vh+O8h0sBHtDWgBbT8GyzkidFoyN+rLVG2CHOmX/guT1+bEOGyI/f1NeSyp/VLNtey1/Hs10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRv0GmLo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRv0GmLo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF83C43394;
	Wed,  6 Mar 2024 01:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709689277;
	bh=+sK0wTaehYThqndiPHqx9kbd/99rtW7d1DSUy4y4dYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fRv0GmLogphy25iqy2CgQAuxBVCiXuxxQjsHXSMGZv2gfgHoo6+UifShyJegtcEE9
	 SOOqyEA+qsBVJEw4Do0RBrnatFjxBX7aeMx4nRbJNKUSZv49Z2BGI8O0CKg9QAM6rA
	 NqiAtZpNAbxxAPgofmitEtlLARH8nFmvuqz8vMZ+nZcJGnPbQlkhrXgj/jaBbLOd2e
	 tmqRe0J2ODWpKAxkaWEbv1f/KqsnbWtgVEXGKyjaUn7hABEjhToSLt7kc4lMoei3Ul
	 WiPFhS4RhMDQTp09zDleZKMQ4F1DBD6c1TR9Y4NRSijcJd1QDzoE4TaP2SEQwFyt31
	 PfUCduFAePTjw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v13 7/9] selftests: mptcp: print test results with counters
Date: Wed,  6 Mar 2024 09:40:57 +0800
Message-Id: <17ece3b5751fd87d44633f0f379080da780a82f5.1709688778.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1709688778.git.tanggeliang@kylinos.cn>
References: <cover.1709688778.git.tanggeliang@kylinos.cn>
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
 tools/testing/selftests/net/mptcp/diag.sh         |  6 ++----
 .../testing/selftests/net/mptcp/mptcp_connect.sh  |  6 +++---
 .../testing/selftests/net/mptcp/mptcp_sockopt.sh  | 15 +++++----------
 tools/testing/selftests/net/mptcp/pm_netlink.sh   |  5 +++--
 tools/testing/selftests/net/mptcp/simult_flows.sh |  7 ++++---
 tools/testing/selftests/net/mptcp/userspace_pm.sh |  4 +++-
 6 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index b63510ce2327..4ffdd415e670 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -54,7 +54,7 @@ __chk_nr()
 
 	nr=$(eval $command)
 
-	printf "%-50s" "$msg"
+	mptcp_lib_print_title "$msg"
 	if [ "$nr" != "$expected" ]; then
 		if [ "$nr" = "$skip" ] && ! mptcp_lib_expect_all_features; then
 			echo "[ skip ] Feature probably not supported"
@@ -68,7 +68,6 @@ __chk_nr()
 		echo "[  ok  ]"
 		mptcp_lib_result_pass "${msg}"
 	fi
-	MPTCP_LIB_TEST_COUNTER=$((MPTCP_LIB_TEST_COUNTER+1))
 }
 
 __chk_msk_nr()
@@ -113,7 +112,7 @@ wait_msk_nr()
 		sleep 1
 	done
 
-	printf "%-50s" "$msg"
+	mptcp_lib_print_title "$msg"
 	if [ $i -ge $timeout ]; then
 		echo "[ fail ] timeout while expecting $expected max $max last $nr"
 		mptcp_lib_result_fail "${msg} # timeout"
@@ -126,7 +125,6 @@ wait_msk_nr()
 		echo "[  ok  ]"
 		mptcp_lib_result_pass "${msg}"
 	fi
-	MPTCP_LIB_TEST_COUNTER=$((MPTCP_LIB_TEST_COUNTER+1))
 }
 
 chk_msk_fallback_nr()
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index da943aa0cea1..684c24aba21a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -249,7 +249,8 @@ fi
 
 print_larger_title() {
 	# here we don't have the time, a bit longer for the alignment
-	printf "%-69s" "${@}"
+	MPTCP_LIB_TEST_FORMAT="%02u %-69s" \
+		mptcp_lib_print_title "${@}"
 }
 
 check_mptcp_disabled()
@@ -321,7 +322,6 @@ do_transfer()
 
 	local port
 	port=$((port_base++))
-	MPTCP_LIB_TEST_COUNTER=$((MPTCP_LIB_TEST_COUNTER+1))
 
 	if [ "$rcvbuf" -gt 0 ]; then
 		extra_args="$extra_args -R $rcvbuf"
@@ -348,7 +348,7 @@ do_transfer()
 	addr_port=$(printf "%s:%d" ${connect_addr} ${port})
 	local result_msg
 	result_msg="$(printf "%.3s %-5s -> %.3s (%-20s) %-5s" ${connector_ns} ${cl_proto} ${listener_ns} ${addr_port} ${srv_proto})"
-	printf "%-50s" "${result_msg}"
+	mptcp_lib_print_title "${result_msg}"
 
 	if $capture; then
 		local capuser
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 17b36c1312f4..466800326cbb 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -113,11 +113,6 @@ check_mark()
 	return 0
 }
 
-print_title()
-{
-	printf "%-50s" "${@}"
-}
-
 do_transfer()
 {
 	local listener_ns="$1"
@@ -167,7 +162,7 @@ do_transfer()
 	wait $spid
 	local rets=$?
 
-	print_title "Transfer ${ip:2}"
+	mptcp_lib_print_title "Transfer ${ip:2}"
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		echo "[FAIL] client exit code $retc, server $rets"
 		echo -e "\nnetns ${listener_ns} socket stat for ${port}:" 1>&2
@@ -188,7 +183,7 @@ do_transfer()
 	fi
 	mptcp_lib_result_code "${rets}" "transfer ${ip}"
 
-	print_title "Mark ${ip:2}"
+	mptcp_lib_print_title "Mark ${ip:2}"
 	if [ $local_addr = "::" ];then
 		check_mark $listener_ns 6 || retc=1
 		check_mark $connector_ns 6 || retc=1
@@ -232,7 +227,7 @@ do_mptcp_sockopt_tests()
 	ip netns exec "$ns_sbox" ./mptcp_sockopt
 	lret=$?
 
-	print_title "SOL_MPTCP sockopt v4"
+	mptcp_lib_print_title "SOL_MPTCP sockopt v4"
 	if [ $lret -ne 0 ]; then
 		echo "[FAIL]"
 		mptcp_lib_result_fail "sockopt v4"
@@ -245,7 +240,7 @@ do_mptcp_sockopt_tests()
 	ip netns exec "$ns_sbox" ./mptcp_sockopt -6
 	lret=$?
 
-	print_title "SOL_MPTCP sockopt v6"
+	mptcp_lib_print_title "SOL_MPTCP sockopt v6"
 	if [ $lret -ne 0 ]; then
 		echo "[FAIL]"
 		mptcp_lib_result_fail "sockopt v6"
@@ -275,7 +270,7 @@ run_tests()
 
 do_tcpinq_test()
 {
-	print_title "TCP_INQ cmsg/ioctl $*"
+	mptcp_lib_print_title "TCP_INQ cmsg/ioctl $*"
 	ip netns exec "$ns_sbox" ./mptcp_inq "$@"
 	local lret=$?
 	if [ $lret -ne 0 ];then
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
index 20bf1ea43362..03fd08e8e044 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -14,6 +14,8 @@ ns3=""
 capture=false
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
+# a bit more space: because we have more to display
+MPTCP_LIB_TEST_FORMAT="%02u %-60s"
 ret=0
 bail=0
 slack=50
@@ -126,7 +128,6 @@ do_transfer()
 	local max_time=$3
 	local port
 	port=$((10000+MPTCP_LIB_TEST_COUNTER))
-	MPTCP_LIB_TEST_COUNTER=$((MPTCP_LIB_TEST_COUNTER+1))
 
 	:> "$cout"
 	:> "$sout"
@@ -238,7 +239,7 @@ run_test()
 	# completion (see mptcp_connect): 200ms on each side, add some slack
 	time=$((time + 400 + slack))
 
-	printf "%-60s" "$msg"
+	mptcp_lib_print_title "$msg"
 	do_transfer $small $large $time
 	lret=$?
 	mptcp_lib_result_code "${lret}" "${msg}"
@@ -248,7 +249,7 @@ run_test()
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

