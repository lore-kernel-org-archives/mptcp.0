Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B00193077
	for <mptcp@lists.linux.dev>; Fri,  9 Aug 2024 11:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723204420; cv=none; b=fr8kxC3qA2X4UJkB0FAg5y29FixmCjBvYIoL6pMZX1M36f6spGYie8Bog0U1eSR7Ewg2wMz46fKacEfutaxy07fH4eRhVlirvazJ+HSgfSr3nQLTs87JOI37UgSK/mHXG66aP0nt1Qwn2Fi8dkZ85byA3PU+yRXDhpuemzPvskA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723204420; c=relaxed/simple;
	bh=dcvHN8tXoyOB6ReR4Ha5tUVZbK852mFX8b6oevVKsrg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CBwTgZ+LItvdGLs+SipNeFpUwRLPk/PBi//fGmjm8W83tNsu89I3XnageBX3whf3WbBCjLqvPMLXWvN+AhOP/gFefY8h7sc1k/bQTzhvyysW9s4WHoiwPQKWmSwsn7iOweqzNk7VDEClvJVGGrjH8RZwpC3R3EKvmNrby8B5/ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3BT6Awu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3BT6Awu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E498AC32782;
	Fri,  9 Aug 2024 11:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723204420;
	bh=dcvHN8tXoyOB6ReR4Ha5tUVZbK852mFX8b6oevVKsrg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=t3BT6AwuIoyHFfZfXovy62BFwPdTSPyjiYidbhKsDQiGzf2kkZTfgB6LTe5T8Q4HD
	 y2CAlj6t636fJTP2RYDfz3nM4gt40fApfYp1C9QNsm5QdDG0Mx5ptHDgfB9Ux4dvnA
	 TFFAdXQchYZCge4jfnhU/s/KxMQaFQvne1udinnnF2yAPnygaOsr73cqRIDB5VdVO7
	 JJ5DcDR/sO9m02kF5CDKr0Ggrfn1uZQlKRIGUSNzxhO9Iy1Rwlqa6wtNA5VP2GG5vr
	 Hb6wMOLj/41OZCi8rBISxt1HYwM5KZ7N2n8SfAZUP7jPBIgsdKbtW2se4gZ8dpQ9hZ
	 RV1FP8sR8wykA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 09 Aug 2024 13:51:22 +0200
Subject: [PATCH mptcp-next v4 4/8] selftests: mptcp: join: one line for
 join check
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-mptcp-join-tx-mib-v4-4-98b0b0e098c5@kernel.org>
References: <20240809-mptcp-join-tx-mib-v4-0-98b0b0e098c5@kernel.org>
In-Reply-To: <20240809-mptcp-join-tx-mib-v4-0-98b0b0e098c5@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3162; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=dcvHN8tXoyOB6ReR4Ha5tUVZbK852mFX8b6oevVKsrg=;
 b=owEBbAKT/ZANAwAIAfa3gk9CaaBzAcsmYgBmtgM/QTTub0Zza0seHHE/kYckTwRt8l5i4umd1
 Bi7+LLLdrWJAjIEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrYDPwAKCRD2t4JPQmmg
 c1S7D/d65Q/+GxWehtNRuzIkR56PZG/gbcSB7JqyAnU0MRKwKharpYHiQLRFdCRvXrSAt7yjJ1W
 8vrY13piV3atGvjyWy77BijvqudTF+K/6zy+Q9EUmYAA0pAM15DpcNCQUVmSea1QD1jNzQUlvcJ
 g7hnqbFoQrDCIoe7QXUvWhR2hjBTqTNRQw508sMlQzW4JoqzNZ5xPlMgB0ahdFC4VZeyRn7/t15
 CUmLz50vAtio5H8eVFWT+S7UVwo2w9n7M9k+lZGQ4qrIzngjEh4viu+X8L5Z22QDjoH5qvi3soK
 Vfyh9zBStb+WB5tajpW+WJ+zn/KTAZdKsqlGIX31Qpy9ILc9l0n9iS7Zhf4szjF6waWO6lCwFbj
 h1srXR7ZrlbYsdVtZ5n3LUIurH7V82wMXQuspmcU3bHrxyiGYpOQI3cpvTGOmXFblkwUaaubHIN
 pIjof6ij4vLnMorn6LF4gj8u1dReINQA97/w1Y8ykd4aowcbyHF4chNWAF9O6Zysq25RBidhrXq
 AMu6cNuTr5qRgedkBs6bdK3bobYosfdD9mAzEYRHS/q8A0Io2oz9gvwHb9naxLzecCU6vNK3HK4
 Zq31vPxey3T3Gy2dKo1T3WMFCpGJfeMrix6uscKV4gWbX0MIiZxwxd6eWO66pn+2TOBdm0qp0Ed
 nACZaEGk9KApf
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Most tests are checking if the expected number of SYN/SYN+ACK/ACK JOINs
have been received, each of them on one line.

More Join related tests are going to be checked soon, no need to add 5
new lines per test in case of success, just one is enough. In case of
issue, the errors will still be reported like before.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
  - v4
    - fail_test with a description. (Geliang)
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 45 ++++++++++++++++---------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 0401ba1aaf1b..9739c57f5ba6 100755
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
+		fail_test "see above"
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

