Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C573E17A5AC
	for <mptcp@lists.linux.dev>; Fri,  9 Aug 2024 11:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723204422; cv=none; b=SS+GV6wgG7d5ciAHw1IiawIL90Xazi4uJF7rHwPgboRBnGY6po2Id7NkTxhJzWu7qOMC0gt+1KAdrbBA4AOE37IdPMYlqzWZYkGKgaJ5DzTQ+gKvYwglqKviJynxwNWl4t/vVf5x+Jr8DHwKc2ly5agVOTjnvXEl949HzKZsDdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723204422; c=relaxed/simple;
	bh=dvCq1v8vZWclkTPB1+uiopJJ8muV5zHagRgFs+ze98E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UPtm8CMI09I5auDa9o64PLerqSJnS4vjH4YYB6MD2Amyxq2EZRnghrbqEXhYWknS8tfZJjQQdJHvk5IVYnAp2DF7fTcm8utoICHgD+U4wu8HVUid+6iocf5BRJ8dnK+C+lmX6fpKLa39PZCu0pvvO7dQ/tohjnGRpxNLq96wxXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwNwTLK6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwNwTLK6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E98C4AF0E;
	Fri,  9 Aug 2024 11:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723204422;
	bh=dvCq1v8vZWclkTPB1+uiopJJ8muV5zHagRgFs+ze98E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GwNwTLK6RtD/zdObqpAYUhk9z4fU6HjPvQ4trlw+/qp/RNUw2TlYYjiHbjHNWQTb4
	 RDhoZBgSs9DjDSkB8MYv3SGiNJLXVukBv2LGdpoP3fH1xw9cXHU7YWQB7qHEG87iF9
	 /NGNcDuXcuPSTSErWoXO2As/AcYs6D6O2UNd6BgfOU18brVAbtCA/ojzreVDkO1zt9
	 vwGPaVjG+YJKJZk6Y87O5F2QM2BCVfuhvxzJSnZlO8lSyACBscjoM9foQLdqKmBgRp
	 ODZOjIEMn8r/yrEAWI1INNfUTbI6wpPUhXnQDrsHJPm6WN7RI0zQiwGyIRIEVVQCTf
	 THl5QiipC8jIg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 09 Aug 2024 13:51:24 +0200
Subject: [PATCH mptcp-next v4 6/8] selftests: mptcp: join: more explicit
 check name
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-mptcp-join-tx-mib-v4-6-98b0b0e098c5@kernel.org>
References: <20240809-mptcp-join-tx-mib-v4-0-98b0b0e098c5@kernel.org>
In-Reply-To: <20240809-mptcp-join-tx-mib-v4-0-98b0b0e098c5@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=7975; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=dvCq1v8vZWclkTPB1+uiopJJ8muV5zHagRgFs+ze98E=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmtgM/i29nxZ56onAUn2Jn+BKKv+TPEAO6Vo2vz
 o2vyRYtCWKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrYDPwAKCRD2t4JPQmmg
 c+22EACaSpg5R8CPv92t+8UdhAywlTulxHUSsyXLelqfkfIqTMEvw6p6nWhhpun1HnMYdABNF+g
 bokufnwbQXgftlCcf3Yp5ZsKz7djwyYlTGGRJxqgesB7z54XallURYtShX4pI3sTLAFmKKQrCZL
 eKHnrPSjtw0IIHmKHzTuSTpu51huBdxDv7jhS+Vk3gJ5v6S96lQMz2s4ooyB6bMEUR5M5sTojXA
 kKFSu/1/tn14xnk5opRXVJuMYgFQ2LsIpaMhfnNo2H1xCpdrqQQ9iJjwK9QVL0dqhhxH6qEXHPS
 bY00JSVop/4VQRF4Hlk16r6uZAwJT7x1OQ7Yg7btJO1Ad1vy+vJdbnz9QNXMfJ9hFVh30063iHb
 sPSVQc2cTdTz9v94RK/VlY3vUvvGhAnMPYLoNSfN2IaxcBcabU+iaPuBPzui6lAKt6UY4dpojPS
 rBye77YUcCP0Jm+mMu6MVeWtGBtHJYtiiP5clPkH5nEAkn1Wl78y07YqyMtwtiLRlMt3aM+Qqpi
 +HROtxvHSkjszD0k0Bv/aIgPRT1fzaPduwpfYo7o25rTqmme507eJvoBZjUBcxRolhwMHdSIBHM
 +2YE2Xp+t33ReJ3PUILiVrEBSt5eOKU31VwhQNB0trwpMcibyHr1IcDPmZFSu68JXfqaZMqGSWJ
 6C+9gYrqYRAExBQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Before, the check names had to be very short. It is no longer the case
now that these checks are printed on a dedicated line.

Then, it looks better to have more explicit names.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
  - v4:
    - specify (again) tx in the failed message. (Geliang)
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 65 +++++++++++++------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 320cee75ac41..c54ea286128c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -860,7 +860,7 @@ chk_cestab_nr()
 	local cestab=$2
 	local count
 
-	print_check "cestab $cestab"
+	print_check "currently established: $cestab"
 	count=$(mptcp_lib_get_counter ${ns} "MPTcpExtMPCurrEstab")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1136,7 +1136,7 @@ chk_csum_nr()
 		csum_ns2=${csum_ns2:1}
 	fi
 
-	print_check "sum"
+	print_check "checksum server"
 	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtDataCsumErr")
 	if [ -n "$count" ] && [ "$count" != "$csum_ns1" ]; then
 		extra_msg+=" ns1=$count"
@@ -1149,7 +1149,8 @@ chk_csum_nr()
 	else
 		print_ok
 	fi
-	print_check "csum"
+
+	print_check "checksum client"
 	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtDataCsumErr")
 	if [ -n "$count" ] && [ "$count" != "$csum_ns2" ]; then
 		extra_msg+=" ns2=$count"
@@ -1193,7 +1194,7 @@ chk_fail_nr()
 		fail_rx=${fail_rx:1}
 	fi
 
-	print_check "ftx"
+	print_check "fail tx"
 	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPFailTx")
 	if [ -n "$count" ] && [ "$count" != "$fail_tx" ]; then
 		extra_msg+=",tx=$count"
@@ -1207,7 +1208,7 @@ chk_fail_nr()
 		print_ok
 	fi
 
-	print_check "failrx"
+	print_check "fail rx"
 	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPFailRx")
 	if [ -n "$count" ] && [ "$count" != "$fail_rx" ]; then
 		extra_msg+=",rx=$count"
@@ -1240,7 +1241,7 @@ chk_fclose_nr()
 		extra_msg="invert"
 	fi
 
-	print_check "ctx"
+	print_check "fast close tx"
 	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPFastcloseTx")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1251,7 +1252,7 @@ chk_fclose_nr()
 		print_ok
 	fi
 
-	print_check "fclzrx"
+	print_check "fast close rx"
 	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPFastcloseRx")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1281,7 +1282,7 @@ chk_rst_nr()
 		extra_msg="invert"
 	fi
 
-	print_check "rtx"
+	print_check "reset tx"
 	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPRstTx")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1293,7 +1294,7 @@ chk_rst_nr()
 		print_ok
 	fi
 
-	print_check "rstrx"
+	print_check "reset rx"
 	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPRstRx")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1314,7 +1315,7 @@ chk_infi_nr()
 	local infi_rx=$2
 	local count
 
-	print_check "itx"
+	print_check "infi tx"
 	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtInfiniteMapTx")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1324,7 +1325,7 @@ chk_infi_nr()
 		print_ok
 	fi
 
-	print_check "infirx"
+	print_check "infi rx"
 	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtInfiniteMapRx")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1407,8 +1408,8 @@ chk_join_nr()
 		rc=${KSFT_SKIP}
 	elif [ "$count" != "$syn_nr" ]; then
 		rc=${KSFT_FAIL}
-		print_check "syn"
-		fail_test "got $count JOIN[s] syn expected $syn_nr"
+		print_check "syn rx"
+		fail_test "got $count JOIN[s] syn rx expected $syn_nr"
 	fi
 
 	with_cookie=$(ip netns exec $ns2 sysctl -n net.ipv4.tcp_syncookies)
@@ -1421,8 +1422,8 @@ chk_join_nr()
 		# the subflow creation
 		if [ "$with_cookie" != 2 ] || [ "$count" -le "$syn_ack_nr" ] || [ "$count" -gt "$syn_nr" ]; then
 			rc=${KSFT_FAIL}
-			print_check "synack"
-			fail_test "got $count JOIN[s] synack expected $syn_ack_nr"
+			print_check "synack rx"
+			fail_test "got $count JOIN[s] synack rx expected $syn_ack_nr"
 		fi
 	fi
 
@@ -1431,8 +1432,8 @@ chk_join_nr()
 		rc=${KSFT_SKIP}
 	elif [ "$count" != "$ack_nr" ]; then
 		rc=${KSFT_FAIL}
-		print_check "ack"
-		fail_test "got $count JOIN[s] ack expected $ack_nr"
+		print_check "ack rx"
+		fail_test "got $count JOIN[s] ack rx expected $ack_nr"
 	fi
 
 	print_results "join Rx" ${rc}
@@ -1512,7 +1513,7 @@ chk_add_nr()
 
 	timeout=$(ip netns exec ${ns_tx} sysctl -n net.mptcp.add_addr_timeout)
 
-	print_check "add"
+	print_check "add addr rx"
 	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtAddAddr")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1524,7 +1525,7 @@ chk_add_nr()
 		print_ok
 	fi
 
-	print_check "echo"
+	print_check "add addr echo rx"
 	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtEchoAdd")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1535,7 +1536,7 @@ chk_add_nr()
 	fi
 
 	if [ $port_nr -gt 0 ]; then
-		print_check "pt"
+		print_check "add addr rx with port"
 		count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtPortAdd")
 		if [ -z "$count" ]; then
 			print_skip
@@ -1545,7 +1546,7 @@ chk_add_nr()
 			print_ok
 		fi
 
-		print_check "syn"
+		print_check "syn rx port"
 		count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPJoinPortSynRx")
 		if [ -z "$count" ]; then
 			print_skip
@@ -1556,7 +1557,7 @@ chk_add_nr()
 			print_ok
 		fi
 
-		print_check "synack"
+		print_check "synack rx port"
 		count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPJoinPortSynAckRx")
 		if [ -z "$count" ]; then
 			print_skip
@@ -1567,7 +1568,7 @@ chk_add_nr()
 			print_ok
 		fi
 
-		print_check "ack"
+		print_check "ack rx port"
 		count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPJoinPortAckRx")
 		if [ -z "$count" ]; then
 			print_skip
@@ -1578,7 +1579,7 @@ chk_add_nr()
 			print_ok
 		fi
 
-		print_check "syn"
+		print_check "syn rx port mismatch"
 		count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMismatchPortSynRx")
 		if [ -z "$count" ]; then
 			print_skip
@@ -1589,7 +1590,7 @@ chk_add_nr()
 			print_ok
 		fi
 
-		print_check "ack"
+		print_check "ack rx port mismatch"
 		count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMismatchPortAckRx")
 		if [ -z "$count" ]; then
 			print_skip
@@ -1613,7 +1614,7 @@ chk_add_tx_nr()
 
 	timeout=$(ip netns exec $ns1 sysctl -n net.mptcp.add_addr_timeout)
 
-	print_check "add TX"
+	print_check "add addr tx"
 	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtAddAddrTx")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1625,7 +1626,7 @@ chk_add_tx_nr()
 		print_ok
 	fi
 
-	print_check "echo TX"
+	print_check "add addr echo tx"
 	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtEchoAddTx")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1663,7 +1664,7 @@ chk_rm_nr()
 		extra_msg="invert"
 	fi
 
-	print_check "rm"
+	print_check "rm addr rx"
 	count=$(mptcp_lib_get_counter ${addr_ns} "MPTcpExtRmAddr")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1673,7 +1674,7 @@ chk_rm_nr()
 		print_ok
 	fi
 
-	print_check "rmsf"
+	print_check "rm subflow"
 	count=$(mptcp_lib_get_counter ${subflow_ns} "MPTcpExtRmSubflow")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1708,7 +1709,7 @@ chk_rm_tx_nr()
 {
 	local rm_addr_tx_nr=$1
 
-	print_check "rm TX"
+	print_check "rm addr tx"
 	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtRmAddrTx")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1727,7 +1728,7 @@ chk_prio_nr()
 	local mpj_syn_ack=$4
 	local count
 
-	print_check "ptx"
+	print_check "mp_prio tx"
 	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPPrioTx")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1737,7 +1738,7 @@ chk_prio_nr()
 		print_ok
 	fi
 
-	print_check "prx"
+	print_check "mp_prio rx"
 	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPPrioRx")
 	if [ -z "$count" ]; then
 		print_skip

-- 
2.45.2

