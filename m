Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68549202642
	for <mptcp@lists.linux.dev>; Fri, 18 Oct 2024 10:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248735; cv=none; b=QlLatvFsXs2tD4f3oH5Xykz6GmwbavucCZrberseQiS928GRZtZ3t0I9O2Ig3Zi5xDhgjao7TJeab5bqsNn6p2RqFV1M9myzbenKuYDoXjjT+be/4HETCv4Hi+C7+1HFGYOlBHAYQeoYbWWzeZXQgTxBQdTLiC4lQBajAzDYv+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248735; c=relaxed/simple;
	bh=Ug1Y1GMWSEQ8/ec0m1xspvrZLUB5hAm3Fo4JLCG0Uak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JYNjvWfXNtwPjPO1YCQkLlQNbcEHj6A8mM4BLbefuB895/plkCdwezgjnRmZMiXcdadR1KBedT3PGgYtDvhw7eE6BtvbosXM8FI7fZ36eW0/Yr7NC9JsSylbk5XRH2LTnFA7aPTEDNwwhyhEBl3G5dIhTehh5CNCXNYfBqJXwSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWFNtKQl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWFNtKQl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12FB3C4CEC3;
	Fri, 18 Oct 2024 10:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729248735;
	bh=Ug1Y1GMWSEQ8/ec0m1xspvrZLUB5hAm3Fo4JLCG0Uak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MWFNtKQlCefJXIKwsJl1aR5PFBhE5jA6wUvALx/DpGapDMt3Bgyff9BRyraeXvZXp
	 swwRBgP4qDW7AONKpK5vk34B7vc8SIC9CoOEfXeEtjIPtJSJWAUjbagPR9K1/TNfpw
	 r3i9XDJZyXRrqQ+mzEtM5F/snuXFSxoO7vy5p2P2zaCVCWwiKkwfghL6YIt48FnlOq
	 VeuiLThgs0Aft8AHkUp7QnXTdWBfY4go7LLH+uouV3xUCoxbaO4Mq1xtLbjNPPZ7pJ
	 CCvofh0IXa7TuGOGe3nDlsPuZoR402mBWW1dSbO2c8NJhPSPPEtnxCA+/zbOvYILHF
	 V/DcIzYQWsgpQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 5/6] selftests/bpf: Add mptcp_address bpf_iter test prog
Date: Fri, 18 Oct 2024 18:51:57 +0800
Message-ID: <56151a024fbd4dacbfb919ca499641a88229e796.1729248083.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729248083.git.tanggeliang@kylinos.cn>
References: <cover.1729248083.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a test program for the newly added mptcp_address bpf_iter
in SEC "cgroup/getsockopt". This test iterates over all address entries on
the local address list of userspace PM and check whether each one is an
IPv4mapped address.

Export mptcp_address helpers bpf_iter_mptcp_address_new/_next/_destroy into
bpf_experimental.h. Use bpf_mptcp_sock_acquire() to acquire the msk, then
lock the msk pm lock and use bpf_for_each(mptcp_address) to walk the local
address list of this msk. Invoke bpf_ipv6_addr_v4mapped() in the loop to
check whether the address is an IPv4mapped one. Then Add the address ID of
each entry to local veriable local_ids.

Out of the loop, unlock the msk pm lock and use bpf_mptcp_sock_release() to
release the msk. Finally, assign local_ids to global variable ids so that
the application can obtain this value.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/bpf_experimental.h  |  7 ++++
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |  5 +++
 .../selftests/bpf/progs/mptcp_bpf_iters.c     | 39 +++++++++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index d43690b17468..e6db7797539c 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -582,6 +582,13 @@ extern struct mptcp_subflow_context *
 bpf_iter_mptcp_subflow_next(struct bpf_iter_mptcp_subflow *it) __weak __ksym;
 extern void bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_subflow *it) __weak __ksym;
 
+struct bpf_iter_mptcp_address;
+extern int bpf_iter_mptcp_address_new(struct bpf_iter_mptcp_address *it,
+				      struct mptcp_sock *msk) __weak __ksym;
+extern struct mptcp_pm_addr_entry *
+bpf_iter_mptcp_address_next(struct bpf_iter_mptcp_address *it) __weak __ksym;
+extern void bpf_iter_mptcp_address_destroy(struct bpf_iter_mptcp_address *it) __weak __ksym;
+
 extern int bpf_wq_init(struct bpf_wq *wq, void *p__map, unsigned int flags) __weak __ksym;
 extern int bpf_wq_start(struct bpf_wq *wq, unsigned int flags) __weak __ksym;
 extern int bpf_wq_set_callback_impl(struct bpf_wq *wq,
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
index 3b20cfd44505..376979a9c4f0 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
@@ -52,6 +52,11 @@ bpf_mptcp_subflow_ctx(const struct sock *sk) __ksym;
 extern struct sock *
 bpf_mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow) __ksym;
 
+extern void bpf_spin_lock_bh(spinlock_t *lock) __ksym;
+extern void bpf_spin_unlock_bh(spinlock_t *lock) __ksym;
+
+extern bool bpf_ipv6_addr_v4mapped(const struct mptcp_addr_info *a) __ksym;
+
 extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 					bool scheduled) __ksym;
 
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
index 263221ea6feb..2423cf392b79 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
@@ -58,3 +58,42 @@ int iters_subflow(struct bpf_sockopt *ctx)
 	bpf_mptcp_sock_release(msk);
 	return 1;
 }
+
+SEC("cgroup/getsockopt")
+int iters_address(struct bpf_sockopt *ctx)
+{
+	struct mptcp_pm_addr_entry *entry;
+	struct bpf_sock *sk = ctx->sk;
+	struct mptcp_sock *msk;
+	int local_ids = 0;
+
+	if (!sk || sk->protocol != IPPROTO_MPTCP ||
+	    ctx->level != SOL_TCP || ctx->optname != TCP_CONGESTION)
+		return 1;
+
+	msk = bpf_mptcp_sk((struct sock *)sk);
+	if (msk->pm.server_side)
+		return 1;
+
+	msk = bpf_mptcp_sock_acquire(msk);
+	if (!msk)
+		return 1;
+	bpf_spin_lock_bh(&msk->pm.lock);
+	bpf_for_each(mptcp_address, entry, msk) {
+		/* Here MPTCP-specific path manager kfunc can be called:
+		 * this test is not doing anything really useful, only to
+		 * verify the iteration works.
+		 */
+
+		if (!bpf_ipv6_addr_v4mapped(&entry->addr))
+			break;
+
+		local_ids += entry->addr.id;
+	}
+	bpf_spin_unlock_bh(&msk->pm.lock);
+	bpf_mptcp_sock_release(msk);
+
+	ids = local_ids;
+
+	return 1;
+}
-- 
2.43.0

