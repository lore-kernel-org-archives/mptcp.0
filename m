Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518FF10A1B
	for <mptcp@lists.linux.dev>; Tue,  5 Mar 2024 05:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709616139; cv=none; b=TtS74niHFsJH1XuqE6PXO6aAeRaAAQjWMQhkA/SDsqdhwPN8klCEd7CvVnKsp+XvjoBWLRHIeT873g+/0JmKQZE9kKfa5DI1gB23sr35dGHN0n0Qhzyb3qChFotvzGO0whIz/2vz7YtWNjJTVCB437fKokbWkvwzWsUnld3hl4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709616139; c=relaxed/simple;
	bh=f0jTeinBjuVIE07L9iwf5FkS74tQY5blTjXDif9Iu7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jwS+qoNdk7lGJu2Iz6t2FmR+p+xTGzGJHf1JCf3WkMU+aUCle5fCp6gSlFh48cowP8MEjZ05MTn8Bvu3aFp7/rF5sM8H+BxiwuC8NdFVaLVeA+Assp2OJZU7XOEKRyF907vnXWFuBtYV+scseGoOtj5w6oZg6rl0p3k/sCzmgSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIeupz0B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIeupz0B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5EBC43390;
	Tue,  5 Mar 2024 05:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709616139;
	bh=f0jTeinBjuVIE07L9iwf5FkS74tQY5blTjXDif9Iu7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vIeupz0B6PKAbSntCVe5FTgk7C3jrB68LPKCcgzPYWhW8dVTHNd9Unt6KeWRZDoDd
	 DzhV9U36KPxT9bBwaGAfTponFfudqneNA28fCFkA2QYUz3iEju1o0TpzicMIyWbsBS
	 jqdOCCXqbnB6gc42T/IIbwjXZX7NsFjFHuauPUTziUyIQPt9P5fNpm6lbOjyCr8x9g
	 4bqsHJ7baxeLBQg818JgKUpoLIN/RRlZWVbDVmGB1k7sXs/pTB02Ky4V/PbzcN25aL
	 lSzY8DtJi6zAjvfuIPBwLNUj3JfR/QPe3kles7eoYcjbtuMPF+56xWqY2uXooqnNkP
	 aw6fF+8+0B1hA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v12 4/9] selftests: mptcp: sockopt: print every test result
Date: Tue,  5 Mar 2024 13:22:02 +0800
Message-Id: <49a057cdf4728d52ce1301a04fe1fbe63a6c2a91.1709615883.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1709615883.git.tanggeliang@kylinos.cn>
References: <cover.1709615883.git.tanggeliang@kylinos.cn>
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

