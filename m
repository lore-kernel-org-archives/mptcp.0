Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545811CAA7D
	for <mptcp@lists.linux.dev>; Sat,  8 Nov 2025 14:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762611690; cv=none; b=Lor7G7RR9k7122zH8NyOxWdtqE2V/H7uT8QE/5FYgrRRUyshHMflj9S6eoyDkOF4LelZk+Bi4zMpSSEXfecofj4/Tk5QH5Ai1GqjcOr800GdAnfe+0cC8/j1X58r5JbGLkCe93sehE6h3q9O5lz6INzVS/09K8AU+n7TzxQTFiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762611690; c=relaxed/simple;
	bh=dPQo3Xsh01MNud+lvRdSjux/xoRJB+DELkWMdmulEuQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mxlK1q1wh2H8zmv5p2XIQf+7PDzXxmNU4YqMtfzjpSE+dgzLumAGxQGNUwC4fNc6YOk9zI06Odt7lQuALC2WuNihapWpJk8dV79nLehWghIX7IilLnN1KAM0TdQ2Vq6pArvx2fm84FS3zpznm6LYaS0YztcBa/5f8rXPY+vkNzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F9o5erBw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9o5erBw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76154C116C6;
	Sat,  8 Nov 2025 14:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762611689;
	bh=dPQo3Xsh01MNud+lvRdSjux/xoRJB+DELkWMdmulEuQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=F9o5erBw8g6+R/W9cPKYcuUzhRJ+LtTxP4Rcp+2FtBEzTUhJSr8Jutz8wkA8Mu4Li
	 xpACxAel7iXYKpvZQXzm6jvQyQulEyi6iQ7fL2J+/uWe2vJiIlzQ4VSuCmPZw4I85Q
	 N3YLmG55p3sR82rKTZO1Zm2YL3+EBalfwBSJNtLRhSaOMfQiCufWhV0qdjKosmYPsN
	 ZxeH3GH5nSOcjAeeVVQ+WRuEmJDtthdgWNTaHiorQm3lpPFkMZg+/yjHylxOPYFjAv
	 PzpRW/XxTGZ+lO/L4N34spKwTYyUV0l9x5GzXKtoDKccAWwAEBpJ7YqMjN08CAxodL
	 HjRrboCBtPq4g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 08 Nov 2025 15:20:30 +0100
Subject: [PATCH mptcp-next 4/4] selftests: mptcp: get stats just before
 timing out
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-slft-timeout-stats-v1-4-c2234d277318@kernel.org>
References: <20251108-slft-timeout-stats-v1-0-c2234d277318@kernel.org>
In-Reply-To: <20251108-slft-timeout-stats-v1-0-c2234d277318@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=10114; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=dPQo3Xsh01MNud+lvRdSjux/xoRJB+DELkWMdmulEuQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDL5A5+qzOAoNN1gdPvHFPdJB9aslnKuSeJd/Fd6DWfIn
 cCc/xsYO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACZSdJ/hf7gOk3/uP6H117Vm
 vV5aKXnZI2v1+n6/kwE2zVOlHh2f/YGRYW3zep5iuctv8k+wczhsd300JfJJn3XRjV27ffNO2G3
 TZgAA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Recently, some debugging happened around a test that was timing out. The
stats were showing connections being closed which was confusing because
the closing state was caused by the timeout stopping the transfer.

To avoid such confusion, the timeout is no longer done per mptcp_connect
process, but separately. In case of timeout, the stats are now printed,
then the apps are killed.

The stats will still be printed after the kill, but that's fine, and
this might even be useful, just in case. Timeout should be exceptional.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 21 +++++++++-------
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 29 +++++++++++-----------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 13 ++++++++++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 21 +++++++++-------
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 24 ++++++++++--------
 5 files changed, 66 insertions(+), 42 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 1149bd150d6a..6bff77ed0a74 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -391,26 +391,29 @@ do_transfer()
 		mptcp_lib_nstat_init "${connector_ns}"
 	fi
 
-	timeout ${timeout_test} \
-		ip netns exec ${listener_ns} \
-			./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
-				$extra_args $local_addr < "$sin" > "$sout" &
+	ip netns exec ${listener_ns} \
+		./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
+			$extra_args $local_addr < "$sin" > "$sout" &
 	local spid=$!
 
 	mptcp_lib_wait_local_port_listen "${listener_ns}" "${port}"
 
 	local start
 	start=$(date +%s%3N)
-	timeout ${timeout_test} \
-		ip netns exec ${connector_ns} \
-			./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
-				$extra_args $connect_addr < "$cin" > "$cout" &
+	ip netns exec ${connector_ns} \
+		./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
+			$extra_args $connect_addr < "$cin" > "$cout" &
 	local cpid=$!
 
+	mptcp_lib_wait_timeout "${timeout_test}" "${listener_ns}" \
+		"${connector_ns}" "${port}" "${cpid}" "${spid}" &
+	local timeout_pid=$!
+
 	wait $cpid
 	local retc=$?
 	wait $spid
 	local rets=$?
+	kill $timeout_pid 2>/dev/null && timeout_pid=0
 
 	local stop
 	stop=$(date +%s%3N)
@@ -431,7 +434,7 @@ do_transfer()
 	local duration
 	duration=$((stop-start))
 	printf "(duration %05sms) " "${duration}"
-	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
+	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ] || [ ${timeout_pid} -ne 0 ]; then
 		mptcp_lib_pr_fail "client exit code $retc, server $rets"
 		mptcp_lib_pr_err_stats "${listener_ns}" "${connector_ns}" "${port}"
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 8be8bfa71946..9ce386b3056c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1041,38 +1041,38 @@ do_transfer()
 	if [ "$test_linkfail" -gt 1 ];then
 		listener_in="${sinfail}"
 	fi
-	timeout ${timeout_test} \
-		ip netns exec ${listener_ns} \
-			./mptcp_connect -t ${timeout_poll} -l -p ${port} -s ${srv_proto} \
-				${extra_srv_args} "${bind_addr}" < "${listener_in}" > "${sout}" &
+	ip netns exec ${listener_ns} \
+		./mptcp_connect -t ${timeout_poll} -l -p ${port} -s ${srv_proto} \
+			${extra_srv_args} "${bind_addr}" < "${listener_in}" > "${sout}" &
 	local spid=$!
 
 	mptcp_lib_wait_local_port_listen "${listener_ns}" "${port}"
 
 	extra_cl_args="$extra_args $extra_cl_args"
 	if [ "$test_linkfail" -eq 0 ];then
-		timeout ${timeout_test} \
-			ip netns exec ${connector_ns} \
-				./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
-					$extra_cl_args $connect_addr < "$cin" > "$cout" &
+		ip netns exec ${connector_ns} \
+			./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
+				$extra_cl_args $connect_addr < "$cin" > "$cout" &
 	elif [ "$test_linkfail" -eq 1 ] || [ "$test_linkfail" -eq 2 ];then
 		connector_in="${cinsent}"
 		( cat "$cinfail" ; sleep 2; link_failure $listener_ns ; cat "$cinfail" ) | \
 			tee "$cinsent" | \
-			timeout ${timeout_test} \
 				ip netns exec ${connector_ns} \
 					./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
 						$extra_cl_args $connect_addr > "$cout" &
 	else
 		connector_in="${cinsent}"
 		tee "$cinsent" < "$cinfail" | \
-			timeout ${timeout_test} \
-				ip netns exec ${connector_ns} \
-					./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
-						$extra_cl_args $connect_addr > "$cout" &
+			ip netns exec ${connector_ns} \
+				./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
+					$extra_cl_args $connect_addr > "$cout" &
 	fi
 	local cpid=$!
 
+	mptcp_lib_wait_timeout "${timeout_test}" "${listener_ns}" \
+		"${connector_ns}" "${port}" "${cpid}" "${spid}" &
+	local timeout_pid=$!
+
 	pm_nl_set_endpoint $listener_ns $connector_ns $connect_addr
 	check_cestab $listener_ns $connector_ns
 
@@ -1080,13 +1080,14 @@ do_transfer()
 	local retc=$?
 	wait $spid
 	local rets=$?
+	kill $timeout_pid 2>/dev/null && timeout_pid=0
 
 	cond_stop_capture
 
 	mptcp_lib_nstat_get "${listener_ns}"
 	mptcp_lib_nstat_get "${connector_ns}"
 
-	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
+	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ] || [ ${timeout_pid} -ne 0 ]; then
 		fail_test "client exit code $retc, server $rets"
 		mptcp_lib_pr_err_stats "${listener_ns}" "${connector_ns}" "${port}"
 		return 1
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 91ec75ddcb96..5fea7e7df628 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -350,6 +350,19 @@ mptcp_lib_evts_get_info() {
 		mptcp_lib_get_info_value "${1}" "^type:${3:-1},"
 }
 
+mptcp_lib_wait_timeout() {
+	local timeout_test="${1}"
+	local listener_ns="${2}"
+	local connector_ns="${3}"
+	local port="${4}"
+	shift 4 # rest are PIDs
+
+	sleep "${timeout_test}"
+	mptcp_lib_print_err "timeout"
+	mptcp_lib_pr_err_stats "${listener_ns}" "${connector_ns}" "${port}"
+	kill "${@}" 2>/dev/null
+}
+
 # $1: PID
 mptcp_lib_kill_wait() {
 	[ "${1}" -eq 0 ] && return 0
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 6cde7429104b..326466f2f6eb 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -172,31 +172,34 @@ do_transfer()
 	mptcp_lib_nstat_init "${listener_ns}"
 	mptcp_lib_nstat_init "${connector_ns}"
 
-	timeout ${timeout_test} \
-		ip netns exec ${listener_ns} \
-			$mptcp_connect -t ${timeout_poll} -l -M 1 -p $port -s ${srv_proto} -c "${cmsg}" \
-				${local_addr} < "$sin" > "$sout" &
+	ip netns exec ${listener_ns} \
+		$mptcp_connect -t ${timeout_poll} -l -M 1 -p $port -s ${srv_proto} -c "${cmsg}" \
+			${local_addr} < "$sin" > "$sout" &
 	local spid=$!
 
 	mptcp_lib_wait_local_port_listen "${listener_ns}" "${port}"
 
-	timeout ${timeout_test} \
-		ip netns exec ${connector_ns} \
-			$mptcp_connect -t ${timeout_poll} -M 2 -p $port -s ${cl_proto} -c "${cmsg}" \
-				$connect_addr < "$cin" > "$cout" &
+	ip netns exec ${connector_ns} \
+		$mptcp_connect -t ${timeout_poll} -M 2 -p $port -s ${cl_proto} -c "${cmsg}" \
+			$connect_addr < "$cin" > "$cout" &
 
 	local cpid=$!
 
+	mptcp_lib_wait_timeout "${timeout_test}" "${listener_ns}" \
+		"${connector_ns}" "${port}" "${cpid}" "${spid}" &
+	local timeout_pid=$!
+
 	wait $cpid
 	local retc=$?
 	wait $spid
 	local rets=$?
+	kill $timeout_pid 2>/dev/null && timeout_pid=0
 
 	mptcp_lib_nstat_get "${listener_ns}"
 	mptcp_lib_nstat_get "${connector_ns}"
 
 	print_title "Transfer ${ip:2}"
-	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
+	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ] || [ ${timeout_pid} -ne 0 ]; then
 		mptcp_lib_pr_fail "client exit code $retc, server $rets"
 		mptcp_lib_pr_err_stats "${listener_ns}" "${connector_ns}" "${port}"
 
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 503cb59571a4..cc4d40d149e2 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -158,24 +158,27 @@ do_transfer()
 	mptcp_lib_nstat_init "${ns3}"
 	mptcp_lib_nstat_init "${ns1}"
 
-	timeout ${timeout_test} \
-		ip netns exec ${ns3} \
-			./mptcp_connect -jt ${timeout_poll} -l -p $port -T $max_time \
-				0.0.0.0 < "$sin" > "$sout" &
+	ip netns exec ${ns3} \
+		./mptcp_connect -jt ${timeout_poll} -l -p $port -T $max_time \
+			0.0.0.0 < "$sin" > "$sout" &
 	local spid=$!
 
 	mptcp_lib_wait_local_port_listen "${ns3}" "${port}"
 
-	timeout ${timeout_test} \
-		ip netns exec ${ns1} \
-			./mptcp_connect -jt ${timeout_poll} -p $port -T $max_time \
-				10.0.3.3 < "$cin" > "$cout" &
+	ip netns exec ${ns1} \
+		./mptcp_connect -jt ${timeout_poll} -p $port -T $max_time \
+			10.0.3.3 < "$cin" > "$cout" &
 	local cpid=$!
 
+	mptcp_lib_wait_timeout "${timeout_test}" "${ns3}" "${ns1}" "${port}" \
+		"${cpid}" "${spid}" &
+	local timeout_pid=$!
+
 	wait $cpid
 	local retc=$?
 	wait $spid
 	local rets=$?
+	kill $timeout_pid 2>/dev/null && timeout_pid=0
 
 	if $capture; then
 		sleep 1
@@ -191,8 +194,9 @@ do_transfer()
 	cmp $cin $sout > /dev/null 2>&1
 	local cmpc=$?
 
-	if [ $retc -eq 0 ] && [ $rets -eq 0 ] && \
-	   [ $cmpc -eq 0 ] && [ $cmps -eq 0 ]; then
+	if [ $retc -eq 0 ] && [ $rets -eq 0 ] &&
+	   [ $cmpc -eq 0 ] && [ $cmps -eq 0 ] &&
+	   [ $timeout_pid -eq 0 ]; then
 		printf "%-16s" " max $max_time "
 		mptcp_lib_pr_ok
 		cat "$capout"

-- 
2.51.0

