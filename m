Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903A9692FC
	for <mptcp@lists.linux.dev>; Fri,  1 Mar 2024 06:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709275627; cv=none; b=gXQhU1CoqFyw77CAVMHPecda1wz+WvR/sRBADGn9v3YPUURRGJqYfJZDTD4UeJM6yl/bO6eiPZlyvkfpcZO3UIjG6ay8c7FEdRM/nHF/tu739BtA+aaLT9eYzd08za8Qw8bUa93T+iLEKllb89JxkxQHJ3vmnGgr9pjozylxdZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709275627; c=relaxed/simple;
	bh=DPfEeTX/i0l4VFamNh8v0cZHG2J6wZOZ1iR3W4Xzuik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z1EhL8wmBDVSW0H8YEEveba1QOTj1lNDTMlTrMX53SsMM4Ic4ZsZKlgjSC8hyubq6zbh4bcZDoetiyPMUkhf7tFybya3tkzTl769iMpetaTcqWFCcHyvw764DIr+BxS1rtDZb6whs8AEr9l7B+fYUqLYEXE7Y/ZkJlCRLTxlDgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jO73M3GB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jO73M3GB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5850C43399;
	Fri,  1 Mar 2024 06:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709275627;
	bh=DPfEeTX/i0l4VFamNh8v0cZHG2J6wZOZ1iR3W4Xzuik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jO73M3GBmT8kMyc3hKXqQXBkhWX6Xd2ElmdV/U7eo5DzJr7gdrJsMpMUc/FPri+Pb
	 HLau94l7PTSJ5YYJXub1nPaj/y4KzTRKhFtOXiRZt7XFia+MLuS54rirGi83seSqPn
	 K+V00lvOL5L7s5+bPhxtwt4yL8wTIyuo+sM8Pfmmdjn4dVTTwzZJx3qzooho5bMJei
	 rfCTOQK6RxH6QP78n9XUlEtKhrZM6X0bv+BCT0PlG6YMrtJQd0tSI78ywZbvxoq0Ky
	 JRFnRa4HFkdJbTlUvGk7tA2FUXqMgMmKf3DLIuKGA740BfWfNEb/puC+4E/K+Iqg74
	 19dH6V9a1AGQw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 4/6] selftests: mptcp: add test counter helpers
Date: Fri,  1 Mar 2024 14:46:34 +0800
Message-Id: <c5d881cf8b95e142e33a2555e35f2eb403ab9d3e.1709275290.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1709275290.git.tanggeliang@kylinos.cn>
References: <cover.1709275290.git.tanggeliang@kylinos.cn>
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

Each MPTCP selftest is having subtests, and it helps to give them a
number to quickly identify them. This can be managed by mptcp_lib.sh,
reusing what has been done here. The following commit will use these
new helpers in the other tests.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 22 +++++++------------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 10 +++++++++
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 1df2d24979a0..2f34e2b9a1c4 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -48,7 +48,7 @@ declare -A all_tests
 declare -a only_tests_ids
 declare -a only_tests_names
 declare -A failed_tests
-TEST_COUNT=0
+MPTCP_LIB_TEST_FORMAT="%03u %s\n"
 TEST_NAME=""
 nr_blank=6
 
@@ -170,11 +170,6 @@ cleanup()
 	cleanup_partial
 }
 
-print_title()
-{
-	printf "%03u %s\n" "${TEST_COUNT}" "${TEST_NAME}"
-}
-
 print_check()
 {
 	printf "%-${nr_blank}s%-36s" " " "${*}"
@@ -233,7 +228,7 @@ skip_test()
 
 	local i
 	for i in "${only_tests_ids[@]}"; do
-		if [ "${TEST_COUNT}" -eq "${i}" ]; then
+		if [ "$((MPTCP_LIB_TEST_COUNTER+1))" -eq "${i}" ]; then
 			return 1
 		fi
 	done
@@ -268,14 +263,13 @@ reset()
 
 	TEST_NAME="${1}"
 
-	TEST_COUNT=$((TEST_COUNT+1))
-
 	if skip_test; then
+		MPTCP_LIB_TEST_COUNTER=$((MPTCP_LIB_TEST_COUNTER+1))
 		last_test_ignored=1
 		return 1
 	fi
 
-	print_title
+	mptcp_lib_print_title "${TEST_NAME}"
 
 	if [ "${init}" != "1" ]; then
 		init
@@ -462,7 +456,7 @@ fail_test()
 
 	# just in case a test is marked twice as failed
 	if [ ${last_test_failed} -eq 0 ]; then
-		failed_tests[${TEST_COUNT}]="${TEST_NAME}"
+		failed_tests[${MPTCP_LIB_TEST_COUNTER}]="${TEST_NAME}"
 		dump_stats
 		last_test_failed=1
 	fi
@@ -973,7 +967,7 @@ do_transfer()
 	local srv_proto="$4"
 	local connect_addr="$5"
 
-	local port=$((10000 + TEST_COUNT - 1))
+	local port=$((10000 + MPTCP_LIB_TEST_COUNTER - 1))
 	local cappid
 	local FAILING_LINKS=${FAILING_LINKS:-""}
 	local fastclose=${fastclose:-""}
@@ -991,9 +985,9 @@ do_transfer()
 			capuser="-Z $SUDO_USER"
 		fi
 
-		capfile=$(printf "mp_join-%02u-%s.pcap" "$TEST_COUNT" "${listener_ns}")
+		capfile=$(printf "mp_join-%02u-%s.pcap" "$MPTCP_LIB_TEST_COUNTER" "${listener_ns}")
 
-		echo "Capturing traffic for test $TEST_COUNT into $capfile"
+		echo "Capturing traffic for test $MPTCP_LIB_TEST_COUNTER into $capfile"
 		ip netns exec ${listener_ns} tcpdump -i any -s 65535 -B 32768 $capuser -w $capfile > "$capout" 2>&1 &
 		cappid=$!
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 763a2989ca6d..459e90258f37 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -10,6 +10,8 @@ readonly KSFT_TEST="${MPTCP_LIB_KSFT_TEST:-$(basename "${0}" .sh)}"
 
 MPTCP_LIB_SUBTESTS=()
 MPTCP_LIB_SUBTESTS_DUPLICATED=0
+MPTCP_LIB_TEST_COUNTER=0
+MPTCP_LIB_TEST_FORMAT="%02u %-50s"
 
 # only if supported (or forced) and not disabled, see no-color.org
 if { [ -t 1 ] || [ "${SELFTESTS_MPTCP_LIB_COLOR_FORCE:-}" = "1" ]; } &&
@@ -411,3 +413,11 @@ mptcp_lib_events() {
 	ip netns exec "${ns}" ./pm_nl_ctl events >> "${evts}" 2>&1 &
 	pid=$!
 }
+
+mptcp_lib_print_title() {
+	: "${MPTCP_LIB_TEST_COUNTER:?}"
+	: "${MPTCP_LIB_TEST_FORMAT:?}"
+
+	# shellcheck disable=SC2059 # the format is in a variable
+	printf "${MPTCP_LIB_TEST_FORMAT}" "$((++MPTCP_LIB_TEST_COUNTER))" "${*}"
+}
-- 
2.40.1

