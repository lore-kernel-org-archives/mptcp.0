Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECFB182DF
	for <mptcp@lists.linux.dev>; Mon, 20 May 2024 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716215884; cv=none; b=b3qhUycbjEx0uKkLTTbMvscLRVUxkpGoNXFfIek2BQoSEJSlSshjGtK+EYuyzjn/uetdj+DOdl0S/FRHQcg2wQpSFS29UYsa6v4rcYFA2WxvWXp9GCFC1+fYFQYIvipsu9X77x3JzoqCQf7YqEqtimCF5GS9/tea8C013AlhoT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716215884; c=relaxed/simple;
	bh=7cO4+g901/OvGtpUux7VPcBFyjT/JLEPvy0BAA2THy4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W2T9kJUY6CyWnmOSz6Mq8Yn6XxmLL1yi92oRFrQ7RFgp/CrreQPlzvJbKrph/cBLi+ncrQ+wJfg8o8XVqufy2T/XzTCuVD6NtWod11ma9k5arJRVmo4w16pUBSR9beQHN5h5cPQZjQgw16dyHB8pu0Q3QnE6IvMhPelft/+O5Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjakA6ya; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjakA6ya"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53215C2BD11;
	Mon, 20 May 2024 14:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716215883;
	bh=7cO4+g901/OvGtpUux7VPcBFyjT/JLEPvy0BAA2THy4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BjakA6yaXyoxAQJlLI9H6XPcSKMeFREr2/B+ClhR72h/9wc8+EQLNX51OOryZ77Yk
	 dY94kfT2VjcEn7JWkJ3j86WgBXogLhuqP1nujdsotpF9ZG67OrgyX/46BeEkZCXg4r
	 GfpPTUD9K1kR7aJC9YI84quFFHGCnPqwtirHjQbmyEvBZtIHCfCQUK0L6JAuiwpjlt
	 UbViYKcCdtedvLewj8cRAgLhpzzoYfHBe5FvMzVa5IKIlUb2iyarO9fiGKXGLvjlSo
	 wsPAWLbom+1lzFjZTqJCXfhQAcPiA4ELgjkyJSilufpvPEsSEhAXh18DRNLXt7PnUe
	 1CispUvHfkWzw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 20 May 2024 16:37:55 +0200
Subject: [PATCH mptcp-next 1/4] selftests: mptcp: lib: support flaky
 subtests
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240520-selftests-mptcp-disable-flaky-v1-1-02e23ba0bc3b@kernel.org>
References: <20240520-selftests-mptcp-disable-flaky-v1-0-02e23ba0bc3b@kernel.org>
In-Reply-To: <20240520-selftests-mptcp-disable-flaky-v1-0-02e23ba0bc3b@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3450; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=7cO4+g901/OvGtpUux7VPcBFyjT/JLEPvy0BAA2THy4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmS2BJ/del5qlDW3YtwdQwAmkS3Ie1W8ju+unPC
 J0fMqxN3QyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZktgSQAKCRD2t4JPQmmg
 c40UEAC3ZW0pU1UgqoNmT2vE+F4ZKnHy/7QwOlTZX90sVwK/goDi8zlz+prBqsl2VUC2YVRu6Eu
 KsxW5yNGKoReUHRQDQrff+HQqOHGvSriIKglKihkTCzRhdO0ColO3q0szTuv2D6qkwBIbiLwZ9s
 DuOMxbAQA7LgBIQ1TLP/MImlHNMbDVTe9E0C3HGM3I66elpUYtKF4soAkzmXVxPRbOKQlf2gbRx
 GdukmY183f83uNQwExr/msevuThFW5mI7pfEmt83hqbQpaOiAjPtuu8w0w6Tc9qORMq8Jz1w2C9
 FLR1W0HtfnJWsCOywPQtRrMkElDmBHQAK3MrIJH5pQqvW+OGMLmDsTJUYsa4bqc5UjUTJWQdAeO
 XnEELSNuL8lLWHg7k4DFgA34quBnLdJIzTJwGKVCxDxBIgbYX6QcR82DNKvWMNmFn1E0DDr094g
 Jd7gRoS+uUHkW4xgu4FKLHeT3bSJv4PChX6mEAdGYe7zK20Gatv0HNDlcngI02aH8fEqBpnu/Jh
 U4oaKw3mZesiy463dqtuyiZOQWPKw/G7dPLOOhcP2Jb27ee3pkugCpIJwg2J4VThtTRIvq6wRfp
 PvvFebuNt5CBj1cqvMX4jr20eN3PJd/yr8o3snIsf02AlDa6Ui7yzhqS/Xc2L+Zb6DDB2Oi/yRZ
 sL11eT0xzlwDM0g==
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

