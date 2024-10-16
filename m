Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263B618FC61
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 07:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729064011; cv=none; b=DVOxty9oPO9wJEIuNDkNkWmDl2JDMwzki7lZK1Ymn6As94pn78mYmwz7IQ8U3XII2QJpvsihVWh+xcrerD0evM/NQJP2Aou1VuLbwaakcUgJkflaJcKBqeptw54Yi+ry0j/RQJT5/2ozjtQduCH5+LSqgcgWuASyZTvjB2pBSjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729064011; c=relaxed/simple;
	bh=oaMGBd1pK55bdmLctreYWKC0GMO08L9WxrADmppgE/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GG3aRFrOUdHILIxuy+Ze1R2deCEcLxdgagdTIFDz9igCM4eRyKOfLTCONugvvg0bB6RbmbbfO7T8zmV94fRmdbmTKbxmoZV9xDHsnaFGWo1jNF2ldGjQmB8Brk0r//0w7c71/6Lgs1DKpKO18+zrcS2ybXNjAQAKnXHp1vXq+bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgOkQgnx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgOkQgnx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B02C4CEC5;
	Wed, 16 Oct 2024 07:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729064011;
	bh=oaMGBd1pK55bdmLctreYWKC0GMO08L9WxrADmppgE/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MgOkQgnxgI2hU/2UtACDUYhOLRPDOT9JvW34CK4uQYAcCxdHuKonZIqYvptJL96FY
	 cPiRmpTQuKSs6MR9HaBXPArbiUZnHrYl8D6vaCPuTz39HUbZaLSFBRL9DMoPjwrz1X
	 afV6uzuTiVV/W0M3q0eeeK/w04uqN1yyqwqlpmomAV5ZltO1FAI6kP/8yz1EMFVJQc
	 uNoJNAIcQLeg6PR4D2skMME9Itd6sVazZCvshJS55pmXywisna6c4HG7pRY4yXZrde
	 dcC8JsO5PYZtJM1IE+fzZuBM8qmgVS0vyM3USubjjQVHW5nRF6iivWnVtOKGOcuiRw
	 ETR+1lt05qbJg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 4/9] selftests/bpf: Add mptcp_subflow bpf_iter test prog
Date: Wed, 16 Oct 2024 15:33:11 +0800
Message-ID: <c2700ffe15a4d0747f1579675ed8440fbe0ea15a.1729063444.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729063444.git.tanggeliang@kylinos.cn>
References: <cover.1729063444.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a "cgroup/getsockopt" program "iters_subflow" to test the
newly added mptcp_subflow bpf_iter.

Export mptcp_subflow helpers bpf_iter_mptcp_subflow_new/_next/_destroy,
bpf_mptcp_sock_acquire/_release and other helpers into bpf_experimental.h.

Use bpf_mptcp_sock_acquire() to acquire the msk, then use bpf_for_each()
to walk the subflow list of this msk. MPTCP-specific packet scheduler kfunc
can be called in the loop. In this test, just add all subflow ids to local
veriable local_ids, then invoke the kfunc bpf_mptcp_subflow_tcp_sock() in
the loop to pick a subsocket.

Out of the loop, use bpf_mptcp_subflow_ctx() to get the subflow context
of the picked subsocket and do some verification. Finally, assign
local_ids to global variable ids so that the application can obtain this
value, and release the msk.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/bpf_experimental.h  |  7 +++
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |  8 +++
 .../selftests/bpf/progs/mptcp_bpf_iters.c     | 60 +++++++++++++++++++
 3 files changed, 75 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c

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
index c3800f986ae1..b1f6e1fb467e 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
@@ -43,6 +43,14 @@ mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
 }
 
 /* ksym */
+extern struct mptcp_sock *bpf_mptcp_sock_acquire(struct mptcp_sock *msk) __ksym;
+extern void bpf_mptcp_sock_release(struct mptcp_sock *msk) __ksym;
+
+extern struct mptcp_subflow_context *
+bpf_mptcp_subflow_ctx(const struct sock *sk) __ksym;
+extern struct sock *
+bpf_mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow) __ksym;
+
 extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 					bool scheduled) __ksym;
 
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
new file mode 100644
index 000000000000..263221ea6feb
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024, Kylin Software */
+
+/* vmlinux.h, bpf_helpers.h and other 'define' */
+#include "bpf_tracing_net.h"
+#include "mptcp_bpf.h"
+
+char _license[] SEC("license") = "GPL";
+int ids;
+
+SEC("cgroup/getsockopt")
+int iters_subflow(struct bpf_sockopt *ctx)
+{
+	struct mptcp_subflow_context *subflow;
+	struct bpf_sock *sk = ctx->sk;
+	struct sock *ssk = NULL;
+	struct mptcp_sock *msk;
+	int local_ids = 0;
+
+	if (!sk || sk->protocol != IPPROTO_MPTCP ||
+	    ctx->level != SOL_TCP || ctx->optname != TCP_CONGESTION)
+		return 1;
+
+	msk = bpf_mptcp_sk((struct sock *)sk);
+	if (msk->pm.server_side || !msk->pm.subflows)
+		return 1;
+
+	msk = bpf_mptcp_sock_acquire(msk);
+	if (!msk)
+		return 1;
+	bpf_for_each(mptcp_subflow, subflow, msk) {
+		/* Here MPTCP-specific packet scheduler kfunc can be called:
+		 * this test is not doing anything really useful, only to
+		 * verify the iteration works.
+		 */
+
+		local_ids += subflow->subflow_id;
+
+		/* only to check the following kfunc works */
+		ssk = bpf_mptcp_subflow_tcp_sock(subflow);
+	}
+
+	if (!ssk)
+		goto out;
+
+	/* assert: if not OK, something wrong on the kernel side */
+	if (ssk->sk_dport != ((struct sock *)msk)->sk_dport)
+		goto out;
+
+	/* only to check the following kfunc works */
+	subflow = bpf_mptcp_subflow_ctx(ssk);
+	if (subflow->token != msk->token)
+		goto out;
+
+	ids = local_ids;
+
+out:
+	bpf_mptcp_sock_release(msk);
+	return 1;
+}
-- 
2.43.0

