Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3964B1CAA84
	for <mptcp@lists.linux.dev>; Sun,  2 Feb 2025 04:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738470969; cv=none; b=RrRs2W9OUZQep58yMFGvuuXGdMHPcVB8TG+P9dGBqnmf/7duLCR/UY/woIeKXEHDuwXySh3+N+62cMuYpZisY7HvM9vkLwBFIcOXiU+qOIbuwD/rCQqaYTD5Y7VZhIr4fAXKhYrW1xy1OoihRNF84HrOA55UDoheBxOblikZnVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738470969; c=relaxed/simple;
	bh=f8dTKPfnG9ZPz08IOWZ/i1ldFiBG8mEHo3twTxc7vH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKO82j9nu1smJ4xMBVEISg9IXSgHPpw1crkGAOgEMtQ5CafPB/cEvI652NMguEWeY77zskt0oEq+vgRMrzHiFon2kUWI/vo2ZAumUSlbsAihTnbTjXVUCdNLERau/5wfgcd5jV+d5NjTzC1p+iz0nOMXKLv6i47aL+B49feVOrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbN80OXF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbN80OXF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B12C4CEE3;
	Sun,  2 Feb 2025 04:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738470969;
	bh=f8dTKPfnG9ZPz08IOWZ/i1ldFiBG8mEHo3twTxc7vH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XbN80OXFzA/JLUMoYqwLZc/skRc0aIcfeTraDB3atWeKTDM+fHDhAkLxdG2C/1Ehw
	 SjbxMyOOKXmOBh8E9FQdv7IqYEjfhTDIO4mfvpEG61Xt2YyEt1wMewehEKeXvkO4Tr
	 p9VPqDraDZ1ACWaZ6Hbx1/cQtexCK2rOeJmkOLm0o6WPVxL95RzcbBY31O5V1RhCCk
	 JziXPAXVw+hWpFNtJkr+SlfuvZHD185rJ0/6MHMLrOBFYn4kaaDvzL554N3ncUx33S
	 nvrLrMZ26TdnIP7PSpEvv9rgxMnU8DYCnSnY+JazqhoZMDbHxbpe84n4H+QFQalTDH
	 fBUVl8mN1BZ9Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 4/5] Revert "bpf: Acquire and release mptcp socket"
Date: Sun,  2 Feb 2025 12:35:10 +0800
Message-ID: <fe7228964295fd898a3e1468231709cfd5386d23.1738470660.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1738470660.git.tanggeliang@kylinos.cn>
References: <cover.1738470660.git.tanggeliang@kylinos.cn>
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
index c0ac11f611b0..a74173cc8998 100644
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

