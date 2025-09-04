Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19DA2F39A6
	for <mptcp@lists.linux.dev>; Thu,  4 Sep 2025 11:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756985904; cv=none; b=EjUbvrMA0IoNWFY6TrckXi4mlXBsHJQrM34lcpudM7GbtHV02cQf2DekPvGCm5X6yaXScVpCKx4kfPef8RFMzEdk3LMBQNDwajfWkf+XF2a+CmNbNAiRiQNSOg6PWgkKgcxV5oKDeQFNvS4bO8gomxSQ6MVdl8+6hCNShjeCe+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756985904; c=relaxed/simple;
	bh=gJhzZ7ogTLAF6f3s/nOccNHwhoEfz+6IDelT9pKGKOo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fF5FHRAXZxnEZ/FxPTsCvbdkXBcIdviSwvQsvAH4tKkFXEqmJBT5vbXRQchuaT3t1PFEdk0JpKV6NL80NkRpuiI0mxuEiht5N+a2b3sxzBKY/1b7fKVZKfyx5e93tC4Xnu4oXIOmPrvRas8y6QcaMBNe9O1pA0TBcR1vYRth5Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQIiaPGn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQIiaPGn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3BE3C4CEF5;
	Thu,  4 Sep 2025 11:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756985903;
	bh=gJhzZ7ogTLAF6f3s/nOccNHwhoEfz+6IDelT9pKGKOo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fQIiaPGnAhgtIum7cmZcQJkJhZfZ31SQja/GJCp/+jaKY76pRR5opQXutW/xL9DtE
	 Hv8iJJig0NmnA4AlVWxF5Q/fXVeWY5pu2HZx/Sh67nndQj2orgn/97ERCvU9dmytpD
	 xyWNzwzF5ILfn8DoT6gph44P9mFnLLB7QeWXyQnox0+aK9RikSDc/oV0fcKoyuFO2D
	 z5A81qsa8B0vcivlSnD9bgSRGjPQ9MXgNjxIZ/UQ2KdmQ9ZuKh147EVnR7pJwKCIl4
	 BOsw+aky3+7A/R328wFamZWl5yfmj9NKadBY7R1tVJmUkgF05KqM5SKSj3KKDKKO9I
	 VLYt3S0r9sgOw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 04 Sep 2025 13:38:07 +0200
Subject: [PATCH mptcp-next v2 3/3] selftests: mptcp: join: allow more time
 to send ADD_ADDR
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-sft-mptcp-join-add_addr-no-retrans-v2-3-a019e6678628@kernel.org>
References: <20250904-sft-mptcp-join-add_addr-no-retrans-v2-0-a019e6678628@kernel.org>
In-Reply-To: <20250904-sft-mptcp-join-add_addr-no-retrans-v2-0-a019e6678628@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1515; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=gJhzZ7ogTLAF6f3s/nOccNHwhoEfz+6IDelT9pKGKOo=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJ2VmnXdylKyq7fepHd8dXDr1f9zC9oONb/+TNj0hOtJ
 u1DVyX6OkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACZSl8bI8OSo1bwrcZrrmn98
 DOtx2lL16CID4wmx6OXNZfXJ+4SfWDEytPQEPl0eUDg3LT575Zzju+vWe+qsyhJmZK35+XD60gX
 LOQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When many ADD_ADDR need to be sent, it can take some time to send each
of them, and create new subflows. Some CIs seem to occasionally have
issues with these tests, especially with "debug" kernels.

Two subtests will now run for a slightly longer time: the last two where
3 or more ADD_ADDR are sent during the test.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index be49712f91155a1f14f6cc21776764d65a897c27..dc1f7d5b7fbaf5aa71d95c0d3e0b418cf3916199 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2268,7 +2268,8 @@ signal_address_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1
+		speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 3 3 3
 		chk_add_nr 3 3
 	fi
@@ -2280,7 +2281,8 @@ signal_address_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1
+		speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		join_syn_tx=3 \
 			chk_join_nr 1 1 1
 		chk_add_nr 3 3

-- 
2.51.0

