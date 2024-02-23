Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50106BE68
	for <mptcp@lists.linux.dev>; Fri, 23 Feb 2024 03:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708657698; cv=none; b=oLDXnoSHYIIYQjfLjZfygwyGlwAQZeqDltFkrRGRmbUBEwUZARWO2YNB1YOl5avV4M5pCK8+axzqvyg2L1hXjTbMXXvOvf2LYT0dFNqMwUZe/q5vnR95kdda7BCbGYDaMgkfE/KGMJtBOfjuqTNy4tH4f5haqepcdvGApzctONk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708657698; c=relaxed/simple;
	bh=JKNSE3Jwnns2RlzjhCr7vEsS+15M9QTpSzCcDzrjW6c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lNl4iSIN2Al+kzTAKG6L71Noq3TSoWXao3gGbEp8fYmt4vVSSW8gKVPZ3Akd2W0ztaQdNFSws355BGD7OBg254vskI771QYqOBzMvnsb+kFXuadia7W24YBlHsN5oe3OynXb42hmevcKcA0XCJbfZjXdi6kD7MebQ1f92Kv8JZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=az4uxso2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="az4uxso2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6CCC433A6;
	Fri, 23 Feb 2024 03:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708657697;
	bh=JKNSE3Jwnns2RlzjhCr7vEsS+15M9QTpSzCcDzrjW6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=az4uxso2KIaLDx5D42ND9Y99M2FWaFDM3sei8kVvLjeuGhsOCAtHd3PvbSqUb6Twr
	 LjBszMiS5Lr883rDNdWn3qH1gWKUGbN2SFHDCbbl10OgAOvoiSDmDHrKdOfs36UUh4
	 KKhR2oTzBD8CFtqyrZMfzWnHv5HdeeQyHAI9gD56BIBdDbnBxibK+uoJK1pIPAYrKq
	 8wqTUxTbWy0zeLV1psXDI4E69S8wW2qvrdoC4OuGKBgtTzPpgJUTHBcSOyi8czXGih
	 ecdPuqWOZUt6K3N1Htb7GF13xxrX092rIhNNbdMRk/fSP1qa8qVtG7ds51q0WrKc9x
	 eMmzPLor91VZw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 1/8] selftests: mptcp: capitalize ok/fail/skip
Date: Fri, 23 Feb 2024 11:08:04 +0800
Message-Id: <84859e105235db82170d8757815bcf66d3aa41cf.1708657486.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708657486.git.tanggeliang@kylinos.cn>
References: <cover.1708657486.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Most scripts print uppercase [ OK ], [ FAIL ] and [ SKIP ] as test results,
but lowercase ones are used in diag.sh, mptcp_join.sh and simult_flows.sh.
To maintain consistency with other scripts, this patch capitalizes these
lowercase [ ok ], [ fail ] and [ skip ]:

    [ ok ]   -> [ OK ]   in diag.sh, mptcp_join.sh
    [ fail ] -> [FAIL] in diag.sh, mptcp_join.sh, simult_flows.sh
    [ skip ] -> [SKIP] in diag.sh, mptcp_join.sh

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/diag.sh        | 12 ++++++------
 .../testing/selftests/net/mptcp/mptcp_connect.sh | 16 ++++++++--------
 tools/testing/selftests/net/mptcp/mptcp_join.sh  |  6 +++---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh   |  2 +-
 .../testing/selftests/net/mptcp/simult_flows.sh  |  2 +-
 5 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index d8f080f934ac..aa3fb808fc6d 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -58,15 +58,15 @@ __chk_nr()
 	printf "%-50s" "$msg"
 	if [ "$nr" != "$expected" ]; then
 		if [ "$nr" = "$skip" ] && ! mptcp_lib_expect_all_features; then
-			echo "[ skip ] Feature probably not supported"
+			echo "[SKIP] Feature probably not supported"
 			mptcp_lib_result_skip "${msg}"
 		else
-			echo "[ fail ] expected $expected found $nr"
+			echo "[FAIL] expected $expected found $nr"
 			mptcp_lib_result_fail "${msg}"
 			ret=$test_cnt
 		fi
 	else
-		echo "[  ok  ]"
+		echo "[ OK ]"
 		mptcp_lib_result_pass "${msg}"
 	fi
 	test_cnt=$((test_cnt+1))
@@ -116,15 +116,15 @@ wait_msk_nr()
 
 	printf "%-50s" "$msg"
 	if [ $i -ge $timeout ]; then
-		echo "[ fail ] timeout while expecting $expected max $max last $nr"
+		echo "[FAIL] timeout while expecting $expected max $max last $nr"
 		mptcp_lib_result_fail "${msg} # timeout"
 		ret=$test_cnt
 	elif [ $nr != $expected ]; then
-		echo "[ fail ] expected $expected found $nr"
+		echo "[FAIL] expected $expected found $nr"
 		mptcp_lib_result_fail "${msg} # unexpected result"
 		ret=$test_cnt
 	else
-		echo "[  ok  ]"
+		echo "[ OK ]"
 		mptcp_lib_result_pass "${msg}"
 	fi
 	test_cnt=$((test_cnt+1))
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 0ca2960c9099..ab3bb3b17522 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -254,7 +254,7 @@ check_mptcp_disabled()
 
 	# net.mptcp.enabled should be enabled by default
 	if [ "$(ip netns exec ${disabled_ns} sysctl net.mptcp.enabled | awk '{ print $3 }')" -ne 1 ]; then
-		echo -e "net.mptcp.enabled sysctl is not 1 by default\t\t[ FAIL ]"
+		echo -e "net.mptcp.enabled sysctl is not 1 by default\t\t[FAIL]"
 		mptcp_lib_result_fail "net.mptcp.enabled sysctl is not 1 by default"
 		ret=1
 		return 1
@@ -267,7 +267,7 @@ check_mptcp_disabled()
 	mptcp_lib_ns_exit "${disabled_ns}"
 
 	if [ ${err} -eq 0 ]; then
-		echo -e "New MPTCP socket cannot be blocked via sysctl\t\t[ FAIL ]"
+		echo -e "New MPTCP socket cannot be blocked via sysctl\t\t[FAIL]"
 		mptcp_lib_result_fail "New MPTCP socket cannot be blocked via sysctl"
 		ret=1
 		return 1
@@ -294,7 +294,7 @@ do_ping()
 	ip netns exec ${connector_ns} ping ${ping_args} $connect_addr >/dev/null || rc=1
 
 	if [ $rc -ne 0 ] ; then
-		echo "$listener_ns -> $connect_addr connectivity [ FAIL ]" 1>&2
+		echo "$listener_ns -> $connect_addr connectivity [FAIL]" 1>&2
 		ret=1
 
 		return 1
@@ -427,7 +427,7 @@ do_transfer()
 	result_msg+=" # time=${duration}ms"
 	printf "(duration %05sms) " "${duration}"
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
-		echo "[ FAIL ] client exit code $retc, server $rets" 1>&2
+		echo "[FAIL] client exit code $retc, server $rets" 1>&2
 		echo -e "\nnetns ${listener_ns} socket stat for ${port}:" 1>&2
 		ip netns exec ${listener_ns} ss -Menita 1>&2 -o "sport = :$port"
 		cat /tmp/${listener_ns}.out
@@ -469,13 +469,13 @@ do_transfer()
 	fi
 
 	if [ ${stat_synrx_now_l} -lt ${expect_synrx} ]; then
-		printf "[ FAIL ] lower MPC SYN rx (%d) than expected (%d)\n" \
+		printf "[FAIL] lower MPC SYN rx (%d) than expected (%d)\n" \
 			"${stat_synrx_now_l}" "${expect_synrx}" 1>&2
 		retc=1
 	fi
 	if [ ${stat_ackrx_now_l} -lt ${expect_ackrx} ] && [ ${stat_ooo_now} -eq 0 ]; then
 		if [ ${stat_ooo_now} -eq 0 ]; then
-			printf "[ FAIL ] lower MPC ACK rx (%d) than expected (%d)\n" \
+			printf "[FAIL] lower MPC ACK rx (%d) than expected (%d)\n" \
 				"${stat_ackrx_now_l}" "${expect_ackrx}" 1>&2
 			rets=1
 		else
@@ -491,13 +491,13 @@ do_transfer()
 
 		local csum_err_s_nr=$((csum_err_s - stat_csum_err_s))
 		if [ $csum_err_s_nr -gt 0 ]; then
-			printf "[ FAIL ]\nserver got %d data checksum error[s]" ${csum_err_s_nr}
+			printf "[FAIL]\nserver got %d data checksum error[s]" ${csum_err_s_nr}
 			rets=1
 		fi
 
 		local csum_err_c_nr=$((csum_err_c - stat_csum_err_c))
 		if [ $csum_err_c_nr -gt 0 ]; then
-			printf "[ FAIL ]\nclient got %d data checksum error[s]" ${csum_err_c_nr}
+			printf "[FAIL]\nclient got %d data checksum error[s]" ${csum_err_c_nr}
 			retc=1
 		fi
 	fi
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 1df2d24979a0..8e8977031fa0 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -190,17 +190,17 @@ print_info()
 
 print_ok()
 {
-	mptcp_lib_print_ok "[ ok ]${1:+ ${*}}"
+	mptcp_lib_print_ok "[ OK ]${1:+ ${*}}"
 }
 
 print_fail()
 {
-	mptcp_lib_print_err "[fail]${1:+ ${*}}"
+	mptcp_lib_print_err "[FAIL]${1:+ ${*}}"
 }
 
 print_skip()
 {
-	mptcp_lib_print_warn "[skip]${1:+ ${*}}"
+	mptcp_lib_print_warn "[SKIP]${1:+ ${*}}"
 }
 
 # [ $1: fail msg ]
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index bef597e62f3e..9e1486a618a6 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -294,7 +294,7 @@ mptcp_lib_check_transfer() {
 	local what="${3}"
 
 	if ! cmp "$in" "$out" > /dev/null 2>&1; then
-		echo "[ FAIL ] $what does not match (in, out):"
+		echo "[FAIL] $what does not match (in, out):"
 		mptcp_lib_print_file_err "$in"
 		mptcp_lib_print_file_err "$out"
 
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 467feb17e07b..58cfdaf1db25 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -192,7 +192,7 @@ do_transfer()
 		return 0
 	fi
 
-	echo " [ fail ]"
+	echo " [FAIL]"
 	echo "client exit code $retc, server $rets" 1>&2
 	echo -e "\nnetns ${ns3} socket stat for $port:" 1>&2
 	ip netns exec ${ns3} ss -nita 1>&2 -o "sport = :$port"
-- 
2.40.1

