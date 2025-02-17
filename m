Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336B01A5B8C
	for <mptcp@lists.linux.dev>; Mon, 17 Feb 2025 10:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788458; cv=none; b=DKrIeOjCGXcTq5TPNNLu57R8ChXmxXVAZdB7bUeEqRx8kZpqJJTptG0pm1JKF/MQHY/CfhWgRtvwTv7TUI8Myi/AoG5zoCayu/9vYGU+99HzGZpRzWLkXdCNmKqkmMw7H51NulQ7N6deFRrVdbSk4ADP+S92Nsdb4wV2rcjeyVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788458; c=relaxed/simple;
	bh=FmZ9/jn3TitLxcMXG2LVFBIVimxoZsguzgy/ogPWiwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pUPzUTM7x7ifi+UX8NP4p6ysP9jNdN/SXdysx7yp8xkkoFj2imlv01SikFoSW8K8IaB/8x/e6+Ic18Ju4dkUhGZ46+igmFOGj7424S5HpC6fr+8SyHnSLbI0CVDaVcnEkQxUrGOkoQ/0bZjsLuM7T8AvpMwZK5le88KcgG6KYv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGlOxInE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGlOxInE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E87EC4CED1;
	Mon, 17 Feb 2025 10:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739788455;
	bh=FmZ9/jn3TitLxcMXG2LVFBIVimxoZsguzgy/ogPWiwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FGlOxInEk+THbTmT7oL7T206CsBdR9lvC9WBlJex1cXl/D3avE4Kh3mwq1Nc01wcy
	 qBjGWK/XyhyJGyCwswM0DpcJkubCPSEM8x03osCcOuiFcES8sJFgN35G9ax2wnn0mX
	 vtteZRx8ojrfsre0aSqy7yokQrSMmP621sjlz/j2eu/xuEkXTSN198hG2DSY+eCF+x
	 MQvvZ+HN2+IQFvGsFkIUiYo15bv+6Of+55v2kfmnCRjHZwpe3rgUG6/ibbikb0jkKV
	 9z+EUGDvT9sIn854NoFFE4I3f2iNEvW7ty9Q8JS71rq+B3KNaISDaN4cDNHgDIJUil
	 KaHbDLj3XCCLQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 4/5] Revert "bpf: Acquire and release mptcp socket"
Date: Mon, 17 Feb 2025 18:34:01 +0800
Message-ID: <fc744745b9d971b19ba27895f4595417ccec2eda.1739787744.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1739787744.git.tanggeliang@kylinos.cn>
References: <cover.1739787744.git.tanggeliang@kylinos.cn>
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
index 06fb0f88e35f..2256d4de1e20 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -278,23 +278,6 @@ bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_subflow *it)
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
@@ -315,8 +298,6 @@ BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy, KF_ITER_DESTROY)
-BTF_ID_FLAGS(func, bpf_mptcp_sock_acquire, KF_ACQUIRE | KF_RET_NULL)
-BTF_ID_FLAGS(func, bpf_mptcp_sock_release, KF_RELEASE)
 BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
-- 
2.43.0

