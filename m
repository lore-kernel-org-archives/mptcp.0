Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98777CA62
	for <mptcp@lists.linux.dev>; Tue,  1 Oct 2024 06:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727765243; cv=none; b=riwBL7eySyCEFp/J/TvAA3zjVFySJI9fk6PkVuNmmBCO1k6CgAJ7T49qTmCNg+jn6RkOmlTxlPC8AoOqcr6IBOw0H6G5fNg0I3uKFmQK52mBZr5Xjy6kArbcKUkWDKaCheHR45zyIdCRRNPbkVUMMN3Wn3h/icXsAEQZMIo7d/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727765243; c=relaxed/simple;
	bh=kQqAiddCeIlBAqXA4dHyUYa56F4hufNbrB/31+DwG+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YMjjndaZwrbWOrDU164nci7fvh4dRnWIwkJCR1oIcOPbsH9Eum/yVT64nbkGJf4vvOav7gJVmTohF8hzgHwnlBA25nrkD2VOIJJtN3lGSVI6rpZ+3Lz5sbv8dV++LQZ75Bi/06UhLC6rPXv+YMoSclc9ey5wGKtay7rg1w5Juqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7Wh6u61; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7Wh6u61"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C737C4CEC7;
	Tue,  1 Oct 2024 06:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727765243;
	bh=kQqAiddCeIlBAqXA4dHyUYa56F4hufNbrB/31+DwG+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n7Wh6u61HCNABuldudGPCcA4MxbEEjulvXCH/r0bfKSz7wl+fS7XIVuB9jQGDkaUp
	 lr+vINnQeIerNmJl3DdDaOjmGuxwXfSlihsNj6kzMZpLex9gMk3IRbacsKayopnPtP
	 72WGyBwd7n+jxaumORyXwc7VkcNrv8YvPvGCu7Tk7ru3ITTTpfLq5G28RmHy9kux1Q
	 pX7dteoLkS6EzrjD1eIGQYBFF8v5nJ2q26kWSkP+BlvTSI7pjVCo7yALgncPpDA31w
	 xYeueHTKUydL2xFhnuwkxzguEsqwPOIniH/C5pkScIGa5gi+DUvyEt/dQWwdjKSn6o
	 L+DYVbfSayLSg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 1/7] bpf: Register mptcp common kfunc set
Date: Tue,  1 Oct 2024 14:47:08 +0800
Message-ID: <ecca7b1ec62ef28edecea7f4bb13272e7448143e.1727764822.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727764822.git.tanggeliang@kylinos.cn>
References: <cover.1727764822.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The mptcp kfuncs mptcp_subflow_active() and mptcp_subflow_set_scheduled()
are going to be used in BPF selftests, so put them into mptcp common kfunc
set and register it with BPF_PROG_TYPE_UNSPEC.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 6414824402e6..41937fde0bb6 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -220,10 +220,18 @@ __bpf_kfunc bool bpf_mptcp_subflow_queues_empty(struct sock *sk)
 
 __diag_pop();
 
-BTF_KFUNCS_START(bpf_mptcp_sched_kfunc_ids)
+BTF_KFUNCS_START(bpf_mptcp_common_kfunc_ids)
+BTF_ID_FLAGS(func, mptcp_subflow_active)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
+BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
+
+static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
+	.owner	= THIS_MODULE,
+	.set	= &bpf_mptcp_common_kfunc_ids,
+};
+
+BTF_KFUNCS_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx_by_pos)
-BTF_ID_FLAGS(func, mptcp_subflow_active)
 BTF_ID_FLAGS(func, mptcp_set_timeout)
 BTF_ID_FLAGS(func, mptcp_wnd_end)
 BTF_ID_FLAGS(func, tcp_stream_memory_free)
@@ -241,6 +249,8 @@ static int __init bpf_mptcp_kfunc_init(void)
 	int ret;
 
 	ret = register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
+					       &bpf_mptcp_common_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					       &bpf_mptcp_sched_kfunc_set);
 #ifdef CONFIG_BPF_JIT
-- 
2.43.0

