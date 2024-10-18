Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FE518FC75
	for <mptcp@lists.linux.dev>; Fri, 18 Oct 2024 09:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729243151; cv=none; b=II5PZAI/bRA0+UoeRz9utbrpk0hlZmHSMvXka/jNgdX9JLtAnOeya7uaLBlkTGQSTnkyNF2a8JTgZuORtz9mRzlY5Bm1xtfQbn+YtiCtg1RwjDDwMg2WbfWQUMKRqE8cRsUeCoLro95B5Ln2uSQa7Ml5Z4RgTrn7JufIzdHO9tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729243151; c=relaxed/simple;
	bh=gfI7ffM4BR6nmpfVDJI4OeNg/i5LZsn1ZqXbETAKL/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IO69B85HNbIYtpJrMFgBmkU6k37CT0EtJhC+Ib83gekytkYFpNW5Q3yZc7onm687RH7lN2aUmTddSUKH1AdFs1Bc+ow56fwFEM9U5mwxiagt8h+zNF9VJ+TzHzhwksW7QN8+GcItBQsq369Qw3CAPSI2xizcWSugPg2CygKfVdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LtzkAYFs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LtzkAYFs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87637C4CECF;
	Fri, 18 Oct 2024 09:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729243151;
	bh=gfI7ffM4BR6nmpfVDJI4OeNg/i5LZsn1ZqXbETAKL/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LtzkAYFssFzl6k0Rytr5WmChufW5ACZYKFK1PuroR7o3yO4hdxUTE4ppShHcN2LXS
	 DW+vDhyMVdJcAWCNpk1JSeomQKZDPdt9X6zRcnxvYCEuDwupg+JSTRmxi3wgPRFV0/
	 6EZ6U8/nnCKsAG4uUwgDeryJl/0B91lY/adXj5FkvX+BOwGSAGrMywM/xHcQ3hmz3i
	 qsVNxd6cj0wB/QF8uyqc+5ROcxGtV2vlHehpLeDaCwbJYDm+oJyHJ1z3fBh4dsqvd4
	 tAvd8i514S/osK1+wSxvwW0MCLfUH0RzaAgTrGr82JLZiBDlbs3PExTy0c4Amx3CAM
	 lz/URX3RqNPVw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 3/9] bpf: Acquire and release mptcp socket
Date: Fri, 18 Oct 2024 17:18:05 +0800
Message-ID: <e1103b087cf44ac990b6bfbc60da634b243a5735.1729242644.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729242644.git.tanggeliang@kylinos.cn>
References: <cover.1729242644.git.tanggeliang@kylinos.cn>
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

