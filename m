Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275591EE030
	for <mptcp@lists.linux.dev>; Fri, 18 Oct 2024 09:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729243160; cv=none; b=tHjyN75Uzyy+6FgEO8zXvwItQToM2CrcnqgIcNfJ5aav8SExfnMyndlMREEdRrMDqYlpLGzNOClR/vJFBTlvhwDm3tnRAI4gzpeKjRNx9caN5Obf9uW5PIHULc+e2+W0Uunw8915doFVTofRpTcDvxq2DFY/YGlNzbHNtYJvRQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729243160; c=relaxed/simple;
	bh=Kbg/woWQyt8SzsP3SFPPdsPppNrlRZawsUM/d+hlE0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kRj/GnABVmOotG192X8dZo5lbkxfNawlXvRB7yHKtWCTYdFFSDBZVp2X7s+y8HTeWnbl9OqvQMGmLSWlrqfravAZl8GYUh++/Jc9gWjb06/8Sj+0tjmBPR8EIW1o4npj07gtmPkloVHkuOJqd+u2mUZ4R1WpU9JcSkBF6zeZjyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rL3Mvolx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rL3Mvolx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8398EC4CECF;
	Fri, 18 Oct 2024 09:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729243159;
	bh=Kbg/woWQyt8SzsP3SFPPdsPppNrlRZawsUM/d+hlE0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rL3MvolxVbC9JWS3FaS8R1n+O21fIMyYTn2chaJYQQoxfg1AJ7FpaUbQ5YWahf0TX
	 Qw7DUbwretnaVUssNYh2BCgF9yrL+ZjX6JhCZohvLE4P0+qErwKbmME5gzF6CwOuyh
	 3uBXRcCWi/uD2Mj9QpaHvX8GHNKgDC+hsCpZeLmyX+tRxEfUjFGl1G5x/6XBJff0V5
	 LYsmA7Prs7b8cfzOmg25Fh+Oy3UyAssOWYSyxAuEtMTavs8MHMvSXEIVnGkY9VUZb8
	 S/2PPOmV4E9CiQrg4sk5FAnoEp1JuB1n9tlebPyz1NX22TyQy4ahfm2x0jPTFVVDm/
	 vtbkg0Yv/xPvg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 8/9] Revert "bpf: Export more bpf_burst related functions"
Date: Fri, 18 Oct 2024 17:18:10 +0800
Message-ID: <02084f6354f9dae436d493618a7360af0b65e23b.1729242644.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729242644.git.tanggeliang@kylinos.cn>
References: <cover.1729242644.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This reverts commit 371136b55b559e2ef4d117a901b9f96ee036a175.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c      | 11 -----------
 net/mptcp/protocol.c |  4 ++--
 net/mptcp/protocol.h |  3 ---
 3 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index cf660e561d7b..476620526c79 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -288,11 +288,6 @@ bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int p
 	return data->contexts[pos];
 }
 
-__bpf_kfunc bool bpf_mptcp_subflow_queues_empty(struct sock *sk)
-{
-	return tcp_rtx_queue_empty(sk);
-}
-
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_mptcp_common_kfunc_ids)
@@ -314,12 +309,6 @@ static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
 BTF_KFUNCS_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx_by_pos)
-BTF_ID_FLAGS(func, mptcp_subflow_active)
-BTF_ID_FLAGS(func, mptcp_set_timeout)
-BTF_ID_FLAGS(func, mptcp_wnd_end)
-BTF_ID_FLAGS(func, tcp_stream_memory_free)
-BTF_ID_FLAGS(func, bpf_mptcp_subflow_queues_empty)
-BTF_ID_FLAGS(func, mptcp_pm_subflow_chk_stale)
 BTF_KFUNCS_END(bpf_mptcp_sched_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set = {
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 21bc3586c33e..b0e9a745ea62 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -50,7 +50,7 @@ DEFINE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
 static struct net_device mptcp_napi_dev;
 
 /* Returns end sequence number of the receiver's advertised window */
-u64 mptcp_wnd_end(const struct mptcp_sock *msk)
+static u64 mptcp_wnd_end(const struct mptcp_sock *msk)
 {
 	return READ_ONCE(msk->wnd_end);
 }
@@ -489,7 +489,7 @@ static long mptcp_timeout_from_subflow(const struct mptcp_subflow_context *subfl
 	       inet_csk(ssk)->icsk_timeout - jiffies : 0;
 }
 
-void mptcp_set_timeout(struct sock *sk)
+static void mptcp_set_timeout(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow;
 	long tout = 0;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b963e68451b1..0624de84e339 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -720,9 +720,6 @@ void __mptcp_subflow_send_ack(struct sock *ssk);
 void mptcp_subflow_reset(struct sock *ssk);
 void mptcp_subflow_queue_clean(struct sock *sk, struct sock *ssk);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
-u64 mptcp_wnd_end(const struct mptcp_sock *msk);
-void mptcp_set_timeout(struct sock *sk);
-bool bpf_mptcp_subflow_queues_empty(struct sock *sk);
 struct mptcp_subflow_context *
 bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos);
 struct sock *__mptcp_nmpc_sk(struct mptcp_sock *msk);
-- 
2.43.0

