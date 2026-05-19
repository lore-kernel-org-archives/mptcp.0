Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD4A3E5EE8
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 21:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779225936; cv=none; b=aJtC0GlFRvNpVtFW3KAG7hr5LSoiO1Zl9SeGMU57iDjYjuz/Vq6MI5uRYOQR+i3xBcYSas9PNQPcUhs3C55BkQ0tT5VdVv1IdbxSAl3OoAmoLfd9vReqLrHTSwzJZH6K+zdV2PTfBHoEhhVNErSveTHoM5Fxg5KhJi7Jzm0ccoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779225936; c=relaxed/simple;
	bh=mRUZ8fUJ0RdPTACYZ38omEzQSXZElas6fU7vIj+n7VU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l0T75FeoiAlnacPuCwmWokvJC9MUInSuc6AnjYGAz0WqEe9vOj41FHErP9QW5rxDPzEdcryz3xod5ZfkY9UkkvpH54L1ntVm7FwpLLs/yCIDWkqq/LKa3vGCfN8n7I0+JQagz3I1aNEau4dNmS43q98uf7jbXS/uXQ8r5hVqMw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSHvlEev; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSHvlEev"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3AC1F00893;
	Tue, 19 May 2026 21:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779225935;
	bh=2Nz2b4R39HJ/RleNIijKDRgk7riODoAYKUDaMa2MMTk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OSHvlEeviOGdeWY0sRlDPNb2+hIwPTp+wTohieXH0xrBkhfF95Ari5w36bRhukIk8
	 hkrHSRUCFEVfSpkZvGd2XBz/2NeLYBpCpsh5K8/dSJ8twqvzmq2Jaa7HJpHcVZQBOe
	 ehmR6CzlyzmBGLq6Wk0q2RJ1GKxtJh72hCeTVlhOruGEUbBmWE+CD+ewJwOH5GIqcB
	 RJTGtNZGFhpgB9pwqCuEHifDvGLqHjkhYlm52Eh8O5vVGFD7Jlw7yYyHGZ1TYajmQk
	 WVSq9aS0FuzT2Fgge5FnogUUoA9q2rFQ4BxFIFA+ALq1Ys5/jmVGrQ9lY0CKQ+FyfH
	 Jqeg8BEMn5rmw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 20 May 2026 07:25:20 +1000
Subject: [PATCH mptcp-next v3 09/16] selftests: mptcp: always check
 sent/dropped ADD_ADDRs
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-mptcp-add-addr6-port-ts-v3-9-bffa658a7678@kernel.org>
References: <20260520-mptcp-add-addr6-port-ts-v3-0-bffa658a7678@kernel.org>
In-Reply-To: <20260520-mptcp-add-addr6-port-ts-v3-0-bffa658a7678@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4863; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=mRUZ8fUJ0RdPTACYZ38omEzQSXZElas6fU7vIj+n7VU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqDNVBc4PumfqTVtO0kSE6ZOGUJ7DNO/el1qzb/
 Iv+ZnukppCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagzVQQAKCRD2t4JPQmmg
 cyQ6EACzAXu+QgHEOHbj+EXaPH/na/MTylqlV20Machvkfg02WauJkbwoQjDnV00th43cxMHI33
 qmak0T/y6L33qTYsgYmDRqydNwmQFcfgHq8s9RwluxiLOJIY80e/E7sliMtTba1meK7E4SebNbs
 Q0HWCZqNTvV3DwRQuEa//WbTBOkC99+I2Bq5Hm/m3hpDpuCcMVMto+NR1SEQ+JMCDyDNN0F+g86
 M6Ot+lqgqzyq9ujlTdPzab29gxRcgkmtRwT8pNvpDW7JclTXOUb5whRULR6DZq8lC5eMEle2074
 nah3eOCHsu9ealpnmIYJyUZ+qG1/LdRjI1lroJN05ngzhnCeo5Jwhp1w+B1vLtezVWA1XDP/5cN
 QJUDKZEtpYxpPEO1mLUmKj0YVCCWjlpUNm9GA63KOjB9BN+pIkFDLZZcE0OU4PluCuTNeft8ziX
 41ehaFICq9CtSHHXYCkBkGT960NBQ6PtTE0ik/9oZk/K8kjR+K2zU4wh1EZ6QlGOnmcdAVoMykV
 Czck/SpVqPAXgqkzY5FlFFJG6VSicqqFQ8QvzDPPjzNQU3zNX6wpjzAI62ov5ycEZ0BBN/yL/U0
 GP8Rq8iD+LNJMw7Tpif/rJRuLd8byNOMt93DDtr2+D6fRTQDg8PQo/kNjG9Ux/sTYlnhCC8p7xr
 f4Bbgy1zrbVRhIQ==
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
index d491c3e964d6..82c0f7df3be2 100755
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

