Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64150AD5A
	for <mptcp@lists.linux.dev>; Sun,  3 Mar 2024 09:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709459595; cv=none; b=NatzZi+aIXUKkzYQ78R2EIuOlCkJ0ZO4wIz92/4eHauVy+Ba9BZAA5NTSs4pa92i9piqFfFIurgKc8bJhZUNg4LasAwEQ8NrI2cnJIX9V/rDnB02DZiM8+myE+SEbztCsZQvupuIlozZ71ccM6+9OjYFJxiS8Go8AAqwoVwL4jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709459595; c=relaxed/simple;
	bh=XJp4qlrsqFDyMqcpdQ+3RWmW8qOVLq8HkeyE6x+SDoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pbXHEEVbTmJSeluLH8QRTrjk+zjTr6DASFAkog2cosvhImpbf8CT5f+kFsQe0miZcGFIiOL96AVsntJTD5BMpDq2xa1AgQD1Pd59SN5pfrMFDB5q+yBYkOw0X/FOHZM1UUYyB8jMnzj4USSrrvZWrscCLCD+kPIxgyFqIbV516E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iiCxuqTH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iiCxuqTH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E5AC433F1;
	Sun,  3 Mar 2024 09:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709459594;
	bh=XJp4qlrsqFDyMqcpdQ+3RWmW8qOVLq8HkeyE6x+SDoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iiCxuqTHjMlEIIYF14xrcgp87t5aWOPz//MwV+kNqEeSzLfoS+Z7xcF0scUdNFXa1
	 XLCBFvcC8pO2uyNHZug/1LmY2aTmTTlwOstaOO4GHtq+tL8pa7HEvmp2gHGMyeW4ri
	 LjzFWXBt5foUS4YzAnZmI73zicR0byBAmcyxLO39s/6/UKHP3YCHP/sZgVON2Sa4ks
	 MjRa50xoiJS6Wb/WevRXMYCMg24vC8cTLUsFxTXADjAjZlUsWZ+5SD3N/PaPvvzJ9s
	 gOz/BOWMNYPVu5zFqRZo+v584sLrqizcnMKOKj7sYn6rBgYCIGZtaYGzcvjVbxErlJ
	 Gm/wMve34NqHw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 1/8] selftests: mptcp: print all error messages to stdout
Date: Sun,  3 Mar 2024 17:52:21 +0800
Message-Id: <25b38a5fd6e6f5d485a65ab3c1269b9ed8a0ac8b.1709459360.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1709459360.git.tanggeliang@kylinos.cn>
References: <cover.1709459360.git.tanggeliang@kylinos.cn>
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
index 0ca2960c9099..679e366c8f6b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -294,7 +294,7 @@ do_ping()
 	ip netns exec ${connector_ns} ping ${ping_args} $connect_addr >/dev/null || rc=1
 
 	if [ $rc -ne 0 ] ; then
-		echo "$listener_ns -> $connect_addr connectivity [ FAIL ]" 1>&2
+		echo "$listener_ns -> $connect_addr connectivity [ FAIL ]"
 		ret=1
 
 		return 1
@@ -470,13 +470,13 @@ do_transfer()
 
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
@@ -721,7 +721,7 @@ EOF
 	ip -net "$listener_ns" route del local $local_addr/0 dev lo table 100
 
 	if [ $lret -ne 0 ]; then
-		echo "FAIL: $msg, mptcp connection error" 1>&2
+		echo "FAIL: $msg, mptcp connection error"
 		ret=$lret
 		return 1
 	fi
@@ -810,7 +810,7 @@ log_if_error()
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

