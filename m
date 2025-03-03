Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335EE1F3BAD
	for <mptcp@lists.linux.dev>; Mon,  3 Mar 2025 10:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998032; cv=none; b=GJU0vCc1I7az+o5ICQtq7K69zZbb1vt5bLnvfrFIfPY5hjxM1v0efD8zY9UmH851WLF97qqMhr0mQKvcGBPINePs4541Rg2+5m1YfyJrmfq0uCQHFdy5eeLlzTH1d3YlIW7D4rGOcPNs1480ZpOnMWTZD91n55+dbyqxqaILwUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998032; c=relaxed/simple;
	bh=dco71mADKrWFOJx0j5CmX6RjpZLYY5fBgwGpgyFHs1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q95cOM0UvGdoQXTQM3YqSfVG+VaOeUuJLS94wIMEqMFCKR/biALLzjbcOUCLD3Q6xBmFZsmqMDL51o+YElHfNRQFwJQ4NC9+g6VMk9a6ojMJxxRJbZdSKt70q7tE45/UT+IfdzRGtiLpIU3xl8kH06IaksNLZjVi2znNopGq9js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOsHi7u5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOsHi7u5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81146C4CEE5;
	Mon,  3 Mar 2025 10:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740998031;
	bh=dco71mADKrWFOJx0j5CmX6RjpZLYY5fBgwGpgyFHs1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NOsHi7u5JEq3x27L2IY4VbDJOU0ttcU+19uepTFbMH0RIU9vPJqwVlEggOwSmf+9l
	 bqmVacT8CClieBDch3502RMmXP8vzcTN2ghtwbErlZXK22iEhKp4NBRvg5WCodRjrv
	 G8ofp8DushiRIEJ9g0VCjQtcM/poGMyaklalGaxPbRwgqWkbeAhBwx0ozQX+3lvFUN
	 0eVu+6jBd70/WvW6rAZ6FwVidAyQiOR+D0NU1vw1sW70LHA/+zexLxp1asWQ/XFEP8
	 6aIMFuyd5uBq+DSe0e8CPw4sQdcC4KX4RFxK7Sb+i3Lv1eqgQzRrNgjHtVAh76MXZo
	 HDlXW7Hs+VePw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 4/5] Revert "bpf: Acquire and release mptcp socket"
Date: Mon,  3 Mar 2025 18:33:36 +0800
Message-ID: <b71087ed69b7859bd0408c7979aba9489d404ec3.1740997925.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740997925.git.tanggeliang@kylinos.cn>
References: <cover.1740997925.git.tanggeliang@kylinos.cn>
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
index a307490bb20e..9091da0a24b0 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -297,23 +297,6 @@ bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_subflow *it)
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
@@ -334,8 +317,6 @@ BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy, KF_ITER_DESTROY)
-BTF_ID_FLAGS(func, bpf_mptcp_sock_acquire, KF_ACQUIRE | KF_RET_NULL)
-BTF_ID_FLAGS(func, bpf_mptcp_sock_release, KF_RELEASE)
 BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
-- 
2.43.0

