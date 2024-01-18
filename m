Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BC42D058
	for <mptcp@lists.linux.dev>; Thu, 18 Jan 2024 18:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705602482; cv=none; b=mHWRWezSf5Vlkm6laCiF9TCrrAQENe9Si6ucEkmnaoUCbaGOdB1ypMPYnxEXdJ0WIUo2eMnbRnIZOAzd6Q/SYcHntLpw8/03d8bhzf/1YiQZgBKFLCHsAQis0Tke29HZa8cDmdpkfa5/Su3ca49pNrd8jQXL4vrVEnXpMKjDmMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705602482; c=relaxed/simple;
	bh=Zx8ztWLbl0Ls8/1ZWr3YYT7es5suQ4BXikDCsEYKYe8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NKJgVzlgKyKuN5opCCe5tRLEGSK+Qlg0RE0aUuC8EeNeIej356HdZRIfFxcryGyjUSL2xXkDmpHAQy/sHc930Nw/LjOQARhdfzsBshhVGsYlPPREyWm1AT2n3ZGacfUJJRMoDxi9EJZ7hhp5P+ri8Vncye1MSANnypA2ll0JOH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEhuBR3s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEhuBR3s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44597C43390;
	Thu, 18 Jan 2024 18:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705602481;
	bh=Zx8ztWLbl0Ls8/1ZWr3YYT7es5suQ4BXikDCsEYKYe8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XEhuBR3sh0cgK1hmQOOAbdC9+wdxjjNDnQwCYWBXd10B6miXw9kQu2JDuFtC3gXxT
	 H1cxbqLJqrjMT+xLNSnWun1aFL+JXIE7WUYHkB9kSTKdJL5mQLOw5Q1W73Vjk8WOQf
	 D0j98A8EuFW+iWfQvDTwFYHh6vh6tijkehBuEI80p5NuRtLGTD9JNC4nNcyG9wT8kY
	 1d0SsuYbi7ZM+JhKK30D3AtT5Nm43r6Ke2zJvjhTCRqkWQGG8l6wsF/1WXI676RQh8
	 JRqugD5Pqo1U4JmvZepyeEtzodoPKDjaZvWuv+eb3tCYmg4StliekjLAwHJ8v5EmvY
	 lhTHHHy/cV6Nw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 18 Jan 2024 19:27:37 +0100
Subject: [PATCH mptcp-next 7/7] selftests: mptcp: join: stop transfer when
 check is done
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240118-selftests-mptcp-simult-slack-qemu-no-kvm-v1-7-f3a4db41c3be@kernel.org>
References: <20240118-selftests-mptcp-simult-slack-qemu-no-kvm-v1-0-f3a4db41c3be@kernel.org>
In-Reply-To: <20240118-selftests-mptcp-simult-slack-qemu-no-kvm-v1-0-f3a4db41c3be@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3655; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Zx8ztWLbl0Ls8/1ZWr3YYT7es5suQ4BXikDCsEYKYe8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlqW2pgKGq3532IYnGb4eQT9iFh/Rx/DGdKU7Ct
 Erc4GOctLGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZaltqQAKCRD2t4JPQmmg
 c1I6D/9s8raZRnnKN0mFWlckOs1E+sDrFHYkuo2E6flGWvrrXaNn/aTU54XVw+imE/GuGn7gJgT
 5uC9FJSlKBsozDHhpi0Gf/oy8x1DctLureS+FGY9ZEkU4buPgM50l5KNg6786nKwbkgPBQUBXXH
 jnar13MNzh8DsJfmEH2D7Au7aoHjzRkHZpxvZk9h+K2ercx7ZW0aFCKGmtGWYsUNkUEeyPbRXQ7
 j4WKAhzHhrLk4bapgQSP77XQUbOJjR8FK4fPoJtTpz8YL+kQybIXBi4AFjKkPK599y0YTLm2RNq
 vlj9syAx0ujFg2kq4sPZEAGP2Ce+roakTHwYnMg3OzugrouoENmoFWYbt+95luZ1/6Cnjh0RTvf
 k7noWcdf8mKm5QXa7asqACuhbMYsRRwLTosYAG5BMxmaEaisII+fII9l/P6Ow4pBoheshxTcK2j
 DeIb6lI1PZlF/9cZBNy7GW5SNP6Jgu7Lu01DfmO4uxSZ3RnmqUGh+CS2SBOjIrte9SF9C+nQz6v
 lOYKtKYHeRWHS6d8Fgf5EH2LVDfGHs2t3PdmJscmK6NfHiAhrqQjmbClQ0yyoyt6n+Na+bUMUMO
 qmsOLK50ogcJRFma5kFnR/046/f8I9cXIIlbx3PWpw5qBCGCGfC2WTfuXxJhxrOBEXIJKPennCu
 wt6DguqoEai/UaQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Since the mentioned commit, the "userspace pm" tests of mptcp_join
selftests are launching the whole transfer in the background, do the
required checks, then wait for the end of transfer.

There is no need to wait longer, especially because the checks at the
end of the transfer are ignored (which is fine). This saves quite a few
seconds on slow environments.

While at it, use 'mptcp_lib_kill_wait()' helper everywhere, instead of
on a specific one with 'kill_tests_wait()'. Note that old versions will
need commit bdbef0a6ff10 ("selftests: mptcp: add mptcp_lib_kill_wait")
as well.

Fixes: 4369c198e599 ("selftests: mptcp: test userspace pm out of transfer")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 27 ++++++++++---------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 3a5b63026191..c07386e21e0a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -643,13 +643,6 @@ kill_events_pids()
 	mptcp_lib_kill_wait $evts_ns2_pid
 }
 
-kill_tests_wait()
-{
-	#shellcheck disable=SC2046
-	kill -SIGUSR1 $(ip netns pids $ns2) $(ip netns pids $ns1)
-	wait
-}
-
 pm_nl_set_limits()
 {
 	local ns=$1
@@ -3453,7 +3446,7 @@ userspace_tests()
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		kill_events_pids
-		wait $tests_pid
+		mptcp_lib_kill_wait $tests_pid
 	fi
 
 	# userspace pm create destroy subflow
@@ -3475,7 +3468,7 @@ userspace_tests()
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		kill_events_pids
-		wait $tests_pid
+		mptcp_lib_kill_wait $tests_pid
 	fi
 
 	# userspace pm create id 0 subflow
@@ -3494,7 +3487,7 @@ userspace_tests()
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
 		kill_events_pids
-		wait $tests_pid
+		mptcp_lib_kill_wait $tests_pid
 	fi
 
 	# userspace pm remove initial subflow
@@ -3518,7 +3511,7 @@ userspace_tests()
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 1 1
 		kill_events_pids
-		wait $tests_pid
+		mptcp_lib_kill_wait $tests_pid
 	fi
 
 	# userspace pm send RM_ADDR for ID 0
@@ -3544,7 +3537,7 @@ userspace_tests()
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 1 1
 		kill_events_pids
-		wait $tests_pid
+		mptcp_lib_kill_wait $tests_pid
 	fi
 }
 
@@ -3558,7 +3551,8 @@ endpoint_tests()
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		speed=slow \
-			run_tests $ns1 $ns2 10.0.1.1 2>/dev/null &
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
 
 		wait_mpj $ns1
 		pm_nl_check_endpoint "creation" \
@@ -3573,7 +3567,7 @@ endpoint_tests()
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags signal
 		pm_nl_check_endpoint "modif is allowed" \
 			$ns2 10.0.2.2 id 1 flags signal
-		kill_tests_wait
+		mptcp_lib_kill_wait $tests_pid
 	fi
 
 	if reset "delete and re-add" &&
@@ -3582,7 +3576,8 @@ endpoint_tests()
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
 		test_linkfail=4 speed=20 \
-			run_tests $ns1 $ns2 10.0.1.1 2>/dev/null &
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
 
 		wait_mpj $ns2
 		chk_subflow_nr "before delete" 2
@@ -3597,7 +3592,7 @@ endpoint_tests()
 		wait_mpj $ns2
 		chk_subflow_nr "after re-add" 2
 		chk_mptcp_info subflows 1 subflows 1
-		kill_tests_wait
+		mptcp_lib_kill_wait $tests_pid
 	fi
 }
 

-- 
2.43.0

