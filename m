Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383711C696
	for <mptcp@lists.linux.dev>; Mon, 26 Feb 2024 08:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708935497; cv=none; b=JTF2dD7YxEOzOSP+v8i9GS/T+Fcg7AlDA09jIUyDIEGqKToLuEHepsyX179ak1hQz4Uyyr6S2oNUn82bUkSwlC5hahtfHAfrIzhVnJMAiXaLFJAbumuq1OGz9yrDdiktPt8GSU9Cezwyouzj84+dUDL9kVCgXNYH3Fl/7Yc/PzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708935497; c=relaxed/simple;
	bh=p2XInzCPm8ijm0ExDUVT4NzKzxvFhHym8yw81fgTaV8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i/d84muVpRzx6CP+iQCdKOnKGR/BTqUl8XFwVsOTPi17FT65qTMRLOOIEA04/hKaZPA+2lHc9LtKWOe42nqyZv6ogJ5XhzcMHLu1/XANXCIwInsCLUq/d3RCC9bvegtRKUXcRes2jgfljLyHx148z3DdO9jyazqx5Hn1e2+mo4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvvNgRg+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvvNgRg+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97687C433F1;
	Mon, 26 Feb 2024 08:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708935496;
	bh=p2XInzCPm8ijm0ExDUVT4NzKzxvFhHym8yw81fgTaV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TvvNgRg+eCs+wl6wrJIvw5GIThOKRqaHp7qpFMXdWiVH6vFV59Is4FJyW61NdJwK8
	 AP6m77q/UHCggElKjxeTho1DWOPz7pjNXOTCU3q/FdRYuXGceiVZe6dFKteg3pooUG
	 keYHgwSq4C2HmaY598ZZLKGhBHaG3rEp4p3H8qmfvIhQVZIFilcCwA4JFvCMXBCIHa
	 DvE4s6gdZHH37aaTT//D45SMa3nP6oWq2UCylxaH6dhlCSph3KsONX9KnlVZyrs0fM
	 JcUA+FAr1Papy0R71YmOT5cY6wHuDK5mjeDOBVu3VtfCYpru/3CrEUKGr2gUOy5vzm
	 ElrPcO6yBUC7w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 07/13] selftests: mptcp: add mptcp_lib_print_test_counter
Date: Mon, 26 Feb 2024 16:17:52 +0800
Message-Id: <456f56cc925a7d20c5bf502ff1940be9117f356a.1708935196.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708935196.git.tanggeliang@kylinos.cn>
References: <cover.1708935196.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new helper mptcp_lib_print_test_counter() to print out
test counter in each test result and increase the counter. The counter
digits of most tests are 2, only mptcp_join.sh is 3.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 5 ++---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh  | 9 +++++++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 8e8977031fa0..0d45578f7858 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -48,6 +48,7 @@ declare -A all_tests
 declare -a only_tests_ids
 declare -a only_tests_names
 declare -A failed_tests
+#shellcheck disable=SC2034
 TEST_COUNT=0
 TEST_NAME=""
 nr_blank=6
@@ -172,7 +173,7 @@ cleanup()
 
 print_title()
 {
-	printf "%03u %s\n" "${TEST_COUNT}" "${TEST_NAME}"
+	mptcp_lib_print_test_counter TEST_COUNT "%s\n" "${TEST_NAME}" 3
 }
 
 print_check()
@@ -268,8 +269,6 @@ reset()
 
 	TEST_NAME="${1}"
 
-	TEST_COUNT=$((TEST_COUNT+1))
-
 	if skip_test; then
 		last_test_ignored=1
 		return 1
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 7e309493eda2..482e88f5b7bf 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -411,3 +411,12 @@ mptcp_lib_events() {
 	ip netns exec "${ns}" ./pm_nl_ctl events >> "${evts}" 2>&1 &
 	pid=$!
 }
+
+mptcp_lib_print_test_counter() {
+	declare -n counter="${1}"
+	local fmt="${2}"
+	local msg="${3}"
+	local digit="${4-2}"
+
+	printf "%0${digit}u ${fmt}" "$((++counter))" "${msg}"
+}
-- 
2.40.1

