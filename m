Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F651C4A08
	for <mptcp@lists.linux.dev>; Thu, 21 Nov 2024 09:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732181806; cv=none; b=RJkV/VwD0xf84frUJDnhclhgEbM2pIdrLnhvFhnQEFJevT0ZcUy9HMSfW9dc0NFFy6RtseSbA2kPYluvfPoISO4ZbAHdxDQiEHbCBo5lkwcQKUBlYjiM6tmRQbb7BILxJqlJEpKL4/nSRKoJ0xYkI11qO29YK1pFVJRNInlUygw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732181806; c=relaxed/simple;
	bh=j86koVjy9m5DQMFl9dmS/aL9/28ANwXTgkirhcoNrU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z723/QSwMeeJCEFC8jr9/H37Ocqz/jBXr56B+G2SWz8rDZ9yVA9Vv0NE/nFT8747PBx1U1Il7AD7eh0AZdgcwHXufQkBjH7Xfwytc5rcnhpPOK221m9dae8sdXyFmW+3sfU8L7zgvIbumgBO90aZS/z5Qq9XQS5uUUdVsvsw9/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YeK05vyz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YeK05vyz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7584C4CECC;
	Thu, 21 Nov 2024 09:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732181805;
	bh=j86koVjy9m5DQMFl9dmS/aL9/28ANwXTgkirhcoNrU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YeK05vyzQiUQb+Lz8NkOI0Z4G0wPUHJn0gs3JJhW27k6dU2MqT8ATzFa+xfNXqlVp
	 CROOnwyiVM7I92dBXarwPLVt7xkpzT4zYvVeWetWpd8RE/Mr9bpAjaWARFSw5q4sqt
	 q8Nd3XHQFs/gyRmMy8QsDSTfw+1w5CThtfNNcDPhVJKXLUN+SVwLPIyND0+///Nl5l
	 fcY3+znXHlI/GOSx/Obls9+UWBvsLY5qbdftkJdnjVGuQ0H39hggtfIKlAHvCAPXZM
	 /871GAv8C1E09B5lyId3Eo9C3WURLC1C2kpQjFjtz4X8wHols4GnlkHcBk06fhAZTJ
	 8yhJKf8DRCErg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 3/3] Squash to "selftests/bpf: Add mptcp_subflow bpf_iter subtest"
Date: Thu, 21 Nov 2024 17:36:35 +0800
Message-ID: <1f670acc8c3b1606609b017a4953f4ddab3b1794.1732181420.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1732181419.git.tanggeliang@kylinos.cn>
References: <cover.1732181419.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

IPPROTO_MPTCP is checked in bpf_mptcp_sk(), no need to check it in BPF
program.

bpf_mptcp_sk() and bpf_mptcp_subflow_ctx() may return NULL, need to
check the return values.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
index 1bede22a7e3d..5e475edf37b3 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
@@ -21,12 +21,11 @@ int iters_subflow(struct bpf_sockopt *ctx)
 	struct mptcp_sock *msk;
 	int local_ids = 0;
 
-	if (!sk || sk->protocol != IPPROTO_MPTCP ||
-	    ctx->level != SOL_TCP || ctx->optname != TCP_IS_MPTCP)
+	if (ctx->level != SOL_TCP || ctx->optname != TCP_IS_MPTCP)
 		return 1;
 
 	msk = bpf_mptcp_sk((struct sock *)sk);
-	if (msk->pm.server_side || !msk->pm.subflows)
+	if (!msk || msk->pm.server_side || !msk->pm.subflows)
 		return 1;
 
 	msk = bpf_mptcp_sock_acquire(msk);
@@ -53,7 +52,7 @@ int iters_subflow(struct bpf_sockopt *ctx)
 
 	/* only to check the following kfunc works */
 	subflow = bpf_mptcp_subflow_ctx(ssk);
-	if (subflow->token != msk->token)
+	if (!subflow || subflow->token != msk->token)
 		goto out;
 
 	ids = local_ids;
-- 
2.45.2

