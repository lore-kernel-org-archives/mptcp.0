Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E59B80C13
	for <mptcp@lists.linux.dev>; Tue, 24 Sep 2024 09:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169009; cv=none; b=sJ7vxlJXgGx4JWpVzm/sJ8CbYsshSvc+HlAru6yQ+ejrSoxjzU3HZlR7b2urKhD45sbCyRh6d2Uv+62eZS46wvHOJj4v1BAh+Id26woJZlPSWpLRsehRaI44z9tpAaf6LtSAjqqNaHcBq0sb4Rtcm/IwYPxKsh3m5BaADZ89fHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169009; c=relaxed/simple;
	bh=5fLCxGFpHjELiPu/sDDRqRb7EBs7tE1st2nT3+IP+T0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oLox18naOMHlBhvraDF9wj7obm3sx0t5R1H2qUq7LkW1bXJyJiodjtouubVQeUFYr5Mhz84C6Iaa5m6BZLDtZIR2EAItMpTFIs7TIj7RTQiw5dOthS31yCnJDZ9dtr+69jtvX/qfHfuMMWK1BBCpyjyXLFAzazvzWj4QnlAu8/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ni46VGq+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ni46VGq+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A709C4CEC5;
	Tue, 24 Sep 2024 09:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727169009;
	bh=5fLCxGFpHjELiPu/sDDRqRb7EBs7tE1st2nT3+IP+T0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ni46VGq+8eGNGNU1ZZ3EJAw7erz7gI98Xg0PAGCmhZULGF8kQnZZSnNRSrnPD0gJw
	 KBDU8EtaM6gNHSVKkwR1l0o4cRgwXH+8brKOVSdd04H5znx4VhP1YpJYd6D0rE5bGH
	 6HVFlfHXn/zkAc1PpkuN38UB/Dm25uJtUGZFQwrDmVqiLQUsEFNfh1S7Da4rXvoUeS
	 bEq4TyZouOsJLmVnbVk2nK1bpuJ3ErIHZ+tUfMZI5gQ/GiNfQRqh3aBUv+/ZWqZb3H
	 9RYcSLnXPDPC9fds6taiIAO54XGJTgkQXwmy6llRc98cPRRm/2enAihbO+fKByEf5l
	 kdrn8QRWYR59A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 04/10] selftests/bpf: Add mptcp_subflow bpf_iter test prog
Date: Tue, 24 Sep 2024 17:09:48 +0800
Message-ID: <6b52ba4a67304ccb3b36f9e098a8e26d9ffb58ff.1727168628.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727168628.git.tanggeliang@kylinos.cn>
References: <cover.1727168628.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new mptcp bpf selftest program in "cgroup/getsockopt"
for the newly added mptcp_subflow bpf_iter.

Export bpf_mptcp_sk, bpf_iter_mptcp_subflow_new/_next/_destroy and
bpf_mptcp_sock_acquire/_release into bpf_experimental.h, then use
bpf_for_each(mptcp_subflow, subflow, msk) to walk the mptcp subflow list.
Invoke kfuncs mptcp_subflow_active() and mptcp_subflow_set_scheduled() in
bpf_for_each loop.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/bpf_experimental.h  |  7 +++
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |  6 +++
 .../selftests/bpf/progs/mptcp_bpf_iter.c      | 46 +++++++++++++++++++
 3 files changed, 59 insertions(+)
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
index c3800f986ae1..ab46b66422c4 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
@@ -43,6 +43,12 @@ mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
 }
 
 /* ksym */
+extern bool mptcp_subflow_active(struct mptcp_subflow_context *subflow) __ksym;
+extern struct mptcp_sock *bpf_mptcp_sk(struct sock *sk) __ksym;
+
+extern struct mptcp_sock *bpf_mptcp_sock_acquire(struct mptcp_sock *msk) __ksym;
+extern void bpf_mptcp_sock_release(struct mptcp_sock *msk) __ksym;
+
 extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 					bool scheduled) __ksym;
 
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_iter.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_iter.c
new file mode 100644
index 000000000000..39240df5bc3c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_iter.c
@@ -0,0 +1,46 @@
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
+SEC("cgroup/getsockopt")
+int mptcp_getsockopt(struct bpf_sockopt *ctx)
+{
+	struct mptcp_subflow_context *subflow;
+	struct bpf_sock *sk = ctx->sk;
+	struct mptcp_sock *msk;
+
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 1;
+
+	if (!sk || sk->protocol != IPPROTO_MPTCP ||
+	    ctx->level != SOL_TCP || ctx->optname != TCP_CONGESTION)
+		return 1;
+
+	msk = bpf_mptcp_sock_acquire(bpf_mptcp_sk((struct sock *)sk));
+	if (!msk)
+		return 1;
+
+	subflows = 0;
+
+	bpf_for_each(mptcp_subflow, subflow, msk) {
+		if (subflow->token != msk->token) {
+			ctx->retval = -1;
+			break;
+		}
+
+		if (!mptcp_subflow_active(subflow))
+			continue;
+
+		subflows++;
+	}
+	bpf_mptcp_sock_release(msk);
+
+	return 1;
+}
-- 
2.43.0

