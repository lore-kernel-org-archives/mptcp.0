Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640BC62158
	for <mptcp@lists.linux.dev>; Thu, 29 Feb 2024 09:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709200291; cv=none; b=FnwMiZQkCk/GK+Oo7jBShQXpT5K6fJgAu5qyxQUBM/bFEedi8uaGtatcON8ves8IZzuduEkQK8vGJbfX4yhFYbXnmMlM5HaqEVF4cO/yEM4tCRBrI09wus9Oiqzdb27riQ42vLO/A8UVZAxVue9VMza1hXia0CySganJIKGnrSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709200291; c=relaxed/simple;
	bh=SMAkT3mC2OPIrzgbw+ZxiXQXPSAhsFqPQeWBKPhfYMg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qhrGyjbKQrDQZcu1790GWve6HZAwGu5WjgwgElOve58SsRFF7ruZCY489L1fnXNhQGVhAQw766OqBwSo6w9ZJYOF0JpuLHYIHDAZIbq68OHWL3M8NP+0z+esOuIusUddAPNilqeQqfkVmMZiCY35BkjgOWoxz1Qc8iR/Qt5rqio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8UhmG80; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8UhmG80"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A268DC433C7;
	Thu, 29 Feb 2024 09:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709200290;
	bh=SMAkT3mC2OPIrzgbw+ZxiXQXPSAhsFqPQeWBKPhfYMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V8UhmG80jPPU3NV20CEH6JkFUveM5XGC9bMqW+MltCXriNn91YUCr5rMeCqVsHw9N
	 nepw4SxM6O3iJsFiWmXe72gKwpTmEJTpesLZ+cHX/RXmC/RI07MGWDp8u0sZODYnem
	 YZb/zt/FAt7NcYN+9UpHvWkubshlZYuvorj8zYsxjdZKvFIhIRM4qeOlbhtiMVvlxB
	 5KWdRSiVmI1e6Q+9PZG3JZ80U1A3Dte4EWzmVNOCR3hxU/AHb0Iig9b798EEK0CUEq
	 KHvM4Sa0gX7i+n7RSElB9ABkiFkraCznS38xhV+rhMlrn3FvA0+G/OQ6L1W9WDmBlz
	 j5oF/zvVo9xcw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 6/8] selftests: mptcp: add test counter helpers
Date: Thu, 29 Feb 2024 17:51:09 +0800
Message-Id: <9a31a17605edb4546467a172d8619eff3f15a002.1709200070.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1709200070.git.tanggeliang@kylinos.cn>
References: <cover.1709200070.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds two vars in mptcp_lib.sh, MPTCP_LIB_TEST_COUNTER for
the test counter and MPTCP_LIB_TEST_FORMAT for the test print format.
Also add two helpers, mptcp_lib_inc_test_counter(), increase the test
counter, and mptcp_lib_pr_title_counter(), print the test title with
counter. They are used in mptcp_join.sh first.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 16 ++++++++--------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh  | 17 +++++++++++++++++
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 1df2d24979a0..7acc6064eb17 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -48,7 +48,6 @@ declare -A all_tests
 declare -a only_tests_ids
 declare -a only_tests_names
 declare -A failed_tests
-TEST_COUNT=0
 TEST_NAME=""
 nr_blank=6
 
@@ -172,7 +171,8 @@ cleanup()
 
 print_title()
 {
-	printf "%03u %s\n" "${TEST_COUNT}" "${TEST_NAME}"
+	MPTCP_LIB_TEST_FORMAT="%03u %s\n"
+	mptcp_lib_pr_title_counter "${TEST_NAME}"
 }
 
 print_check()
@@ -233,7 +233,7 @@ skip_test()
 
 	local i
 	for i in "${only_tests_ids[@]}"; do
-		if [ "${TEST_COUNT}" -eq "${i}" ]; then
+		if [ "${MPTCP_LIB_TEST_COUNTER}" -eq "${i}" ]; then
 			return 1
 		fi
 	done
@@ -268,7 +268,7 @@ reset()
 
 	TEST_NAME="${1}"
 
-	TEST_COUNT=$((TEST_COUNT+1))
+	mptcp_lib_inc_test_counter
 
 	if skip_test; then
 		last_test_ignored=1
@@ -462,7 +462,7 @@ fail_test()
 
 	# just in case a test is marked twice as failed
 	if [ ${last_test_failed} -eq 0 ]; then
-		failed_tests[${TEST_COUNT}]="${TEST_NAME}"
+		failed_tests[${MPTCP_LIB_TEST_COUNTER}]="${TEST_NAME}"
 		dump_stats
 		last_test_failed=1
 	fi
@@ -973,7 +973,7 @@ do_transfer()
 	local srv_proto="$4"
 	local connect_addr="$5"
 
-	local port=$((10000 + TEST_COUNT - 1))
+	local port=$((10000 + MPTCP_LIB_TEST_COUNTER - 1))
 	local cappid
 	local FAILING_LINKS=${FAILING_LINKS:-""}
 	local fastclose=${fastclose:-""}
@@ -991,9 +991,9 @@ do_transfer()
 			capuser="-Z $SUDO_USER"
 		fi
 
-		capfile=$(printf "mp_join-%02u-%s.pcap" "$TEST_COUNT" "${listener_ns}")
+		capfile=$(printf "mp_join-%02u-%s.pcap" "$MPTCP_LIB_TEST_COUNTER" "${listener_ns}")
 
-		echo "Capturing traffic for test $TEST_COUNT into $capfile"
+		echo "Capturing traffic for test $MPTCP_LIB_TEST_COUNTER into $capfile"
 		ip netns exec ${listener_ns} tcpdump -i any -s 65535 -B 32768 $capuser -w $capfile > "$capout" 2>&1 &
 		cappid=$!
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 763a2989ca6d..cbf0dd2cc4cb 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -411,3 +411,20 @@ mptcp_lib_events() {
 	ip netns exec "${ns}" ./pm_nl_ctl events >> "${evts}" 2>&1 &
 	pid=$!
 }
+
+MPTCP_LIB_TEST_COUNTER=0
+MPTCP_LIB_TEST_FORMAT=""
+
+mptcp_lib_inc_test_counter() {
+	: "${MPTCP_LIB_TEST_COUNTER:?}"
+
+	MPTCP_LIB_TEST_COUNTER=$((MPTCP_LIB_TEST_COUNTER+1))
+}
+
+#shellcheck disable=SC2059
+mptcp_lib_pr_title_counter() {
+	: "${MPTCP_LIB_TEST_COUNTER:?}"
+	: "${MPTCP_LIB_TEST_FORMAT:="%02u %-50s"}"
+
+	printf "${MPTCP_LIB_TEST_FORMAT}" "${MPTCP_LIB_TEST_COUNTER}" "${*}"
+}
-- 
2.40.1

