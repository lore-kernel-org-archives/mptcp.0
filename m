Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ED967E9E
	for <mptcp@lists.linux.dev>; Fri,  1 Mar 2024 06:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709275626; cv=none; b=lCMKCsxJmxyV2C5HL/sydpr+QRaJActy2hRz+73ba8rjD+VWbermkXkI2+Mng8pwc3uQOmonxJ4fByGX4pL0a1f8IwD7lClZM6+HHw5YJ5LRvM2RA3nrLe5qtMgpqizWWQAVUPGbgK2LODeKpVyls97GqIinw9tJ3hcR/uR87TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709275626; c=relaxed/simple;
	bh=CWN8PfX0cqDC2HaWWfUnt5AFAZ6W4dWqc3Pu7lZRMlU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XltgbMQuHNLUnf5ELB7JuDso7/tJ/Bxav2nmbl0UJk8FFOGkKwlGFDapyUxuMIy1pDZwjaXRj9tlOlibwY7zoqelJ3FU3BBfOSPqdqIPi+Qc4Ylp25cX31Iq2pfuTJcXj7o4FT2d+6CXUQn8T+OwjYVIGxMtOL41uVFjH+VuOZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5TPsGhm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5TPsGhm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866D0C43390;
	Fri,  1 Mar 2024 06:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709275626;
	bh=CWN8PfX0cqDC2HaWWfUnt5AFAZ6W4dWqc3Pu7lZRMlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t5TPsGhmt1MPtXz82Vpqz+Eth/y9o9QmYTPwxpxVBbsByqZrLTIA7Bey4aRTgep1I
	 2oMk064Qp4sif/Nv1kM5iC1Wgdx+1f1GR4wom4bKgkj8Dst7CWyX7uUzSSQQFJwpUw
	 h80/88aDJimDdA6x0UaFqL2bfqLj31/aYmZeWO5n9JcgrHU0YTp2b9P0518IX0zQCz
	 ZMAi3Am7HGQmvAFKtr44h/rMSfEy3CnY+kLhDujQoiZhoc8Q05N8KotOzCt01xJs/r
	 EVRDvo2OKHs1T8wZz1ZjUq+42KBN4lGpLMp/iO1ZWV77c9E3kR7uqisA4vzf6kgTNx
	 c8NxsQEsBjBLw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 3/6] selftests: mptcp: print all error messages to stdout
Date: Fri,  1 Mar 2024 14:46:33 +0800
Message-Id: <7a116f2a3ed7a09a24e52644f83a46d153510bf7.1709275290.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1709275290.git.tanggeliang@kylinos.cn>
References: <cover.1709275290.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Some error messages are dropped while the others are printed to 'stdout'.
As part of the unification, this patch drop "1>&2" to let all errors
messages are printed to 'stdout'.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 10 +++++-----
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |  9 +++++----
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 242407a1b4da..be598e1e25f5 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -301,7 +301,7 @@ do_ping()
 	ip netns exec ${connector_ns} ping ${ping_args} $connect_addr >/dev/null || rc=1
 
 	if [ $rc -ne 0 ] ; then
-		echo "$listener_ns -> $connect_addr connectivity [ FAIL ]" 1>&2
+		echo "$listener_ns -> $connect_addr connectivity [ FAIL ]"
 		ret=1
 
 		return 1
@@ -477,13 +477,13 @@ do_transfer()
 
 	if [ ${stat_synrx_now_l} -lt ${expect_synrx} ]; then
 		printf "[ FAIL ] lower MPC SYN rx (%d) than expected (%d)\n" \
-			"${stat_synrx_now_l}" "${expect_synrx}" 1>&2
+			"${stat_synrx_now_l}" "${expect_synrx}"
 		retc=1
 	fi
 	if [ ${stat_ackrx_now_l} -lt ${expect_ackrx} ] && [ ${stat_ooo_now} -eq 0 ]; then
 		if [ ${stat_ooo_now} -eq 0 ]; then
 			printf "[ FAIL ] lower MPC ACK rx (%d) than expected (%d)\n" \
-				"${stat_ackrx_now_l}" "${expect_ackrx}" 1>&2
+				"${stat_ackrx_now_l}" "${expect_ackrx}"
 			rets=1
 		else
 			printf "[ Note ] fallback due to TCP OoO"
@@ -728,7 +728,7 @@ EOF
 	ip -net "$listener_ns" route del local $local_addr/0 dev lo table 100
 
 	if [ $lret -ne 0 ]; then
-		echo "FAIL: $msg, mptcp connection error" 1>&2
+		echo "FAIL: $msg, mptcp connection error"
 		ret=$lret
 		return 1
 	fi
@@ -817,7 +817,7 @@ log_if_error()
 	local msg="$1"
 
 	if [ ${ret} -ne 0 ]; then
-		echo "FAIL: ${msg}" 1>&2
+		echo "FAIL: ${msg}"
 
 		final_ret=${ret}
 		ret=0
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 6ed4aa32222f..bf22174c022c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -103,7 +103,8 @@ check_mark()
 	local v
 	for v in $values; do
 		if [ $v -ne 0 ]; then
-			echo "FAIL: got $tables $values in ns $ns , not 0 - not all expected packets marked" 1>&2
+			echo "FAIL: got $tables $values in ns $ns," \
+			     "not 0 - not all expected packets marked"
 			ret=1
 			return 1
 		fi
@@ -221,7 +222,7 @@ do_mptcp_sockopt_tests()
 	lret=$?
 
 	if [ $lret -ne 0 ]; then
-		echo "FAIL: SOL_MPTCP getsockopt" 1>&2
+		echo "FAIL: SOL_MPTCP getsockopt"
 		mptcp_lib_result_fail "sockopt v4"
 		ret=$lret
 		return
@@ -232,7 +233,7 @@ do_mptcp_sockopt_tests()
 	lret=$?
 
 	if [ $lret -ne 0 ]; then
-		echo "FAIL: SOL_MPTCP getsockopt (ipv6)" 1>&2
+		echo "FAIL: SOL_MPTCP getsockopt (ipv6)"
 		mptcp_lib_result_fail "sockopt v6"
 		ret=$lret
 		return
@@ -263,7 +264,7 @@ do_tcpinq_test()
 	local lret=$?
 	if [ $lret -ne 0 ];then
 		ret=$lret
-		echo "FAIL: mptcp_inq $*" 1>&2
+		echo "FAIL: mptcp_inq $*"
 		mptcp_lib_result_fail "TCP_INQ: $*"
 		return $lret
 	fi
-- 
2.40.1

