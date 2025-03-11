Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6DD360
	for <mptcp@lists.linux.dev>; Tue, 11 Mar 2025 06:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741675611; cv=none; b=nU8xyLOB0ypyNSZQNrh7Knq5pQxXtoyOza2Zigup2YpZQ7voXwix8USQ2LG5Ocozyo4Dm/vBRoYjNgjrRCKaYhjWc/dNDotR8IoZg5wwHiiN9Nonf8c98e7qtJGarNrQCnCm4ey8qMPB+KiNgaDOoZnVqzGDcvodtmd4ecsSUBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741675611; c=relaxed/simple;
	bh=A2X00gCDQP/wlsCXvloDMCCwZxgxiwZc0BgKClX01Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WA2EnudWGkNFGhzINzOGLqkGr95Z9YLwBvaBYjafzfprCeaNEsEXLUiWv30JC2H+ItsZEhI5DunjAxzokZT7SF9OsmeNXHKMv6It9qnBpcZ5Qd1buKAW2btKnoi1BCx7RO/iO+/7BQFaqAWMy6TiGZ6u9NShjqnlxAaqyDsA8iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3i+JeFw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3i+JeFw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE03C4CEE9;
	Tue, 11 Mar 2025 06:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741675610;
	bh=A2X00gCDQP/wlsCXvloDMCCwZxgxiwZc0BgKClX01Fc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M3i+JeFwMEFxpjrGa+xhKCOvBSHYLlEJg76wlHkt/2zeVxVIwEUQOV2V8g2l0wZNB
	 BUMAGW5R0mj4CB6FM5G5hygN/d+LLvWwUCC3l3a08Ma9MoBcIVCnVkpQq16eqw2oke
	 vuxWDyLQJeWrKgF76oPE3Cu7SexYdjPFwDAjfmnHjMUzCIoDWsRbveZPgBkBB6AUAx
	 iP+HjSFsV4rVC5TCAzpI2C45pohL+lP209qeo77RNwYkifCxhPP5eJsU22g4cBs3gI
	 LoKsANWuOU6K4JcqgKpb+Us+6yvK2tMYV0lNaEHLOKVenyZq4ICWlqPZgLWQSjnyCh
	 iMF0b1c2Mi/Mw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH RESEND mptcp-next v11 10/10] selftests: mptcp: add pm sysctl mapping tests
Date: Tue, 11 Mar 2025 14:46:27 +0800
Message-ID: <a3bad00d1a9525a8cd26b02c3a4875d13b142845.1741674285.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741674285.git.tanggeliang@kylinos.cn>
References: <cover.1741674285.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20250311064627.LYaT1L204xviQplWmY-9E9uhUYYZF-UlTMBV43ozMCg@z>

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch checks if the newly added net.mptcp.path_manager is mapped
successfully from or to the old net.mptcp.pm_type in userspace_pm.sh.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/userspace_pm.sh       | 30 ++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 3651f73451cf..333064b0b5ac 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -117,7 +117,36 @@ cleanup()
 trap cleanup EXIT
 
 # Create and configure network namespaces for testing
+print_title "Init"
 mptcp_lib_ns_init ns1 ns2
+
+# check path_manager and pm_type sysctl mapping
+if [ -f /proc/sys/net/mptcp/path_manager ]; then
+	ip netns exec "$ns1" sysctl -q net.mptcp.path_manager=userspace
+	pm_type="$(ip netns exec "$ns1" sysctl -n net.mptcp.pm_type)"
+	if [ "${pm_type}" != "1" ]; then
+		test_fail "unexpected pm_type: ${pm_type}"
+		mptcp_lib_result_print_all_tap
+		exit ${KSFT_FAIL}
+	fi
+
+	ip netns exec "$ns1" sysctl -q net.mptcp.path_manager=error 2>/dev/null
+	pm_type="$(ip netns exec "$ns1" sysctl -n net.mptcp.pm_type)"
+	if [ "${pm_type}" != "1" ]; then
+		test_fail "unexpected pm_type after error: ${pm_type}"
+		mptcp_lib_result_print_all_tap
+		exit ${KSFT_FAIL}
+	fi
+
+	ip netns exec "$ns1" sysctl -q net.mptcp.pm_type=0
+	pm_name="$(ip netns exec "$ns1" sysctl -n net.mptcp.path_manager)"
+	if [ "${pm_name}" != "kernel" ]; then
+		test_fail "unexpected path-manager: ${pm_name}"
+		mptcp_lib_result_print_all_tap
+		exit ${KSFT_FAIL}
+	fi
+fi
+
 for i in "$ns1" "$ns2" ;do
 	ip netns exec "$i" sysctl -q net.mptcp.pm_type=1
 done
@@ -152,7 +181,6 @@ mptcp_lib_events "${ns1}" "${server_evts}" server_evts_pid
 sleep 0.5
 mptcp_lib_subtests_last_ts_reset
 
-print_title "Init"
 print_test "Created network namespaces ns1, ns2"
 test_pass
 
-- 
2.43.0

