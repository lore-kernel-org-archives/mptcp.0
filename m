Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459E51EA85
	for <mptcp@lists.linux.dev>; Thu,  5 Sep 2024 13:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725544340; cv=none; b=o6Ee+2uiJmXEUMBcC2YqY8SpGN5efe25NAdYNkOEsAVzH5mXAl7/ZtW4aTW3lL11ULhOVdzB3MRFiGS33EX8GTqacDQ6Y+WMBY5sCnCzU8I/gjbQiw0Mq8oAfaDnSLvREvnmz8BoSUalDbAD2N2bwcge4vBbedzNX/RfsqSL8kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725544340; c=relaxed/simple;
	bh=/7dcNxe7NJjQWtVfZyZqdN9uo0e0jW6M0qXBu8fSDN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mD8AJoDcxQXyj/B/wDQPAMxxHZl7bk7vrsPrRwuAlZ8bfjRgj1iK4Wkx6K2Wmtaw8Qh5wUDTcL5qPB9KWSxK3GcfwosCulI3+xypEHglXWjIO9AcyWLbrzNmZTppm8ttnAcJVlHOnSGr1NxDsE7v0hVrJgRvpFdYPq++M5xEzDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+ZuNabf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+ZuNabf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0455DC4CEC7;
	Thu,  5 Sep 2024 13:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725544339;
	bh=/7dcNxe7NJjQWtVfZyZqdN9uo0e0jW6M0qXBu8fSDN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o+ZuNabfl9JBDS6+aDwFpZRAWfBarmZ0ehsO6V7pZOYMacXowoAc1AvMNIS0U6u4m
	 fIe332GPRbjum6rUr7aBYGTQuu82MHBoyzKOKDUlgp921LgnQAvI11hZRWBLa4/SS1
	 dxer+L11HyVXp/A/zCBlvT84PcknHMdg2L+Ilw0x+O6J3wtwOSn+T0CsUiCXP5y96Z
	 q+reImIrRoPuFaILF5r+6ONz1liD+EzR2rgz3Dbc5od1MTcdor0mXorb9CzZK8tnAx
	 DZ0IF5zDcrmkT4eTaTQpOEAl+IlahHn1Hi8py+z0slhLVInab1JQkAmZzbkWc0FIkx
	 9t2Ir08CfzADg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/4] bpf: Register mptcp tracing kfunc set
Date: Thu,  5 Sep 2024 21:52:10 +0800
Message-ID: <10a0327a5c882326e5ace658bfd2a4d6e075d794.1725544210.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1725544210.git.tanggeliang@kylinos.cn>
References: <cover.1725544210.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Since the kfuncs mptcp_subflow_active() and mptcp_subflow_set_scheduled()
are invoked in the mptcp_subflow bpf_iter test in a trace for
mptcp_subflow_get_send(), it's necessary to register them into a
BPF_PROG_TYPE_TRACING type kfunc set.

Note:

 BTF_KFUNCS_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
 BTF_ID_FLAGS(func, mptcp_subflow_active)
 BTF_KFUNCS_END(bpf_mptcp_sched_kfunc_ids)

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index cda09bbfd617..01aedaff66ed 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -301,6 +301,8 @@ static int __init bpf_mptcp_kfunc_init(void)
 	int ret;
 
 	ret = register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
+					       &bpf_mptcp_sched_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					       &bpf_mptcp_sched_kfunc_set);
 #ifdef CONFIG_BPF_JIT
-- 
2.43.0

