Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A038E19BB6
	for <mptcp@lists.linux.dev>; Wed, 21 Jun 2023 17:18:40 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3f9b1a117caso33304635e9.0
        for <mptcp@lists.linux.dev>; Wed, 21 Jun 2023 10:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687367918; x=1689959918;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XH2yJYNIBeDUoFK6wBIuMe60uiEr3uKqfavOad4jbfo=;
        b=MUuHxjqEzEZe5jUnOSELFQ4mKEUiAYci2zvZMbNiIGjiqykEqHv9FNmC8pUpx4Nuo2
         glAkSrrJnQJWomRcXPpRnZpujIGicm045DGTJz8sPQgwLvidJtCLaCvgGLEReY3xdFO5
         Pc28O2zq/ib3C9nM6X+1U4QAVHfvH4M3LDRVgCLrGUZPe37Hzo8lSAERcMVtIzvEPyBs
         qWlXNivFkkekx/X82vpMcIWUUsLTRmsZZ1BF3YZqRqwSUJJljjTqdWPar4ONvj5jCXYb
         fhWUC5yG/tHJnVN3ZWZ3T21lsgAfcOtZOuw1E/qIau7QilAnTXj593skA6P1r7VDUqc4
         maTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687367918; x=1689959918;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XH2yJYNIBeDUoFK6wBIuMe60uiEr3uKqfavOad4jbfo=;
        b=i5d3Nby/ei+1PR/TkTH8vbC627vkKQt14QebVLZzR33v4ZfMTXITcsCyIPEjlUGm9/
         oWjiPRC3qzto9AKz4fomqbyYiFNEi23at/0aWkPSn2vPZgard/d5+KKbOYafZ1Z/lw4h
         ikFpQSBXJTm6pLGyDpKaQq9c6vp32vuZh315CwrNv8eM3m9Ivk3K9LEZmyHc1Qj3gScW
         EjHdNjkvu6RRuTTPH8XsSJMPeZtYeBGF0e977/M10SV7ZEpAiwfRWhAMhV+d1WflcJTs
         BFl7QpeW/xh+ZX8rgrpQ78Ww9vES02umPhPalSlR70t6cbDbRTMyx7Moqn4h0sR4JP4G
         k4ew==
X-Gm-Message-State: AC+VfDxfeN1/OGr5e5EZLIcYrIZHtUcZ91R++hcze3VUUF9QlaJsDXgH
	enkpE9R8r1PiK8Z9rLva4tpV5QGPbfFi6OZA9IzQQVZj
X-Google-Smtp-Source: ACHHUZ4BjnpyMSv7oir91/yQFk68PTXeEgDTBI/yrBa8BFKwQoo14htvBAmQvnBG6NcpiKZryqesaw==
X-Received: by 2002:a1c:ed0b:0:b0:3f5:39:240c with SMTP id l11-20020a1ced0b000000b003f50039240cmr57441wmh.27.1687367918537;
        Wed, 21 Jun 2023 10:18:38 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id f1-20020adfdb41000000b0030ae499da59sm4930027wrj.111.2023.06.21.10.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 10:18:38 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 21 Jun 2023 19:18:13 +0200
Subject: [PATCH mptcp-next 12/18] selftests: mptcp: connect: format
 subtests results in TAP
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230621-mptcp-issue-368-selftests-subtests-v1-12-0cae453ae1fa@tessares.net>
References: <20230621-mptcp-issue-368-selftests-subtests-v1-0-0cae453ae1fa@tessares.net>
In-Reply-To: <20230621-mptcp-issue-368-selftests-subtests-v1-0-0cae453ae1fa@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7315;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=D/D8ftBZomxqHObQ0bmg9cyKZZl6R3qNQxo3PNmcH0Q=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkkzDjRGVuvMHnpCvNmGeCZPRP2ypBkyJZN35HU
 DQhVDoVfyuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJMw4wAKCRD2t4JPQmmg
 cyY5EADM2lhy2MqLLxYunu3z84Dz88Q5qpvxOMU0rDIPSTxbyby494IPnjU9T8m0lo/sGdwi1RL
 03a84CtNjYIcQta6SvOlc+VxmSBdho4laQ9ftwuxgTRMzgPv/63cNxj01oIvbod3SscD96Zkfiy
 uO/L3Eiuwtkl0AjOPcC5VwfmR5DcCwRZo0RBpzkvh+NGv7oAk8ctTa+/yZiLqFvUseov7a0MAa9
 pBShxn7pxJdrHnI5J0jQXar+qXtxmNP+xldPmIhIPGl6XTzTkE3W+0HkiV09kdXopMBDoLBMJLi
 QVziXum1XQrvVEAmVFIvlYO2PhOr9pUr8s7ZTmhVIhWCR+N1QhxoXNq5unPUMblun+W5IQuvODB
 L3by3OqjOrZJ0BvDN007WyDM3etG9qMkQ/0ixjk0Bqzq7jn4hTScPI6roNzI3Mr+QNxc94SZdUX
 mAjhA8Gh0RlsBUT8hvDwY/7fVOg4FUkBd5BFjI4L+HMzhGw/L1euBZl+T8aFki9jUwGdNNO1s6f
 fofs3dohvWXwLTNtUsaSI0ey3C1u6RDS9qblHolCqGkQAH6DyvZCLD6nG4q0OproGx8YkXN70vQ
 MXdHiDP8tABOb2RgaKDWHBbYtsrY/qxg683ofFZucjtW483c30cfVG6X2i8DblOgXIb8CxrcTCT
 cicFsxyuk/59UaQ==
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
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 39 ++++++++++++++++++++--
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index dba58875ef4c..bd5c51e30657 100755
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

