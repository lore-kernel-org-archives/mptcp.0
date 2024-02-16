Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D101B812
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 09:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077062; cv=none; b=OY0/UiAj7chO75s3h1DKQZuC1R9ZfsyC5gZfUsvT5IudWjV11nMquTlhg4OuuttsYoAxjgJ6GlbW0ig3wmT7em5pcWjMSETsp401JCxWqlUAM1zkL+odvzTDugV/nxMR2PavZc8gksMrYPCglku05oEcVNV9qJznt4FslB7qCjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077062; c=relaxed/simple;
	bh=ztSOL3yuAiBglsCt/oJFcG/XW3eHsvPR15R7sR8PpG8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ErWD26N7rqbhfJY6TLjddV8uTeIvNaq39+sxQb7Gde7xkoJ/Uih8rJkq5ScL2D8EvcH6XvWrJjDtFgQOYQCYC91xBARRs2cEzf0HuCByUI52lPD/W4GI3PJBpJwfr37W7CRgrGRoJGMQy3Q602ipcIghpp8IF1yx7GFW8TUpqlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WzRMTEz8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WzRMTEz8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C78C433F1;
	Fri, 16 Feb 2024 09:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708077062;
	bh=ztSOL3yuAiBglsCt/oJFcG/XW3eHsvPR15R7sR8PpG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WzRMTEz8REohS0jGEMk0XVGaYCkodUdyEGHH5M0TJ7KLdquL0H2wABi6D5OLbnwzb
	 ZdVPbd+hNGAbTfOPzICqqOHUj5rri+1RZryLNvcQ3ZR/clwO5jzAShS1fxPc7TjioE
	 yzPmnKlov5wVncUbHa8iZFrp7NuXEDlgr77J8fRJ2vYxuBov/WN9rGVL3iOlVFcjhN
	 UClfWE0aJ6Djvy9hmmeftBDW222z0pOvNB1jw0YfRIxnuPkL1TiPPO3Nl6SQgNM6Cq
	 GhCHHvHwBqppWuyIhpM2KbUp5WEoCDwcDJRi8flayCjjslbq87Aoicf046ppiOIKEQ
	 yU3y2m9QdwxYA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 7/7] selftests: mptcp: add mptcp_lib_check_tools helper
Date: Fri, 16 Feb 2024 17:50:35 +0800
Message-Id: <f7ca03a3e2d9b8c8a49e9226d88b40c935875e14.1708076886.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708076886.git.tanggeliang@kylinos.cn>
References: <cover.1708076886.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch exports check_tools() helper from mptcp_join.sh into
mptcp_lib.sh as a public one mptcp_lib_check_tools(). The arguments
"ip", "ss", and "iptables" are passed into this helper to indicate
whether to check ip tool, ss tool and iptables tools.

This helper can be used in every scripts.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/diag.sh     | 13 +--------
 .../selftests/net/mptcp/mptcp_connect.sh      | 14 +--------
 .../testing/selftests/net/mptcp/mptcp_join.sh | 26 +----------------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 29 +++++++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 22 +-------------
 .../testing/selftests/net/mptcp/pm_netlink.sh |  8 +----
 .../selftests/net/mptcp/simult_flows.sh       |  8 +----
 .../selftests/net/mptcp/userspace_pm.sh       |  8 +----
 8 files changed, 36 insertions(+), 92 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 8573326d326a..7c68160ad3b9 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -33,18 +33,7 @@ cleanup()
 	ip netns del $ns
 }
 
-mptcp_lib_check_mptcp
-
-ip -Version > /dev/null 2>&1
-if [ $? -ne 0 ];then
-	echo "SKIP: Could not run test without ip tool"
-	exit $ksft_skip
-fi
-ss -h | grep -q MPTCP
-if [ $? -ne 0 ];then
-	echo "SKIP: ss tool does not support MPTCP"
-	exit $ksft_skip
-fi
+mptcp_lib_check_tools "ip" "ss"
 
 get_msk_inuse()
 {
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index eb811d257cab..6c846db4243f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -145,19 +145,7 @@ cleanup()
 	done
 }
 
-mptcp_lib_check_mptcp
-mptcp_lib_check_kallsyms
-
-ip -Version > /dev/null 2>&1
-if [ $? -ne 0 ];then
-	echo "SKIP: Could not run test without ip tool"
-	exit $ksft_skip
-fi
-
-if ! ss -h | grep -q MPTCP; then
-	echo "SKIP: ss tool does not support MPTCP"
-	exit $ksft_skip
-fi
+mptcp_lib_check_tools "ip" "ss"
 
 sin=$(mktemp)
 sout=$(mktemp)
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 34a8d5ab185c..644740d7d988 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -149,34 +149,10 @@ cleanup_partial()
 	done
 }
 
-check_tools()
-{
-	mptcp_lib_check_mptcp
-	mptcp_lib_check_kallsyms
-
-	if ! ip -Version &> /dev/null; then
-		echo "SKIP: Could not run test without ip tool"
-		exit $ksft_skip
-	fi
-
-	if ! ss -h | grep -q MPTCP; then
-		echo "SKIP: ss tool does not support MPTCP"
-		exit $ksft_skip
-	fi
-
-	if ! iptables -V &> /dev/null; then
-		echo "SKIP: Could not run all tests without iptables tool"
-		exit $ksft_skip
-	elif ! ip6tables -V &> /dev/null; then
-		echo "SKIP: Could not run all tests without ip6tables tool"
-		exit $ksft_skip
-	fi
-}
-
 init() {
 	init=1
 
-	check_tools
+	mptcp_lib_check_tools "ip" "ss" "iptables"
 
 	sin=$(mktemp)
 	sout=$(mktemp)
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 108a1e12436c..cdb8948749eb 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -319,3 +319,32 @@ mptcp_lib_wait_local_port_listen() {
 		sleep 0.1
 	done
 }
+
+mptcp_lib_check_tools() {
+	mptcp_lib_check_mptcp
+	mptcp_lib_check_kallsyms
+
+	if [ "${1:-""}" == "ip" ]; then
+		if ! ip -Version &> /dev/null; then
+			mptcp_lib_print_warn "SKIP: Could not run test without ip tool"
+			exit ${KSFT_SKIP}
+		fi
+	fi
+
+	if [ "${2:-""}" == "ss" ]; then
+		if ! ss -h | grep -q MPTCP; then
+			mptcp_lib_print_warn "SKIP: ss tool does not support MPTCP"
+			exit ${KSFT_SKIP}
+		fi
+	fi
+
+	if [ "${3:-""}" == "iptables" ]; then
+		if ! iptables -V &> /dev/null; then
+			mptcp_lib_print_warn "SKIP: Could not run all tests without iptables tool"
+			exit ${KSFT_SKIP}
+		elif ! ip6tables -V &> /dev/null; then
+			mptcp_lib_print_warn "SKIP: Could not run all tests without ip6tables tool"
+			exit ${KSFT_SKIP}
+		fi
+	fi
+}
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 988042912c7a..8b6dd6e919c8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -85,27 +85,7 @@ cleanup()
 	rm -f "$sin" "$sout"
 }
 
-mptcp_lib_check_mptcp
-mptcp_lib_check_kallsyms
-
-ip -Version > /dev/null 2>&1
-if [ $? -ne 0 ];then
-	echo "SKIP: Could not run test without ip tool"
-	exit $ksft_skip
-fi
-
-if ! ss -h | grep -q MPTCP; then
-	echo "SKIP: ss tool does not support MPTCP"
-	exit $ksft_skip
-fi
-
-if ! iptables -V &> /dev/null; then
-	echo "SKIP: Could not run all tests without iptables tool"
-	exit $ksft_skip
-elif ! ip6tables -V &> /dev/null; then
-	echo "SKIP: Could not run all tests without ip6tables tool"
-	exit $ksft_skip
-fi
+mptcp_lib_check_tools "ip" "ss" "iptables"
 
 check_mark()
 {
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index ebfefae71e13..e7ab5eca3e75 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -35,13 +35,7 @@ cleanup()
 	ip netns del $ns1
 }
 
-mptcp_lib_check_mptcp
-
-ip -Version > /dev/null 2>&1
-if [ $? -ne 0 ];then
-	echo "SKIP: Could not run test without ip tool"
-	exit $ksft_skip
-fi
+mptcp_lib_check_tools "ip"
 
 trap cleanup EXIT
 
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index e6e5b933a1b9..053f40bf25c1 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -42,13 +42,7 @@ cleanup()
 	done
 }
 
-mptcp_lib_check_mptcp
-
-ip -Version > /dev/null 2>&1
-if [ $? -ne 0 ];then
-	echo "SKIP: Could not run test without ip tool"
-	exit $ksft_skip
-fi
+mptcp_lib_check_tools "ip"
 
 #  "$ns1"              ns2                    ns3
 #     ns1eth1    ns2eth1   ns2eth3      ns3eth1
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 1b94a75604fe..9d42fb9bc809 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -10,19 +10,13 @@
 
 . "$(dirname "${0}")/mptcp_lib.sh"
 
-mptcp_lib_check_mptcp
-mptcp_lib_check_kallsyms
+mptcp_lib_check_tools "ip"
 
 if ! mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 	echo "userspace pm tests are not supported by the kernel: SKIP"
 	exit ${KSFT_SKIP}
 fi
 
-if ! ip -Version &> /dev/null; then
-	echo "SKIP: Cannot not run test without ip tool"
-	exit ${KSFT_SKIP}
-fi
-
 ANNOUNCED=6        # MPTCP_EVENT_ANNOUNCED
 REMOVED=7          # MPTCP_EVENT_REMOVED
 SUB_ESTABLISHED=10 # MPTCP_EVENT_SUB_ESTABLISHED
-- 
2.40.1

