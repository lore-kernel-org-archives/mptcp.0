Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B597B35E94F
	for <mptcp@lists.linux.dev>; Mon, 22 Jun 2026 05:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782107121; cv=none; b=Rz5YPiDtWKXiZKWNq/cp5+y+i4DtNZp1l3CPsF/bVvZEQsTlVe4Wy3h+uhForCoRqLnVUkghanwxiIfp8eHR9Y3kWLsZE0d93V75QUdfzx2tvp/P5hGE+OWyPanDUpDx9DyRSJMeCIsaOg9p80XjHz/yDB799+45bjI5CGhOJkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782107121; c=relaxed/simple;
	bh=s8/ZVSjx5uGYQgF2yUjZtjqYZvLOMFauNjcRdufCEmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pSOqbsht1g63QdbbfG7BruaT3Ju6FHPjE+acgLDjBqiCEb2hni4YXLucCBrkXswIBaMxJTENDv6RVu9RL0/xZAO3G39AEyCfeM5X/Pj9lFAwuWkosogCxtrbLd/MHJloXn3vt4v2oPKMWeyr0u09Z60xLkdfAcH3C+WwmZeiARY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vt5y1wW6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vt5y1wW6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA67D1F000E9;
	Mon, 22 Jun 2026 05:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782107120;
	bh=kKnWJNPfEXte+tBflpKIjdfVz6HrWblQsG17NAxwgKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vt5y1wW6k2mcVQMGfFplet+ajJAELwg4J8MZnLw4WUOlScE+y5KdgV5qUvZMc9IK+
	 HMlhkHmka4S5WCgQoEkwP97PdxOTPhG9+Ots2GxwCUZR3eo7CLVnWo7H0h49iblPiO
	 nb/6GvOMddQz+JfPYlyLCtDpLxXyVwOg/ZbVje5Qeko7vH11Dt6arvuZ848dmF5oke
	 cTNKdy4tsph0zjc4rZo+nQADTO3g5OK57uvO7dMQGjT8ITu9oG2hOgui4P67RNIZqu
	 ZbYTMx+MudmcRL5Bai1M76hc8WBarsR7XZmWq43QSbhZ7FMqxC0E8I8utwkXHcv9+N
	 SLyhuID/+0EKw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 3/7] Squash to "selftests/bpf: Add bpf_burst scheduler & test"
Date: Mon, 22 Jun 2026 13:45:03 +0800
Message-ID: <9478b630e87e24d61b2d3c236462a70ada74aa44.1782106180.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1782106180.git.tanggeliang@kylinos.cn>
References: <cover.1782106180.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Implement sk_stream_memory_free() logic inline in bpf_burst_get_send.
The original approach relied on the bpf_sk_stream_memory_free() kfunc,
which is being removed. The new implementation:
- Checks subflow send buffer (sk_wmem_queued < sk_sndbuf)
- Checks MPTCP notsent_bytes against msk->notsent_lowat
- Follows the same semantics as the kernel's __sk_stream_memory_free()

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 33 +++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
index 693fab55f7be..bd258776076c 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
@@ -18,10 +18,39 @@ char _license[] SEC("license") = "GPL";
 extern bool mptcp_subflow_active(struct mptcp_subflow_context *subflow) __ksym;
 extern void mptcp_set_timeout(struct sock *sk) __ksym;
 extern __u64 mptcp_wnd_end(const struct mptcp_sock *msk) __ksym;
-extern bool bpf_sk_stream_memory_free(const struct sock *sk) __ksym;
 extern bool bpf_mptcp_subflow_queues_empty(struct sock *sk) __ksym;
 extern void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk) __ksym;
 
+static __always_inline u32 mptcp_notsent_lowat(struct mptcp_sock *msk)
+{
+	return msk->notsent_lowat ?: UINT_MAX;
+}
+
+static __always_inline bool mptcp_stream_memory_free(struct mptcp_sock *msk,
+						     int wake)
+{
+	u32 notsent_bytes;
+
+	notsent_bytes = msk->write_seq - msk->snd_nxt;
+	return (notsent_bytes << wake) < mptcp_notsent_lowat(msk);
+}
+
+static __always_inline bool __sk_stream_memory_free(struct mptcp_sock *msk,
+						    const struct sock *ssk,
+						    int wake)
+{
+	if (ssk->sk_wmem_queued >= ssk->sk_sndbuf)
+		return false;
+
+	return mptcp_stream_memory_free(msk, wake);
+}
+
+static __always_inline bool sk_stream_memory_free(struct mptcp_sock *msk,
+						  const struct sock *ssk)
+{
+	return __sk_stream_memory_free(msk, ssk, 0);
+}
+
 static __always_inline __u64 div_u64(__u64 dividend, __u32 divisor)
 {
 	return dividend / divisor;
@@ -96,7 +125,7 @@ int BPF_PROG(bpf_burst_get_send, struct mptcp_sock *msk)
 		send_info[SSK_MODE_ACTIVE].ssk = send_info[SSK_MODE_BACKUP].ssk;
 
 	ssk = send_info[SSK_MODE_ACTIVE].ssk;
-	if (!ssk || !bpf_sk_stream_memory_free(ssk))
+	if (!ssk || !sk_stream_memory_free(msk, ssk))
 		return -1;
 
 	subflow = bpf_mptcp_subflow_ctx(ssk);
-- 
2.53.0

