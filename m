Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3763514AD0E
	for <mptcp@lists.linux.dev>; Mon,  9 Dec 2024 06:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733724766; cv=none; b=IGEtok96OkuGilBH2sh1RnpZOCbf8Ah6QpAEYr2F/17/KealiZxZBfGF4aj4Jmgy3ntyfj/oBZKJU0mzoE+uim35rNSnaTV2R9yDaL9bi9Ah46YzJSnov9Dpaa17KFLP7dtDmXugVl8v1Qg/o8f0n4mFEPMej6eFqHwPzUM2fYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733724766; c=relaxed/simple;
	bh=SQV9nesIDZg3IV89hJf9DcNukyegI2kFcLBPZJpMrJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EPq8VZV60P90zghi6HM7/oDDv+OD1hYdYUEfAV3inS0TnQ6oQeHTmLwo2u7ddVprOoDKyzSXuotF9FBpTSKP3unyCsrmmqjkLTG4wazLlbYZ8W2glqPIC8moH0WpUsxe9+VHjy3gTIK88n+EcwC9/NWCWUt57FGSHi2H+jXYFtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+m9xGy6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+m9xGy6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E33C4CED1;
	Mon,  9 Dec 2024 06:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733724765;
	bh=SQV9nesIDZg3IV89hJf9DcNukyegI2kFcLBPZJpMrJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U+m9xGy67WH1CvIDhmyB8LOZnshhNm6rNTnxCayFxwrnC0FXzlcrNSZPF53MlYSgB
	 oDoA/HDV7V4m6gMrwtEbSiWTxI2OEoEL+3q5mh2NnrrbOlBCvrONKM7fRGjFghLpMq
	 Fl3WozkpGI6js8oZkk7hEl1No7q8x+sxCRX7rMv6EVGcnDCYsfT148lDViE/4SoMY7
	 XvTneOyi5LEdDNmtle1LkxHUWHuo+o10dXq9B9hx+YBrqVqMrZVb3igYeOckmKZYP2
	 cqxMjQ+QhTvJpYjDzPjV7mJBmUav68sn9xiH7RkCKgVt9cpvOhsBvrwhd03F6EYamJ
	 GYRwDoxX6cQ2w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 5/5] Squash to "selftests/bpf: Add mptcp_subflow bpf_iter subtest"
Date: Mon,  9 Dec 2024 14:12:30 +0800
Message-ID: <a09e5fca81f603c21e7f6b2e76ab92ac6f8ef0e1.1733724383.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733724383.git.tanggeliang@kylinos.cn>
References: <cover.1733724383.git.tanggeliang@kylinos.cn>
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

