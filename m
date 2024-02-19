Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E87D23769
	for <mptcp@lists.linux.dev>; Mon, 19 Feb 2024 09:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708334995; cv=none; b=LJPlj6+Fc9xKny1t1sOvw4IVGjDlUE6UArqOId2VINW8cQESbJQ3hS26Ll5FzZi+rpkYZTdkTT6XBNzqOpbXrMPpXQNeCgKUPze5UULLUjO3YXQX36R2y5gtmfMxb7z8wGhaurRwRHmVrjfuG6+U6pGHrmkpXLb1EIpJo55lId4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708334995; c=relaxed/simple;
	bh=apje5hz9yQ+sRC9YLz9pz5+ymYo97pW1XfGRazAHmuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ch0dTvcnK2jDPozg6ubvM/Jffva8Gaj4Ewn6I2+0/B4J1am9AVmX6GteEh0lzN6T3DL20pvbVOLqqopBhsyCml5khCjRtRrsSHnAIy8z7XFPQWFgZLGD1isFSSxp01BEtXy/+YzmzF1FV9xC+irZrB0mxRAeuHZb9vUtjPg8rbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MU9ddtfZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MU9ddtfZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE23C433F1;
	Mon, 19 Feb 2024 09:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708334994;
	bh=apje5hz9yQ+sRC9YLz9pz5+ymYo97pW1XfGRazAHmuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MU9ddtfZ+zzLWikIvCxyBlPWD9yFh5vE88L8a2+ScXZZddP7plmBupDb/n6OcOSWl
	 GhMseO7n1KGqa4qVzHQYsEYCPxi/axgs6FuwBRK6X5iNJd8bMXyCQU8lRKsT4rfWRX
	 lxwsLFN9tAj9wSJnxYbFIzbJMknJ/uIFDBW4P67URDlvbYy7A5YM78OgDxMjb8OW+x
	 0AZtOodlMZkglrTviZKm1JDJNTVbSSyadrF69Go5ycIOYTGlbsAfZEmQ2B3NNC5wAZ
	 c0jQHbQsPv/mEErSmFEpHUomrm+/Kdj5TU34lez8ksqlh96ICtiyhej/DgKSc6aFLD
	 /6KKVCRT/lGZw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 4/5] selftests: mptcp: add mptcp_lib_check_output helper
Date: Mon, 19 Feb 2024 17:29:34 +0800
Message-Id: <c81e0a2cc5cc6bf7e717fde333adf3c3b2180c6e.1708334850.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708334850.git.tanggeliang@kylinos.cn>
References: <cover.1708334850.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Unify check_output() in mptcp_join.sh and check() in pm_netlink.sh into
a new public function mptcp_lib_check_output() in mptcp_lib.sh. And use
mptcp_lib_print_ok() and _err() in it to print test results with colors.

Use this new helper instead of check_output() and check().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 21 +-----------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 32 +++++++++++++++++++
 .../testing/selftests/net/mptcp/pm_netlink.sh | 24 ++++----------
 3 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ceaaf155cc32..f75d22dbb28d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -21,7 +21,6 @@ cinfail=""
 cinsent=""
 tmpfile=""
 cout=""
-check_output_err=""
 capout=""
 ksft_skip=4
 iptables="iptables"
@@ -151,7 +150,6 @@ init() {
 	cout=$(mktemp)
 	evts_ns1=$(mktemp)
 	evts_ns2=$(mktemp)
-	check_output_err=$(mktemp)
 
 	trap cleanup EXIT
 
@@ -165,7 +163,6 @@ cleanup()
 	rm -f "$sin" "$sout" "$cinsent" "$cinfail"
 	rm -f "$tmpfile"
 	rm -rf $evts_ns1 $evts_ns2
-	rm -f $check_output_err
 	mptcp_lib_cleanup
 	cleanup_partial
 }
@@ -3345,26 +3342,10 @@ userspace_pm_get_addr()
 
 check_output()
 {
-	local cmd="$1"
-	local expected="$2"
 	local msg="$3"
-	local out=`$cmd 2>$check_output_err`
-	local cmd_ret=$?
 
 	printf "%-42s" "$msg"
-	if [ $cmd_ret -ne 0 ]; then
-		mptcp_lib_print_err "[FAIL] command execution '$cmd' stderr "
-		cat $check_output_err
-		ret=${KSFT_FAIL}
-		return $cmd_ret
-	elif [ "$out" = "$expected" ]; then
-		mptcp_lib_print_ok "[ OK ]"
-		return 0
-	else
-		mptcp_lib_print_err "[FAIL] expected '$expected' got '$out'"
-		ret=${KSFT_FAIL}
-		return 1
-	fi
+	mptcp_lib_check_output "${1}" "${2}"
 }
 
 userspace_tests()
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 01b0e43eaa80..fd2ed3b5137c 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -410,6 +410,38 @@ mptcp_lib_ns_exit() {
 	done
 }
 
+check_output_err=$(mktemp)
+
+mptcp_lib_check_output() {
+	: "${check_output_err:?}"
+	: "${ret:?}"
+
+	local cmd="$1"
+	local expected="$2"
+	local out
+	local cmd_ret
+
+	out=$($cmd 2>"$check_output_err")
+	cmd_ret=$?
+
+	if [ $cmd_ret -ne 0 ]; then
+		mptcp_lib_print_err "[FAIL] command execution '$cmd' stderr "
+		cat "$check_output_err"
+		ret=${KSFT_FAIL}
+		return $cmd_ret
+	elif [ "$out" = "$expected" ]; then
+		mptcp_lib_print_ok "[ OK ]"
+		return 0
+	else
+		mptcp_lib_print_err "[FAIL] expected '$expected' got '$out'"
+		ret=${KSFT_FAIL}
+		return 1
+	fi
+}
+
 mptcp_lib_cleanup() {
+	: "${check_output_err:?}"
+
 	echo "cleanup"
+	rm -f "$check_output_err"
 }
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 5da9ccafc47e..eb3440d2620e 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -25,11 +25,9 @@ while getopts "$optstring" option;do
 done
 
 mptcp_lib_ns_init 1
-err=$(mktemp)
 
 cleanup()
 {
-	rm -f $err
 	mptcp_lib_ns_exit 1
 	mptcp_lib_cleanup
 }
@@ -43,26 +41,18 @@ ip netns exec $ns1 sysctl -q net.mptcp.enabled=1
 
 check()
 {
-	local cmd="$1"
-	local expected="$2"
 	local msg="$3"
-	local out=`$cmd 2>$err`
-	local cmd_ret=$?
 
 	printf "%-50s" "$msg"
-	if [ $cmd_ret -ne 0 ]; then
-		echo "[FAIL] command execution '$cmd' stderr "
-		cat $err
-		mptcp_lib_result_fail "${msg} # error ${cmd_ret}"
-		ret=1
-	elif [ "$out" = "$expected" ]; then
-		echo "[ OK ]"
+	# ${*} doesn't work here since there're spaces in some arguments.
+	mptcp_lib_check_output "${1}" "${2}"
+	local rc=$?
+	if [ ${rc} -eq 0 ]; then
 		mptcp_lib_result_pass "${msg}"
-	else
-		echo -n "[FAIL] "
-		echo "expected '$expected' got '$out'"
+	elif [ ${rc} -eq 1 ]; then
 		mptcp_lib_result_fail "${msg} # different output"
-		ret=1
+	else
+		mptcp_lib_result_fail "${msg} # error ${rc}"
 	fi
 }
 
-- 
2.40.1

