Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9561250F6
	for <mptcp@lists.linux.dev>; Wed, 28 Feb 2024 07:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709106238; cv=none; b=Zm/fF5DmmACoCXqB6D3H+XquqptWd77YxtaqireWjjE9u+3emMryFL7EAuvcGfCrP0OSmFfsbWNghh5UDfuLpFrt5EJ6m6xb97exWvIlTVW0NvSQJgTeDlthxtMPZErULLA0IPOR56FU4r3XlvRApBsjFRN7AL5FP7qj9QKOmak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709106238; c=relaxed/simple;
	bh=DEHNed5ubF2UfhRx6iZwcexnQosQPOVR4yfe92dSPV4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KPW0GiIY/RYLpbvCxpZT0C7rXrZis9LolmfXu70bIuqawFhr3RpcF1BBUOsWa8F73RDSjXKodhOJRa2ZyBw4+dNj/PXWiRBGTQEclPELOswfZSB2GGR7Lno9S+KnmZLd3KkCHdqQ794qiksDg43H8u4LQdTDnL3OLqI69Zwg2qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fq3Z3JGK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fq3Z3JGK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02FA0C433F1;
	Wed, 28 Feb 2024 07:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709106238;
	bh=DEHNed5ubF2UfhRx6iZwcexnQosQPOVR4yfe92dSPV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fq3Z3JGKJyIAcmADXI+T21uJHeKGRuueVv4v7BkEVOYIxuS41zOC6tFXBT8s7TPdQ
	 4L5nVUkH90r+1EzLjtQ4qc4NgUGHJb3PAjGep79CjMxoLVj/DBpe0ZsKiBaQlg1TW2
	 xpX5ryHy4JRe5PGcJmlINsOXUfMRbJky4sQMHmTjWIKkVWXuxi59mtbXk35FSARr3y
	 Gd1bvBbeh+VouhG1QCfy6l+3oxE+7brgF7+nWCy4+bLmmDx8pJlVS+okXWgRv9wSCJ
	 4jKchfIEmFY7zqDo7GEpF32OUJJNqPY31FF9VNeY09mKz6ldlWT3RR77ADY5O33fD6
	 C4+p0ZeUNoUOA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 2/9] selftests: mptcp: print test results with colors
Date: Wed, 28 Feb 2024 15:43:40 +0800
Message-Id: <eacc57e0d627d22cdaf68fd08b430eb5e381ecc0.1709105922.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1709105922.git.tanggeliang@kylinos.cn>
References: <cover.1709105922.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch uses mptcp_lib_pr_ok(), mptcp_lib_pr_skip(), mptcp_lib_pr_fail()
and mptcp_lib_pr_info() helpers in all scripts to print test results with
colors.

Having colors helps to quickly identify issues when looking at a long list
of output logs and results.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---

Notes:
    use mptcp_lib_pr_* helpers, not mptcp_lib_print_* helpers

 tools/testing/selftests/net/mptcp/diag.sh     | 12 ++--
 .../selftests/net/mptcp/mptcp_connect.sh      | 58 +++++++++----------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 21 ++++---
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 19 +++---
 .../testing/selftests/net/mptcp/pm_netlink.sh |  3 +-
 .../selftests/net/mptcp/simult_flows.sh       |  4 +-
 6 files changed, 61 insertions(+), 56 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index d8f080f934ac..7830bc043d52 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -58,15 +58,15 @@ __chk_nr()
 	printf "%-50s" "$msg"
 	if [ "$nr" != "$expected" ]; then
 		if [ "$nr" = "$skip" ] && ! mptcp_lib_expect_all_features; then
-			echo "[ skip ] Feature probably not supported"
+			mptcp_lib_pr_skip "Feature probably not supported"
 			mptcp_lib_result_skip "${msg}"
 		else
-			echo "[ fail ] expected $expected found $nr"
+			mptcp_lib_pr_fail "expected $expected found $nr"
 			mptcp_lib_result_fail "${msg}"
 			ret=$test_cnt
 		fi
 	else
-		echo "[  ok  ]"
+		mptcp_lib_pr_ok
 		mptcp_lib_result_pass "${msg}"
 	fi
 	test_cnt=$((test_cnt+1))
@@ -116,15 +116,15 @@ wait_msk_nr()
 
 	printf "%-50s" "$msg"
 	if [ $i -ge $timeout ]; then
-		echo "[ fail ] timeout while expecting $expected max $max last $nr"
+		mptcp_lib_pr_fail "timeout while expecting $expected max $max last $nr"
 		mptcp_lib_result_fail "${msg} # timeout"
 		ret=$test_cnt
 	elif [ $nr != $expected ]; then
-		echo "[ fail ] expected $expected found $nr"
+		mptcp_lib_pr_fail "expected $expected found $nr"
 		mptcp_lib_result_fail "${msg} # unexpected result"
 		ret=$test_cnt
 	else
-		echo "[  ok  ]"
+		mptcp_lib_pr_ok
 		mptcp_lib_result_pass "${msg}"
 	fi
 	test_cnt=$((test_cnt+1))
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 0ca2960c9099..ffc063a58149 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -218,7 +218,7 @@ set_ethtool_flags() {
 	local flags="$3"
 
 	if ip netns exec $ns ethtool -K $dev $flags 2>/dev/null; then
-		echo "INFO: set $ns dev $dev: ethtool -K $flags"
+		mptcp_lib_pr_info "set $ns dev $dev: ethtool -K $flags"
 	fi
 }
 
@@ -254,7 +254,7 @@ check_mptcp_disabled()
 
 	# net.mptcp.enabled should be enabled by default
 	if [ "$(ip netns exec ${disabled_ns} sysctl net.mptcp.enabled | awk '{ print $3 }')" -ne 1 ]; then
-		echo -e "net.mptcp.enabled sysctl is not 1 by default\t\t[ FAIL ]"
+		mptcp_lib_pr_fail "net.mptcp.enabled sysctl is not 1 by default"
 		mptcp_lib_result_fail "net.mptcp.enabled sysctl is not 1 by default"
 		ret=1
 		return 1
@@ -267,13 +267,14 @@ check_mptcp_disabled()
 	mptcp_lib_ns_exit "${disabled_ns}"
 
 	if [ ${err} -eq 0 ]; then
-		echo -e "New MPTCP socket cannot be blocked via sysctl\t\t[ FAIL ]"
+		mptcp_lib_pr_fail "New MPTCP socket cannot be blocked via sysctl"
 		mptcp_lib_result_fail "New MPTCP socket cannot be blocked via sysctl"
 		ret=1
 		return 1
 	fi
 
-	echo -e "New MPTCP socket can be blocked via sysctl\t\t[ OK ]"
+	echo -n -e "New MPTCP socket can be blocked via sysctl\t\t"
+	mptcp_lib_pr_ok
 	mptcp_lib_result_pass "New MPTCP socket can be blocked via sysctl"
 	return 0
 }
@@ -294,7 +295,7 @@ do_ping()
 	ip netns exec ${connector_ns} ping ${ping_args} $connect_addr >/dev/null || rc=1
 
 	if [ $rc -ne 0 ] ; then
-		echo "$listener_ns -> $connect_addr connectivity [ FAIL ]" 1>&2
+		mptcp_lib_pr_fail "$listener_ns -> $connect_addr connectivity" 1>&2
 		ret=1
 
 		return 1
@@ -330,7 +331,7 @@ do_transfer()
 	fi
 
 	if [ -n "$extra_args" ] && $options_log; then
-		echo "INFO: extra options: $extra_args"
+		mptcp_lib_pr_info "extra options: $extra_args"
 	fi
 	options_log=false
 
@@ -427,7 +428,7 @@ do_transfer()
 	result_msg+=" # time=${duration}ms"
 	printf "(duration %05sms) " "${duration}"
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
-		echo "[ FAIL ] client exit code $retc, server $rets" 1>&2
+		mptcp_lib_pr_fail "client exit code $retc, server $rets" 1>&2
 		echo -e "\nnetns ${listener_ns} socket stat for ${port}:" 1>&2
 		ip netns exec ${listener_ns} ss -Menita 1>&2 -o "sport = :$port"
 		cat /tmp/${listener_ns}.out
@@ -469,13 +470,13 @@ do_transfer()
 	fi
 
 	if [ ${stat_synrx_now_l} -lt ${expect_synrx} ]; then
-		printf "[ FAIL ] lower MPC SYN rx (%d) than expected (%d)\n" \
+		mptcp_lib_pr_fail "lower MPC SYN rx (%d) than expected (%d)\n" \
 			"${stat_synrx_now_l}" "${expect_synrx}" 1>&2
 		retc=1
 	fi
 	if [ ${stat_ackrx_now_l} -lt ${expect_ackrx} ] && [ ${stat_ooo_now} -eq 0 ]; then
 		if [ ${stat_ooo_now} -eq 0 ]; then
-			printf "[ FAIL ] lower MPC ACK rx (%d) than expected (%d)\n" \
+			mptcp_lib_pr_fail "lower MPC ACK rx (%d) than expected (%d)\n" \
 				"${stat_ackrx_now_l}" "${expect_ackrx}" 1>&2
 			rets=1
 		else
@@ -491,19 +492,19 @@ do_transfer()
 
 		local csum_err_s_nr=$((csum_err_s - stat_csum_err_s))
 		if [ $csum_err_s_nr -gt 0 ]; then
-			printf "[ FAIL ]\nserver got %d data checksum error[s]" ${csum_err_s_nr}
+			mptcp_lib_pr_fail "\nserver got %d data checksum error[s]" ${csum_err_s_nr}
 			rets=1
 		fi
 
 		local csum_err_c_nr=$((csum_err_c - stat_csum_err_c))
 		if [ $csum_err_c_nr -gt 0 ]; then
-			printf "[ FAIL ]\nclient got %d data checksum error[s]" ${csum_err_c_nr}
+			mptcp_lib_pr_fail "\nclient got %d data checksum error[s]" ${csum_err_c_nr}
 			retc=1
 		fi
 	fi
 
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ]; then
-		printf "[ OK ]"
+		mptcp_lib_pr_ok
 		mptcp_lib_result_pass "${TEST_GROUP}: ${result_msg}"
 	else
 		mptcp_lib_result_fail "${TEST_GROUP}: ${result_msg}"
@@ -534,7 +535,6 @@ do_transfer()
 			"${expect_ackrx}" "${stat_ackrx_now_l}"
 	fi
 
-	echo
 	cat "$capout"
 	[ $retc -eq 0 ] && [ $rets -eq 0 ]
 }
@@ -660,7 +660,7 @@ run_test_transparent()
 	# following function has been exported (T). Not great but better than
 	# checking for a specific kernel version.
 	if ! mptcp_lib_kallsyms_has "T __ip_sock_set_tos$"; then
-		echo "INFO: ${msg} not supported by the kernel: SKIP"
+		mptcp_lib_pr_skip "INFO: ${msg} not supported by the kernel"
 		mptcp_lib_result_skip "${TEST_GROUP}"
 		return
 	fi
@@ -677,7 +677,7 @@ table inet mangle {
 }
 EOF
 	then
-		echo "SKIP: $msg, could not load nft ruleset"
+		mptcp_lib_pr_skip "$msg, could not load nft ruleset"
 		mptcp_lib_fail_if_expected_feature "nft rules"
 		mptcp_lib_result_skip "${TEST_GROUP}"
 		return
@@ -693,7 +693,7 @@ EOF
 
 	if ! ip -net "$listener_ns" $r6flag rule add fwmark 1 lookup 100; then
 		ip netns exec "$listener_ns" nft flush ruleset
-		echo "SKIP: $msg, ip $r6flag rule failed"
+		mptcp_lib_pr_skip "$msg, ip $r6flag rule failed"
 		mptcp_lib_fail_if_expected_feature "ip rule"
 		mptcp_lib_result_skip "${TEST_GROUP}"
 		return
@@ -702,13 +702,13 @@ EOF
 	if ! ip -net "$listener_ns" route add local $local_addr/0 dev lo table 100; then
 		ip netns exec "$listener_ns" nft flush ruleset
 		ip -net "$listener_ns" $r6flag rule del fwmark 1 lookup 100
-		echo "SKIP: $msg, ip route add local $local_addr failed"
+		mptcp_lib_pr_skip "$msg, ip route add local $local_addr failed"
 		mptcp_lib_fail_if_expected_feature "ip route"
 		mptcp_lib_result_skip "${TEST_GROUP}"
 		return
 	fi
 
-	echo "INFO: test $msg"
+	mptcp_lib_pr_info "test $msg"
 
 	TEST_COUNT=10000
 	local extra_args="-o TRANSPARENT"
@@ -721,12 +721,12 @@ EOF
 	ip -net "$listener_ns" route del local $local_addr/0 dev lo table 100
 
 	if [ $lret -ne 0 ]; then
-		echo "FAIL: $msg, mptcp connection error" 1>&2
+		mptcp_lib_pr_fail "$msg, mptcp connection error" 1>&2
 		ret=$lret
 		return 1
 	fi
 
-	echo "PASS: $msg"
+	mptcp_lib_pr_info "PASS: $msg"
 	return 0
 }
 
@@ -735,7 +735,7 @@ run_tests_peekmode()
 	local peekmode="$1"
 
 	TEST_GROUP="peek mode: ${peekmode}"
-	echo "INFO: with peek mode: ${peekmode}"
+	mptcp_lib_pr_info "with peek mode: ${peekmode}"
 	run_tests_lo "$ns1" "$ns1" 10.0.1.1 1 "-P ${peekmode}"
 	run_tests_lo "$ns1" "$ns1" dead:beef:1::1 1 "-P ${peekmode}"
 }
@@ -745,12 +745,12 @@ run_tests_mptfo()
 	TEST_GROUP="MPTFO"
 
 	if ! mptcp_lib_kallsyms_has "mptcp_fastopen_"; then
-		echo "INFO: TFO not supported by the kernel: SKIP"
+		mptcp_lib_pr_skip "TFO not supported by the kernel"
 		mptcp_lib_result_skip "${TEST_GROUP}"
 		return
 	fi
 
-	echo "INFO: with MPTFO start"
+	mptcp_lib_pr_info "with MPTFO start"
 	ip netns exec "$ns1" sysctl -q net.ipv4.tcp_fastopen=2
 	ip netns exec "$ns2" sysctl -q net.ipv4.tcp_fastopen=1
 
@@ -762,7 +762,7 @@ run_tests_mptfo()
 
 	ip netns exec "$ns1" sysctl -q net.ipv4.tcp_fastopen=0
 	ip netns exec "$ns2" sysctl -q net.ipv4.tcp_fastopen=0
-	echo "INFO: with MPTFO end"
+	mptcp_lib_pr_info "with MPTFO end"
 }
 
 run_tests_disconnect()
@@ -773,7 +773,7 @@ run_tests_disconnect()
 	TEST_GROUP="full disconnect"
 
 	if ! mptcp_lib_kallsyms_has "mptcp_pm_data_reset$"; then
-		echo "INFO: Full disconnect not supported: SKIP"
+		mptcp_lib_pr_skip "Full disconnect not supported"
 		mptcp_lib_result_skip "${TEST_GROUP}"
 		return
 	fi
@@ -786,7 +786,7 @@ run_tests_disconnect()
 	cin_disconnect="$old_cin"
 	connect_per_transfer=3
 
-	echo "INFO: disconnect"
+	mptcp_lib_pr_info "disconnect"
 	run_tests_lo "$ns1" "$ns1" 10.0.1.1 1 "-I 3 -i $old_cin"
 	run_tests_lo "$ns1" "$ns1" dead:beef:1::1 1 "-I 3 -i $old_cin"
 
@@ -810,7 +810,7 @@ log_if_error()
 	local msg="$1"
 
 	if [ ${ret} -ne 0 ]; then
-		echo "FAIL: ${msg}" 1>&2
+		mptcp_lib_pr_fail "${msg}" 1>&2
 
 		final_ret=${ret}
 		ret=0
@@ -835,7 +835,7 @@ check_mptcp_disabled
 
 stop_if_error "The kernel configuration is not valid for MPTCP"
 
-echo "INFO: validating network environment with pings"
+mptcp_lib_pr_info "validating network environment with pings"
 for sender in "$ns1" "$ns2" "$ns3" "$ns4";do
 	do_ping "$ns1" $sender 10.0.1.1
 	do_ping "$ns1" $sender dead:beef:1::1
@@ -859,7 +859,7 @@ mptcp_lib_result_code "${ret}" "ping tests"
 stop_if_error "Could not even run ping tests"
 
 [ -n "$tc_loss" ] && tc -net "$ns2" qdisc add dev ns2eth3 root netem loss random $tc_loss delay ${tc_delay}ms
-echo -n "INFO: Using loss of $tc_loss "
+mptcp_lib_pr_info "Using loss of $tc_loss "
 test "$tc_delay" -gt 0 && echo -n "delay $tc_delay ms "
 
 reorder_delay=$((tc_delay / 4))
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 3f5b16fe5220..58fe4dad9d9d 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -55,6 +55,9 @@ mptcp_lib_pr_ok() {
 mptcp_lib_pr_skip() {
 	local msg="[SKIP]"
 
+	if [ "${#}" -gt 0 ]; then
+		msg+="${1:+ ${*}}"
+	fi
 	mptcp_lib_print_warn "${msg}"
 }
 
@@ -101,14 +104,14 @@ mptcp_lib_has_file() {
 
 mptcp_lib_check_mptcp() {
 	if ! mptcp_lib_has_file "/proc/sys/net/mptcp/enabled"; then
-		echo "SKIP: MPTCP support is not available"
+		mptcp_lib_pr_skip "MPTCP support is not available"
 		exit ${KSFT_SKIP}
 	fi
 }
 
 mptcp_lib_check_kallsyms() {
 	if ! mptcp_lib_has_file "/proc/kallsyms"; then
-		echo "SKIP: CONFIG_KALLSYMS is missing"
+		mptcp_lib_pr_skip "CONFIG_KALLSYMS is missing"
 		exit ${KSFT_SKIP}
 	fi
 }
@@ -315,7 +318,7 @@ mptcp_lib_check_transfer() {
 	local what="${3}"
 
 	if ! cmp "$in" "$out" > /dev/null 2>&1; then
-		echo "[ FAIL ] $what does not match (in, out):"
+		mptcp_lib_pr_fail "$what does not match (in, out):"
 		mptcp_lib_print_file_err "$in"
 		mptcp_lib_print_file_err "$out"
 
@@ -350,24 +353,24 @@ mptcp_lib_check_tools() {
 		case "${tool}" in
 		"ip")
 			if ! ip -Version &> /dev/null; then
-				mptcp_lib_print_warn "SKIP: Could not run test without ip tool"
+				mptcp_lib_pr_skip "Could not run test without ip tool"
 				exit ${KSFT_SKIP}
 			fi
 			;;
 		"ss")
 			if ! ss -h | grep -q MPTCP; then
-				mptcp_lib_print_warn "SKIP: ss tool does not support MPTCP"
+				mptcp_lib_pr_skip "ss tool does not support MPTCP"
 				exit ${KSFT_SKIP}
 			fi
 			;;
 		"iptables"* | "ip6tables"*)
 			if ! "${tool}" -V &> /dev/null; then
-				mptcp_lib_print_warn "SKIP: Could not run all tests without ${tool}"
+				mptcp_lib_pr_skip "Could not run all tests without ${tool}"
 				exit ${KSFT_SKIP}
 			fi
 			;;
 		*)
-			mptcp_lib_print_err "Internal error: unsupported tool: ${tool}"
+			mptcp_lib_pr_fail "Internal error: unsupported tool: ${tool}"
 			exit ${KSFT_FAIL}
 			;;
 		esac
@@ -386,13 +389,13 @@ mptcp_lib_check_output() {
 	fi
 
 	if [ ${cmd_ret} -ne 0 ]; then
-		mptcp_lib_print_err "[FAIL] command execution '${cmd}' stderr"
+		mptcp_lib_pr_fail "command execution '${cmd}' stderr"
 		cat "${err}"
 		return 2
 	elif [ "${out}" = "${expected}" ]; then
 		return 0
 	else
-		mptcp_lib_print_err "[FAIL] expected '${expected}' got '${out}'"
+		mptcp_lib_pr_fail "expected '${expected}' got '${out}'"
 		return 1
 	fi
 }
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 6ed4aa32222f..ccc941e1e7bb 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -103,7 +103,8 @@ check_mark()
 	local v
 	for v in $values; do
 		if [ $v -ne 0 ]; then
-			echo "FAIL: got $tables $values in ns $ns , not 0 - not all expected packets marked" 1>&2
+			mptcp_lib_pr_fail "got $tables $values in ns $ns, \
+not 0 - not all expected packets marked" 1>&2
 			ret=1
 			return 1
 		fi
@@ -212,7 +213,7 @@ do_mptcp_sockopt_tests()
 	local lret=0
 
 	if ! mptcp_lib_kallsyms_has "mptcp_diag_fill_info$"; then
-		echo "INFO: MPTCP sockopt not supported: SKIP"
+		mptcp_lib_pr_skip "INFO: MPTCP sockopt not supported"
 		mptcp_lib_result_skip "sockopt"
 		return
 	fi
@@ -221,7 +222,7 @@ do_mptcp_sockopt_tests()
 	lret=$?
 
 	if [ $lret -ne 0 ]; then
-		echo "FAIL: SOL_MPTCP getsockopt" 1>&2
+		mptcp_lib_pr_fail "SOL_MPTCP getsockopt" 1>&2
 		mptcp_lib_result_fail "sockopt v4"
 		ret=$lret
 		return
@@ -232,7 +233,7 @@ do_mptcp_sockopt_tests()
 	lret=$?
 
 	if [ $lret -ne 0 ]; then
-		echo "FAIL: SOL_MPTCP getsockopt (ipv6)" 1>&2
+		mptcp_lib_pr_fail "SOL_MPTCP getsockopt (ipv6)" 1>&2
 		mptcp_lib_result_fail "sockopt v6"
 		ret=$lret
 		return
@@ -263,12 +264,12 @@ do_tcpinq_test()
 	local lret=$?
 	if [ $lret -ne 0 ];then
 		ret=$lret
-		echo "FAIL: mptcp_inq $*" 1>&2
+		mptcp_lib_pr_fail "mptcp_inq $*" 1>&2
 		mptcp_lib_result_fail "TCP_INQ: $*"
 		return $lret
 	fi
 
-	echo "PASS: TCP_INQ cmsg/ioctl $*"
+	mptcp_lib_pr_info "PASS: TCP_INQ cmsg/ioctl $*"
 	mptcp_lib_result_pass "TCP_INQ: $*"
 	return $lret
 }
@@ -278,7 +279,7 @@ do_tcpinq_tests()
 	local lret=0
 
 	if ! mptcp_lib_kallsyms_has "mptcp_ioctl$"; then
-		echo "INFO: TCP_INQ not supported: SKIP"
+		mptcp_lib_pr_skip "INFO: TCP_INQ not supported"
 		mptcp_lib_result_skip "TCP_INQ"
 		return
 	fi
@@ -315,12 +316,12 @@ run_tests $ns1 $ns2 10.0.1.1
 run_tests $ns1 $ns2 dead:beef:1::1
 
 if [ $ret -eq 0 ];then
-	echo "PASS: all packets had packet mark set"
+	mptcp_lib_pr_info "PASS: all packets had packet mark set"
 fi
 
 do_mptcp_sockopt_tests
 if [ $ret -eq 0 ];then
-	echo "PASS: SOL_MPTCP getsockopt has expected information"
+	mptcp_lib_pr_info "PASS: SOL_MPTCP getsockopt has expected information"
 fi
 
 do_tcpinq_tests
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 427fc5c70b3c..ffa79df99d38 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -189,7 +189,8 @@ subflow,backup,fullmesh 10.0.1.1" "          (backup,fullmesh)"
 else
 	for st in fullmesh nofullmesh backup,fullmesh; do
 		st="          (${st})"
-		printf "%-50s%s\n" "${st}" "[SKIP]"
+		printf "%-50s" "${st}"
+		mptcp_lib_pr_skip
 		mptcp_lib_result_skip "${st}"
 	done
 fi
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 467feb17e07b..af6d9a81c317 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -187,12 +187,12 @@ do_transfer()
 	printf "%-16s" " max $max_time "
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ] && \
 	   [ $cmpc -eq 0 ] && [ $cmps -eq 0 ]; then
-		echo "[ OK ]"
+		mptcp_lib_pr_ok
 		cat "$capout"
 		return 0
 	fi
 
-	echo " [ fail ]"
+	mptcp_lib_pr_fail
 	echo "client exit code $retc, server $rets" 1>&2
 	echo -e "\nnetns ${ns3} socket stat for $port:" 1>&2
 	ip netns exec ${ns3} ss -nita 1>&2 -o "sport = :$port"
-- 
2.40.1

