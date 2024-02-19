Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BBB21A02
	for <mptcp@lists.linux.dev>; Mon, 19 Feb 2024 08:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708330943; cv=none; b=jnBHxO8SlMfI8+W6vJiEgRxBU7WYxY2HDX+qUJEKyqTSHhPRAK2jsjGEKBXEqE7nBg57kqku+LtZOu/9hA2Yj5DKGZq3bFyDkjPP/MyczDJLeVgxv+ZeOnhQlU3s57low6+u4uFOalMKaJTFoPFCkytnSaI97Ct3Qgy8V+xF1/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708330943; c=relaxed/simple;
	bh=/x3GkWx2GP+H9JT2Hj8rjMhztPvSfb/QAFsXiNjn/H8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VoY5JvffAsX8zeoTs21d6RrDe30PTn/bbXV1gfAn3hmGmRpebHbitQVuB3kjsS4NxKsN5M3L+JFPsY3txYAkar1gqmLb+yk8fEG+Vn7kom4Mv5m4EWaYJeogW9ojXi6ad18Nsb3pF5pMRVdFtGXPZr2MgAqdt0smfv9YDVdedIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pV1hxh1h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pV1hxh1h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E342FC433F1;
	Mon, 19 Feb 2024 08:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708330943;
	bh=/x3GkWx2GP+H9JT2Hj8rjMhztPvSfb/QAFsXiNjn/H8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pV1hxh1hX+COuKDYvVVaoAHhzl5WwUzr1JXIvMdIbLOvhvlE/iRNdEhkkNvbJ7EN6
	 TBtgXkFWZd3SRClH1ThVvQRg31ZMlyt6k2fDPVwC/8QaPajuHBBj0V8BUxUIQ/kt6u
	 fmrRu1kCiL16HsTLSjFDLao5IDqqv9shikr4aRE9Z3W/tsXNm7sqdTtQBovT23H6xp
	 zmaDgY1Atp6Xm23ivP7H+22YaFqDit6S3N+MwIY5/aPQMvvsdBF+/1Os0+5yLhckyR
	 LjsjLqNeOhWO2miADWlcaQd6Opi8cJrcDjdpQU2CbEAKKsCJK3IXvbJpfoxk6Sebpb
	 FUkyhwdEQXLeQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 2/2] selftests: mptcp: add mptcp_lib_check_tools helper
Date: Mon, 19 Feb 2024 16:22:12 +0800
Message-Id: <428122f8879686b24852d3e46850b9e3538afb99.1708330720.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708330720.git.tanggeliang@kylinos.cn>
References: <cover.1708330720.git.tanggeliang@kylinos.cn>
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
 tools/testing/selftests/net/mptcp/diag.sh     | 12 +------
 .../selftests/net/mptcp/mptcp_connect.sh      |  7 +----
 .../testing/selftests/net/mptcp/mptcp_join.sh | 28 ++---------------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 31 +++++++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 15 +--------
 .../testing/selftests/net/mptcp/pm_netlink.sh |  7 +----
 .../selftests/net/mptcp/simult_flows.sh       |  7 +----
 .../selftests/net/mptcp/userspace_pm.sh       |  6 +---
 8 files changed, 40 insertions(+), 73 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 8573326d326a..60a7009ce1b5 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -34,17 +34,7 @@ cleanup()
 }
 
 mptcp_lib_check_mptcp
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
+mptcp_lib_check_tools ip ss
 
 get_msk_inuse()
 {
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 7898d62fce0b..ea52110c3fbc 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -147,12 +147,7 @@ cleanup()
 
 mptcp_lib_check_mptcp
 mptcp_lib_check_kallsyms
-
-ip -Version > /dev/null 2>&1
-if [ $? -ne 0 ];then
-	echo "SKIP: Could not run test without ip tool"
-	exit $ksft_skip
-fi
+mptcp_lib_check_tools ip
 
 sin=$(mktemp)
 sout=$(mktemp)
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index d797b27b7626..d9df6eb6a52a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -152,34 +152,12 @@ cleanup_partial()
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
-	if ! "${iptables}" -V &> /dev/null; then
-		echo "SKIP: Could not run all tests without ${iptables} tool"
-		exit $ksft_skip
-	elif ! "${ip6tables}" -V &> /dev/null; then
-		echo "SKIP: Could not run all tests without ${ip6tables} tool"
-		exit $ksft_skip
-	fi
-}
-
 init() {
 	init=1
 
-	check_tools
+	mptcp_lib_check_mptcp
+	mptcp_lib_check_kallsyms
+	mptcp_lib_check_tools ip ss iptables
 
 	sin=$(mktemp)
 	sout=$(mktemp)
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 108a1e12436c..b92c5278730b 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -319,3 +319,34 @@ mptcp_lib_wait_local_port_listen() {
 		sleep 0.1
 	done
 }
+
+mptcp_lib_check_tools() {
+	local tool
+
+	for tool in "${@}"; do
+		case "${tool}" in
+		"ip")
+			if ! ip -Version &> /dev/null; then
+				mptcp_lib_print_warn "SKIP: Could not run test without ip tool"
+				exit ${KSFT_SKIP}
+			fi
+			;;
+		"ss")
+			if ! ss -h | grep -q MPTCP; then
+				mptcp_lib_print_warn "SKIP: ss tool does not support MPTCP"
+				exit ${KSFT_SKIP}
+			fi
+			;;
+		"iptables"* | "ip6tables"*)
+			if ! "${tool}" -V &> /dev/null; then
+				mptcp_lib_print_warn "SKIP: Could not run all tests without ${tool} tool"
+				exit ${KSFT_SKIP}
+			fi
+			;;
+		*)
+			mptcp_lib_print_warn "Unsupported tool: ${tool}"
+			exit ${KSFT_SKIP}
+			;;
+		esac
+	done
+}
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index dac8e1fc7143..edb71f44be45 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -89,20 +89,7 @@ cleanup()
 
 mptcp_lib_check_mptcp
 mptcp_lib_check_kallsyms
-
-ip -Version > /dev/null 2>&1
-if [ $? -ne 0 ];then
-	echo "SKIP: Could not run test without ip tool"
-	exit $ksft_skip
-fi
-
-if ! "${iptables}" -V &> /dev/null; then
-	echo "SKIP: Could not run all tests without ${iptables} tool"
-	exit $ksft_skip
-elif ! "${ip6tables}" -V &> /dev/null; then
-	echo "SKIP: Could not run all tests without ${ip6tables} tool"
-	exit $ksft_skip
-fi
+mptcp_lib_check_tools ip iptables
 
 check_mark()
 {
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index ebfefae71e13..cb6ea67e688b 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -36,12 +36,7 @@ cleanup()
 }
 
 mptcp_lib_check_mptcp
-
-ip -Version > /dev/null 2>&1
-if [ $? -ne 0 ];then
-	echo "SKIP: Could not run test without ip tool"
-	exit $ksft_skip
-fi
+mptcp_lib_check_tools ip
 
 trap cleanup EXIT
 
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index e6e5b933a1b9..7d8388ecc966 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -43,12 +43,7 @@ cleanup()
 }
 
 mptcp_lib_check_mptcp
-
-ip -Version > /dev/null 2>&1
-if [ $? -ne 0 ];then
-	echo "SKIP: Could not run test without ip tool"
-	exit $ksft_skip
-fi
+mptcp_lib_check_tools ip
 
 #  "$ns1"              ns2                    ns3
 #     ns1eth1    ns2eth1   ns2eth3      ns3eth1
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 1b94a75604fe..629fc5d0ecc5 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -17,11 +17,7 @@ if ! mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 	echo "userspace pm tests are not supported by the kernel: SKIP"
 	exit ${KSFT_SKIP}
 fi
-
-if ! ip -Version &> /dev/null; then
-	echo "SKIP: Cannot not run test without ip tool"
-	exit ${KSFT_SKIP}
-fi
+mptcp_lib_check_tools ip
 
 ANNOUNCED=6        # MPTCP_EVENT_ANNOUNCED
 REMOVED=7          # MPTCP_EVENT_REMOVED
-- 
2.40.1

