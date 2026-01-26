Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F71C283FF5
	for <mptcp@lists.linux.dev>; Mon, 26 Jan 2026 19:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769455493; cv=none; b=ZmIYPtnoX5F/ega57ihZ0dVpCGD+E9wc/TK0DNnR5DCzyWRDQjaE7kkUlLo4n2oEMKDBfVQgpbFzNqHcU3PN+9L+oe+R3ouELXoelzPUHO7Bn+yYQUdqeHsE2toYA1XzV4aSUjFEzg1w537lKj0cR5xytZmYXMIZZF7Ov83si88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769455493; c=relaxed/simple;
	bh=UHERAxu10ZJ+RINGroNmczXSgLe6VESbXo9pE/t+mXs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AnqhJGdGGrqh3B3xNNEr9nwpDHQU7tUVWRI27/36SWeQbc3XXeqntLTFBDFtpFr6Uxavfzp9bvX+WVv9ed+PK1Gsr+KCMqEsY7jqTz5ddbVo5wJp1VfhkP3hq5rWdTPAwNzSPpULV61VPq+go7eIjlzKzefdj21Y97ch4ejxUxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GE/eSuC4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GE/eSuC4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C26C19422;
	Mon, 26 Jan 2026 19:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769455493;
	bh=UHERAxu10ZJ+RINGroNmczXSgLe6VESbXo9pE/t+mXs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GE/eSuC4MrSHZcKyuz7Gp+ZPuNkVG0uy4diNzRn9x3ouqkchBQTbQ9prWIBXPS32Y
	 dUy3F9QhBPMPb4BuBUajRWCDhkIaC8/RHObERYCn7emwCUnnvrc+l6NT1CYF4A9k9P
	 iIzhjXYa02JIA8MXEqhJRsRMSj0kf9fQsvyyaUjmYDfA7lS8hiYAtoZKScvDZlkDXS
	 XMOZgt2ZPY6jh35KNMmpdXbn5ecTVcUaZbQB1Jmp3svcHE220y8bRN4VJijczel55I
	 j1QXiDd/sfvQ898v3R9Ivvd301m4onxsJofpUE6cnaYXUR4BdW4HyKAiog9FVrNLdU
	 e+nd0dqcCEslw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 26 Jan 2026 20:18:43 +0100
Subject: [PATCH mptcp-net v2 06/11] selftests: mptcp: join: fix wait_mpj
 helper
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-mptcp-issue-603-v2-6-8393e7840b9e@kernel.org>
References: <20260126-mptcp-issue-603-v2-0-8393e7840b9e@kernel.org>
In-Reply-To: <20260126-mptcp-issue-603-v2-0-8393e7840b9e@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4182; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=UHERAxu10ZJ+RINGroNmczXSgLe6VESbXo9pE/t+mXs=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLL99c4ztmRpvA5ZWLVOVF3+U/9r5f9udOXVbG+4ZNqm
 sVFs/ffO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACby9gPDXyEh64dmU6fkLzod
 b1DM8kZgXkOiQrlDQn1bhW78+YpdDQz/c+WmixxpFquRUvlwXn2i8aPPjJveCimaGjhlra2fVvq
 ZBwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It looks like most of the time, this helper was simply waiting a bit
more than one second: the previous MPJoin counter was often already at
the expected value. So at the end, it was just checking 10 times for
the MPJoin counter to change, but it was not happening. For the tests,
that was time, it was just waiting longer for nothing.

Instead, use 'wait_mpj' with the expected counter: in the tests, the MPJ
counter can easily be predicted. While at it, stop passing the netns as
argument: here the received MPJoin ACK is checked, which happens on the
server side. If later on, this needs to be checked on the client side,
the helper can be adapted for this case, but better avoid confusions now
if it is not needed.

While at it, stop using 'i' for the variable if it is not used.

With this, the tests can finish quicker.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 30 ++++++++++++-------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ff20d86ed399..6ab568d6b856 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -631,17 +631,15 @@ wait_rm_sf()
 	done
 }
 
+# $1: expected MPJ ACK Rx counter in $ns1
 wait_mpj()
 {
-	local ns="${1}"
-	local cnt old_cnt
+	local exp_cnt="${1}"
+	local cnt
 
-	old_cnt=$(mptcp_lib_get_counter ${ns} "MPTcpExtMPJoinAckRx")
-
-	local i
-	for i in $(seq 10); do
-		cnt=$(mptcp_lib_get_counter ${ns} "MPTcpExtMPJoinAckRx")
-		[ "$cnt" = "${old_cnt}" ] || break
+	for _ in $(seq 10); do
+		cnt=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinAckRx")
+		[ "${cnt}" = "${exp_cnt}" ] && break
 		sleep 0.1
 	done
 }
@@ -4207,7 +4205,7 @@ endpoint_tests()
 		chk_mptcp_info subflows 0 subflows 0
 
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
-		wait_mpj $ns2
+		wait_mpj 2
 		chk_subflow_nr "after re-add id 2" 2
 		chk_mptcp_info subflows 1 subflows 1
 
@@ -4219,7 +4217,7 @@ endpoint_tests()
 		ip netns exec "${ns2}" ${iptables} -D OUTPUT -s "10.0.3.2" -p tcp -j REJECT
 		pm_nl_del_endpoint $ns2 3 10.0.3.2
 		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
-		wait_mpj $ns2
+		wait_mpj 3
 		chk_subflow_nr "after no reject" 3
 		chk_mptcp_info subflows 2 subflows 2
 
@@ -4231,7 +4229,7 @@ endpoint_tests()
 			chk_mptcp_info subflows 2 subflows 2 # only decr for additional sf
 
 			pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
-			wait_mpj $ns2
+			wait_mpj $((3 + i))
 			chk_subflow_nr "after re-add id 0 ($i)" 3
 			chk_mptcp_info subflows 3 subflows 3
 		done
@@ -4289,7 +4287,7 @@ endpoint_tests()
 
 		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.3.1 id 2 flags signal
-		wait_mpj $ns2
+		wait_mpj 3
 		chk_subflow_nr "after re-add" 3
 		chk_mptcp_info subflows 2 subflows 2
 		chk_mptcp_info add_addr_signal 2 add_addr_accepted 2
@@ -4301,7 +4299,7 @@ endpoint_tests()
 		chk_mptcp_info add_addr_signal 2 add_addr_accepted 2
 
 		pm_nl_add_endpoint $ns1 10.0.1.1 id 99 flags signal
-		wait_mpj $ns2
+		wait_mpj 4
 		chk_subflow_nr "after re-add ID 0" 3
 		chk_mptcp_info subflows 3 subflows 3
 		chk_mptcp_info add_addr_signal 3 add_addr_accepted 2
@@ -4313,7 +4311,7 @@ endpoint_tests()
 		chk_mptcp_info add_addr_signal 2 add_addr_accepted 2
 
 		pm_nl_add_endpoint $ns1 10.0.1.1 id 88 flags signal
-		wait_mpj $ns2
+		wait_mpj 5
 		chk_subflow_nr "after re-re-add ID 0" 3
 		chk_mptcp_info subflows 3 subflows 3
 		chk_mptcp_info add_addr_signal 3 add_addr_accepted 2
@@ -4362,9 +4360,9 @@ endpoint_tests()
 		wait_rm_addr $ns2 0
 		ip netns exec "${ns2}" ${iptables} -D OUTPUT -s "10.0.3.2" -p tcp -j REJECT
 		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
-		wait_mpj $ns2
+		wait_mpj 1
 		pm_nl_add_endpoint $ns1 10.0.3.1 id 2 flags signal
-		wait_mpj $ns2
+		wait_mpj 2
 		mptcp_lib_kill_group_wait $tests_pid
 
 		join_syn_tx=3 join_connect_err=1 \

-- 
2.51.0

