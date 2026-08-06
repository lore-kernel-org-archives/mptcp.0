Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD89C429025
	for <mptcp@lists.linux.dev>; Thu,  6 Aug 2026 09:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786007453; cv=none; b=KYfmM1+4D+jTjcwWmG39C1GV8HrCtJvrzZo/UgBWcMLR45bn6xLc5qzus3hNN+zcFdk8S60+ervkFoof8nxMefHM/6cqm/vBuySHTcyEqnsydmmPtqR6lAq1GNEgYnG5jh33mOGrFl/ORNy0Qq6deUvSRM/ye96z1UoYj9xlA2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786007453; c=relaxed/simple;
	bh=WlsGc20hLmrMqoAanRk8/I0Uz7Hwe6SOI/yZDNS+3Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ms/o2V+a9kRKrcrgdHc5l3p+3AkPbGBEW5d8rTQmSSTTRyjDNCwny6wUvWRjzzzEBq0BSwnwp27quEX2DtleI6r4+YxbKI/AK52tvU4ECnDh5WIa67ZeFzpZcJOUehlsansiYdNMJ5VCIL5vZY5aZl4dj2IfA4oaY5mp6o1k71Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GO0Dri+K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GO0Dri+K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1FA1F000E9;
	Thu,  6 Aug 2026 09:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786007451;
	bh=FkQFfBbx0A0TYTzJtiQ5Wcdrs9UkvX794w/NDF+Ruq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GO0Dri+Ku9JI8XH1z3+veTzjhiNaai8lQJOvwrAtB0dwe98+4BqEUE6DYNLMqtFQM
	 kHilp4ORjtSnuZ5WA7aIhTwz2xiMAnK01ZPnwYAHudS2JdbF9CHquWGAqQKNj6tsz0
	 SjAa3SO+b9GWAPbrJf1pOTzIRjY6LIheqESPl7/wSEWFjZ3UrD67ibFN/3fMEOiwpa
	 HFxN2me9pPLudF/W8Punr4tOMcYLJrQJjYLEUEKb8pNnFMoYTF5VCYn/2gRL2LLdwG
	 he/W+EG8kHP1sQ6gqNls7foDoMaoK/E0LO4KX2cIymN7nlboK3r+5IypXV8KzpSKId
	 Bh1ZpxY7alYHw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/2] Squash to "selftests/bpf: Add bpf_burst scheduler & test"
Date: Thu,  6 Aug 2026 17:10:38 +0800
Message-ID: <4365e7acc6848e42ea3cd0bd72a28884cb995bdf.1786007209.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1786007209.git.tanggeliang@kylinos.cn>
References: <cover.1786007209.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

mptcp_pm_subflow_chk_stale() is removed from mptcp_subflow_get_retrans()
in kernel, drop it in bpf_burst_get_retrans() too.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
index 8ff529d38a59..3d512b0efe6f 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
@@ -25,7 +25,6 @@ extern bool mptcp_subflow_active(struct mptcp_subflow_context *subflow) __ksym;
 extern void mptcp_set_timeout(struct sock *sk) __ksym;
 extern __u64 mptcp_wnd_end(const struct mptcp_sock *msk) __ksym;
 extern bool bpf_sk_stream_memory_free(const struct mptcp_subflow_context *subflow) __ksym;
-extern void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk) __ksym;
 
 static __always_inline __u64 div_u64(__u64 dividend, __u32 divisor)
 {
@@ -140,7 +139,6 @@ int BPF_PROG(bpf_burst_get_retrans, struct mptcp_sock *msk)
 
 		/* still data outstanding at TCP level? skip this */
 		if (!tcp_rtx_and_write_queues_empty(ssk)) {
-			mptcp_pm_subflow_chk_stale(msk, ssk);
 			min_stale_count = min(min_stale_count, subflow->stale_count);
 			continue;
 		}
-- 
2.53.0

