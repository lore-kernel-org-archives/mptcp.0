Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0106714F6F
	for <mptcp@lists.linux.dev>; Tue,  5 Dec 2023 07:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BafdhKBl"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701759808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GLz6wMbXNShpx8cjlm//yAvOCQUXfEeS5C0ZVGN+4Vg=;
	b=BafdhKBlvZSH1TnfEZk/dNKak8NOhe9U+ArpSgh52tb8B0bMm+eL4L8EGW1RNT1/zwsqNR
	dEml3H1VO6g9xOeXdRuMpNbEuWyDE5GXP3LvokKw8L6H4P5lHaTfyOXGnRSVNPRLV3ZlmT
	nw3Gs2BQ0AaVHUOZshm3cMhWg0XoLUs=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v5 11/33] selftests: mptcp: add mptcp_lib_check_tools helper
Date: Tue,  5 Dec 2023 15:00:58 +0800
Message-Id: <9e9f67f2fabe76ac49feafb01011fc2bd1c0bf21.1701759405.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1701759405.git.geliang.tang@linux.dev>
References: <cover.1701759405.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch exports check_tools() helper from mptcp_join.sh into
mptcp_lib.sh as a public one mptcp_lib_check_tools(). The arguments
"ip", "ss", and "iptables" are passed into this helper to indicate
whether to check ip tool, ss tool and iptables tools.

This helper can be used in every scripts.

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 tools/testing/selftests/net/mptcp/diag.sh     | 13 +-----
 .../selftests/net/mptcp/mptcp_connect.sh      | 15 +------
 .../testing/selftests/net/mptcp/mptcp_join.sh | 33 +--------------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 40 +++++++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 29 +-------------
 .../testing/selftests/net/mptcp/pm_netlink.sh |  8 +---
 .../selftests/net/mptcp/simult_flows.sh       |  8 +---
 .../selftests/net/mptcp/userspace_pm.sh       |  8 +---
 8 files changed, 47 insertions(+), 107 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 3119811018fc..1c86183864d3 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -31,18 +31,7 @@ cleanup()
 	mptcp_lib_cleanup
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
index b554c2e9750e..cf9548e190b1 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -136,20 +136,7 @@ cleanup()
 	mptcp_lib_cleanup
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
-ss -h | grep -q MPTCP
-if [ $? -ne 0 ];then
-	echo "SKIP: ss tool does not support MPTCP"
-	exit $ksft_skip
-fi
+mptcp_lib_check_tools "ip" "ss"
 
 sin=$(mktemp)
 sout=$(mktemp)
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 57a9ea9db2ec..b5d149008d21 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -22,8 +22,6 @@ tmpfile=""
 cout=""
 capout=""
 ksft_skip=4
-iptables="iptables"
-ip6tables="ip6tables"
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 capture=0
@@ -131,39 +129,10 @@ cleanup_partial()
 	mptcp_lib_ns_exit
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
-	ss -h | grep -q MPTCP
-	if [ $? -ne 0 ];then
-		echo "SKIP: ss tool does not support MPTCP"
-		exit $ksft_skip
-	fi
-
-	# Use the legacy version if available to support old kernel versions
-	if iptables-legacy -V &> /dev/null; then
-		iptables="iptables-legacy"
-		ip6tables="ip6tables-legacy"
-	elif ! iptables -V &> /dev/null; then
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
index e8e1250e5ea6..491730cf24dc 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -514,6 +514,46 @@ mptcp_lib_ns_exit() {
 	done
 }
 
+iptables="iptables"
+ip6tables="ip6tables"
+
+mptcp_lib_check_tools() {
+	: "${iptables:?}"
+	: "${ip6tables:?}"
+
+	mptcp_lib_check_mptcp
+	mptcp_lib_check_kallsyms
+
+	if [ "${1:-""}" == "ip" ]; then
+		if ! ip -Version &> /dev/null; then
+			mptcp_lib_print_warn "SKIP: Could not run test without ip tool"
+			exit $ksft_skip
+		fi
+	fi
+
+	if [ "${2:-""}" == "ss" ]; then
+		ss -h | grep -q MPTCP
+		if [ $? -ne 0 ];then
+			mptcp_lib_print_warn "SKIP: ss tool does not support MPTCP"
+			exit $ksft_skip
+		fi
+	fi
+
+	if [ "${3:-""}" == "iptables" ]; then
+		# Use the legacy version if available to support old kernel versions
+		if iptables-legacy -V &> /dev/null; then
+			iptables="iptables-legacy"
+			ip6tables="ip6tables-legacy"
+		elif ! iptables -V &> /dev/null; then
+			mptcp_lib_print_warn "SKIP: Could not run all tests without iptables tool"
+			exit $ksft_skip
+		elif ! ip6tables -V &> /dev/null; then
+			mptcp_lib_print_warn "SKIP: Could not run all tests without ip6tables tool"
+			exit $ksft_skip
+		fi
+	fi
+}
+
 mptcp_lib_cleanup() {
 	: "${check_output_err:?}"
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 2c11cad6b607..2290b3290214 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -10,8 +10,6 @@ cout=""
 ksft_skip=4
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
-iptables="iptables"
-ip6tables="ip6tables"
 
 mptcp_lib_ns_init
 
@@ -76,32 +74,7 @@ cleanup()
 	mptcp_lib_cleanup
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
-ss -h | grep -q MPTCP
-if [ $? -ne 0 ];then
-	echo "SKIP: ss tool does not support MPTCP"
-	exit $ksft_skip
-fi
-
-# Use the legacy version if available to support old kernel versions
-if iptables-legacy -V &> /dev/null; then
-	iptables="iptables-legacy"
-	ip6tables="ip6tables-legacy"
-elif ! iptables -V &> /dev/null; then
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
index 8f99b138a59f..e8ecf292a38f 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -31,13 +31,7 @@ cleanup()
 	mptcp_lib_cleanup
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
index c1a21cd8c076..57180c2da605 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -29,13 +29,7 @@ cleanup()
 	mptcp_lib_cleanup
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
index 93f8b200ce49..50eda314ec2e 100755
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
 file=""
 client4_pid=0
 server4_pid=0
-- 
2.35.3

