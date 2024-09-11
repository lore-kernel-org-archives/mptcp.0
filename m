Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A73D29CE6
	for <mptcp@lists.linux.dev>; Wed, 11 Sep 2024 03:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726023790; cv=none; b=fT5xtujA+cRX2nfbhGBa9sR/gN30XQlCjLUAzdR91M+whaaYCXsvtTclbsFVrAq/TnJJURdJiy01ChBc8RBzXEH63FqFGs15CbkcbW02k4XKPPrzG8hl26RNEnQcLuKCLRhP7VCgGLJ0iwW+7+mJLqhag5VAYUiIIpqBUfDdAaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726023790; c=relaxed/simple;
	bh=O7H5p81f3ccOd4bUeotTC/JgYHamD54yF+Aj4VgqtxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O+A6C6WdMORc8MB7nZZ2V+v2e3Jrb6spp7LIo5ljH8ITp/pj5qOGF95aCvqxf97JuGqEhR1rJ8xvvxri/z/Pdbvnj1ZNoBkmpCj93Fjcgj04DzE8aMDgUiKbvT6PeMl6FopbF1rYCxSvElcEJlfwKroXK69U2JfVGx2dzG+1Anc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDiFfwxJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDiFfwxJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1267EC4CECE;
	Wed, 11 Sep 2024 03:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726023789;
	bh=O7H5p81f3ccOd4bUeotTC/JgYHamD54yF+Aj4VgqtxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HDiFfwxJ06EsMk9Oasciv14GSvdUYMczZIUlr8c57jXgZttqTgTL3TldsfMhVC72N
	 Vx0XnFjlIfe0lBCogRI8aGm1ZOBUaiQk53kehZIYjbF4xp50BR50VuJztn/O8HIJ7k
	 qf5Gh8IZj2QHdvjplTLd92smM+FHEc+c2YCnXqLZfaj1Cyyps0aJF+LkX6wkiIgyhY
	 v57rfmbghtekpLmjn68npJd/qtyOT1/gR9yBpm4cHZE43nKuiEJGYwKtOpZv2yMdJB
	 YeOydjvypbPtjRxMVLWPSCphSU6DuzihmXF/7BN2+/GqV9ZlJ4KDNRmHLRhoBH8HZo
	 3O7qXYGTKLx6A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 2/5] selftests/bpf: Add mptcp_subflow bpf_iter test prog
Date: Wed, 11 Sep 2024 11:02:56 +0800
Message-ID: <e2ef1d277a4edf5263824d0b4cd2777fbc8d59b1.1726023577.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1726023577.git.tanggeliang@kylinos.cn>
References: <cover.1726023577.git.tanggeliang@kylinos.cn>
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

Add a ftrace hook for mptcp_sched_get_send() to do this test and invoke
kfuncs mptcp_subflow_active() and mptcp_subflow_set_scheduled() in the
loops.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/bpf_experimental.h  |  7 ++++
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |  4 ++
 .../selftests/bpf/progs/mptcp_bpf_iter.c      | 38 +++++++++++++++++++
 3 files changed, 49 insertions(+)
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
index 928a1e5ad8db..3280d4183beb 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
@@ -43,9 +43,13 @@ mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
 }
 
 /* ksym */
+extern bool mptcp_subflow_active(struct mptcp_subflow_context *subflow) __ksym;
 extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 					bool scheduled) __ksym;
 
+extern void bpf_rcu_read_lock(void) __ksym;
+extern void bpf_rcu_read_unlock(void) __ksym;
+
 extern struct mptcp_subflow_context *
 bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos) __ksym;
 
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_iter.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_iter.c
new file mode 100644
index 000000000000..03168be3980b
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
+int iter = 0;
+int pid;
+
+SEC("fentry/mptcp_sched_get_send")
+int BPF_PROG(trace_mptcp_sched_get_send, struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+	int i = 0;
+
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 0;
+
+	bpf_rcu_read_lock();
+	bpf_for_each(mptcp_subflow, subflow, msk) {
+		if (i++ >= MPTCP_SUBFLOWS_MAX)
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
+	iter = i;
+	return 0;
+}
-- 
2.43.0

