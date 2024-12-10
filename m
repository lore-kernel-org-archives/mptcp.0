Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B2C111A8
	for <mptcp@lists.linux.dev>; Tue, 10 Dec 2024 03:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733801538; cv=none; b=omXP+EMvAyI3MKa0uZi3MKYUOoXWx4YfqQwmQC+vYnb8IXy75haemDN+/73TjAeMwiW6jRTW18Clwykb7LHjUpS3RyUMbQONXazf8Lbs7OZbpKOhPwwIrO0zdo4wNYFXy0eyAy7FmUX8khv6kcGnaS5yWoBOljWzKtldMA4Jb8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733801538; c=relaxed/simple;
	bh=wyrmivQNQCfbSFI4XHlRb9hYdqZQG4n+lfAtLYCea/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k8jhpqufV2mg2kmo7CJOa33AX0kshiFRYYKeG6P7xuyLTdrzr/y+KPvWmJBbZxHDrCN8ZpE3rJvqTGqp++vGqWkp1PTm85wnuTRIxY0q9b4jQ0U9S4ssUpj0H5cj9sGRksMlW+gStWueslRTekHAmWtd9fEsVMOBC83FHR0yc9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsWdQbcL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsWdQbcL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655D3C4CED6;
	Tue, 10 Dec 2024 03:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733801537;
	bh=wyrmivQNQCfbSFI4XHlRb9hYdqZQG4n+lfAtLYCea/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lsWdQbcL6nrylZq3cWkQE+3xycGx/cnmjPB4UHS/hylgS7cq5Y3d+rGNMF1tjkcMP
	 SUjNg5azIVhEd2LLaPl/K2LtrGKEbexN8V9deWP6FvidPJGiALH4eTr8VHwezCjB14
	 K62TYleHURSMt1M1BiHWMpC79TZnWDsD562hskPlX6O9nxtzAao+bws81mHFzFpa9o
	 2bdfpbpNxyJYK/r+Dr4Fc1i+okdMLbq8WlLaBmiPr1iT9GDmejnK6yq+WBmCkU+k7X
	 xXLqvYAnEFj8uNYCiYOD8ehaYQHj9afLEAYZpDdKYFR9jBQOAwMx+sTcRBkvIZ1D28
	 Y5U9iqaVw8ZjA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 7/9] Revert "mptcp: add sched_data helpers"
Date: Tue, 10 Dec 2024 11:31:44 +0800
Message-ID: <e0b8ff852c45132e8b740c99f0b1d494cf5ec157.1733800335.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733800334.git.tanggeliang@kylinos.cn>
References: <cover.1733800334.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Drop this patch. bpf_mptcp_subflow_ctx_by_pos and
mptcp_sched_data_set_contexts are uesless now.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c      |  8 --------
 net/mptcp/protocol.h |  2 --
 net/mptcp/sched.c    | 22 ----------------------
 3 files changed, 32 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 10d3db6323dc..8a9c7a91dd7a 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -305,14 +305,6 @@ __bpf_kfunc static void bpf_mptcp_sock_release(struct mptcp_sock *msk)
 	WARN_ON_ONCE(!sk || !refcount_dec_not_one(&sk->sk_refcnt));
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
index 78a7cfb84c69..1e6b6b85b850 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -727,8 +727,6 @@ void mptcp_subflow_queue_clean(struct sock *sk, struct sock *ssk);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
 u64 mptcp_wnd_end(const struct mptcp_sock *msk);
 void mptcp_set_timeout(struct sock *sk);
-struct mptcp_subflow_context *
-bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos);
 struct sock *__mptcp_nmpc_sk(struct mptcp_sock *msk);
 bool __mptcp_close(struct sock *sk, long timeout);
 void mptcp_cancel_work(struct sock *sk);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 6da60e35932f..df7dbcfa3b71 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -141,26 +141,6 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 	WRITE_ONCE(subflow->scheduled, scheduled);
 }
 
-static void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
-					  struct mptcp_sched_data *data)
-{
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
-}
-
 int mptcp_sched_get_send(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
@@ -187,7 +167,6 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 	data.reinject = false;
 	if (msk->sched == &mptcp_sched_default || !msk->sched)
 		return mptcp_sched_default_get_subflow(msk, &data);
-	mptcp_sched_data_set_contexts(msk, &data);
 	return msk->sched->get_subflow(msk, &data);
 }
 
@@ -210,6 +189,5 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 	data.reinject = true;
 	if (msk->sched == &mptcp_sched_default || !msk->sched)
 		return mptcp_sched_default_get_subflow(msk, &data);
-	mptcp_sched_data_set_contexts(msk, &data);
 	return msk->sched->get_subflow(msk, &data);
 }
-- 
2.45.2

