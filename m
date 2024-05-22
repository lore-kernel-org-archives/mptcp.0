Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2847079B9D
	for <mptcp@lists.linux.dev>; Wed, 22 May 2024 10:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716374874; cv=none; b=GSQupyAa+l+3eYMw8/wlQEawy9kgvxWA/ioy12JALA3e1siAN0KHrGDE9m1W+Rg1uJjTOaEU9hny2+0gwR1LiGhtSPhDB0B4Sqeewzg7ZZMId08SOJBfuh1hH9s6+SMWaYkzmlOpDRQ7J2SjLIFC0l4AdF3fpad1ZfQlX1K7HJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716374874; c=relaxed/simple;
	bh=FNpzG5YrNfqfglGKIkGAIvhRVCv3J44sO+WOWiMI968=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fKvKabNDWpB0VYx4GzeOiddUBHtznir/k6JxXMT4Nmsk6MiOMZRkKQdU7e/fSndNpdOPNmwiRHSUBl+hiJzkYsFCIJ9kA348FL+//kHYQKKwP9NZNpTucr36GSy0aiaW193DnOp6Uc3hWTak3c3UlSTAmtb0D6ALtiZjIpBO+4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxnWKIAQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxnWKIAQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E46EC32789;
	Wed, 22 May 2024 10:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716374873;
	bh=FNpzG5YrNfqfglGKIkGAIvhRVCv3J44sO+WOWiMI968=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cxnWKIAQNlKH/cncvYH/WUV1ttwaKnWqfMpL/O9n/HiCaXEz/aDekxEqvPSt5YMtJ
	 mouvwniiqgDoNiYMAvQrOgKSmNDRp0gyCB7Sq11aImHb6xyyolG2cBjK2v+GFFTUo+
	 DrntuPMlgnj60isdCC0eDBYvEiY8PoBKNwDQCyMHldp/0jidGfkiN2OnxmQacJaRdd
	 fRuizudANkFyRppDOz+vLYob30z03UT8a5xOnoHbo5gmC6QUlrsyT4SVgw4ueNkoJK
	 icqdo+E+3T6vMvqK0I1h0AAK8sny7l6xa9EN9n4uStX3ch6U2iylBrFF+U8sZx5FFh
	 xvxootLBYFqBg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 22 May 2024 12:47:43 +0200
Subject: [PATCH mptcp-net v3 1/4] selftests: mptcp: lib: support flaky
 subtests
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-selftests-mptcp-disable-flaky-v3-1-a10c68bf2680@kernel.org>
References: <20240522-selftests-mptcp-disable-flaky-v3-0-a10c68bf2680@kernel.org>
In-Reply-To: <20240522-selftests-mptcp-disable-flaky-v3-0-a10c68bf2680@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2918; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=FNpzG5YrNfqfglGKIkGAIvhRVCv3J44sO+WOWiMI968=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmTc1XXAL6HkhDH52lBdEJDFepxRR1mVStdWqZS
 gVCX2xMP3GJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZk3NVwAKCRD2t4JPQmmg
 c6PZEADtf4SfVFPMt9pyDYtQUoBw50uUSkrBkf+bh6TQAjtR9Hkm9wWARJC4YspnIazqrbjx7a+
 ixCcIpo5xma+iN73wKVHKaSiKj3NLTYUO4hFRtZlJOxBK/xYVLbYqJl3S3yZHm6rdxDkR8+FkTp
 Mt2xqqXWBHjN6TW75mf6+7tVbfT/2HRv4KX+2Q+N6PR1wBMUXptntiezDcCAJaw784qDv+6NKWN
 GZC7puZI0JCYLE1xpI/HrzfdU+CMlJA6fL9ygPWkCblvYOZCNptCrLb3kNOr6wiJ+qKE+ztY49m
 rD1Kw/aBLQUfE4M+IxTHaJOBuTM3Nb8M09gvghbyPOLxspKCjYuroo4Hnk2UgFcSFXQDhSp57a+
 eF47KR1X6Y//kcV3HINvYN1GDL3Zr06nLrz42noW4vviSfZOdlAN/vXvIv+CwhcNF7yAylhQacK
 PD+masa1nic65N2ddNPr2Ld5vJmPv4jnKn7uZVKOxULPaJHLJthlBM8eqfoUvkJkAYu01dfRHto
 GlV25gcsoMvcZnsArdkYJF0RTDFbbUg1AqcU2Sf4dxD/LiAsV2LfFqmfCYmvBDm6aREkXnFsG4d
 SZdrz/OP82UMCAWJrVdlavfOAPfjPIP/U9W8B9f6tK/OtRv2aG+c+Haws6GnbkOl8DDNEMD6N8A
 novXjYeDBBjwe5A==
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

Note that the MPTCP CI will continue to track these flaky subtests by
setting SELFTESTS_MPTCP_LIB_OVERRIDE_FLAKY env var to 1, and a ticket
has to be created before marking subtests as flaky.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 30 ++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index ad2ebda5cb64..6ffa9b7a3260 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -21,6 +21,7 @@ declare -rx MPTCP_LIB_AF_INET6=10
 
 MPTCP_LIB_SUBTESTS=()
 MPTCP_LIB_SUBTESTS_DUPLICATED=0
+MPTCP_LIB_SUBTEST_FLAKY=0
 MPTCP_LIB_TEST_COUNTER=0
 MPTCP_LIB_TEST_FORMAT="%02u %-50s"
 MPTCP_LIB_IP_MPTCP=0
@@ -41,6 +42,16 @@ else
 	readonly MPTCP_LIB_COLOR_RESET=
 fi
 
+# SELFTESTS_MPTCP_LIB_OVERRIDE_FLAKY env var can be set not to ignore errors
+# from subtests marked as flaky
+mptcp_lib_override_flaky() {
+	[ "${SELFTESTS_MPTCP_LIB_OVERRIDE_FLAKY:-}" = 1 ]
+}
+
+mptcp_lib_subtest_is_flaky() {
+	[ "${MPTCP_LIB_SUBTEST_FLAKY}" = 1 ] && ! mptcp_lib_override_flaky
+}
+
 # $1: color, $2: text
 mptcp_lib_print_color() {
 	echo -e "${MPTCP_LIB_START_PRINT:-}${*}${MPTCP_LIB_COLOR_RESET}"
@@ -72,7 +83,16 @@ mptcp_lib_pr_skip() {
 }
 
 mptcp_lib_pr_fail() {
-	mptcp_lib_print_err "[FAIL]${1:+ ${*}}"
+	local title cmt
+
+	if mptcp_lib_subtest_is_flaky; then
+		title="IGNO"
+		cmt=" (flaky)"
+	else
+		title="FAIL"
+	fi
+
+	mptcp_lib_print_err "[${title}]${cmt}${1:+ ${*}}"
 }
 
 mptcp_lib_pr_info() {
@@ -208,7 +228,13 @@ mptcp_lib_result_pass() {
 
 # $1: test name
 mptcp_lib_result_fail() {
-	__mptcp_lib_result_add "not ok" "${1}"
+	if mptcp_lib_subtest_is_flaky; then
+		# It might sound better to use 'not ok # TODO' or 'ok # SKIP',
+		# but some CIs don't understand 'TODO' and treat SKIP as errors.
+		__mptcp_lib_result_add "ok" "${1} # IGNORE Flaky"
+	else
+		__mptcp_lib_result_add "not ok" "${1}"
+	fi
 }
 
 # $1: test name

-- 
2.43.0

