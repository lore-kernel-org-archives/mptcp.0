Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CD1EDC
	for <mptcp@lists.linux.dev>; Sun,  3 Mar 2024 09:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709459602; cv=none; b=FVxvsLdTc9kbNqo8vSp6sSlykACVNQejKpWPx0Bw5rcQ1NiS0UdE/dX1J51JW0QeEuRL1zszFVsg5f5She/dhh9CCMeS+1X2KyxHOkGs16/2cf1kwLoonQgNoTBunp+KK/KpNW44iS4+RDk3H9S3OgWIDngDRxGPq8AHH6fbEgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709459602; c=relaxed/simple;
	bh=E5UV1tvxlmrvPf5D3nuVpcmOLrzM5C1dxxZ3cARqctw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HS+5q41CtQ/rb+6Uewng47in5PjpVnc7zEDbf19J5pO/HDQmov/Jl32PNUN9qUrJkv4Bzs/5Ky9S+EfyMaUeiS4mR4p3Ys4zxV/GvEVD9P2s4CeSGDVmekF0UVqU+leh7ohvmI70UeE0oT1s3vJ5rsY0ORmGfXxRDmbWV8dg1CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLbbkQir; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLbbkQir"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2CF5C433C7;
	Sun,  3 Mar 2024 09:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709459601;
	bh=E5UV1tvxlmrvPf5D3nuVpcmOLrzM5C1dxxZ3cARqctw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nLbbkQiraxmDxqMmnC1AzQe33LXFgZE2i+glQaVixVUiK2JG/iSdMNwTokI+SH7iA
	 zwlwfwcOU8B+uyfeGsBsxlF/f5yCV8Eu0aJ6s7vtWMfAtDPwYIf/G/nCFOnwlO0oUR
	 Qwq1sPZhMVhyucE/7ZzDbHy59zyM6AYqMt5jJe+yA0hKRyL0p5ilnAHpdwwlgMo2RZ
	 dgJ8XtEgRtOQ1W+HB7AgJqlzWvgsFog3RlEdF+gcmsZz47V/Y4J57OlkFOFUOc+myb
	 1Z1YIrQXekKfGoG0E2PCImFYr8Y97AFoRGNJb4R41nHMZfsVmlBkATpmE6U6y18E/I
	 FV58ksMiIm9XA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 6/8] selftests: mptcp: print counters in print_title
Date: Sun,  3 Mar 2024 17:52:26 +0800
Message-Id: <12011243e247a9720fe2a337eca4bab0109337d1.1709459360.git.tanggeliang@kylinos.cn>
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

This patch adds a new variable MPTCP_LIB_TEST_FORMAT as the test title
printing format. Also add a helper mptcp_lib_print_title() to use this
format to print the test title with test counters. They are used in
mptcp_join.sh first.

Each MPTCP selftest is having subtests, and it helps to give them a
number to quickly identify them. This can be managed by mptcp_lib.sh,
reusing what has been done here. The following commit will use these
new helpers in the other tests.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 13 ++++---------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh  |  9 +++++++++
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 4ef0d5ae9dae..2f34e2b9a1c4 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -48,6 +48,7 @@ declare -A all_tests
 declare -a only_tests_ids
 declare -a only_tests_names
 declare -A failed_tests
+MPTCP_LIB_TEST_FORMAT="%03u %s\n"
 TEST_NAME=""
 nr_blank=6
 
@@ -169,11 +170,6 @@ cleanup()
 	cleanup_partial
 }
 
-print_title()
-{
-	printf "%03u %s\n" "${MPTCP_LIB_TEST_COUNTER}" "${TEST_NAME}"
-}
-
 print_check()
 {
 	printf "%-${nr_blank}s%-36s" " " "${*}"
@@ -232,7 +228,7 @@ skip_test()
 
 	local i
 	for i in "${only_tests_ids[@]}"; do
-		if [ "${MPTCP_LIB_TEST_COUNTER}" -eq "${i}" ]; then
+		if [ "$((MPTCP_LIB_TEST_COUNTER+1))" -eq "${i}" ]; then
 			return 1
 		fi
 	done
@@ -267,14 +263,13 @@ reset()
 
 	TEST_NAME="${1}"
 
-	MPTCP_LIB_TEST_COUNTER=$((MPTCP_LIB_TEST_COUNTER+1))
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
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 2750756d25c9..459e90258f37 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -11,6 +11,7 @@ readonly KSFT_TEST="${MPTCP_LIB_KSFT_TEST:-$(basename "${0}" .sh)}"
 MPTCP_LIB_SUBTESTS=()
 MPTCP_LIB_SUBTESTS_DUPLICATED=0
 MPTCP_LIB_TEST_COUNTER=0
+MPTCP_LIB_TEST_FORMAT="%02u %-50s"
 
 # only if supported (or forced) and not disabled, see no-color.org
 if { [ -t 1 ] || [ "${SELFTESTS_MPTCP_LIB_COLOR_FORCE:-}" = "1" ]; } &&
@@ -412,3 +413,11 @@ mptcp_lib_events() {
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

