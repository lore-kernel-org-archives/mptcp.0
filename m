Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74FC28EF
	for <mptcp@lists.linux.dev>; Wed,  9 Oct 2024 09:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728467175; cv=none; b=HFGeUybiFhd0/T+gFNMPne671KUGqhCw4Nhh23zfYLAL6aKWyPaQaGzuSFQ827tuMPvFns2w2e6hqUfWybhzoJ2nzJiLIo7Farf7iFLK6S1fUVAFNRudmaVMI/dayyEqrUjK0prHiVskIhCG8/Q9My0A/I7nwzbKJTaNh2PN798=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728467175; c=relaxed/simple;
	bh=55BhygoHSnTYYfomdFgaqo3ZmgCtTbwjGCXei+paJwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ENpWVKUG4pChF9XCbshjglRbkdq/n6zTZWJUU8Opd9vMMXyE7TBjHWh12KvCr+XDkYATTk36H7tl0ilkFgDEXSpmasRXHNAXxCkVOqW0Mfed7Tw5xE5laXxymjzed/weO4pWyp7vr+8N36tWt/lMOrl0v32iS3tNI+qAA02X4PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVWGObKc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVWGObKc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20ACCC4CEC5;
	Wed,  9 Oct 2024 09:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728467175;
	bh=55BhygoHSnTYYfomdFgaqo3ZmgCtTbwjGCXei+paJwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QVWGObKc+ee0QJ1lDcFHHtunMG3W3g10c1SuKdVymJpWX9AF4dmLafLTZGjiOcLNO
	 yIFYlEutxmB2QGc26nj5I/DHpcq9GHYbL/WcTWdcU3ZzdKrYDKkgYLsspFyHr9UUEt
	 LV3qTDa46MH585vC3TFnJ6/jA5g8QhI/TIV4WsUUk1VixGIIRGPaSsW8Nn9Kt17oX6
	 9EcBtoG1UQSpKxrQ7bRLcCHVfJJ9LM986lg5s4QptxIvlwdQagSQ673pO6y1yy/uQ5
	 ZcuLGJxKLiLFEWbEmNWro4S4lR156401SxCb369qi12POnFxzYzfJuWuzPasrqRnuM
	 KVueivwnKTEQA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 4/7] selftests/bpf: Add mptcp_subflow bpf_iter test prog
Date: Wed,  9 Oct 2024 17:45:46 +0800
Message-ID: <dffa6284797ec2e3e8c8a1f6891f012bd1efdc20.1728466623.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728466623.git.tanggeliang@kylinos.cn>
References: <cover.1728466623.git.tanggeliang@kylinos.cn>
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
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |  9 ++++
 .../bpf/progs/mptcp_bpf_iters_subflow.c       | 42 +++++++++++++++++++
 3 files changed, 58 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_iters_subflow.c

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
index c3800f986ae1..e18796361394 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
@@ -43,9 +43,18 @@ mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
 }
 
 /* ksym */
+extern bool mptcp_subflow_active(struct mptcp_subflow_context *subflow) __ksym;
 extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 					bool scheduled) __ksym;
 
+extern struct mptcp_sock *bpf_mptcp_sock_acquire(struct mptcp_sock *msk) __ksym;
+extern void bpf_mptcp_sock_release(struct mptcp_sock *msk) __ksym;
+
+extern struct mptcp_subflow_context *
+bpf_mptcp_subflow_ctx(const struct sock *sk) __ksym;
+extern struct sock *
+bpf_mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow) __ksym;
+
 extern struct mptcp_subflow_context *
 bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos) __ksym;
 
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_iters_subflow.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_iters_subflow.c
new file mode 100644
index 000000000000..4268e4604c5a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_iters_subflow.c
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

