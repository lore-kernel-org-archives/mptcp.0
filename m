Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BD217A5AC
	for <mptcp@lists.linux.dev>; Fri,  9 Aug 2024 11:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723204423; cv=none; b=ZtxoU98ES0hE9EovsIVcworlzuZ07EQcnOr/To6/ePXWl1dknr4npxsju0QA5rNiThyX/6Md/YWAKls3x//u5g1Ce4VS22V/4PankXeue7vf9kRqIFblTxAIeGLnPNdvnmuBJzDFICNc5X+zXtTm2vWmA37TcXpJMoHkrkDTcmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723204423; c=relaxed/simple;
	bh=hjYY+Ub43ZQ656E9aYfMeR033msk6NZtHY2IFVJ8Cj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qfKeKJEN9yKxDxedscY5qmn7qUUKUltM7OBW0YjIMoz88dAxB0MFBE3SR9g3gOEgm6sBFMez+vvtfMv9zeEvJeeGTOheGABzsZsO6JO3c/iGP6n7TP1b0m0eZpagD+mykJ5utd9YmhckEt41OSyr34iLPuTdtLq0RUp9dWii2AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkX04PmZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkX04PmZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2014C32782;
	Fri,  9 Aug 2024 11:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723204423;
	bh=hjYY+Ub43ZQ656E9aYfMeR033msk6NZtHY2IFVJ8Cj0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lkX04PmZkufpbkF2znH+z/cPWmYkUTq+oatdldnCmfRkcFZ0UadIemwkxATpPNoHF
	 5/0LYsohF6jBBo2zCCQ8SrSHmw2r9PlgexWIR73kHK4XSuvoiSphrwp7XyXtU3RGDj
	 Vee/KaL/NJ8TzaCn4lpfUbU71hY7EGd+UyGUri9JGh3AT+aNTBALH9rAySR4nzFwzM
	 z5VL27c56olpM6700M0RC+c6t761928TaUAwZLWNAoI5tKjNV5JXqN5mIHlzUcOT8S
	 9RFyIPuO1x1x4+2nJMvdbPsxiKlP70QaydUvmoxjrUlzHzdOixrCNkP6iahsXILfVc
	 pGae2sNIWNNSQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 09 Aug 2024 13:51:25 +0200
Subject: [PATCH mptcp-next v4 7/8] selftests: mptcp: join: specify host
 being checked
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-mptcp-join-tx-mib-v4-7-98b0b0e098c5@kernel.org>
References: <20240809-mptcp-join-tx-mib-v4-0-98b0b0e098c5@kernel.org>
In-Reply-To: <20240809-mptcp-join-tx-mib-v4-0-98b0b0e098c5@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=8676; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=hjYY+Ub43ZQ656E9aYfMeR033msk6NZtHY2IFVJ8Cj0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmtgM/2LlbGYdesLwzoP5wO7ZC/CXqGGCtxay82
 XgGJ1hwb0GJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrYDPwAKCRD2t4JPQmmg
 c3etEADxIB9cYfhsVAqzlsilulmW6w+RibVvCIxNbBBAi0/vrGsoHHKJUNe4yDWkIQs9/AB6mkG
 BtE+ZEwn9s7YyKM7QSEG6lVcUopXHoxewbscjCpVYJaxOZPk6lZ+9eWCck1c9SpwBIGreO6pOb2
 7Wmf+RdYXO//S1/RTYc1+cLNPhG+LPaCRzJVwL8NAwaQqJOudZGgpQXqALE5HIgE/XoRQEx9kGS
 iVZfjRQEddxVRPusbLhEKuio7hD2GdDQdHZ27skp7RztaF+RodgIS19DF8quZJ7bjNFMK7mj6gG
 HXAUioN1FjiJopsrqZqKmUuWdgHfbE02pF6X9vbZNMhOWUykY+Uwc4jv68YryeXkrwos+J7I2ao
 EUojsOoaciqnv0fKmlu2jekfcUK+r5hTNEwWsiJIx9DmosCYRge3JY1g4BtvJiNDsyuKRPqc0Ng
 ZsETsi/H3DlbWnSR+witFk1YtoV+3iw+5EPuWe36e0plLIQcz7oaa0zkB77eEt8ByxZd7w7P9LY
 sbUFTJ95kd9dEakkqBM2mO6rBNU8ZY0fdJHA4Cpgplgvn/fsm/wHLXa4m+QedJHNKQIfxTs4rH6
 3mQNF8yb101uAcCAbYeHFa+lXlHrCAj3/RtCmM3ALj1Dip5v1J/sei+kbuLVHrlSU0DA51duSjH
 6SLN5lEx6ytp8rw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Instead of displaying 'invert' when looking at some events like MP_FAIL,
MP_FASTCLOSE, MP_RESET, RM_ADDR, which is a bit vague because they are
not traditionnaly sent from one side, the host being checked is now
printed.

For the ADD_ADDR, only display the host when it is the client sending
it, which is more unusual.

Also before, the 'invert' message was printed after a few checks, but it
was not clear which ones exactly.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 89 +++++++++++++------------
 1 file changed, 45 insertions(+), 44 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index c54ea286128c..717de94201ba 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1175,6 +1175,8 @@ chk_fail_nr()
 	local count
 	local ns_tx=$ns1
 	local ns_rx=$ns2
+	local tx="server"
+	local rx="client"
 	local extra_msg=""
 	local allow_tx_lost=0
 	local allow_rx_lost=0
@@ -1182,7 +1184,8 @@ chk_fail_nr()
 	if [[ $ns_invert = "invert" ]]; then
 		ns_tx=$ns2
 		ns_rx=$ns1
-		extra_msg="invert"
+		tx="client"
+		rx="server"
 	fi
 
 	if [[ "${fail_tx}" = "-"* ]]; then
@@ -1194,10 +1197,10 @@ chk_fail_nr()
 		fail_rx=${fail_rx:1}
 	fi
 
-	print_check "fail tx"
+	print_check "fail tx ${tx}"
 	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPFailTx")
 	if [ -n "$count" ] && [ "$count" != "$fail_tx" ]; then
-		extra_msg+=",tx=$count"
+		extra_msg+=" tx=$count"
 	fi
 	if [ -z "$count" ]; then
 		print_skip
@@ -1208,10 +1211,10 @@ chk_fail_nr()
 		print_ok
 	fi
 
-	print_check "fail rx"
+	print_check "fail rx ${rx}"
 	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPFailRx")
 	if [ -n "$count" ] && [ "$count" != "$fail_rx" ]; then
-		extra_msg+=",rx=$count"
+		extra_msg+=" rx=$count"
 	fi
 	if [ -z "$count" ]; then
 		print_skip
@@ -1233,37 +1236,35 @@ chk_fclose_nr()
 	local count
 	local ns_tx=$ns2
 	local ns_rx=$ns1
-	local extra_msg=""
+	local tx="client"
+	local rx="server"
 
 	if [[ $ns_invert = "invert" ]]; then
 		ns_tx=$ns1
 		ns_rx=$ns2
-		extra_msg="invert"
+		tx="server"
+		rx="client"
 	fi
 
-	print_check "fast close tx"
+	print_check "fast close tx ${tx}"
 	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPFastcloseTx")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$fclose_tx" ]; then
-		extra_msg+=",tx=$count"
 		fail_test "got $count MP_FASTCLOSE[s] TX expected $fclose_tx"
 	else
 		print_ok
 	fi
 
-	print_check "fast close rx"
+	print_check "fast close rx ${rx}"
 	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPFastcloseRx")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$fclose_rx" ]; then
-		extra_msg+=",rx=$count"
 		fail_test "got $count MP_FASTCLOSE[s] RX expected $fclose_rx"
 	else
 		print_ok
 	fi
-
-	print_info "$extra_msg"
 }
 
 chk_rst_nr()
@@ -1274,15 +1275,17 @@ chk_rst_nr()
 	local count
 	local ns_tx=$ns1
 	local ns_rx=$ns2
-	local extra_msg=""
+	local tx="server"
+	local rx="client"
 
 	if [[ $ns_invert = "invert" ]]; then
 		ns_tx=$ns2
 		ns_rx=$ns1
-		extra_msg="invert"
+		tx="client"
+		rx="server"
 	fi
 
-	print_check "reset tx"
+	print_check "reset tx ${tx}"
 	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPRstTx")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1294,7 +1297,7 @@ chk_rst_nr()
 		print_ok
 	fi
 
-	print_check "reset rx"
+	print_check "reset rx ${rx}"
 	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPRstRx")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1305,8 +1308,6 @@ chk_rst_nr()
 	else
 		print_ok
 	fi
-
-	print_info "$extra_msg"
 }
 
 chk_infi_nr()
@@ -1315,7 +1316,7 @@ chk_infi_nr()
 	local infi_rx=$2
 	local count
 
-	print_check "infi tx"
+	print_check "infi tx client"
 	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtInfiniteMapTx")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1325,7 +1326,7 @@ chk_infi_nr()
 		print_ok
 	fi
 
-	print_check "infi rx"
+	print_check "infi rx server"
 	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtInfiniteMapRx")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1501,19 +1502,21 @@ chk_add_nr()
 	local mis_ack_nr=0
 	local ns_tx=$ns1
 	local ns_rx=$ns2
-	local extra_msg=""
+	local tx=""
+	local rx=""
 	local count
 	local timeout
 
 	if [[ $ns_invert = "invert" ]]; then
 		ns_tx=$ns2
 		ns_rx=$ns1
-		extra_msg="invert"
+		tx=" client"
+		rx=" server"
 	fi
 
 	timeout=$(ip netns exec ${ns_tx} sysctl -n net.mptcp.add_addr_timeout)
 
-	print_check "add addr rx"
+	print_check "add addr rx${rx}"
 	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtAddAddr")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1525,7 +1528,7 @@ chk_add_nr()
 		print_ok
 	fi
 
-	print_check "add addr echo rx"
+	print_check "add addr echo rx${tx}"
 	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtEchoAdd")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1536,7 +1539,7 @@ chk_add_nr()
 	fi
 
 	if [ $port_nr -gt 0 ]; then
-		print_check "add addr rx with port"
+		print_check "add addr rx with port${rx}"
 		count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtPortAdd")
 		if [ -z "$count" ]; then
 			print_skip
@@ -1546,7 +1549,7 @@ chk_add_nr()
 			print_ok
 		fi
 
-		print_check "syn rx port"
+		print_check "syn rx port${tx}"
 		count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPJoinPortSynRx")
 		if [ -z "$count" ]; then
 			print_skip
@@ -1557,7 +1560,7 @@ chk_add_nr()
 			print_ok
 		fi
 
-		print_check "synack rx port"
+		print_check "synack rx port${rx}"
 		count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPJoinPortSynAckRx")
 		if [ -z "$count" ]; then
 			print_skip
@@ -1568,7 +1571,7 @@ chk_add_nr()
 			print_ok
 		fi
 
-		print_check "ack rx port"
+		print_check "ack rx port${tx}"
 		count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPJoinPortAckRx")
 		if [ -z "$count" ]; then
 			print_skip
@@ -1579,7 +1582,7 @@ chk_add_nr()
 			print_ok
 		fi
 
-		print_check "syn rx port mismatch"
+		print_check "syn rx port mismatch${tx}"
 		count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMismatchPortSynRx")
 		if [ -z "$count" ]; then
 			print_skip
@@ -1590,7 +1593,7 @@ chk_add_nr()
 			print_ok
 		fi
 
-		print_check "ack rx port mismatch"
+		print_check "ack rx port mismatch${tx}"
 		count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMismatchPortAckRx")
 		if [ -z "$count" ]; then
 			print_skip
@@ -1601,8 +1604,6 @@ chk_add_nr()
 			print_ok
 		fi
 	fi
-
-	print_info "$extra_msg"
 }
 
 chk_add_tx_nr()
@@ -1646,6 +1647,8 @@ chk_rm_nr()
 	local count
 	local addr_ns=$ns1
 	local subflow_ns=$ns2
+	local addr="server"
+	local subflow="client"
 	local extra_msg=""
 
 	shift 2
@@ -1655,16 +1658,14 @@ chk_rm_nr()
 		shift
 	done
 
-	if [ -z $invert ]; then
-		addr_ns=$ns1
-		subflow_ns=$ns2
-	elif [ $invert = "true" ]; then
+	if [ "$invert" = "true" ]; then
 		addr_ns=$ns2
 		subflow_ns=$ns1
-		extra_msg="invert"
+		addr="client"
+		subflow="server"
 	fi
 
-	print_check "rm addr rx"
+	print_check "rm addr rx ${addr}"
 	count=$(mptcp_lib_get_counter ${addr_ns} "MPTcpExtRmAddr")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1674,7 +1675,7 @@ chk_rm_nr()
 		print_ok
 	fi
 
-	print_check "rm subflow"
+	print_check "rm subflow ${subflow}"
 	count=$(mptcp_lib_get_counter ${subflow_ns} "MPTcpExtRmSubflow")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1688,7 +1689,7 @@ chk_rm_nr()
 		count=$((count + cnt))
 		if [ "$count" != "$rm_subflow_nr" ]; then
 			suffix="$count in [$rm_subflow_nr:$((rm_subflow_nr*2))]"
-			extra_msg+=" simult"
+			extra_msg="simult"
 		fi
 		if [ $count -ge "$rm_subflow_nr" ] && \
 		   [ "$count" -le "$((rm_subflow_nr *2 ))" ]; then
@@ -1709,7 +1710,7 @@ chk_rm_tx_nr()
 {
 	local rm_addr_tx_nr=$1
 
-	print_check "rm addr tx"
+	print_check "rm addr tx client"
 	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtRmAddrTx")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1728,7 +1729,7 @@ chk_prio_nr()
 	local mpj_syn_ack=$4
 	local count
 
-	print_check "mp_prio tx"
+	print_check "mp_prio tx server"
 	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPPrioTx")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1738,7 +1739,7 @@ chk_prio_nr()
 		print_ok
 	fi
 
-	print_check "mp_prio rx"
+	print_check "mp_prio rx client"
 	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPPrioRx")
 	if [ -z "$count" ]; then
 		print_skip

-- 
2.45.2

