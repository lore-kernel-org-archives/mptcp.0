Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBE912B148
	for <mptcp@lists.linux.dev>; Thu,  7 Mar 2024 12:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709815745; cv=none; b=i7SeNIO07S40rQ7wfSZm80txuqSUfx6datZ+7T11f3+wfsiSDz8tpv1F6WuxdzIMBBF0DXk2DXV7G9BXMr7H5TlSH3Tt+3zoPEh1Vq+yeqafFlze/U+LeIm3BayCNKTW/wSTuYqPFnhYDaTbucrKa+hcAJhm6IODTSXAzS6iSLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709815745; c=relaxed/simple;
	bh=rfBIY68F5T9/qnXPCXpsp5n6EsXadDbXJU8QcyqCjrc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CHm71gg1L2QeIQFo8eDF8Rmpkoz7VFfUKtjjdeetxjhlXKtmL/BCnFhb3hyE81lJYZugXSWlRQDEPFWsNoRMZ3u7A1Eb515Cef3SVejhKbJ3UNsBwx4yNFdjQFu9UCcPlUkXAYbfvN1aZrU+HXPM7Zqu9HfldMSyy3BcPRT8pfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgSSR3kV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgSSR3kV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89062C433F1;
	Thu,  7 Mar 2024 12:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709815744;
	bh=rfBIY68F5T9/qnXPCXpsp5n6EsXadDbXJU8QcyqCjrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cgSSR3kVK3IPeQ17/LPvNFXaB2ttnSc0FyuJtc8u7lGLEeIulub1IhUaer9YTyUDA
	 TWlrIaco3bT8jFYD0M9WBixLmMg17cuUf5QAgpglFTgm1bBw/kMt/lF2/JTYbTKyo3
	 QI+oa/HqTj0V0rfQletMyewvjwokz4SF1zWjdp+p4SPf31jXwsI8An2P9ijGA2W8/R
	 ZJx7HnX6jT5Hibkc/Iej6SRsjVat3IuBLOTMiSXsgZXL6WT+SjHAzD1W+mU/nXvsJw
	 dektF0t0bm72tJBhyXmxnrMHXvoBALmVN8AffASGgs5VkOK3NrK45ma4peF8DER5mQ
	 076ErA+i2fXCw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 4/5] selftests: mptcp: use KSFT_SKIP/KSFT_PASS/KSFT_FAIL
Date: Thu,  7 Mar 2024 20:48:43 +0800
Message-Id: <6f60ec8167e1ab3c5e542430871da60e7a6110ab.1709815545.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1709815545.git.tanggeliang@kylinos.cn>
References: <cover.1709815545.git.tanggeliang@kylinos.cn>
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
 .../testing/selftests/net/mptcp/pm_netlink.sh  |  8 ++++----
 .../selftests/net/mptcp/simult_flows.sh        |  4 ++--
 .../selftests/net/mptcp/userspace_pm.sh        |  8 ++++----
 6 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index cb1837f2761a..4c4248554826 100755
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
@@ -263,7 +263,7 @@ check_mptcp_disabled()
 	if [ "$(ip netns exec ${disabled_ns} sysctl net.mptcp.enabled | awk '{ print $3 }')" -ne 1 ]; then
 		mptcp_lib_pr_fail "net.mptcp.enabled sysctl is not 1 by default"
 		mptcp_lib_result_fail "net.mptcp.enabled sysctl is not 1 by default"
-		ret=1
+		ret=${KSFT_FAIL}
 		return 1
 	fi
 	ip netns exec ${disabled_ns} sysctl -q net.mptcp.enabled=0
@@ -276,7 +276,7 @@ check_mptcp_disabled()
 	if [ ${err} -eq 0 ]; then
 		mptcp_lib_pr_fail "New MPTCP socket cannot be blocked via sysctl"
 		mptcp_lib_result_fail "New MPTCP socket cannot be blocked via sysctl"
-		ret=1
+		ret=${KSFT_FAIL}
 		return 1
 	fi
 
@@ -302,7 +302,7 @@ do_ping()
 
 	if [ $rc -ne 0 ] ; then
 		mptcp_lib_pr_fail "$listener_ns -> $connect_addr connectivity"
-		ret=1
+		ret=${KSFT_FAIL}
 
 		return 1
 	fi
@@ -821,7 +821,7 @@ log_if_error()
 		mptcp_lib_pr_fail "${msg}"
 
 		final_ret=${ret}
-		ret=0
+		ret=${KSFT_PASS}
 
 		return ${final_ret}
 	fi
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 5f5be437b9c8..6d725419b7d4 100755
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
@@ -392,15 +391,15 @@ setup_fail_rules()
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
@@ -414,7 +413,7 @@ reset_with_fail()
 	local rc=0
 	setup_fail_rules "${@}" || rc=$?
 
-	if [ ${rc} -eq ${ksft_skip} ]; then
+	if [ ${rc} -eq ${KSFT_SKIP} ]; then
 		mark_as_skipped "unable to set the 'fail' rules"
 		return 1
 	fi
@@ -450,7 +449,7 @@ reset_with_tcp_filter()
 # $1: err msg
 fail_test()
 {
-	ret=1
+	ret=${KSFT_FAIL}
 
 	print_fail "${@}"
 
@@ -3633,7 +3632,7 @@ usage()
 {
 	if [ -n "${1}" ]; then
 		echo "${1}"
-		ret=1
+		ret=${KSFT_FAIL}
 	fi
 
 	echo "mptcp_join usage:"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 96aa8f71bbb0..e2d70c18786e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -105,7 +105,7 @@ check_mark()
 		if [ $v -ne 0 ]; then
 			mptcp_lib_pr_fail "got $tables $values in ns $ns," \
 					  "not 0 - not all expected packets marked"
-			ret=1
+			ret=${KSFT_FAIL}
 			return 1
 		fi
 	done
@@ -178,7 +178,7 @@ do_transfer()
 
 		mptcp_lib_result_fail "transfer ${ip}"
 
-		ret=1
+		ret=${KSFT_FAIL}
 		return 1
 	fi
 	if ! mptcp_lib_check_transfer $cin $sout "file received by server"; then
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 69ffff8b076b..6ab8c5d36340 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -19,11 +19,11 @@ while getopts "$optstring" option;do
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
@@ -57,13 +57,13 @@ check()
 	mptcp_lib_check_output "${err}" "${cmd}" "${expected}" || rc=${?}
 	if [ ${rc} -eq 2 ]; then
 		mptcp_lib_result_fail "${msg} # error ${rc}"
-		ret=1
+		ret=${KSFT_FAIL}
 	elif [ ${rc} -eq 0 ]; then
 		mptcp_lib_print_ok "[ OK ]"
 		mptcp_lib_result_pass "${msg}"
 	elif [ ${rc} -eq 1 ]; then
 		mptcp_lib_result_fail "${msg} # different output"
-		ret=1
+		ret=${KSFT_FAIL}
 	fi
 }
 
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 4ee18406ee50..68ee92eccccb 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -263,7 +263,7 @@ while getopts "bcdh" option;do
 	case "$option" in
 	"h")
 		usage $0
-		exit 0
+		exit ${KSFT_PASS}
 		;;
 	"b")
 		bail=1
@@ -276,7 +276,7 @@ while getopts "bcdh" option;do
 		;;
 	"?")
 		usage $0
-		exit 1
+		exit ${KSFT_FAIL}
 		;;
 	esac
 done
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 3ae215a46c86..9c017082f603 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -86,7 +86,7 @@ test_skip()
 test_fail()
 {
 	mptcp_lib_pr_fail "${@}"
-	ret=1
+	ret=${KSFT_FAIL}
 	mptcp_lib_result_fail "${test_name}"
 }
 
@@ -206,7 +206,7 @@ make_connection()
 	else
 		test_fail "Expected tokens (c:${client_token} - s:${server_token}) and server (c:${client_serverside} - s:${server_serverside})"
 		mptcp_lib_result_print_all_tap
-		exit 1
+		exit ${KSFT_FAIL}
 	fi
 
 	if [ "$is_v6" = "v6" ]
@@ -237,7 +237,7 @@ check_expected()
 		return 0
 	fi
 
-	ret=1
+	ret=${KSFT_FAIL}
 	mptcp_lib_result_fail "${test_name}"
 	return 1
 }
@@ -842,7 +842,7 @@ verify_listener_events()
 	if [ "${rc}" -eq 0 ]; then
 		test_pass
 	else
-		ret=1
+		ret=${KSFT_FAIL}
 		mptcp_lib_result_fail "${test_name}"
 	fi
 }
-- 
2.40.1

