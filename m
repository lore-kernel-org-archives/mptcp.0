Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB641E4A4
	for <mptcp@lists.linux.dev>; Fri,  8 Mar 2024 05:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709877472; cv=none; b=sGDtkFRgX8uktQodFbgRypxrxApjzbQw7+aphvj1o54f3aIBGLYmy/Q2njGSBUj8GPcg1/8IDayiZs1ZfsvKTN0S8JpXjYuq8w/bvrRhsvJ+qXnMb5ysxK6BirzkbI8CnG4k5bntDkvw5XhATNtCM31v49wZgJopoveE/aEZnb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709877472; c=relaxed/simple;
	bh=ul1l5+lLFH9mjztpvqCfZRZM6zmYLJeXWgzMLeQGO0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q7Ee1bUKkRqV630Q7VPFHi6ndT4IlNrc6XJT7BSw+Qy28XOIk17U9eVlNx13jMVtxOyH/JUDN1HckcTfDmq/R1GdWKct//YN/uQ5CAZyrhHtwLYnwdpGDYrAB+nfSACw8tkne5JQ45cve3pD325IVZ4ndHBZRHkJmazUHESvx3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGVC3q6d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGVC3q6d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC19C433C7;
	Fri,  8 Mar 2024 05:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709877472;
	bh=ul1l5+lLFH9mjztpvqCfZRZM6zmYLJeXWgzMLeQGO0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YGVC3q6daZipZV7iMSkZjI7l6s2uEfEiw7HXNB3KcizlpCSoQoSnBojjYdlEZPoXo
	 8yG9QXFQgAdWiQttj7KYOz1vgbab0sW2k1su4TPrw4mYDkdOqIpPffGKpd29u99FP4
	 ml2OWyp3Pg+xHZEl27lsL6R6rl0Z3W6BawJQT6rD9X+sOzS9OOiOhuXHfUKbxrC2ol
	 nFxHgUGnK2ceLZM5e9KF74Dsiub2fxzaBPvX70fBRzIjdjPgEDrICWELTotpF9j0Pn
	 /hsANObfvl/8XeIdL3w9HgWsBUUosS1OnW4z0F+ZTXYZPQtESub/Fg+ozKucmrw3LW
	 KXlAG8aYWctdw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 6/7] selftests: mptcp: use KSFT_SKIP/KSFT_PASS/KSFT_FAIL
Date: Fri,  8 Mar 2024 13:57:39 +0800
Message-Id: <da93c358ce28e335ee84557f712d867e14bd726a.1709876991.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1709876991.git.tanggeliang@kylinos.cn>
References: <cover.1709876991.git.tanggeliang@kylinos.cn>
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
 .../selftests/net/mptcp/userspace_pm.sh        |  4 ++--
 6 files changed, 25 insertions(+), 26 deletions(-)

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
index fc301789a8b5..140d80289b51 100755
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
 
 	if [ ${#} -gt 0 ]; then
 		print_fail "${@}"
@@ -3632,7 +3631,7 @@ usage()
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
index 72dca742280f..9e2981f2d7f5 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -89,7 +89,7 @@ test_fail()
 	then
 		mptcp_lib_pr_fail "${@}"
 	fi
-	ret=1
+	ret=${KSFT_FAIL}
 	mptcp_lib_result_fail "${test_name}"
 }
 
@@ -209,7 +209,7 @@ make_connection()
 	else
 		test_fail "Expected tokens (c:${client_token} - s:${server_token}) and server (c:${client_serverside} - s:${server_serverside})"
 		mptcp_lib_result_print_all_tap
-		exit 1
+		exit ${KSFT_FAIL}
 	fi
 
 	if [ "$is_v6" = "v6" ]
-- 
2.40.1

