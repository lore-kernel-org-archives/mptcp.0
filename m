Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3BAEDC
	for <mptcp@lists.linux.dev>; Sun,  3 Mar 2024 09:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709459600; cv=none; b=k25Syl4Y+Waao51vqvWhM+2PQLFRBkaX9Fc96rlf8erhlOgSrJ1stCvZ1iZn4FOurtoqlkDz6K4dMgVFdnTgJ8Pqmf7rvnbvnDZXt/hpdVSJIlRxCaGoxMO2ZBmG3DegLSVC3nWoYo5KIJksfYRh8BEVP/R1SAC8y9ZLma11K/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709459600; c=relaxed/simple;
	bh=f2Bh1a7OwY/EsBlg+YApH/UZfoe7DlZ4ttkSgvZl1Po=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HQE04WJ/5yTAQVYTmbRzAJ2hA6XJ1zin8Z2KOMxsuzMfWS/PbWITng7BkMBMrcm7veB+KOSysZ1xX8IXKmrNkRL0flcO/WPtkeojKpkkaUet4Ne9Idc5IzSgvDjxAPVqQQSIe7xq3kh1WD46KoZ0iYx7zYTvX7DKwm2Jsny4zmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBMd4EzK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBMd4EzK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94254C433F1;
	Sun,  3 Mar 2024 09:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709459600;
	bh=f2Bh1a7OwY/EsBlg+YApH/UZfoe7DlZ4ttkSgvZl1Po=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OBMd4EzKnOp1nKn2gQHwCodFKo7JXXB7QEOu4hbHKqPEtE1U58HahSbz5HJtoxqdG
	 CKLJ+fYzxdqiYHJPddGquNx3diTUqcpx0gtUsi12mrOCTUUxkq64ArL/N+wJ8eHEy/
	 /DbwGtd+qMlDhVLUumgbmOcSksC+hWgI7DSLD55Aqh/D11ZhDR57DRrI/u0fbZ6j4+
	 sfoZd/bg+9q2jpKZFd/xbyEiSNsmNGi1shPcFy4IBV8bPjU5n+1VQOkCBS0WcBedKT
	 I6HqtKZyDy5vozhv68h2Ol4zZi9TUcnmWb4jLb10JKgiPFJhT2okVfR0DHXLX711iI
	 TyZnKSMPOqyDA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 5/8] selftests: mptcp: export TEST_COUNTER variable
Date: Sun,  3 Mar 2024 17:52:25 +0800
Message-Id: <24df8154cf66c56591c896cdc2c16bb69b2fa10c.1709459360.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1709459360.git.tanggeliang@kylinos.cn>
References: <cover.1709459360.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Variable TEST_COUNT are used in mptcp_connect.sh and mptcp_join.sh as
test counters, which are initialized to 0, while variable test_cnt are used
in diag.sh and simult_flows.sh, which are initialized to 1. To maintain
consistency, this patch renames them all as MPTCP_LIB_TEST_COUNTER,
initializes it to 1, and exports it into mptcp_lib.sh.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/diag.sh         |  5 ++---
 .../testing/selftests/net/mptcp/mptcp_connect.sh  |  3 +--
 tools/testing/selftests/net/mptcp/mptcp_join.sh   | 15 +++++++--------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh    |  1 +
 tools/testing/selftests/net/mptcp/simult_flows.sh |  5 ++---
 5 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index afe862895946..b63510ce2327 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -9,7 +9,6 @@
 . "$(dirname "${0}")/mptcp_lib.sh"
 
 ns=""
-test_cnt=1
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 ret=0
@@ -69,7 +68,7 @@ __chk_nr()
 		echo "[  ok  ]"
 		mptcp_lib_result_pass "${msg}"
 	fi
-	test_cnt=$((test_cnt+1))
+	MPTCP_LIB_TEST_COUNTER=$((MPTCP_LIB_TEST_COUNTER+1))
 }
 
 __chk_msk_nr()
@@ -127,7 +126,7 @@ wait_msk_nr()
 		echo "[  ok  ]"
 		mptcp_lib_result_pass "${msg}"
 	fi
-	test_cnt=$((test_cnt+1))
+	MPTCP_LIB_TEST_COUNTER=$((MPTCP_LIB_TEST_COUNTER+1))
 }
 
 chk_msk_fallback_nr()
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index be598e1e25f5..07332f13afd7 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -131,7 +131,6 @@ ns2=""
 ns3=""
 ns4=""
 
-TEST_COUNT=0
 TEST_GROUP=""
 
 # This function is used in the cleanup trap
@@ -322,7 +321,7 @@ do_transfer()
 
 	local port
 	port=$((10000+PORT++))
-	TEST_COUNT=$((TEST_COUNT+1))
+	MPTCP_LIB_TEST_COUNTER=$((MPTCP_LIB_TEST_COUNTER+1))
 
 	if [ "$rcvbuf" -gt 0 ]; then
 		extra_args="$extra_args -R $rcvbuf"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 1df2d24979a0..4ef0d5ae9dae 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -48,7 +48,6 @@ declare -A all_tests
 declare -a only_tests_ids
 declare -a only_tests_names
 declare -A failed_tests
-TEST_COUNT=0
 TEST_NAME=""
 nr_blank=6
 
@@ -172,7 +171,7 @@ cleanup()
 
 print_title()
 {
-	printf "%03u %s\n" "${TEST_COUNT}" "${TEST_NAME}"
+	printf "%03u %s\n" "${MPTCP_LIB_TEST_COUNTER}" "${TEST_NAME}"
 }
 
 print_check()
@@ -233,7 +232,7 @@ skip_test()
 
 	local i
 	for i in "${only_tests_ids[@]}"; do
-		if [ "${TEST_COUNT}" -eq "${i}" ]; then
+		if [ "${MPTCP_LIB_TEST_COUNTER}" -eq "${i}" ]; then
 			return 1
 		fi
 	done
@@ -268,7 +267,7 @@ reset()
 
 	TEST_NAME="${1}"
 
-	TEST_COUNT=$((TEST_COUNT+1))
+	MPTCP_LIB_TEST_COUNTER=$((MPTCP_LIB_TEST_COUNTER+1))
 
 	if skip_test; then
 		last_test_ignored=1
@@ -462,7 +461,7 @@ fail_test()
 
 	# just in case a test is marked twice as failed
 	if [ ${last_test_failed} -eq 0 ]; then
-		failed_tests[${TEST_COUNT}]="${TEST_NAME}"
+		failed_tests[${MPTCP_LIB_TEST_COUNTER}]="${TEST_NAME}"
 		dump_stats
 		last_test_failed=1
 	fi
@@ -973,7 +972,7 @@ do_transfer()
 	local srv_proto="$4"
 	local connect_addr="$5"
 
-	local port=$((10000 + TEST_COUNT - 1))
+	local port=$((10000 + MPTCP_LIB_TEST_COUNTER - 1))
 	local cappid
 	local FAILING_LINKS=${FAILING_LINKS:-""}
 	local fastclose=${fastclose:-""}
@@ -991,9 +990,9 @@ do_transfer()
 			capuser="-Z $SUDO_USER"
 		fi
 
-		capfile=$(printf "mp_join-%02u-%s.pcap" "$TEST_COUNT" "${listener_ns}")
+		capfile=$(printf "mp_join-%02u-%s.pcap" "$MPTCP_LIB_TEST_COUNTER" "${listener_ns}")
 
-		echo "Capturing traffic for test $TEST_COUNT into $capfile"
+		echo "Capturing traffic for test $MPTCP_LIB_TEST_COUNTER into $capfile"
 		ip netns exec ${listener_ns} tcpdump -i any -s 65535 -B 32768 $capuser -w $capfile > "$capout" 2>&1 &
 		cappid=$!
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 763a2989ca6d..2750756d25c9 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -10,6 +10,7 @@ readonly KSFT_TEST="${MPTCP_LIB_KSFT_TEST:-$(basename "${0}" .sh)}"
 
 MPTCP_LIB_SUBTESTS=()
 MPTCP_LIB_SUBTESTS_DUPLICATED=0
+MPTCP_LIB_TEST_COUNTER=0
 
 # only if supported (or forced) and not disabled, see no-color.org
 if { [ -t 1 ] || [ "${SELFTESTS_MPTCP_LIB_COLOR_FORCE:-}" = "1" ]; } &&
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 467feb17e07b..20bf1ea43362 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -14,7 +14,6 @@ ns3=""
 capture=false
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
-test_cnt=1
 ret=0
 bail=0
 slack=50
@@ -126,8 +125,8 @@ do_transfer()
 	local sin=$2
 	local max_time=$3
 	local port
-	port=$((10000+test_cnt))
-	test_cnt=$((test_cnt+1))
+	port=$((10000+MPTCP_LIB_TEST_COUNTER))
+	MPTCP_LIB_TEST_COUNTER=$((MPTCP_LIB_TEST_COUNTER+1))
 
 	:> "$cout"
 	:> "$sout"
-- 
2.40.1

