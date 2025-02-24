Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B59F510
	for <mptcp@lists.linux.dev>; Mon, 24 Feb 2025 03:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740368276; cv=none; b=pTY35naccJVLA5Tw24QWDdj5fc0p1DCBl0BO4yeD/18MoiSnlUZk9oDcvWv9tLVifdApVYlmHJgkTE16ysIZLdIL0QzVmaX7z/boPCV6Rebe1ayz/mNs5v18bpXa1gRMQK73t7pvO6Q5pT9vWWkPFyEDcc6tfLIyWMGQl8CO/lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740368276; c=relaxed/simple;
	bh=o8gw8gLxpotp0mZg8+swJYM8o556x79xbkiQGfRHl5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DrjwsoJJV0jkvWD92xWE2T+KJA+WZySsk7X6/Vq2WlxJE1+mMhDtRqj6kEO64tg56BBdV0mKmioWpezyP1c8RqXYJBKnGXzynYZKfqMPWRUhS8Jl+vgxvJOoiWNsA0crEggDw1vVtAgqUAavogujmmjPF/3mmuqV5o5XjOHpeqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSBo+Sxt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSBo+Sxt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FA2C4CEE4;
	Mon, 24 Feb 2025 03:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740368276;
	bh=o8gw8gLxpotp0mZg8+swJYM8o556x79xbkiQGfRHl5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oSBo+Sxt0kW9sxcvDvciTv+Vl8Ce8abYXCAoBvPLal5ejagyBuh1XgJHge2SFO4o9
	 06He4dHII2Gu8JBcLFDrOaIBGLGkWVD5li6JvcwHQ6gsD81NJWT4mrAittKqtBwaaq
	 1JUmftd1UP8yo5fJoNlcrjFlPVDdyDHg0GPBAy8esg4g7qLZllMtvBWnyN/bipCaPV
	 cr5gKyTj9Xgi+HdUP4p10IPXXFi5AbcGW4ny3lNFPElA5ORnVeCyizF8DBE0XMIYxQ
	 hL4qypPT7iZrKK4bNqtak2BPAaPj1UspXPXaC2mUd3fxVKv0pKBSF7UcEPnyTWCHFq
	 ocSSWXxNiD6KA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 4/5] Revert "bpf: Acquire and release mptcp socket"
Date: Mon, 24 Feb 2025 11:37:39 +0800
Message-ID: <685f8d65a65014fe4dbdfd743d1f2fd1b9e02d33.1740368110.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740368110.git.tanggeliang@kylinos.cn>
References: <cover.1740368110.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Drop this patch as Martin suggested.

From Martin's review [1], this mptcp_sock_acquire() helper was a workaround
only to please the verifier, but they were not needed.

[1]
https://lore.kernel.org/9b373a23-c093-42d8-b4ae-99f2e62e7681@linux.dev

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index a6b07aaddcb2..ac7744c6006f 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -274,23 +274,6 @@ bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_subflow *it)
 {
 }
 
-__bpf_kfunc static struct
-mptcp_sock *bpf_mptcp_sock_acquire(struct mptcp_sock *msk)
-{
-	struct sock *sk = (struct sock *)msk;
-
-	if (sk && refcount_inc_not_zero(&sk->sk_refcnt))
-		return msk;
-	return NULL;
-}
-
-__bpf_kfunc static void bpf_mptcp_sock_release(struct mptcp_sock *msk)
-{
-	struct sock *sk = (struct sock *)msk;
-
-	WARN_ON_ONCE(!sk || !refcount_dec_not_one(&sk->sk_refcnt));
-}
-
 __bpf_kfunc struct mptcp_subflow_context *
 bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos)
 {
@@ -311,8 +294,6 @@ BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy, KF_ITER_DESTROY)
-BTF_ID_FLAGS(func, bpf_mptcp_sock_acquire, KF_ACQUIRE | KF_RET_NULL)
-BTF_ID_FLAGS(func, bpf_mptcp_sock_release, KF_RELEASE)
 BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
-- 
2.43.0

