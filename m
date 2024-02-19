Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F8825574
	for <mptcp@lists.linux.dev>; Mon, 19 Feb 2024 09:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708334279; cv=none; b=aMhGllOu8I1uljGPzzfbcy5vj/veKAnGBJ4RSk8XZ1IbhGf6okQ6RVjtUIwaX8Ut9QWWDuv8tT8U9eTkVBP+JrkcKXHm1sZtMe8kATqN8gIc6xNW7UqR66hg6iF6Zz2MW3EB1xBRIGekaT5uFKGVShkXRhZ6te6irF3bc8Uxe2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708334279; c=relaxed/simple;
	bh=Hc5RxExOYLLpL8ViR3FDzIYUbv86TEHLNux6ELkZYPc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WPzjgcRlugF+ngxDvdy4OikyOi2flCt7THirEI0hWyIqHdtJC3fiZsEphccrRtjKX+O4lbIuBL8whpQihw6L5nketwckIqaR9LDMa9QySImt3q2Rss2q285UMe/KkPJOXIS4qMK0Q7UYYdVnhfKeoXSUk+oLiRH5VCIr+ymBdEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHmo6bmC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHmo6bmC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAEE3C433C7;
	Mon, 19 Feb 2024 09:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708334279;
	bh=Hc5RxExOYLLpL8ViR3FDzIYUbv86TEHLNux6ELkZYPc=;
	h=From:To:Cc:Subject:Date:From;
	b=SHmo6bmCAAWffYw9Gpq+Cyuq+pMG12cWYp1J7jMSTi42DmH4tgv5lBvSvH8qYpCgV
	 x+R8LaymVVdL3HskeYiOcda1wO1G06HLBmHsLg44rs260HsAkdcQI4sHSiiYepaPBU
	 6f6dZkdOpx6LWhSe+WgmSV7ycPh5c2N83Im5uwdCTYvQcxcww+B9cZXE4iy4PK98Us
	 /Eb+H7zz04HHiTc5ugRaY/ibzuSZvUH5KxTuVZbKANOireXyl4RssHcqwwWm25xvK3
	 07IOLVEikGveN2yDvUGZQ3HohqpN/JUqxD64Fj+s4T7s7oz6v/do++Py6aCIxxVFBI
	 lnOsm1i+5+Vqg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4] selftests: mptcp: add mptcp_lib_check_tools helper
Date: Mon, 19 Feb 2024 17:17:50 +0800
Message-Id: <82ff7dbbf5ba256c707e3863ebbcbdc71179de3a.1708334189.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
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
"ip", "ss", "iptables" and "ip6tables" are passed into this helper
to indicate whether to check ip tool, ss tool, iptables and ip6tables
tools.

This helper can be used in every scripts.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 v4:
 - update this patch as Matt suggested.
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
index d797b27b7626..a8d08554efc9 100755
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
+	mptcp_lib_check_tools ip ss "${iptables}" "${ip6tables}"
 
 	sin=$(mktemp)
 	sout=$(mktemp)
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 108a1e12436c..6d9a2af85a8d 100644
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
+				mptcp_lib_print_warn "SKIP: Could not run all tests without ${tool}"
+				exit ${KSFT_SKIP}
+			fi
+			;;
+		*)
+			mptcp_lib_print_err "Internal error: unsupported tool: ${tool}"
+			exit ${KSFT_FAIL}
+			;;
+		esac
+	done
+}
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index dac8e1fc7143..fd7de1b3dc55 100755
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
+mptcp_lib_check_tools ip "${iptables}" "${ip6tables}"
 
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

