Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC61A5FEF9
	for <mptcp@lists.linux.dev>; Tue, 20 Feb 2024 09:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708423125; cv=none; b=X+/Gp23rysvLgpvMDtnLOwdOTEkvAbUXeqSu/EXQVa5Hhppkg9rRXMSksFa7T9occgi7oTRbSCBbUD1nKvyJamzBy9ji0uJnihqoMpGWs/EmlEq8/qkH50+FzfAfA5Hiv7oEN8YB6Xd7cQrlHaLyxWYZoh/HBmpPDb3t25JeZhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708423125; c=relaxed/simple;
	bh=0CgG4IkiNx47pqID/6b2tO72Om8asP5GeTaPgH6uU3k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GU520Zk1cXm9TaaQTCXjcmA2JUaaP9P8hN4SzXdRzeDnK0fmU2ytqukBEX6TspV/sOX5H3iOyZRQAJlnNg3WFmi+RCNN74ismr223n538DfToE001BTdon3KNjlEXsM6m0N0VqoTV+Zme/5MbSrm0tIgyEdXyyzRRxKv4Ka/m+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PaSQgiNe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PaSQgiNe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA356C433F1;
	Tue, 20 Feb 2024 09:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708423124;
	bh=0CgG4IkiNx47pqID/6b2tO72Om8asP5GeTaPgH6uU3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PaSQgiNe/PIhgDYO3KZzwr5bakYJ3NMd73JZEvbSs20v1ASKrNyU7flfxbJfjmkA4
	 L4m1WZiZTdPDbRGpAk/1PVoidBBmtoYEPEF7QprGLDuZ2aVQy0gDD856Bufyabpg49
	 xsc1UFSgI6g3wUtpV7jYsq1KyNxIo9ri7PXNHydatfTWuOVpVveKU+T3Xj1kEOFXj/
	 vgoNscABWG3M60QZRxC+x16Vu+86iwlS3OcL2Hau/Dh+S0e7+CF3PjN4LvMG6DZRry
	 jypNeseAGjxUYZtKByvccHvEykQ10BFRkfQEmlrwN1m3lfpDZrAdB+GIxUDLOKoCnY
	 7kxtdDSpihpVg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v14 08/14] selftests: mptcp: add mptcp_lib_check_output helper
Date: Tue, 20 Feb 2024 17:58:22 +0800
Message-Id: <33bd2ab5bf6cc62d94e618761dcc731338029b08.1708422758.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708422758.git.tanggeliang@kylinos.cn>
References: <cover.1708422758.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Extract the main part of check() in pm_netlink.sh into a new helper
named mptcp_lib_check_output in mptcp_lib.sh.

This helper will be used for userspace dump addresses tests.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 19 +++++++++++++++++++
 .../testing/selftests/net/mptcp/pm_netlink.sh | 18 +++++++-----------
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 6d9a2af85a8d..aca35376006b 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -350,3 +350,22 @@ mptcp_lib_check_tools() {
 		esac
 	done
 }
+
+mptcp_lib_check_output() {
+	local err="$1"
+	local cmd="$2"
+	local expected="$3"
+	local cmd_ret=0
+	local out=$(${cmd} 2>${err}) || cmd_ret=${?}
+
+	if [ $cmd_ret -ne 0 ]; then
+		mptcp_lib_print_err "[FAIL] command execution '$cmd' stderr"
+		cat "${err}"
+		return 2
+	elif [ "$out" = "$expected" ]; then
+		return 0
+	else
+		mptcp_lib_print_err "[FAIL] expected '$expected' got '$out'"
+		return 1
+	fi
+}
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index cb6ea67e688b..1ec9d8622fc9 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -49,21 +49,17 @@ check()
 	local cmd="$1"
 	local expected="$2"
 	local msg="$3"
-	local out=`$cmd 2>$err`
-	local cmd_ret=$?
+	local rc=0
 
 	printf "%-50s" "$msg"
-	if [ $cmd_ret -ne 0 ]; then
-		echo "[FAIL] command execution '$cmd' stderr "
-		cat $err
-		mptcp_lib_result_fail "${msg} # error ${cmd_ret}"
+	mptcp_lib_check_output "${err}" "${cmd}" "${expected}" || rc=${?}
+	if [ ${rc} -eq 2 ]; then
+		mptcp_lib_result_fail "${msg} # error ${rc}"
 		ret=1
-	elif [ "$out" = "$expected" ]; then
-		echo "[ OK ]"
+	elif [ ${rc} -eq 0 ]; then
+		mptcp_lib_print_ok "[ OK ]"
 		mptcp_lib_result_pass "${msg}"
-	else
-		echo -n "[FAIL] "
-		echo "expected '$expected' got '$out'"
+	elif [ ${rc} -eq 1 ]; then
 		mptcp_lib_result_fail "${msg} # different output"
 		ret=1
 	fi
-- 
2.40.1

