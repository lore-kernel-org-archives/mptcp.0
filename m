Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E4B3F6C32
	for <mptcp@lists.linux.dev>; Mon, 18 May 2026 12:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109163; cv=none; b=dyV6q3DbZeXWl6WFFoD4ZjAm11to+1HHDCK8+PzZLC3AEOClEZgD/btKe65MCWJnbUEziRIBMrD+7txeUoY8H0juW/COeoBxP6fYH+XmJQf2xBF6c5CCAMhBPKTG9L/kj6b1oIAcR3PKHtLJPOFn+Wc3qHm6ApDjVVUO3Q7gdYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109163; c=relaxed/simple;
	bh=TRuNmJBPNrFxZsiPEKT/+vK50p+CzqAyydGOsc4W+jI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j0bMgLyEBZ44AqkhVMbHTvk/Kebqp6HKeOjmMmk/ZwJE38AJsb274p60+9TZ5F7xlIRlJPVbfTMa5w1e68ESBloFDJ1n5+AqWqfvphBxxlUpQcScIB7Gj4Q6eovEwpJzBFQivcetTrycjx1q+G60AZSJcLJs/TRtvmlggqC4LjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8UewHun; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8UewHun"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85812C2BCC6;
	Mon, 18 May 2026 12:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779109162;
	bh=TRuNmJBPNrFxZsiPEKT/+vK50p+CzqAyydGOsc4W+jI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Z8UewHuny5MQXlPNVt95167KQJDjAPzauU1YH7aZlQA9+RVQZd83UTxbRn3rjO6Cv
	 6McapvmW7FKFYQ42g6U5ViMNDSy6TDDfn4Qth+5t4QY2NAfGNqQ0Jly96AgEtzqOQ6
	 x48UCeLHWauGx2t1E2RmHsC+kncKeiYNGNhDLr2jmfjXFzBF8pArOnZAEdi1T5SbQp
	 iCiHCUxX84aNp1/9ftrABvN8D/TBbEo5PnFZdy2RruUnkBsm7dcIkQHUHR63mh7ErZ
	 oEJjw7RZjqxDP6vk4B2r9yISHHdjEyyTEVx+RN6axAimObTnylfhVnX7sceJwcunE6
	 AFEnpxXhnjIDA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 18 May 2026 22:59:09 +1000
Subject: [PATCH mptcp-next 05/12] selftests: mptcp: always check
 sent/dropped ADD_ADDRs
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-mptcp-add-addr6-port-ts-v1-5-f1ca26977fcd@kernel.org>
References: <20260518-mptcp-add-addr6-port-ts-v1-0-f1ca26977fcd@kernel.org>
In-Reply-To: <20260518-mptcp-add-addr6-port-ts-v1-0-f1ca26977fcd@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4863; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=TRuNmJBPNrFxZsiPEKT/+vK50p+CzqAyydGOsc4W+jI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqCw0hcDS7zTOrLxWAKi6mySB8tdRjf+L0Dj0Qv
 p1sWnreguCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagsNIQAKCRD2t4JPQmmg
 cznXEACnJHaWoF9KkWKTZ2Ef+Ac15D7yBpuRnWGMdUYn5f799Hw+bo7yYg8GyTWaQtH3r5GRS74
 pkfJ/HFVQd84Y5ab8gej4q3S3MMLU+qOaSBXQ63yBfH+f9OdU5vf7bYbmm+9Mo1u9kQG/yC07XE
 cY4NZzQ4SFYUteiF3rQVX2UlNXlNufTuPM3J3GJ7K7v09EswIXpTpQXVPVkbveP+v51OibsLmnu
 4vppScnH2GlqV78TUgGmbFoXjKhgvl1XToTgmzJAouRUgED3LMjJxsbFiKpwBSQgRPQWGuIPGW6
 v7gJpo8bFkyZAxJ1ce5pPjDVJxKHvfzz4xaeRQHyma6nyy9vkByIQe5oTOkVc9gi7tQlLfxemU3
 X3PMqj68j//u/0X+eYLnJl9esEheYIj7yul+ZUn3Q7hsEtnxGaOX3cMy+KVqUbx9+Ak1WcJOVo/
 b5JdqiBGKcihRWwttPQeOCVpyY3YBuwcR+s8kRjuYCnul82/8YzScZCzewPlhXGsk60kE40jwE+
 T8+HEiqQ6adscJNJYOQyuxxudMA0C9dVdZJDsQbgXzGUhvjgfDCH55OIkoeqC3p4vVjNUyr+zUr
 WoBzmDbNdUh9t7kpBzsprd1p7yWsq6nOfCeVBxB/ivl+8UVQQ6vwuQ0uHyIr/BbeEi1SwJGAcGa
 ooz9PkTLYmDuMKw==
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
index fa5be164b705..aa84affa7fa5 100755
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

