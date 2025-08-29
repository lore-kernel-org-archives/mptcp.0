Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7005643164
	for <mptcp@lists.linux.dev>; Fri, 29 Aug 2025 20:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756499635; cv=none; b=KocnLQ1qfkfIhO3NTxgiBFnljgskMU2rnnjlfcO+xra0mZRBuQLMuhYD/TyD6ldNj0p9pR0yEnozbEegMDPsvYv9NVTwmmBjhmVTJ3Ud+JxUr9rPUsPUAqRWMB3sS54UVWPczNN1YlfbDjQeacdbrdoAAQVqwI/bJtChnbB7AeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756499635; c=relaxed/simple;
	bh=g379lyf7TLQ/isY1EW3k/F/29wnqhKJr1yE63TgWuhs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MXrkfDtI7SZACwW4rb/K4wlozWu6qIrQYckf5znKUbZKsUcI0joTn2EyBt6F/7nF7W5Ti+wqRBUx+SZayaq/1htfZ9deRdtJfmQ+0HipBEjc8vs4fULm98cbzJIPDhwfz1L4lsPC9mJV4H/V07KBF59sHZ7fJRyQXKb3mmZ/DJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLdcrnnR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLdcrnnR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62E6C4CEF0;
	Fri, 29 Aug 2025 20:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756499635;
	bh=g379lyf7TLQ/isY1EW3k/F/29wnqhKJr1yE63TgWuhs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cLdcrnnRK7U1lC+h9IwALipYHLzriNr3nEo/X/XkezBal/wfQ0CI2Q0O7sNclWoxM
	 1LNYwn6TBPx2PDZwuV9b5InpX0rT6RkyFRGlTPhRyFnZzq4NF5v7BNbuy7a2oyUxgB
	 XNaJNTQ207KmtvIga1ZRqeSsECMNuP9qUYylILiylmRuuAPRqlTmJOet67sA6aoFpz
	 fVtIE188I8eDtKCGQUE7OkQUHLw4D/LlBYuWpymGhSxZ3lCuR1SQhrfU7uLkB57hM0
	 CWEG4TJmD6X4CG4QUFCAigzvuocy0t87m/yP5CvMiiFnPgBoUy5NUrXmv8RxSi60i7
	 wfK8Dq1Mq9slg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 29 Aug 2025 22:33:38 +0200
Subject: [PATCH mptcp-net 6/7] selftests: mptcp: shellcheck: support
 v0.11.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-mptcp-pm-user-c-flag-v1-6-78b25dda7708@kernel.org>
References: <20250829-mptcp-pm-user-c-flag-v1-0-78b25dda7708@kernel.org>
In-Reply-To: <20250829-mptcp-pm-user-c-flag-v1-0-78b25dda7708@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4986; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=g379lyf7TLQ/isY1EW3k/F/29wnqhKJr1yE63TgWuhs=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI28a1pelyxvyKL7bTMN/vizMqoQBHONN0PjpNDbmdvP
 5Cp1pbaUcrCIMbFICumyCLdFpk/83kVb4mXnwXMHFYmkCEMXJwCMJHzZowMS609n+Rntdw0FI/a
 MUN0Z0Tepr7Hb2xvHohWOMwQlz5FgOF/2qGfOzPPFzXl1HneEdXYvGLbztS63vyNq7b9yLr8t3I
 VPwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This v0.11.0 version introduces SC2329:

  Warn when (non-escaping) functions are never invoked.

Except that, similar to SC2317, ShellCheck is currently unable to figure
out functions that are invoked via trap, or indirectly, when calling
functions via variables. It is then needed to disable this new SC2329.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Note: I guess this patch is a good candidate for 'net'.
---
 tools/testing/selftests/net/mptcp/diag.sh          | 2 +-
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 2 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 2 +-
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 2 +-
 tools/testing/selftests/net/mptcp/pm_netlink.sh    | 5 +++--
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 2 +-
 tools/testing/selftests/net/mptcp/userspace_pm.sh  | 2 +-
 7 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 7a3cb4c09e450f0ae570015c4724ec268c6dc19f..d847ff1737c30c0eae1cefeb5a83bd3223897707 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -28,7 +28,7 @@ flush_pids()
 }
 
 # This function is used in the cleanup trap
-#shellcheck disable=SC2317
+#shellcheck disable=SC2317,SC2329
 cleanup()
 {
 	ip netns pids "${ns}" | xargs --no-run-if-empty kill -SIGKILL &>/dev/null
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 5e3c56253274a1f938d2ed9986c4290fcea8b96b..c2ab9f7f0d2133559bb18ce884b613d21d1ec5f0 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -134,7 +134,7 @@ ns4=""
 TEST_GROUP=""
 
 # This function is used in the cleanup trap
-#shellcheck disable=SC2317
+#shellcheck disable=SC2317,SC2329
 cleanup()
 {
 	rm -f "$cin_disconnect"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a97b568104bc284f050b2f0e09fe3fdd3341c5cb..f2133e247d8cbc17abd3c3563261068a65b56ad8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -8,7 +8,7 @@
 
 # ShellCheck incorrectly believes that most of the code here is unreachable
 # because it's invoked by variable name, see how the "tests" array is used
-#shellcheck disable=SC2317
+#shellcheck disable=SC2317,SC2329
 
 . "$(dirname "${0}")/mptcp_lib.sh"
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 418a903c3a4d396bd733bf8b6f68b1447d4d1de3..f01989be6e9b3daeecc5a8f41b37c9a284efef61 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -95,7 +95,7 @@ init()
 }
 
 # This function is used in the cleanup trap
-#shellcheck disable=SC2317
+#shellcheck disable=SC2317,SC2329
 cleanup()
 {
 	mptcp_lib_ns_exit "${ns1}" "${ns2}" "${ns_sbox}"
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index ac7ec6f9402376a34602ef1ca6c4822e8dde0ded..ec6a8758819194f2c53791d76ae68e088f188813 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -32,7 +32,7 @@ ns1=""
 err=$(mktemp)
 
 # This function is used in the cleanup trap
-#shellcheck disable=SC2317
+#shellcheck disable=SC2317,SC2329
 cleanup()
 {
 	rm -f "${err}"
@@ -70,8 +70,9 @@ format_endpoints() {
 	mptcp_lib_pm_nl_format_endpoints "${@}"
 }
 
+# This function is invoked indirectly
+#shellcheck disable=SC2317,SC2329
 get_endpoint() {
-	# shellcheck disable=SC2317 # invoked indirectly
 	mptcp_lib_pm_nl_get_endpoint "${ns1}" "${@}"
 }
 
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 2329c2f8519b7c336e9f90a705dfa7588207a543..1903e8e84a315175e2ffd620dd7b4e94dbf25dfb 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -35,7 +35,7 @@ usage() {
 }
 
 # This function is used in the cleanup trap
-#shellcheck disable=SC2317
+#shellcheck disable=SC2317,SC2329
 cleanup()
 {
 	rm -f "$cout" "$sout"
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 333064b0b5ac03ae003417d2070f3c08f94743ed..970c329735ff14f87f0048ba0030dc7edaaa86bc 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -94,7 +94,7 @@ test_fail()
 }
 
 # This function is used in the cleanup trap
-#shellcheck disable=SC2317
+#shellcheck disable=SC2317,SC2329
 cleanup()
 {
 	print_title "Cleanup"

-- 
2.50.1

