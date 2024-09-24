Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D8380C13
	for <mptcp@lists.linux.dev>; Tue, 24 Sep 2024 09:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169007; cv=none; b=uimNkS9ipqvzmI1UG/y1gBpWXABqrJGSBXIPK2cSUnnwgr7tCFO90OwRbZIgynEKn5Nrij0YIuplhlp239VMB57Wp7of8AfvEHiOyAIDlMyRxXsBY4fNTcqdEJRBeShTlSUs5wWc5DrTb/JZXNKPYb6CDgY7vXqQha3WaxJXFR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169007; c=relaxed/simple;
	bh=P7kYYdBgJb4t2O0r2+V/Ny8iY05lxoL8YcLH9Qfcgo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=peUF1vN/7LFlsYj4RpNF2vjo5n0bU/uNnTkQX1FMFl2mXRbYvC8C9Kq+bFPoy17EWm3vJ5YaTM2P4CpS53DflrlLCRT1cPFTIOnT0VB/+V97/wWFneJXd4tiKHrTNwRF7jB5pZtHwHnUL00K4n021KU7qjt6d80l+K+dOrUWNQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmysWi49; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmysWi49"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51231C4CEC4;
	Tue, 24 Sep 2024 09:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727169007;
	bh=P7kYYdBgJb4t2O0r2+V/Ny8iY05lxoL8YcLH9Qfcgo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mmysWi49XGDVrR2W7bux7VhqcX0ja3um+Wpbab5mF3AygrzXZSyxDAmbuNmye4kI2
	 zOJPtMs5MiU9eYN5LinO85NZ7fnpSvgrMGPaH851HYFKJJloPsewEk0OaB7AC9Pmm+
	 sEkq1i1IKCWAoo306BNSxVMYnnlfxD1bSFOXjtHLb6q2SbGk6FALhewj51HorPzKYC
	 bUtlIdBFUa3UdViou//cYK1rvC3l8Ar3vS2rEO8GkJdWEqt7xm0Zwoo5nntNFvXLJ3
	 icRAPS83ws6kqziYeggYFA38lUXZtu6Ozqs9iOeUhP4P2ocq0uU3unXRGo0lZQjzsQ
	 oQnhDnEQPLYdg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 03/10] bpf: Add mptcp_sock acquire and release helpers
Date: Tue, 24 Sep 2024 17:09:47 +0800
Message-ID: <5279f8e3ea5ebbb7ec672803713970223096269d.1727168628.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727168628.git.tanggeliang@kylinos.cn>
References: <cover.1727168628.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds bpf_mptcp_sock_acquire() and bpf_mptcp_sock_release()
helpers. A refcounted object is added in struct mptcp_sock, increase it
in _acquire() and decrease it in _release(). Register them with
KF_ACQUIRE flag and KF_RELEASE flag.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 3e13bf126e0e..32894d2246b2 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -248,6 +248,22 @@ __bpf_kfunc void bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_subflow *i
 {
 }
 
+__bpf_kfunc struct mptcp_sock *bpf_mptcp_sock_acquire(struct mptcp_sock *msk)
+{
+	struct sock *sk = (struct sock *)msk;
+
+	if (sk && refcount_inc_not_zero(&sk->sk_refcnt))
+		return msk;
+	return NULL;
+}
+
+__bpf_kfunc void bpf_mptcp_sock_release(struct mptcp_sock *msk)
+{
+	struct sock *sk = (struct sock *)msk;
+
+	WARN_ON_ONCE(!sk || !refcount_dec_not_one(&sk->sk_refcnt));
+}
+
 __bpf_kfunc struct mptcp_subflow_context *
 bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos)
 {
@@ -269,6 +285,8 @@ BTF_ID_FLAGS(func, bpf_mptcp_sk)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_mptcp_sock_acquire, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_mptcp_sock_release, KF_RELEASE)
 BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
-- 
2.43.0

