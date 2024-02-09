Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC3D53398
	for <mptcp@lists.linux.dev>; Fri,  9 Feb 2024 17:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707499753; cv=none; b=ln6xhC3rlCPxJ7XhlQHVbLCUacfncMxVOJbX5QEOb6wcH80ThxIXBPqqr+OO09uYMbdQpUd+Vs51JqtRM87zUSU0d3Ws5FZaC5vWNLwSOV4Wq6KBsZU6VqUva25wJ5uk25WczqLs8aWeaUVp4+ig9cETS97qF8o3A82a2r2pcIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707499753; c=relaxed/simple;
	bh=k19QfQTM6BklgCn0TivSF1zvEGRWJJiaNLoU+TAvgFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AvdrZp/zChWVKuARZmMDvqKDP6Idx4ltdtWdyvzBK81pjTxqQPRBouY16y0oNLE9/xca/DVyL2Yr5fYwLBHwUCe3wy/qd56e6EzEOolHcJn3WYQibXolCQiS3Kplmkg+ePGq3Ax/LzVdPNE31ubWmEAEUaGzKAqbWDWlWSyX874=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vDQp4RcX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDQp4RcX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8AAC433F1;
	Fri,  9 Feb 2024 17:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707499753;
	bh=k19QfQTM6BklgCn0TivSF1zvEGRWJJiaNLoU+TAvgFY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vDQp4RcXpnOherjB5p2d+v8kwTdxZCd+iyZC/TIm8Dq+3OSGtOaUJvi/P7wVR+q4W
	 YTWJxHf+nbZhe0nM41zOXVsKNUcZpEgdW+P8QlxyuRYajhV1vWC89FlHL4rfbkpdyW
	 G7n+gLAuy1u+qd7YIe18Wh0uwuAEUJlJvlqxZRELOqiXMokV/8/3R79AIV1VDuCrh/
	 dTMXG+x8oAIM8ZIBnYBrQW+L6ZljpfFeQZUpJmkskpcTNYcxBAgq1eKlUkfNCXaYmJ
	 u0ojB+gOzZbaS4dklIljVgzl23eumM/e/wZyAj59dtnPqNRrOnNf+SOkvXS/vpSmLs
	 J/se0mK6FIWCg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 09 Feb 2024 18:28:43 +0100
Subject: [PATCH mptcp-net 5/5] selftests: mptcp: lib: catch duplicated
 subtest entries
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240209-selftests-mptcp-uniq-title-v1-5-e4fb3a3b5f66@kernel.org>
References: <20240209-selftests-mptcp-uniq-title-v1-0-e4fb3a3b5f66@kernel.org>
In-Reply-To: <20240209-selftests-mptcp-uniq-title-v1-0-e4fb3a3b5f66@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2442; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=k19QfQTM6BklgCn0TivSF1zvEGRWJJiaNLoU+TAvgFY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlxmDjaByetgH9UM7ojBfZnVfTzQvfEzy8Lvw9T
 yzTgsku0ayJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZcZg4wAKCRD2t4JPQmmg
 cwcbD/9IHADkE2NvW/b6gxOQtxbcblaewJqP56BCsSTVRL0tzDSOkgyaYt6EE70qZpRoYt/0hec
 DxGhIAmoUd9c2SdZGKYrlsXcKuyXxzytGRi6rtyUUUB17MepIgHWdVhAa3CZiOfZqpZr4WA11+z
 SQsf4v+Od43VsxgP0KTTQj+xYLXF84k8AM1OaWAO9u7R2TKAYzT1XuNq6AK1gdLyNXQmCOA+03e
 rpcbrf2ZvIk1yvdof9KI2pvQXKmB2jSDK4rkN5Hb8BFLHQn+wPSkSm9BkpM6BEAJ9Lo7BjLJZ+x
 q28NkZASOUpY2kEMBTIwy+t2lhrQv5VYkWXQk+lys+WUYfvbmsCbc6U8Iauu8E0LPSezKxy05GM
 pL5X3Ktz5PJRMaOKGYEP1owvQle/8i6g6vOvYIySCnpX7t9p9Mjwg0WJO8CzV2G/IUC+lphiqQ3
 gnIjXLFqcbs0jq+X0db9U82H+hdmG1ZyN54PJpIk6wOo/D/KiRXWeZAT/5aREtWx6raxIVbBuaN
 4PxhAOj0AG3sar5hf4VaI+GQANIBPeOSGyOOG9oNDpIgN+jyX/opzmzvWGxLZ3hytPIEPyQ4/Ys
 SW3iAfdHC0d+IKICGm0aILlNdtYGA9iJRTdvStA3ewoCGCmaVxW5dv9uIUj7ez4J+HPrYPNBf3+
 iZnaAFdfVJh73wg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It is important to have a unique (sub)test name in TAP, because some CI
environments drop tests with duplicated name.

When adding a new subtest entry, an error message is printed in case of
duplicated entries. If there were duplicated entries and if all features
were expected to work, the script exits with an error at the end, after
having printed all subtests in the TAP format. Thanks to that, the MPTCP
CI will catch such issues early.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
  - This is a patch for 'mptcp-next'. But because it depends on the
    other ones, I added it in this series, also to check I didn't miss
    anything.
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 3a2abae5993e..037cb3e84330 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -9,6 +9,7 @@ readonly KSFT_SKIP=4
 readonly KSFT_TEST="${MPTCP_LIB_KSFT_TEST:-$(basename "${0}" .sh)}"
 
 MPTCP_LIB_SUBTESTS=()
+MPTCP_LIB_SUBTESTS_DUPLICATED=0
 
 # only if supported (or forced) and not disabled, see no-color.org
 if { [ -t 1 ] || [ "${SELFTESTS_MPTCP_LIB_COLOR_FORCE:-}" = "1" ]; } &&
@@ -146,12 +147,26 @@ mptcp_lib_kversion_ge() {
 	mptcp_lib_fail_if_expected_feature "kernel version ${1} lower than ${v}"
 }
 
+__mptcp_lib_result_check_duplicated() {
+	local subtest
+
+	for subtest in "${MPTCP_LIB_SUBTESTS[@]}"; do
+		if [[ "${subtest}" == *" - ${KSFT_TEST}: ${*%% #*}" ]]; then
+			MPTCP_LIB_SUBTESTS_DUPLICATED=1
+			mptcp_lib_print_err "Duplicated entry: ${*}"
+			break
+		fi
+	done
+}
+
 __mptcp_lib_result_add() {
 	local result="${1}"
 	shift
 
 	local id=$((${#MPTCP_LIB_SUBTESTS[@]} + 1))
 
+	__mptcp_lib_result_check_duplicated "${*}"
+
 	MPTCP_LIB_SUBTESTS+=("${result} ${id} - ${KSFT_TEST}: ${*}")
 }
 
@@ -206,6 +221,12 @@ mptcp_lib_result_print_all_tap() {
 	for subtest in "${MPTCP_LIB_SUBTESTS[@]}"; do
 		printf "%s\n" "${subtest}"
 	done
+
+	if [ "${MPTCP_LIB_SUBTESTS_DUPLICATED}" = 1 ] &&
+	   mptcp_lib_expect_all_features; then
+		mptcp_lib_print_err "Duplicated test entries"
+		exit ${KSFT_FAIL}
+	fi
 }
 
 # get the value of keyword $1 in the line marked by keyword $2

-- 
2.43.0

