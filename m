Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA33213B2AC
	for <mptcp@lists.linux.dev>; Tue,  6 Aug 2024 11:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722943151; cv=none; b=EyaV/hCQcikhKJFwKShJomyjLg81mLxic8aF+j7sBZMyg/49kbIaFRRhVBGNLdEtLy8Hnb5ka7og5qCvK2kyx0KbCyxPTOSUi8ZHvJiZcjLCs5M23XjZSweeGV11yv/6r/Lxh9L7bSx9361B3vvbcO7XugSIc/NSKYFKTGu0gqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722943151; c=relaxed/simple;
	bh=VPLgy2ezHqxUsWZzlp6O9floU/WVlaFLfSiTDoQRh80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cTihyFQDG+HxnQwmWRXmHQRAzYUSnDvhcZRCajl7pzQ4AHmHzerYBYodKZBFJyNVdLzSUzJsYFvBhK5csp7r4S1+Lbkea5Gizo96hwSsqr0m7N7JwR+n3P6zuhVwIANSd59ZYW+vDk0r/zacnfYiQ3SkB01rqlYjvPrAf67Nujw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sd9ymLKe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sd9ymLKe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF7EC4AF09;
	Tue,  6 Aug 2024 11:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722943150;
	bh=VPLgy2ezHqxUsWZzlp6O9floU/WVlaFLfSiTDoQRh80=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sd9ymLKePqKZLux+aEkkVky/eEgnnhHDBR1sjUl6cAdPstux1jCjSyF8D+iQ6PTsH
	 ctmG/oU5Vg9WIzWrbwWEc+/NEujvq8HZGlFEer+YUvfP8pqWslOju5//c3jySnQ+my
	 jckYQbndNHm9NhCwyneYVVvMh6nOh7BfaJ2jHNUMEmQwrHoTvAZKwY/wSS3Ezjl0bd
	 mEou+/86HGnfQ1LtUDE5nAGKCFGuOEG2Fgg+4u3TthFhC6fXPesH2OkAyZySRAglCw
	 FJSvb8cl2zZEE4iaHntgjhV/4qXaRap+8bkg0d2MyJQe9P+MGvp7/91ODaxqMrzY9/
	 1NdbogF8gw1yQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 06 Aug 2024 13:18:53 +0200
Subject: [PATCH mptcp-next v3 5/8] selftests: mptcp: join: validate MPJ SYN
 TX MIB counters
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-mptcp-join-tx-mib-v3-5-c3b54d2099e9@kernel.org>
References: <20240806-mptcp-join-tx-mib-v3-0-c3b54d2099e9@kernel.org>
In-Reply-To: <20240806-mptcp-join-tx-mib-v3-0-c3b54d2099e9@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5613; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=VPLgy2ezHqxUsWZzlp6O9floU/WVlaFLfSiTDoQRh80=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmsgaou+b/1fwgxJR7R15/4yVHciFiPernbQpwT
 +SCWkp0MpyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrIGqAAKCRD2t4JPQmmg
 cx8bD/wOF8P6fCS7kNOB6rzXScUIX5JClr5w7g0Spi2sLEobyd631/pFIc6nRa1EhE9jDsCjShZ
 a3Sp5uhyNaTOvyEUYSSTSYX3xLCD+ie9yAt436R1zm1PwMvBvRODMlSK6CjSDNk1iDoD3ZRXFcj
 s2iO4+LjhHzxFsTUUQsClqSp3huIna/XqrtEaTpGoM9Q5s18ro0+W2pNVhVb0Yn2XphMWq9EU5y
 sI2/NH/bhYHNQNoyouguwGQknX1bz9MGttcHR2w6C7Tx7XrEbmstYx02t0Q1kDizTjuveWS8O0m
 38v4wITlJj1B4E7ea4kQgKamOAjqBKu0Azg5oZXJmtGDdJQLv6xjdNATMX/Egc5noFSH8bgLm23
 Tdya2bv8CeHAoFMuskwVZNglpPFqCnN/MSXXME5gJXbzoMe7R6Mnh7i6ewgzzQYJA/NXmwRdY2W
 ELG+Ego24Tm1PiFOYCn1n1Ti1WxmTx0xiBxyMzJ11CkdI7bNnlAxI471ey6CakYa3J4ATlK8AE8
 ItbsuOlPNGqqe0yIt7rH0g7H3mbeXSw6JFsk40X3OS/SzIeocjT9SMBJBUe/tlZtYZAt3EOpWLX
 31VsXRNfJih9bwX6faL/t+6EKr+BO5CUPxXuKe3XiG6plFfBUurIWEFtRfK1FqDyRF5I8qxTEGJ
 2t2s/W3L7W2w15Q==
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
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 84 +++++++++++++++++++++----
 1 file changed, 73 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b10bcb1ac970..23ea8acb7a36 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1331,6 +1331,54 @@ chk_infi_nr()
 	fi
 }
 
+chk_join_tx_nr()
+{
+	local syn_tx=${join_syn_tx:-${syn_nr}}
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
@@ -1385,6 +1433,8 @@ chk_join_nr()
 
 	print_results "join Rx" ${rc}
 
+	chk_join_tx_nr
+
 	if $validate_checksum; then
 		chk_csum_nr $csum_ns1 $csum_ns2
 		chk_fail_nr $fail_nr $fail_nr
@@ -1925,9 +1975,11 @@ subflows_error_tests()
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
@@ -1939,7 +1991,8 @@ subflows_error_tests()
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 		speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 1 1 1
+		join_syn_tx=2 \
+			chk_join_nr 1 1 1
 	fi
 
 	# multiple subflows, with subflow timeout on MPJ
@@ -1951,7 +2004,8 @@ subflows_error_tests()
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 		speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 1 1 1
+		join_syn_tx=2 \
+			chk_join_nr 1 1 1
 	fi
 
 	# multiple subflows, check that the endpoint corresponding to
@@ -1972,7 +2026,8 @@ subflows_error_tests()
 
 		# additional subflow could be created only if the PM select
 		# the later endpoint, skipping the already used one
-		chk_join_nr 1 1 1
+		join_syn_tx=2 \
+			chk_join_nr 1 1 1
 	fi
 }
 
@@ -2058,7 +2113,8 @@ signal_address_tests()
 		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
 		pm_nl_set_limits $ns2 3 3
 		run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 1 1 1
+		join_syn_tx=3 \
+			chk_join_nr 1 1 1
 		chk_add_nr 3 3
 	fi
 
@@ -2226,7 +2282,8 @@ add_addr_timeout_tests()
 		pm_nl_set_limits $ns2 2 2
 		speed=10 \
 			run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 1 1 1
+		join_syn_tx=2 \
+			chk_join_nr 1 1 1
 		chk_add_nr 8 0
 	fi
 }
@@ -2326,7 +2383,8 @@ remove_tests()
 		pm_nl_set_limits $ns2 2 2
 		addr_nr_ns1=-3 speed=10 \
 			run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 1 1 1
+		join_syn_tx=2 join_connect_err=1 \
+			chk_join_nr 1 1 1
 		chk_add_nr 3 3
 		chk_rm_nr 3 1 invert
 		chk_rst_nr 0 0
@@ -2391,7 +2449,8 @@ remove_tests()
 		pm_nl_set_limits $ns2 3 3
 		addr_nr_ns1=-8 speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 1 1 1
+		join_syn_tx=3 \
+			chk_join_nr 1 1 1
 		chk_add_nr 3 3
 		chk_rm_nr 3 1 invert
 		chk_rst_nr 0 0
@@ -3619,7 +3678,8 @@ endpoint_tests()
 
 		mptcp_lib_kill_wait $tests_pid
 
-		chk_join_nr 3 3 3
+		join_syn_tx=4 \
+			chk_join_nr 3 3 3
 		chk_rm_nr 1 1
 	fi
 
@@ -3654,7 +3714,8 @@ endpoint_tests()
 		chk_mptcp_info subflows 2 subflows 2
 		mptcp_lib_kill_wait $tests_pid
 
-		chk_join_nr 3 3 3
+		join_connect_err=1 \
+			chk_join_nr 3 3 3
 		chk_add_nr 4 4
 		chk_rm_nr 2 1 invert
 	fi
@@ -3685,7 +3746,8 @@ endpoint_tests()
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

