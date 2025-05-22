Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038CF320F
	for <mptcp@lists.linux.dev>; Thu, 22 May 2025 07:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747897524; cv=none; b=pgZPKI224UXE6db1OPvBcAV4ra1RY5/WExDjtBP52VMrS1hheFKvtnLyhkY+t7VO1xx2Zp57HoVSTZ9c6JsxRxCYhgCNTXQ2OIZeSkqK/gH6x3a/P4rY0Edbl//SR61esfPxTw0p+9LiVZz8r0lmN295d89MjQWx/FhG2S7vuHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747897524; c=relaxed/simple;
	bh=YJH7KBp/Vt7JBWOzR8ymjr/VzEsGUXfpUMSxmH2gnq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q3kl/eRsvN0kq32Etd/Xwj7lQnANmb1ZIByYIbsThjRxD4HLmiIYXw6eMTEJ4yR9oinrZNab+03UmYsn5soi+Ghe1o18NIseoVIOt0+osgSXsyT+kCsnB8MfYgWWVSdjdN82rkH2MSiitCUrUb3/hBkI5jdBZDFHXEzfwiEZv4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Spf5S7eN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Spf5S7eN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6BBC4CEE4;
	Thu, 22 May 2025 07:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747897523;
	bh=YJH7KBp/Vt7JBWOzR8ymjr/VzEsGUXfpUMSxmH2gnq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Spf5S7eNdmD+2Nv8fPK2fBX9Jyg51NOb7+0boictFOlUhcApJUiY6VvUH/sJWSzHY
	 Zw540gJdLNVcRdHPE6r/7bnATnN3qkWfYxFc1v3spN6Y3tdmeXBrMoJcOozFKFn1JS
	 KSHbsjoZwV3aXYorAZY7Y0uQS4wliLpZx+Z5OFursw4XVjJtqC78O/1plOUF7MbDl6
	 /6lcJQoYHVv0vu9ZvxLH7xWVsMPhtMkEP4Ljk2y3Qo22W5hbOC/voCgZR3vkUU7Rhr
	 tfL/j/yMRh7C7oxcG1c9pxl3OFZs3NI84NucVzz/M3en4uIHe3MHKx0H8v+xxDrpJp
	 UIqtbssl7p38w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 2/2] Squash to "bpf: Export mptcp packet scheduler helpers"
Date: Thu, 22 May 2025 15:05:17 +0800
Message-ID: <dfd9d56e608ea3f68297092c9e90134e4807d3d6.1747897261.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747897261.git.tanggeliang@kylinos.cn>
References: <cover.1747897261.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Define .filter as Martin suggested.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 2b0cfb57df8c..c7a9d1393786 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -317,9 +317,30 @@ BTF_ID_FLAGS(func, bpf_mptcp_subflow_queues_empty)
 BTF_ID_FLAGS(func, mptcp_pm_subflow_chk_stale, KF_SLEEPABLE)
 BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
 
+static int bpf_mptcp_common_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	if (!btf_id_set8_contains(&bpf_mptcp_common_kfunc_ids, kfunc_id))
+		return 0;
+
+	if (prog->type != BPF_PROG_TYPE_STRUCT_OPS)
+		return -EACCES;
+
+	/* .filter is called sometimes before prog->aux->st_ops is set,
+	 * then prog->aux->st_ops is NULL. If return -EACCES in this case,
+	 * an error occur:
+	 * 	bug: bad parent state for iter next call
+	 */
+	if (prog->aux->st_ops &&
+	    prog->aux->st_ops != &bpf_mptcp_sched_ops)
+		return -EACCES;
+
+	return 0;
+}
+
 static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
 	.owner	= THIS_MODULE,
 	.set	= &bpf_mptcp_common_kfunc_ids,
+	.filter	= bpf_mptcp_common_kfunc_filter,
 };
 
 static int __init bpf_mptcp_kfunc_init(void)
@@ -327,8 +348,6 @@ static int __init bpf_mptcp_kfunc_init(void)
 	int ret;
 
 	ret = register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
-	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCKOPT,
-					       &bpf_mptcp_common_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					       &bpf_mptcp_common_kfunc_set);
 #ifdef CONFIG_BPF_JIT
-- 
2.43.0

