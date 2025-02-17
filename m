Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E603F23CE
	for <mptcp@lists.linux.dev>; Mon, 17 Feb 2025 10:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788886; cv=none; b=fY5W+yoz+ygrVJCA6Tx8jUOYuBc2V4ju5RG6VM43bu60WE2G6CDhpRgeXaHUgXpKW1Zdhnn5FN1VZ1JEglbAgVQ/0xYFmRVG+5h5BGLlE7sTswz45a5NLqgQPy1b+hJ7aoV8Elhcx+9fe57zU11ap6EVlO6VLitg0Bupxm1nwaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788886; c=relaxed/simple;
	bh=K3Rnb2UTkpBW7VUsFEJQvYCnR2M9r7U8PmE2AvJg74o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZnXTCCZDNQiTLiPbUKxaOD7cwpyzO5ZwLdL7lz+rgIQmy388CkpByJXLJ2MIhupeTquwT5zHqhujStkVpbi1oaL0xMqCTu5x80KR1WzZ1AXp1odxArdi+8op6SAEhXhui9lqQBpV0TGkSffxTovBsg5HJAQir0Y1LUJqzInngjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecdU9fIP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecdU9fIP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E067C4CED1;
	Mon, 17 Feb 2025 10:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739788885;
	bh=K3Rnb2UTkpBW7VUsFEJQvYCnR2M9r7U8PmE2AvJg74o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ecdU9fIPl2Yuj51we3wP00xblCRcQLEbw3Uk2Mz8l2yuLvG7ZYcSznmhccT0qj6UW
	 LGxid3HRJd6ybDwTwWmMe1WkQaXTgjfyjxaGXTpVj4BPHrnmtkTRw2zVZdauJK0cgw
	 fDkbp710WQK9V5NUiFAIxO3+rZLc5UN09pfRxGMSS3l53m3qW8BrHlT7XrekWIcj7z
	 9iLtDTk0GkSW549/7oh6lTmAZg/axQFHqzjr7qAxQc3m8rFttntrn26UnC4k0jZ4jc
	 f7ZSq61bhnRzmkYh6qDLgcfuW3bHROAb3ljWRmNUf21xDMVepXHrInISdgWkbMuzhc
	 yAnwhEwE9ybag==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v15 1/8] Squash to "mptcp: add sched_data helpers"
Date: Mon, 17 Feb 2025 18:41:11 +0800
Message-ID: <7ea96bb05373a60d2a95de3a43527e71a5eeed7e.1739788598.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1739788598.git.tanggeliang@kylinos.cn>
References: <cover.1739788598.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Drop bpf_mptcp_subflow_ctx_by_pos.
Keep mptcp_sched_data_set_contexts for future use.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c      |  8 --------
 net/mptcp/protocol.h |  2 --
 net/mptcp/sched.c    | 15 ---------------
 3 files changed, 25 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 2256d4de1e20..2d2ad38ab1c1 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -278,14 +278,6 @@ bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_subflow *it)
 {
 }
 
-__bpf_kfunc struct mptcp_subflow_context *
-bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos)
-{
-	if (pos >= MPTCP_SUBFLOWS_MAX)
-		return NULL;
-	return data->contexts[pos];
-}
-
 __bpf_kfunc static bool bpf_mptcp_subflow_queues_empty(struct sock *sk)
 {
 	return tcp_rtx_queue_empty(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index bac5c925a72f..a1d6d996aa93 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -718,8 +718,6 @@ void mptcp_subflow_queue_clean(struct sock *sk, struct sock *ssk);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
 u64 mptcp_wnd_end(const struct mptcp_sock *msk);
 void mptcp_set_timeout(struct sock *sk);
-struct mptcp_subflow_context *
-bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos);
 struct sock *__mptcp_nmpc_sk(struct mptcp_sock *msk);
 bool __mptcp_close(struct sock *sk, long timeout);
 void mptcp_cancel_work(struct sock *sk);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 37d86aadaeaa..ef3f0250ae1f 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -157,21 +157,6 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 static void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 					  struct mptcp_sched_data *data)
 {
-	struct mptcp_subflow_context *subflow;
-	int i = 0;
-
-	mptcp_for_each_subflow(msk, subflow) {
-		if (i == MPTCP_SUBFLOWS_MAX) {
-			pr_warn_once("too many subflows");
-			break;
-		}
-		mptcp_subflow_set_scheduled(subflow, false);
-		data->contexts[i++] = subflow;
-	}
-	data->subflows = i;
-
-	for (; i < MPTCP_SUBFLOWS_MAX; i++)
-		data->contexts[i] = NULL;
 }
 
 int mptcp_sched_get_send(struct mptcp_sock *msk)
-- 
2.43.0

