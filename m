Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52DD148FF6
	for <mptcp@lists.linux.dev>; Fri,  4 Oct 2024 12:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728046268; cv=none; b=hq63kN8hTxzVXNa5mnFTbyHe3xyjBiqvixvd+cdmlKzgTmooPxieL4GWw8ky2samtK00GG3wm7vWnSF539oWi23l+bK42HCZ6L0UrGQs1XfSUyK9yjtwyquwTl0sy9U+4D/VFWHyihL1jn+qPsPw+o7GXhjYkIp5vrhcdIB0NfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728046268; c=relaxed/simple;
	bh=y8csAOl3RyE9Mf54rOn42XkriCJxKz+lbdbLXSwnqQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k65/vvVfCZUWvGWg2XPXeIeM5fVjTz3mioWb05/46IM0FQWaQlegz2fJvjtjeQy0v4JMYCLqu7mn0UXBXbZwp8Zj1p4vRd//F+rqxAOAuFaDrWFtXsdX8FEPgGdo+mT9SFfWKm/+j1O9bbeeezjC1Asc7MRmzqJltFfcwuuuSAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfMFBPwE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfMFBPwE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CEE5C4E66E;
	Fri,  4 Oct 2024 12:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728046268;
	bh=y8csAOl3RyE9Mf54rOn42XkriCJxKz+lbdbLXSwnqQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VfMFBPwEFfyBWSOYh8/XnbrUBJ7Kd4z7gdbyVZiiDvKVixAAh19azw+WpFl0rqItM
	 QRBhE5nqdfmIjmeMFGtTyMRGWaf9UCs8SVwFxoE7T8mDXeXphFKc2RINneH8YAswbb
	 MNXH3+ko3UYbMXEkRyy/qNCf4A3Mo/Ss/Y2bwUjQQA7B47tdtMCaymrDma3rvKn8D8
	 PK6ED+lfe/ncdbNdpkdpXKRGBFTjsH62xd2uOA19b1UxhVu6/rDGJzn1+p4kFHklHu
	 bD3EUfTRuRGt51+pJzlsw2p570P2/n5LVXmCZBDMKEOC6Sjvfarqihs3xneryABrmG
	 29CkHp+Tq4W1w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 4/7] selftests/bpf: Add mptcp_subflow bpf_iter test prog
Date: Fri,  4 Oct 2024 20:50:50 +0800
Message-ID: <107c9ba99516663569ccb0031259c7b4cbb1ad95.1728046021.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728046021.git.tanggeliang@kylinos.cn>
References: <cover.1728046021.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a ftrace hook for mptcp_sched_get_send() to test the newly
added mptcp_subflow bpf_iter. This test simulates a typical mptcp packet
scheduler, which selects a subflow from multiple subflows of an mptcp
socket to send data.

Export mptcp_subflow helpers bpf_iter_mptcp_subflow_new/_next/_destroy,
bpf_mptcp_sock_acquire/_release and other helpers into bpf_experimental.h.

Use _acquire() to acquire the msk, then use bpf_for_each(mptcp_subflow) to
walk the subflow list of this msk. Invoke kfuncs mptcp_subflow_active() and
bpf_mptcp_subflow_tcp_sock() in the loop to pick a subsocket. Finally use
bpf_mptcp_subflow_ctx() to get the subflow context of this subsocket and
use mptcp_subflow_set_scheduled() to set it as being scheduled.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/bpf_experimental.h  |  7 ++++
 tools/testing/selftests/bpf/progs/mptcp_bpf.h | 10 +++++
 .../selftests/bpf/progs/mptcp_bpf_iter.c      | 42 +++++++++++++++++++
 3 files changed, 59 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_iter.c

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index b0668f29f7b3..d43690b17468 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -575,6 +575,13 @@ extern int bpf_iter_css_new(struct bpf_iter_css *it,
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
index c3800f986ae1..ada2273bf7b6 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
@@ -43,9 +43,19 @@ mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
 }
 
 /* ksym */
+extern bool mptcp_subflow_active(struct mptcp_subflow_context *subflow) __ksym;
 extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 					bool scheduled) __ksym;
 
+extern struct mptcp_sock *bpf_mptcp_sock_acquire(struct mptcp_sock *msk) __ksym;
+extern void bpf_mptcp_sock_release(struct mptcp_sock *msk) __ksym;
+
+extern struct mptcp_sock *bpf_mptcp_sk(struct sock *sk) __ksym;
+extern struct mptcp_subflow_context *
+bpf_mptcp_subflow_ctx(const struct sock *sk) __ksym;
+extern struct sock *
+bpf_mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow) __ksym;
+
 extern struct mptcp_subflow_context *
 bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos) __ksym;
 
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_iter.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_iter.c
new file mode 100644
index 000000000000..4268e4604c5a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_iter.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024, Kylin Software */
+
+/* vmlinux.h, bpf_helpers.h and other 'define' */
+#include "bpf_tracing_net.h"
+#include "mptcp_bpf.h"
+
+char _license[] SEC("license") = "GPL";
+int subflows;
+int pid;
+
+SEC("fentry/mptcp_sched_get_send")
+int BPF_PROG(trace_mptcp_sched_get_send, struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *ssk = NULL;
+
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 0;
+
+	msk = bpf_mptcp_sock_acquire(msk);
+	if (!msk)
+		return 0;
+	bpf_for_each(mptcp_subflow, subflow, msk) {
+		if (subflow->token != msk->token)
+			break;
+
+		if (!mptcp_subflow_active(subflow))
+			continue;
+
+		ssk = bpf_mptcp_subflow_tcp_sock(subflow);
+	}
+	bpf_mptcp_sock_release(msk);
+
+	if (!ssk)
+		return 0;
+	subflow = bpf_mptcp_subflow_ctx(ssk);
+	mptcp_subflow_set_scheduled(subflow, true);
+	subflows = subflow->subflow_id;
+
+	return 0;
+}
-- 
2.43.0

