Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B081B21AD
	for <mptcp@lists.linux.dev>; Fri, 24 Jan 2025 10:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737714532; cv=none; b=ERIUMPBZ8dkKW5dCiHKj9iqxt+HHww+VMnQYjxhWpCzjMR8DHozoRrEJqf8pCsguXIw70liBlRFf3hnPZTAtXPWf2vbdx3lzSvD3jmo5wqAgOrF0wYrwHcsq23qeC7qiETCzDbs6S8+lG/pXr3+/fA8VQ5lEqNgK9QS9N1hkVJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737714532; c=relaxed/simple;
	bh=oGmxM4LXDzvIY8eA8PSBTT06Nl1iB7C2qKIoOM3mW4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p0Z6zM0QiLZ3jKp1YK/NkHGtYcA20Z3wHGx7AxNkbODPuV9mlUoUHCwbProwAnxRoXg7FlKXTBgNN8wfPgN7QYBUnXZcPkaDYNawY6/lleXgDPgPLql46tnIb8+wCf6AYTRTLDDAxD+Iwt7n2Q3INURarI6iiaXTH3sknenfcPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GBQiVSr2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBQiVSr2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87F9C4CED2;
	Fri, 24 Jan 2025 10:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737714532;
	bh=oGmxM4LXDzvIY8eA8PSBTT06Nl1iB7C2qKIoOM3mW4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GBQiVSr26Z+M+OEDv6w68UZbOleV/TvYzvVGl8C4Swyy3L8yk7bN3Uec/JHea33lA
	 /bIK1Apq5pHIQMEvYfGlz+TB2LJh5LipTxhQh8/zOJzQ3dGDz0C4juR39JTAdZGFKu
	 rL6Jvohsk91mTTxfJKC4uuWe4uNXQ3dtOTcjriTFZQd8i2cN2CIh8HNp2B5uBQEfp/
	 ATEih9p2exsoYjtHAmWODDk4bKkVpwydlIMootbdsrajYjLzmdKO9fFz20jb3M0OvK
	 QakXWCtUldxDcwzicDFM3TIqXNDnG0P9bYZ71g1PCm9gkZvCYEauCbdjyF83zgYiVs
	 SYTwMCbIjDJrw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/3] Revert "bpf: Acquire and release mptcp socket"
Date: Fri, 24 Jan 2025 18:28:40 +0800
Message-ID: <e0b4aa54a1c63b3245e5de0b649687588d122aa0.1737714424.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1737714424.git.tanggeliang@kylinos.cn>
References: <cover.1737714424.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Drop this patch as Martin suggested.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index def4de34666d..27a8c2e9ca2b 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -276,23 +276,6 @@ bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_subflow *it)
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
@@ -313,8 +296,6 @@ BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy, KF_ITER_DESTROY)
-BTF_ID_FLAGS(func, bpf_mptcp_sock_acquire, KF_ACQUIRE | KF_RET_NULL)
-BTF_ID_FLAGS(func, bpf_mptcp_sock_release, KF_RELEASE)
 BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
-- 
2.43.0

