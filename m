Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A0922324
	for <mptcp@lists.linux.dev>; Thu, 21 Dec 2023 11:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OviV5rJn"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703158420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LHKZCMJUUj/YLyLqiwasaXRB8T18yVI9+zzSssaVs18=;
	b=OviV5rJnIr9ROqCoFR6jIq1ATn7uRIq+Jbl+lc3afGVXe6KxTPuoZMK1bp8SBvQND55pYi
	wizHOe+a5QumEgqYtw8U8IsWCKy5umFORXkgJPX1Ub3MvbgapnT7AxMs2DcY31s2Dl47g2
	Q992o7/9t151Ro8Juq3gQwT995rxOFE=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v6 15/15] selftests: mptcp: add mptcp_lib_check_output helper
Date: Thu, 21 Dec 2023 19:31:18 +0800
Message-Id: <6d41bb831a15469b0e051e437a7aeaf7c2a31e20.1703158128.git.geliang.tang@linux.dev>
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

Unify check_output() in mptcp_join.sh and check() in pm_netlink.sh into
a new public function mptcp_lib_check_output() in mptcp_lib.sh. And use
mptcp_lib_print_ok() and _err() in it to print test results with colors.

Use this new helper instead of check_output() and check().

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 43 ++++---------------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 31 +++++++++++++
 .../testing/selftests/net/mptcp/pm_netlink.sh | 29 ++++---------
 3 files changed, 47 insertions(+), 56 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 5972f1c23246..ee16ffcedd6b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -20,7 +20,6 @@ cinfail=""
 cinsent=""
 tmpfile=""
 cout=""
-check_output_err=""
 capout=""
 ksft_skip=4
 timeout_poll=30
@@ -141,7 +140,6 @@ init() {
 	cinsent=$(mktemp)
 	cout=$(mktemp)
 	mptcp_lib_evts_init
-	check_output_err=$(mktemp)
 
 	trap cleanup EXIT
 
@@ -155,7 +153,6 @@ cleanup()
 	rm -f "$sin" "$sout" "$cinsent" "$cinfail"
 	rm -f "$tmpfile"
 	mptcp_lib_evts_remove
-	rm -f $check_output_err
 	mptcp_lib_cleanup
 	cleanup_partial
 }
@@ -3303,30 +3300,6 @@ userspace_pm_get_addr()
 	ip netns exec $1 ./pm_nl_ctl get $2 token $tk
 }
 
-check_output()
-{
-	local cmd="$1"
-	local expected="$2"
-	local msg="$3"
-	local out=`$cmd 2>$check_output_err`
-	local cmd_ret=$?
-
-	printf "%-42s" "$msg"
-	if [ $cmd_ret -ne 0 ]; then
-		mptcp_lib_print_err "[ FAIL ] command execution '$cmd' stderr "
-		cat $check_output_err
-		ret=${KSFT_FAIL}
-		return $cmd_ret
-	elif [ "$out" = "$expected" ]; then
-		mptcp_lib_print_ok "[ OK ]"
-		return 0
-	else
-		mptcp_lib_print_err "[ FAIL ] expected '$expected' got '$out'"
-		ret=${KSFT_FAIL}
-		return 1
-	fi
-}
-
 userspace_tests()
 {
 	# userspace pm type prevents add_addr
@@ -3533,10 +3506,10 @@ userspace_tests()
 		chk_subflows_total 2 2
 		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
 		local dump="id 10 flags signal 10.0.2.1"
-		check_output "userspace_pm_get_addr $ns1 10" \
-			     "$dump" "      get id 10 addr"
-		check_output "userspace_pm_dump $ns1" \
-			     "$dump" "      dump addrs signal"
+		mptcp_lib_check_output "userspace_pm_get_addr $ns1 10" \
+				       "$dump" "      get id 10 addr"
+		mptcp_lib_check_output "userspace_pm_dump $ns1" \
+				       "$dump" "      dump addrs signal"
 		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
@@ -3557,10 +3530,10 @@ userspace_tests()
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
 		local dump="id 20 flags subflow 10.0.3.2"
-		check_output "userspace_pm_get_addr $ns2 20" \
-			     "$dump" "      get id 20 addr"
-		check_output "userspace_pm_dump $ns2" \
-			     "$dump" "      dump addrs subflow"
+		mptcp_lib_check_output "userspace_pm_get_addr $ns2 20" \
+				       "$dump" "      get id 20 addr"
+		mptcp_lib_check_output "userspace_pm_dump $ns2" \
+				       "$dump" "      dump addrs subflow"
 		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 540c35012041..162fd6922086 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -526,8 +526,39 @@ mptcp_lib_check_tools() {
 	fi
 }
 
+check_output_err=$(mktemp)
+
+mptcp_lib_check_output() {
+	: "${check_output_err:?}"
+	: "${ret:?}"
+
+	local cmd="$1"
+	local expected="$2"
+	local msg="$3"
+	local out=`$cmd 2>$check_output_err`
+	local cmd_ret=$?
+
+	printf "%-42s" "$msg"
+	if [ $cmd_ret -ne 0 ]; then
+		mptcp_lib_print_err "[ FAIL ] command execution '$cmd' stderr "
+		cat $check_output_err
+		ret=${KSFT_FAIL}
+		return $cmd_ret
+	elif [ "$out" = "$expected" ]; then
+		mptcp_lib_print_ok "[ OK ]"
+		return 0
+	else
+		mptcp_lib_print_err "[ FAIL ] expected '$expected' got '$out'"
+		ret=${KSFT_FAIL}
+		return 1
+	fi
+}
+
 mptcp_lib_cleanup() {
+	: "${check_output_err:?}"
+
 	echo "cleanup"
+	rm -f $check_output_err
 }
 
 echo -e "\n${KSFT_TEST}\n"
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 59d891300df5..e8ecf292a38f 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -24,11 +24,9 @@ while getopts "$optstring" option;do
 done
 
 mptcp_lib_ns_init
-err=$(mktemp)
 
 cleanup()
 {
-	rm -f $err
 	mptcp_lib_ns_exit
 	mptcp_lib_cleanup
 }
@@ -41,26 +39,15 @@ ip netns exec $ns1 sysctl -q net.mptcp.enabled=1
 
 check()
 {
-	local cmd="$1"
-	local expected="$2"
-	local msg="$3"
-	local out=`$cmd 2>$err`
-	local cmd_ret=$?
-
-	printf "%-50s" "$msg"
-	if [ $cmd_ret -ne 0 ]; then
-		echo "[FAIL] command execution '$cmd' stderr "
-		cat $err
-		mptcp_lib_result_fail "${msg} # error ${cmd_ret}"
-		ret=1
-	elif [ "$out" = "$expected" ]; then
-		echo "[ OK ]"
-		mptcp_lib_result_pass "${msg}"
+	# ${*} doesn't work here since there're spaces in some arguments.
+	mptcp_lib_check_output "${1}" "${2}" "${3}"
+	local rc=$?
+	if [ ${rc} -eq 0 ]; then
+		mptcp_lib_result_pass "${3}"
+	elif [ ${rc} -eq 1 ]; then
+		mptcp_lib_result_fail "${3} # different output"
 	else
-		echo -n "[FAIL] "
-		echo "expected '$expected' got '$out'"
-		mptcp_lib_result_fail "${msg} # different output"
-		ret=1
+		mptcp_lib_result_fail "${3} # error ${rc}"
 	fi
 }
 
-- 
2.35.3

