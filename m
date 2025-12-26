Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBC11DFDB8
	for <mptcp@lists.linux.dev>; Fri, 26 Dec 2025 06:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766731242; cv=none; b=I6SB4H+XSOEPfsVQzWnH0f+0s7Dz7Z2fmlvLTtgbkfJjP7CqU93x6hKXcNtTHVc4+HCQEvC1DX6AYLX4+jF5ijvJ8rmSv9lrlqj5R8p91MQGNZn0LfRs/2I5aPawFpPjV/hLUYoK/59n2ppHfICNn+sMgLLaQLCoP/Y+2uyN6bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766731242; c=relaxed/simple;
	bh=jhjMiNr5+aaFx1bqk9cS/LdE2h7vU46w6MTlQZ9d9Qk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KKgwfEUinYijqYNAVTPlKoWw6LY342t7MF4TYmvAICWTw2pNsT2o2Zpn5ZDuiOtKce32MuiaZXHdZKnuBTVLETAeg0NrP8y+2b2P6JNBYUg1RF2B8FSXLSHEvAVv+yeHO7SZNrTjDnBb/2AJbJBxIlSKP9YPYJdrokBCrMJBbPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJy3t3bE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJy3t3bE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477D5C4CEF7;
	Fri, 26 Dec 2025 06:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766731241;
	bh=jhjMiNr5+aaFx1bqk9cS/LdE2h7vU46w6MTlQZ9d9Qk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NJy3t3bEYRbssGi2WZaPZ08smw2S1AnmWm0cZtfLzW0cWKErMa4yDBgrNGg1baNUE
	 HLgqTNO7pmji5b7HdY/WE6d008v1nitJG+O4PyKn3DatBnyDq2CGu2PqIIxjUVRvC2
	 i4XSGzy1WN6CpEDrzxxRG/1JXIzsSmYpiTS2EGAuAHoQE9AbWJhPFsAIqtgS7EiNt9
	 HDE8zIIyVe7q7rXcAzvQcCEIHumjP+3TbJ+kLj5KzFC6NpdN4VSUKTaBpo6H9f1K4x
	 Q6DRwNSzg/xbd33csqgihIHV75Sbs38u17Jf7zXG0NCB7uh3WJEliqu5r3j/3EpVLn
	 ejWYbklXalUEA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 26 Dec 2025 07:40:19 +0100
Subject: [PATCH mptcp-next 05/11] selftests: mptcp: join: wait for estab
 event instead of MPJ
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251226-mptcp-issue-603-v1-5-bb30e331b839@kernel.org>
References: <20251226-mptcp-issue-603-v1-0-bb30e331b839@kernel.org>
In-Reply-To: <20251226-mptcp-issue-603-v1-0-bb30e331b839@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3978; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=jhjMiNr5+aaFx1bqk9cS/LdE2h7vU46w6MTlQZ9d9Qk=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDL9dO/9j5pnuPD/vxdrpi5dGbBI0jCqsYZrg+xElZ2M/
 FI/lx5R6yhlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZjIBR2G/w5bdXcmpWo+mnj+
 9erNJirXwmJqurdHBs1b8mvrmdeGbQkM/5S4vwc53YzhPu/9QbBur9MhpWVKgvEa6mv4/nNUx9s
 KMwIA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

'wait_mpj' was used just after having created a background connection,
but before creating new subflows. So no MPJ were sent. The intention was
to wait for the connection to be established, which was the same as
doing a simple sleep with a "random" value.

Instead, wait for an "established" event. With this, the tests can
finish quicker.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index bf0cc59b5210..9b58d7567c18 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4000,7 +4000,7 @@ userspace_tests()
 		{ timeout_test=120 test_linkfail=128 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
-		wait_mpj $ns1
+		wait_event ns1 MPTCP_LIB_EVENT_ESTABLISHED 1
 		userspace_pm_add_addr $ns1 10.0.2.1 10
 		userspace_pm_add_addr $ns1 10.0.3.1 20
 		chk_join_nr 2 2 2
@@ -4033,7 +4033,7 @@ userspace_tests()
 		{ timeout_test=120 test_linkfail=128 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
-		wait_mpj $ns2
+		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
 		userspace_pm_add_sf $ns2 10.0.3.2 20
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
@@ -4061,7 +4061,7 @@ userspace_tests()
 		{ timeout_test=120 test_linkfail=128 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
-		wait_mpj $ns2
+		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		userspace_pm_add_sf $ns2 10.0.3.2 0
@@ -4082,7 +4082,7 @@ userspace_tests()
 		{ timeout_test=120 test_linkfail=128 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
-		wait_mpj $ns2
+		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
 		userspace_pm_add_sf $ns2 10.0.3.2 20
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
@@ -4106,7 +4106,7 @@ userspace_tests()
 		{ timeout_test=120 test_linkfail=128 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
-		wait_mpj $ns1
+		wait_event ns1 MPTCP_LIB_EVENT_ESTABLISHED 1
 		userspace_pm_add_addr $ns1 10.0.2.1 10
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
@@ -4159,6 +4159,7 @@ endpoint_tests()
 	# userspace pm type prevents add_addr
 	if reset "implicit EP" &&
 	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		start_events
 		pm_nl_set_limits $ns1 2 2
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
@@ -4166,7 +4167,7 @@ endpoint_tests()
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 
-		wait_mpj $ns1
+		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
 		pm_nl_check_endpoint "creation" \
 			$ns2 10.0.2.2 id 1 flags implicit
 		chk_mptcp_info subflows 1 subflows 1
@@ -4180,6 +4181,7 @@ endpoint_tests()
 		pm_nl_check_endpoint "modif is allowed" \
 			$ns2 10.0.2.2 id 1 flags signal
 		mptcp_lib_kill_group_wait $tests_pid
+		kill_events_pids
 	fi
 
 	if reset_with_tcp_filter "delete and re-add" ns2 10.0.3.2 REJECT OUTPUT &&
@@ -4193,7 +4195,7 @@ endpoint_tests()
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 
-		wait_mpj $ns2
+		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
 		pm_nl_check_endpoint "creation" \
 			$ns2 10.0.2.2 id 2 flags subflow dev ns2eth2
 		chk_subflow_nr "before delete id 2" 2
@@ -4271,7 +4273,7 @@ endpoint_tests()
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 
-		wait_mpj $ns2
+		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
 		pm_nl_check_endpoint "creation" \
 			$ns1 10.0.2.1 id 1 flags signal
 		chk_subflow_nr "before delete" 2

-- 
2.51.0

