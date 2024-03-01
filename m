Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BA02AEEE
	for <mptcp@lists.linux.dev>; Fri,  1 Mar 2024 06:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709273895; cv=none; b=DBDpC4fsW/dvC0IjhMZGYnzXXBGFbkrej+8UrzUtsblfyutQfPGguSJZ0dEYbx458lgEyz/A9bfNw/ZCaifOnnQcc/Rc8nErgEGs0nkZ52xalZ78HrUMlIKpYNzfWykt+RLk/SgZtpaAty714xPMWpwys1vxbLsfxYpgkXk57BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709273895; c=relaxed/simple;
	bh=H9QOIxnaRhQ/Wwc18XEB4b4cKb8OOlODawSaWwRhz10=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dzCz7BhfVSPs8RIZu+M3bUBJN8nGp8wTvMKWMZOyhVKkGQRtGjh6Sz5neOVix4tcZg5yJxIKx16WGMvzEgMuW+APlMiBAeGaam9vM59zpP9O+d/FWLPMaCD6uBdbyhJ5Feyu+FBSgANhgil7pfYh9YZzG7DQfQgt8thxTwX5HB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVkMJBkF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVkMJBkF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C5AC433F1;
	Fri,  1 Mar 2024 06:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709273894;
	bh=H9QOIxnaRhQ/Wwc18XEB4b4cKb8OOlODawSaWwRhz10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fVkMJBkFDPEj9Tu2OiOity7Plg6KQb5avN5KRE6QA8GiaiDYraeQ3IFxbYcJ1ZMm+
	 Qunlm+t4NrrgffP/bnotVel+U8AUYmyDoFIWQ/9JJj3CVVq78u1Wlx7vwPP1em2yyo
	 772kSmTcSX1QLJUYrmTFkWW9iZfPKHmcWKBvSv9NILZ3/dTV6VBP+fCC0WDnvjT3H5
	 mKyZwUPPb1HfKEIqxYK09eX912uWUQGT+T700MxTVZmfYXpTf/29WlTGMp7fExSAHJ
	 +xwugPbCEchdZ8G7Z8TR7gKtJBndUijYKwzRV8zkHKVu+SeQkY9vimRoVJpj9OVZmR
	 4WfeyjJVGgdzg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 4/6] selftests: mptcp: add test counter helpers
Date: Fri,  1 Mar 2024 14:18:03 +0800
Message-Id: <e9f3fbe82ab7e6bd1dcf2e05d7a4f6c856a6784b.1709273774.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1709273774.git.tanggeliang@kylinos.cn>
References: <cover.1709273774.git.tanggeliang@kylinos.cn>
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
index 1df2d24979a0..2a549b0c4950 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -48,9 +48,9 @@ declare -A all_tests
 declare -a only_tests_ids
 declare -a only_tests_names
 declare -A failed_tests
-TEST_COUNT=0
 TEST_NAME=""
 nr_blank=6
+MPTCP_LIB_TEST_FORMAT="%03u %s\n"
 
 # These var are used only in some tests, make sure they are not already set
 unset FAILING_LINKS
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

