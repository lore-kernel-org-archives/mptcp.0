Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED70B18A6A9
	for <mptcp@lists.linux.dev>; Thu, 12 Sep 2024 09:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726133166; cv=none; b=TSQ/jOtG1OcpAblOaCdU+zzi3U3soR0TbpgNCcLZpSe2gM5BaaBIV+t+3XvaGCAyqYwdDcO8VYeu3yCckqMJlUXYwKp5dp6u4Yw8A2mQwZilS3URZocLAZjXj2vQkfETlD3livChtT0oV8xY8XhqBFBmzOHtRqsSZWUakJBBnbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726133166; c=relaxed/simple;
	bh=O7H5p81f3ccOd4bUeotTC/JgYHamD54yF+Aj4VgqtxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fwr+hl3xOl5MEbDKaQGNOBT1Ma8CVcVvPXeWp2v8oZdmJhHYLxkWoVoIwcv5WNbXDkL44KPP4VosoZEtZ3sWLsXH+Bupl3FTQFMq4afAmWMwn9+Wz2/P3nJ8jaT47aXx08qmlKZRQEVOmNmkVCLhRYlLBXEAtgSx9K75B29u/Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmJQowze; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmJQowze"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B79C4CEC5;
	Thu, 12 Sep 2024 09:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726133165;
	bh=O7H5p81f3ccOd4bUeotTC/JgYHamD54yF+Aj4VgqtxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lmJQowzeXsnOws1Pm3+je5xWy3L/QU4RCWFKsTOen6GMMFcSedmKej9CEYvhQYbYB
	 38B7hI+i9tv2lDRyAzNbKhTWKsvLLV8Zy9ke2FeHhb47Uys0bfSUOo9XL2Nvi9lrtN
	 S+nJh7YvY3ZaGUM5sREek83Lkcn9jMHcpXkQev2Vr4wJdUvYZDk2RK9q/rp+YrKKa4
	 G716PLV59GmkrJGXTWsl0mGhQYXgL9zpojFV1taSlz3uQI1SyVVgri0Z078jjFBQ3z
	 cLYvnFq06n8yX5DbC5sOQYaj/qPzaPfzgq8AR/kCJh2YsskjAu+7Mdi5+9m12tCdTz
	 GAp8szX2e0UAA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 2/5] selftests/bpf: Add mptcp_subflow bpf_iter test prog
Date: Thu, 12 Sep 2024 17:25:52 +0800
Message-ID: <4467ab3af0f1a6c378778ca6be72753b16a1532c.1726132802.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1726132802.git.tanggeliang@kylinos.cn>
References: <cover.1726132802.git.tanggeliang@kylinos.cn>
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

