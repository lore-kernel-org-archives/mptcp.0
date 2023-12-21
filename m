Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C046BB32
	for <mptcp@lists.linux.dev>; Thu, 21 Dec 2023 11:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hOOcn1WJ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703158417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=56wQj/pyy8i5F0vAWCKD/4TA5hNwr4AdvST/4FhwG/I=;
	b=hOOcn1WJJ6daqfA5UzmeQs1vnfuNMDDHmsmesgPcfnYXsaWx0EbbM0LEuqqSubsypaGYVr
	yslCwNrmBun8llkK0hIIcF9mkgysyKvSZqAfQTtei7r9FUaG9IrGY7tE/WgiT7scsF5Wlg
	jL9ebJ7v5GxF63q72UFDNMhFGdiG4Ik=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v6 13/15] selftests: mptcp: add mptcp_lib_check_tools helper
Date: Thu, 21 Dec 2023 19:31:16 +0800
Message-Id: <bac75f931a9ab8cdcb820fe1e6863fe1c9df4835.1703158128.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1703158128.git.geliang.tang@linux.dev>
References: <cover.1703158128.git.geliang.tang@linux.dev>
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
index 984a4f3b359b..1424769d292b 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -30,18 +30,7 @@ cleanup()
 	mptcp_lib_ns_exit
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
index c5456066ef55..c64f0038daef 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -135,20 +135,7 @@ cleanup()
 	mptcp_lib_ns_exit
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
index ee514d056f0d..8b52ed5c15b2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -23,8 +23,6 @@ cout=""
 check_output_err=""
 capout=""
 ksft_skip=4
-iptables="iptables"
-ip6tables="ip6tables"
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 capture=0
@@ -132,39 +130,10 @@ cleanup_partial()
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
index 2ff69d073a0f..90e2864391cf 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -485,3 +485,43 @@ mptcp_lib_ns_exit() {
 		rm -f /tmp/$netns.{nstat,out}
 	done
 }
+
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
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 760a024e5b14..3ab7eb695af3 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -10,8 +10,6 @@ cout=""
 ksft_skip=4
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
-iptables="iptables"
-ip6tables="ip6tables"
 
 mptcp_lib_ns_init
 
@@ -75,32 +73,7 @@ cleanup()
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
index 5208492d1f01..684c532c2f35 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -32,13 +32,7 @@ cleanup()
 	mptcp_lib_ns_exit
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
index 8925d94926ee..fb68fc79fd07 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -28,13 +28,7 @@ cleanup()
 	mptcp_lib_ns_exit
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
index 3a9e2a69eb6d..bae3377b6afe 100755
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

