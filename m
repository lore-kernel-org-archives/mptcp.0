Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8475A50
	for <mptcp@lists.linux.dev>; Wed,  6 Mar 2024 01:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709689272; cv=none; b=fdBlX7VQqCuQj8GWO3cp6x9GjVd+x1R1bXNvc9V+8jzGLquo9zuYlCq8ZYU77o0JHIUzXWlG6ROmpcG2OE76ouHEHAnTuwZkkh0XAsbe27Ykrumr8Tm8Cnqi16WnwT4E23AMX0Z9Uf5xiW5p3ZZXW5HKWcX0EyOy17F7C8+8BCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709689272; c=relaxed/simple;
	bh=f0jTeinBjuVIE07L9iwf5FkS74tQY5blTjXDif9Iu7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=APfXcgio79aCnqEUvoXnkga3ZeYK3AqQnX5CTHRwOtljcVJCmldNPzXWzryIximflFcO20p2K281fQpwckfLIUtq064TCFlN7EARkaQ8ZsvTRCA2fZaH1lPnmId5+/6tK1KGUALpYpd0ygT0MmhyRQD+Z49oNNGFbQv0NfAaPMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H52+QvP9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H52+QvP9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0BF7C43390;
	Wed,  6 Mar 2024 01:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709689272;
	bh=f0jTeinBjuVIE07L9iwf5FkS74tQY5blTjXDif9Iu7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H52+QvP9JChILgIT0Qe8ncy5E8f7PvzYggXN9BA10IBrsy9F/dDpEyDS7Mi7LwP1L
	 tWDJGZEwXFuuu5oa/+mmebPTMc5ilZ+yJIcRXhCiTC1v9Ydy4555vsUokOT+5qqVTb
	 GyiCosw9zFKlvu1t5rMdkwWkIR9NwPvxMHnSPLeIxgZecUY9UA67vuWnHvFYQFqO0G
	 XRus72Ke8aNipYyxmC+X9mfZ5Hu4yud5d6nEqcuIoMEuCTRFejczWoeBVzfLe4xgSB
	 oa1iIMSP/y+Nj0kfuj01CAHuGo1bbNCRj1OdE7leEKcc2befrbAD7oXhRNOHEYttkb
	 ExvUz+UBo/Ssg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v13 4/9] selftests: mptcp: sockopt: print every test result
Date: Wed,  6 Mar 2024 09:40:54 +0800
Message-Id: <e77d501a8afa1577f58c741604f9df2a3e94735f.1709688778.git.tanggeliang@kylinos.cn>
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

Also fix the TAP output:

ok 1 - mptcp_sockopt: transfer ipv4
ok 2 - mptcp_sockopt: mark ipv4
ok 3 - mptcp_sockopt: transfer ipv6
ok 4 - mptcp_sockopt: mark ipv6
ok 5 - mptcp_sockopt: sockopt v4
ok 6 - mptcp_sockopt: sockopt v6
ok 7 - mptcp_sockopt: TCP_INQ: -t tcp
ok 8 - mptcp_sockopt: TCP_INQ: -6 -t tcp
ok 9 - mptcp_sockopt: TCP_INQ: -r tcp
ok 10 - mptcp_sockopt: TCP_INQ: -6 -r tcp
ok 11 - mptcp_sockopt: TCP_INQ: -r tcp -t tcp

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---

Notes:
    fix the TAP output

 .../selftests/net/mptcp/mptcp_sockopt.sh      | 42 +++++++++++--------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 7c70b52e63c6..17b36c1312f4 100755
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
@@ -162,8 +167,9 @@ do_transfer()
 	wait $spid
 	local rets=$?
 
+	print_title "Transfer ${ip:2}"
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
-		echo " client exit code $retc, server $rets"
+		echo "[FAIL] client exit code $retc, server $rets"
 		echo -e "\nnetns ${listener_ns} socket stat for ${port}:" 1>&2
 		ip netns exec ${listener_ns} ss -Menita 1>&2 -o "sport = :$port"
 
@@ -175,7 +181,14 @@ do_transfer()
 		ret=1
 		return 1
 	fi
+	if ! mptcp_lib_check_transfer $cin $sout "file received by server"; then
+		rets=1
+	else
+		echo "[ OK ]"
+	fi
+	mptcp_lib_result_code "${rets}" "transfer ${ip}"
 
+	print_title "Mark ${ip:2}"
 	if [ $local_addr = "::" ];then
 		check_mark $listener_ns 6 || retc=1
 		check_mark $connector_ns 6 || retc=1
@@ -184,15 +197,13 @@ do_transfer()
 		check_mark $connector_ns 4 || retc=1
 	fi
 
-	mptcp_lib_check_transfer $cin $sout "file received by server"
-	rets=$?
-
 	mptcp_lib_result_code "${retc}" "mark ${ip}"
-	mptcp_lib_result_code "${rets}" "transfer ${ip}"
 
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ];then
+		echo "[ OK ]"
 		return 0
 	fi
+	echo "[FAIL]"
 
 	return 1
 }
@@ -221,23 +232,27 @@ do_mptcp_sockopt_tests()
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
 
@@ -260,16 +275,17 @@ run_tests()
 
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
@@ -315,15 +331,7 @@ trap cleanup EXIT
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

