Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1BABA5F
	for <mptcp@lists.linux.dev>; Fri, 23 Feb 2024 03:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708657702; cv=none; b=r/QxgPY7ZMvA+Rn8mSISjH3yiWiSJb6e/wFuioPefW4KjjoHPBlcixy4VJMhfiCofDvluc9Mw4e/BplBVe0WtXqDi8K6UyMqwblt3xjoTtpVmqYvE6jqUCxd9rCJn/EcAA3KWDmZHDpyOGyNRQT6BR7G+WIb2cECNjj8QMvvibA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708657702; c=relaxed/simple;
	bh=EVZ44CdOzOgcNwRJZ5qsbW3kiaxalloX9GgQxLaRaDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d0LKaXagh3FlWWsTawGTVfX5VtLO0B96aeVhmV6siR04glllieTxC42Jas5zPzsuJu+jQdwsM6y4mOidoFW4Oa3OFh5HVvGqwt8yUVyNs/QadSv0ghAI5choVkNWIliH5HzDDeE5FIgXokOB3aoAGMs0vs113yZ7G+RgldosHoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tsy8giHR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tsy8giHR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7C5C433F1;
	Fri, 23 Feb 2024 03:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708657701;
	bh=EVZ44CdOzOgcNwRJZ5qsbW3kiaxalloX9GgQxLaRaDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tsy8giHRw9MCbuTL4UjfpBkI1wvEOepTYUu5aNveCLUFkVi4m5lHVAc87ESvhWUyV
	 bCINdT78Eo8TXGPzjWMQgVAMpb/+vnyS9aiQM2VcnYK6YA7kzWoIiRxCUHI6utr7/Y
	 VIUClaWvJszzNJm+Mklfb4IEdwgGHhHGQIAH2KL8ZH01L4D9v7qog1f+HWqDIU/eg7
	 bwPopbSboswVvcld2HkkxBykWdFsQNpE6zuIpsOnmPsrBkTDJ/ckqoAKSmjhSTbt9J
	 y7851Kj1rQH/8S/fimtLxR+BLU2V0QtvDnImjt3yTpfhCeIxABbwzTQS2jzHDo7hUr
	 GH37KFmID2pxw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 4/8] selftests: mptcp: print test results with colors
Date: Fri, 23 Feb 2024 11:08:07 +0800
Message-Id: <d6e23e9c2084927be6b58e85f73f72a84a2a4b04.1708657487.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708657486.git.tanggeliang@kylinos.cn>
References: <cover.1708657486.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The helper mptcp_lib_verify_listener_events() will be added latter in
mptcp_lib.sh, and be used by mptcp_join.sh and userspace_pm.sh. The
former prints colored output while the latter is not. It makes sense
to unify them.

This patch uses mptcp_lib_print_ok(), _warn(), _err() and _info() helpers
in scripts diag.sh, mptcp_connect.sh, mptcp_sockopt.sh, pm_netlink.sh,
simult_flows.sh and userspace_pm.sh to print test results with colors.

Having colors helps to quickly identify issues when looking at a long
list of output logs and results.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/diag.sh     | 12 +++++-----
 .../selftests/net/mptcp/mptcp_connect.sh      | 24 ++++++++++---------
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 16 ++++++-------
 .../testing/selftests/net/mptcp/pm_netlink.sh |  3 ++-
 .../selftests/net/mptcp/simult_flows.sh       |  4 ++--
 .../selftests/net/mptcp/userspace_pm.sh       | 13 ++++------
 6 files changed, 35 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index ce2e78e6f65b..b113e64e8191 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -58,15 +58,15 @@ __chk_nr()
 	printf "%-50s" "$msg"
 	if [ "$nr" != "$expected" ]; then
 		if [ "$nr" = "$skip" ] && ! mptcp_lib_expect_all_features; then
-			echo "[SKIP] Feature probably not supported"
+			mptcp_lib_print_warn "[SKIP] Feature probably not supported"
 			mptcp_lib_result_skip "${msg}"
 		else
-			echo "[FAIL] expected $expected found $nr"
+			mptcp_lib_print_err "[FAIL] expected $expected found $nr"
 			mptcp_lib_result_fail "${msg}"
 			ret=$TEST_COUNT
 		fi
 	else
-		echo "[ OK ]"
+		mptcp_lib_print_ok "[ OK ]"
 		mptcp_lib_result_pass "${msg}"
 	fi
 	TEST_COUNT=$((TEST_COUNT+1))
@@ -116,15 +116,15 @@ wait_msk_nr()
 
 	printf "%-50s" "$msg"
 	if [ $i -ge $timeout ]; then
-		echo "[FAIL] timeout while expecting $expected max $max last $nr"
+		mptcp_lib_print_err "[FAIL] timeout while expecting $expected max $max last $nr"
 		mptcp_lib_result_fail "${msg} # timeout"
 		ret=$TEST_COUNT
 	elif [ $nr != $expected ]; then
-		echo "[FAIL] expected $expected found $nr"
+		mptcp_lib_print_err "[FAIL] expected $expected found $nr"
 		mptcp_lib_result_fail "${msg} # unexpected result"
 		ret=$TEST_COUNT
 	else
-		echo "[ OK ]"
+		mptcp_lib_print_ok "[ OK ]"
 		mptcp_lib_result_pass "${msg}"
 	fi
 	TEST_COUNT=$((TEST_COUNT+1))
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index ab3bb3b17522..2a035a6cee86 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -254,7 +254,8 @@ check_mptcp_disabled()
 
 	# net.mptcp.enabled should be enabled by default
 	if [ "$(ip netns exec ${disabled_ns} sysctl net.mptcp.enabled | awk '{ print $3 }')" -ne 1 ]; then
-		echo -e "net.mptcp.enabled sysctl is not 1 by default\t\t[FAIL]"
+		echo -n -e "net.mptcp.enabled sysctl is not 1 by default\t\t"
+		mptcp_lib_print_err "\t\t   [FAIL]"
 		mptcp_lib_result_fail "net.mptcp.enabled sysctl is not 1 by default"
 		ret=1
 		return 1
@@ -267,13 +268,15 @@ check_mptcp_disabled()
 	mptcp_lib_ns_exit "${disabled_ns}"
 
 	if [ ${err} -eq 0 ]; then
-		echo -e "New MPTCP socket cannot be blocked via sysctl\t\t[FAIL]"
+		echo -n -e "New MPTCP socket cannot be blocked via sysctl\t\t"
+		mptcp_lib_print_err "\t\t   [FAIL]"
 		mptcp_lib_result_fail "New MPTCP socket cannot be blocked via sysctl"
 		ret=1
 		return 1
 	fi
 
-	echo -e "New MPTCP socket can be blocked via sysctl\t\t[ OK ]"
+	echo -n -e "New MPTCP socket can be blocked via sysctl\t\t"
+	mptcp_lib_print_ok "\t\t   [ OK ]"
 	mptcp_lib_result_pass "New MPTCP socket can be blocked via sysctl"
 	return 0
 }
@@ -503,7 +506,7 @@ do_transfer()
 	fi
 
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ]; then
-		printf "[ OK ]"
+		mptcp_lib_print_ok "[ OK ]"
 		mptcp_lib_result_pass "${TEST_GROUP}: ${result_msg}"
 	else
 		mptcp_lib_result_fail "${TEST_GROUP}: ${result_msg}"
@@ -534,7 +537,6 @@ do_transfer()
 			"${expect_ackrx}" "${stat_ackrx_now_l}"
 	fi
 
-	echo
 	cat "$capout"
 	[ $retc -eq 0 ] && [ $rets -eq 0 ]
 }
@@ -708,7 +710,7 @@ EOF
 		return
 	fi
 
-	echo "INFO: test $msg"
+	mptcp_lib_print_info "INFO: test $msg"
 
 	TEST_COUNT=10000
 	local extra_args="-o TRANSPARENT"
@@ -735,7 +737,7 @@ run_tests_peekmode()
 	local peekmode="$1"
 
 	TEST_GROUP="peek mode: ${peekmode}"
-	echo "INFO: with peek mode: ${peekmode}"
+	mptcp_lib_print_info "INFO: with peek mode: ${peekmode}"
 	run_tests_lo "$ns1" "$ns1" 10.0.1.1 1 "-P ${peekmode}"
 	run_tests_lo "$ns1" "$ns1" dead:beef:1::1 1 "-P ${peekmode}"
 }
@@ -750,7 +752,7 @@ run_tests_mptfo()
 		return
 	fi
 
-	echo "INFO: with MPTFO start"
+	mptcp_lib_print_info "INFO: with MPTFO start"
 	ip netns exec "$ns1" sysctl -q net.ipv4.tcp_fastopen=2
 	ip netns exec "$ns2" sysctl -q net.ipv4.tcp_fastopen=1
 
@@ -762,7 +764,7 @@ run_tests_mptfo()
 
 	ip netns exec "$ns1" sysctl -q net.ipv4.tcp_fastopen=0
 	ip netns exec "$ns2" sysctl -q net.ipv4.tcp_fastopen=0
-	echo "INFO: with MPTFO end"
+	mptcp_lib_print_info "INFO: with MPTFO end"
 }
 
 run_tests_disconnect()
@@ -786,7 +788,7 @@ run_tests_disconnect()
 	cin_disconnect="$old_cin"
 	connect_per_transfer=3
 
-	echo "INFO: disconnect"
+	mptcp_lib_print_info "INFO: disconnect"
 	run_tests_lo "$ns1" "$ns1" 10.0.1.1 1 "-I 3 -i $old_cin"
 	run_tests_lo "$ns1" "$ns1" dead:beef:1::1 1 "-I 3 -i $old_cin"
 
@@ -835,7 +837,7 @@ check_mptcp_disabled
 
 stop_if_error "The kernel configuration is not valid for MPTCP"
 
-echo "INFO: validating network environment with pings"
+mptcp_lib_print_info "INFO: validating network environment with pings"
 for sender in "$ns1" "$ns2" "$ns3" "$ns4";do
 	do_ping "$ns1" $sender 10.0.1.1
 	do_ping "$ns1" $sender dead:beef:1::1
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index b677fba5a383..615d6f078f6f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -218,7 +218,7 @@ do_mptcp_sockopt_tests()
 	local lret=0
 
 	if ! mptcp_lib_kallsyms_has "mptcp_diag_fill_info$"; then
-		echo "INFO: MPTCP sockopt not supported: SKIP"
+		mptcp_lib_print_warn "INFO: MPTCP sockopt not supported: SKIP"
 		mptcp_lib_result_skip "sockopt"
 		return
 	fi
@@ -228,7 +228,7 @@ do_mptcp_sockopt_tests()
 
 	printf "%-25s %35s" "sockopt v4" " "
 	if [ $lret -ne 0 ]; then
-		echo "FAIL: SOL_MPTCP getsockopt" 1>&2
+		mptcp_lib_print_err "FAIL: SOL_MPTCP getsockopt"
 		mptcp_lib_result_fail "sockopt v4"
 		ret=$lret
 		return
@@ -241,7 +241,7 @@ do_mptcp_sockopt_tests()
 
 	printf "%-25s %35s" "sockopt v6" " "
 	if [ $lret -ne 0 ]; then
-		echo "FAIL: SOL_MPTCP getsockopt (ipv6)" 1>&2
+		mptcp_lib_print_err "FAIL: SOL_MPTCP getsockopt (ipv6)"
 		mptcp_lib_result_fail "sockopt v6"
 		ret=$lret
 		return
@@ -274,13 +274,13 @@ do_tcpinq_test()
 	local lret=$?
 	if [ $lret -ne 0 ];then
 		ret=$lret
-		echo "FAIL: mptcp_inq $*" 1>&2
+		mptcp_lib_print_err "FAIL: mptcp_inq $*" 1>&2
 		mptcp_lib_result_fail "TCP_INQ: $*"
 		return $lret
 	fi
 	mptcp_lib_print_ok "[ OK ]"
 
-	echo "PASS: TCP_INQ cmsg/ioctl $*"
+	mptcp_lib_print_info "PASS: TCP_INQ cmsg/ioctl $*"
 	mptcp_lib_result_pass "TCP_INQ: $*"
 	return $lret
 }
@@ -290,7 +290,7 @@ do_tcpinq_tests()
 	local lret=0
 
 	if ! mptcp_lib_kallsyms_has "mptcp_ioctl$"; then
-		echo "INFO: TCP_INQ not supported: SKIP"
+		mptcp_lib_print_warn "INFO: TCP_INQ not supported: SKIP"
 		mptcp_lib_result_skip "TCP_INQ"
 		return
 	fi
@@ -327,12 +327,12 @@ run_tests $ns1 $ns2 10.0.1.1
 run_tests $ns1 $ns2 dead:beef:1::1
 
 if [ $ret -eq 0 ];then
-	echo "PASS: all packets had packet mark set"
+	mptcp_lib_print_info "PASS: all packets had packet mark set"
 fi
 
 do_mptcp_sockopt_tests
 if [ $ret -eq 0 ];then
-	echo "PASS: SOL_MPTCP getsockopt has expected information"
+	mptcp_lib_print_info "PASS: SOL_MPTCP getsockopt has expected information"
 fi
 
 do_tcpinq_tests
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 427fc5c70b3c..68fad278ac59 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -189,7 +189,8 @@ subflow,backup,fullmesh 10.0.1.1" "          (backup,fullmesh)"
 else
 	for st in fullmesh nofullmesh backup,fullmesh; do
 		st="          (${st})"
-		printf "%-50s%s\n" "${st}" "[SKIP]"
+		printf "%-50s" "${st}"
+		mptcp_lib_print_warn "[SKIP]"
 		mptcp_lib_result_skip "${st}"
 	done
 fi
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 934034d9958b..4155b6b890ae 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -187,12 +187,12 @@ do_transfer()
 	printf "%-16s" " max $max_time "
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ] && \
 	   [ $cmpc -eq 0 ] && [ $cmps -eq 0 ]; then
-		echo "[ OK ]"
+		mptcp_lib_print_ok "[ OK ]"
 		cat "$capout"
 		return 0
 	fi
 
-	echo " [FAIL]"
+	mptcp_lib_print_err " [FAIL]"
 	echo "client exit code $retc, server $rets" 1>&2
 	echo -e "\nnetns ${ns3} socket stat for $port:" 1>&2
 	ip netns exec ${ns3} ss -nita 1>&2 -o "sport = :$port"
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index bca071ba5e4f..1bcde235e363 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -61,7 +61,7 @@ _printf() {
 
 print_title()
 {
-	_printf "INFO: %s\n" "${1}"
+	mptcp_lib_print_info "INFO: ${1}"
 }
 
 # $1: test name
@@ -72,27 +72,22 @@ print_test()
 	_printf "%-68s" "${TEST_NAME}"
 }
 
-print_results()
-{
-	_printf "[%s]\n" "${1}"
-}
-
 test_pass()
 {
-	print_results " OK "
+	mptcp_lib_print_ok "[ OK ]${1:+ ${*}}"
 	mptcp_lib_result_pass "${TEST_NAME}"
 }
 
 test_skip()
 {
-	print_results "SKIP"
+	mptcp_lib_print_warn "[SKIP]${1:+ ${*}}"
 	mptcp_lib_result_skip "${TEST_NAME}"
 }
 
 # $1: msg
 test_fail()
 {
-	print_results "FAIL"
+	mptcp_lib_print_err "[FAIL]${1:+ ${*}}"
 	ret=1
 
 	if [ -n "${1}" ]; then
-- 
2.40.1

