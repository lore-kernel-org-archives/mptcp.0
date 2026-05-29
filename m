Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF8434A78F
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 03:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780024934; cv=none; b=PiJAhih4HZgFxd5LevYgQLHIvQnTaCN9ycmtSz5KCuyEe+KnGG9IJfQATutuBst/C0Bs0b/Z30VJQCBiOVNRgE4+hk6X+vkmw99j/lW8E6qGt/gU2mTwrQwC3tXNqwQ+Jy9D9FES/wc6TfTqcL1Bat1aIscsld39gyuRlnWxgxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780024934; c=relaxed/simple;
	bh=eFRRUtLlaSDK5M12HoqIyj6tzF//osJkq7wWoc6D3dM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R3+9HzA6FbOaB877jFeQUdFV5Dv8bBdoTE5oWYNSBhYcrNd4R2pNirruaESdnjTpC2bYypfsZ6WiwQNI+nxEjWzYw+YndEmIfAWtc1AgaZKqtDoXw83nSRyPtQ5B0fvCehvwLRYry2hHG36Mxs/uK6IoGBPn34CQI7muIkKS+lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZy/1NH8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZy/1NH8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4817B1F000E9;
	Fri, 29 May 2026 03:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780024932;
	bh=S7CxZcapsEoPHXEpGpGH8EjVqlEvdqKsoyORIItShRs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=QZy/1NH8hZi8UZOGhJ+TQuAPEo5w3ngb8Js2vVhmsvq7d0Uj22L5csvbkTtEe5Auv
	 S93TMbo+IpfPbR8UuwkUxOyUlM/Xt/MH2eoreaxEbysk64trcRUc5pNoDDz+r5n46s
	 q1jVTZUhplgU3SLmZ7Gqso7kksqDgn0Cr2wMMYq1QHIpNWsXL1+ldmA7wDQR9wAnkQ
	 Zl4wdN1upFj6ldNOFaoLB8JfhYRZ+TQZhNapsQB0V7r59JnDSzpSOQ5pwbE2cTsLCG
	 TOaKdh1jOTtoB5i8fnulKSW/b4AxtWf09fl5cX6T1oIGfrS7JAhbmCPr2uL60rTzge
	 q8aKHoGjAjM6g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 29 May 2026 13:21:47 +1000
Subject: [PATCH mptcp-next v4 09/15] selftests: mptcp: always check
 sent/dropped ADD_ADDRs
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-mptcp-add-addr6-port-ts-v4-9-cea393fa33a2@kernel.org>
References: <20260529-mptcp-add-addr6-port-ts-v4-0-cea393fa33a2@kernel.org>
In-Reply-To: <20260529-mptcp-add-addr6-port-ts-v4-0-cea393fa33a2@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4863; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=eFRRUtLlaSDK5M12HoqIyj6tzF//osJkq7wWoc6D3dM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqGQZWNU80FV3CVzeubJZIo3G5B1zTlGfBg28C6
 pe5ZXqWv4iJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCahkGVgAKCRD2t4JPQmmg
 c70BEACJE/WBaGZ/fwBE5Xui2EmwJbwK/BpqJtGAi7c/cX4tFCSzJiAU8tZ9qs/TPqcdgtMBuYb
 KbNgFdb+FNCBsdtOGUGn25jUw+lm0cvmxLhal4Bc0em2bLz1ctD85h702KwHBjV9qMWFcgB6Xrp
 UQLE79uy3j5IeOrBWKC5UE6laLwZeaMYMUkYzmAp9uD5lY/66ZF5uMIjBRLpQhpnuXacjYpr291
 sASIEBkW7xqoGYP1fxED7JTMqGyus7KU1ZmvINTHtvn9mQt+JgODkHBD24q2yu2ZWnYxHv3x9r9
 aRKivkgeaMl5pU8MYyUrKpjLApDROkQ6M2AeLjoszAIzVGDHYClxkb+TcIdUmyS9/MVUf/q7mFB
 sTjDE7L/Am7hBxRm/MnDkr28OVAPu42BOKpwIE8SnbWJxbmDWI7lbObNN4whBp5TEwF9oDRuxv6
 bxJG6DrkxSk5JTqnufAtcn6phzazDBsTGGSwXZsHQZ2NeL5KR+D5m2yX8G690vB7A7UIG5jj/BW
 udHYT3S3OJTk8WQSpxUq1fLiDNDyCuTdX5vm+pVXGCFvflA6GthpMVYSrAcNMNo1qUjeS4BEmW4
 9lTh6cwa27DRLFB4SyTkTlxmd7Rk+SUvTl6pyGX7+RnW3dXgldSSDVac35furVeDvQsXYRfWBa0
 YEsjhLFEtq8sMkA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Before, they were only checked on demand, but it seems better to check
them each time received ADD_ADDRs are checked.

Errors are only reported when the counter exists, and the value is not
the expected one. This is similar to what is done in chk_join_nr: it
reduces the output, and avoids a lot of 'skip' when validating older
kernels. Also here, some tests need to adapt the default expected
counters, e.g. when ADD_ADDR echo are dropped on the reception side, or
it is not possible to send an ADD_ADDR due to the limited option space.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 71 ++++++++++---------------
 1 file changed, 27 insertions(+), 44 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 30dbdcdf5e4a..550a6b6117a9 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -87,6 +87,10 @@ unset fb_mpc_data
 unset fb_md5_sig
 unset fb_dss
 
+unset add_addr_tx_nr
+unset add_addr_echo_tx_nr
+unset add_addr_drop_tx_nr
+
 # generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) == 0x30) ||
 #				  (ip6 && (ip6[74] & 0xf0) == 0x30)'"
 CBPF_MPTCP_SUBOPTION_ADD_ADDR="14,
@@ -1710,6 +1714,9 @@ chk_add_nr()
 	local ack_nr=$port_nr
 	local mis_syn_nr=0
 	local mis_ack_nr=0
+	local add_tx_nr=${add_addr_tx_nr:-${add_nr}}
+	local echo_tx_nr=${add_addr_echo_tx_nr:-${echo_nr}}
+	local drop_tx_nr=${add_addr_drop_tx_nr:-0}
 	local ns_tx=$ns1
 	local ns_rx=$ns2
 	local tx=""
@@ -1811,50 +1818,25 @@ chk_add_nr()
 			print_ok
 		fi
 	fi
-}
 
-chk_add_tx_nr()
-{
-	local add_tx_nr=$1
-	local echo_tx_nr=$2
-	local count
-
-	print_check "add addr tx"
-	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtAddAddrTx")
-	if [ -z "$count" ]; then
-		print_skip
+	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtAddAddrTx")
 	# Tolerate more ADD_ADDR then expected (if any), due to retransmissions
-	elif [ "$count" != "$add_tx_nr" ] &&
-	     { [ "$add_tx_nr" -eq 0 ] || [ "$count" -lt "$add_tx_nr" ]; }; then
+	if [ -n "$count" ] && [ "$count" != "$add_tx_nr" ] &&
+	   { [ "$add_tx_nr" -eq 0 ] || [ "$count" -lt "$add_tx_nr" ]; }; then
+		print_check "add addr tx"
 		fail_test "got $count ADD_ADDR[s] TX, expected $add_tx_nr"
-	else
-		print_ok
 	fi
 
-	print_check "add addr echo tx"
-	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtEchoAddTx")
-	if [ -z "$count" ]; then
-		print_skip
-	elif [ "$count" != "$echo_tx_nr" ]; then
+	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtEchoAddTx")
+	if [ -n "$count" ] && [ "$count" != "$echo_tx_nr" ]; then
+		print_check "add addr echo tx"
 		fail_test "got $count ADD_ADDR echo[s] TX, expected $echo_tx_nr"
-	else
-		print_ok
 	fi
-}
 
-chk_add_drop_tx_nr()
-{
-	local drop_tx_nr=$1
-	local count
-
-	print_check "add addr tx drop"
-	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtAddAddrTxDrop")
-	if [ -z "$count" ]; then
-		print_skip
-	elif [ "$count" != "$drop_tx_nr" ]; then
+	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtAddAddrTxDrop")
+	if [ -n "$count" ] && [ "$count" != "$drop_tx_nr" ]; then
+		print_check "add addr tx drop"
 		fail_test "got $count ADD_ADDR drop[s] TX, expected $drop_tx_nr"
-	else
-		print_ok
 	fi
 }
 
@@ -2267,7 +2249,6 @@ signal_address_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
-		chk_add_tx_nr 1 1
 		chk_add_nr 1 1
 	fi
 
@@ -2545,8 +2526,8 @@ add_addr_timeout_tests()
 		speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
-		chk_add_tx_nr 4 4
-		chk_add_nr 4 0
+		add_addr_echo_tx_nr=4 \
+			chk_add_nr 4 0
 	fi
 
 	# add_addr timeout IPv6
@@ -2557,7 +2538,8 @@ add_addr_timeout_tests()
 		speed=slow \
 			run_tests $ns1 $ns2 dead:beef:1::1
 		chk_join_nr 1 1 1
-		chk_add_nr 4 0
+		add_addr_echo_tx_nr=4 \
+			chk_add_nr 4 0
 	fi
 
 	# signal addresses timeout
@@ -2569,7 +2551,8 @@ add_addr_timeout_tests()
 		speed=10 \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
-		chk_add_nr 8 0
+		add_addr_echo_tx_nr=8 \
+			chk_add_nr 8 0
 	fi
 
 	# signal invalid addresses timeout
@@ -2582,7 +2565,8 @@ add_addr_timeout_tests()
 			run_tests $ns1 $ns2 10.0.1.1
 		join_syn_tx=2 \
 			chk_join_nr 1 1 1
-		chk_add_nr 8 0
+		add_addr_echo_tx_nr=7 \
+			chk_add_nr 8 0
 	fi
 }
 
@@ -3331,9 +3315,8 @@ add_addr_ports_tests()
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal port 10100
 		pm_nl_add_endpoint $ns1 dead:beef:3::1 flags signal
 		run_tests $ns1 $ns2 dead:beef:1::1
-		chk_add_drop_tx_nr 1
-		chk_add_tx_nr 1 1
-		chk_add_nr 1 1 0
+		add_addr_drop_tx_nr=1 \
+			chk_add_nr 1 1 0
 	fi
 }
 

-- 
2.53.0

