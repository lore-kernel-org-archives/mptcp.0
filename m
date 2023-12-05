Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF0B14F6F
	for <mptcp@lists.linux.dev>; Tue,  5 Dec 2023 07:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bnNYDc97"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701759810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OtdihN2qTzJDHy87Xwj42b0HcvuCBrxUSrd4eh7uHgY=;
	b=bnNYDc97inTy8qw2v/qVWJr/r2Xbgp6/W6E1S/slgEblMjjc2oxihOlLlcAk4fLulL2pZ1
	UZpAtzeeymFnLa3RLYX9vfhutZv2+GgbrOKWfl36hgPWw9zvDXGIG8YWP6GrrPTbRSJf9L
	+CGY2oI+j+Fab3Uqg+QkkgOy+hBqet4=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v5 13/33] selftests: mptcp: connect: print colored output
Date: Tue,  5 Dec 2023 15:01:00 +0800
Message-Id: <9cc26a5f783587deaf7ab5982e8dc4a0f0b2f1dc.1701759405.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1701759405.git.geliang.tang@linux.dev>
References: <cover.1701759405.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use mptcp_lib_print_info() and _ok() helpers in script mptcp_connect.sh
to print test results with colors.

Having colors helps to quickly identify issues when looking at a long
list of output logs and results.

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 .../selftests/net/mptcp/mptcp_connect.sh      | 24 ++++++++++---------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index cf9548e190b1..e566b57d5cc1 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -242,7 +242,8 @@ check_mptcp_disabled()
 
 	# net.mptcp.enabled should be enabled by default
 	if [ "$(ip netns exec ${disabled_ns} sysctl net.mptcp.enabled | awk '{ print $3 }')" -ne 1 ]; then
-		echo -e "net.mptcp.enabled sysctl is not 1 by default\t\t[ FAIL ]"
+		echo -n -e "net.mptcp.enabled sysctl is not 1 by default\t\t"
+		mptcp_lib_print_err "\t\t   [ FAIL ]"
 		mptcp_lib_result_fail "net.mptcp.enabled sysctl is not 1 by default"
 		ret=1
 		return 1
@@ -255,13 +256,15 @@ check_mptcp_disabled()
 	ip netns delete ${disabled_ns}
 
 	if [ ${err} -eq 0 ]; then
-		echo -e "New MPTCP socket cannot be blocked via sysctl\t\t[ FAIL ]"
+		echo -n -e "New MPTCP socket cannot be blocked via sysctl\t\t"
+		mptcp_lib_print_err "\t\t   [ FAIL ]"
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
@@ -477,7 +480,7 @@ do_transfer()
 	fi
 
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ]; then
-		printf "[ OK ]"
+		mptcp_lib_print_ok "[ OK ]"
 		mptcp_lib_result_pass "${TEST_GROUP}: ${result_msg}"
 	else
 		mptcp_lib_result_fail "${TEST_GROUP}: ${result_msg}"
@@ -508,7 +511,6 @@ do_transfer()
 			"${expect_ackrx}" "${stat_ackrx_now_l}"
 	fi
 
-	echo
 	cat "$capout"
 	[ $retc -eq 0 ] && [ $rets -eq 0 ]
 }
@@ -684,7 +686,7 @@ EOF
 		return
 	fi
 
-	echo "INFO: test $msg"
+	mptcp_lib_print_info "INFO: test $msg"
 
 	TEST_COUNT=10000
 	local extra_args="-o TRANSPARENT"
@@ -711,7 +713,7 @@ run_tests_peekmode()
 	local peekmode="$1"
 
 	TEST_GROUP="peek mode: ${peekmode}"
-	echo "INFO: with peek mode: ${peekmode}"
+	mptcp_lib_print_info "INFO: with peek mode: ${peekmode}"
 	run_tests_lo "$ns1" "$ns1" 10.0.1.1 1 "-P ${peekmode}"
 	run_tests_lo "$ns1" "$ns1" dead:beef:1::1 1 "-P ${peekmode}"
 }
@@ -726,7 +728,7 @@ run_tests_mptfo()
 		return
 	fi
 
-	echo "INFO: with MPTFO start"
+	mptcp_lib_print_info "INFO: with MPTFO start"
 	ip netns exec "$ns1" sysctl -q net.ipv4.tcp_fastopen=2
 	ip netns exec "$ns2" sysctl -q net.ipv4.tcp_fastopen=1
 
@@ -738,7 +740,7 @@ run_tests_mptfo()
 
 	ip netns exec "$ns1" sysctl -q net.ipv4.tcp_fastopen=0
 	ip netns exec "$ns2" sysctl -q net.ipv4.tcp_fastopen=0
-	echo "INFO: with MPTFO end"
+	mptcp_lib_print_info "INFO: with MPTFO end"
 }
 
 run_tests_disconnect()
@@ -762,7 +764,7 @@ run_tests_disconnect()
 	cin_disconnect="$old_cin"
 	connect_per_transfer=3
 
-	echo "INFO: disconnect"
+	mptcp_lib_print_info "INFO: disconnect"
 	run_tests_lo "$ns1" "$ns1" 10.0.1.1 1 "-I 3 -i $old_cin"
 	run_tests_lo "$ns1" "$ns1" dead:beef:1::1 1 "-I 3 -i $old_cin"
 
@@ -811,7 +813,7 @@ check_mptcp_disabled
 
 stop_if_error "The kernel configuration is not valid for MPTCP"
 
-echo "INFO: validating network environment with pings"
+mptcp_lib_print_info "INFO: validating network environment with pings"
 for sender in "$ns1" "$ns2" "$ns3" "$ns4";do
 	do_ping "$ns1" $sender 10.0.1.1
 	do_ping "$ns1" $sender dead:beef:1::1
-- 
2.35.3

