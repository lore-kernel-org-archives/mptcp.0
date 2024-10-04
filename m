Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121FD1DC725
	for <mptcp@lists.linux.dev>; Fri,  4 Oct 2024 12:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728046267; cv=none; b=rU3J129VL3EdSLxOKAorla7fKI2Fy/rSNXAIB0r/FZDqzwJT2zBs6uQmcYW1dMKOvYApRZ3X8gZqlsvlO4dKXQAz02k7P8m8ZuKvHmPBUlNqRdDRPiSXlx5poTYd08KjHKggQW9v9URUZBgNNXqzoh4FmP5AecSMv7TqVn/qV30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728046267; c=relaxed/simple;
	bh=N4f5rVYDDgamnmspueWxm9kpAhwX+7YZy1q8g8y7Sno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILfTKDLrXtu1BQfajq98x7iNYKVy5Dc5RvYERb7Ycggd9bRmLLLubKyn+Xuvw7dRHUfw1gMb2L6LZcGcbAy2BAKWTwp6e6axENiUvIaM+di4i8jS2Ne4UjjWeYAEwUj3kqTC88Md5cMmGfZxqW7AHeF4f5HM0LatlY5hrtmAppE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLyNAxPU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLyNAxPU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A85C4E673;
	Fri,  4 Oct 2024 12:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728046266;
	bh=N4f5rVYDDgamnmspueWxm9kpAhwX+7YZy1q8g8y7Sno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OLyNAxPUgyRdQXvnPcMBltjUJUtAtf+1p99krsGmUPLFImBb8vLFzW/JiBvQvij8Z
	 axJqnMtMc3eOTSVOEANPHK4MpFVoRm5KNrZtxLjBHmQNR/HAd0EODyevZ7gFTiwa1V
	 mImsImne9/BRmpdeN6guzLxvndGQrt67ITvBe96AkJFI8Bw8RcDAhyaHOjHbSxmCSM
	 W7mtbtLp7z/CJKFEB9x5z/9zztOdDCIFK+5C/npWICCss08E2bJhdaYtGk/7tBff0D
	 r27NFMOLWe2gGlIKSD22tDxXem+dmIvHkb3fMVAr2y3Mq/tn2/XRbmkD11uRE/zHTf
	 9nCJXGwonlQVg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 3/7] bpf: Add mptcp_sock acquire and release helpers
Date: Fri,  4 Oct 2024 20:50:49 +0800
Message-ID: <93161d30c383af13faece05d6e47fd75ff61a697.1728046021.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728046021.git.tanggeliang@kylinos.cn>
References: <cover.1728046021.git.tanggeliang@kylinos.cn>
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
index 49df9e5d5667..1dd98765e2d1 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -260,6 +260,22 @@ __bpf_kfunc void bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_subflow *i
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
@@ -284,6 +300,8 @@ BTF_ID_FLAGS(func, mptcp_subflow_active)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_mptcp_sock_acquire, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_mptcp_sock_release, KF_RELEASE)
 BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
-- 
2.43.0

