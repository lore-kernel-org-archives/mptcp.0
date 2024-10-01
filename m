Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F5B63D
	for <mptcp@lists.linux.dev>; Tue,  1 Oct 2024 06:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727765247; cv=none; b=VKFdh7We2yxapZd063ZLQzWJMD4vHv7EPNO6dS2WSHWNo64J0IzhNQaWrxe3DVGgD+06ALNeiKj2nSKlpnemLH3rYYx7opOCQh4PSDyvBrpAeE40PffXQqTJqNh6H3TR+FhivBbAlEkIaPFwl0IsXlIvdo/z6SEL34c92O1FlkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727765247; c=relaxed/simple;
	bh=Q1Wx5JxP3AzULZ9dHq2Uun+kE+KkuUSuOgO/0ToF2w0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i5+rSfUB/ekz8oazMhSFoJZehmZdRdihtenL08QlyxoWsfEcb/8/UD/KfS8uqlf4fQgb9dUHJDuR9SfmbH6Sc9HgyIfC7vAZ7WbNeXTSN9ilk3kUG9+15dr/RzH3JS21llCHFr3SCNmr5oqVMLgMs0woW8mrkHKURRreYmDfSeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShdVo5Wy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShdVo5Wy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3EC8C4AF0B;
	Tue,  1 Oct 2024 06:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727765246;
	bh=Q1Wx5JxP3AzULZ9dHq2Uun+kE+KkuUSuOgO/0ToF2w0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ShdVo5WyirgN3Y3P0aO56g8dhWMwoyLJNwUiw0JnFIm40+ezMVIJ6RgsTqNrcrJZ0
	 jgOZU9EDgn0HeZ5KdXMGIY1jp93Trrn5a8m/qlW+W3MowvSfhyiqbcKkLW/L+d9s3Q
	 2YIwixCEgTGAL9EI8YpTUjpkkj2G2l8Tu+tl7an5m0lcmJHORhCfhtC6nRtbi+yJ9R
	 WHVKNaOdbpE3sZsanFJtT/tDSdfdDW1d+s7tGc0CtnouqLtbL0JlBLiseeNSQ386ab
	 EaQlmqfXqj29iEMMrVJkHDrqv8i7+SOSBDhQIdyKrXEFdCtn//P2wDpJKhwwgtFDtv
	 1vt/poAC1BwZA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 4/7] selftests/bpf: Add mptcp_subflow bpf_iter test prog
Date: Tue,  1 Oct 2024 14:47:11 +0800
Message-ID: <507c23f6f7fb09363d9665d2241430150b78fa05.1727764822.git.tanggeliang@kylinos.cn>
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

This patch adds a ftrace hook for mptcp_sched_get_send() to test the newly
added mptcp_subflow bpf_iter.

Export mptcp_subflow helpers bpf_iter_mptcp_subflow_new/_next/_destroy and
bpf_mptcp_sock_acquire/_release into bpf_experimental.h, then use
bpf_for_each(mptcp_subflow, subflow, msk) to walk the mptcp subflow list.
Invoke kfuncs mptcp_subflow_active() and mptcp_subflow_set_scheduled() in
the loop.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/bpf_experimental.h  |  7 ++++
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |  4 ++
 .../selftests/bpf/progs/mptcp_bpf_iter.c      | 39 +++++++++++++++++++
 3 files changed, 50 insertions(+)
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
index c3800f986ae1..0d84b206764b 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
@@ -43,9 +43,13 @@ mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
 }
 
 /* ksym */
+extern bool mptcp_subflow_active(struct mptcp_subflow_context *subflow) __ksym;
 extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 					bool scheduled) __ksym;
 
+extern struct mptcp_sock *bpf_mptcp_sock_acquire(struct mptcp_sock *msk) __ksym;
+extern void bpf_mptcp_sock_release(struct mptcp_sock *msk) __ksym;
+
 extern struct mptcp_subflow_context *
 bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos) __ksym;
 
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_iter.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_iter.c
new file mode 100644
index 000000000000..57ee738d27c1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_iter.c
@@ -0,0 +1,39 @@
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
+
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 0;
+
+	msk = bpf_mptcp_sock_acquire(msk);
+	if (!msk)
+		return 0;
+
+	subflows = 0;
+
+	bpf_for_each(mptcp_subflow, subflow, msk) {
+		if (subflow->token != msk->token)
+			break;
+
+		if (!mptcp_subflow_active(subflow))
+			continue;
+
+		mptcp_subflow_set_scheduled(subflow, false);
+		subflows++;
+	}
+	bpf_mptcp_sock_release(msk);
+
+	return 0;
+}
-- 
2.43.0

