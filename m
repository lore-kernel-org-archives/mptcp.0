Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC0ABE4A
	for <mptcp@lists.linux.dev>; Sun,  3 Mar 2024 11:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709466790; cv=none; b=czxI14XA1ZG0+VYsWdRzSiqmkzTk2FVHNnfpP1pEY0Oph3AJi4X8ie1ukDywi1167a006ZY6kr/JDq7LOInZk4FXsuus8qpYx5iU8pdTrb32mIw7vESUfW3bMDQsht/gL1ihD5066x7PKJR6Zt8pS7tnfnPP57Mef8nUoZVCvjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709466790; c=relaxed/simple;
	bh=POK6HyvhsACvrS8L/c1QUhHc/4CLukJs44NtSP+v52c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gu+DeXd2MYaWPY5lu9bVw6sDtLMxT8zaHW70krjTM2dix+0w1XQnXf8BjJTj5KHfggl1pdypNdqB7MsBihQljzgl9uQMQsPHp4UGh3JmiQ3WWxiLC71svkgFfLF7B1vaSSPsXs02fp2e2LAea/nx1RnF7CaW8/1+4m3b/9cBQVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLMZwXSk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLMZwXSk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC914C43394;
	Sun,  3 Mar 2024 11:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709466790;
	bh=POK6HyvhsACvrS8L/c1QUhHc/4CLukJs44NtSP+v52c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vLMZwXSkiy9fV5ajrdrN68BWsJZ3zGYszzVIsMDQIMifSr7mxAcedVWCXW3iRdSe7
	 Th2dYA++96rx69+ig5JyUWslYlMbPsXfjUSxP+U2KIws/lamsWNzJZmA6Luzr03Bq9
	 AysnK+ytb+N2Zn/6gWUO8NKOEYn4PHqG88s82OVwLQVxfUd2AjLEHv5pyEw9pZb4JD
	 I4cwXX/PW2kAdIwjOyXC2IdB78lC8yc8P5tBENOZRGFaa1HO2XfdUxECEY65+t0mfd
	 t+FKQgv8V3OOh1R85aUz43REOhtLtx8pHoUs2kYFKkgTNlrMmoOS5/qR16aNspPeE/
	 HOF2gNWjU9nEg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 4/8] selftests: mptcp: sockopt: print every test result
Date: Sun,  3 Mar 2024 19:52:53 +0800
Message-Id: <d5d8963bae6555f4ebd9b51f9269cc7b64dedc94.1709466624.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1709466624.git.tanggeliang@kylinos.cn>
References: <cover.1709466624.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Only total test results are printed out in mptcp_sockopt.sh:

PASS: all packets had packet mark set
PASS: SOL_MPTCP getsockopt has expected information
PASS: TCP_INQ cmsg/ioctl -t tcp
PASS: TCP_INQ cmsg/ioctl -6 -t tcp
PASS: TCP_INQ cmsg/ioctl -r tcp
PASS: TCP_INQ cmsg/ioctl -6 -r tcp
PASS: TCP_INQ cmsg/ioctl -r tcp -t tcp

They mismatch with the test results:

ok 1 - mptcp_sockopt: mark ipv4
ok 2 - mptcp_sockopt: transfer ipv4
ok 3 - mptcp_sockopt: mark ipv6
ok 4 - mptcp_sockopt: transfer ipv6
ok 5 - mptcp_sockopt: sockopt v4
ok 6 - mptcp_sockopt: sockopt v6
ok 7 - mptcp_sockopt: TCP_INQ: -t tcp
ok 8 - mptcp_sockopt: TCP_INQ: -6 -t tcp
ok 9 - mptcp_sockopt: TCP_INQ: -r tcp
ok 10 - mptcp_sockopt: TCP_INQ: -6 -r tcp
ok 11 - mptcp_sockopt: TCP_INQ: -r tcp -t tcp

'mptcp_sockopt.sh' now display more detailed results + why (what you had
in a former patch from v6, merged here). It no longer displays 'PASS:',
because it is duplicated info now that the detailed are displayed:

Transfer v4                                       [ OK ]
Mark v4                                           [ OK ]
Transfer v6                                       [ OK ]
Mark v6                                           [ OK ]
SOL_MPTCP sockopt v4                              [ OK ]
SOL_MPTCP sockopt v6                              [ OK ]
TCP_INQ cmsg/ioctl -t tcp                         [ OK ]
TCP_INQ cmsg/ioctl -6 -t tcp                      [ OK ]
TCP_INQ cmsg/ioctl -r tcp                         [ OK ]
TCP_INQ cmsg/ioctl -6 -r tcp                      [ OK ]
TCP_INQ cmsg/ioctl -r tcp -t tcp                  [ OK ]

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 31 ++++++++++++-------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index bf22174c022c..f7f643779992 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -113,6 +113,11 @@ check_mark()
 	return 0
 }
 
+print_title()
+{
+	printf "%-50s" "${@}"
+}
+
 do_transfer()
 {
 	local listener_ns="$1"
@@ -162,6 +167,7 @@ do_transfer()
 	wait $spid
 	local rets=$?
 
+	print_title "Transfer ${ip:2}"
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		echo " client exit code $retc, server $rets" 1>&2
 		echo -e "\nnetns ${listener_ns} socket stat for ${port}:" 1>&2
@@ -175,7 +181,9 @@ do_transfer()
 		ret=1
 		return 1
 	fi
+	echo "[ OK ]"
 
+	print_title "Mark ${ip:2}"
 	if [ $local_addr = "::" ];then
 		check_mark $listener_ns 6 || retc=1
 		check_mark $connector_ns 6 || retc=1
@@ -191,8 +199,10 @@ do_transfer()
 	mptcp_lib_result_code "${rets}" "transfer ${ip}"
 
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ];then
+		echo "[ OK ]"
 		return 0
 	fi
+	echo "[FAIL]"
 
 	return 1
 }
@@ -221,23 +231,27 @@ do_mptcp_sockopt_tests()
 	ip netns exec "$ns_sbox" ./mptcp_sockopt
 	lret=$?
 
+	print_title "SOL_MPTCP sockopt v4"
 	if [ $lret -ne 0 ]; then
-		echo "FAIL: SOL_MPTCP getsockopt"
+		echo "[FAIL]"
 		mptcp_lib_result_fail "sockopt v4"
 		ret=$lret
 		return
 	fi
+	echo "[ OK ]"
 	mptcp_lib_result_pass "sockopt v4"
 
 	ip netns exec "$ns_sbox" ./mptcp_sockopt -6
 	lret=$?
 
+	print_title "SOL_MPTCP sockopt v6"
 	if [ $lret -ne 0 ]; then
-		echo "FAIL: SOL_MPTCP getsockopt (ipv6)"
+		echo "[FAIL]"
 		mptcp_lib_result_fail "sockopt v6"
 		ret=$lret
 		return
 	fi
+	echo "[ OK ]"
 	mptcp_lib_result_pass "sockopt v6"
 }
 
@@ -260,16 +274,17 @@ run_tests()
 
 do_tcpinq_test()
 {
+	print_title "TCP_INQ cmsg/ioctl $*"
 	ip netns exec "$ns_sbox" ./mptcp_inq "$@"
 	local lret=$?
 	if [ $lret -ne 0 ];then
 		ret=$lret
-		echo "FAIL: mptcp_inq $*"
+		echo "[FAIL]"
 		mptcp_lib_result_fail "TCP_INQ: $*"
 		return $lret
 	fi
 
-	echo "PASS: TCP_INQ cmsg/ioctl $*"
+	echo "[ OK ]"
 	mptcp_lib_result_pass "TCP_INQ: $*"
 	return $lret
 }
@@ -315,15 +330,7 @@ trap cleanup EXIT
 run_tests $ns1 $ns2 10.0.1.1
 run_tests $ns1 $ns2 dead:beef:1::1
 
-if [ $ret -eq 0 ];then
-	echo "PASS: all packets had packet mark set"
-fi
-
 do_mptcp_sockopt_tests
-if [ $ret -eq 0 ];then
-	echo "PASS: SOL_MPTCP getsockopt has expected information"
-fi
-
 do_tcpinq_tests
 
 mptcp_lib_result_print_all_tap
-- 
2.40.1

