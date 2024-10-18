Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD267133987
	for <mptcp@lists.linux.dev>; Fri, 18 Oct 2024 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729267248; cv=none; b=c96Fgwiz9NpUDqDL7mxzaQK2kIlla6rIrLitcKkZOXEXstgJDx2YanBCi/4/gNlui6NRr/Rz6FgG+DPThZa93VgQ6NgfHafpmMdg2eNY1KuNlMLDTUUgOYHMNFru0EhhZjnD3cVKME0sL0pBj9E4Rl2m/f9XuXWswkAxBSrps9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729267248; c=relaxed/simple;
	bh=oLzEaoF7HhnJ/lJr3NNq07/yId5b/25FLKZSkKUO4MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sbtoUQunpVMW5AyPb+uEnwjRAb0JwwWIYgayOiwEsYOBo93aaxzh7a0BXXExpQEFltT7UEBR0JcnrLQEZEHM7egYiox21IJbOIgCQEW+tMI14YlFFryRXx+T+SENprdVBfCn7OiHidbzd0RWlUgoHN84/ISzaRxvYe2d2K3pRyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1om+gRT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1om+gRT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22766C4CEC5;
	Fri, 18 Oct 2024 16:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729267248;
	bh=oLzEaoF7HhnJ/lJr3NNq07/yId5b/25FLKZSkKUO4MM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T1om+gRTjmGXnBKATYFfpWQ7qNtsBVm9FWf6aqJcgRAsnedH20ARH0cBKLdCbMi2i
	 Ts+DSO47SJiGoB+utpURJpcuMMq4Upb7CbKNytAuGyb0Yhl1cNpJXkmuL1y7DKPIdF
	 JTeXr8IwbjrvTvQfxs40zEPkPeWv1M/5MidXPNJ2Zar2Z7m97Gs0/seHg1CsOlTH2/
	 GyKiPq+cgDhnjmj8jeMcfYXlho1NQkHdkxcn9zuUD5yM0fRilUm8UJlrCQ8hvWk+C2
	 mugPk9mRWz4G+4bKjBVugYuG8UQNuHxwZQRwBOg3UlwIUke+8tkpvzeZo9IaIPbBdR
	 a6TzhHHETgOhA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v12 8/8] Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
Date: Sat, 19 Oct 2024 00:00:28 +0800
Message-ID: <69f2524080295acce68e60be8903626568e8c5c4.1729267039.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729267039.git.tanggeliang@kylinos.cn>
References: <cover.1729267039.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Please update the subject to

	"bpf: Export mptcp packet scheduler helpers"

Make bpf_mptcp_subflow_queues_empty static.
Merge "bpf: Export more bpf_burst related functions" into this patch.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c      | 11 +++++++++++
 net/mptcp/protocol.c |  4 ++--
 net/mptcp/protocol.h |  2 ++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 476620526c79..1ad7f703abb2 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -288,6 +288,11 @@ bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int p
 	return data->contexts[pos];
 }
 
+__bpf_kfunc static bool bpf_mptcp_subflow_queues_empty(struct sock *sk)
+{
+	return tcp_rtx_queue_empty(sk);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_mptcp_common_kfunc_ids)
@@ -309,6 +314,12 @@ static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
 BTF_KFUNCS_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx_by_pos)
+BTF_ID_FLAGS(func, mptcp_subflow_active)
+BTF_ID_FLAGS(func, mptcp_set_timeout)
+BTF_ID_FLAGS(func, mptcp_wnd_end)
+BTF_ID_FLAGS(func, tcp_stream_memory_free)
+BTF_ID_FLAGS(func, bpf_mptcp_subflow_queues_empty)
+BTF_ID_FLAGS(func, mptcp_pm_subflow_chk_stale)
 BTF_KFUNCS_END(bpf_mptcp_sched_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set = {
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b0e9a745ea62..21bc3586c33e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -50,7 +50,7 @@ DEFINE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
 static struct net_device mptcp_napi_dev;
 
 /* Returns end sequence number of the receiver's advertised window */
-static u64 mptcp_wnd_end(const struct mptcp_sock *msk)
+u64 mptcp_wnd_end(const struct mptcp_sock *msk)
 {
 	return READ_ONCE(msk->wnd_end);
 }
@@ -489,7 +489,7 @@ static long mptcp_timeout_from_subflow(const struct mptcp_subflow_context *subfl
 	       inet_csk(ssk)->icsk_timeout - jiffies : 0;
 }
 
-static void mptcp_set_timeout(struct sock *sk)
+void mptcp_set_timeout(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow;
 	long tout = 0;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0624de84e339..b4c72a73594f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -720,6 +720,8 @@ void __mptcp_subflow_send_ack(struct sock *ssk);
 void mptcp_subflow_reset(struct sock *ssk);
 void mptcp_subflow_queue_clean(struct sock *sk, struct sock *ssk);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
+u64 mptcp_wnd_end(const struct mptcp_sock *msk);
+void mptcp_set_timeout(struct sock *sk);
 struct mptcp_subflow_context *
 bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos);
 struct sock *__mptcp_nmpc_sk(struct mptcp_sock *msk);
-- 
2.43.0

