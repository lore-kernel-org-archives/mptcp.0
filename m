Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CA839FF4
	for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 07:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708499195; cv=none; b=rIOExWZW4myg5tiYpccQ5N9RZUBUrdSCmr5+fcOLmUcBrZnDgTZZN7pYIjS7ccUY8i/ONSe8guat++/O3HhQKalOmN44NufdCf9YMyBvEGX9J50/th4CWefoCdr98fhEDUf/+nTV/yYU9mtMViFyJm8Vke45zKrcpaZb2WaTJu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708499195; c=relaxed/simple;
	bh=K/cMKVOV4dV6ScAorofxySSwNQBUrD1a24gRcxz3Poo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=si/ikIo4hoCU8sc4+ZvyiPpezpPw7Rv+CDNRkilaRAJMgHQzsngZ0tH4l5dZtMK/Xf1YMdHDTCs9npKtkvf0vPm+WHzU8bF62LXwY7xgA/F5VUuy8Dj8jAjKMYkZzleAAdL6T8EQXrOxpVI+TtaXF1BCrCTeZ282ZvIUCML/kf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNyaoZbe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNyaoZbe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFFC5C433F1;
	Wed, 21 Feb 2024 07:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708499195;
	bh=K/cMKVOV4dV6ScAorofxySSwNQBUrD1a24gRcxz3Poo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TNyaoZbey48XJBs27q1WzH+DKiq4Sm5mn733HVsw8XUAb/bRfN1t8dF/5PPNZA2HO
	 dgP0P5x+g+Osh112OcYDlfuEuIqnPsHHZRkrecm6F8+xsFeAFgqgIE+CA7y39KkxFR
	 q2dQm7qXQJ8qll6UQZbuE/AaGLE5W6yfYi23J+fJE8cHBPEZy34xpT/XnB992u3nWm
	 ynNZ+URVhKsbTwG2gVqKe7dDHI/Gt+AtZSp0LbtVP7FUnZN1UaavsnHL0ZbAi/+dNI
	 SWmpZTkZu7mgYaa4EwKFgKqHCJK9FhNzpSPn9UGvCoEcOcDBTHdf4OirCeK1ofgs8r
	 5j1MSjcNhWaxw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 3/3] selftests: mptcp: add mptcp_lib_evts_* helpers
Date: Wed, 21 Feb 2024 15:06:22 +0800
Message-Id: <82a62a697fa15f7f430076f67d6bb23a1827eb7b.1708499011.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708499011.git.tanggeliang@kylinos.cn>
References: <cover.1708499011.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

To avoid duplicated code in different MPTCP selftests, we can add and
use helpers defined in mptcp_lib.sh.

This patch unifies "pm_nl_ctl events" related code in userspace_pm.sh
and mptcp_join.sh into four helpers: mptcp_lib_evts_init(), _start(),
_kill() and _remove(). Define them in mptcp_lib.sh and use these new
helpers in both scripts.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 16 ++----
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 55 +++++++++++++++++++
 .../selftests/net/mptcp/userspace_pm.sh       | 28 +++-------
 3 files changed, 67 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index bea7627c7313..006fefaf2e2a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -158,8 +158,7 @@ init() {
 	cinsent=$(mktemp)
 	cout=$(mktemp)
 	err=$(mktemp)
-	evts_ns1=$(mktemp)
-	evts_ns2=$(mktemp)
+	mptcp_lib_evts_init evts_ns1 evts_ns2
 
 	trap cleanup EXIT
 
@@ -172,7 +171,7 @@ cleanup()
 	rm -f "$cin" "$cout" "$sinfail"
 	rm -f "$sin" "$sout" "$cinsent" "$cinfail"
 	rm -f "$tmpfile"
-	rm -rf $evts_ns1 $evts_ns2
+	mptcp_lib_evts_remove "${evts_ns1}" "${evts_ns2}"
 	rm -f "$err"
 	cleanup_partial
 }
@@ -437,12 +436,8 @@ reset_with_events()
 {
 	reset "${1}" || return 1
 
-	:> "$evts_ns1"
-	:> "$evts_ns2"
-	ip netns exec $ns1 ./pm_nl_ctl events >> "$evts_ns1" 2>&1 &
-	evts_ns1_pid=$!
-	ip netns exec $ns2 ./pm_nl_ctl events >> "$evts_ns2" 2>&1 &
-	evts_ns2_pid=$!
+	mptcp_lib_evts_start "${ns1}" "${ns2}" "${evts_ns1}" "${evts_ns2}" \
+			     evts_ns1_pid evts_ns2_pid
 }
 
 reset_with_tcp_filter()
@@ -614,8 +609,7 @@ wait_mpj()
 
 kill_events_pids()
 {
-	mptcp_lib_kill_wait $evts_ns1_pid
-	mptcp_lib_kill_wait $evts_ns2_pid
+	mptcp_lib_evts_kill evts_ns1_pid evts_ns2_pid
 }
 
 pm_nl_set_limits()
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 14c0b97a153e..9573edb4efb1 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -396,3 +396,58 @@ mptcp_lib_ns_exit() {
 		ip netns del "$netns"
 	done
 }
+
+mptcp_lib_evts_init() {
+	local arg
+
+	for arg in "${@}"; do
+		declare -n evts="${arg}"
+
+		if [ -z "${evts}" ]; then
+			evts=$(mktemp)
+		fi
+	done
+}
+
+# $1 ns1, $2 ns2
+mptcp_lib_evts_start() {
+	local ns_1="${1}"
+	local ns_2="${2}"
+	local evts_1="${3}"
+	local evts_2="${4}"
+	declare -n pid_1="${5}"
+	declare -n pid_2="${6}"
+
+	:>"${evts_1}"
+	:>"${evts_2}"
+
+	if [ ${pid_1} -ne 0 ]; then
+		mptcp_lib_kill_wait "${pid_1}"
+	fi
+	ip netns exec "${ns_1}" ./pm_nl_ctl events >> "${evts_1}" 2>&1 &
+	pid_1=$!
+
+	if [ ${pid_2} -ne 0 ]; then
+		mptcp_lib_kill_wait "${pid_2}"
+	fi
+	ip netns exec "${ns_2}" ./pm_nl_ctl events >> "${evts_2}" 2>&1 &
+	pid_2=$!
+}
+
+mptcp_lib_evts_kill() {
+	declare -n pid_1="${1}"
+	declare -n pid_2="${2}"
+
+	mptcp_lib_kill_wait "${pid_1}"
+	mptcp_lib_kill_wait "${pid_2}"
+
+	pid_1=0
+	pid_2=0
+}
+
+mptcp_lib_evts_remove() {
+	local evts_1="${1}"
+	local evts_2="${2}"
+
+	rm -rf "${evts_1}" "${evts_2}"
+}
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 10074709420a..b6a03d96e786 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -111,15 +111,16 @@ cleanup()
 
 	# Terminate the MPTCP connection and related processes
 	local pid
-	for pid in $client4_pid $server4_pid $client6_pid $server6_pid\
-		   $server_evts_pid $client_evts_pid
+	for pid in $client4_pid $server4_pid $client6_pid $server6_pid
 	do
 		mptcp_lib_kill_wait $pid
 	done
+	mptcp_lib_evts_kill server_evts_pid client_evts_pid
 
 	mptcp_lib_ns_exit "${ns1}" "${ns2}"
 
-	rm -rf $file $client_evts $server_evts
+	rm -rf $file
+	mptcp_lib_evts_remove "${server_evts}" "${client_evts}"
 
 	_printf "Done\n"
 }
@@ -176,24 +177,9 @@ make_connection()
 
 	# Capture netlink events over the two network namespaces running
 	# the MPTCP client and server
-	if [ -z "$client_evts" ]; then
-		client_evts=$(mktemp)
-	fi
-	:>"$client_evts"
-	if [ $client_evts_pid -ne 0 ]; then
-		mptcp_lib_kill_wait $client_evts_pid
-	fi
-	ip netns exec "$ns2" ./pm_nl_ctl events >> "$client_evts" 2>&1 &
-	client_evts_pid=$!
-	if [ -z "$server_evts" ]; then
-		server_evts=$(mktemp)
-	fi
-	:>"$server_evts"
-	if [ $server_evts_pid -ne 0 ]; then
-		mptcp_lib_kill_wait $server_evts_pid
-	fi
-	ip netns exec "$ns1" ./pm_nl_ctl events >> "$server_evts" 2>&1 &
-	server_evts_pid=$!
+	mptcp_lib_evts_init server_evts client_evts
+	mptcp_lib_evts_start "${ns1}" "${ns2}" "${server_evts}" "${client_evts}" \
+			     server_evts_pid client_evts_pid
 	sleep 0.5
 
 	# Run the server
-- 
2.40.1

