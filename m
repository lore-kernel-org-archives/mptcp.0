Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9114C192B9F
	for <mptcp@lists.linux.dev>; Fri,  9 Aug 2024 11:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723204421; cv=none; b=A8V7qbG4tOFVHY0/a9IU5BFXVkLk9w081omDGFo8QgcMaAn6fmu9s+MT4K3b0eCmRrxvS/2cj4GIeGtWj86mKpy4DTaq5ix+ug5bAd5TwugZhKQ6sdP4DVL3FclVrj+OeeOmvZWmMaQOlF7hcwN7LpeakhODI9joe0lxf2CdpRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723204421; c=relaxed/simple;
	bh=oUbKAORZxUAlgllMUyhOdrEUI2zUNhTF+JHNRu7hDNU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sHIyn8B8KNECyHtNgYa+Z4lAreDCreSz4ffBrIPFacA7qDuEwnXHCyogKN0vtNYNRcL5lzjoJZymgcVG4dsXo3s3zZdEcujljrKIfB11APtu+xgXiAvMLwFJDz/NFeQgT+8BtjpZtP0eVNMcJJMM/70dJm2RUUn1UOd5LWSAPTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tk6ZPq/H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tk6ZPq/H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F89C4AF0D;
	Fri,  9 Aug 2024 11:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723204421;
	bh=oUbKAORZxUAlgllMUyhOdrEUI2zUNhTF+JHNRu7hDNU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tk6ZPq/HGOBsV/jfigfbBJoz2ltR5GI9DEfcO6IY9sUQ2ZROMCPGIFxFmhgCBuYtG
	 jNqNOoAB0cr2yEFexBXIhgM9ZBkMgu2LQXUIVsl/rBlUlK0s/2QXTQJ0wwIlgHGxsF
	 XQ9JLaZ7WRr5YJKFVoIspAaIGLXh9bhhFhIOe+hmbgrw2DyF8Qjnl91uK9AhEtHzwc
	 YKL9ABLgMEKdDTqe6QeTZnBPX/x5MkBLd/Yfj2WfThqAuyUsyAkEWY02ojBvqL/iWD
	 qwdc04o+J6OsllAn7PlpcqQ39qWzGDs7DBQL6uzWd4Mebg8DzaiVljg2HL3VRQD4Ie
	 hVkgTREuyB4hA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 09 Aug 2024 13:51:23 +0200
Subject: [PATCH mptcp-next v4 5/8] selftests: mptcp: join: validate MPJ SYN
 TX MIB counters
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-mptcp-join-tx-mib-v4-5-98b0b0e098c5@kernel.org>
References: <20240809-mptcp-join-tx-mib-v4-0-98b0b0e098c5@kernel.org>
In-Reply-To: <20240809-mptcp-join-tx-mib-v4-0-98b0b0e098c5@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=6067; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=oUbKAORZxUAlgllMUyhOdrEUI2zUNhTF+JHNRu7hDNU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmtgM/Z+cIuVa4d1QhtBR/1d3OxoJAp/Lp10XB/
 rPLxQSsLtyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrYDPwAKCRD2t4JPQmmg
 c5rIEADLtrixZx3PKeG1AF4bJuJIFxt+a61QTp9A+JGpZOjtzz6nuhvDwQ5zXHoaiI3Xx+yALh7
 fVdonDlkQlaDyhIUEpZe9EQx36+WIZI0BOgzY3Af+N8vSIRAIo8o5vcstZx+jDhzL+W1Cd7ftmD
 cl9u64/4cKbyZd1DovxII979GhiTmi+2g5FrI00d6yuSYEQ8BAkb4KeLKD6F/GWOhykDzKb7EOC
 Oz3r1GfpG8d0322ZdM7rxrpVUV1Vjfya1l1tZh+m7D1fEVN4Paga4QEJuP4mDbqyWrcN68ZK9Zo
 c7vbBISA/kIRIwt2FgfB24T1eQoOipiwoIQulES0naQwt/SyYr5u3ikMq95BTDxV+6k9h13MCVp
 mwXymOaINzqX/z/oKsMKUugn8TFztsRoSDLwY9M18oG+O6r51m6R61gwAAHlxK4MfC1LXgNoEbv
 KG65IRxMmRvKbWThZDlGnH+MDlzdATTPjRJzKmsI0fTvUcRFhacOoVPykJVcIUa0viHqU7pf9N/
 bjzovSMxEo79t8YUhQlDjd/PIs1+R/oWF7dmN5O3CN8E2YKBcohmm9yvTFyiYKqb82rDDp5QYa/
 oh0F7TLASv4C59MUay3F056GB8TA7x9nhVEw0TNb3xhxJ1q6S2Ivs9YFLES2ruJLdHsrewOraxN
 Bpwk9kddQAyFE7g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A few new MPJoinSynTx MIB counters have been added in a previous commit.
They are being validated here in mptcp_join.sh selftest, each time the
number of received MPJ are checked.

Most of the time, the number of sent SYN+MPJ is the same as the received
ones. But sometimes, there are more, because there are dropped, or there
are errors.

While at it, the "no MPC reuse with single endpoint" subtest has been
modified to force a bind() error.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
  - v3:
    - Force a bind error (Geliang)
    - Validate join tx with rx ones. (Geliang)
  - v4:
    - do not depend on chk_join_nr. (Geliang)
    - unset optional vars, just in case.
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 89 ++++++++++++++++++++++---
 1 file changed, 78 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 9739c57f5ba6..320cee75ac41 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -67,6 +67,10 @@ unset join_fail_nr
 unset join_rst_nr
 unset join_infi_nr
 unset join_corrupted_pkts
+unset join_syn_tx
+unset join_create_err
+unset join_bind_err
+unset join_connect_err
 
 # generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) == 0x30) ||
 #				  (ip6 && (ip6[74] & 0xf0) == 0x30)'"
@@ -1331,6 +1335,54 @@ chk_infi_nr()
 	fi
 }
 
+chk_join_tx_nr()
+{
+	local syn_tx=${join_syn_tx:-0}
+	local create=${join_create_err:-0}
+	local bind=${join_bind_err:-0}
+	local connect=${join_connect_err:-0}
+	local rc=${KSFT_PASS}
+	local count
+
+	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtMPJoinSynTx")
+	if [ -z "$count" ]; then
+		rc=${KSFT_SKIP}
+	elif [ "$count" != "$syn_tx" ]; then
+		rc=${KSFT_FAIL}
+		print_check "syn tx"
+		fail_test "got $count JOIN[s] syn tx expected $syn_tx"
+	fi
+
+	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtMPJoinSynTxCreatSkErr")
+	if [ -z "$count" ]; then
+		rc=${KSFT_SKIP}
+	elif [ "$count" != "$create" ]; then
+		rc=${KSFT_FAIL}
+		print_check "syn tx create socket error"
+		fail_test "got $count JOIN[s] syn tx create socket error expected $create"
+	fi
+
+	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtMPJoinSynTxBindErr")
+	if [ -z "$count" ]; then
+		rc=${KSFT_SKIP}
+	elif [ "$count" != "$bind" ]; then
+		rc=${KSFT_FAIL}
+		print_check "syn tx bind error"
+		fail_test "got $count JOIN[s] syn tx bind error expected $bind"
+	fi
+
+	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtMPJoinSynTxConnectErr")
+	if [ -z "$count" ]; then
+		rc=${KSFT_SKIP}
+	elif [ "$count" != "$connect" ]; then
+		rc=${KSFT_FAIL}
+		print_check "syn tx connect error"
+		fail_test "got $count JOIN[s] syn tx connect error expected $connect"
+	fi
+
+	print_results "join Tx" ${rc}
+}
+
 chk_join_nr()
 {
 	local syn_nr=$1
@@ -1385,6 +1437,9 @@ chk_join_nr()
 
 	print_results "join Rx" ${rc}
 
+	join_syn_tx="${join_syn_tx:-${syn_nr}}" \
+		chk_join_tx_nr
+
 	if $validate_checksum; then
 		chk_csum_nr $csum_ns1 $csum_ns2
 		chk_fail_nr $fail_nr $fail_nr
@@ -1925,9 +1980,11 @@ subflows_error_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
+		pm_nl_add_endpoint $ns2 10.0.12.2 flags subflow
 		speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 0 0 0
+		join_bind_err=1 \
+			chk_join_nr 0 0 0
 	fi
 
 	# multiple subflows, with subflow creation error
@@ -1939,7 +1996,8 @@ subflows_error_tests()
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 		speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 1 1 1
+		join_syn_tx=2 \
+			chk_join_nr 1 1 1
 	fi
 
 	# multiple subflows, with subflow timeout on MPJ
@@ -1951,7 +2009,8 @@ subflows_error_tests()
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 		speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 1 1 1
+		join_syn_tx=2 \
+			chk_join_nr 1 1 1
 	fi
 
 	# multiple subflows, check that the endpoint corresponding to
@@ -1972,7 +2031,8 @@ subflows_error_tests()
 
 		# additional subflow could be created only if the PM select
 		# the later endpoint, skipping the already used one
-		chk_join_nr 1 1 1
+		join_syn_tx=2 \
+			chk_join_nr 1 1 1
 	fi
 }
 
@@ -2058,7 +2118,8 @@ signal_address_tests()
 		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
 		pm_nl_set_limits $ns2 3 3
 		run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 1 1 1
+		join_syn_tx=3 \
+			chk_join_nr 1 1 1
 		chk_add_nr 3 3
 	fi
 
@@ -2226,7 +2287,8 @@ add_addr_timeout_tests()
 		pm_nl_set_limits $ns2 2 2
 		speed=10 \
 			run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 1 1 1
+		join_syn_tx=2 \
+			chk_join_nr 1 1 1
 		chk_add_nr 8 0
 	fi
 }
@@ -2326,7 +2388,8 @@ remove_tests()
 		pm_nl_set_limits $ns2 2 2
 		addr_nr_ns1=-3 speed=10 \
 			run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 1 1 1
+		join_syn_tx=2 join_connect_err=1 \
+			chk_join_nr 1 1 1
 		chk_add_nr 3 3
 		chk_rm_nr 3 1 invert
 		chk_rst_nr 0 0
@@ -2391,7 +2454,8 @@ remove_tests()
 		pm_nl_set_limits $ns2 3 3
 		addr_nr_ns1=-8 speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 1 1 1
+		join_syn_tx=3 \
+			chk_join_nr 1 1 1
 		chk_add_nr 3 3
 		chk_rm_nr 3 1 invert
 		chk_rst_nr 0 0
@@ -3619,7 +3683,8 @@ endpoint_tests()
 
 		mptcp_lib_kill_wait $tests_pid
 
-		chk_join_nr 3 3 3
+		join_syn_tx=4 \
+			chk_join_nr 3 3 3
 		chk_rm_nr 1 1
 	fi
 
@@ -3654,7 +3719,8 @@ endpoint_tests()
 		chk_mptcp_info subflows 2 subflows 2
 		mptcp_lib_kill_wait $tests_pid
 
-		chk_join_nr 3 3 3
+		join_connect_err=1 \
+			chk_join_nr 3 3 3
 		chk_add_nr 4 4
 		chk_rm_nr 2 1 invert
 	fi
@@ -3685,7 +3751,8 @@ endpoint_tests()
 		wait_mpj $ns2
 		mptcp_lib_kill_wait $tests_pid
 
-		chk_join_nr 2 2 2
+		join_syn_tx=3 join_connect_err=1 \
+			chk_join_nr 2 2 2
 		chk_add_nr 2 2
 		chk_rm_nr 1 0 invert
 	fi

-- 
2.45.2

