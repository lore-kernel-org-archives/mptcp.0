Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC59134A4
	for <mptcp@lists.linux.dev>; Fri,  8 Dec 2023 10:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R1KZo08N"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702030036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LP1C8/HImQQd6UwwwVrAuIEW6juQTxQcMv1BIo+r+Wk=;
	b=R1KZo08NRr+S/mraHlpsc7oIrPx0oSqcR8D3ik9UOTeTnVeJ2IR/FH9IGSYgcLGmtH3mS+
	gQIyGcZ4z60Jv55DPl2J9euhX412Ym/qyUaiA0mMNsK4BEYUCYL3FnSeNbQfi2Mf/jUrdX
	xynW1+Wc4d+LXR3TKq/AOERm7njMpsY=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v14 09/25] selftests: mptcp: dump userspace addrs list
Date: Fri,  8 Dec 2023 18:07:22 +0800
Message-Id: <aabd77eb7139500cff4fdca47910b2e80fb8d3af.1702029538.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1702029538.git.geliang.tang@linux.dev>
References: <cover.1702029538.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch tests newly added dump command for the userspace PM. Add
two new tests for userspace pm dump address and subflow. Use the
helpers userspace_pm_add_addr() and userspace_pm_add_sf() to add an
address and a suflow.

Similar to check() in pm_netlink.sh, add a new helper check_output()
in mptcp_join.sh to check the output of the given commands. Use it to
check the outputs of dump commands.

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 3cd066e6e2b0..16710e4b89d5 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -21,6 +21,7 @@ cinfail=""
 cinsent=""
 tmpfile=""
 cout=""
+check_output_err=""
 capout=""
 ns1=""
 ns2=""
@@ -186,6 +187,7 @@ init() {
 	cout=$(mktemp)
 	evts_ns1=$(mktemp)
 	evts_ns2=$(mktemp)
+	check_output_err=$(mktemp)
 
 	trap cleanup EXIT
 
@@ -199,6 +201,7 @@ cleanup()
 	rm -f "$sin" "$sout" "$cinsent" "$cinfail"
 	rm -f "$tmpfile"
 	rm -rf $evts_ns1 $evts_ns2
+	rm -f $check_output_err
 	cleanup_partial
 }
 
@@ -3356,6 +3359,32 @@ userspace_pm_rm_sf()
 	wait_rm_sf $1 "${cnt}"
 }
 
+check_output() {
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
 userspace_tests()
 {
 	# userspace pm type prevents add_addr
@@ -3545,6 +3574,52 @@ userspace_tests()
 		kill_events_pids
 		wait $tests_pid
 	fi
+
+	# userspace pm dump address
+	if reset_with_events "userspace pm dump address" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns1
+		pm_nl_set_limits $ns2 1 1
+		speed=5 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns1
+		userspace_pm_add_addr $ns1 10.0.2.1 10
+		chk_join_nr 1 1 1
+		chk_add_nr 1 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 2 2
+		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
+		local dump="id 10 flags signal 10.0.2.1"
+		[ $ip_mptcp -eq 1 ] && dump="10.0.2.1 id 10 signal "
+		check_output "pm_nl_show_endpoints $ns1" \
+			     "$dump" "      dump addrs signal"
+		kill_events_pids
+		wait $tests_pid
+	fi
+
+	# userspace pm dump subflow
+	if reset_with_events "userspace pm dump subflow" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns2
+		pm_nl_set_limits $ns1 0 1
+		speed=5 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns2
+		chk_mptcp_info subflows 0 subflows 0
+		chk_subflows_total 1 1
+		userspace_pm_add_sf $ns2 10.0.3.2 20
+		chk_join_nr 1 1 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 2 2
+		local dump="id 20 flags subflow 10.0.3.2"
+		[ $ip_mptcp -eq 1 ] && dump="10.0.3.2 id 20 subflow "
+		check_output "pm_nl_show_endpoints $ns2" \
+			     "$dump" "      dump addrs subflow"
+		kill_events_pids
+		wait $tests_pid
+	fi
 }
 
 endpoint_tests()
-- 
2.35.3

