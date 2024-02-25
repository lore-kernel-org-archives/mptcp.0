Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8D2DDDA
	for <mptcp@lists.linux.dev>; Sun, 25 Feb 2024 13:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708866266; cv=none; b=uS3xO6iOAumJeOrZXVSbZGzSo9eNSRe8rwjSunayuqkkq1APXkVgZ81tx4ttyDsi9ayn7YFWWhMcU3Jfr5QHf37oFj/f/dRT8hJWl0FO/cVcBUC3mtf9g0w3KhYTocikU7U2jPIZl4NN87YOUkqGOz7A16mVopK8UovljWIQ5dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708866266; c=relaxed/simple;
	bh=A77LoFKQPcYYGpDJROrFX/2KFGUgjzW7DYcgC4PTqcM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r7PHvoDB33iFf7czdkOkyt+P+fYP0P8KpdatqxEfmUtTS+njTnPAQlsRrTakMXwa6jqYPjg7kfByZEnb9bYWAa4gWv8K+n7nbzY7UC8DGOtfOzJerP7VkBh5DkvqAd+fJ9vNhY0jkBmDc5LH9UHxMcBCXqQrIhQg2R3kixm2Dcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DynygQfk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DynygQfk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E07C433F1;
	Sun, 25 Feb 2024 13:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708866266;
	bh=A77LoFKQPcYYGpDJROrFX/2KFGUgjzW7DYcgC4PTqcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DynygQfk+FwAwdffxnV9yqvI7djRgu5I7QzB8Q3C5U1fD1M14BEd02OAWGgz8ErmB
	 dXudLEVLe1NzfrkT0gptAtJjFrwG+bY83VelFDh19uYN+NywD7dvmzlerXolbXwTh2
	 XiBqcgC+To5tL8b2Ip9tdi5/GjSGIVUn6TGBAaUJ/kMNAFFiYkajXiz7xNC4nenLaY
	 0xDGYnDdsKDFnID22OGFati9UvvljexOtxQbU+ymvpwAZHxSUft2HPfJEOe2mgMBg+
	 iyQLNPkLbPMjkmIfD2Vb4rOq6Se0sclMAJE6pGMWJDfEomjDfPsdUVCVyatZNgznoW
	 T8was2SpDArfA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 13/13] selftests: mptcp: use KSFT_SKIP/KSFT_PASS/KSFT_FAIL
Date: Sun, 25 Feb 2024 21:04:01 +0800
Message-Id: <53f87e57c38fe571ca2d41bdf7a225357a6d05ad.1708866087.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708866087.git.tanggeliang@kylinos.cn>
References: <cover.1708866087.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch uses the public var KSFT_SKIP in mptcp_lib.sh instead of
ksft_skip, and drop 'ksft_skip=4' in mptcp_join.sh.

Use KSFT_PASS and KSFT_FAIL macros instead of 0 and 1 after 'exit '
and 'ret=' in all scripts:

        exit 0 -> exit ${KSFT_PASS}
        exit 1 -> exit ${KSFT_FAIL}
         ret=0 ->  ret=${KSFT_PASS}
         ret=1 ->  ret=${KSFT_FAIL}

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_connect.sh       | 18 +++++++++---------
 .../testing/selftests/net/mptcp/mptcp_join.sh  | 13 ++++++-------
 .../selftests/net/mptcp/mptcp_sockopt.sh       |  4 ++--
 .../testing/selftests/net/mptcp/pm_netlink.sh  |  4 ++--
 .../selftests/net/mptcp/simult_flows.sh        |  4 ++--
 .../selftests/net/mptcp/userspace_pm.sh        |  4 ++--
 6 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index a3316590b989..3aefa269c921 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -65,14 +65,14 @@ while getopts "$optstring" option;do
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
@@ -96,7 +96,7 @@ while getopts "$optstring" option;do
 			sndbuf="$OPTARG"
 		else
 			echo "-S requires numeric argument, got \"$OPTARG\"" 1>&2
-			exit 1
+			exit ${KSFT_FAIL}
 		fi
 		;;
 	"R")
@@ -104,7 +104,7 @@ while getopts "$optstring" option;do
 			rcvbuf="$OPTARG"
 		else
 			echo "-R requires numeric argument, got \"$OPTARG\"" 1>&2
-			exit 1
+			exit ${KSFT_FAIL}
 		fi
 		;;
 	"m")
@@ -121,7 +121,7 @@ while getopts "$optstring" option;do
 		;;
 	"?")
 		usage $0
-		exit 1
+		exit ${KSFT_FAIL}
 		;;
 	esac
 done
@@ -260,7 +260,7 @@ check_mptcp_disabled()
 			"net.mptcp.enabled sysctl is not 1 by default"
 		mptcp_lib_print_err "\t\t\t\t   [FAIL]"
 		mptcp_lib_result_fail "net.mptcp.enabled sysctl is not 1 by default"
-		ret=1
+		ret=${KSFT_FAIL}
 		return 1
 	fi
 	ip netns exec ${disabled_ns} sysctl -q net.mptcp.enabled=0
@@ -275,7 +275,7 @@ check_mptcp_disabled()
 			"New MPTCP socket cannot be blocked via sysctl"
 		mptcp_lib_print_err "\t\t\t\t   [FAIL]"
 		mptcp_lib_result_fail "New MPTCP socket cannot be blocked via sysctl"
-		ret=1
+		ret=${KSFT_FAIL}
 		return 1
 	fi
 
@@ -303,7 +303,7 @@ do_ping()
 
 	if [ $rc -ne 0 ] ; then
 		echo "$listener_ns -> $connect_addr connectivity [FAIL]" 1>&2
-		ret=1
+		ret=${KSFT_FAIL}
 
 		return 1
 	fi
@@ -823,7 +823,7 @@ log_if_error()
 		echo "FAIL: ${msg}" 1>&2
 
 		final_ret=${ret}
-		ret=0
+		ret=${KSFT_PASS}
 
 		return ${final_ret}
 	fi
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 71d345f15209..27119f5288a8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -25,7 +25,6 @@ err=""
 capout=""
 ns1=""
 ns2=""
-ksft_skip=4
 iptables="iptables"
 ip6tables="ip6tables"
 timeout_poll=30
@@ -396,15 +395,15 @@ setup_fail_rules()
 		-p tcp \
 		-m length --length 150:9999 \
 		-m statistic --mode nth --packet 1 --every 99999 \
-		-j MARK --set-mark 42 || return ${ksft_skip}
+		-j MARK --set-mark 42 || return ${KSFT_SKIP}
 
-	tc -n $ns2 qdisc add dev ns2eth$i clsact || return ${ksft_skip}
+	tc -n $ns2 qdisc add dev ns2eth$i clsact || return ${KSFT_SKIP}
 	tc -n $ns2 filter add dev ns2eth$i egress \
 		protocol ip prio 1000 \
 		handle 42 fw \
 		action pedit munge offset 148 u8 invert \
 		pipe csum tcp \
-		index 100 || return ${ksft_skip}
+		index 100 || return ${KSFT_SKIP}
 }
 
 reset_with_fail()
@@ -418,7 +417,7 @@ reset_with_fail()
 	local rc=0
 	setup_fail_rules "${@}" || rc=$?
 
-	if [ ${rc} -eq ${ksft_skip} ]; then
+	if [ ${rc} -eq ${KSFT_SKIP} ]; then
 		mark_as_skipped "unable to set the 'fail' rules"
 		return 1
 	fi
@@ -454,7 +453,7 @@ reset_with_tcp_filter()
 # $1: err msg
 fail_test()
 {
-	ret=1
+	ret=${KSFT_FAIL}
 
 	print_fail "${@}"
 
@@ -3637,7 +3636,7 @@ usage()
 {
 	if [ -n "${1}" ]; then
 		echo "${1}"
-		ret=1
+		ret=${KSFT_FAIL}
 	fi
 
 	echo "mptcp_join usage:"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 5943ec8145f9..ef26919f15b8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -106,7 +106,7 @@ check_mark()
 	for v in $values; do
 		if [ $v -ne 0 ]; then
 			echo "FAIL: got $tables $values in ns $ns , not 0 - not all expected packets marked" 1>&2
-			ret=1
+			ret=${KSFT_FAIL}
 			return 1
 		fi
 	done
@@ -175,7 +175,7 @@ do_transfer()
 		mptcp_lib_print_err "[FAIL]"
 		mptcp_lib_result_fail "transfer ${ip}"
 
-		ret=1
+		ret=${KSFT_FAIL}
 		return 1
 	fi
 	mptcp_lib_print_ok "[ OK ]"
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 435e1b0eb071..b50ad2d469b4 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -21,11 +21,11 @@ while getopts "$optstring" option;do
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
index d2be6a3c9c28..4607c074b632 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -262,7 +262,7 @@ while getopts "bcdh" option;do
 	case "$option" in
 	"h")
 		usage $0
-		exit 0
+		exit ${KSFT_PASS}
 		;;
 	"b")
 		bail=1
@@ -275,7 +275,7 @@ while getopts "bcdh" option;do
 		;;
 	"?")
 		usage $0
-		exit 1
+		exit ${KSFT_FAIL}
 		;;
 	esac
 done
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index b36c42a55f03..2cd197d47fff 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -79,7 +79,7 @@ test_skip()
 test_fail()
 {
 	mptcp_lib_print_err "[FAIL]${1:+ ${*}}"
-	ret=1
+	ret=${KSFT_FAIL}
 
 	if [ -n "${1}" ]; then
 		_printf "\t%s\n" "${1}"
@@ -204,7 +204,7 @@ make_connection()
 	else
 		test_fail "Expected tokens (c:${client_token} - s:${server_token}) and server (c:${client_serverside} - s:${server_serverside})"
 		mptcp_lib_result_print_all_tap
-		exit 1
+		exit ${KSFT_FAIL}
 	fi
 
 	if [ "$is_v6" = "v6" ]
-- 
2.40.1

