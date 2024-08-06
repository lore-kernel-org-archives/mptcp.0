Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF70E13B2AC
	for <mptcp@lists.linux.dev>; Tue,  6 Aug 2024 11:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722943150; cv=none; b=LDGhd7XrFyk1/p+w0c1eq/N4M9f1UGAnuMUvscilFGJejP/H3sewUoIxK79CNT6rMRiyH4c/3g7Gq390U9mhIIH2QDNgHJc9fHXtK0k6HAQOYMFZbB/vgyntNo8wPtGsoQeboKzUs3DZtL7CJXagrg1/gMD0sxOsFx66Vb/g+g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722943150; c=relaxed/simple;
	bh=7eeIfWOdfy8EQiyo7rDxb3MXooMUvHzbK458WgX5nUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=na7o76ISaq+NILlexjUOd+x9rbxqRS4tJVxSBBATIdVaGsgRru1LvwTr5aJayejiHHvuCZZi6xrKfVQGpqjLWkSO2Xqt8Y12ek2BrHZePlQdQKd3vRwoME69GsoR76MLbZ6xKFL6zwqwioUxW7aDK3IG8EoLSWKnKjH8JzScwxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQ58P8f5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQ58P8f5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6AFC4AF0F;
	Tue,  6 Aug 2024 11:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722943149;
	bh=7eeIfWOdfy8EQiyo7rDxb3MXooMUvHzbK458WgX5nUQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uQ58P8f5dCZLJDOrqyvx6gUgZJYZCFv3Bec09xjyurMGBPsqmPve+dHCZifE7OD3Q
	 ic5+m0qDdfb+DUF+TFP0IOMKLeco5Wg0RaP9Lm3T4RCKqjCjvRqlemc2hN4Gdi9GGI
	 mY8O23tIXfI9DAPoknqgP1aYSBLv8zGeSnink9V5wYTxGAg6EvoUFfRbWqp/s2PUb+
	 MFvBpCUNfJYcsrLJxv8fevhO5h2twskP3t0cASmbxnxmJD62I+P9FeC83Mq65qsU42
	 40UwsMIXcB5RKdHd8UbnNWHV1qkdiMXjuUC41s5q1JYPCT0rdEhG1tJRfxNaJSz1Se
	 KOka9klKBnHDw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 06 Aug 2024 13:18:52 +0200
Subject: [PATCH mptcp-next v3 4/8] selftests: mptcp: join: one line for
 join check
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-mptcp-join-tx-mib-v3-4-c3b54d2099e9@kernel.org>
References: <20240806-mptcp-join-tx-mib-v3-0-c3b54d2099e9@kernel.org>
In-Reply-To: <20240806-mptcp-join-tx-mib-v3-0-c3b54d2099e9@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3082; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=7eeIfWOdfy8EQiyo7rDxb3MXooMUvHzbK458WgX5nUQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmsgaoIBFHes6/cqnpd4P/+a1NUzRCV3BryRxJP
 YHxkcsuxO2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrIGqAAKCRD2t4JPQmmg
 cwjtEAC/IkEw2XezhFVWMUAOp7cLU2j5hf46quZaWHevqh7MHSYMdCNRcvRzivBwsNfq88JUH42
 2CSMgq38ELIBvauoxv2AmliYBhNaXA5V+6z3Ev5roYd772YyXWJC4Yps14oUKBmFb/KjPIDcVVH
 IuRttSb9aUq4iVRAtq/PY+d4neoI0UKfc1wxOkLyty0BXiWDZT9hXMos6OQT1xaOdLCAeeu3COZ
 4Myy/aPRr63h5BvN63O7mzpshFRPX2xr7MWI8owNtCXph9lQm1g+UH9G+txytJh/LbexwD8AhkQ
 qKnGBIOoNW4EL5W4y+KOOCfdyq1+btdy/oMk/DT4IXIs8xfIV9Jaiu8Id3xT5nw7oIGpDpwVvKU
 fSCYlRTkplmQ4z/PmqCnzYReXl5/9PvkYiGJl6/nM/qcwq18bWdBFYBkEtjJO297MfoKwecsUBV
 7W/evU8l1FTaZG1yz5SsseMHmsBHFUqFnXZae5QLbB5NWL4sZhCef6r6eqarnjmpJIJ3/IpN0fW
 fq3lsa/sngDoQZ0bpqUlMjjqGkHGmTV1EFchbloL+VlpBUD0gLNHQ4ulCdp+avoP67ySHQen72d
 vnwgQnvASGUt7R4+IKAVT/QI2O9HClmHOup/gaPdpsVlZY5KlwFUFiAbhpWgyIOFevHYs1dDYMO
 6EVTOj8HNl0r5Gg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Most tests are checking if the expected number of SYN/SYN+ACK/ACK JOINs
have been received, each of them on one line.

More Join related tests are going to be checked soon, no need to add 5
new lines per test in case of success, just one is enough. In case of
issue, the errors will still be reported like before.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 45 ++++++++++++++++---------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 0401ba1aaf1b..b10bcb1ac970 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -202,6 +202,22 @@ print_skip()
 	mptcp_lib_pr_skip "${@}"
 }
 
+# $1: check name; $2: rc
+print_results()
+{
+	local check="${1}"
+	local rc=${2}
+
+	print_check "${check}"
+	if [ ${rc} = ${KSFT_PASS} ]; then
+		print_ok
+	elif [ ${rc} = ${KSFT_SKIP} ]; then
+		print_skip
+	else
+		fail_test
+	fi
+}
+
 # [ $1: fail msg ]
 mark_as_skipped()
 {
@@ -1326,6 +1342,7 @@ chk_join_nr()
 	local rst_nr=${join_rst_nr:-0}
 	local infi_nr=${join_infi_nr:-0}
 	local corrupted_pkts=${join_corrupted_pkts:-0}
+	local rc=${KSFT_PASS}
 	local count
 	local with_cookie
 
@@ -1333,43 +1350,41 @@ chk_join_nr()
 		print_info "${corrupted_pkts} corrupted pkts"
 	fi
 
-	print_check "syn"
 	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinSynRx")
 	if [ -z "$count" ]; then
-		print_skip
+		rc=${KSFT_SKIP}
 	elif [ "$count" != "$syn_nr" ]; then
+		rc=${KSFT_FAIL}
+		print_check "syn"
 		fail_test "got $count JOIN[s] syn expected $syn_nr"
-	else
-		print_ok
 	fi
 
-	print_check "synack"
 	with_cookie=$(ip netns exec $ns2 sysctl -n net.ipv4.tcp_syncookies)
 	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtMPJoinSynAckRx")
 	if [ -z "$count" ]; then
-		print_skip
+		rc=${KSFT_SKIP}
 	elif [ "$count" != "$syn_ack_nr" ]; then
 		# simult connections exceeding the limit with cookie enabled could go up to
 		# synack validation as the conn limit can be enforced reliably only after
 		# the subflow creation
-		if [ "$with_cookie" = 2 ] && [ "$count" -gt "$syn_ack_nr" ] && [ "$count" -le "$syn_nr" ]; then
-			print_ok
-		else
+		if [ "$with_cookie" != 2 ] || [ "$count" -le "$syn_ack_nr" ] || [ "$count" -gt "$syn_nr" ]; then
+			rc=${KSFT_FAIL}
+			print_check "synack"
 			fail_test "got $count JOIN[s] synack expected $syn_ack_nr"
 		fi
-	else
-		print_ok
 	fi
 
-	print_check "ack"
 	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinAckRx")
 	if [ -z "$count" ]; then
-		print_skip
+		rc=${KSFT_SKIP}
 	elif [ "$count" != "$ack_nr" ]; then
+		rc=${KSFT_FAIL}
+		print_check "ack"
 		fail_test "got $count JOIN[s] ack expected $ack_nr"
-	else
-		print_ok
 	fi
+
+	print_results "join Rx" ${rc}
+
 	if $validate_checksum; then
 		chk_csum_nr $csum_ns1 $csum_ns2
 		chk_fail_nr $fail_nr $fail_nr

-- 
2.45.2

