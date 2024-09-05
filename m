Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958391EA85
	for <mptcp@lists.linux.dev>; Thu,  5 Sep 2024 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725544341; cv=none; b=oANYh/x16CV8DDCx+E9VSuZ8PYXzol9FeLyu2CvqhVZYBwBh979C2s4hGE8TJKcOhETp9OpTtVSle/H7v9ETOc71Xaj/FFWzwoVIg9L9XVWGCRtOUbrTNzAge/iLKM++2Z+mvE3gmDL0g2PGptRb0l9zW3QXHc5F0iHct+I3xD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725544341; c=relaxed/simple;
	bh=bJr0UQrY9gjo9mLkj6nQItUIEAc6Iyb65LatvsgtBvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VmNF60o51Sri2SZ0RdkmzPo2OV+sWyMhIKNVMjBH8StptHvQnVrRATQL4kg1AMsWv1vOmMXTb66QRbOCGAwinx1/cEBZdERAWXf2S5YeulJCzq1QKofE48+eq9XSqdLTcc2275R+drANGGicnyemCj7qsJoJ07ZlFjgl7zOfN+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gaMSjAFn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaMSjAFn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558F1C4CEC3;
	Thu,  5 Sep 2024 13:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725544341;
	bh=bJr0UQrY9gjo9mLkj6nQItUIEAc6Iyb65LatvsgtBvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gaMSjAFnzXXOLcarryxeQ1gcY67l/2eriIx8qdyCinDBN6DUKiHNVxLe1JBsVjraX
	 e1uUtWk3rSZBNs8/IUZB3c0Q5svx/ZtMjokBElEFvsDGYNw5VTAD23rpuC3el/Ps2c
	 ec/CVzEgbO/fWRq510YZUIHiZ8vxAY83GUnuQieiWSMeTTvDFkrKcxxky3vJG1qYAu
	 HrpE8ZEy1wvWwltOL9lPTGFPfyxziqBQtQ6HchFcIygUAy/Yn1h28Q2qLkMS3FGj5b
	 eUJJ1nEmzPDsw8TIKxuCe0CavAkgkUOrFfhf03gzBOAOclAv+ZattgvDIFE+UUUeKe
	 SYrEI+VTyJUVg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 3/4] selftests/bpf: Add mptcp_subflow bpf_iter test prog
Date: Thu,  5 Sep 2024 21:52:11 +0800
Message-ID: <42d7177dbc273c36c1ef1d5d10d889f3cd0411e2.1725544210.git.tanggeliang@kylinos.cn>
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

This patch adds a new mptcp bpf selftest program for the newly added
mptcp_subflow bpf_iter.

Export bpf_iter_mptcp_subflow_new/_next/_destroy into bpf_experimental.h
then use bpf_for_each(mptcp_subflow, subflow, msk) to walk the mptcp
subflow list.

Add a trace for mptcp_subflow_get_send() to do this test and invoke
kfuncs mptcp_subflow_active() and mptcp_subflow_set_scheduled() in the
loop.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/bpf_experimental.h  |  7 ++++
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |  3 ++
 .../selftests/bpf/progs/mptcp_bpf_iter.c      | 38 +++++++++++++++++++
 3 files changed, 48 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_iter.c

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 828556cdc2f0..97aad95c90c6 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -549,6 +549,13 @@ extern int bpf_iter_css_new(struct bpf_iter_css *it,
 extern struct cgroup_subsys_state *bpf_iter_css_next(struct bpf_iter_css *it) __weak __ksym;
 extern void bpf_iter_css_destroy(struct bpf_iter_css *it) __weak __ksym;
 
+struct bpf_iter_mptcp_subflow;
+extern int bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subflow *it,
+				      struct mptcp_sock *msk) __weak __ksym;
+extern struct mptcp_subflow_context *
+bpf_iter_mptcp_subflow_next(struct bpf_iter_mptcp_subflow *it) __weak __ksym;
+extern void bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_subflow *it) __weak __ksym;
+
 extern int bpf_wq_init(struct bpf_wq *wq, void *p__map, unsigned int flags) __weak __ksym;
 extern int bpf_wq_start(struct bpf_wq *wq, unsigned int flags) __weak __ksym;
 extern int bpf_wq_set_callback_impl(struct bpf_wq *wq,
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
index 928a1e5ad8db..9496dad5e9f0 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
@@ -46,6 +46,9 @@ mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
 extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 					bool scheduled) __ksym;
 
+extern void bpf_rcu_read_lock(void) __ksym;
+extern void bpf_rcu_read_unlock(void) __ksym;
+
 extern struct mptcp_subflow_context *
 bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos) __ksym;
 
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_iter.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_iter.c
new file mode 100644
index 000000000000..a3e27901d1a0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_iter.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024, Kylin Software */
+
+/* vmlinux.h, bpf_helpers.h and other 'define' */
+#include "bpf_tracing_net.h"
+#include "mptcp_bpf.h"
+
+char _license[] SEC("license") = "GPL";
+int pid;
+
+extern bool mptcp_subflow_active(struct mptcp_subflow_context *subflow) __ksym;
+
+SEC("fentry/mptcp_subflow_get_send")
+struct sock *BPF_PROG(trace_mptcp_subflow_get_send, struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+	int i = 0;
+
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return NULL;
+
+	bpf_rcu_read_lock();
+	bpf_for_each(mptcp_subflow, subflow, msk) {
+		if (i++ > MPTCP_SUBFLOWS_MAX)
+			break;
+
+		if (subflow->token != msk->token)
+			break;
+
+		if (!mptcp_subflow_active(subflow))
+			continue;
+
+		mptcp_subflow_set_scheduled(subflow, false);
+	}
+	bpf_rcu_read_unlock();
+
+	return NULL;
+}
-- 
2.43.0

