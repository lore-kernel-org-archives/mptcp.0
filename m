Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1769F1FCD00
	for <mptcp@lists.linux.dev>; Tue,  4 Mar 2025 11:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741088467; cv=none; b=HxLd4kjKBng477wFU8c0e/ZoPcjCToBPIOSqqPNDMBSp0zqovzEPKx1Q7tjbTf+pwwjDt2G7oP0R6Ahm6hHjQYHoNFxUZKwI6TjKLnZc9m6a3DUUhaTA7GwbBjDqZ6vKt/3r5a0Ps5Ix8aMb8wUuNGfKPuAzf1IW6Jstc9uCClM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741088467; c=relaxed/simple;
	bh=sbUWC9SquLlleHoOdk86wuTG+zOwj14mSkxTPeXU8fU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GORpeBiL9i/U+38akPTjQkY/GaDhJXmkbBoiq1aLuE1DDxSUurE5wj9I2Hai2LUUIYt0zxD3g0f1UFL/ulctFqGqgBq9rDL7Icus57J1GSwsQu0M68ZIXwEmI+iL3a4tx5mFHStE2NdTGChcHwr/SULRLtfUbMvoBJkW0QDCYTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qj+x2wvY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qj+x2wvY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E55FEC4CEE5;
	Tue,  4 Mar 2025 11:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741088466;
	bh=sbUWC9SquLlleHoOdk86wuTG+zOwj14mSkxTPeXU8fU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qj+x2wvYX7zwfuLB/cG2Clqg7AMNqj95TIeL9P1CKJoIFCfJG49mSWm1lNnPzqVJT
	 X1xe30paTLOrCQ/G6SEdvWi30D1Pa7xEP9DscEz2NQOu6rwXPfJ4sVgNGKuLh7pb6q
	 g9DHPswdfLNBsmCRhZMiP/2dE8Gf4+RQIT/7gbJ9emZhwK/WtB9NSACORVQPinIUyh
	 Ot4CZKlmqGeJFu9B0XRi2Lwuwi7DqAe4LTOIH8/GcCt3GMg6xK0S66Md0KsVyN0Xeg
	 t421SDN38Zdjevi7g1RxHtYMCn/Kv1L94YJg+RjOPLjIsL/DG0QoPbA8d8CBp8dp5q
	 VRuv5TjiE44Gw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 12/12] selftests: mptcp: add path_manager sysctl test
Date: Tue,  4 Mar 2025 19:40:39 +0800
Message-ID: <bd2c57de226d1f36f7d9388f50442f32fb300154.1741088339.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741088339.git.tanggeliang@kylinos.cn>
References: <cover.1741088339.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new helper set_path_manager() to set the newly added
net.mptcp.path_manager, and test it inside a userspace pm test.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 34 ++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index fa1929ca6ad4..3b43b42f9abe 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -91,6 +91,19 @@ CBPF_MPTCP_SUBOPTION_ADD_ADDR="14,
 			       6 0 0 65535,
 			       6 0 0 0"
 
+set_path_manager()
+{
+	local ns=$1
+	local pm=$2
+
+	if ! ip netns exec ${ns} sysctl net.mptcp.available_path_managers |
+	     grep -wq "${pm}"; then
+		mptcp_lib_pr_fail "path manager ${pm} not found"
+		return 1
+	fi
+	ip netns exec ${ns} sysctl -q net.mptcp.path_manager="${pm}"
+}
+
 init_partial()
 {
 	capout=$(mktemp)
@@ -3619,7 +3632,26 @@ userspace_tests()
 	# userspace pm create destroy subflow
 	if reset_with_events "userspace pm create destroy subflow" &&
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
-		set_userspace_pm $ns2
+		if continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/path_manager'; then
+			local pm1 pm2
+
+			set_path_manager $ns1 "kernel"
+			set_path_manager $ns2 "userspace"
+
+			pm1=$(ip netns exec ${ns1} sysctl -n net.mptcp.pm_type)
+			if [ "$pm1" != "0" ]; then
+				mptcp_lib_pr_fail "ns1 pm_type mapping fails"
+				return 1
+			fi
+
+			pm2=$(ip netns exec ${ns2} sysctl -n net.mptcp.pm_type)
+			if [ "$pm2" != "1" ]; then
+				mptcp_lib_pr_fail "ns2 pm_type mapping fails"
+				return 1
+			fi
+		else
+			set_userspace_pm $ns2
+		fi
 		pm_nl_set_limits $ns1 0 1
 		{ speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
-- 
2.43.0

