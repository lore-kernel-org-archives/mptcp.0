Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E2118629E
	for <mptcp@lists.linux.dev>; Mon, 15 Jul 2024 10:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721038213; cv=none; b=XBmndx7Z/1HSCfZZHxGxNuCPGMrc8RvXSEboD6z65MuSNc5QayQc2toqVxs01Xcasrwh3iJPbSJkSQyf6YtY0mvf2b4Tc3A9/N2qyVgP945xcQb0Sfbdpz720/WTUDiqQ6YKysvqHN810Fo7WqvOSc/B/04wADoHFIxeUUwwvsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721038213; c=relaxed/simple;
	bh=IZLmMEPKaTI0ecetyxX+ZJUmzHaA8vdoxLN3U+l3uKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hLE0y7qh01vaya3fvePb6IHDXObHyANIk5pEj/ArZL3eRNpsk0jSfDoQZ5rKAv4H+gtr2khV2L8ypk1P3EQMGn67yabmODt0/h60K/X4v+nq6XAMF5k5df53PZ9XuKyOlDMg8KuBVTBLUyVXXBM0/Bf40+hR8cHugBw89gdYW5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYgnCLHk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYgnCLHk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8293DC4AF0B;
	Mon, 15 Jul 2024 10:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721038213;
	bh=IZLmMEPKaTI0ecetyxX+ZJUmzHaA8vdoxLN3U+l3uKA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LYgnCLHkC3g6oWhSduC3UBv9CDDBCXd6d1EPYB9EF/4JtsxfuZ7MrYQuaQENLOilB
	 z48h9+j5tj/duETNCkeEUGObb3SbaEqLU5vaVA20ZcUye5cyxnjGT+gCls/I8GB0rW
	 SUskY4rOD2jlsnOaotVSYMmh+M75zLaU4McNxjfcdNPCt9h7L4p2K18pON+2qfmNVt
	 ANECHMspgpV67xud65qss4fPoMT1CswtT1w8vFxT35vn36yf7N26+eigiOxiwxo2Rv
	 3F6uuuiGB2Kwc7heItCivUaV+8YAvoW5HZ/pK1FYoIXZHtSGqHCjAW74jbhBa/VACM
	 9tJHV5fUzO4gw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 15 Jul 2024 12:09:47 +0200
Subject: [PATCH mptcp-net v2 09/17] selftests: mptcp: join: check re-using
 ID of unused ADD_ADDR
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-mptcp-pm-avail-v2-9-fc5153bd1f6e@kernel.org>
References: <20240715-mptcp-pm-avail-v2-0-fc5153bd1f6e@kernel.org>
In-Reply-To: <20240715-mptcp-pm-avail-v2-0-fc5153bd1f6e@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2591; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=IZLmMEPKaTI0ecetyxX+ZJUmzHaA8vdoxLN3U+l3uKA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmlPV3Dzgx+mAyPSFhH/O3Xvt8e2+J84oy6fohn
 k+dEJfQaj2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZpT1dwAKCRD2t4JPQmmg
 c85KEAClgt1k/UPUT09zPZyLy6FnVPmzEAW3WchKapITG740W/MFAu8Zs0nQ6YtBlL4yBzg6WMn
 MJEz2MnoblbwPeKib1J1cVaifk8dUJ/cR7PJ6gMBuSOBwUCWteRhyFQf1OgZhQp9UMn6cuqL7tp
 fYdzuwv1QBo8YaGrPbaIsDxSEn4T0tP3C1UKIfjzWifZwi/KmKqqBurSTfRo5OrryLlo3apKDyO
 0LJfrpWN+fc7tAcK9OCniT+NxOOoL/q5oiK8qUzEqA1ve3P7Oh7BybirAwX7lyx9mBddaonTP+R
 Dok5XNaZ+6Vol7xALjyTsbPq/83xh/e17/EJpcO/B3CLHtkpGeHxaF9v5XOvCDGkBVs/7BdeWy/
 6KMHjQz3w390LsLQmbPlA58YbXJPW0p3yBwiCABea5k4My19cDWQHLM6OJntvKlgQ2cxqXKizQZ
 +vkp9MN/6loPZ1Hr/s5Bx9HSj60VU2uMRseDi5RVOZ4Hy8Zi+5E4GF2i2NraNA7nMB6gwcq9aYF
 anINCbKBmOR40SV/1GHioMEVZpm8sR5OeRbtPBJnr6h0M+vAgAauRX9al4TfPEhsxyMfcc4K1KA
 6JpMdMaYkcQ1+7ZrdkLpUw0T1ySXTXvaWuZMOzA6xOtMQLdduWbuidZuLvuL+pU/DVBRgxB4Jej
 6U9fSe6rOecaR6A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This test extends "delete re-add signal" to validate the previous
commit. An extra address is announced by the server, but this address
cannot be used by the client. The result is that no subflow will be
established to this address.

Later, the server will delete this extra endpoint, and set a new one,
with a valid address, but re-using the same ID. Before the previous
commit, the server would not have been able to announce this new
address.

While at it, extra checks have been added to validate the expected
numbers of MPJ, ADD_ADDR and RM_ADDR.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: b6c08380860b ("mptcp: remove addr and subflow in PM netlink")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index d25ac561e050..b4dc5f2772dc 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3557,9 +3557,11 @@ endpoint_tests()
 	# remove and re-add
 	if reset "delete re-add signal" &&
 	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
-		pm_nl_set_limits $ns1 1 1
-		pm_nl_set_limits $ns2 1 1
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
+		# broadcast IP: no packet for this address will be received on ns1
+		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
 		test_linkfail=4 speed=20 \
 			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
@@ -3571,15 +3573,21 @@ endpoint_tests()
 		chk_mptcp_info subflows 1 subflows 1
 
 		pm_nl_del_endpoint $ns1 1 10.0.2.1
+		pm_nl_del_endpoint $ns1 2 224.0.0.1
 		sleep 0.5
 		chk_subflow_nr "after delete" 1
 		chk_mptcp_info subflows 0 subflows 0
 
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
+		pm_nl_add_endpoint $ns1 10.0.3.1 id 2 flags signal
 		wait_mpj $ns2
-		chk_subflow_nr "after re-add" 2
-		chk_mptcp_info subflows 1 subflows 1
+		chk_subflow_nr "after re-add" 3
+		chk_mptcp_info subflows 2 subflows 2
 		mptcp_lib_kill_wait $tests_pid
+
+		chk_join_nr 3 3 3
+		chk_add_nr 4 4
+		chk_rm_nr 2 1 invert
 	fi
 
 }

-- 
2.45.2

