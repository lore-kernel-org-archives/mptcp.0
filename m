Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A8E1A0BE1
	for <mptcp@lists.linux.dev>; Tue, 10 Dec 2024 03:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733801541; cv=none; b=ebAQIPUnkjd2V7v/6AUDXxZ8AbtU7e1BqO7SyvDbmteD8ZLk1und4JUAUgsFvMJApuz78pf2Zi8v3K4Dueajtuba3BRc9ThDORTCNw8HZuDjwy5znK9UKi4hY4ZAVdojYU+Y5sYO/JEBW2v7JhaNF7q+uxQnlPyPD/jyfTjUL20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733801541; c=relaxed/simple;
	bh=5IBg0zzlOEIp6c4dUinkZxwxyokgH0hk0VuGn7nIjvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XYpo0WNG98KmCiRPMeCsBz3zKKwNCUCRv2AJIjD5+3IWFx9/rS9QhdGPZIfItM33AbyGx3CkG86NzcsjMWwtnsYjnzrFu+9gX8QA8+dAUWpnuTWhXW7L2xltqASioOkokb8HUuWG5280T5zxwiNteGIzYpPxmnbsn5g2RZJbmaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfB5EcWO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfB5EcWO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271FDC4CED6;
	Tue, 10 Dec 2024 03:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733801539;
	bh=5IBg0zzlOEIp6c4dUinkZxwxyokgH0hk0VuGn7nIjvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YfB5EcWOmszQdGupCvTGBzg//2tUTRvxIolV8A4GDr3YfXLcIAoLQYUrAMb/Q8IYk
	 TK0xCxBtbi3wGs9IwTFG7i2sN+5Gt/M60KJlz1mjVl4wXPVZwsX06tFYEjiGqlWRCw
	 hs7u4VIZ1X0MRnww3IUF2Kp18EtPHfKJ0eihz1ACBvzMmCs+ufM4CdK24cicau/UES
	 ABeTc473q+BrcOtbCARzLeLhbkaYzbInFj+rB14f9xr6EOL8mNWS1NJZZGdp/CBb5T
	 3bKxemorvmNpAh4vEjz9rtsKGBJtZT8ilOmKMCha+Dq0clJtuirYjZSzJiSNeRIqC4
	 DgUohUDxwvTZg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 8/9] Squash to "bpf: Export mptcp packet scheduler helpers"
Date: Tue, 10 Dec 2024 11:31:45 +0800
Message-ID: <5a05fc430573e3173336b401e7350740bcac38cb.1733800335.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733800334.git.tanggeliang@kylinos.cn>
References: <cover.1733800334.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Remove bpf_mptcp_subflow_ctx_by_pos from BPF kfunc set.
Drop bpf_mptcp_sched_kfunc_set, use bpf_mptcp_common_kfunc_set instead.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 8a9c7a91dd7a..1d1727ac1fc6 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -321,27 +321,18 @@ BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_mptcp_sock_acquire, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_mptcp_sock_release, KF_RELEASE)
-BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
-
-static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
-	.owner	= THIS_MODULE,
-	.set	= &bpf_mptcp_common_kfunc_ids,
-};
-
-BTF_KFUNCS_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
-BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx_by_pos)
 BTF_ID_FLAGS(func, mptcp_subflow_active)
 BTF_ID_FLAGS(func, mptcp_set_timeout)
 BTF_ID_FLAGS(func, mptcp_wnd_end)
 BTF_ID_FLAGS(func, tcp_stream_memory_free)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_queues_empty)
 BTF_ID_FLAGS(func, mptcp_pm_subflow_chk_stale)
-BTF_KFUNCS_END(bpf_mptcp_sched_kfunc_ids)
+BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
 
-static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set = {
+static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
 	.owner	= THIS_MODULE,
-	.set	= &bpf_mptcp_sched_kfunc_ids,
+	.set	= &bpf_mptcp_common_kfunc_ids,
 };
 
 static int __init bpf_mptcp_kfunc_init(void)
@@ -352,7 +343,7 @@ static int __init bpf_mptcp_kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
 					       &bpf_mptcp_common_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
-					       &bpf_mptcp_sched_kfunc_set);
+					       &bpf_mptcp_common_kfunc_set);
 #ifdef CONFIG_BPF_JIT
 	ret = ret ?: register_bpf_struct_ops(&bpf_mptcp_sched_ops, mptcp_sched_ops);
 #endif
-- 
2.45.2

