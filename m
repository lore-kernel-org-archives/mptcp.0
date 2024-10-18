Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068744207A
	for <mptcp@lists.linux.dev>; Fri, 18 Oct 2024 16:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729267240; cv=none; b=E8cGAOSfFPmKRtG+chzOcwQhdZHwnk/boRh1aZ44frZVeONapRsE1fSWyCn6JSjppJbAVM7K4E1OKI2x7+2NdEGrlKnegkihn5OHrv3ssGrkvgJYnL/Dd/ath3ni/A99pihiTBviRZzy2+PHiNiGP3I/KEsTqbP/14fkD9i5USc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729267240; c=relaxed/simple;
	bh=gfI7ffM4BR6nmpfVDJI4OeNg/i5LZsn1ZqXbETAKL/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XdOhcBsVIdpKh4IfMOEV3TGPCq7yRNbI2bjsgwuIZPJM1v6r8Ju7dfthakktJWlgdfk4L0p0CgJ8ZPizPYrLh0OA9K5h5+7qPGrut4Wg5jlCHeu9lfbo6D1BHCtrFbjL8wJGQt086ONpWRUzMv50c/B5yXP9Om3Ww2dxa08tmuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/Xaml/x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/Xaml/x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2862C4CEC5;
	Fri, 18 Oct 2024 16:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729267239;
	bh=gfI7ffM4BR6nmpfVDJI4OeNg/i5LZsn1ZqXbETAKL/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k/Xaml/xTiTeHhfDTcw2ff8IYFj6qidirdVAWgN6tgCKxi1RV0qzWcJdvqFGHd7k6
	 wKuH1zJXxdoCkaySTykicoavPH6hGq+LUsLrWeZPAthrc+rca/l4aZYGDsR7XzQElE
	 gSyAs7jDFfNSzh5TzO+HjKXidLJSoMJBKWy9YnvP9CsbsqrolhCgxKW2bSwLRH9/OQ
	 WqU4tDAhX98O9M1WNFl/dsCWeWieXtNcL4betRYeBWtSvp+QFkd5ANVmm36DA7k9wQ
	 D5WgENYGzg3NxAIQlCc5t6irjpb4hQ9hlNh3g5GJLMmiP9kN3pItWhCGuocnHWvs3Y
	 qeQBmg1n44p/g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v12 3/8] bpf: Acquire and release mptcp socket
Date: Sat, 19 Oct 2024 00:00:23 +0800
Message-ID: <e1103b087cf44ac990b6bfbc60da634b243a5735.1729267039.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729267039.git.tanggeliang@kylinos.cn>
References: <cover.1729267039.git.tanggeliang@kylinos.cn>
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
index 65fa84d1e745..cf660e561d7b 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -264,6 +264,22 @@ __bpf_kfunc static void bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_sub
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
@@ -286,6 +302,8 @@ BTF_ID_FLAGS(func, bpf_mptcp_subflow_tcp_sock)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_mptcp_sock_acquire, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_mptcp_sock_release, KF_RELEASE)
 BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
-- 
2.43.0

