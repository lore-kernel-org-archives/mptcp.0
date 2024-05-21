Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06AD2E859
	for <mptcp@lists.linux.dev>; Tue, 21 May 2024 10:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716287865; cv=none; b=tKGv//PxN8EMwfKKkZttnJwLz4/6+mjE4lNC0Rx7TQVggPv0l63AkhxKAZIiXk91v0aYPulBHWVG3X0cfYL6PoC9szTjxRMI6F+6QqfusvZgPAXayvueTykn34enQegWFWgyI7eY0meBJlDso5FRMJlGdO4+q11Mgp4RFDLbu94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716287865; c=relaxed/simple;
	bh=V+qPQZfB/z1akTeQhdwJFW3QhSkmqZ+HbC66dHmPs2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A/kB9wsrDHxtfTUjHaGCAma/4VXBjNZPKYOS/gthzUbtLUPVfhOtaW7C7v8g0ZvtOl+PMkbxnuGVZ+Zk5B/EXHzPYHe3KhAgMtwbThLgXICW7S218aEgq5wyowT7G97KNqr5MVMvWmFNYLb5bV9G6MCsXzTMigsZVA1pwlxvoF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXOewyC0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXOewyC0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B68C2BD11;
	Tue, 21 May 2024 10:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716287864;
	bh=V+qPQZfB/z1akTeQhdwJFW3QhSkmqZ+HbC66dHmPs2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DXOewyC0HMl75/qL+0MOqmz5P5/WPEjzo4st9FEMT5xIr6h3udPPBnz5/zd/NDjV9
	 tvb8isKvS/a2xbp740E+DowG/t0JCFP+5ZkwUJ74C74/eZF/e6ek4IV5SmsWwitu9o
	 KIlPdpDaKzOqEFVuQd5a5kYyWk2C954LONy+gxNSyHAxZg9vwM/GJiFd+7WI/HCbfx
	 rrjP2gnLWQSYoC6jKpRlPItjf2MUXc0dbEexGcbFeIj80zFkn9/fTgJtGWZ9ttCpxZ
	 Qc0XwVnb5NuDwsSv/jkppnXTBxs3KzIAsbtWLpHzzHAqmtFQRwBKYlP5gw1RvL2jy6
	 6yp/8SGPBUIhg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 3/4] selftests: mptcp: use cleanup_all_ns helper in lib.sh
Date: Tue, 21 May 2024 18:37:30 +0800
Message-ID: <2415273c8041e2eeac40abaae8aab05d66a0a237.1716287732.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1716287732.git.tanggeliang@kylinos.cn>
References: <cover.1716287732.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch uses cleanup_all_ns() helper in lib.sh instead of all
mptcp_lib_ns_exit() in mptcp seltests. And drop this duplicate mptcp
helper in mptcp_lib.sh.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/diag.sh          | 2 +-
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 3 +--
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 2 +-
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 8 --------
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 2 +-
 tools/testing/selftests/net/mptcp/pm_netlink.sh    | 2 +-
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 2 +-
 tools/testing/selftests/net/mptcp/userspace_pm.sh  | 2 +-
 8 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index eec1f04d231f..9e19e3e8d833 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -33,7 +33,7 @@ cleanup()
 {
 	ip netns pids "${ns1}" | xargs --no-run-if-empty kill -SIGKILL &>/dev/null
 
-	mptcp_lib_ns_exit "${ns1}"
+	cleanup_all_ns
 }
 
 mptcp_lib_check_mptcp
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index b77fb7065bfb..4e2c5dd0de3c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -142,7 +142,7 @@ cleanup()
 	rm -f "$sin" "$sout"
 	rm -f "$capout"
 
-	mptcp_lib_ns_exit "${ns1}" "${ns2}" "${ns3}" "${ns4}"
+	cleanup_all_ns
 }
 
 mptcp_lib_check_mptcp
@@ -271,7 +271,6 @@ check_mptcp_disabled()
 	local err=0
 	LC_ALL=C ip netns exec ${disabled_ns} ./mptcp_connect -p 10000 -s MPTCP 127.0.0.1 < "$cin" 2>&1 | \
 		grep -q "^socket: Protocol not available$" && err=1
-	mptcp_lib_ns_exit "${disabled_ns}"
 
 	if [ ${err} -eq 0 ]; then
 		mptcp_lib_pr_fail "New MPTCP socket cannot be blocked via sysctl"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index fefa9173bdaa..911b6393eba3 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -133,7 +133,7 @@ cleanup_partial()
 {
 	rm -f "$capout"
 
-	mptcp_lib_ns_exit "${ns1}" "${ns2}"
+	cleanup_all_ns
 }
 
 init() {
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 59eb77e7813d..bd7d78e4aa83 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -424,14 +424,6 @@ mptcp_lib_ns_init() {
 	done
 }
 
-mptcp_lib_ns_exit() {
-	local netns
-	for netns in "${@}"; do
-		ip netns del "${netns}"
-		rm -f /tmp/"${netns}".{nstat,out}
-	done
-}
-
 mptcp_lib_events() {
 	local ns="${1}"
 	local evts="${2}"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 68899a303a1a..e1026b028739 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -98,7 +98,7 @@ init()
 #shellcheck disable=SC2317
 cleanup()
 {
-	mptcp_lib_ns_exit "${ns1}" "${ns2}" "${ns_sbox}"
+	cleanup_all_ns
 	rm -f "$cin" "$cout"
 	rm -f "$sin" "$sout"
 }
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 2757378b1b13..5b4d83c2e280 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -36,7 +36,7 @@ err=$(mktemp)
 cleanup()
 {
 	rm -f "${err}"
-	mptcp_lib_ns_exit "${ns1}"
+	cleanup_all_ns
 }
 
 mptcp_lib_check_mptcp
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index d0b39c2e38a3..6eddb3bba2e8 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -42,7 +42,7 @@ cleanup()
 	rm -f "$large" "$small"
 	rm -f "$capout"
 
-	mptcp_lib_ns_exit "${ns1}" "${ns2}" "${ns3}"
+	cleanup_all_ns
 }
 
 mptcp_lib_check_mptcp
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 9e2981f2d7f5..0c089e7f5f0a 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -107,7 +107,7 @@ cleanup()
 		mptcp_lib_kill_wait $pid
 	done
 
-	mptcp_lib_ns_exit "${ns1}" "${ns2}"
+	cleanup_all_ns
 
 	rm -rf $file $client_evts $server_evts
 
-- 
2.43.0

