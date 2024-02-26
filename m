Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0582D605BF
	for <mptcp@lists.linux.dev>; Mon, 26 Feb 2024 09:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708940622; cv=none; b=ljEe4SinRQmdxn+LHihWcNtESNMAxTXtglLkfcYRQLDr7d0XueEHU99FCNHeDegOkFtXNwVDHO7mQ5Pn6u3jVcfFX0DQa5iB63bQlzs3T9KX8JQYH8azThrDbyn3AxVqRxPq2fzvKHjtJy9rFW0fHv9zHULoF5jFE8u72+ZaYkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708940622; c=relaxed/simple;
	bh=dAgaN/vwNd4UGo7QPDiYuPewVPIoosy0DBtc3wajZ3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nto7SmbWK0IX4O1G4d8xeXWX/0s5makTAzQYwizFAG3n+57jGzbe2yIcvxbTKYGpcoSPmV7t/t3msgtpgF8A2tbJ+HWalsnGzbIrIu/7c8VEwjqh+pL0uQ8DX6QM522eSa6AN0MAtZ9Y7p2aRqjuxwQi04gcN3G7niHrfZu5VjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vc7+8gC1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vc7+8gC1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA591C433C7;
	Mon, 26 Feb 2024 09:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708940621;
	bh=dAgaN/vwNd4UGo7QPDiYuPewVPIoosy0DBtc3wajZ3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vc7+8gC1UJbMU/osls7Olzht0AfdA2SeLlGZB5clUSuNzxhR2hCHlAXRrEexDAN8x
	 dJNz9fLsEFKhsBWUAqKCqN76rg1QH8wOOZG/QuPaL8l53/Rygw2Rdb7Ui9VcYT8VjX
	 kenb4fKPszL0N6VX6KZ4xX9Ni8ijT9Ah55NDJO+W7OF+xn39cGqQNW9aDCEe98uCfl
	 9GvefZhZ7uUKR+Cf+DsSEfKerx9OpY/K1d7ymJPiUpMc+keXS23VN4uf0NvoHOoAhK
	 TQJSLVYiUSsxVz8Oad3+nTVh8Y8AbfnesCnx7fOiBadn1eD/9mKY3lk4y81obhPmpR
	 zZGoz+8mK5uZw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 07/12] selftests: mptcp: print test results with counters
Date: Mon, 26 Feb 2024 17:43:18 +0800
Message-Id: <ceb85fa70bc1c314fc7bab4e29b4e1b30e38dae4.1708939962.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708939962.git.tanggeliang@kylinos.cn>
References: <cover.1708939962.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new helper mptcp_lib_print_test_counter() to print
out test counter in each test result and increase the counter. Use
this helper to print out test counters for every tests in diag.sh,
mptcp_connect.sh, mptcp_sockopt.sh, pm_netlink.sh, simult_flows.sh,
and userspace_pm.sh.

Each output looks like:

diag.sh
 01 no msk on netns creation                          [  OK  ]
 02 listen match for dport 10000                      [  OK  ]
 03 listen match for sport 10000                      [  OK  ]
 04 listen match for saddr and sport                  [  OK  ]
 05 all listen sockets                                [  OK  ]

mptcp_connect.sh
 01 New MPTCP socket can be blocked via sysctl                      [ OK ]
 INFO: validating network environment with pings
 02 ping tests                                                      [ OK ]
 INFO: Using loss of 0.16% delay 25 ms reorder .. with delay 6ms on ns3eth4
 03 ns1 MPTCP -> ns1 (10.0.1.1:10000      ) MPTCP  (duration 116ms) [ OK ]
 04 ns1 MPTCP -> ns1 (10.0.1.1:10001      ) TCP    (duration  33ms) [ OK ]
 05 ns1 TCP   -> ns1 (10.0.1.1:10002      ) MPTCP  (duration  25ms) [ OK ]
 06 ns1 MPTCP -> ns1 (dead:beef:1::1:10003) MPTCP  (duration 128ms) [ OK ]
 07 ns1 MPTCP -> ns1 (dead:beef:1::1:10004) TCP    (duration  31ms) [ OK ]

mptcp_sockopt.sh
 01 transfer ipv4                                                [ OK ]
 02 mark ipv4                                                    [ OK ]
 03 transfer ipv6                                                [ OK ]
 04 mark ipv6                                                    [ OK ]
 PASS: all packets had packet mark set
 05 sockopt v4                                                   [ OK ]
 06 sockopt v6                                                   [ OK ]
 PASS: SOL_MPTCP getsockopt has expected information
 07 TCP_INQ: -t tcp                                              [ OK ]
 PASS: TCP_INQ cmsg/ioctl -t tcp
 08 TCP_INQ: -6 -t tcp                                           [ OK ]
 PASS: TCP_INQ cmsg/ioctl -6 -t tcp
 09 TCP_INQ: -r tcp                                              [ OK ]
 PASS: TCP_INQ cmsg/ioctl -r tcp
 10 TCP_INQ: -6 -r tcp                                           [ OK ]

pm_netlink.sh
 01 defaults addr list                        [ OK ]
 02 simple add/get addr                       [ OK ]
 03 dump addrs                                [ OK ]
 04 simple del addr                           [ OK ]
 05 dump addrs after del                      [ OK ]
 06 duplicate addr                            [ OK ]
 07 id addr increment                         [ OK ]
 08 hard addr limit                           [ OK ]
 09 above hard addr limit                     [ OK ]

simult_flows.sh
 01 balanced bwidth                          7411 max 8456       [ OK ]
 02 balanced bwidth - reverse direction      7380 max 8456       [ OK ]
 03 balanced bwidth with unbalanced delay    7434 max 8456       [ OK ]

userspace_pm.sh
 INFO: Init
 01 Created network namespaces ns1, ns2                       [ OK ]
 INFO: Make connections
 02 Established IPv4 MPTCP Connection ns2 => ns1              [ OK ]
 03 Established IPv6 MPTCP Connection ns2 => ns1              [ OK ]
 INFO: Announce tests
 04 ADD_ADDR 10.0.2.2 (ns2) => ns1, invalid token             [ OK ]
 05 ADD_ADDR id:14 10.0.2.2 (ns2) => ns1, reuse port          [ OK ]

Having test counters helps to quickly identify issues when looking at a
long list of output logs and results.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/diag.sh     |  8 ++---
 .../selftests/net/mptcp/mptcp_connect.sh      | 33 +++++++++++--------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  8 +++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 12 ++++---
 .../testing/selftests/net/mptcp/pm_netlink.sh |  6 ++--
 .../selftests/net/mptcp/simult_flows.sh       |  7 ++--
 .../selftests/net/mptcp/userspace_pm.sh       |  3 +-
 7 files changed, 47 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index f9f62a8f41e3..01e9f11f1f47 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -9,7 +9,7 @@
 . "$(dirname "${0}")/mptcp_lib.sh"
 
 ns=""
-test_cnt=1
+test_cnt=0
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 ret=0
@@ -55,7 +55,7 @@ __chk_nr()
 
 	nr=$(eval $command)
 
-	printf "%-50s" "$msg"
+	mptcp_lib_print_test_counter test_cnt "%-50s" "$msg"
 	if [ "$nr" != "$expected" ]; then
 		if [ "$nr" = "$skip" ] && ! mptcp_lib_expect_all_features; then
 			mptcp_lib_print_warn "[SKIP] Feature probably not supported"
@@ -69,7 +69,6 @@ __chk_nr()
 		mptcp_lib_print_ok "[ OK ]"
 		mptcp_lib_result_pass "${msg}"
 	fi
-	test_cnt=$((test_cnt+1))
 }
 
 __chk_msk_nr()
@@ -114,7 +113,7 @@ wait_msk_nr()
 		sleep 1
 	done
 
-	printf "%-50s" "$msg"
+	mptcp_lib_print_test_counter test_cnt "%-50s" "$msg"
 	if [ $i -ge $timeout ]; then
 		mptcp_lib_print_err "[FAIL] timeout while expecting $expected max $max last $nr"
 		mptcp_lib_result_fail "${msg} # timeout"
@@ -127,7 +126,6 @@ wait_msk_nr()
 		mptcp_lib_print_ok "[ OK ]"
 		mptcp_lib_result_pass "${msg}"
 	fi
-	test_cnt=$((test_cnt+1))
 }
 
 chk_msk_fallback_nr()
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 06e945914ace..00bbe451e50d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -131,6 +131,7 @@ ns2=""
 ns3=""
 ns4=""
 
+#shellcheck disable=SC2034
 TEST_COUNT=0
 TEST_GROUP=""
 
@@ -255,8 +256,9 @@ check_mptcp_disabled()
 
 	# net.mptcp.enabled should be enabled by default
 	if [ "$(ip netns exec ${disabled_ns} sysctl net.mptcp.enabled | awk '{ print $3 }')" -ne 1 ]; then
-		echo -n -e "net.mptcp.enabled sysctl is not 1 by default"
-		mptcp_lib_print_err "\t\t\t   [FAIL]"
+		mptcp_lib_print_test_counter TEST_COUNT "%s" \
+			"net.mptcp.enabled sysctl is not 1 by default"
+		mptcp_lib_print_err "\t\t\t\t   [FAIL]"
 		mptcp_lib_result_fail "net.mptcp.enabled sysctl is not 1 by default"
 		ret=1
 		return 1
@@ -269,15 +271,17 @@ check_mptcp_disabled()
 	mptcp_lib_ns_exit "${disabled_ns}"
 
 	if [ ${err} -eq 0 ]; then
-		echo -n -e "New MPTCP socket cannot be blocked via sysctl"
-		mptcp_lib_print_err "\t\t\t   [FAIL]"
+		mptcp_lib_print_test_counter TEST_COUNT "%s" \
+			"New MPTCP socket cannot be blocked via sysctl"
+		mptcp_lib_print_err "\t\t\t\t   [FAIL]"
 		mptcp_lib_result_fail "New MPTCP socket cannot be blocked via sysctl"
 		ret=1
 		return 1
 	fi
 
-	echo -n -e "New MPTCP socket can be blocked via sysctl"
-	mptcp_lib_print_ok "\t\t\t   [ OK ]"
+	mptcp_lib_print_test_counter TEST_COUNT "%s" \
+		"New MPTCP socket can be blocked via sysctl"
+	mptcp_lib_print_ok "\t\t\t\t   [ OK ]"
 	mptcp_lib_result_pass "New MPTCP socket can be blocked via sysctl"
 	return 0
 }
@@ -319,7 +323,6 @@ do_transfer()
 
 	local port
 	port=$((10000+PORT++))
-	TEST_COUNT=$((TEST_COUNT+1))
 
 	if [ "$rcvbuf" -gt 0 ]; then
 		extra_args="$extra_args -R $rcvbuf"
@@ -346,7 +349,7 @@ do_transfer()
 	addr_port=$(printf "%s:%d" ${connect_addr} ${port})
 	local result_msg
 	result_msg="$(printf "%.3s %-5s -> %.3s (%-20s) %-5s" ${connector_ns} ${cl_proto} ${listener_ns} ${addr_port} ${srv_proto})"
-	printf "%s\t" "${result_msg}"
+	mptcp_lib_print_test_counter TEST_COUNT "%s\t" "${result_msg}"
 
 	if $capture; then
 		local capuser
@@ -663,7 +666,8 @@ run_test_transparent()
 	# following function has been exported (T). Not great but better than
 	# checking for a specific kernel version.
 	if ! mptcp_lib_kallsyms_has "T __ip_sock_set_tos$"; then
-		echo "INFO: ${msg} not supported by the kernel: SKIP"
+		mptcp_lib_print_test_counter TEST_COUNT "%s\n" \
+			"INFO: ${msg} not supported by the kernel: SKIP"
 		mptcp_lib_result_skip "${TEST_GROUP}"
 		return
 	fi
@@ -680,7 +684,8 @@ table inet mangle {
 }
 EOF
 	then
-		echo "SKIP: $msg, could not load nft ruleset"
+		mptcp_lib_print_test_counter TEST_COUNT "%s\n" \
+			"SKIP: $msg, could not load nft ruleset"
 		mptcp_lib_fail_if_expected_feature "nft rules"
 		mptcp_lib_result_skip "${TEST_GROUP}"
 		return
@@ -696,7 +701,8 @@ EOF
 
 	if ! ip -net "$listener_ns" $r6flag rule add fwmark 1 lookup 100; then
 		ip netns exec "$listener_ns" nft flush ruleset
-		echo "SKIP: $msg, ip $r6flag rule failed"
+		mptcp_lib_print_test_counter TEST_COUNT "%s\n" \
+			"SKIP: $msg, ip $r6flag rule failed"
 		mptcp_lib_fail_if_expected_feature "ip rule"
 		mptcp_lib_result_skip "${TEST_GROUP}"
 		return
@@ -705,7 +711,8 @@ EOF
 	if ! ip -net "$listener_ns" route add local $local_addr/0 dev lo table 100; then
 		ip netns exec "$listener_ns" nft flush ruleset
 		ip -net "$listener_ns" $r6flag rule del fwmark 1 lookup 100
-		echo "SKIP: $msg, ip route add local $local_addr failed"
+		mptcp_lib_print_test_counter TEST_COUNT "%s\n" \
+			"SKIP: $msg, ip route add local $local_addr failed"
 		mptcp_lib_fail_if_expected_feature "ip route"
 		mptcp_lib_result_skip "${TEST_GROUP}"
 		return
@@ -861,7 +868,7 @@ mptcp_lib_result_code "${ret}" "ping tests"
 
 stop_if_error "Could not even run ping tests"
 
-echo -e "ping tests"
+mptcp_lib_print_test_counter TEST_COUNT "%s" "ping tests"
 mptcp_lib_print_ok "\t\t\t\t\t\t\t\t   [ OK ]"
 
 [ -n "$tc_loss" ] && tc -net "$ns2" qdisc add dev ns2eth3 root netem loss random $tc_loss delay ${tc_delay}ms
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 7e309493eda2..df495658f043 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -411,3 +411,11 @@ mptcp_lib_events() {
 	ip netns exec "${ns}" ./pm_nl_ctl events >> "${evts}" 2>&1 &
 	pid=$!
 }
+
+mptcp_lib_print_test_counter() {
+	declare -n counter="${1}"
+	local fmt="${2}"
+	local msg="${3}"
+
+	printf "%02u ${fmt}" "$((++counter))" "${msg}"
+}
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index cfa0cfb918f4..a2a5049f22bb 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -17,6 +17,8 @@ timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 iptables="iptables"
 ip6tables="ip6tables"
+#shellcheck disable=SC2034
+test_cnt=0
 
 ns1=""
 ns2=""
@@ -161,7 +163,7 @@ do_transfer()
 	wait $spid
 	local rets=$?
 
-	printf "%-50s" "transfer ${ip}"
+	mptcp_lib_print_test_counter test_cnt "%-50s" "transfer ${ip}"
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		echo " client exit code $retc, server $rets" 1>&2
 		echo -e "\nnetns ${listener_ns} socket stat for ${port}:" 1>&2
@@ -178,7 +180,7 @@ do_transfer()
 	fi
 	mptcp_lib_print_ok "[ OK ]"
 
-	printf "%-50s" "mark ${ip}"
+	mptcp_lib_print_test_counter test_cnt "%-50s" "mark ${ip}"
 	if [ $local_addr = "::" ];then
 		check_mark $listener_ns 6 || retc=1
 		check_mark $connector_ns 6 || retc=1
@@ -226,7 +228,7 @@ do_mptcp_sockopt_tests()
 	ip netns exec "$ns_sbox" ./mptcp_sockopt
 	lret=$?
 
-	printf "%-50s" "sockopt v4"
+	mptcp_lib_print_test_counter test_cnt "%-50s" "sockopt v4"
 	if [ $lret -ne 0 ]; then
 		mptcp_lib_print_err "FAIL: SOL_MPTCP getsockopt"
 		mptcp_lib_result_fail "sockopt v4"
@@ -239,7 +241,7 @@ do_mptcp_sockopt_tests()
 	ip netns exec "$ns_sbox" ./mptcp_sockopt -6
 	lret=$?
 
-	printf "%-50s" "sockopt v6"
+	mptcp_lib_print_test_counter test_cnt "%-50s" "sockopt v6"
 	if [ $lret -ne 0 ]; then
 		mptcp_lib_print_err "FAIL: SOL_MPTCP getsockopt (ipv6)"
 		mptcp_lib_result_fail "sockopt v6"
@@ -269,7 +271,7 @@ run_tests()
 
 do_tcpinq_test()
 {
-	printf "%-50s" "TCP_INQ: $*"
+	mptcp_lib_print_test_counter test_cnt "%-50s" "TCP_INQ: $*"
 	ip netns exec "$ns_sbox" ./mptcp_inq "$@"
 	local lret=$?
 	if [ $lret -ne 0 ];then
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 68fad278ac59..87ed60ed4112 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -9,6 +9,8 @@
 . "$(dirname "${0}")/mptcp_lib.sh"
 
 ret=0
+#shellcheck disable=SC2034
+test_cnt=0
 
 usage() {
 	echo "Usage: $0 [ -h ]"
@@ -53,7 +55,7 @@ check()
 	local msg="$3"
 	local rc=0
 
-	printf "%-50s" "$msg"
+	mptcp_lib_print_test_counter test_cnt "%-50s" "$msg"
 	mptcp_lib_check_output "${err}" "${cmd}" "${expected}" || rc=${?}
 	if [ ${rc} -eq 2 ]; then
 		mptcp_lib_result_fail "${msg} # error ${rc}"
@@ -189,7 +191,7 @@ subflow,backup,fullmesh 10.0.1.1" "          (backup,fullmesh)"
 else
 	for st in fullmesh nofullmesh backup,fullmesh; do
 		st="          (${st})"
-		printf "%-50s" "${st}"
+		mptcp_lib_print_test_counter test_cnt "%-50s" "${st}"
 		mptcp_lib_print_warn "[SKIP]"
 		mptcp_lib_result_skip "${st}"
 	done
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 79cb377ee0bd..eb2eaa48035f 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -14,7 +14,7 @@ ns3=""
 capture=false
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
-test_cnt=1
+test_cnt=0
 ret=0
 bail=0
 slack=50
@@ -127,7 +127,6 @@ do_transfer()
 	local max_time=$3
 	local port
 	port=$((10000+test_cnt))
-	test_cnt=$((test_cnt+1))
 
 	:> "$cout"
 	:> "$sout"
@@ -239,7 +238,7 @@ run_test()
 	# completion (see mptcp_connect): 200ms on each side, add some slack
 	time=$((time + 400 + slack))
 
-	printf "%-60s" "$msg"
+	mptcp_lib_print_test_counter test_cnt "%-60s" "$msg"
 	do_transfer $small $large $time
 	lret=$?
 	mptcp_lib_result_code "${lret}" "${msg}"
@@ -249,7 +248,7 @@ run_test()
 	fi
 
 	msg+=" - reverse direction"
-	printf "%-60s" "${msg}"
+	mptcp_lib_print_test_counter test_cnt "%-60s" "${msg}"
 	do_transfer $large $small $time
 	lret=$?
 	mptcp_lib_result_code "${lret}" "${msg}"
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 33bbb0d5807f..27f308601005 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -53,6 +53,7 @@ server_addr_id=${RANDOM:0:2}
 ns1=""
 ns2=""
 ret=0
+test_cnt=0
 test_name=""
 
 _printf() {
@@ -69,7 +70,7 @@ print_test()
 {
 	test_name="${1}"
 
-	_printf "%-68s" "${test_name}"
+	mptcp_lib_print_test_counter test_cnt "%-68s" "${test_name}"
 }
 
 test_pass()
-- 
2.40.1

