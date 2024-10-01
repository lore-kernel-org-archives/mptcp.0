Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F5363D
	for <mptcp@lists.linux.dev>; Tue,  1 Oct 2024 06:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727765245; cv=none; b=pGsF3uyRp1XWVqAKhOKninksyhvDxOBKb+nnA/l6ZKMVwIbUdoPn6HMja4/jzvAAsP4UNeXrpoM1JiZjqcr9mEXY/w6TFv8hpa6/4ijN2reSJjm8mjYCAI7QBtSc2B1m9Dbz4jMBl/2x1ZqWSpWoHgwz0YE41HTlh3CpSeJcdg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727765245; c=relaxed/simple;
	bh=LtVt7ehTTBhyv9n7P3sh6p5RBizQeQ+VwmhO2uH/qRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LCuckpbz8lJZV0alJVhhXOy+QQbgJ7IEdMaBGCJU/fxqZfiAG+zGH7V2XWbHehOHJBnJw1N/32K6vwW9g0SASYaRoR9GwDg8VGjJ47dY6JBVYi309BC9a+lH5xSMEi29YMz5TcqQZqEdCDTZapdsQu1N+uXi/qDATkZfrqDjFSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7fccBbB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7fccBbB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4C2C4CEC7;
	Tue,  1 Oct 2024 06:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727765245;
	bh=LtVt7ehTTBhyv9n7P3sh6p5RBizQeQ+VwmhO2uH/qRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V7fccBbBLUmpQ9XVEd6e4zRM7YzgWfS5cM/9XZVYIJEsmpjybRk99vdkEiISqVIG1
	 CHO/bGscdH+5K78w6iJgxzDrabliGuUKmo36NMD+kf9NLBoXoa+59Hj54NVdSySxiN
	 ngCDzadbIEzn8jN7dfPECQjSiCPi+hOYXQpnPG53eeLylyjdPuG/TCTBMiXoLRni+Y
	 HYAO4Cka4YyVtTNIk8UZ+F3nTwhv/01brIyRHR7N/ELf2CvIezzrqjieox9Nq7UPHw
	 zVNBazc+eDZ1PyfG8dx7eBpijWXmvxLu8IZJmK8K1vN2pMF0XI8e8MZo76mo9ATWKc
	 bX96VcKAxMaww==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 3/7] bpf: Add mptcp_sock acquire and release helpers
Date: Tue,  1 Oct 2024 14:47:10 +0800
Message-ID: <ad3c81cf6982aedd9f5a0933e27fc504af3fdcbb.1727764822.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727764822.git.tanggeliang@kylinos.cn>
References: <cover.1727764822.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

KF_TRUSTED_ARGS flag is used for bpf_iter_mptcp_subflow_new, it indicates
that the all pointer arguments are valid. It's necessary to add a
KF_ACQUIRE helper to get valid "msk".

This patch adds bpf_mptcp_sock_acquire() and bpf_mptcp_sock_release()
helpers for this. Increase sk->sk_refcnt in _acquire() and decrease it
in _release(). Register them with KF_ACQUIRE flag and KF_RELEASE flag.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 31bb2a869d34..f5700dbe2024 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -243,6 +243,22 @@ __bpf_kfunc void bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_subflow *i
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
@@ -264,6 +280,8 @@ BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_mptcp_sock_acquire, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_mptcp_sock_release, KF_RELEASE)
 BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
-- 
2.43.0

