Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C474F5FE
	for <mptcp@lists.linux.dev>; Tue, 21 May 2024 07:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716276457; cv=none; b=NhB+93gOg+ZHWIU5vzMoxqIyyPHLvL4RsumFH+LB9XP/HvDy8+bLhrzXy9uqdZbGPK7NxgrDp4FJ4L22tBu6ditQIYb0TOeeG10zkHtu689uV5nxagIcmH10MDI8sFOG4HZ1VCOaOFo929HVXawx5UbvmCofi+IuKcprRMNXpew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716276457; c=relaxed/simple;
	bh=7cO4+g901/OvGtpUux7VPcBFyjT/JLEPvy0BAA2THy4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sINP4/HRv5WShoCKm1pm3dHwlJrmyIDfDO6rXt4MyGdI1KAXf8o+tiYdD+a8nfoYOcSNyD9MDKfOFXo9FTe+LKwmcvWNOLCpAnVHM/TvxbgMRB5vCcjtHFhWH15hBQEWvo8BLarYjd2IZojaazexWYcoinsX3OwDLLr+XUhk9jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfJmVVBQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfJmVVBQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18FEEC4AF08;
	Tue, 21 May 2024 07:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716276456;
	bh=7cO4+g901/OvGtpUux7VPcBFyjT/JLEPvy0BAA2THy4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cfJmVVBQNQ6bJ9+eDKeVSz6hh7M4ULvzOvES5CRBKCzrBEgohwE/Nt94QJ3TZMLQ1
	 mYOgeaVk23IaUOIWO/9Nsx9LHvn227L2a7qQf3iEYY7+wzZN+croMCF9xu6pjmtMAp
	 na2JX9a2osvU6MrqDjWNW4bc9R5p7O0pcPqQUIoo5GVKn7ijsOKPFFs1LYrWFXpE+w
	 t6kyyOoncjH+DVBpLZJkykW/tMXD5Di6M8+M8SGRotZc3+xJfooz8zv0HiUduc13sR
	 c6+TkgfYfaYSzB90gWB2r9v30Oc6l1XPYPj8ygRj1VCYTyPJCGDFwXQ6hX8NO619MW
	 2aOQ4sVSRfSaA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 21 May 2024 09:27:30 +0200
Subject: [PATCH mptcp-next v2 1/4] selftests: mptcp: lib: support flaky
 subtests
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240521-selftests-mptcp-disable-flaky-v2-1-eba143bcbad0@kernel.org>
References: <20240521-selftests-mptcp-disable-flaky-v2-0-eba143bcbad0@kernel.org>
In-Reply-To: <20240521-selftests-mptcp-disable-flaky-v2-0-eba143bcbad0@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3450; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=7cO4+g901/OvGtpUux7VPcBFyjT/JLEPvy0BAA2THy4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmTEzmRGM7sdJnwTneUWEN0ydbd8A/Cdu6wynqB
 vC4ROONgvyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZkxM5gAKCRD2t4JPQmmg
 c95vD/wIoEwdOH802du7+ex500pnjI4LHS0YoMCu1ztbruNpxkbhwuk6b7ieYkv8wGSc/Lukynx
 ggqt3DL8W4BNtb3oHvejnrgiMug1D5YCWRPkIcQ7lQ0apLUNqMbvKLXma7zZd2wmHI5Qse7ElUi
 Hl6pqAPwLtP71/BLBk1ovrYYWnlaaOn34nGF/eskAys+/wf4iOBrMxYu1TXPU3ztGTPVBZ78eEr
 /f0TW3JenrLuTNyEnNj+KuxjuROo5DyP5CDMPtdlGCVXPquDoifYDKk6N+gvwgoesbEJ4OSWdgg
 EkzneWVcsaFmvgbCRQ6fgwKM68Wmf0Kb+erhIjWiQ3cDVOTLahV6xcokvFpmFFiOUddmXwdAO+p
 vPiy3VP5ceOnb4WKLCgiPnoYUzgB1stbZp8eLnL8f+lru8G1cxDftnlJ8IHLTegiyymqxl4BRvy
 mSgD+HUZ83Vh2X3VIjSs8n+uoAm5HVBUwL4JQNKQ4nWT6YPFSWYByFM1p6MDNiLn7vWlVk8pvIl
 FUK3I5cZNlB6j6mW/xIlXSlfhjgEXiSxWF6dXvn5wA6zpcfedBnA7OrEC7JHk3xPUnPMB3aO0To
 OfqnM60VmrBI3Y42tAWNu7NPgEmE4y7TzLp+AHWGRaq3zh9rzaRvGSfRYPDcQQuUfMNsPROzfn7
 ACKHb/QuyyZq4BA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Some subtests can be unstable, failing once every X runs. Fixing them
can take time: there could be an issue in the kernel or in the subtest,
and it is then important to do a proper analysis, not to hide real bugs.

To avoid creating noises on the different CIs, it is important to have a
simple way to mark subtests as flaky, and ignore the errors. This is
what this patch introduces: subtests can be marked as flaky by setting
MPTCP_LIB_SUBTEST_FLAKY env var to 1, e.g.

  MPTCP_LIB_SUBTEST_FLAKY=1 <run flaky subtest>

The subtest will be executed, and errors (if any) will be ignored. It is
still good to run these subtests, as it exercises code, and the results
can still be useful for the on-going investigations.

Note that the MPTCP CI will continue to track these flaky subtests, and
a ticket should be created before marking a subtest as flaky.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 38 ++++++++++++++++++++------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index ad2ebda5cb64..44febbc11131 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -21,6 +21,7 @@ declare -rx MPTCP_LIB_AF_INET6=10
 
 MPTCP_LIB_SUBTESTS=()
 MPTCP_LIB_SUBTESTS_DUPLICATED=0
+MPTCP_LIB_SUBTEST_FLAKY=0
 MPTCP_LIB_TEST_COUNTER=0
 MPTCP_LIB_TEST_FORMAT="%02u %-50s"
 MPTCP_LIB_IP_MPTCP=0
@@ -41,6 +42,18 @@ else
 	readonly MPTCP_LIB_COLOR_RESET=
 fi
 
+# SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var can be set when validating all
+# features using the last version of the kernel and the selftests to make sure
+# a test is not being skipped by mistake.
+mptcp_lib_expect_all_features() {
+	[ "${SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES:-}" = "1" ]
+}
+
+mptcp_lib_subtest_is_flaky() {
+	# If all features are expected, do not threat them as flaky
+	[ "${MPTCP_LIB_SUBTEST_FLAKY}" = 1 ] && ! mptcp_lib_expect_all_features
+}
+
 # $1: color, $2: text
 mptcp_lib_print_color() {
 	echo -e "${MPTCP_LIB_START_PRINT:-}${*}${MPTCP_LIB_COLOR_RESET}"
@@ -72,20 +85,21 @@ mptcp_lib_pr_skip() {
 }
 
 mptcp_lib_pr_fail() {
-	mptcp_lib_print_err "[FAIL]${1:+ ${*}}"
+	local title
+
+	if mptcp_lib_subtest_is_flaky; then
+		title="IGNO"
+	else
+		title="FAIL"
+	fi
+
+	mptcp_lib_print_err "[${title}]${1:+ ${*}}"
 }
 
 mptcp_lib_pr_info() {
 	mptcp_lib_print_info "INFO: ${*}"
 }
 
-# SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var can be set when validating all
-# features using the last version of the kernel and the selftests to make sure
-# a test is not being skipped by mistake.
-mptcp_lib_expect_all_features() {
-	[ "${SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES:-}" = "1" ]
-}
-
 # $1: msg
 mptcp_lib_fail_if_expected_feature() {
 	if mptcp_lib_expect_all_features; then
@@ -208,7 +222,13 @@ mptcp_lib_result_pass() {
 
 # $1: test name
 mptcp_lib_result_fail() {
-	__mptcp_lib_result_add "not ok" "${1}"
+	if mptcp_lib_subtest_is_flaky; then
+		# It might sound better to use 'not ok # TODO' or 'ok # SKIP',
+		# but some CIs don't understand 'TODO' and treat SKIP as errors.
+		__mptcp_lib_result_add "ok" "${1} # IGNORE"
+	else
+		__mptcp_lib_result_add "not ok" "${1}"
+	fi
 }
 
 # $1: test name

-- 
2.43.0

