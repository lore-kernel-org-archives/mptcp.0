Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E010A50
	for <mptcp@lists.linux.dev>; Wed,  6 Mar 2024 01:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709689274; cv=none; b=piH0fvoL9RmyrWJIgQb2CXuWmHZRRDfVwOrDp9ij1nLo8kCCifAjgY9o4clTA8eRoYLoNjjL83JdjmacXzGRssrn267TkFFqsVdMmXoLprcMfXgqdcFoMKBH1YLL+6Rhn54yQ5sGi37ZxtAJK5WbNDtqNbRvEujJMiXqQztThYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709689274; c=relaxed/simple;
	bh=wwEC2qJow6e44SejmRB9r6NGTj+5HCW+DyUIiWielU8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bnb5pfc3I1VXvefpHCykAa8MjWbgLbo1qDqOtXaeuRuB4mVe2OLZCd2afs5+Jk+1PL/9HyJ/wEiRw3/bW8Q8l75ZgwyS0yvzhXfVTwr7FwbvuvECdv3qX2vgE2jk8rfN1gVwOw96acDt05ATuspfZczWEZ9w+NAQcNuePDO/9JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJp23wNr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJp23wNr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15701C43394;
	Wed,  6 Mar 2024 01:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709689273;
	bh=wwEC2qJow6e44SejmRB9r6NGTj+5HCW+DyUIiWielU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eJp23wNr0ON6cDkc5xhQlca5Kc2uq9Let0mD+jW8e4BcznyC+RoYo0C2vLahHLwoj
	 RNA/2a6VzDvhutWVAJVZJh0PS+yMb5EX84feiatk/lDV+16ZeMvHtLvWd4qKUTIwDe
	 Bd8l5mB+R/b/zTnSqm0KKdqH4fNCHeCDQy/hpupS+AfbyUFHlL6g6UfsdWEj9DZWHM
	 F83Xt2VzvCVKH9Qstd1mvc/nFva0RgdG52BBzNeXsVDOijAXB/sV9yQ7G4KQ+dWOeQ
	 /44coMpbtQZo+hmNQ31px929s9igA2cUCsr8cT8vzA3Mu/x/zqAy6jSLY1tN0iE5/o
	 DrIKHdLydrMEA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v13 5/9] selftests: mptcp: export TEST_COUNTER variable
Date: Wed,  6 Mar 2024 09:40:55 +0800
Message-Id: <725cf9632aec5b8bd51230ec335d6e44dd1a038b.1709688778.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1709688778.git.tanggeliang@kylinos.cn>
References: <cover.1709688778.git.tanggeliang@kylinos.cn>
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
 tools/testing/selftests/net/mptcp/mptcp_lib.sh    |  2 ++
 tools/testing/selftests/net/mptcp/simult_flows.sh |  5 ++---
 5 files changed, 14 insertions(+), 16 deletions(-)

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
index 709233ffa305..da943aa0cea1 100755
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
 	port=$((port_base++))
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
index 5d071b6eb780..63abf4431993 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -10,6 +10,8 @@ readonly KSFT_TEST="${MPTCP_LIB_KSFT_TEST:-$(basename "${0}" .sh)}"
 
 MPTCP_LIB_SUBTESTS=()
 MPTCP_LIB_SUBTESTS_DUPLICATED=0
+# shellcheck disable=SC2034 # unused at this moment
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

