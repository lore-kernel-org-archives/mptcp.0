Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6C524B2C
	for <mptcp@lists.linux.dev>; Wed, 28 Feb 2024 07:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709106236; cv=none; b=IVNRLx8y0Aw0Lkaq90hW8rpCvHv5AQwfm0nMKz4VLWvCWwCl31nhk0+I4NFZyASXNdTo4hwqfthCYHNBgsV4pxp53tkqv2Y36tdp61ub5mNaD1hFhZSJIl/Fm+YywhQzWpQeCZP60Ott53y1YduUWb+lT4JsrNBxT0DQ56sIkVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709106236; c=relaxed/simple;
	bh=KvdVpJrkwsH7Z86TuLA9FGLtQ28ntaHyvlreTJewkDU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a/2mLN5C+d/k74fDuVm9OeAtzRk5d4CXkau3NMMdU9A6lDhoBTWD4VIKPSZEq6o8lXO3r6Ns7hvGxSxEo3X2r70wxRjJs/BIio7A0c8WOj7D44gsQSf8x/UJKz+LrWzfeDL5RxRa/Qukt+mSDkY1ad4D8ZXA2ItAFCZjti0hTng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ukoy+mnV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ukoy+mnV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27853C433C7;
	Wed, 28 Feb 2024 07:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709106236;
	bh=KvdVpJrkwsH7Z86TuLA9FGLtQ28ntaHyvlreTJewkDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ukoy+mnVFXjFH70KmqkYG/9Cz2yK996KRqQqbUP8iFH8DHqc2Nf1+rBKn8XDjKf5P
	 gy/OKZfZ6lySFtMN7+d6LxjPszzfy2a9dRtI9nJYJ28og8zRjQxTHuBFoO/H0h76b0
	 ptmYBraKGXQGpO9AQf/nrsiUV2t0+0GU3vL1uvikj5H6aA5XYui7VOt1uVbghdVuUP
	 00mIQKPCX9TOPteR9ftqAvctypBfkbiTQiCm5mGikfLpBIGxiK91pA1djoEjrzo7cl
	 HBJCOarjM1FPN3RjSEgZ9kzS2TK9y7/ptkXVKpwm3eZI11hqgyEkWYX7QpKzs4YyI8
	 AhIvodEvgLFGw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 1/9] selftests: mptcp: add mptcp_lib_pr_ok/skip/fail/info
Date: Wed, 28 Feb 2024 15:43:39 +0800
Message-Id: <d7732e6238909444e5c3d8a67aa06f2fa4b3e79b.1709105922.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1709105922.git.tanggeliang@kylinos.cn>
References: <cover.1709105922.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

To unify the output formats of all test scripts, this patch adds
four more helpers:

	mptcp_lib_pr_ok()
	mptcp_lib_pr_skip()
	mptcp_lib_pr_fail()
	mptcp_lib_pr_info()

to print out [ OK ], [SKIP], [FAIL] and 'INFO:' with colors. Use
them in mptcp_join.sh and userspace_pm.sh first, and then use them
in all scripts in the next commit.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh |  6 ++---
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 23 +++++++++++++++++++
 .../selftests/net/mptcp/userspace_pm.sh       | 13 ++++-------
 3 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 1df2d24979a0..53d51a5f68f9 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -190,17 +190,17 @@ print_info()
 
 print_ok()
 {
-	mptcp_lib_print_ok "[ ok ]${1:+ ${*}}"
+	mptcp_lib_pr_ok "${@}"
 }
 
 print_fail()
 {
-	mptcp_lib_print_err "[fail]${1:+ ${*}}"
+	mptcp_lib_pr_fail "${@}"
 }
 
 print_skip()
 {
-	mptcp_lib_print_warn "[skip]${1:+ ${*}}"
+	mptcp_lib_pr_skip "${@}"
 }
 
 # [ $1: fail msg ]
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 763a2989ca6d..3f5b16fe5220 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -48,6 +48,29 @@ mptcp_lib_print_err() {
 	mptcp_lib_print_color "${MPTCP_LIB_COLOR_RED}${*}"
 }
 
+mptcp_lib_pr_ok() {
+	mptcp_lib_print_ok "[ OK ]"
+}
+
+mptcp_lib_pr_skip() {
+	local msg="[SKIP]"
+
+	mptcp_lib_print_warn "${msg}"
+}
+
+mptcp_lib_pr_fail() {
+	local msg="[FAIL]"
+
+	if [ "${#}" -gt 0 ]; then
+		msg+="${1:+ ${*}}"
+	fi
+	mptcp_lib_print_err "${msg}"
+}
+
+mptcp_lib_pr_info() {
+	mptcp_lib_print_info "INFO:${1:+ ${*}}"
+}
+
 # SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var can be set when validating all
 # features using the last version of the kernel and the selftests to make sure
 # a test is not being skipped by mistake.
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index b0cce8f065d8..5f32ac451596 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -61,7 +61,7 @@ _printf() {
 
 print_title()
 {
-	_printf "INFO: %s\n" "${1}"
+	mptcp_lib_print_info "INFO: ${1}"
 }
 
 # $1: test name
@@ -72,27 +72,22 @@ print_test()
 	_printf "%-68s" "${test_name}"
 }
 
-print_results()
-{
-	_printf "[%s]\n" "${1}"
-}
-
 test_pass()
 {
-	print_results " OK "
+	mptcp_lib_pr_ok
 	mptcp_lib_result_pass "${test_name}"
 }
 
 test_skip()
 {
-	print_results "SKIP"
+	mptcp_lib_pr_skip
 	mptcp_lib_result_skip "${test_name}"
 }
 
 # $1: msg
 test_fail()
 {
-	print_results "FAIL"
+	mptcp_lib_pr_fail "${1:+ ${*}}"
 	ret=1
 
 	if [ -n "${1}" ]; then
-- 
2.40.1

