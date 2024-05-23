Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF16A13C9C0
	for <mptcp@lists.linux.dev>; Thu, 23 May 2024 08:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451752; cv=none; b=E6Mk5/XLWpNqfHTpHJaVxdReYmJW6g4SS9kDSVJ68XtU5LKPIqdQgQQqn4N2oqgb/8e/VyYgk8CEDr9DMdNNKqK5dArDtKZtyYdhC7Bn1fH9doMDno9mq1guLJ1qhCYupxUsasrVLInIp5gHgeFiWJg/7JNf0gApTnByKCBza6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451752; c=relaxed/simple;
	bh=aPj54Zpaw4QQ/eAL5pKV/1vKVi+5wUs1+F4qyAlxqSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQVfmiBdzFxm7UCY7ksTSwXZGyko6Av4/xDiUHxa8s3HCjzlSmVThrc0zXxnpUvQIT4NcbwJWrEEC5ltab8zopdoX1qxI84g1KYxuou6wxVb7YGTiH1aA2ac1iBOb6zIe55plGTJCCIOUA6hhC8kZv5K6EPg4Wyn7RIO9cLjQx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5O4vkYa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5O4vkYa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22DF1C32782;
	Thu, 23 May 2024 08:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716451752;
	bh=aPj54Zpaw4QQ/eAL5pKV/1vKVi+5wUs1+F4qyAlxqSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t5O4vkYayIl+5nypDBbCKHUwhMWURCPq+cReuN9hx6GRZcwkPyDfWN+ss35He/V0o
	 Yy3WkjyFQqro9dLHZ6GHqkyBRaWFtqKujZKs28fB3nMJfU12L+KtkukvHD9K2sGdi7
	 eh2DM61fSS0ffvpznocBtC9/u8VDPD4rvy7O/SBJ+WpyuVflsJhagmNqmpwtHxgtpR
	 8W2FaCI1Dk8fypxoGQbhvNdDEGlQcsVAkg9zvhLe0xQGdGyqIQDXaKaclM/jBUrQsP
	 M/1DZdg+KE4s4FTXtCVbTkarOcU5w9NFU94PNQSbPeTlbqDCmNVIfql1ZSobkRzr4E
	 zEH4+bC5veg3g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 3/4] selftests: mptcp: use cleanup_all_ns helper in lib.sh
Date: Thu, 23 May 2024 16:08:59 +0800
Message-ID: <d341c904ef486b7e0039c3812ddd659ef7791f9f.1716451525.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1716451525.git.tanggeliang@kylinos.cn>
References: <cover.1716451525.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch uses cleanup_all_ns() helper defined in lib.sh instead of
all mptcp_lib_ns_exit() in mptcp seltests. And drop this duplicate
mptcp helper in mptcp_lib.sh.

In mptcp_connect.sh, drop mptcp_lib_ns_exit in check_mptcp_disabled()
directly, this "disabled_ns" will be deleted by cleanup_all_ns() in
cleanup(), together with "ns1 - ns4".

In mptcp_join.sh, drop mptcp_lib_ns_exit in cleanup_partial() directly,
each existing namespace will delete automaticly in setup_ns(), only
adding cleanup_all_ns in cleanup() is enough.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/diag.sh          | 2 +-
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 3 +--
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 3 +--
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 8 --------
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 2 +-
 tools/testing/selftests/net/mptcp/pm_netlink.sh    | 2 +-
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 2 +-
 tools/testing/selftests/net/mptcp/userspace_pm.sh  | 2 +-
 8 files changed, 7 insertions(+), 17 deletions(-)

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
index fefa9173bdaa..87a518b8c19f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -132,8 +132,6 @@ init_shapers()
 cleanup_partial()
 {
 	rm -f "$capout"
-
-	mptcp_lib_ns_exit "${ns1}" "${ns2}"
 }
 
 init() {
@@ -166,6 +164,7 @@ cleanup()
 	rm -rf $evts_ns1 $evts_ns2
 	rm -f "$err"
 	cleanup_partial
+	cleanup_all_ns
 }
 
 print_check()
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

