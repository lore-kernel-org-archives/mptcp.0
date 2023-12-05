Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6AE15481
	for <mptcp@lists.linux.dev>; Tue,  5 Dec 2023 07:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OJzZ0aM+"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701759822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ncBiZcWz0LJRnYAO6Y+Y3cIGO4AvvosRVmbMoclVNA=;
	b=OJzZ0aM+Se5E7S/iru7zQ66/VaKOA1TGcLqDHEEkfxl3eLBO8SKlLvsXWCeO35v0swfv/0
	dJ0wTlQ2C/l5k3l4kGxhakzR+ZYt6IhK/SLeqqMsSZzrlbbHmCQfv/VB4hcVP7542Xb54R
	czN5/eAxMYg5pyzLVHwBFWfqldTuqzM=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v5 22/33] selftests: mptcp: sockopt: print out test counter
Date: Tue,  5 Dec 2023 15:01:09 +0800
Message-Id: <b3eb6a10102838c64d8f3c9ad168aeb9c7205c1e.1701759405.git.geliang.tang@linux.dev>
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

This patch prints out TEST_COUNT for every tests in script
mptcp_sockopt.sh.

The output looks like:

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

Having test counters helps to quickly identify issues when looking at a
long list of output logs and results.

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 .../testing/selftests/net/mptcp/mptcp_sockopt.sh | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 338d48c248c4..de051a49745b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -152,7 +152,8 @@ do_transfer()
 	wait $spid
 	local rets=$?
 
-	printf "%-25s %35s" "transfer ${ip}" " "
+	TEST_COUNT=$((TEST_COUNT+1))
+	printf "%02u %-25s %35s" "$TEST_COUNT" "transfer ${ip}" " "
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		echo " client exit code $retc, server $rets" 1>&2
 		echo -e "\nnetns ${listener_ns} socket stat for ${port}:" 1>&2
@@ -169,7 +170,8 @@ do_transfer()
 	fi
 	mptcp_lib_print_ok "[ OK ]"
 
-	printf "%-25s %35s" "mark ${ip}" " "
+	TEST_COUNT=$((TEST_COUNT+1))
+	printf "%02u %-25s %35s" "$TEST_COUNT" "mark ${ip}" " "
 	if [ $local_addr = "::" ];then
 		check_mark $listener_ns 6 || retc=1
 		check_mark $connector_ns 6 || retc=1
@@ -214,10 +216,11 @@ do_mptcp_sockopt_tests()
 		return
 	fi
 
+	TEST_COUNT=$((TEST_COUNT+1))
 	ip netns exec "$ns3" ./mptcp_sockopt
 	lret=$?
 
-	printf "%-25s %35s" "sockopt v4" " "
+	printf "%02u %-25s %35s" "$TEST_COUNT" "sockopt v4" " "
 	if [ $lret -ne 0 ]; then
 		mptcp_lib_print_err "[ FAIL ] SOL_MPTCP getsockopt"
 		mptcp_lib_result_fail "sockopt v4"
@@ -227,10 +230,11 @@ do_mptcp_sockopt_tests()
 	mptcp_lib_print_ok "[ OK ]"
 	mptcp_lib_result_pass "sockopt v4"
 
+	TEST_COUNT=$((TEST_COUNT+1))
 	ip netns exec "$ns3" ./mptcp_sockopt -6
 	lret=$?
 
-	printf "%-25s %35s" "sockopt v6" " "
+	printf "%02u %-25s %35s" "$TEST_COUNT" "sockopt v6" " "
 	if [ $lret -ne 0 ]; then
 		mptcp_lib_print_err "[ FAIL] SOL_MPTCP getsockopt (ipv6)"
 		mptcp_lib_result_fail "sockopt v6"
@@ -260,7 +264,9 @@ run_tests()
 
 do_tcpinq_test()
 {
-	printf "%-25s %35s" "TCP_INQ: $*" " "
+	TEST_COUNT=$((TEST_COUNT+1))
+
+	printf "%02u %-25s %35s" "$TEST_COUNT" "TCP_INQ: $*" " "
 	ip netns exec "$ns3" ./mptcp_inq "$@"
 	local lret=$?
 	if [ $lret -ne 0 ];then
-- 
2.35.3

