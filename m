Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8649415AE0
	for <mptcp@lists.linux.dev>; Tue,  5 Dec 2023 07:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W1ICkCep"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701759812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=twa+zf++T2p1ks/c8QavHDePfhiK0c35fL1o4rTAweI=;
	b=W1ICkCepTe4txuCIdH+fRcprmpeiaVhTVD64LuVTM60IpVu+xaBzvQleIsY/BE8/j20yGt
	iAuzu1DFE3OSHouv0O40Feaha28UCIIfieSMB/BIMPKgvkUqH8o9nD/TTybrZXsSszEA/F
	V2f1WiGuRQmVwIK1t1HcFUpOaBtJ8lQ=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v5 14/33] selftests: mptcp: sockopt: print every test result
Date: Tue,  5 Dec 2023 15:01:01 +0800
Message-Id: <60b81e1e81a4f57d3e7429511bbf7fdcd05e8a6d.1701759405.git.geliang.tang@linux.dev>
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

Only total test results are printed out in mptcp_sockopt.sh:

 PASS: all packets had packet mark set
 PASS: SOL_MPTCP getsockopt has expected information
 PASS: TCP_INQ cmsg/ioctl -t tcp
 PASS: TCP_INQ cmsg/ioctl -6 -t tcp
 PASS: TCP_INQ cmsg/ioctl -r tcp
 PASS: TCP_INQ cmsg/ioctl -6 -r tcp

This patch prints more info for every test result in each test
group:

 transfer ipv4                                                [ OK ]
 mark ipv4                                                    [ OK ]
 transfer ipv6                                                [ OK ]
 mark ipv6                                                    [ OK ]
 PASS: all packets had packet mark set
 sockopt v4                                                   [ OK ]
 sockopt v6                                                   [ OK ]
 PASS: SOL_MPTCP getsockopt has expected information
 TCP_INQ: -t tcp                                              [ OK ]
 PASS: TCP_INQ cmsg/ioctl -t tcp
 TCP_INQ: -6 -t tcp                                           [ OK ]
 PASS: TCP_INQ cmsg/ioctl -6 -t tcp
 TCP_INQ: -r tcp                                              [ OK ]
 PASS: TCP_INQ cmsg/ioctl -r tcp
 TCP_INQ: -6 -r tcp                                           [ OK ]
 PASS: TCP_INQ cmsg/ioctl -6 -r tcp
 TCP_INQ: -r tcp -t tcp                                       [ OK ]

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 2290b3290214..8cee8bc6d6e5 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -152,6 +152,7 @@ do_transfer()
 	wait $spid
 	local rets=$?
 
+	printf "%-25s %35s" "transfer ${ip}" " "
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		echo " client exit code $retc, server $rets" 1>&2
 		echo -e "\nnetns ${listener_ns} socket stat for ${port}:" 1>&2
@@ -160,12 +161,15 @@ do_transfer()
 		echo -e "\nnetns ${connector_ns} socket stat for ${port}:" 1>&2
 		ip netns exec ${connector_ns} ss -Menita 1>&2 -o "dport = :$port"
 
+		mptcp_lib_print_err "[ FAIL ]"
 		mptcp_lib_result_fail "transfer ${ip}"
 
 		ret=1
 		return 1
 	fi
+	mptcp_lib_print_ok "[ OK ]"
 
+	printf "%-25s %35s" "mark ${ip}" " "
 	if [ $local_addr = "::" ];then
 		check_mark $listener_ns 6 || retc=1
 		check_mark $connector_ns 6 || retc=1
@@ -181,8 +185,10 @@ do_transfer()
 	mptcp_lib_result_code "${rets}" "transfer ${ip}"
 
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ];then
+		mptcp_lib_print_ok "[ OK ]"
 		return 0
 	fi
+	mptcp_lib_print_err "[ FAIL ]"
 
 	return 1
 }
@@ -211,23 +217,27 @@ do_mptcp_sockopt_tests()
 	ip netns exec "$ns3" ./mptcp_sockopt
 	lret=$?
 
+	printf "%-25s %35s" "sockopt v4" " "
 	if [ $lret -ne 0 ]; then
 		echo "FAIL: SOL_MPTCP getsockopt" 1>&2
 		mptcp_lib_result_fail "sockopt v4"
 		ret=$lret
 		return
 	fi
+	mptcp_lib_print_ok "[ OK ]"
 	mptcp_lib_result_pass "sockopt v4"
 
 	ip netns exec "$ns3" ./mptcp_sockopt -6
 	lret=$?
 
+	printf "%-25s %35s" "sockopt v6" " "
 	if [ $lret -ne 0 ]; then
 		echo "FAIL: SOL_MPTCP getsockopt (ipv6)" 1>&2
 		mptcp_lib_result_fail "sockopt v6"
 		ret=$lret
 		return
 	fi
+	mptcp_lib_print_ok "[ OK ]"
 	mptcp_lib_result_pass "sockopt v6"
 }
 
@@ -250,6 +260,7 @@ run_tests()
 
 do_tcpinq_test()
 {
+	printf "%-25s %35s" "TCP_INQ: $*" " "
 	ip netns exec "$ns3" ./mptcp_inq "$@"
 	local lret=$?
 	if [ $lret -ne 0 ];then
@@ -258,6 +269,7 @@ do_tcpinq_test()
 		mptcp_lib_result_fail "TCP_INQ: $*"
 		return $lret
 	fi
+	mptcp_lib_print_ok "[ OK ]"
 
 	echo "PASS: TCP_INQ cmsg/ioctl $@"
 	mptcp_lib_result_pass "TCP_INQ: $*"
-- 
2.35.3

