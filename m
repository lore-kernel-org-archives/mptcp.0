Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EB1192D9D
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 07:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729064009; cv=none; b=q8329QtnrrZo+Q2hwWq0DJCM79zYxNly/OA9sFjKAIPd12ADiuDRSeRfPN0bIDTFRdbFU625ZGeypZTSjFp31RswkAGRNSasu5mN2b0kPGBZE8KrdlegU865LSRMU7XyU00kDHmmVXIpSCfvBk10jbPGy3VDz7+iTA665vve4t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729064009; c=relaxed/simple;
	bh=G3Mj/1LV2XacqFHXlZNcFs7RZYqQ88fkQCHIFhe3LKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rLLrZydT8IkLcnwVFYhcrgFV5H+48fo1pynggIWzYfe3kQs9Ol9vPRBm1x5YMmkoWKBbqhNcYj8X+dHIBpiobwHUbKWcOUiZaePYsZ0iI73ES/UZrxLhr72SCYhujbx15NqO3+PB9mP4W3wAhVZpqX04V3yskVu8rz3Yy2ZWxZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqNGBRRZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqNGBRRZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8DC0C4CEC5;
	Wed, 16 Oct 2024 07:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729064009;
	bh=G3Mj/1LV2XacqFHXlZNcFs7RZYqQ88fkQCHIFhe3LKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nqNGBRRZs8efx0Q+lM+fqeDUDjF0BycpxaDhNYNgVUAWLw+Vzbg9IalI7CWbFFyUp
	 lm6exJgQHJAztkVDYvVk1egV5Mc73WyzDJzVk1nf7bM+HdU9SsBr7BLo1yri9Egtpj
	 2lQKM0Q8PAihCdrF/oWqs0nNmUkOuiB2gdLPQEsqbZaqMVGCCVAT5NFYO6B0s3n5Kh
	 9e1rDzqC7Oxn0fsonN2Na0RtVQN1yKqEQxt9+X+QiMw0tfTkztUNuQsDg0/bM3lEeC
	 j5jgYFIxGybuV4kqBA0EYO+5dS8eYwYAdIrAwLAWkEkYZDtDgLZA3Gv0MSyze6IFJB
	 8ylvWzwHGpEaQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 3/9] bpf: Acquire and release mptcp socket
Date: Wed, 16 Oct 2024 15:33:10 +0800
Message-ID: <7442bbc9df71fb9b333e674b0421f2a7b8f6b74f.1729063444.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729063444.git.tanggeliang@kylinos.cn>
References: <cover.1729063444.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The KF_TRUSTED_ARGS flag is used for bpf_iter_mptcp_subflow_new, it
indicates that the all pointer arguments are valid. It's necessary to
add a KF_ACQUIRE helper to get valid "msk".

This patch adds bpf_mptcp_sock_acquire() and bpf_mptcp_sock_release()
helpers for this. Increase sk->sk_refcnt in _acquire() and decrease it
in _release(). Register them with KF_ACQUIRE flag and KF_RELEASE flag.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 405907b79d4d..19dbf28018f5 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -255,6 +255,22 @@ __bpf_kfunc static void bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_sub
 {
 }
 
+__bpf_kfunc static struct mptcp_sock *bpf_mptcp_sock_acquire(struct mptcp_sock *msk)
+{
+	struct sock *sk = (struct sock *)msk;
+
+	if (sk && refcount_inc_not_zero(&sk->sk_refcnt))
+		return msk;
+	return NULL;
+}
+
+__bpf_kfunc static void bpf_mptcp_sock_release(struct mptcp_sock *msk)
+{
+	struct sock *sk = (struct sock *)msk;
+
+	WARN_ON_ONCE(!sk || !refcount_dec_not_one(&sk->sk_refcnt));
+}
+
 __bpf_kfunc struct mptcp_subflow_context *
 bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos)
 {
@@ -276,6 +292,8 @@ BTF_ID_FLAGS(func, bpf_mptcp_subflow_tcp_sock)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_mptcp_sock_acquire, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_mptcp_sock_release, KF_RELEASE)
 BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
-- 
2.43.0

