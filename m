Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D746089C
	for <mptcp@lists.linux.dev>; Thu, 29 Feb 2024 09:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709200294; cv=none; b=pLfBoiqHU6Wl9AGpWxMm/NXF7i5o3JFqTu+MC6jpkT+7lG4c0ZR6QRENSIOxTkj/Va1NZ5LcbcQRgctZvg7gV0DUQXDE+dALr3W7qI8XFsNRCQJD81SoAUko0miJj7TzCFOpV7tpLEDrZ5UY0j1fk6zgkshFP7tcXpXA7QLmqDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709200294; c=relaxed/simple;
	bh=MsNlSe2x7/vsK8bOU+yw0YVx39ufWJv6xuDKJ8rgkjo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IgR9kJ8gZJ5cvjjjT8u1D4uWkBn5oKi/ZaG1KpcTrGhFiz4MTIsXP7tE3XAj4bKH7mqlCehNlHPDoaCIMS7nUuKuSHUTJugVb85jZkQ8Wb9h5gtUABRRQM8piXzXb6IBAMSoqwzSFqhakOW1vUFjArIu1vH1nPXqzBiptr3ayd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQWXyQMr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQWXyQMr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2914C43390;
	Thu, 29 Feb 2024 09:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709200294;
	bh=MsNlSe2x7/vsK8bOU+yw0YVx39ufWJv6xuDKJ8rgkjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tQWXyQMrSHE4ueVPKYmpR3zG28IQ/OG2WSHddlfNW2eOmZnJhNIxfluVw+G/N1LJp
	 GdFNyyjnanvNbxdz7KG7LqcX8l7w+TODPlsDCC4XDEXnC5Hs6u+Kp4JBdH0XCuo4e3
	 l9NEnHWeJyDVXHZZrxKQ49tIrgCS3fYINSw/urpN9z8g74929HpFPEVhVKAgtpwJij
	 oaeK9KCUpcnEaq+fRDjMZZLgyjbW1mZ4YZ0+sffFvW7MsXpc3956COCKiiOoasYF73
	 WeqAedqxy07GVmrnXEdEBn3pCAd+qiOfd/uHWAfSsoKYHU67cria7aUTPB+O4OZYYe
	 UBqt091hFt2zA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 8/8] selftests: mptcp: print test results with colors
Date: Thu, 29 Feb 2024 17:51:11 +0800
Message-Id: <81fd6204fc60dd90a4410b3435ab4552402b71c0.1709200070.git.tanggeliang@kylinos.cn>
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

To unify the output formats of all test scripts, this patch adds
four more helpers:

	mptcp_lib_pr_ok()
	mptcp_lib_pr_skip()
	mptcp_lib_pr_fail()
	mptcp_lib_pr_info()

to print out [ OK ], [SKIP], [FAIL] and 'INFO: ' with colors. Use them
in all scripts to print the "ok/skip/fail/info' using the same 'format'.

Having colors helps to quickly identify issues when looking at a long
list of output logs and results.

Note that the mptcp_join.sh tests will now print these keywords with
capital letters, like most of the other tests.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/diag.sh     | 12 ++--
 .../selftests/net/mptcp/mptcp_connect.sh      | 61 +++++++++----------
 .../testing/selftests/net/mptcp/mptcp_join.sh |  6 +-
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 35 ++++++++---
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 25 ++++----
 .../testing/selftests/net/mptcp/pm_netlink.sh |  2 +-
 .../selftests/net/mptcp/simult_flows.sh       |  4 +-
 .../selftests/net/mptcp/userspace_pm.sh       | 18 ++----
 8 files changed, 85 insertions(+), 78 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 74b19b89d6e6..f7a729dfc555 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -57,15 +57,15 @@ __chk_nr()
 	mptcp_lib_print_title "$msg"
 	if [ "$nr" != "$expected" ]; then
 		if [ "$nr" = "$skip" ] && ! mptcp_lib_expect_all_features; then
-			echo "[ skip ] Feature probably not supported"
+			mptcp_lib_pr_skip "Feature probably not supported"
 			mptcp_lib_result_skip "${msg}"
 		else
-			echo "[ fail ] expected $expected found $nr"
+			mptcp_lib_pr_fail "expected $expected found $nr"
 			mptcp_lib_result_fail "${msg}"
 			ret=${KSFT_FAIL}
 		fi
 	else
-		echo "[  ok  ]"
+		mptcp_lib_pr_ok
 		mptcp_lib_result_pass "${msg}"
 	fi
 }
@@ -114,15 +114,15 @@ wait_msk_nr()
 
 	mptcp_lib_print_title "$msg"
 	if [ $i -ge $timeout ]; then
-		echo "[ fail ] timeout while expecting $expected max $max last $nr"
+		mptcp_lib_pr_fail "timeout while expecting $expected max $max last $nr"
 		mptcp_lib_result_fail "${msg} # timeout"
 		ret=${KSFT_FAIL}
 	elif [ $nr != $expected ]; then
-		echo "[ fail ] expected $expected found $nr"
+		mptcp_lib_pr_fail "expected $expected found $nr"
 		mptcp_lib_result_fail "${msg} # unexpected result"
 		ret=${KSFT_FAIL}
 	else
-		echo "[  ok  ]"
+		mptcp_lib_pr_ok
 		mptcp_lib_result_pass "${msg}"
 	fi
 }
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 096ff8941c5b..70acbb19f568 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -218,7 +218,7 @@ set_ethtool_flags() {
 	local flags="$3"
 
 	if ip netns exec $ns ethtool -K $dev $flags 2>/dev/null; then
-		echo "INFO: set $ns dev $dev: ethtool -K $flags"
+		mptcp_lib_pr_info "set $ns dev $dev: ethtool -K $flags"
 	fi
 }
 
@@ -255,7 +255,7 @@ check_mptcp_disabled()
 	mptcp_lib_print_title "New MPTCP socket can be blocked via sysctl"
 	# net.mptcp.enabled should be enabled by default
 	if [ "$(ip netns exec ${disabled_ns} sysctl net.mptcp.enabled | awk '{ print $3 }')" -ne 1 ]; then
-		echo -e "net.mptcp.enabled sysctl is not 1 by default\t\t[ FAIL ]"
+		mptcp_lib_pr_fail "net.mptcp.enabled sysctl is not 1 by default"
 		mptcp_lib_result_fail "net.mptcp.enabled sysctl is not 1 by default"
 		ret=1
 		return 1
@@ -268,13 +268,13 @@ check_mptcp_disabled()
 	mptcp_lib_ns_exit "${disabled_ns}"
 
 	if [ ${err} -eq 0 ]; then
-		echo -e "New MPTCP socket cannot be blocked via sysctl\t\t[ FAIL ]"
+		mptcp_lib_pr_fail "New MPTCP socket cannot be blocked via sysctl"
 		mptcp_lib_result_fail "New MPTCP socket cannot be blocked via sysctl"
 		ret=1
 		return 1
 	fi
 
-	echo "[ OK ]"
+	mptcp_lib_pr_ok
 	mptcp_lib_result_pass "New MPTCP socket can be blocked via sysctl"
 	return 0
 }
@@ -295,7 +295,7 @@ do_ping()
 	ip netns exec ${connector_ns} ping ${ping_args} $connect_addr >/dev/null || rc=1
 
 	if [ $rc -ne 0 ] ; then
-		echo "$listener_ns -> $connect_addr connectivity [ FAIL ]" 1>&2
+		mptcp_lib_pr_fail "$listener_ns -> $connect_addr connectivity"
 		ret=1
 
 		return 1
@@ -330,7 +330,7 @@ do_transfer()
 	fi
 
 	if [ -n "$extra_args" ] && $options_log; then
-		echo "INFO: extra options: $extra_args"
+		mptcp_lib_pr_info "extra options: $extra_args"
 	fi
 	options_log=false
 
@@ -427,7 +427,7 @@ do_transfer()
 	result_msg+=" # time=${duration}ms"
 	printf "(duration %05sms) " "${duration}"
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
-		echo "[ FAIL ] client exit code $retc, server $rets" 1>&2
+		mptcp_lib_pr_fail "client exit code $retc, server $rets"
 		echo -e "\nnetns ${listener_ns} socket stat for ${port}:" 1>&2
 		ip netns exec ${listener_ns} ss -Menita 1>&2 -o "sport = :$port"
 		cat /tmp/${listener_ns}.out
@@ -469,14 +469,14 @@ do_transfer()
 	fi
 
 	if [ ${stat_synrx_now_l} -lt ${expect_synrx} ]; then
-		printf "[ FAIL ] lower MPC SYN rx (%d) than expected (%d)\n" \
-			"${stat_synrx_now_l}" "${expect_synrx}" 1>&2
+		mptcp_lib_pr_fail "lower MPC SYN rx (${stat_synrx_now_l})" \
+				  "than expected (${expect_synrx})"
 		retc=1
 	fi
 	if [ ${stat_ackrx_now_l} -lt ${expect_ackrx} ] && [ ${stat_ooo_now} -eq 0 ]; then
 		if [ ${stat_ooo_now} -eq 0 ]; then
-			printf "[ FAIL ] lower MPC ACK rx (%d) than expected (%d)\n" \
-				"${stat_ackrx_now_l}" "${expect_ackrx}" 1>&2
+			mptcp_lib_pr_fail "lower MPC ACK rx (${stat_ackrx_now_l})" \
+					  "than expected (${expect_ackrx})"
 			rets=1
 		else
 			printf "[ Note ] fallback due to TCP OoO"
@@ -491,19 +491,19 @@ do_transfer()
 
 		local csum_err_s_nr=$((csum_err_s - stat_csum_err_s))
 		if [ $csum_err_s_nr -gt 0 ]; then
-			printf "[ FAIL ]\nserver got %d data checksum error[s]" ${csum_err_s_nr}
+			mptcp_lib_pr_fail "server got ${csum_err_s_nr} data checksum error[s]"
 			rets=1
 		fi
 
 		local csum_err_c_nr=$((csum_err_c - stat_csum_err_c))
 		if [ $csum_err_c_nr -gt 0 ]; then
-			printf "[ FAIL ]\nclient got %d data checksum error[s]" ${csum_err_c_nr}
+			mptcp_lib_pr_fail "client got ${csum_err_c_nr} data checksum error[s]"
 			retc=1
 		fi
 	fi
 
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ]; then
-		printf "[ OK ]"
+		mptcp_lib_pr_ok
 		mptcp_lib_result_pass "${TEST_GROUP}: ${result_msg}"
 	else
 		mptcp_lib_result_fail "${TEST_GROUP}: ${result_msg}"
@@ -534,7 +534,6 @@ do_transfer()
 			"${expect_ackrx}" "${stat_ackrx_now_l}"
 	fi
 
-	echo
 	cat "$capout"
 	[ $retc -eq 0 ] && [ $rets -eq 0 ]
 }
@@ -660,7 +659,7 @@ run_test_transparent()
 	# following function has been exported (T). Not great but better than
 	# checking for a specific kernel version.
 	if ! mptcp_lib_kallsyms_has "T __ip_sock_set_tos$"; then
-		echo "INFO: ${msg} not supported by the kernel: SKIP"
+		mptcp_lib_pr_skip "INFO: ${msg} not supported by the kernel"
 		mptcp_lib_result_skip "${TEST_GROUP}"
 		return
 	fi
@@ -677,7 +676,7 @@ table inet mangle {
 }
 EOF
 	then
-		echo "SKIP: $msg, could not load nft ruleset"
+		mptcp_lib_pr_skip "$msg, could not load nft ruleset"
 		mptcp_lib_fail_if_expected_feature "nft rules"
 		mptcp_lib_result_skip "${TEST_GROUP}"
 		return
@@ -693,7 +692,7 @@ EOF
 
 	if ! ip -net "$listener_ns" $r6flag rule add fwmark 1 lookup 100; then
 		ip netns exec "$listener_ns" nft flush ruleset
-		echo "SKIP: $msg, ip $r6flag rule failed"
+		mptcp_lib_pr_skip "$msg, ip $r6flag rule failed"
 		mptcp_lib_fail_if_expected_feature "ip rule"
 		mptcp_lib_result_skip "${TEST_GROUP}"
 		return
@@ -702,13 +701,13 @@ EOF
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
 
 	PORT=10000
 	local extra_args="-o TRANSPARENT"
@@ -721,12 +720,12 @@ EOF
 	ip -net "$listener_ns" route del local $local_addr/0 dev lo table 100
 
 	if [ $lret -ne 0 ]; then
-		echo "FAIL: $msg, mptcp connection error" 1>&2
+		mptcp_lib_pr_fail "$msg, mptcp connection error"
 		ret=$lret
 		return 1
 	fi
 
-	echo "PASS: $msg"
+	mptcp_lib_pr_info "PASS: $msg"
 	return 0
 }
 
@@ -735,7 +734,7 @@ run_tests_peekmode()
 	local peekmode="$1"
 
 	TEST_GROUP="peek mode: ${peekmode}"
-	echo "INFO: with peek mode: ${peekmode}"
+	mptcp_lib_pr_info "with peek mode: ${peekmode}"
 	run_tests_lo "$ns1" "$ns1" 10.0.1.1 1 "-P ${peekmode}"
 	run_tests_lo "$ns1" "$ns1" dead:beef:1::1 1 "-P ${peekmode}"
 }
@@ -745,12 +744,12 @@ run_tests_mptfo()
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
 
@@ -762,7 +761,7 @@ run_tests_mptfo()
 
 	ip netns exec "$ns1" sysctl -q net.ipv4.tcp_fastopen=0
 	ip netns exec "$ns2" sysctl -q net.ipv4.tcp_fastopen=0
-	echo "INFO: with MPTFO end"
+	mptcp_lib_pr_info "with MPTFO end"
 }
 
 run_tests_disconnect()
@@ -773,7 +772,7 @@ run_tests_disconnect()
 	TEST_GROUP="full disconnect"
 
 	if ! mptcp_lib_kallsyms_has "mptcp_pm_data_reset$"; then
-		echo "INFO: Full disconnect not supported: SKIP"
+		mptcp_lib_pr_skip "Full disconnect not supported"
 		mptcp_lib_result_skip "${TEST_GROUP}"
 		return
 	fi
@@ -786,7 +785,7 @@ run_tests_disconnect()
 	cin_disconnect="$old_cin"
 	connect_per_transfer=3
 
-	echo "INFO: disconnect"
+	mptcp_lib_pr_info "disconnect"
 	run_tests_lo "$ns1" "$ns1" 10.0.1.1 1 "-I 3 -i $old_cin"
 	run_tests_lo "$ns1" "$ns1" dead:beef:1::1 1 "-I 3 -i $old_cin"
 
@@ -810,7 +809,7 @@ log_if_error()
 	local msg="$1"
 
 	if [ ${ret} -ne 0 ]; then
-		echo "FAIL: ${msg}" 1>&2
+		mptcp_lib_pr_fail "${msg}"
 
 		final_ret=${ret}
 		ret=0
@@ -858,11 +857,11 @@ done
 mptcp_lib_result_code "${ret}" "ping tests"
 
 stop_if_error "Could not even run ping tests"
-echo "[ OK ]"
+mptcp_lib_pr_ok
 MPTCP_LIB_TEST_FORMAT="%02u %-50s"
 
 [ -n "$tc_loss" ] && tc -net "$ns2" qdisc add dev ns2eth3 root netem loss random $tc_loss delay ${tc_delay}ms
-echo -n "INFO: Using loss of $tc_loss "
+mptcp_lib_pr_info "Using loss of $tc_loss "
 test "$tc_delay" -gt 0 && echo -n "delay $tc_delay ms "
 
 reorder_delay=$((tc_delay / 4))
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 7acc6064eb17..c3654eb45870 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -190,17 +190,17 @@ print_info()
 
 print_ok()
 {
-	mptcp_lib_print_ok "[ ok ]${1:+ ${*}}"
+	mptcp_lib_pr_ok "${@}"
 }
 
 print_fail()
 {
-	mptcp_lib_print_err "[fail]${1:+ ${*}}"
+	mptcp_lib_pr_fail "${@}"
 }
 
 print_skip()
 {
-	mptcp_lib_print_warn "[skip]${1:+ ${*}}"
+	mptcp_lib_pr_skip "${@}"
 }
 
 # [ $1: fail msg ]
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 358d5b77fc0f..53867f9d212d 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -48,6 +48,23 @@ mptcp_lib_print_err() {
 	mptcp_lib_print_color "${MPTCP_LIB_COLOR_RED}${*}"
 }
 
+#shellcheck disable=SC2120
+mptcp_lib_pr_ok() {
+	mptcp_lib_print_ok "[ OK ]${1:+ ${*}}"
+}
+
+mptcp_lib_pr_skip() {
+	mptcp_lib_print_warn "[SKIP]${1:+ ${*}}"
+}
+
+mptcp_lib_pr_fail() {
+	mptcp_lib_print_err "[FAIL]${1:+ ${*}}"
+}
+
+mptcp_lib_pr_info() {
+	mptcp_lib_print_info "INFO: ${*}"
+}
+
 # SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var can be set when validating all
 # features using the last version of the kernel and the selftests to make sure
 # a test is not being skipped by mistake.
@@ -78,14 +95,14 @@ mptcp_lib_has_file() {
 
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
@@ -292,7 +309,7 @@ mptcp_lib_check_transfer() {
 	local what="${3}"
 
 	if ! cmp "$in" "$out" > /dev/null 2>&1; then
-		echo "[ FAIL ] $what does not match (in, out):"
+		mptcp_lib_pr_fail "$what does not match (in, out):"
 		mptcp_lib_print_file_err "$in"
 		mptcp_lib_print_file_err "$out"
 
@@ -327,24 +344,24 @@ mptcp_lib_check_tools() {
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
@@ -363,13 +380,13 @@ mptcp_lib_check_output() {
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
index a797e13d3fe7..d695561fbf46 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -103,7 +103,8 @@ check_mark()
 	local v
 	for v in $values; do
 		if [ $v -ne 0 ]; then
-			echo "FAIL: got $tables $values in ns $ns , not 0 - not all expected packets marked" 1>&2
+			mptcp_lib_pr_fail "got $tables $values in ns $ns," \
+					  "not 0 - not all expected packets marked"
 			ret=1
 			return 1
 		fi
@@ -175,7 +176,7 @@ do_transfer()
 		ret=1
 		return 1
 	fi
-	echo "[ OK ]"
+	mptcp_lib_pr_ok
 
 	mptcp_lib_print_title "Mark ${ip}"
 	if [ $local_addr = "::" ];then
@@ -193,10 +194,10 @@ do_transfer()
 	mptcp_lib_result_code "${rets}" "transfer ${ip}"
 
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ];then
-		echo "[ OK ]"
+		mptcp_lib_pr_ok
 		return 0
 	fi
-	echo "FAIL: Mark ${ip}"
+	mptcp_lib_pr_fail "Mark ${ip}"
 
 	return 1
 }
@@ -217,7 +218,7 @@ do_mptcp_sockopt_tests()
 	local lret=0
 
 	if ! mptcp_lib_kallsyms_has "mptcp_diag_fill_info$"; then
-		echo "INFO: MPTCP sockopt not supported: SKIP"
+		mptcp_lib_pr_skip "MPTCP sockopt not supported"
 		mptcp_lib_result_skip "sockopt"
 		return
 	fi
@@ -227,12 +228,12 @@ do_mptcp_sockopt_tests()
 
 	mptcp_lib_print_title "SOL_MPTCP sockopt v4"
 	if [ $lret -ne 0 ]; then
-		echo "FAIL: SOL_MPTCP getsockopt" 1>&2
+		mptcp_lib_pr_fail "SOL_MPTCP getsockopt"
 		mptcp_lib_result_fail "sockopt v4"
 		ret=$lret
 		return
 	fi
-	echo "[ OK ]"
+	mptcp_lib_pr_ok
 	mptcp_lib_result_pass "sockopt v4"
 
 	ip netns exec "$ns_sbox" ./mptcp_sockopt -6
@@ -240,12 +241,12 @@ do_mptcp_sockopt_tests()
 
 	mptcp_lib_print_title "SOL_MPTCP sockopt v6"
 	if [ $lret -ne 0 ]; then
-		echo "FAIL: SOL_MPTCP getsockopt (v6)" 1>&2
+		mptcp_lib_pr_fail "SOL_MPTCP getsockopt (v6)"
 		mptcp_lib_result_fail "sockopt v6"
 		ret=$lret
 		return
 	fi
-	echo "[ OK ]"
+	mptcp_lib_pr_ok
 	mptcp_lib_result_pass "sockopt v6"
 }
 
@@ -273,12 +274,12 @@ do_tcpinq_test()
 	local lret=$?
 	if [ $lret -ne 0 ];then
 		ret=$lret
-		echo "FAIL: mptcp_inq $*" 1>&2
+		mptcp_lib_pr_fail "mptcp_inq $*"
 		mptcp_lib_result_fail "TCP_INQ: $*"
 		return $lret
 	fi
 
-	echo "[ OK ]"
+	mptcp_lib_pr_ok
 	mptcp_lib_result_pass "TCP_INQ: $*"
 	return $lret
 }
@@ -288,7 +289,7 @@ do_tcpinq_tests()
 	local lret=0
 
 	if ! mptcp_lib_kallsyms_has "mptcp_ioctl$"; then
-		echo "INFO: TCP_INQ not supported: SKIP"
+		mptcp_lib_pr_skip "INFO: TCP_INQ not supported"
 		mptcp_lib_result_skip "TCP_INQ"
 		return
 	fi
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 5b9bc25dfef4..69ffff8b076b 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -190,7 +190,7 @@ else
 	for st in fullmesh nofullmesh backup,fullmesh; do
 		st="          (${st})"
 		mptcp_lib_print_title "${st}"
-		echo "[SKIP]"
+		mptcp_lib_pr_skip
 		mptcp_lib_result_skip "${st}"
 	done
 fi
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 212782301c6f..c5dbe083e47f 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -185,12 +185,12 @@ do_transfer()
 	printf "%-10s" " max $max_time "
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
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 62e059e3fb24..0c5ba35f6af4 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -61,7 +61,7 @@ _printf() {
 
 print_title()
 {
-	_printf "INFO: %s\n" "${1}"
+	mptcp_lib_pr_info "${1}"
 }
 
 # $1: test name
@@ -73,33 +73,23 @@ print_test()
 	mptcp_lib_print_title "${test_name}"
 }
 
-print_results()
-{
-	_printf "[%s]\n" "${1}"
-}
-
 test_pass()
 {
-	print_results " OK "
+	mptcp_lib_pr_ok
 	mptcp_lib_result_pass "${test_name}"
 }
 
 test_skip()
 {
-	print_results "SKIP"
+	mptcp_lib_pr_skip
 	mptcp_lib_result_skip "${test_name}"
 }
 
 # $1: msg
 test_fail()
 {
-	print_results "FAIL"
+	mptcp_lib_pr_fail "${@}"
 	ret=1
-
-	if [ -n "${1}" ]; then
-		_printf "\t%s\n" "${1}"
-	fi
-
 	mptcp_lib_result_fail "${test_name}"
 }
 
-- 
2.40.1

