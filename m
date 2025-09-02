Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BBD2DF6F4
	for <mptcp@lists.linux.dev>; Tue,  2 Sep 2025 19:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756839712; cv=none; b=PKda5bsET4c161yjbp8LvdYYsX7ji50NCELSXPP6PPQn0TKFc8qBAmBF8rr2j6UifcAwLHI0vdB9awul/KG44cEL1pfqss69OiK1Hg794CttvhXZSQY24fM/SF583ZmV6nUqpMeFCihd48GbPZU2Rdf5tIyCYFCYFjX7Vn8udfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756839712; c=relaxed/simple;
	bh=qciBjF76ETss+mqHo9kiwuEAE16QRV0ywZ4C3ccfihI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pf4SGpOqtImNOvm5lKvWEIvAFHMFpuJiJ1gpU/VG8zd2LOlBMKdsgk6k06PoAl4973hQp9U7Qe2F7hCvnOtm+B2VxGNBaHkpIasO+p6yiQc3lEHuX6Gr4xAW+Q6KaCJrxqqFipOdMEnPJXXzG01YRWUDsLBZX4ZA4oiGGyUzJy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tsq0k7W7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tsq0k7W7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14EBDC4CEF6;
	Tue,  2 Sep 2025 19:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756839711;
	bh=qciBjF76ETss+mqHo9kiwuEAE16QRV0ywZ4C3ccfihI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Tsq0k7W7LFWPgIDhE8qPYKWONiZPxnHqYUH7ZS1i5a0qMR0urHgrJhOj5AhnMylja
	 sAXUNZPQmXYRw5v/L1t0aUylncD3GEnq40EYQbFpxzkEI7ZSqamSjEwFFM300VoI9B
	 O5JoPSBBFFB34cgwbSfDxY2KfEcJWu+VAZHCkVU2JquQQdDeI2Xiv7CTc7NweoOf8o
	 g5WQ3c/3dXr0yUA3axqAFvgSRVFVLivTn7T8su1raxfXVGAdCKsI/ozGUny5QaqdB7
	 HhFeQrSHXHtJ1VhFBAId+NPMNvve1r9wne5WMBuoqM6LdKRGDdA/zIyMNuxHCLM78s
	 JbrnDcWoIhpPg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 02 Sep 2025 21:01:40 +0200
Subject: [PATCH mptcp-next 3/3] selftests: mptcp: join: allow more time to
 send ADD_ADDR
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-sft-mptcp-join-add_addr-no-retrans-v1-3-956a315d6a5a@kernel.org>
References: <20250902-sft-mptcp-join-add_addr-no-retrans-v1-0-956a315d6a5a@kernel.org>
In-Reply-To: <20250902-sft-mptcp-join-add_addr-no-retrans-v1-0-956a315d6a5a@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1467; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=qciBjF76ETss+mqHo9kiwuEAE16QRV0ywZ4C3ccfihI=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDK220utzjieq5fIamDxfUftje8cTadPHrAoivu05X+wp
 Jn/rZetHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABeZxsgwe+/HtZsm6ig6P9JX
 XfKzduXfL6t/WSS5zl0ZEpz0at3CeEaG0wIqk6JX9O4In/T24YZ9lvcb/q6P1TYK+Fd67YPGQ9f
 FLAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When many ADD_ADDR need to be sent, it can take some time to send each
of them, and create new subflows. Some CIs seem to occasionally have
issues with these tests, especially with "debug" kernels.

Two subtests will now run for a slightly longer time: the last two where
3 or more ADD_ADDR are sent during the test.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 1028f3f931612d98e828707a9f55caa69be4a6ca..9c1ab36110850dcc35bb77e2d5894d8b1dd496a0 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2266,7 +2266,8 @@ signal_address_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1
+		speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 3 3 3
 		chk_add_nr 3 3
 	fi
@@ -2278,7 +2279,8 @@ signal_address_tests()
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

