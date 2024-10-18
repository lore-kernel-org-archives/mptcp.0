Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E2D1E883A
	for <mptcp@lists.linux.dev>; Fri, 18 Oct 2024 09:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729243161; cv=none; b=Vgri44Cw531sd+5+FleX46k7t14rqt+bojyAudnaALUgDWVe5g+MVKlMxU3ysfu359byTAcIgLcpzcj3xqtnaPgxPCVUOTkZ7P1xKqR+XxgiaxeBSesk1KPUpNislkqlD+6bHO3tBGY/xlnmWGnRUt6xSbG884QSkJnaVAqD7HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729243161; c=relaxed/simple;
	bh=oLzEaoF7HhnJ/lJr3NNq07/yId5b/25FLKZSkKUO4MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bp9YLb0rFL2ecmeS4aT2N41NWeJ6/fJ+TdNR7b87uZmtfQPDj2tlEGQwGGSgUgKnnlJij6UqIwxBWrY/6mYggRrrZ6EAkL6aBTf5qfTheiAUDGsDLiF4eyLZKhTbHNvt3w2V8+9I66c5wzHwooMWmy2uGvT8KPeyRId2H1YqhJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6JcGgql; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6JcGgql"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4B9C4CEC3;
	Fri, 18 Oct 2024 09:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729243161;
	bh=oLzEaoF7HhnJ/lJr3NNq07/yId5b/25FLKZSkKUO4MM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K6JcGgqlnqZfUnk53cUCQCWEVH74BoJWS0B7maU0NrVoS3a4IS9b3JeC+GDmpzfWT
	 pWddlpgped8jlBY6GsfUCf+hTTgzkiETu1S1DZ1eJE26lvHueCP/S92QyRxQ8KJJjG
	 290Xgp4HUQsMAEBsvW95sI6Zq4OZN+kPUP5BP5cs84kp2C22UQxvou8NA0P1BUnayS
	 xYjjh93cmVtmXZl4GmnqKjkyKliwxIDD5zF+Fxm82UayDSJss1QOu2R3Tts3N9v6G7
	 FsWNwPRuxsgkqQoI/ONwKNVihSF6NGLDhhRsojiXQuwnhYWQdFSNNUnIjiN+McDM1Z
	 yNhEnVcDiq1uQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 9/9] Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
Date: Fri, 18 Oct 2024 17:18:11 +0800
Message-ID: <aaa85cd4e8b5e09ce2b066f66f016928a5989ae9.1729242644.git.tanggeliang@kylinos.cn>
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

