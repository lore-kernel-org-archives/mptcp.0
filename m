Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F8F1A291
	for <mptcp@lists.linux.dev>; Thu,  5 Sep 2024 02:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725503231; cv=none; b=DQajtnUC4/egpRVYH9dYzYspjr/pf0jgUCGYzaOZpehX24xQiQpVAuuIj3xDVwvsEgJ0NLOyyAGhmJY1gv8Cr+Gj/jZlYfH66ZQbMmb6jlukoGTLaxcN/waqVLNNHjItj3OrIytvzg/WuHJR2cJjY1m3fPf2QG7N1bNQ9v1lwkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725503231; c=relaxed/simple;
	bh=vTfiggft06llAFuz4f3D8JufNjpczNfklpupNrDDF5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5XYHA22Ybxg2Vf08+eb6JzdzXyufpQirlis0efX1pH1LgUZxRl8Ro9ivQKAK6sUridYkKHM5JKBA1sI+ybxYPa8+TBiyZ1mneGCHJkTwUn89GPgamlo8EttsWrforxcZjtHD3ai0DsVfENnmdZ6Z9V48wfP0Idok5YFcNb8Q4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjvJO/EN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjvJO/EN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21154C4CEC2;
	Thu,  5 Sep 2024 02:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725503231;
	bh=vTfiggft06llAFuz4f3D8JufNjpczNfklpupNrDDF5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GjvJO/ENPwg+ZJRInZQehXP2zQ2hFOs11ahX/AR1Eah0s+0RJO6Ag8ubFmYhDKyvB
	 t053ib0KGvPqYt8+ScIXiAwMXsTG2+JGMpkViKP1Pu5X1lKGOv7CkKb6hdjL07yEQr
	 Xiioru3bcY4oNVQeuNpPZQCFpBzP1FpPNasXIttistaPn1UwhdWCiHkKrvG3d2229Y
	 h3EWmEyQSKuK8sEFCJHMvDAzEDvoWZLQWIGyr+peFROkWnhaFXEmX9Hpr6uoBqy9Nx
	 D64DHVluyGXfzblLoxZTVYvEvr6+Qs+M3YVCQjstgYrJuskFojd9y95qRK5ZGztSSU
	 2yLrG6RaxG3Tw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 1/4] Squash to "selftests/bpf: Add mptcp subflow example"
Date: Thu,  5 Sep 2024 10:26:56 +0800
Message-ID: <ed716f90cfeea9073efc76b02397beba80a2643b.1725502822.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1725502822.git.tanggeliang@kylinos.cn>
References: <cover.1725502822.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

For easier verification of cc, set cc of the second subflow as "reno",
instead of the first one.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/mptcp_subflow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_subflow.c b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
index bc572e1d6df8..2e28f4a215b5 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_subflow.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
@@ -52,7 +52,7 @@ int mptcp_subflow(struct bpf_sock_ops *skops)
 	err = bpf_setsockopt(skops, SOL_SOCKET, SO_MARK, &mark, sizeof(mark));
 	if (err < 0)
 		return 1;
-	if (mark == 1)
+	if (mark == 2)
 		err = bpf_setsockopt(skops, SOL_TCP, TCP_CONGESTION, cc, TCP_CA_NAME_MAX);
 
 	return 1;
-- 
2.43.0

