Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E296A1BE873
	for <mptcp@lists.linux.dev>; Tue,  6 Aug 2024 11:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722943153; cv=none; b=rgH/GlV1Kt9x2hAW0yNUbbUeemxLaOgub7JBz75FETrU6hmC6kxwKisMbbd1+ZzYw7JZfQDo9VlAUzbs7K6gtpR5eeheE/qodd63yP0R/oM+eRFjRS6fhnaKqaCi51+oP6we0aMg+QcTC+ML/ZVqm2Qz8ctJ0cZGbILwJ6ek7GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722943153; c=relaxed/simple;
	bh=QeaN9eDa0KKA0O2ZrIdqGKGh8lIFJChW21TbQGBGwak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YWFRTFf3anlixPGtN+Q7lxfRQcJXRKoxGxEgNTXlDpb5+wC4K12L+4ayK70jcv/T+Ui4/ASa75K/OE3dk5U7LI42a6UZDZ8QuHn5aGVOhU5hW/mofYQqppg1XKo3nFFLl0iHURd2MCwdGev9AhYHnR11r6g7RbwTfkFQH3r1kvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPfpia7P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPfpia7P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE1FC4AF09;
	Tue,  6 Aug 2024 11:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722943152;
	bh=QeaN9eDa0KKA0O2ZrIdqGKGh8lIFJChW21TbQGBGwak=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NPfpia7PWprtHVKq60g6Wns73N/mmTjlkOxAXwi7bJfgUqjRd+gX5ItDSjpxxAiDS
	 /qLkMTIh3SZvt4gqolaSkFvTyLrY98dev4xnV0sQSI1HjDQFLJ7HhFdls1Xbf2l7J5
	 W0UEDVVDRDxWpyablXTwa4L3Wi/LgQKwAv0yMTlM9EP0Db5yD9pLiOKj9DYAkQwxgi
	 /qanFvdRQWJB447FtEN6tVM6ItqoL27XnAXNUgJjYNWSZqI5PzrL2SRGO3oIeE+X7g
	 pzcH6RELRDbezmzYyaMmCm5t3fIZ2VDXaFC/m8PZzoUoeqf0jVknB8XCEcAyyppNfr
	 eOazZYYNv1m7w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 06 Aug 2024 13:18:55 +0200
Subject: [PATCH mptcp-next v3 7/8] selftests: mptcp: join: specify host
 being checked
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-mptcp-join-tx-mib-v3-7-c3b54d2099e9@kernel.org>
References: <20240806-mptcp-join-tx-mib-v3-0-c3b54d2099e9@kernel.org>
In-Reply-To: <20240806-mptcp-join-tx-mib-v3-0-c3b54d2099e9@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=8676; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=QeaN9eDa0KKA0O2ZrIdqGKGh8lIFJChW21TbQGBGwak=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmsgaorrAlFtxgrCqqBQ0MU7J8fhVHWkm3HkGgA
 0J/jAavglyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrIGqAAKCRD2t4JPQmmg
 c0szD/9jdZD8UDwL8Wsq1zrv8FJIFCu0jFT0TDG6JUnZ1ayfwSIaI4Oafu/c6WAF+zRAQFc344a
 zhx7ifkcgNeUhxgK6/SGMuwKVtvdIlElGN89Tb7RUHK9nWriulMJ6biNhj/CvT49kGEF35e3wz/
 r5SpG++gh75H0ZvAdojsNplUKmsoNdYLJU6iuwcvGnqJ3zxnl1GUD/wqYS9WHUCuA02VHXNZhqk
 43UP+V01K7f+JC5h/csPtCd7w3XvRAtFNkuJYUgxxOFqHYyD1HK5qw5eKDhaSMjenEvUwtq893T
 pGyBc13EjIVkjxgEMKlQwVlnsaa/o2cY4/YUbmFR4nZHhS2CpPdtpThOPl/QD+KJkqzRdsL54hc
 EtfHW0GiDpPCKAVbW5LxZ3RlVa7guEsKuCxI4A6r3b/2Qrl7it222XZy4qLO4Wmq5vHEL4fjMdX
 XvX7ejWyrMWlyGspEpAlHlhGqwa+yXT7Pp277jUQJupRVSNabkuFqKIgrrQ8hKYgtX4hGDKNNx9
 LPYhxNeOePBAQ/WDRZEswFXfCKWcs+8bTkTUTrmaYU9wgtyEqU8qUDCgE/hNAxrPir93D+3OWGn
 OUOWF2ffH50ajwEcJmo31q/waUKziSVGItM9HsGBtbAlPuIbSO/sZg5VeGMr5JJFKjToKSC5yug
 LhEh2pJhCTpVvEg==
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
index 46e8e43c4a54..a8c4d6c04823 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1171,6 +1171,8 @@ chk_fail_nr()
 	local count
 	local ns_tx=$ns1
 	local ns_rx=$ns2
+	local tx="server"
+	local rx="client"
 	local extra_msg=""
 	local allow_tx_lost=0
 	local allow_rx_lost=0
@@ -1178,7 +1180,8 @@ chk_fail_nr()
 	if [[ $ns_invert = "invert" ]]; then
 		ns_tx=$ns2
 		ns_rx=$ns1
-		extra_msg="invert"
+		tx="client"
+		rx="server"
 	fi
 
 	if [[ "${fail_tx}" = "-"* ]]; then
@@ -1190,10 +1193,10 @@ chk_fail_nr()
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
@@ -1204,10 +1207,10 @@ chk_fail_nr()
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
@@ -1229,37 +1232,35 @@ chk_fclose_nr()
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
@@ -1270,15 +1271,17 @@ chk_rst_nr()
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
@@ -1290,7 +1293,7 @@ chk_rst_nr()
 		print_ok
 	fi
 
-	print_check "reset rx"
+	print_check "reset rx ${rx}"
 	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPRstRx")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1301,8 +1304,6 @@ chk_rst_nr()
 	else
 		print_ok
 	fi
-
-	print_info "$extra_msg"
 }
 
 chk_infi_nr()
@@ -1311,7 +1312,7 @@ chk_infi_nr()
 	local infi_rx=$2
 	local count
 
-	print_check "infi tx"
+	print_check "infi tx client"
 	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtInfiniteMapTx")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1321,7 +1322,7 @@ chk_infi_nr()
 		print_ok
 	fi
 
-	print_check "infi rx"
+	print_check "infi rx server"
 	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtInfiniteMapRx")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1496,19 +1497,21 @@ chk_add_nr()
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
@@ -1520,7 +1523,7 @@ chk_add_nr()
 		print_ok
 	fi
 
-	print_check "add addr echo rx"
+	print_check "add addr echo rx${tx}"
 	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtEchoAdd")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1531,7 +1534,7 @@ chk_add_nr()
 	fi
 
 	if [ $port_nr -gt 0 ]; then
-		print_check "add addr rx with port"
+		print_check "add addr rx with port${rx}"
 		count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtPortAdd")
 		if [ -z "$count" ]; then
 			print_skip
@@ -1541,7 +1544,7 @@ chk_add_nr()
 			print_ok
 		fi
 
-		print_check "syn rx port"
+		print_check "syn rx port${tx}"
 		count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPJoinPortSynRx")
 		if [ -z "$count" ]; then
 			print_skip
@@ -1552,7 +1555,7 @@ chk_add_nr()
 			print_ok
 		fi
 
-		print_check "synack rx port"
+		print_check "synack rx port${rx}"
 		count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPJoinPortSynAckRx")
 		if [ -z "$count" ]; then
 			print_skip
@@ -1563,7 +1566,7 @@ chk_add_nr()
 			print_ok
 		fi
 
-		print_check "ack rx port"
+		print_check "ack rx port${tx}"
 		count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPJoinPortAckRx")
 		if [ -z "$count" ]; then
 			print_skip
@@ -1574,7 +1577,7 @@ chk_add_nr()
 			print_ok
 		fi
 
-		print_check "syn rx port mismatch"
+		print_check "syn rx port mismatch${tx}"
 		count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMismatchPortSynRx")
 		if [ -z "$count" ]; then
 			print_skip
@@ -1585,7 +1588,7 @@ chk_add_nr()
 			print_ok
 		fi
 
-		print_check "ack rx port mismatch"
+		print_check "ack rx port mismatch${tx}"
 		count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMismatchPortAckRx")
 		if [ -z "$count" ]; then
 			print_skip
@@ -1596,8 +1599,6 @@ chk_add_nr()
 			print_ok
 		fi
 	fi
-
-	print_info "$extra_msg"
 }
 
 chk_add_tx_nr()
@@ -1641,6 +1642,8 @@ chk_rm_nr()
 	local count
 	local addr_ns=$ns1
 	local subflow_ns=$ns2
+	local addr="server"
+	local subflow="client"
 	local extra_msg=""
 
 	shift 2
@@ -1650,16 +1653,14 @@ chk_rm_nr()
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
@@ -1669,7 +1670,7 @@ chk_rm_nr()
 		print_ok
 	fi
 
-	print_check "rm subflow"
+	print_check "rm subflow ${subflow}"
 	count=$(mptcp_lib_get_counter ${subflow_ns} "MPTcpExtRmSubflow")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1683,7 +1684,7 @@ chk_rm_nr()
 		count=$((count + cnt))
 		if [ "$count" != "$rm_subflow_nr" ]; then
 			suffix="$count in [$rm_subflow_nr:$((rm_subflow_nr*2))]"
-			extra_msg+=" simult"
+			extra_msg="simult"
 		fi
 		if [ $count -ge "$rm_subflow_nr" ] && \
 		   [ "$count" -le "$((rm_subflow_nr *2 ))" ]; then
@@ -1704,7 +1705,7 @@ chk_rm_tx_nr()
 {
 	local rm_addr_tx_nr=$1
 
-	print_check "rm addr tx"
+	print_check "rm addr tx client"
 	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtRmAddrTx")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1723,7 +1724,7 @@ chk_prio_nr()
 	local mpj_syn_ack=$4
 	local count
 
-	print_check "mp_prio tx"
+	print_check "mp_prio tx server"
 	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPPrioTx")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1733,7 +1734,7 @@ chk_prio_nr()
 		print_ok
 	fi
 
-	print_check "mp_prio rx"
+	print_check "mp_prio rx client"
 	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPPrioRx")
 	if [ -z "$count" ]; then
 		print_skip

-- 
2.45.2

