Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5266714F6F
	for <mptcp@lists.linux.dev>; Tue,  5 Dec 2023 07:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f5806mYV"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701759843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+iwxa9D286ZuTLMPR6Fx1EUd0hdFS/00ofSgpIuACRI=;
	b=f5806mYVNbVIefaVx4DxWHot47XuNhUNXR0z5C+RrAa/PLJi8NFPAewlA0nW2Cw+sJRleh
	/7SDPu8kpEfTPT1ImJ3CqKhrVkh0zHwWjUfWlbHAc7P7lelXoR0A4sx+TwMDlNiAsbLVc5
	+qdMFDY60khx286f5xO7h6vv/KcQ6Wk=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v5 33/33] selftests: mptcp: use KSFT_PASS and KSFT_FAIL
Date: Tue,  5 Dec 2023 15:01:20 +0800
Message-Id: <8a55f86b68ba0fc9db5b3cdbfdba80390470b352.1701759405.git.geliang.tang@linux.dev>
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

Use KSFT_PASS and KSFT_FAIL macros instead of 0 and 1 after 'exit ' and
'ret=' in all scripts:

        exit 0 -> exit ${KSFT_PASS}
        exit 1 -> exit ${KSFT_FAIL}
         ret=0 ->  ret=${KSFT_PASS}
         ret=1 ->  ret=${KSFT_FAIL}

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 .../selftests/net/mptcp/mptcp_connect.sh       | 18 +++++++++---------
 .../testing/selftests/net/mptcp/mptcp_join.sh  |  4 ++--
 .../selftests/net/mptcp/mptcp_sockopt.sh       |  4 ++--
 .../testing/selftests/net/mptcp/pm_netlink.sh  |  4 ++--
 .../selftests/net/mptcp/simult_flows.sh        |  4 ++--
 .../selftests/net/mptcp/userspace_pm.sh        |  4 ++--
 6 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 32a979a40a72..a46bef3d4d1b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -51,14 +51,14 @@ while getopts "$optstring" option;do
 	case "$option" in
 	"h")
 		usage $0
-		exit 0
+		exit ${KSFT_PASS}
 		;;
 	"d")
 		if [ $OPTARG -ge 0 ];then
 			tc_delay="$OPTARG"
 		else
 			echo "-d requires numeric argument, got \"$OPTARG\"" 1>&2
-			exit 1
+			exit ${KSFT_FAIL}
 		fi
 		;;
 	"e")
@@ -82,7 +82,7 @@ while getopts "$optstring" option;do
 			sndbuf="$OPTARG"
 		else
 			echo "-S requires numeric argument, got \"$OPTARG\"" 1>&2
-			exit 1
+			exit ${KSFT_FAIL}
 		fi
 		;;
 	"R")
@@ -90,7 +90,7 @@ while getopts "$optstring" option;do
 			rcvbuf="$OPTARG"
 		else
 			echo "-R requires numeric argument, got \"$OPTARG\"" 1>&2
-			exit 1
+			exit ${KSFT_FAIL}
 		fi
 		;;
 	"m")
@@ -107,7 +107,7 @@ while getopts "$optstring" option;do
 		;;
 	"?")
 		usage $0
-		exit 1
+		exit ${KSFT_FAIL}
 		;;
 	esac
 done
@@ -230,7 +230,7 @@ check_mptcp_disabled()
 		echo -n -e "net.mptcp.enabled sysctl is not 1 by default\t\t"
 		mptcp_lib_print_err "\t\t   [ FAIL ]"
 		mptcp_lib_result_fail "net.mptcp.enabled sysctl is not 1 by default"
-		ret=1
+		ret=${KSFT_FAIL}
 		return 1
 	fi
 	ip netns exec ${disabled_ns} sysctl -q net.mptcp.enabled=0
@@ -244,7 +244,7 @@ check_mptcp_disabled()
 		echo -n -e "New MPTCP socket cannot be blocked via sysctl\t\t"
 		mptcp_lib_print_err "\t\t   [ FAIL ]"
 		mptcp_lib_result_fail "New MPTCP socket cannot be blocked via sysctl"
-		ret=1
+		ret=${KSFT_FAIL}
 		return 1
 	fi
 
@@ -271,7 +271,7 @@ do_ping()
 
 	if [ $rc -ne 0 ] ; then
 		echo "$listener_ns -> $connect_addr connectivity [ FAIL ]" 1>&2
-		ret=1
+		ret=${KSFT_FAIL}
 
 		return 1
 	fi
@@ -782,7 +782,7 @@ log_if_error()
 		echo "FAIL: ${msg}" 1>&2
 
 		final_ret=${ret}
-		ret=0
+		ret=${KSFT_PASS}
 
 		return ${final_ret}
 	fi
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 81521e4760ae..1243dd2305fe 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -427,7 +427,7 @@ reset_with_tcp_filter()
 # $1: err msg
 fail_test()
 {
-	ret=1
+	ret=${KSFT_FAIL}
 
 	print_fail "${@}"
 
@@ -3575,7 +3575,7 @@ usage()
 {
 	if [ -n "${1}" ]; then
 		echo "${1}"
-		ret=1
+		ret=${KSFT_FAIL}
 	fi
 
 	echo "mptcp_join usage:"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 75b9a6a5b5c4..f2e7b2575106 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -85,7 +85,7 @@ check_mark()
 	for v in $values; do
 		if [ $v -ne 0 ]; then
 			echo "FAIL: got $tables $values in ns $ns , not 0 - not all expected packets marked" 1>&2
-			ret=1
+			ret=${KSFT_FAIL}
 			return 1
 		fi
 	done
@@ -155,7 +155,7 @@ do_transfer()
 		mptcp_lib_print_err "[ FAIL ]"
 		mptcp_lib_result_fail "transfer ${ip}"
 
-		ret=1
+		ret=${KSFT_FAIL}
 		return 1
 	fi
 	mptcp_lib_print_ok "[ OK ]"
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 6ff0420b7ac1..dbf2dd435572 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -12,11 +12,11 @@ while getopts "$optstring" option;do
 	case "$option" in
 	"h")
 		usage $0
-		exit 0
+		exit ${KSFT_PASS}
 		;;
 	"?")
 		usage $0
-		exit 1
+		exit ${KSFT_FAIL}
 		;;
 	esac
 done
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index ecf29ce332c5..060b9ea23041 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -240,7 +240,7 @@ while getopts "bcdh" option;do
 	case "$option" in
 	"h")
 		usage $0
-		exit 0
+		exit ${KSFT_PASS}
 		;;
 	"b")
 		bail=1
@@ -253,7 +253,7 @@ while getopts "bcdh" option;do
 		;;
 	"?")
 		usage $0
-		exit 1
+		exit ${KSFT_FAIL}
 		;;
 	esac
 done
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index ec3a68233577..2c1afea1f376 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -70,7 +70,7 @@ test_skip()
 test_fail()
 {
 	mptcp_lib_print_err "[ FAIL ]${1:+ ${*}}"
-	ret=1
+	ret=${KSFT_FAIL}
 
 	if [ -n "${1}" ]; then
 		_printf "\t%s\n" "${1}"
@@ -194,7 +194,7 @@ make_connection()
 	else
 		test_fail "Expected tokens (c:${client_token} - s:${server_token}) and server (c:${client_serverside} - s:${server_serverside})"
 		mptcp_lib_result_print_all_tap
-		exit 1
+		exit ${KSFT_FAIL}
 	fi
 
 	if [ "$is_v6" = "v6" ]
-- 
2.35.3

