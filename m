Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08069129A74
	for <mptcp@lists.linux.dev>; Fri, 19 Jul 2024 12:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721391887; cv=none; b=tZS4hSf7/TFe2/hq1cQ3ktNCnVC720BxYVEXQEJPF3HKtBds+jRbnKC6Qv2Af39vCItmSIa4WLNOX19RCtLUpmgmDrDiuhOFPRSnhfx+dKdmy2JLfty1shjWYJ/0XMfWYW3PQlHF5iOLzFfqLcUvZI5lygHpILXwK+3hG5lrRqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721391887; c=relaxed/simple;
	bh=u8qIDXTTzowhUR4HkW0eiXruuNaZM+rGz61FM/Q9y9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UAEj4xApNyYN2cTP8bWon18IKhuLdlOEKC8uG6A1NOU87w+RKFrSAMa4ST1Q6IUlUIqRNYifjY/yo73nkkUmc3zLEW7RppmRvZNBX7uDX2o+MjC2PN7FR16WOfb7ik9v4UwSKGB8pWwf77PKa1QssVTWYbe605cZBGOel927XlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOkn2Hlz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOkn2Hlz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB5B8C4AF09;
	Fri, 19 Jul 2024 12:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721391886;
	bh=u8qIDXTTzowhUR4HkW0eiXruuNaZM+rGz61FM/Q9y9Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MOkn2HlzCZTguN65XebG77t3Tm8PUbWShKVf5nRK3L3KBvB1Rs2H91YxkzorVo7uI
	 fSrFFseyqOnsZF562mrnnXBF8Cfo814CZ6ewxZnlOQvyDrLRYU37V/XKT7Vb7TpuFv
	 wv40ERBJOld5yg9HkRqgquB1X5R0Rumrg50UO5BR8um5k2/fia3eif2DxcQPAbcHGq
	 +87s1EQli604blKOJFk32CkiyQSz3PAqkTsrq+egyk0rMT1SMDRwSUgf15y46+ggoD
	 cFCB79RpOrrqGGp94s+4ddrsXpgzvH6wYEEywRsterbHO2mp3P/pCXqU0laOLuKlNF
	 Pi2H1i/Lug6IQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 19 Jul 2024 14:24:22 +0200
Subject: [PATCH mptcp-net v3 11/20] selftests: mptcp: join: check re-using
 ID of closed subflow
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-mptcp-pm-avail-v3-11-e96b5591ced3@kernel.org>
References: <20240719-mptcp-pm-avail-v3-0-e96b5591ced3@kernel.org>
In-Reply-To: <20240719-mptcp-pm-avail-v3-0-e96b5591ced3@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2972; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=u8qIDXTTzowhUR4HkW0eiXruuNaZM+rGz61FM/Q9y9Y=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmmlsA31vFyHPIJV8QXPZvOToF3f7OsZL3zRy83
 mk9pbA2xyKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZppbAAAKCRD2t4JPQmmg
 c2PxEADqAL6/Dl178kja6geiCS/rSWrEROC0g/U50j1AVTDGl0Xvg24VruT1ih9o+Y+49g9oKlc
 Lf79XLp0WDFiKTmAChWvsMNOQq4/kIpDXBRVXbZKiaLfWz+3IYhTxxxCUrtY/EUzxs5tLYxJjPy
 fCgoSPb52Dxbj+RVky0if9JnFZWN8K7+wt7+Qu5zEMiqRAqExb0SPyY6EaDQUoaw6vCPfaJus+8
 NMiBQleyfUAexNtS6ieE+KIpN7h85z/xQA4J/P7WqPvrgcSUFAl0zOgxALFapaxjaG1ld4z8p9D
 DT3Q3+JI23xJeVxyLq1c0oWcQ3kEO6/HIEDATh+r0bMa8it8uN9NvmIFG0W9mR1jusF5lLefJfx
 fQN9nLceNWMiX9Joezax5L7WpU42Eso4ye09Iymn1Qn2eIs7gqNM6r+jGQcjwLJKpPyH8RnbDXC
 haFYeo2peM2hTZaMyD0MfT/jyTo/EyXiZVpdiAW8afTbw/o2bJ/Gqe4ey+NhfmdEP+tFqLvea8C
 p1VLpkmf0a9QIyWmZdemwK1O1zbEq4w1CeoON/wfW2HDV3IlJPRMXi26TCo8NcxFOEf0awcyKbP
 bYOSuRf9AmwgTGzPgdJ6O2BPzK1lfn7NRDj0AFimt0ZXysTDr9D+Dfds6tQyZpytrG+aLsWHyl0
 cadCAy18YE1M7YQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This test extends "delete and re-add" to validate the previous commit. A
new 'subflow' endpoint is added, but the subflow request will be
rejected. The result is that no subflow will be established from this
address.

Later, the endpoint is removed and re-added after having cleared the
firewall rule. Before the previous commit, the client would not have
been able to create this new subflow.

While at it, extra checks have been added to validate the expected
numbers of MPJ and RM_ADDR.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: b6c08380860b ("mptcp: remove addr and subflow in PM netlink")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 27 ++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b4dc5f2772dc..c5aa745a36f5 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -436,9 +436,10 @@ reset_with_tcp_filter()
 	local ns="${!1}"
 	local src="${2}"
 	local target="${3}"
+	local chain="${4:-INPUT}"
 
 	if ! ip netns exec "${ns}" ${iptables} \
-			-A INPUT \
+			-A "${chain}" \
 			-s "${src}" \
 			-p tcp \
 			-j "${target}"; then
@@ -3527,10 +3528,10 @@ endpoint_tests()
 		mptcp_lib_kill_wait $tests_pid
 	fi
 
-	if reset "delete and re-add" &&
+	if reset_with_tcp_filter "delete and re-add" ns2 10.0.3.2 REJECT OUTPUT &&
 	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
-		pm_nl_set_limits $ns1 1 1
-		pm_nl_set_limits $ns2 1 1
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
 		test_linkfail=4 speed=20 \
 			run_tests $ns1 $ns2 10.0.1.1 &
@@ -3547,11 +3548,27 @@ endpoint_tests()
 		chk_subflow_nr "after delete" 1
 		chk_mptcp_info subflows 0 subflows 0
 
-		pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
+		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
 		wait_mpj $ns2
 		chk_subflow_nr "after re-add" 2
 		chk_mptcp_info subflows 1 subflows 1
+
+		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
+		wait_attempt_fail $ns2
+		chk_subflow_nr "after new reject" 2
+		chk_mptcp_info subflows 1 subflows 1
+
+		ip netns exec "${ns2}" ${iptables} -D OUTPUT -s "10.0.3.2" -p tcp -j REJECT
+		pm_nl_del_endpoint $ns2 3 10.0.3.2
+		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
+		wait_mpj $ns2
+		chk_subflow_nr "after no reject" 3
+		chk_mptcp_info subflows 2 subflows 2
+
 		mptcp_lib_kill_wait $tests_pid
+
+		chk_join_nr 3 3 3
+		chk_rm_nr 1 1
 	fi
 
 	# remove and re-add

-- 
2.45.2

