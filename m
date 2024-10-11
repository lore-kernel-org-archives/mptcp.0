Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DEA804
	for <mptcp@lists.linux.dev>; Fri, 11 Oct 2024 09:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728638854; cv=none; b=Ey1tezY47olB/z9kwPLpUi+s02+yNA2OiZL+hEAsx7SeEz1GlIMLAb2osaU9JrdBGgzT8cXV8ZBunbK21ioXk7EYRqVLNoaAJTbBCpheQtlWC0wATA/HiVqXk4rsA5YyTYD4/3ckicJ8KJmoBNx6EC5GpRkEYJwNJYVcA8p2OAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728638854; c=relaxed/simple;
	bh=dqyKSa2X/SjqFL0EQzoi2GNrNFplqJmrTVD+PETjlsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TxBhMF2PsRa54koqOgqeGzZ+yZp+OGidVvvlZK4pRlEUWFVtRT2f6pXHy8TQkRSse+/Q9a1ZLeGO5tIJ9T4Szv2tYgRtoYwBfG6Bnykd4a5f7yMZiClk8jJoTgqRUoUz1Qo8DgMufVhh9fChN05g3Si+JdrdE/nmZwKTihXrgRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rLOJVb1n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rLOJVb1n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29669C4CEC3;
	Fri, 11 Oct 2024 09:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728638854;
	bh=dqyKSa2X/SjqFL0EQzoi2GNrNFplqJmrTVD+PETjlsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rLOJVb1nZuHWKJHh+tpz8DfdV5W47RNu30ZfuzXg8GEhzXY8ze44pgDaIHm6gnRxk
	 MSv8Yt+/2qCIUGB/cxwQa2ULxXhvzAZ/oDhZAAf6uFHL2hmKBcqMzuJSoh7hkMwElF
	 TaJ8QIY+XWU2PdTvL5PodE+WbVNxirbj/pkU8ETAww8LumCxQsF9X2Vuaj8VMfYtu3
	 ktn/1Xm3jnRl5vP4fhBmdoRkQWIrWZDuxBVyaC/eCvd/s/gV4kSvh9cQ5B3H09wk9Q
	 THLo5v30lXyW97OjYROIlyv/7Csjko0WSoQjvkPgfsb+IlnOYG4FY1h4fYDBD6AnYn
	 rtdUqIRfSCOtg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 03/11] Revert "bpf: Add bpf_mptcp_sched_kfunc_set"
Date: Fri, 11 Oct 2024 17:27:15 +0800
Message-ID: <c0dcfa7f52b741dc5cbfb025126340d0e2caac85.1728638310.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728638310.git.tanggeliang@kylinos.cn>
References: <cover.1728638310.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Remove bpf_mptcp_subflow_ctx_by_pos from kfunc_set, it becomes empty
now. Drop this patch. It should be registered in the commit "bpf:
Export more bpf_burst related functions"

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index d0758479318c..22caff1d4dc2 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -298,19 +298,13 @@ static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
 	.set	= &bpf_mptcp_common_kfunc_ids,
 };
 
-BTF_KFUNCS_START(bpf_mptcp_sched_kfunc_ids)
-BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx_by_pos)
+/*
 BTF_ID_FLAGS(func, mptcp_set_timeout)
 BTF_ID_FLAGS(func, mptcp_wnd_end)
 BTF_ID_FLAGS(func, tcp_stream_memory_free)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_queues_empty)
 BTF_ID_FLAGS(func, mptcp_pm_subflow_chk_stale)
-BTF_KFUNCS_END(bpf_mptcp_sched_kfunc_ids)
-
-static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set = {
-	.owner	= THIS_MODULE,
-	.set	= &bpf_mptcp_sched_kfunc_ids,
-};
+*/
 
 static int __init bpf_mptcp_kfunc_init(void)
 {
@@ -319,8 +313,6 @@ static int __init bpf_mptcp_kfunc_init(void)
 	ret = register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
 					       &bpf_mptcp_common_kfunc_set);
-	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
-					       &bpf_mptcp_sched_kfunc_set);
 #ifdef CONFIG_BPF_JIT
 	ret = ret ?: register_bpf_struct_ops(&bpf_mptcp_sched_ops, mptcp_sched_ops);
 #endif
-- 
2.43.0

