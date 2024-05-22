Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FFA79B9D
	for <mptcp@lists.linux.dev>; Wed, 22 May 2024 10:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716374877; cv=none; b=jzFQqidRCBmMQOkcxIeqScTJwlmbx9Iivy7xU63b4ENSq7q60udENPkb5HaUpym6mmQYKfbBNYsVBP748crS2URFdSTuyXlQJOnRepCAibyRGolXG3P0eEnQ0eTZt7sVOjh/iZXvreNcx01wNlMVNKwlSmKM6JvAvgEYgeD2oOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716374877; c=relaxed/simple;
	bh=8MBb3YGLk1JPv2fvJpk6cJVJlQcDE2+JIiyeeg0Lk68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RGsGyxw3pRf4yH4rez4+BenG4R30tSPyQ4zYYDwoP05D4/walCt1gycFKaRyM6FpMeD0o2otLHMQamRNEdlGVVOmmXixHqCXV2LCIcL142k4EbkKMYHfXbuTYAHl8Pu2EBLEXvIdXdm3coMky5JW/JK36IOM+WVT7zTJxjGXxT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q17mj77x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q17mj77x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A470C4AF07;
	Wed, 22 May 2024 10:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716374876;
	bh=8MBb3YGLk1JPv2fvJpk6cJVJlQcDE2+JIiyeeg0Lk68=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Q17mj77xIzz8OmSctEXUF6G3mK0f0IQj7tr3VwfnVJ3XnufAocORvh3e2GF6OYDAD
	 giBETMCoXey30QRaeadgtIh7DUyCRXsss+xoLc6AzNAWap2iLB3lkR6pSj36MaPSgp
	 D7IOS9nGUp7s+z+ODDGs/cKFRD0JSCpKu2op/v/wzcIYWZi80FJ0Est8zWfwU9arUp
	 YO+oX6RqaGBgBJx+9nqasomOMzwCOYZlIunNHghq/9ZBA4kJuj2+8ulbpPbhdfLXuk
	 mayjmZDptEbsgYKRConh++Wj/RyO6AWTNEKp6pV2p+6X8QxniuCMWk8QAvVdoSlquB
	 miNgsN3z7bAkw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 22 May 2024 12:47:46 +0200
Subject: [PATCH mptcp-net v3 4/4] selftests: mptcp: join: mark 'fail' tests
 as flaky
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-selftests-mptcp-disable-flaky-v3-4-a10c68bf2680@kernel.org>
References: <20240522-selftests-mptcp-disable-flaky-v3-0-a10c68bf2680@kernel.org>
In-Reply-To: <20240522-selftests-mptcp-disable-flaky-v3-0-a10c68bf2680@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1372; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=8MBb3YGLk1JPv2fvJpk6cJVJlQcDE2+JIiyeeg0Lk68=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmTc1XywECc8w0CxRsqYSiVYwkocib3T4IWr4TJ
 EG8rKKjCQWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZk3NVwAKCRD2t4JPQmmg
 c2G3D/0RAMZwl5xOZE/qb0srTh9tc8P/PVEgyE4w3WKEAJnDte8JOGkeaTSSi8483gNhVmAOzkC
 AUH9FbTRC/H+D4IDIq8wEZQB+T7UnSXHLSUXgv/1VyWg+nJMhg9yVh8zvsr2MAFV5GNbB5oXa0l
 Vnx7Omf9fgII6Cz5LKlSe24rQaOvPRBJnxfEuxbLzshpaZU7wvhUTQOjPiiejIHU9CIF9as0OYy
 8FDgry6jZ2xZNMWz38hUTKOAbirdP71fb4acNV9jeuItc/pv2aVGLFI0JCPMKMfkf0D7qipIXB/
 aEb56HCkNCSSVUZKkYLpPyngYh+XR5RKF5gkLWIxXfMFK8xr7uuHfaW7F5GOXee4UGFiqPQ2zIa
 EL4pJ20GW7sfKVoL9P6wCbmdAnVw6hzM60/q1KM8tJXV7/EZlxGbSM2FeSwthCrY/H3NXm+WQkH
 tJUXnDwzPNdkbJtmaYAvvp7KeONZQ8zDGqqyVZUVqCdyzIdjplTJVE1Ae42GYZSSqHcsdD5fzfk
 7dlfvXTvafGnaJZc1tFiGUO/8AVy1CdWair7hReLP2HZkECh6JRwAC+oQHpFWG+lrcMUzABblTx
 tnStid3miNgU26oxSGPHvln7X1niGFYiIxtzcjVh2vy6ZWbPyfT6NtL0c9KYcKQEFIpu0ZtjLLb
 WRVcA9UKk0dbLrA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

These tests are rarely unstable. It depends on the CI running the tests,
especially if it is also busy doing other tasks in parallel, and if a
debug kernel config is being used.

It looks like this issue is sometimes present with the NetDev CI. While
this is being investigated, the tests are marked as flaky not to create
noises on such CIs.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/491
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b869b46823d7..2b66c5fa71eb 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3101,6 +3101,7 @@ fail_tests()
 {
 	# single subflow
 	if reset_with_fail "Infinite map" 1; then
+		MPTCP_LIB_SUBTEST_FLAKY=1
 		test_linkfail=128 \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0 +1 +0 1 0 1 "$(pedit_action_pkts)"
@@ -3109,6 +3110,7 @@ fail_tests()
 
 	# multiple subflows
 	if reset_with_fail "MP_FAIL MP_RST" 2; then
+		MPTCP_LIB_SUBTEST_FLAKY=1
 		tc -n $ns2 qdisc add dev ns2eth1 root netem rate 1mbit delay 5ms
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1

-- 
2.43.0

