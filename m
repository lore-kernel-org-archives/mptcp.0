Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C1B1FECA3
	for <mptcp@lists.linux.dev>; Wed, 11 Dec 2024 03:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733886733; cv=none; b=CYW7bAzVM6Nvs1JqV5dVbXE6iCvtWg9UMaZzGH/Oi+10u77ZpkN7CwNMxjEHxyU4KV4IeBDiLCCpazNgwsxKJeN/xYPRHWfJQl6bys2p4Tek+agxTlKBx7Uoug0s68EPUp4zC0JPkPlRS5tpDaGV/1Oi9oeC3cp+OAUIbqAzUp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733886733; c=relaxed/simple;
	bh=SQV9nesIDZg3IV89hJf9DcNukyegI2kFcLBPZJpMrJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H+BhLBDymEIVPuWuV7ii9SO5n/hmzRYUYbdWUdG7wK8qJqEW/OXjBfZ3wFOdsFDP71ctoaR9vuvur3u+2qoqbVNT5CvSokso7S17zmTooevJcBjlEiSwv8RrWc9+rInKBqDK59dPrg/p3OEbLGYUimZsmDLRRMUHNKP8kaqR4lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WfrVZ+kD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WfrVZ+kD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53556C4CEDD;
	Wed, 11 Dec 2024 03:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733886733;
	bh=SQV9nesIDZg3IV89hJf9DcNukyegI2kFcLBPZJpMrJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WfrVZ+kDtu4PJtaJzKGP0dtFhgpgeSI0U0ott2HSESYAHmYQQVcgdWNxh1+S1gw0n
	 Q81Ydsq2Gf27P4aCGsAi1m07dwmbjb6Jr3WAnMzFo1+T8ZbCSXQ4+osNhwsOsu4t+3
	 UXtjoKpw9uZQsHmAMQ0ruBYORI9oH6x9+iHRrQnbweOr2lpk6n5sRb2l8CKeXoEh/K
	 LaV2humIA1l4h4P4CdlkGBa/b7HS9siyybIFfO0BdSW3OKk26lPxhBC5ybmmbd3KPW
	 h92txRsIMRxqmKujRMQojQZ/pVrStOLpE9+GbYMv23pA8fMl/5M2VsAm0dIo6Agddj
	 W37BAgbULQZVw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 5/5] Squash to "selftests/bpf: Add mptcp_subflow bpf_iter subtest"
Date: Wed, 11 Dec 2024 11:11:56 +0800
Message-ID: <c902f864276575d11ce309079db5316cdf1c9bbd.1733886326.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733886326.git.tanggeliang@kylinos.cn>
References: <cover.1733886326.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use bpf_skc_to_mptcp_sock() and mptcp_subflow_tcp_sock() instead of
bpf_mptcp_sk() and bpf_mptcp_subflow_tcp_sock().

IPPROTO_MPTCP is checked in bpf_skc_to_mptcp_sock(), no need to check
it in BPF program.

bpf_skc_to_mptcp_sock() and bpf_mptcp_subflow_ctx() may return NULL,
need to check the return values.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf.h       |  1 -
 tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c | 11 +++++------
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
index 3b20cfd44505..b1f6e1fb467e 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
@@ -46,7 +46,6 @@ mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
 extern struct mptcp_sock *bpf_mptcp_sock_acquire(struct mptcp_sock *msk) __ksym;
 extern void bpf_mptcp_sock_release(struct mptcp_sock *msk) __ksym;
 
-extern struct mptcp_sock *bpf_mptcp_sk(struct sock *sk) __ksym;
 extern struct mptcp_subflow_context *
 bpf_mptcp_subflow_ctx(const struct sock *sk) __ksym;
 extern struct sock *
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
index 1bede22a7e3d..fd5691a4073b 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
@@ -21,12 +21,11 @@ int iters_subflow(struct bpf_sockopt *ctx)
 	struct mptcp_sock *msk;
 	int local_ids = 0;
 
-	if (!sk || sk->protocol != IPPROTO_MPTCP ||
-	    ctx->level != SOL_TCP || ctx->optname != TCP_IS_MPTCP)
+	if (ctx->level != SOL_TCP || ctx->optname != TCP_IS_MPTCP)
 		return 1;
 
-	msk = bpf_mptcp_sk((struct sock *)sk);
-	if (msk->pm.server_side || !msk->pm.subflows)
+	msk = bpf_skc_to_mptcp_sock(sk);
+	if (!msk || msk->pm.server_side || !msk->pm.subflows)
 		return 1;
 
 	msk = bpf_mptcp_sock_acquire(msk);
@@ -41,7 +40,7 @@ int iters_subflow(struct bpf_sockopt *ctx)
 		local_ids += subflow->subflow_id;
 
 		/* only to check the following kfunc works */
-		ssk = bpf_mptcp_subflow_tcp_sock(subflow);
+		ssk = mptcp_subflow_tcp_sock(subflow);
 	}
 
 	if (!ssk)
@@ -53,7 +52,7 @@ int iters_subflow(struct bpf_sockopt *ctx)
 
 	/* only to check the following kfunc works */
 	subflow = bpf_mptcp_subflow_ctx(ssk);
-	if (subflow->token != msk->token)
+	if (!subflow || subflow->token != msk->token)
 		goto out;
 
 	ids = local_ids;
-- 
2.45.2

