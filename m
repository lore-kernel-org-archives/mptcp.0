Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189A7125B9
	for <mptcp@lists.linux.dev>; Mon,  9 Sep 2024 01:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725845820; cv=none; b=LxBNQItGgcifT7sYFgKYZ/AQ7xaHunR4HdABLNMc+UW6In0SYYj4i3XPAb3H7rj56MFdKTjO9dGNVDZgkQh3ImYjFeInAjO7Z+VjxTYS/WUvzM9tv1fYU65HBWwklVEXOpzDS85e3kMoSWJpl0dLnlA3+meA7+lpNSRQoxv6ykY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725845820; c=relaxed/simple;
	bh=JspjdKMBqx48yFGCjzfZH/jfXt7PLjQ88Jz68gDrMPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WpOCvsir4bH15FrsmV4JqI62/ndH3RM+L4bfzATD3vPF8FRD7niRlHlnrrKEdBUg6hxSsfdnLsYxQzOBeCj9YTcmUBb90a6MKTeXlQKQWTloA77pC/LHTVbV3K38CzVyGRiqjV3O5zsKbdIiDgp3y8K38vYgjf3HG9Gu2JOewfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXvSh+Fn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXvSh+Fn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B0D8C4CEC3;
	Mon,  9 Sep 2024 01:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725845819;
	bh=JspjdKMBqx48yFGCjzfZH/jfXt7PLjQ88Jz68gDrMPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cXvSh+Fnl/kKCgAGeaOTjE9i40EdZyh5gWSP2wrP/Y1dm/j3dXiarWc2ecvR343Kj
	 KFu/qu12o+sHJIz36wHvodUEgqjwXo7okCqjGdMkHLKfS+RbL56dLFx2GU74KeUa0F
	 3zvvf/mx0upxkQyRNRKCiJnBZCHQ1vP3Y4ku3657qa0lF7t3IRW/osWq/pQNvJb1YP
	 +BiJ1Tk+VDID96LGZmRFhZ5FlCwqSLlilkZ0mX7BIrXr11CmeqNOdN23h6XdgiLV0w
	 pUjtmX/5C0ie30qoiriNXnL8NEzS1U2Wqc50d9eFmBb5SJyh889/fSfuQNO2FtpphC
	 nLX0y6NlYuyIg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 2/4] bpf: Register mptcp tracing kfunc set
Date: Mon,  9 Sep 2024 09:36:45 +0800
Message-ID: <54b9eaedf9d244fa30b6db570f9eab366d4ee75f.1725845619.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1725845619.git.tanggeliang@kylinos.cn>
References: <cover.1725845619.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Since the kfuncs mptcp_subflow_active() and mptcp_subflow_set_scheduled()
are invoked in the mptcp_subflow bpf_iter test in a ftrace hook for
mptcp_sched_get_send(), it's necessary to register them into a
BPF_PROG_TYPE_TRACING type kfunc set together with the bpf_iter
mptcp_subflow helpers bpf_iter_mptcp_subflow_new()/_next()/_destroy().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 799264119891..f653142ada4f 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -275,9 +275,12 @@ __bpf_kfunc_end_defs();
 __diag_pop();
 
 BTF_KFUNCS_START(bpf_mptcp_sched_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new)
+BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next)
+BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy)
+BTF_ID_FLAGS(func, mptcp_subflow_active)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx_by_pos)
-BTF_ID_FLAGS(func, mptcp_subflow_active)
 BTF_ID_FLAGS(func, mptcp_set_timeout)
 BTF_ID_FLAGS(func, mptcp_wnd_end)
 BTF_ID_FLAGS(func, tcp_stream_memory_free)
@@ -295,6 +298,8 @@ static int __init bpf_mptcp_kfunc_init(void)
 	int ret;
 
 	ret = register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
+					       &bpf_mptcp_sched_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					       &bpf_mptcp_sched_kfunc_set);
 #ifdef CONFIG_BPF_JIT
-- 
2.43.0

