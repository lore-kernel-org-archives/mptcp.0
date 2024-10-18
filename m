Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2158B1EE030
	for <mptcp@lists.linux.dev>; Fri, 18 Oct 2024 09:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729243148; cv=none; b=Qa4300oMSLrJUckIpv7bDbfQGnQus+Hnm7HBkIDorXHvP9xqcDQeMEihwnkm9xt98OgY0R8hyxRiDv9X0auGrBmZCTGDybv8ulPWzbkEdCgM667CWTNqRIPGkX8Q9StDNeTox9BduRXYpzHDlaJ6ILTIfcMdXR1Di4M0wZ5LgrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729243148; c=relaxed/simple;
	bh=O/aDW83wsVpbVBtm3apBXP+i5+MgUJPEBFLiPHCpwps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bB71m4TQQEUNT2xl7M9tOZ9fmLt3Zx1086DVyC4pu+JHLPrGxRy8I/oIIN/imXuzxtD6jBDxBv5Qa53reqHFsT8CeKXmjwW3E6Nz4QhnVSk04hE8YP1GaaFE6J+PQBgBsBn7cCtWid3Ig2qANVCizI6A0DgdX9knBnTdpEzYTF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ia1HBelY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ia1HBelY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB10C4CEC3;
	Fri, 18 Oct 2024 09:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729243147;
	bh=O/aDW83wsVpbVBtm3apBXP+i5+MgUJPEBFLiPHCpwps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ia1HBelY8//abj6OLcAmf02jjOKx8bs6h+KeStxYaxpQ3l76hrIVeaclsjZF6UlRh
	 6thM+6v/QzPtrFcrjDzWpsER2NqKYG6VrLilK8d4RLBN0Urf/Q5YmIvDxLiqNnXhOW
	 4OFTd0PQbaph2EUlfYFKSJwcL2kYl59Zr2llZBaiN2GzF/sXIdSw4uvmr5RH41j812
	 VqTpIkFoZlsfo+tblczQ2nyfjavS9SW+3ntFp7dcWJCpZX3ar53kKFXtCS/D97kANw
	 OQ+F0fK+mh494Zv2bIocjzJjTZGlvH0ZrQj1Ud7f+LzSNy4qv+7X4iLP9CU0QC89Q6
	 Jnt1d6NB3CFGA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 1/9] bpf: Register mptcp common kfunc set
Date: Fri, 18 Oct 2024 17:18:03 +0800
Message-ID: <b8de99def444044d8a6d134bfdaf945be21cd9f6.1729242644.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729242644.git.tanggeliang@kylinos.cn>
References: <cover.1729242644.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

MPTCP helper mptcp_sk() is used to convert struct sock to mptcp_sock.
Helpers mptcp_subflow_ctx() and mptcp_subflow_tcp_sock() are used to
convert between struct mptcp_subflow_context and sock. They all will
be used in MPTCP BPF programs too. This patch defines corresponding
wrappers of them, and put the wrappers into mptcp common kfunc set
and register the set with the flag BPF_PROG_TYPE_UNSPEC to let them
accessible to all types of BPF programs.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index a9d6b5b939a2..efab2e6e28ef 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -209,6 +209,23 @@ __diag_push();
 __diag_ignore_all("-Wmissing-prototypes",
 		  "kfuncs which will be used in BPF programs");
 
+__bpf_kfunc static struct mptcp_sock *bpf_mptcp_sk(struct sock *sk)
+{
+	return mptcp_sk(sk);
+}
+
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
@@ -224,6 +241,17 @@ __bpf_kfunc bool bpf_mptcp_subflow_queues_empty(struct sock *sk)
 
 __diag_pop();
 
+BTF_KFUNCS_START(bpf_mptcp_common_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_mptcp_sk)
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
@@ -245,6 +273,8 @@ static int __init bpf_mptcp_kfunc_init(void)
 	int ret;
 
 	ret = register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
+					       &bpf_mptcp_common_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					       &bpf_mptcp_sched_kfunc_set);
 #ifdef CONFIG_BPF_JIT
-- 
2.43.0

