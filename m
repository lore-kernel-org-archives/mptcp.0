Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F92CBA32
	for <mptcp@lists.linux.dev>; Mon, 17 Jul 2023 13:21:43 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3142a9ffa89so4940009f8f.0
        for <mptcp@lists.linux.dev>; Mon, 17 Jul 2023 06:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689600101; x=1692192101;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3pr8rtx3rIJi9b8ImA7oTTauyCDq15ZFdE8w2wHAqlM=;
        b=9EJfcCVaZdEG0v4iqSqBv0bguSnb3CuG0NTv8oDIyhNKXb4cnzmdDxURtBXxLB0lxS
         fUm+dIoCKd6A8w0S/Yg6s8UPoS8HUx9K8N6T7dbRtN5esgbU0sUkx9RwzTpErfr7CUrv
         Fz/VhifuV+4pavdYYMv7z/K5t36OtKf/6X+2apkZJAeR1NpYTsegWsPwtj/lkkF2sVt3
         ZF1NOnm/h5IQKnJvg/I1zo/zq8CkrMjkbPulMX9qsiCMZiCqD/CNe2rCx6+P82tuDfuM
         7M3jPSE0/RIG3hJDihXxL0tx3I+N8Wx1XIFO/oQd77uIj1jl+lDSlHAsX2W38Wz47nu1
         X6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689600101; x=1692192101;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3pr8rtx3rIJi9b8ImA7oTTauyCDq15ZFdE8w2wHAqlM=;
        b=GeyEBKgdlqujjQGTiULl1RBLMPkS0VtOUbZOJbgxDKx4otozDTYaciXyj+MGQUcJ2A
         mFL9S7KYBqjskDVRRm0BaxN2qOjq5GLRbx2qyG90r8W0qDeleWnbgB5SUDAGr2EL/u3l
         Si3kHeA9I5sNa5GfX8hjY4Nr7iF1dvEK4dicDSfouAyyKuKBJd91m42MLxDe8BJz+Tf/
         RRXa0PM2tddycsYhHTLEOVM/RKvWgjOs9WNJCktLskCOVT5RvrhvqvM9RFBCbBETxplQ
         x2jc7Qro6rtwqcqH25VwbPbGkkwcf2DFPbov/F9R67dWT3AOuSKY9QvZvcFDTSneykQ3
         ekEg==
X-Gm-Message-State: ABy/qLZwqSje4M68A2e85XG9kD7L4Sh89PGQoqev9CgcnXZVBE1c1Fmr
	orinHPKgDZdHASckCcidCuLB/w==
X-Google-Smtp-Source: APBJJlEN4PlXex0svmbZlOoHHl0mRarKIQDUzHNNCVNLyRPuH859TTH+139WXT/O0SQUtw7tYw40FA==
X-Received: by 2002:a5d:50d1:0:b0:316:e04a:29e8 with SMTP id f17-20020a5d50d1000000b00316e04a29e8mr10747822wrt.54.1689600101362;
        Mon, 17 Jul 2023 06:21:41 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id r8-20020a056000014800b0030fa3567541sm19249836wrx.48.2023.07.17.06.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 06:21:41 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 17 Jul 2023 15:21:27 +0200
Subject: [PATCH net-next 07/13] selftests: mptcp: connect: format subtests
 results in TAP
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-upstream-net-next-20230712-selftests-mptcp-subtests-v1-7-695127e0ad83@tessares.net>
References: <20230717-upstream-net-next-20230712-selftests-mptcp-subtests-v1-0-695127e0ad83@tessares.net>
In-Reply-To: <20230717-upstream-net-next-20230712-selftests-mptcp-subtests-v1-0-695127e0ad83@tessares.net>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7358;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=WBrB6Y2c7dhnrv1xGXSzU9JFOREHTH6wzrvFzigzIMI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBktUBdx6Dzz1cHO6wZgSg0aS5rwRCtBAA9iUc9y
 TPqz9OaFfqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZLVAXQAKCRD2t4JPQmmg
 czieEACEYVRdIEXeE03dc27PsyYHKtWLeB16Z/OTLqXL9KxG0IN6frqzripqiyQ8jSu00eHq/Rz
 lymqt17XUmBV98/57J+iqnUSvMHlke6CLknKc5SbhNFCM4z4Sy1Hx0cdmT4+i6JLN22OVawN3a8
 rUtsbnDYd18Pm7eQ3mirlbV+/zs0xu8FjyqnRSd9EA12l6K5Z8+cHuHYi+FeI36XtF3nHm+hGPQ
 9l+GIAcCvIsuNH6AUGn7D8ljcDL95VJKhDg+nXun9lzO/tpvU5RGKGlbHWP5S4JMFkZSz0XErc/
 SJ2Q9GfBleQKeiBz6GK6PImjDr3amI9MLbTDw1y1qrInE+ogHQp/vGPad3TtGyFireear+nmuXw
 IXHjvYw3fRJW62LqmB8XiU6LR6NvHPDquLFnnlygTz9FhQttYYel9uQQAdUOb0an7CxYNZEwpQl
 lSU9OSclQyfpslf5dZKk3Waq0VxgBTO0KFV+hc51lYVgJdidyGzzrvWLuw8Se/Z4gEaTCBOaYwm
 AgPLvMOSC6ukL3UdtPF3Ntm4vx0lzOm6FKBAyCzsKGSjYyOMbJSx4OVnjzNcherIxogQc22V2iA
 Dy8fvB9TmaMfUGPv0TTTHHdMbjrGu8K8gZw7U9dqKGVEzjVCIy8WhoUxKdbKXjp85sGyFX+R3HV
 JM3coQaiWxLswRw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The current selftests infrastructure formats the results in TAP 13. This
version doesn't support subtests and only the end result of each
selftest is taken into account. It means that a single issue in a
subtest of a selftest containing multiple subtests forces the whole
selftest to be marked as failed. It also means that subtests results are
not tracked by CIs executing selftests.

MPTCP selftests run hundreds of various subtests. It is then important
to track each of them and not one result per selftest.

It is particularly interesting to do that when validating stable kernels
with the last version of the test suite: tests might fail because a
feature is not supported but the test didn't skip that part. In this
case, if subtests are not tracked, the whole selftest will be marked as
failed making the other subtests useless because their results are
ignored.

This patch formats subtests results in TAP in mptcp_connect.sh selftest.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 39 ++++++++++++++++++++--
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 0f060af01a84..b1fc8afd072d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -129,6 +129,7 @@ ns3="ns3-$rndh"
 ns4="ns4-$rndh"
 
 TEST_COUNT=0
+TEST_GROUP=""
 
 cleanup()
 {
@@ -286,6 +287,7 @@ check_mptcp_disabled()
 	# net.mptcp.enabled should be enabled by default
 	if [ "$(ip netns exec ${disabled_ns} sysctl net.mptcp.enabled | awk '{ print $3 }')" -ne 1 ]; then
 		echo -e "net.mptcp.enabled sysctl is not 1 by default\t\t[ FAIL ]"
+		mptcp_lib_result_fail "net.mptcp.enabled sysctl is not 1 by default"
 		ret=1
 		return 1
 	fi
@@ -298,11 +300,13 @@ check_mptcp_disabled()
 
 	if [ ${err} -eq 0 ]; then
 		echo -e "New MPTCP socket cannot be blocked via sysctl\t\t[ FAIL ]"
+		mptcp_lib_result_fail "New MPTCP socket cannot be blocked via sysctl"
 		ret=1
 		return 1
 	fi
 
 	echo -e "New MPTCP socket can be blocked via sysctl\t\t[ OK ]"
+	mptcp_lib_result_pass "New MPTCP socket can be blocked via sysctl"
 	return 0
 }
 
@@ -318,14 +322,16 @@ do_ping()
 	local connector_ns="$2"
 	local connect_addr="$3"
 	local ping_args="-q -c 1"
+	local rc=0
 
 	if is_v6 "${connect_addr}"; then
 		$ipv6 || return 0
 		ping_args="${ping_args} -6"
 	fi
 
-	ip netns exec ${connector_ns} ping ${ping_args} $connect_addr >/dev/null
-	if [ $? -ne 0 ] ; then
+	ip netns exec ${connector_ns} ping ${ping_args} $connect_addr >/dev/null || rc=1
+
+	if [ $rc -ne 0 ] ; then
 		echo "$listener_ns -> $connect_addr connectivity [ FAIL ]" 1>&2
 		ret=1
 
@@ -404,7 +410,9 @@ do_transfer()
 
 	local addr_port
 	addr_port=$(printf "%s:%d" ${connect_addr} ${port})
-	printf "%.3s %-5s -> %.3s (%-20s) %-5s\t" ${connector_ns} ${cl_proto} ${listener_ns} ${addr_port} ${srv_proto}
+	local result_msg
+	result_msg="$(printf "%.3s %-5s -> %.3s (%-20s) %-5s" ${connector_ns} ${cl_proto} ${listener_ns} ${addr_port} ${srv_proto})"
+	printf "%s\t" "${result_msg}"
 
 	if $capture; then
 		local capuser
@@ -479,6 +487,7 @@ do_transfer()
 
 	local duration
 	duration=$((stop-start))
+	result_msg+=" # time=${duration}ms"
 	printf "(duration %05sms) " "${duration}"
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		echo "[ FAIL ] client exit code $retc, server $rets" 1>&2
@@ -491,6 +500,7 @@ do_transfer()
 
 		echo
 		cat "$capout"
+		mptcp_lib_result_fail "${TEST_GROUP}: ${result_msg}"
 		return 1
 	fi
 
@@ -550,6 +560,9 @@ do_transfer()
 
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ]; then
 		printf "[ OK ]"
+		mptcp_lib_result_pass "${TEST_GROUP}: ${result_msg}"
+	else
+		mptcp_lib_result_fail "${TEST_GROUP}: ${result_msg}"
 	fi
 
 	if [ $cookies -eq 2 ];then
@@ -692,6 +705,8 @@ run_test_transparent()
 	local lret=0
 	local r6flag=""
 
+	TEST_GROUP="${msg}"
+
 	# skip if we don't want v6
 	if ! $ipv6 && is_v6 "${connect_addr}"; then
 		return 0
@@ -703,6 +718,7 @@ run_test_transparent()
 	# checking for a specific kernel version.
 	if ! mptcp_lib_kallsyms_has "T __ip_sock_set_tos$"; then
 		echo "INFO: ${msg} not supported by the kernel: SKIP"
+		mptcp_lib_result_skip "${TEST_GROUP}"
 		return
 	fi
 
@@ -720,6 +736,7 @@ EOF
 	if [ $? -ne 0 ]; then
 		echo "SKIP: $msg, could not load nft ruleset"
 		mptcp_lib_fail_if_expected_feature "nft rules"
+		mptcp_lib_result_skip "${TEST_GROUP}"
 		return
 	fi
 
@@ -736,6 +753,7 @@ EOF
 		ip netns exec "$listener_ns" nft flush ruleset
 		echo "SKIP: $msg, ip $r6flag rule failed"
 		mptcp_lib_fail_if_expected_feature "ip rule"
+		mptcp_lib_result_skip "${TEST_GROUP}"
 		return
 	fi
 
@@ -745,6 +763,7 @@ EOF
 		ip -net "$listener_ns" $r6flag rule del fwmark 1 lookup 100
 		echo "SKIP: $msg, ip route add local $local_addr failed"
 		mptcp_lib_fail_if_expected_feature "ip route"
+		mptcp_lib_result_skip "${TEST_GROUP}"
 		return
 	fi
 
@@ -774,6 +793,7 @@ run_tests_peekmode()
 {
 	local peekmode="$1"
 
+	TEST_GROUP="peek mode: ${peekmode}"
 	echo "INFO: with peek mode: ${peekmode}"
 	run_tests_lo "$ns1" "$ns1" 10.0.1.1 1 "-P ${peekmode}"
 	run_tests_lo "$ns1" "$ns1" dead:beef:1::1 1 "-P ${peekmode}"
@@ -781,8 +801,11 @@ run_tests_peekmode()
 
 run_tests_mptfo()
 {
+	TEST_GROUP="MPTFO"
+
 	if ! mptcp_lib_kallsyms_has "mptcp_fastopen_"; then
 		echo "INFO: TFO not supported by the kernel: SKIP"
+		mptcp_lib_result_skip "${TEST_GROUP}"
 		return
 	fi
 
@@ -806,8 +829,11 @@ run_tests_disconnect()
 	local old_cin=$cin
 	local old_sin=$sin
 
+	TEST_GROUP="full disconnect"
+
 	if ! mptcp_lib_kallsyms_has "mptcp_pm_data_reset$"; then
 		echo "INFO: Full disconnect not supported: SKIP"
+		mptcp_lib_result_skip "${TEST_GROUP}"
 		return
 	fi
 
@@ -856,6 +882,7 @@ stop_if_error()
 {
 	if ! log_if_error "${@}"; then
 		display_time
+		mptcp_lib_result_print_all_tap
 		exit ${final_ret}
 	fi
 }
@@ -886,6 +913,8 @@ for sender in "$ns1" "$ns2" "$ns3" "$ns4";do
 	do_ping "$ns4" $sender dead:beef:3::1
 done
 
+mptcp_lib_result_code "${ret}" "ping tests"
+
 stop_if_error "Could not even run ping tests"
 
 [ -n "$tc_loss" ] && tc -net "$ns2" qdisc add dev ns2eth3 root netem loss random $tc_loss delay ${tc_delay}ms
@@ -915,12 +944,15 @@ echo "on ns3eth4"
 
 tc -net "$ns3" qdisc add dev ns3eth4 root netem delay ${reorder_delay}ms $tc_reorder
 
+TEST_GROUP="loopback v4"
 run_tests_lo "$ns1" "$ns1" 10.0.1.1 1
 stop_if_error "Could not even run loopback test"
 
+TEST_GROUP="loopback v6"
 run_tests_lo "$ns1" "$ns1" dead:beef:1::1 1
 stop_if_error "Could not even run loopback v6 test"
 
+TEST_GROUP="multihosts"
 for sender in $ns1 $ns2 $ns3 $ns4;do
 	# ns1<->ns2 is not subject to reordering/tc delays. Use it to test
 	# mptcp syncookie support.
@@ -966,4 +998,5 @@ run_tests_disconnect
 log_if_error "Tests of the full disconnection have failed"
 
 display_time
+mptcp_lib_result_print_all_tap
 exit ${final_ret}

-- 
2.40.1

