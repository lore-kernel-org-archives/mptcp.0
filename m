Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454C838F9B
	for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 06:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708496615; cv=none; b=aPxbQVSMzdMgBKetxA2fxIewcRDdhrdXsXiNYeoO6omZ6t/yO/FaDHfPCIHBz2jALAza7VWgeN1YDKQDVfEKWU91hW3G1IIVjvlbniX9vbYtG8+4/lZPhCnnhtzmh/v8UNq+CmB2aNKeExH/7HMmDMMlydhVcePof89pFuCKcUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708496615; c=relaxed/simple;
	bh=s4YuhPUexwQKTJWFGPYxPSWxIEZRYK4opEWeo+cbo1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VR7ntHMbLZUq5tHMOTyDwYyTz3kpFXtQUCpQRZfrn9YSy8UV0a3nGUcuzfmdxgbnq+X2/dL/MetTlPu2EsKGdsmMLKyU94lOVajjRnErgd9DFrxto69sjbjmzmtCJAbIBplhSOyIJjenfyvDFIOi/4o99QwOgO4FBrMU4of3qCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4zA44Dx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4zA44Dx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF7AC433C7;
	Wed, 21 Feb 2024 06:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708496615;
	bh=s4YuhPUexwQKTJWFGPYxPSWxIEZRYK4opEWeo+cbo1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g4zA44DxI0oLLh7HiKalGeJJOEbIu4FuHr6f99lv6GVu4DlQhgwrhWrJX6gC6pUd+
	 8mlZ4bDQHl6VadGKeG98wJ1xbm+y+3iXdmOiGJmXluioylLhVPBXnkyJI7TUd/TOBg
	 7b+RpZ6/drrT/Zpkn+HghyZkpdG9kw2bjJCDDI/xkuy5tpXgkiLMOSUBXWVDSH5lZh
	 ae8pkDcqalmompn7MDAh5Ey4B4TbPgFC7uQPbM21PxNYogLZ6WRoyUH0rTHKh/UCW/
	 ZU+r38O2VyhCVVWjirB12pEm20ZvJJa2qF9uC3xRYOGbVfCReKGvfEEz6ykyL4INfK
	 VUWvBYKGdckgA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 3/3] selftests: mptcp: add mptcp_lib_evts_* helpers
Date: Wed, 21 Feb 2024 14:23:24 +0800
Message-Id: <64f6eec75a59f3e0f2d1bdad0a8159a192a1470c.1708496523.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708496523.git.tanggeliang@kylinos.cn>
References: <cover.1708496523.git.tanggeliang@kylinos.cn>
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
index a09b42d1ed37..67a781cd197a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -154,8 +154,7 @@ init() {
 	cinsent=$(mktemp)
 	cout=$(mktemp)
 	err=$(mktemp)
-	evts_ns1=$(mktemp)
-	evts_ns2=$(mktemp)
+	mptcp_lib_evts_init evts_ns1 evts_ns2
 
 	trap cleanup EXIT
 
@@ -168,7 +167,7 @@ cleanup()
 	rm -f "$cin" "$cout" "$sinfail"
 	rm -f "$sin" "$sout" "$cinsent" "$cinfail"
 	rm -f "$tmpfile"
-	rm -rf $evts_ns1 $evts_ns2
+	mptcp_lib_evts_remove "${evts_ns1}" "${evts_ns2}"
 	rm -f "$err"
 	cleanup_partial
 }
@@ -433,12 +432,8 @@ reset_with_events()
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
@@ -610,8 +605,7 @@ wait_mpj()
 
 kill_events_pids()
 {
-	mptcp_lib_kill_wait $evts_ns1_pid
-	mptcp_lib_kill_wait $evts_ns2_pid
+	mptcp_lib_evts_kill evts_ns1_pid evts_ns2_pid
 }
 
 pm_nl_set_limits()
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 4be9247b5da3..2d9894ef302f 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -397,3 +397,58 @@ mptcp_lib_ns_exit() {
 		rm -f /tmp/"$netns".{nstat,out}
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

