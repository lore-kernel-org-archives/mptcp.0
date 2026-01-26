Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E2727B34F
	for <mptcp@lists.linux.dev>; Mon, 26 Jan 2026 19:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769455493; cv=none; b=nhiFi3D8zLstLYB2RwxMVaBvLm2Rkew7P1CyrFRen71Ueti4YfjSPZ7g17E1mwT2+bkzNV359xx6TtJBImJtvP4vz5qiPTtxroaUpQj5p+IMhUNCy2BWQnlMkxg7FoUbFxr/XDMUKPMijhl7GbiyNSHeRgKL3zuaIRMDBCTE2oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769455493; c=relaxed/simple;
	bh=mEMkY0k39eIndONhSfyg0mNTQ9E/68On4Ffvhp63Ejs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DrrczuDrC1d+jmH+kft9Fmiif4nN/9nKycd+XyYSO+wA/T5N/8zRIDvO61kgw264sUS0XjK2V1I1Gu1OT3hGTtzQwp1Gw/rIOjKXrkM+6pzaFbLyu8RlkNAkMtOEVFA/yd0I0cs9iLurbufX1FCwTgrU8JX1/0aJvpGGQ4JrT1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okkjaIZy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okkjaIZy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF2DC19425;
	Mon, 26 Jan 2026 19:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769455492;
	bh=mEMkY0k39eIndONhSfyg0mNTQ9E/68On4Ffvhp63Ejs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=okkjaIZyHL7tqKXBxPmAsTpM30AkacGsBer0nWhi+TgkDHPuhGXMMQi+oQ4+UK562
	 9f1bkd6CplYQVAE2N7m9A0Oe54hCEcRo/H5BsxxPjEmWPgGgMEGtJSKZBLS8q/R3VL
	 m5yFvF3QC0W/hj5gwWmKFHg0y5QAy4bLlQ1PCmFMutUoOfR9+xd8N03tXvVQ13Kxm2
	 l5IbKbgvrQ/uku4cZ+wjBhpGzQbzfcme4duD9lBmWJ6xciCdgiUULwuHlm+9qJIIgT
	 REpCUyvhb1vh3vw5bLRlbvAyx8IAv3dxbZJOqoN20oETs2NDFgq8mmf66Lihs9tNS6
	 p6gstbpn9IFxw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 26 Jan 2026 20:18:42 +0100
Subject: [PATCH mptcp-net v2 05/11] selftests: mptcp: join: wait for estab
 event instead of MPJ
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-mptcp-issue-603-v2-5-8393e7840b9e@kernel.org>
References: <20260126-mptcp-issue-603-v2-0-8393e7840b9e@kernel.org>
In-Reply-To: <20260126-mptcp-issue-603-v2-0-8393e7840b9e@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4100; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=mEMkY0k39eIndONhSfyg0mNTQ9E/68On4Ffvhp63Ejs=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLL91dru55Ijry/oDzuE9eD/yl/9/U5TChZpc/8pt++4
 shsJY+OjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIk8kWBkOJE8L2r/T64625QT
 JemNd82WG7h0Hn4p57CbdXnEsscLUxgZ5h3c1RfKK3bn0w7VmvnidyY6p7N2vzwiES/6O8aVJVu
 fDwA=
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
v2: use reset_with_events instead of starting them manually (Geliang)
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index e70d3420954f..ff20d86ed399 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3999,7 +3999,7 @@ userspace_tests()
 		{ timeout_test=120 test_linkfail=128 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
-		wait_mpj $ns1
+		wait_event ns1 MPTCP_LIB_EVENT_ESTABLISHED 1
 		userspace_pm_add_addr $ns1 10.0.2.1 10
 		userspace_pm_add_addr $ns1 10.0.3.1 20
 		chk_join_nr 2 2 2
@@ -4032,7 +4032,7 @@ userspace_tests()
 		{ timeout_test=120 test_linkfail=128 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
-		wait_mpj $ns2
+		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
 		userspace_pm_add_sf $ns2 10.0.3.2 20
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
@@ -4060,7 +4060,7 @@ userspace_tests()
 		{ timeout_test=120 test_linkfail=128 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
-		wait_mpj $ns2
+		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		userspace_pm_add_sf $ns2 10.0.3.2 0
@@ -4081,7 +4081,7 @@ userspace_tests()
 		{ timeout_test=120 test_linkfail=128 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
-		wait_mpj $ns2
+		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
 		userspace_pm_add_sf $ns2 10.0.3.2 20
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
@@ -4105,7 +4105,7 @@ userspace_tests()
 		{ timeout_test=120 test_linkfail=128 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
-		wait_mpj $ns1
+		wait_event ns1 MPTCP_LIB_EVENT_ESTABLISHED 1
 		userspace_pm_add_addr $ns1 10.0.2.1 10
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
@@ -4158,7 +4158,7 @@ endpoint_tests()
 {
 	# subflow_rebuild_header is needed to support the implicit flag
 	# userspace pm type prevents add_addr
-	if reset "implicit EP" &&
+	if reset_with_events "implicit EP" &&
 	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 2 2
 		pm_nl_set_limits $ns2 2 2
@@ -4167,7 +4167,7 @@ endpoint_tests()
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 
-		wait_mpj $ns1
+		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
 		pm_nl_check_endpoint "creation" \
 			$ns2 10.0.2.2 id 1 flags implicit
 		chk_mptcp_info subflows 1 subflows 1
@@ -4181,6 +4181,7 @@ endpoint_tests()
 		pm_nl_check_endpoint "modif is allowed" \
 			$ns2 10.0.2.2 id 1 flags signal
 		mptcp_lib_kill_group_wait $tests_pid
+		kill_events_pids
 	fi
 
 	if reset_with_tcp_filter "delete and re-add" ns2 10.0.3.2 REJECT OUTPUT &&
@@ -4194,7 +4195,7 @@ endpoint_tests()
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 
-		wait_mpj $ns2
+		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
 		pm_nl_check_endpoint "creation" \
 			$ns2 10.0.2.2 id 2 flags subflow dev ns2eth2
 		chk_subflow_nr "before delete id 2" 2
@@ -4272,7 +4273,7 @@ endpoint_tests()
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 
-		wait_mpj $ns2
+		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
 		pm_nl_check_endpoint "creation" \
 			$ns1 10.0.2.1 id 1 flags signal
 		chk_subflow_nr "before delete" 2

-- 
2.51.0

