Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5CD1F03C1
	for <mptcp@lists.linux.dev>; Wed,  5 Mar 2025 11:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741172424; cv=none; b=h7LcgjaDRcEwER3fs19di3YTUi5xJj06rlK04Ep22xzslA6umOJZp7RhC7mj9fSVbvty9ajhm8IhjeTHZ5mFX2Jefir8cdGQ7CzFr2AzI7D5LxVATI217GpySF/VgTrDB3g2X1/aF7pwyZyYJVheRVEijTKw6AsdH0qi1yyrT1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741172424; c=relaxed/simple;
	bh=l8XTTzYZTexQuN0rQgrmnYxsaqNiFhSaahEvEc4TTkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BzMCr43Ys27u8W4iVP2adqeLxH3MZ/3/BtUMgfpOXmCucXPJzebHkNUIpQaY84sVE9BYw6rORImUPqzFKP+8oEeU3rXUM+ozJq2s+dKEhCBqNCcF+NBs3JksV8GFbKdbjHsDiS8DYRMtdSDSeqdRfa/vU07xz4eS4HcZkbKo2xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMGgcTUk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMGgcTUk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D9FC4CEE2;
	Wed,  5 Mar 2025 11:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741172423;
	bh=l8XTTzYZTexQuN0rQgrmnYxsaqNiFhSaahEvEc4TTkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OMGgcTUkfJNR90wcUDQ4kyYchEMv6AClrmu9myYQqed7eYUdu7iQzMp8Uem+04ZnF
	 3sQVyjyRSm2eAn2S9DiCrq4cinppoeNZdUfhAkxX2IC4T9R95iAGgaf6GAepR0dYUC
	 uu/bKG0oISEbQZqXdpmtM4Qhy60EkZ0pHNUeAdCd9Jzc8U1p71nivUv9rEKTAkJPuJ
	 3Sr76CleMpTrTAnGi7ea1McLKzaPIFJBebtLYC8lXaH0jCDBvCI3r90UfAxQXg+uCD
	 81hiOkqyo0CWuWHEDxgRvZ1+VGHAalBJhXd0wCLDtgBGY1G3Bik/ca/dtoL3PJGOEU
	 37pIdS2+GTwfg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 12/12] selftests: mptcp: add path_manager sysctl tests
Date: Wed,  5 Mar 2025 18:59:53 +0800
Message-ID: <bd0ba642385cdc3df7c1ff6415645c82b9da83b0.1741171898.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741171898.git.tanggeliang@kylinos.cn>
References: <cover.1741171898.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new helper set_path_manager() to set the newly added
net.mptcp.path_manager, and test it inside "userspace pm subflow" test.
Also check if old sysctl net.mptcp.pm_type is mapped successfully.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 34 ++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index c55f5d526769..c140860ab754 100755
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

