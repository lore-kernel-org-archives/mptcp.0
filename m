Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15D41BE873
	for <mptcp@lists.linux.dev>; Tue,  6 Aug 2024 11:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722943152; cv=none; b=NOI9JIVniF/sdyWd7wCFUght07laGGjMt9aYGPZ1WFr656+JxPUXLgqxsm4G3xomxfi/foMMyPEHZ/LmMBYGN3hk3519WRF+po8iM7VecyFN0BBUvdraYnZt4D4mpxvitDmk7EEPZV3xtd8jWtjImo5wHs64AHaWwNpPTThNWLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722943152; c=relaxed/simple;
	bh=ntv4ERciK31UQ3wl2w2eOgt9Q6p8SmLNF8w8ZzDLTQ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QX5I1TrODb82bShLzCAmqtsUbSxTy+j1/jf+b9qtrEy8OOnlOh99RYX+d2Wti2DyGF7A3avC2izR5KymPhSCeY9chpddhXf1KX1ena4cDXbaaopMbO1AEul4rY7jPlRBFLh5B/jdSUnG1wXAJ3bKxMf6Iw18mVuo10QIVNz3Kgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPyDB4I3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPyDB4I3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA160C32786;
	Tue,  6 Aug 2024 11:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722943151;
	bh=ntv4ERciK31UQ3wl2w2eOgt9Q6p8SmLNF8w8ZzDLTQ8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QPyDB4I34mRX2GhJ6qhpSpKmMVkfcMqeQsFi0O5EMJ0xEhRHm3z11HPWNRRy3q8eJ
	 Zt3KCxxzX6j4pstUScotorDfzLcls/DcQcTENXqjI3W1+FWrqfJQEMDyzTo+t4OuHI
	 k81OOezKdRVZ7tmWrvzyLqZCIS18LMqXH5DRs4Q+y8Rpe3Br+IJg8bmytz9W2SJjay
	 O/eNTWZMlR/6UNGrpuqDJOAYFUEaTRqwOFS44JQUS3+QyshKUhjtJf/yNXAeklG/Ae
	 D+Mzq9lr1CR3tLvKT9RL6yUoC52sKTFcuz5dVtCnKIga71M88+2CFVaL9a1seQO+Om
	 TNod9XRpEyqsQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 06 Aug 2024 13:18:54 +0200
Subject: [PATCH mptcp-next v3 6/8] selftests: mptcp: join: more explicit
 check name
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-mptcp-join-tx-mib-v3-6-c3b54d2099e9@kernel.org>
References: <20240806-mptcp-join-tx-mib-v3-0-c3b54d2099e9@kernel.org>
In-Reply-To: <20240806-mptcp-join-tx-mib-v3-0-c3b54d2099e9@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=7602; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ntv4ERciK31UQ3wl2w2eOgt9Q6p8SmLNF8w8ZzDLTQ8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmsgaoDHQ9p29VSLtxlTKvez3kC0QitOndhvQrz
 C2pUhQpHPqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrIGqAAKCRD2t4JPQmmg
 c2LwEACd0HRzAV+vOQ1e0PPMp2eQ+qjqura4trZS4uiBsznQGJ+qy0TsjbP32BdgI+isrRZvsmJ
 x7LWyplEk1DLF87MsQHBTkfmiaqjkPgkMTMBth3tUD+MNSxyJSY0kCyBZ0arfV4ggdHuI0XMLci
 c6dmqF5y34aKC6j4AWy53fz6AD35bYCrOkXYMTqESfvQTwOg3/FAGBiJfanwzXvVkOOLhxvZ/qP
 3byufGzstAGq2vmebScZuOleBA3Hubw4OUwK0mbI/dL1QA7eWsQormNH7QwjhDBzrwAe57uxsp5
 PZRTwzv8BMIWlraG9RQLxFMHjJtmvMjEirHcpSmbNzxje6gJeCi8O67+01X8xFElaWYuXc32McJ
 Sj7/6bkBk9LUZGqOhw/105h7DUgm62W7ugcNQ0ESKwWGmUpiGbFwYsYqsj1vSZB4cMWAWC4egV6
 qNgORyZo025yMEjdaHBwf6eWeIiyIqSViMZRc9UY4JfCdpzd05GZhoec+aoWcjU9cckeNMJ76sW
 kSO2zoaRIXGMYswokjatpEiEvDu3zhZ4T/9JgRQ/lP6X5We2macNEC1xMXX4qSbnU6AOMoOdDKD
 KC3n+fdsOsCvj1oKHZ12d7m0iGLIVj/xGrnGauDVpk2n9yxrKJPN/J9YQV5/8xZJhdEH7+90qfP
 SbRznxDg8wAmueA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Before, the check names had to be very short. It is no longer the case
now that these checks are printed on a dedicated line.

Then, it looks better to have more explicit names.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 59 +++++++++++++------------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 23ea8acb7a36..46e8e43c4a54 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -856,7 +856,7 @@ chk_cestab_nr()
 	local cestab=$2
 	local count
 
-	print_check "cestab $cestab"
+	print_check "currently established: $cestab"
 	count=$(mptcp_lib_get_counter ${ns} "MPTcpExtMPCurrEstab")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1132,7 +1132,7 @@ chk_csum_nr()
 		csum_ns2=${csum_ns2:1}
 	fi
 
-	print_check "sum"
+	print_check "checksum server"
 	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtDataCsumErr")
 	if [ -n "$count" ] && [ "$count" != "$csum_ns1" ]; then
 		extra_msg+=" ns1=$count"
@@ -1145,7 +1145,8 @@ chk_csum_nr()
 	else
 		print_ok
 	fi
-	print_check "csum"
+
+	print_check "checksum client"
 	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtDataCsumErr")
 	if [ -n "$count" ] && [ "$count" != "$csum_ns2" ]; then
 		extra_msg+=" ns2=$count"
@@ -1189,7 +1190,7 @@ chk_fail_nr()
 		fail_rx=${fail_rx:1}
 	fi
 
-	print_check "ftx"
+	print_check "fail tx"
 	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPFailTx")
 	if [ -n "$count" ] && [ "$count" != "$fail_tx" ]; then
 		extra_msg+=",tx=$count"
@@ -1203,7 +1204,7 @@ chk_fail_nr()
 		print_ok
 	fi
 
-	print_check "failrx"
+	print_check "fail rx"
 	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPFailRx")
 	if [ -n "$count" ] && [ "$count" != "$fail_rx" ]; then
 		extra_msg+=",rx=$count"
@@ -1236,7 +1237,7 @@ chk_fclose_nr()
 		extra_msg="invert"
 	fi
 
-	print_check "ctx"
+	print_check "fast close tx"
 	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPFastcloseTx")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1247,7 +1248,7 @@ chk_fclose_nr()
 		print_ok
 	fi
 
-	print_check "fclzrx"
+	print_check "fast close rx"
 	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPFastcloseRx")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1277,7 +1278,7 @@ chk_rst_nr()
 		extra_msg="invert"
 	fi
 
-	print_check "rtx"
+	print_check "reset tx"
 	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPRstTx")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1289,7 +1290,7 @@ chk_rst_nr()
 		print_ok
 	fi
 
-	print_check "rstrx"
+	print_check "reset rx"
 	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPRstRx")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1310,7 +1311,7 @@ chk_infi_nr()
 	local infi_rx=$2
 	local count
 
-	print_check "itx"
+	print_check "infi tx"
 	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtInfiniteMapTx")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1320,7 +1321,7 @@ chk_infi_nr()
 		print_ok
 	fi
 
-	print_check "infirx"
+	print_check "infi rx"
 	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtInfiniteMapRx")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1403,7 +1404,7 @@ chk_join_nr()
 		rc=${KSFT_SKIP}
 	elif [ "$count" != "$syn_nr" ]; then
 		rc=${KSFT_FAIL}
-		print_check "syn"
+		print_check "syn rx"
 		fail_test "got $count JOIN[s] syn expected $syn_nr"
 	fi
 
@@ -1417,7 +1418,7 @@ chk_join_nr()
 		# the subflow creation
 		if [ "$with_cookie" != 2 ] || [ "$count" -le "$syn_ack_nr" ] || [ "$count" -gt "$syn_nr" ]; then
 			rc=${KSFT_FAIL}
-			print_check "synack"
+			print_check "synack rx"
 			fail_test "got $count JOIN[s] synack expected $syn_ack_nr"
 		fi
 	fi
@@ -1427,7 +1428,7 @@ chk_join_nr()
 		rc=${KSFT_SKIP}
 	elif [ "$count" != "$ack_nr" ]; then
 		rc=${KSFT_FAIL}
-		print_check "ack"
+		print_check "ack rx"
 		fail_test "got $count JOIN[s] ack expected $ack_nr"
 	fi
 
@@ -1507,7 +1508,7 @@ chk_add_nr()
 
 	timeout=$(ip netns exec ${ns_tx} sysctl -n net.mptcp.add_addr_timeout)
 
-	print_check "add"
+	print_check "add addr rx"
 	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtAddAddr")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1519,7 +1520,7 @@ chk_add_nr()
 		print_ok
 	fi
 
-	print_check "echo"
+	print_check "add addr echo rx"
 	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtEchoAdd")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1530,7 +1531,7 @@ chk_add_nr()
 	fi
 
 	if [ $port_nr -gt 0 ]; then
-		print_check "pt"
+		print_check "add addr rx with port"
 		count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtPortAdd")
 		if [ -z "$count" ]; then
 			print_skip
@@ -1540,7 +1541,7 @@ chk_add_nr()
 			print_ok
 		fi
 
-		print_check "syn"
+		print_check "syn rx port"
 		count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPJoinPortSynRx")
 		if [ -z "$count" ]; then
 			print_skip
@@ -1551,7 +1552,7 @@ chk_add_nr()
 			print_ok
 		fi
 
-		print_check "synack"
+		print_check "synack rx port"
 		count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPJoinPortSynAckRx")
 		if [ -z "$count" ]; then
 			print_skip
@@ -1562,7 +1563,7 @@ chk_add_nr()
 			print_ok
 		fi
 
-		print_check "ack"
+		print_check "ack rx port"
 		count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPJoinPortAckRx")
 		if [ -z "$count" ]; then
 			print_skip
@@ -1573,7 +1574,7 @@ chk_add_nr()
 			print_ok
 		fi
 
-		print_check "syn"
+		print_check "syn rx port mismatch"
 		count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMismatchPortSynRx")
 		if [ -z "$count" ]; then
 			print_skip
@@ -1584,7 +1585,7 @@ chk_add_nr()
 			print_ok
 		fi
 
-		print_check "ack"
+		print_check "ack rx port mismatch"
 		count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMismatchPortAckRx")
 		if [ -z "$count" ]; then
 			print_skip
@@ -1608,7 +1609,7 @@ chk_add_tx_nr()
 
 	timeout=$(ip netns exec $ns1 sysctl -n net.mptcp.add_addr_timeout)
 
-	print_check "add TX"
+	print_check "add addr tx"
 	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtAddAddrTx")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1620,7 +1621,7 @@ chk_add_tx_nr()
 		print_ok
 	fi
 
-	print_check "echo TX"
+	print_check "add addr echo tx"
 	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtEchoAddTx")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1658,7 +1659,7 @@ chk_rm_nr()
 		extra_msg="invert"
 	fi
 
-	print_check "rm"
+	print_check "rm addr rx"
 	count=$(mptcp_lib_get_counter ${addr_ns} "MPTcpExtRmAddr")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1668,7 +1669,7 @@ chk_rm_nr()
 		print_ok
 	fi
 
-	print_check "rmsf"
+	print_check "rm subflow"
 	count=$(mptcp_lib_get_counter ${subflow_ns} "MPTcpExtRmSubflow")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1703,7 +1704,7 @@ chk_rm_tx_nr()
 {
 	local rm_addr_tx_nr=$1
 
-	print_check "rm TX"
+	print_check "rm addr tx"
 	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtRmAddrTx")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1722,7 +1723,7 @@ chk_prio_nr()
 	local mpj_syn_ack=$4
 	local count
 
-	print_check "ptx"
+	print_check "mp_prio tx"
 	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPPrioTx")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1732,7 +1733,7 @@ chk_prio_nr()
 		print_ok
 	fi
 
-	print_check "prx"
+	print_check "mp_prio rx"
 	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPPrioRx")
 	if [ -z "$count" ]; then
 		print_skip

-- 
2.45.2

