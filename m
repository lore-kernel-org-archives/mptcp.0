Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81F91B3F3D
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 07:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729064005; cv=none; b=nkK1YpXEhXXbXaWM32NO4sl9rYjXKfLjqT2u28V83j1sL3XZrbn2IpXIKSh3EhvGrz/3Oaw65khxaLOj701rXJ/fEI0bZ2hEj/QTDsifg4n0AHmIUtyk8AXB30j4JSyspnc6bX9Q4dl8Jp2MjWyTrsVwZWo7C4uyVW1wq/+sLJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729064005; c=relaxed/simple;
	bh=BNcn869J6bhMq7f3DYJakpmobr9NwRGJK/HBSEdJhXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJEWEExcoAVIhoe7uo15zR7OwD2mL9eq0bt+Bu0t8CdKiBrfX1KLYbCttFfd1ty9qkDeHKE2rgT0FkosDN6r420sEf6I528c8fGotYt1pHbSpWYLdy3G5MG2n1TamAe8oeHqzOYxDuD9pCPAaeAkCrEBtfo9/d8yRCsLGoxlAno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blkdkdtV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blkdkdtV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41716C4CEC5;
	Wed, 16 Oct 2024 07:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729064005;
	bh=BNcn869J6bhMq7f3DYJakpmobr9NwRGJK/HBSEdJhXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=blkdkdtVd3+0cU9b+8mdXllKToXofxOPq2IkgwG2J/t/kBWRjaJ5hloeDDrAdAlSQ
	 7xd6uBcOvN72K9SJeP+U9acBnXZCYz/pW0D+Fwun0zDJu55855k/xvDSdemtcL/xxo
	 DYD/wTNuK1TCHD/mRrLSITCi2it8CAqaYc7p69Bpi++1FwM75vWeFBWLnFln9DERne
	 Xy+W8XByHDvSsdtCmnpchIDvZuFlOUSkV0tzl36Ff7gOY0K94RM81qsdmk5WmBkrOG
	 Jzq+RGpWtBeUSqYEgfGeoVJyUD50r1Gk3o1s/JJo+utTjImJkV9YdsYGQ29Yje4JB8
	 7wvaoSaArtY1A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 1/9] bpf: Register mptcp common kfunc set
Date: Wed, 16 Oct 2024 15:33:08 +0800
Message-ID: <654efc001ecb62731ce2f14103d4a7791098bdc5.1729063444.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729063444.git.tanggeliang@kylinos.cn>
References: <cover.1729063444.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Helpers mptcp_subflow_ctx() and mptcp_subflow_tcp_sock(), for converting
between struct mptcp_subflow_context and struct sock, are useful in MPTCP
BPF programs. This patch defines corresponding wrappers of them, and put
the wrappers into mptcp common kfunc set and register the set with the flag
BPF_PROG_TYPE_UNSPEC to let them accessible to all types of BPF programs.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 6414824402e6..22d2d4d09be7 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -205,6 +205,18 @@ __diag_push();
 __diag_ignore_all("-Wmissing-prototypes",
 		  "kfuncs which will be used in BPF programs");
 
+__bpf_kfunc static struct mptcp_subflow_context *
+bpf_mptcp_subflow_ctx(const struct sock *sk)
+{
+	return mptcp_subflow_ctx(sk);
+}
+
+__bpf_kfunc static struct sock *
+bpf_mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
+{
+	return mptcp_subflow_tcp_sock(subflow);
+}
+
 __bpf_kfunc struct mptcp_subflow_context *
 bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos)
 {
@@ -220,6 +232,16 @@ __bpf_kfunc bool bpf_mptcp_subflow_queues_empty(struct sock *sk)
 
 __diag_pop();
 
+BTF_KFUNCS_START(bpf_mptcp_common_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx)
+BTF_ID_FLAGS(func, bpf_mptcp_subflow_tcp_sock)
+BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
+
+static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
+	.owner	= THIS_MODULE,
+	.set	= &bpf_mptcp_common_kfunc_ids,
+};
+
 BTF_KFUNCS_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx_by_pos)
@@ -241,6 +263,8 @@ static int __init bpf_mptcp_kfunc_init(void)
 	int ret;
 
 	ret = register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
+					       &bpf_mptcp_common_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					       &bpf_mptcp_sched_kfunc_set);
 #ifdef CONFIG_BPF_JIT
-- 
2.43.0

