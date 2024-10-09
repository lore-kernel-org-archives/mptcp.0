Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D945A28EF
	for <mptcp@lists.linux.dev>; Wed,  9 Oct 2024 09:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728467173; cv=none; b=i0R3Nv4hqo9bIOZ59QGROpdO7As+V7uP8qH0AHBpavs8sjwMdQG8qY/xcogjDQrd1R6kMJGPYIlFUjqaoq0TjaaT+DydRb9LqvKhPKhznhKXJTJiwPboaT4Aih5pj3RIQRgfQQh1tOpOtP6WSavFHs/OEDHVZc+xfY/+rttOa18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728467173; c=relaxed/simple;
	bh=ds9vcLnZuG6PXMN18GiFP755NxYGaiSlT21Y7zWUWSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rZauHBR06KYN6FDp85wemKxNFXo62WbcgpFir+1HlvOje7/WFBkxZdEhPOcEuDJoWd+0mRyM3k1KUfvy4eUh3/7Vtp3TZQdMnKLa7jkTP0mbQMIsk9sJRL7EyzQ64tjvWDw8Z2jgPvAd1YR10igMwJZycJ8rWQmlKYhkJLnBgSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p6Pd8Xwq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p6Pd8Xwq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 798BAC4CECE;
	Wed,  9 Oct 2024 09:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728467173;
	bh=ds9vcLnZuG6PXMN18GiFP755NxYGaiSlT21Y7zWUWSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p6Pd8XwqApZr3GYBvx121fRJg0XbHl687rdSTMwiRNcoesSoAwzndcKNfRx/tKARQ
	 5FodB8gmkBVXobc9vEo7J6JxlOeRU2ykwrJfmywDZJrkke/4b7SBb1+3ULJSC4NHOW
	 6n7iBsbwPwt26mTJnrEozeS0yZvEN14RZyMuJ5G4HYkOssuo+5+XtNrqwnD34DxHv3
	 rJGrNVffNEKvv5pOVNc0xxaksFzJbO15gt0pZR+okf8jevwRRu54Okm1EVobe1BG09
	 VRDTMSq762Ay4YHiCewBrqt9H3rT2n/5Y+mt5MAbtQNsW4M7UriB+Zxklq2KSO3+eX
	 jOCU+oJIljvzg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 3/7] bpf: Add mptcp_sock acquire and release helpers
Date: Wed,  9 Oct 2024 17:45:45 +0800
Message-ID: <193b59575ea5f422ab83cdd64adc40b3b2963230.1728466623.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728466623.git.tanggeliang@kylinos.cn>
References: <cover.1728466623.git.tanggeliang@kylinos.cn>
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
index fe2ee03ff1ee..9b87eee13955 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -255,6 +255,22 @@ __bpf_kfunc void bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_subflow *i
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
@@ -278,6 +294,8 @@ BTF_ID_FLAGS(func, mptcp_subflow_active)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_mptcp_sock_acquire, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_mptcp_sock_release, KF_RELEASE)
 BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
-- 
2.43.0

