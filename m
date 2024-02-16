Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35151CD17
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 09:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077059; cv=none; b=HL+Uf2M2KguDV/HibGn20tpWbCEtfzqzG6S5a3JblKoeEggevf6spODiqms0kCP1BEBPH5Siolf9YCT+u9XVLOdSq9x4yA7nAmrANyNL1KJCyk7OrJ6U/tBgsBBzY7KJQJeCQyFduU7eJkitBLbderFcS9qfI1Kgep7NxdSU+Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077059; c=relaxed/simple;
	bh=WTfB/G7xkDM2vtnB1PUe9rO/fwhj+tNHXyPmLFneab0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DOmcxJ71+SBJm4Hyiambx6NdZKTBc3o8IXBnQAMecPc0xj2vSmr3d4sJl/NXBL43+I87MGPH+iWwiQ5FdT9n81XPfLbRJmDE/FdYpM+m1JHnCya4n7dOkosZoQoRR7htz+GomMNf0a1eG1uxflZ6ar1AXxER8ZJI/OiyD9tYukA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZ5es1yC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZ5es1yC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FCF7C433F1;
	Fri, 16 Feb 2024 09:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708077058;
	bh=WTfB/G7xkDM2vtnB1PUe9rO/fwhj+tNHXyPmLFneab0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dZ5es1yCADGlCd9/AdT9hI+xhxAXm71W/c+jbqAO4BJYMKztcMBcL/Q5s/NVOzh7p
	 alPHzqGZC+v1N1m8jzHOOdhl9p72yG5PRKWNWrVtDhSmwqR9EE9Djy87vSFqS8NtGQ
	 5QmRFD3uBgi9/FD7GNHzK2q23Kq37nW3gkuMzSDRDrg+CEaxRBbWDRP/Ce6Qi6m9DR
	 PTE6d98yn2Zdo+79ld4pWVyPO9+R4gbqCv3oCok3KpdWvxic572mZ8AzBR2MKDIdNr
	 U6JwqaDhe7uMNNVLFhV0fsnHvAyalnNwPTo0U95qe4F6v7dNC7NmepXF7a0cZ07T1F
	 fb8OJKHafCOng==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 5/7] selftests: mptcp: drop iptables/ip6tables vars
Date: Fri, 16 Feb 2024 17:50:33 +0800
Message-Id: <fdcfea6deedc64317296cd063c037b45d495c6b7.1708076886.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708076886.git.tanggeliang@kylinos.cn>
References: <cover.1708076886.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Since iptables-legacy/ip6tables-legacy are dropped in the commit
5b31f0f6f954 ("selftests: mptcp: stop forcing iptables-legacy"),
there's no need to use ${iptables}/${ip6tables} variables anymore.
This patch drops them, and use iptables/ip6tables directly.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 20 +++++++++----------
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 16 +++++++--------
 2 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 88074f64f0a7..9b35a16a7c8b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -25,8 +25,6 @@ capout=""
 ns1=""
 ns2=""
 ksft_skip=4
-iptables="iptables"
-ip6tables="ip6tables"
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 capture=false
@@ -161,11 +159,11 @@ check_tools()
 		exit $ksft_skip
 	fi
 
-	if ! "${iptables}" -V &> /dev/null; then
-		echo "SKIP: Could not run all tests without ${iptables} tool"
+	if ! iptables -V &> /dev/null; then
+		echo "SKIP: Could not run all tests without iptables tool"
 		exit $ksft_skip
-	elif ! "${ip6tables}" -V &> /dev/null; then
-		echo "SKIP: Could not run all tests without ${ip6tables} tool"
+	elif ! ip6tables -V &> /dev/null; then
+		echo "SKIP: Could not run all tests without ip6tables tool"
 		exit $ksft_skip
 	fi
 }
@@ -348,9 +346,9 @@ reset_with_add_addr_timeout()
 
 	reset "${1}" || return 1
 
-	tables="${iptables}"
+	tables="iptables"
 	if [ $ip -eq 6 ]; then
-		tables="${ip6tables}"
+		tables="ip6tables"
 	fi
 
 	ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
@@ -414,9 +412,9 @@ setup_fail_rules()
 	local ip="${2:-4}"
 	local tables
 
-	tables="${iptables}"
+	tables="iptables"
 	if [ $ip -eq 6 ]; then
-		tables="${ip6tables}"
+		tables="ip6tables"
 	fi
 
 	ip netns exec $ns2 $tables \
@@ -475,7 +473,7 @@ reset_with_tcp_filter()
 	local src="${2}"
 	local target="${3}"
 
-	if ! ip netns exec "${ns}" ${iptables} \
+	if ! ip netns exec "${ns}" iptables \
 			-A INPUT \
 			-s "${src}" \
 			-p tcp \
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index dac8e1fc7143..722b0872f00d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -11,8 +11,6 @@ cout=""
 ksft_skip=4
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
-iptables="iptables"
-ip6tables="ip6tables"
 
 sec=$(date +%s)
 rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
@@ -26,7 +24,7 @@ add_mark_rules()
 	local m=$2
 
 	local t
-	for t in ${iptables} ${ip6tables}; do
+	for t in "iptables" "ip6tables"; do
 		# just to debug: check we have multiple subflows connection requests
 		ip netns exec $ns $t -A OUTPUT -p tcp --syn -m mark --mark $m -j ACCEPT
 
@@ -96,11 +94,11 @@ if [ $? -ne 0 ];then
 	exit $ksft_skip
 fi
 
-if ! "${iptables}" -V &> /dev/null; then
-	echo "SKIP: Could not run all tests without ${iptables} tool"
+if ! iptables -V &> /dev/null; then
+	echo "SKIP: Could not run all tests without iptables tool"
 	exit $ksft_skip
-elif ! "${ip6tables}" -V &> /dev/null; then
-	echo "SKIP: Could not run all tests without ${ip6tables} tool"
+elif ! ip6tables -V &> /dev/null; then
+	echo "SKIP: Could not run all tests without ip6tables tool"
 	exit $ksft_skip
 fi
 
@@ -109,10 +107,10 @@ check_mark()
 	local ns=$1
 	local af=$2
 
-	local tables=${iptables}
+	local tables="iptables"
 
 	if [ $af -eq 6 ];then
-		tables=${ip6tables}
+		tables="ip6tables"
 	fi
 
 	local counters values
-- 
2.40.1

