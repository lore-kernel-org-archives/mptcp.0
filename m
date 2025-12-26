Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8481DFDB8
	for <mptcp@lists.linux.dev>; Fri, 26 Dec 2025 06:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766731242; cv=none; b=ikD1u99MzL4y1JrVAKKPLI7MHJJYtBnQ4VUFONCcwUcF3HRb/GslWcUrGiU6W5gIzZAmEg56m3pyFBtbsbROkURXGXK+s4NJPxm/zUilOUWwlht67bXb0OpsQgr9BiMvyqLKwX31t1SJFbQyECi5E0mxnXQkR+qxalRU3SAOHOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766731242; c=relaxed/simple;
	bh=I6g/CxaHeQnEBKjAuNkEnCV5RoXjeg6XVnG+uN9y91w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cdLVa3qLU74HeiKw7tPpZZPoNhxPfrAT1K8ieo5Tf1H7GYtmuv+lvoCaRaXKTMUaCs+WhLVujfe1l+Qep/dpQXsFpM9el3cYZecrqIhw7lsIUPVSLCJHDPoAuCTqMT2MEkMJzU3+LR9V9auRHAsYGsdVBMvE755z0ueVzyQAW3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxBa6Yqh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxBa6Yqh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E713C116D0;
	Fri, 26 Dec 2025 06:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766731242;
	bh=I6g/CxaHeQnEBKjAuNkEnCV5RoXjeg6XVnG+uN9y91w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZxBa6YqhKNOyA9zsPSSu3oZp3NOdJfz9yLTZBSEeK+jEZ+EQiEkN/hWOXNun6VwAb
	 S2M1IXIfC0ahNJ/UJbhtWIIa01h3ez+1fjxCAXJnWy8OcOweAjV/o9xE6O2irdtaId
	 SqoCpgcWS+yaPJCT2syJovOZgupwTPCwTcaUrmUIsRJYGMTAQtqEtPzuRp0S0VM/e/
	 lAn2AnBDo/P8Ue3hVtu19u+Tuxy7XM8Kmv17/xZeDuyZ5+S+DocPzJaWYX+K2DaZSJ
	 d1UEZ5DD7ulm3TmbbzfLLkRW3dcD+Rg7XoDV/B779i7ZdgooQ7+NOO4Z/OXVEYkyOi
	 Etb6BzSzb5y2A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 26 Dec 2025 07:40:20 +0100
Subject: [PATCH mptcp-next 06/11] selftests: mptcp: join: fix wait_mpj
 helper
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251226-mptcp-issue-603-v1-6-bb30e331b839@kernel.org>
References: <20251226-mptcp-issue-603-v1-0-bb30e331b839@kernel.org>
In-Reply-To: <20251226-mptcp-issue-603-v1-0-bb30e331b839@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4182; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=I6g/CxaHeQnEBKjAuNkEnCV5RoXjeg6XVnG+uN9y91w=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDL9dO9HKvkJfbrIekKsS+vGI8/c3YkhO5levKo6l5CcM
 fl0p55GRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwER4XRj+Ry8tvJyz8Pi8uV05
 uiu+lv/+qrWrKeCwamlCb5FWD4sdH8Mv5oQW0yzmrdNuXKte9+vDc+atvmKdqhMmFUvyNf+7EMz
 PDAA=
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
index 9b58d7567c18..cf28537b71f7 100755
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

