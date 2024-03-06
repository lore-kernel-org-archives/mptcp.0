Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6772CA7
	for <mptcp@lists.linux.dev>; Wed,  6 Mar 2024 01:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709689280; cv=none; b=oakpQqwK++mZEA3auSo9maOTsyQ0fYuSIRkiQjYRz4WR53IB89Dqry7xMIiUJQKFFKHZhE1HWcLlogaUOGopwX/X/8pNW0kQamRvA3a6h1E17zAw+8fKz23lh7Lil9+y8iCrL6zMoJ9KmUkfHu/d6WiyU3Vrd6h/J/JcMtBdiFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709689280; c=relaxed/simple;
	bh=Gp41un7LFmlmHL14j/3fXrXeqozmkNkklxMZSNUWSN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UMjQzyiAatLtkgpnQ3MZmWHKrr+pqWrCpLyl/OCBuJxT9Ni06F0I7Nmg93sMYwZw9J7CJ4RWy38K7hRePuzxNHUWeSffLCYpoimN8F8ztFjrf4xQRoVRce3y/VA8tn9n3wre6fD8lCOWxxCkOyTPajEtwlzAXi8hE+rWv9+9u3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNm+y+p3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNm+y+p3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E6AC433F1;
	Wed,  6 Mar 2024 01:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709689280;
	bh=Gp41un7LFmlmHL14j/3fXrXeqozmkNkklxMZSNUWSN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kNm+y+p3Fy5iNeZFQSyt0sZl+SQdgEzd9obNB4s5jlxZ0azW47jR52TiWxjQOrHQO
	 SUSSl6LLM4Re6I+xq/+3i0AAiyGvPT7aR0LNU332CuRIc7/vYxV+/xsA5ptmY4JvgE
	 ljc6EmX5DpQxFZZaiXorzF4EAUmFMPLy4OANOSY7u2qLOaQGU0+pvRNPcSfO8NJfAi
	 q7r3PAMfsAIzHmhsG7x+HGtdKjbhZZPSjrcescS4B0u4SFtKHLQ59ZAH4Nb6/5NATq
	 pra4h6Y6cCj+V3gIZ0JcC7UHebli3mool7+5yeoUCS1pUERCjgVMWPJ9QEJ5XP8BVb
	 CDwoWKJxBE8OQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v13 9/9] selftests: mptcp: print test results with colors
Date: Wed,  6 Mar 2024 09:40:59 +0800
Message-Id: <3903335eb71697af9348119b569e29c50c9e741d.1709688778.git.tanggeliang@kylinos.cn>
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

Note that now all print the same keywords, which was not the case
before, but it is good to uniform that.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/diag.sh     | 12 ++--
 .../selftests/net/mptcp/mptcp_connect.sh      | 62 +++++++++----------
 .../testing/selftests/net/mptcp/mptcp_join.sh |  6 +-
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 32 +++++++---
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 28 ++++-----
 .../testing/selftests/net/mptcp/pm_netlink.sh |  2 +-
 .../selftests/net/mptcp/simult_flows.sh       |  4 +-
 .../selftests/net/mptcp/userspace_pm.sh       | 24 ++-----
 8 files changed, 87 insertions(+), 83 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 4ffdd415e670..bc97ab33a00e 100755
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
index d99e4ba96343..abed107ee718 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -218,7 +218,7 @@ set_ethtool_flags() {
 	local flags="$3"
 
 	if ip netns exec $ns ethtool -K $dev $flags 2>/dev/null; then
-		echo "INFO: set $ns dev $dev: ethtool -K $flags"
+		mptcp_lib_pr_info "set $ns dev $dev: ethtool -K $flags"
 	fi
 }
 
@@ -261,7 +261,7 @@ check_mptcp_disabled()
 	print_larger_title "New MPTCP socket can be blocked via sysctl"
 	# net.mptcp.enabled should be enabled by default
 	if [ "$(ip netns exec ${disabled_ns} sysctl net.mptcp.enabled | awk '{ print $3 }')" -ne 1 ]; then
-		echo -e "net.mptcp.enabled sysctl is not 1 by default\t\t[ FAIL ]"
+		mptcp_lib_pr_fail "net.mptcp.enabled sysctl is not 1 by default"
 		mptcp_lib_result_fail "net.mptcp.enabled sysctl is not 1 by default"
 		ret=1
 		return 1
@@ -274,13 +274,13 @@ check_mptcp_disabled()
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
@@ -301,7 +301,7 @@ do_ping()
 	ip netns exec ${connector_ns} ping ${ping_args} $connect_addr >/dev/null || rc=1
 
 	if [ $rc -ne 0 ] ; then
-		echo "$listener_ns -> $connect_addr connectivity [ FAIL ]"
+		mptcp_lib_pr_fail "$listener_ns -> $connect_addr connectivity"
 		ret=1
 
 		return 1
@@ -336,7 +336,7 @@ do_transfer()
 	fi
 
 	if [ -n "$extra_args" ] && $options_log; then
-		echo "INFO: extra options: $extra_args"
+		mptcp_lib_pr_info "extra options: $extra_args"
 	fi
 	options_log=false
 
@@ -433,7 +433,7 @@ do_transfer()
 	result_msg+=" # time=${duration}ms"
 	printf "(duration %05sms) " "${duration}"
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
-		echo "[ FAIL ] client exit code $retc, server $rets" 1>&2
+		mptcp_lib_pr_fail "client exit code $retc, server $rets"
 		echo -e "\nnetns ${listener_ns} socket stat for ${port}:" 1>&2
 		ip netns exec ${listener_ns} ss -Menita 1>&2 -o "sport = :$port"
 		cat /tmp/${listener_ns}.out
@@ -475,14 +475,14 @@ do_transfer()
 	fi
 
 	if [ ${stat_synrx_now_l} -lt ${expect_synrx} ]; then
-		printf "[ FAIL ] lower MPC SYN rx (%d) than expected (%d)\n" \
-			"${stat_synrx_now_l}" "${expect_synrx}"
+		mptcp_lib_pr_fail "lower MPC SYN rx (${stat_synrx_now_l})" \
+				  "than expected (${expect_synrx})"
 		retc=1
 	fi
 	if [ ${stat_ackrx_now_l} -lt ${expect_ackrx} ] && [ ${stat_ooo_now} -eq 0 ]; then
 		if [ ${stat_ooo_now} -eq 0 ]; then
-			printf "[ FAIL ] lower MPC ACK rx (%d) than expected (%d)\n" \
-				"${stat_ackrx_now_l}" "${expect_ackrx}"
+			mptcp_lib_pr_fail "lower MPC ACK rx (${stat_ackrx_now_l})" \
+					  "than expected (${expect_ackrx})"
 			rets=1
 		else
 			printf "[ Note ] fallback due to TCP OoO"
@@ -497,13 +497,13 @@ do_transfer()
 
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
@@ -536,11 +536,11 @@ do_transfer()
 	fi
 
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ]; then
-		printf "[ OK ]%s\n" "${extra:1}"
+		mptcp_lib_pr_ok "${extra:1}"
 		mptcp_lib_result_pass "${TEST_GROUP}: ${result_msg}"
 	else
 		if [ -n "${extra}" ]; then
-			printf "%s\n" "${extra:1}"
+			mptcp_lib_print_warn "${extra:1}"
 		fi
 		mptcp_lib_result_fail "${TEST_GROUP}: ${result_msg}"
 	fi
@@ -670,7 +670,7 @@ run_test_transparent()
 	# following function has been exported (T). Not great but better than
 	# checking for a specific kernel version.
 	if ! mptcp_lib_kallsyms_has "T __ip_sock_set_tos$"; then
-		echo "INFO: ${msg} not supported by the kernel: SKIP"
+		mptcp_lib_pr_skip "${msg} not supported by the kernel"
 		mptcp_lib_result_skip "${TEST_GROUP}"
 		return
 	fi
@@ -687,7 +687,7 @@ table inet mangle {
 }
 EOF
 	then
-		echo "SKIP: $msg, could not load nft ruleset"
+		mptcp_lib_pr_skip "$msg, could not load nft ruleset"
 		mptcp_lib_fail_if_expected_feature "nft rules"
 		mptcp_lib_result_skip "${TEST_GROUP}"
 		return
@@ -703,7 +703,7 @@ EOF
 
 	if ! ip -net "$listener_ns" $r6flag rule add fwmark 1 lookup 100; then
 		ip netns exec "$listener_ns" nft flush ruleset
-		echo "SKIP: $msg, ip $r6flag rule failed"
+		mptcp_lib_pr_skip "$msg, ip $r6flag rule failed"
 		mptcp_lib_fail_if_expected_feature "ip rule"
 		mptcp_lib_result_skip "${TEST_GROUP}"
 		return
@@ -712,13 +712,13 @@ EOF
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
 
 	port_base=20000
 	local extra_args="-o TRANSPARENT"
@@ -731,12 +731,12 @@ EOF
 	ip -net "$listener_ns" route del local $local_addr/0 dev lo table 100
 
 	if [ $lret -ne 0 ]; then
-		echo "FAIL: $msg, mptcp connection error"
+		mptcp_lib_pr_fail "$msg, mptcp connection error"
 		ret=$lret
 		return 1
 	fi
 
-	echo "PASS: $msg"
+	mptcp_lib_pr_info "$msg pass"
 	return 0
 }
 
@@ -745,7 +745,7 @@ run_tests_peekmode()
 	local peekmode="$1"
 
 	TEST_GROUP="peek mode: ${peekmode}"
-	echo "INFO: with peek mode: ${peekmode}"
+	mptcp_lib_pr_info "with peek mode: ${peekmode}"
 	run_tests_lo "$ns1" "$ns1" 10.0.1.1 1 "-P ${peekmode}"
 	run_tests_lo "$ns1" "$ns1" dead:beef:1::1 1 "-P ${peekmode}"
 }
@@ -755,12 +755,12 @@ run_tests_mptfo()
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
 
@@ -772,7 +772,7 @@ run_tests_mptfo()
 
 	ip netns exec "$ns1" sysctl -q net.ipv4.tcp_fastopen=0
 	ip netns exec "$ns2" sysctl -q net.ipv4.tcp_fastopen=0
-	echo "INFO: with MPTFO end"
+	mptcp_lib_pr_info "with MPTFO end"
 }
 
 run_tests_disconnect()
@@ -783,7 +783,7 @@ run_tests_disconnect()
 	TEST_GROUP="full disconnect"
 
 	if ! mptcp_lib_kallsyms_has "mptcp_pm_data_reset$"; then
-		echo "INFO: Full disconnect not supported: SKIP"
+		mptcp_lib_pr_skip "Full disconnect not supported"
 		mptcp_lib_result_skip "${TEST_GROUP}"
 		return
 	fi
@@ -796,7 +796,7 @@ run_tests_disconnect()
 	cin_disconnect="$old_cin"
 	connect_per_transfer=3
 
-	echo "INFO: disconnect"
+	mptcp_lib_pr_info "disconnect"
 	run_tests_lo "$ns1" "$ns1" 10.0.1.1 1 "-I 3 -i $old_cin"
 	run_tests_lo "$ns1" "$ns1" dead:beef:1::1 1 "-I 3 -i $old_cin"
 
@@ -820,7 +820,7 @@ log_if_error()
 	local msg="$1"
 
 	if [ ${ret} -ne 0 ]; then
-		echo "FAIL: ${msg}"
+		mptcp_lib_pr_fail "${msg}"
 
 		final_ret=${ret}
 		ret=0
@@ -867,7 +867,7 @@ done
 mptcp_lib_result_code "${ret}" "ping tests"
 
 stop_if_error "Could not even run ping tests"
-echo "[ OK ]"
+mptcp_lib_pr_ok
 
 [ -n "$tc_loss" ] && tc -net "$ns2" qdisc add dev ns2eth3 root netem loss random $tc_loss delay ${tc_delay}ms
 tc_info="loss of $tc_loss "
@@ -892,7 +892,7 @@ elif [ "$reorder_delay" -gt 0 ];then
 	tc_info+="$tc_reorder with delay ${reorder_delay}ms "
 fi
 
-echo "INFO: Using ${tc_info}on ns3eth4"
+mptcp_lib_pr_info "Using ${tc_info}on ns3eth4"
 
 tc -net "$ns3" qdisc add dev ns3eth4 root netem delay ${reorder_delay}ms $tc_reorder
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 2f34e2b9a1c4..cecf09d14f46 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -185,17 +185,17 @@ print_info()
 
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
index eb740a2f7898..d623c3c418be 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -50,6 +50,23 @@ mptcp_lib_print_err() {
 	mptcp_lib_print_color "${MPTCP_LIB_COLOR_RED}${*}"
 }
 
+# shellcheck disable=SC2120 # parameters are optional
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
@@ -80,14 +97,14 @@ mptcp_lib_has_file() {
 
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
@@ -294,7 +311,7 @@ mptcp_lib_check_transfer() {
 	local what="${3}"
 
 	if ! cmp "$in" "$out" > /dev/null 2>&1; then
-		echo "[ FAIL ] $what does not match (in, out):"
+		mptcp_lib_pr_fail "$what does not match (in, out):"
 		mptcp_lib_print_file_err "$in"
 		mptcp_lib_print_file_err "$out"
 
@@ -352,29 +369,30 @@ mptcp_lib_check_tools() {
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
 	done
 }
+
 mptcp_lib_ns_init() {
 	local sec rndh
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 466800326cbb..22c185124328 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -103,8 +103,8 @@ check_mark()
 	local v
 	for v in $values; do
 		if [ $v -ne 0 ]; then
-			echo "FAIL: got $tables $values in ns $ns," \
-			     "not 0 - not all expected packets marked"
+			mptcp_lib_pr_fail "got $tables $values in ns $ns," \
+					  "not 0 - not all expected packets marked"
 			ret=1
 			return 1
 		fi
@@ -164,7 +164,7 @@ do_transfer()
 
 	mptcp_lib_print_title "Transfer ${ip:2}"
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
-		echo "[FAIL] client exit code $retc, server $rets"
+		mptcp_lib_pr_fail "client exit code $retc, server $rets"
 		echo -e "\nnetns ${listener_ns} socket stat for ${port}:" 1>&2
 		ip netns exec ${listener_ns} ss -Menita 1>&2 -o "sport = :$port"
 
@@ -179,7 +179,7 @@ do_transfer()
 	if ! mptcp_lib_check_transfer $cin $sout "file received by server"; then
 		rets=1
 	else
-		echo "[ OK ]"
+		mptcp_lib_pr_ok
 	fi
 	mptcp_lib_result_code "${rets}" "transfer ${ip}"
 
@@ -195,10 +195,10 @@ do_transfer()
 	mptcp_lib_result_code "${retc}" "mark ${ip}"
 
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ];then
-		echo "[ OK ]"
+		mptcp_lib_pr_ok
 		return 0
 	fi
-	echo "[FAIL]"
+	mptcp_lib_pr_fail
 
 	return 1
 }
@@ -219,7 +219,7 @@ do_mptcp_sockopt_tests()
 	local lret=0
 
 	if ! mptcp_lib_kallsyms_has "mptcp_diag_fill_info$"; then
-		echo "INFO: MPTCP sockopt not supported: SKIP"
+		mptcp_lib_pr_skip "MPTCP sockopt not supported"
 		mptcp_lib_result_skip "sockopt"
 		return
 	fi
@@ -229,12 +229,12 @@ do_mptcp_sockopt_tests()
 
 	mptcp_lib_print_title "SOL_MPTCP sockopt v4"
 	if [ $lret -ne 0 ]; then
-		echo "[FAIL]"
+		mptcp_lib_pr_fail
 		mptcp_lib_result_fail "sockopt v4"
 		ret=$lret
 		return
 	fi
-	echo "[ OK ]"
+	mptcp_lib_pr_ok
 	mptcp_lib_result_pass "sockopt v4"
 
 	ip netns exec "$ns_sbox" ./mptcp_sockopt -6
@@ -242,12 +242,12 @@ do_mptcp_sockopt_tests()
 
 	mptcp_lib_print_title "SOL_MPTCP sockopt v6"
 	if [ $lret -ne 0 ]; then
-		echo "[FAIL]"
+		mptcp_lib_pr_fail
 		mptcp_lib_result_fail "sockopt v6"
 		ret=$lret
 		return
 	fi
-	echo "[ OK ]"
+	mptcp_lib_pr_ok
 	mptcp_lib_result_pass "sockopt v6"
 }
 
@@ -275,12 +275,12 @@ do_tcpinq_test()
 	local lret=$?
 	if [ $lret -ne 0 ];then
 		ret=$lret
-		echo "[FAIL]"
+		mptcp_lib_pr_fail
 		mptcp_lib_result_fail "TCP_INQ: $*"
 		return $lret
 	fi
 
-	echo "[ OK ]"
+	mptcp_lib_pr_ok
 	mptcp_lib_result_pass "TCP_INQ: $*"
 	return $lret
 }
@@ -290,7 +290,7 @@ do_tcpinq_tests()
 	local lret=0
 
 	if ! mptcp_lib_kallsyms_has "mptcp_ioctl$"; then
-		echo "INFO: TCP_INQ not supported: SKIP"
+		mptcp_lib_pr_skip "TCP_INQ not supported"
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
index 03fd08e8e044..4ee18406ee50 100755
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
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index ca238592baee..9fc9e574bc27 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -57,13 +57,9 @@ test_name=""
 # a bit more space: because we have more to display
 MPTCP_LIB_TEST_FORMAT="%02u %-68s"
 
-_printf() {
-	stdbuf -o0 -e0 printf "${@}"
-}
-
 print_title()
 {
-	_printf "INFO: %s\n" "${1}"
+	mptcp_lib_pr_info "${1}"
 }
 
 # $1: test name
@@ -74,33 +70,23 @@ print_test()
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
 
@@ -122,7 +108,7 @@ cleanup()
 
 	rm -rf $file $client_evts $server_evts
 
-	_printf "Done\n"
+	mptcp_lib_pr_info "Done"
 }
 
 trap cleanup EXIT
-- 
2.40.1

