Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E3010A3C
	for <mptcp@lists.linux.dev>; Sun, 25 Feb 2024 13:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708866259; cv=none; b=Z5AKtEycC6YkJcsdaLimBg86Bt4kbVoLh5s+N9a4bSEypt4+uqT4RlcZYhw2MjmnEbNjbGaQOTD5Zmk7frpf/TbOaLcmyS3U4tOf8Svwk9l/uGtJsnS1OwUdkX1GhVJhwSf/Cni0d/4MAz7EAmW2qtN4/TVpwmPCPA8fLZDYePY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708866259; c=relaxed/simple;
	bh=NtWI8hoNQSNaM0fU3cCbGBOP47t4ETz5d7bgpU8oqjs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DpJvnT9nvENbJ09W+7N/QvdO/Ng/FpTOp3DATKzUcYMHeKEeTjXxM0MMeL0Q1Il/x1AiPqJ2fptIx6bwWhoGSbNy7l6XRU/UoEHvXSV/gGvkdFxtT7A3uL6XdMhE//RjGEWZU0LH19LXXnatP7rNllzyuDhZ0IU5DyGmqlk3XAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6ts20Yb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6ts20Yb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E241C433F1;
	Sun, 25 Feb 2024 13:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708866258;
	bh=NtWI8hoNQSNaM0fU3cCbGBOP47t4ETz5d7bgpU8oqjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M6ts20YbT9xLowQ3APdgTdwiHNRjSOYvYx0a7JYx/PjL6ctgX//a99StfTr9nl+bo
	 bixeXWct/AJZBO77UR4K5eP7PcsdP0UW+f3Gbx9vE+SQl/OoFiPxdT4drO1RslaIBU
	 LGyi+1lpqy7gc+heZNneMib01mV2EuKnKGCkCtNjj5qOrUfq6GKyo+sktfjE4Wn5D7
	 O5XUNua/ijeBjvsa4e9tc3EebdT2W+C9kY6rWd/21y4Q1Y4doWCvAwX3judC/JpKTE
	 JfHYWXoxlXdU1Ou3Xean6rC6JEYRWh7gtw6372+OCAYOiVFEojNchSfHAkhfrHGMWI
	 R8TJlGuLvJ8rw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 07/13] selftests: mptcp: add mptcp_lib_print_test_counter
Date: Sun, 25 Feb 2024 21:03:55 +0800
Message-Id: <2a4cf49beb3327717f2dbcba38a693879893fbd6.1708866087.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708866087.git.tanggeliang@kylinos.cn>
References: <cover.1708866087.git.tanggeliang@kylinos.cn>
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
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 6 ++----
 tools/testing/selftests/net/mptcp/mptcp_lib.sh  | 9 +++++++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 8e8977031fa0..abd5fb4704d1 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -48,7 +48,7 @@ declare -A all_tests
 declare -a only_tests_ids
 declare -a only_tests_names
 declare -A failed_tests
-TEST_COUNT=0
+TEST_COUNT=1
 TEST_NAME=""
 nr_blank=6
 
@@ -172,7 +172,7 @@ cleanup()
 
 print_title()
 {
-	printf "%03u %s\n" "${TEST_COUNT}" "${TEST_NAME}"
+	mptcp_lib_print_test_counter TEST_COUNT "%s\n" "${TEST_NAME}" 3
 }
 
 print_check()
@@ -268,8 +268,6 @@ reset()
 
 	TEST_NAME="${1}"
 
-	TEST_COUNT=$((TEST_COUNT+1))
-
 	if skip_test; then
 		last_test_ignored=1
 		return 1
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 7e309493eda2..630fecb942e4 100644
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
+	printf "%0${digit}u ${fmt}" "$((counter++))" "${msg}"
+}
-- 
2.40.1

