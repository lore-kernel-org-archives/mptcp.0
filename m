Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEAF204F85
	for <mptcp@lists.linux.dev>; Sun, 23 Feb 2025 14:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740320841; cv=none; b=jIppcArLtS/1toktCYBeTmF7QpU0hR4RjVzs51uoNJpLhqsj4h4inftGugG5+ECEhHOmC7iu2ZxEjT5gEacYOuXrHraHPl7vkPPV3OEI2BSwbte6s9O1x9via8xOqAqsW4YoJF0lKBkV00CgrjcrKrZTGTMQwpIOF8DGd68cImQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740320841; c=relaxed/simple;
	bh=6tJXIO1uBlnJtX4cdl4ZPNu21fXkU7RaqColePmyvfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/o9BiC1U2dm/W5TShlt9DCtHEDdpl2Bw72UZ/0N5QNzHxCpGF4BrYSp8wUWDRRaX7DRe3E7UvQz2FRVesoibB9k4TtKkNlMkYpPw+YBkjVOOI9ferhOGii4Yfne4vmXUtkSC77PkxOwPkIhummNzezNvoHniGhVs9ZRZ4vcPVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxCbzMYq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxCbzMYq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CBCC4CEDD;
	Sun, 23 Feb 2025 14:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740320841;
	bh=6tJXIO1uBlnJtX4cdl4ZPNu21fXkU7RaqColePmyvfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZxCbzMYqbQP6lojB/ITSuNSaKy0PfkmwLn6sNZK0nTL2SbiQLbzUjXRZBaUOyeMLK
	 GhksyK0SXZVcZ3N4vr3LHAANIMWMOEC0gvpUDTBGVDS7Oo23nhbTJnjo3PR/mtIos2
	 p6/tMo/OoHz0OAze5Ie6ExxE3XHK56ezrkwd5RFO8CWBciKnqo2h2Z3BAc/Jq2+pKK
	 1a2bXsDA8+XYZ4ldOE29dKPhaiQqiW6DWmb2nlJUa2vKq7zfOAlzTNEq+TKdRGpyxC
	 dRQV2T6WBaVJaDBDe5oxF2k9X7SyFuEsbLQxAiFP/BT2VVHGplmSKDbCDcAW0fUoLg
	 uII3SIGSwgmDQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 13/13] selftests/mptcp: use path_manager instead of pm_type
Date: Sun, 23 Feb 2025 22:26:18 +0800
Message-ID: <b94e2a3b16486315acd2fa31cde3830a98573d5d.1740320007.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740320007.git.tanggeliang@kylinos.cn>
References: <cover.1740320007.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch uses the newly added net.mptcp.path_manager instead of the
old net.mptcp.pm_type for all path manager selftests in mptcp_join.sh
and userspace_pm.sh.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 26 +++++++++----------
 .../selftests/net/mptcp/userspace_pm.sh       |  4 +--
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 13a3b68181ee..ed04e7dedf23 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -99,7 +99,7 @@ init_partial()
 
 	local netns
 	for netns in "$ns1" "$ns2"; do
-		ip netns exec $netns sysctl -q net.mptcp.pm_type=0 2>/dev/null || true
+		ip netns exec $netns sysctl -q net.mptcp.path_manager="in-kernel" 2>/dev/null || true
 		if $checksum; then
 			ip netns exec $netns sysctl -q net.mptcp.checksum_enabled=1
 		fi
@@ -1920,7 +1920,7 @@ set_userspace_pm()
 {
 	local ns=$1
 
-	ip netns exec $ns sysctl -q net.mptcp.pm_type=1
+	ip netns exec $ns sysctl -q net.mptcp.path_manager="userspace"
 }
 
 subflows_tests()
@@ -3497,7 +3497,7 @@ userspace_tests()
 {
 	# userspace pm type prevents add_addr
 	if reset "userspace pm type prevents add_addr" &&
-	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/path_manager'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
@@ -3509,7 +3509,7 @@ userspace_tests()
 
 	# userspace pm type does not echo add_addr without daemon
 	if reset "userspace pm no echo w/o daemon" &&
-	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/path_manager'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
@@ -3521,7 +3521,7 @@ userspace_tests()
 
 	# userspace pm type rejects join
 	if reset "userspace pm type rejects join" &&
-	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/path_manager'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
@@ -3532,7 +3532,7 @@ userspace_tests()
 
 	# userspace pm type does not send join
 	if reset "userspace pm type does not send join" &&
-	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/path_manager'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
@@ -3543,7 +3543,7 @@ userspace_tests()
 
 	# userspace pm type prevents mp_prio
 	if reset "userspace pm type prevents mp_prio" &&
-	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/path_manager'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
@@ -3556,7 +3556,7 @@ userspace_tests()
 
 	# userspace pm type prevents rm_addr
 	if reset "userspace pm type prevents rm_addr" &&
-	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/path_manager'; then
 		set_userspace_pm $ns1
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
@@ -3570,7 +3570,7 @@ userspace_tests()
 
 	# userspace pm add & remove address
 	if reset_with_events "userspace pm add & remove address" &&
-	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/path_manager'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 2 2
 		{ speed=5 \
@@ -3603,7 +3603,7 @@ userspace_tests()
 
 	# userspace pm create destroy subflow
 	if reset_with_events "userspace pm create destroy subflow" &&
-	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/path_manager'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
 		{ speed=5 \
@@ -3631,7 +3631,7 @@ userspace_tests()
 
 	# userspace pm create id 0 subflow
 	if reset_with_events "userspace pm create id 0 subflow" &&
-	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/path_manager'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
 		{ speed=5 \
@@ -3652,7 +3652,7 @@ userspace_tests()
 
 	# userspace pm remove initial subflow
 	if reset_with_events "userspace pm remove initial subflow" &&
-	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/path_manager'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
 		{ speed=5 \
@@ -3676,7 +3676,7 @@ userspace_tests()
 
 	# userspace pm send RM_ADDR for ID 0
 	if reset_with_events "userspace pm send RM_ADDR for ID 0" &&
-	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/path_manager'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 1 1
 		{ speed=5 \
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 3651f73451cf..dfeec8d4aecf 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -13,7 +13,7 @@
 mptcp_lib_check_mptcp
 mptcp_lib_check_kallsyms
 
-if ! mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+if ! mptcp_lib_has_file '/proc/sys/net/mptcp/path_manager'; then
 	echo "userspace pm tests are not supported by the kernel: SKIP"
 	exit ${KSFT_SKIP}
 fi
@@ -119,7 +119,7 @@ trap cleanup EXIT
 # Create and configure network namespaces for testing
 mptcp_lib_ns_init ns1 ns2
 for i in "$ns1" "$ns2" ;do
-	ip netns exec "$i" sysctl -q net.mptcp.pm_type=1
+	ip netns exec "$i" sysctl -q net.mptcp.path_manager="userspace"
 done
 
 #  "$ns1"              ns2
-- 
2.43.0

