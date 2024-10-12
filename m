Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9311891B2
	for <mptcp@lists.linux.dev>; Sat, 12 Oct 2024 13:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728740557; cv=none; b=AEZY3D06iNmMX4R7I3b7Edo6kHf7zwJ58PpGw7IBEsAUv0GEgHzts4fvKkxLPBzXrdRpLCRHocTs6d9rF7yyYxJJmach9NrSXXNHRMESblGwmCggpcWQ7bsQum8w8JFIrsDVNJYTwSslDFLK5lFtxmI+sPt5OmrrrfNUCmsc9sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728740557; c=relaxed/simple;
	bh=efrgzvFmXp/p3PDPiPF/b3P1G1kO5oQ0XJgaCKadQSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F8ET9rEGeBi4rMHn/9egE3gZGssYSyIJY1UdlB+I+2496OAziV0zA/BklZZfGudaw9gcETLe3jldUi4AXQ8KTeAeapW5sL5+jE86DDziflKOy6qFpUzKfz04fSk9Sm40t485RSig62xT+mWUDq7RnmDP5NX8HpatDIXA6yA0U2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LW2fU8FS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LW2fU8FS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5762C4CEC6;
	Sat, 12 Oct 2024 13:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728740557;
	bh=efrgzvFmXp/p3PDPiPF/b3P1G1kO5oQ0XJgaCKadQSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LW2fU8FSXIrZv/nIFQLZge7OL5YcHRjtCDFotpxe7L0bp19zzZcmRpMCsGcelyxsC
	 aui9KqK5dMt5zsOLlcqmjcHLJOhuWfJUNb+6D/wDsjOrStH2cwpSwCcV8ZIIfs41DM
	 XhDHbsWM+NHiAw82audqIXuNyN4KchjqjMovhwCHC0XPRn14kATj6KJcav0I1cV2lq
	 vkDnQu8xkNVS8+XvEQ+uvWYzhbaSpCpUXZvQca5ihyIzhGoLtUVOcGs+yxVe5rnycd
	 fR/YcCUqMQ6MiMgp1qDv9ByHp4YAgRJClErHRNHrkSlg3P9/+SuWQxLkZRiAWyqHCT
	 5IfRTykp62xDg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 03/11] Revert "bpf: Export more bpf_burst related functions"
Date: Sat, 12 Oct 2024 21:42:08 +0800
Message-ID: <59e45a04c0bfd578bf10b4b1159a961a154fa33c.1728738220.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728738219.git.tanggeliang@kylinos.cn>
References: <cover.1728738219.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This reverts commit d0f5ca7a98fea075d60fb88f1c2b29a6f5f04d68.
---
 net/mptcp/bpf.c      | 10 ----------
 net/mptcp/protocol.c |  4 ++--
 net/mptcp/protocol.h |  3 ---
 3 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 3be587c7b21e..627839383b29 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -268,11 +268,6 @@ __bpf_kfunc void bpf_mptcp_sock_release(struct mptcp_sock *msk)
 	WARN_ON_ONCE(!sk || !refcount_dec_not_one(&sk->sk_refcnt));
 }
 
-__bpf_kfunc bool bpf_mptcp_subflow_queues_empty(struct sock *sk)
-{
-	return tcp_rtx_queue_empty(sk);
-}
-
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_mptcp_common_kfunc_ids)
@@ -294,11 +289,6 @@ static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
 
 BTF_KFUNCS_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx_by_pos)
-BTF_ID_FLAGS(func, mptcp_set_timeout)
-BTF_ID_FLAGS(func, mptcp_wnd_end)
-BTF_ID_FLAGS(func, tcp_stream_memory_free)
-BTF_ID_FLAGS(func, bpf_mptcp_subflow_queues_empty)
-BTF_ID_FLAGS(func, mptcp_pm_subflow_chk_stale)
 BTF_KFUNCS_END(bpf_mptcp_sched_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set = {
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e420ce9bbfb6..e978e05ec8d1 100644
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
index e774f28a6f8d..a93e661ef5c4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -720,9 +720,6 @@ void __mptcp_subflow_send_ack(struct sock *ssk);
 void mptcp_subflow_reset(struct sock *ssk);
 void mptcp_subflow_queue_clean(struct sock *sk, struct sock *ssk);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
-u64 mptcp_wnd_end(const struct mptcp_sock *msk);
-void mptcp_set_timeout(struct sock *sk);
-bool bpf_mptcp_subflow_queues_empty(struct sock *sk);
 struct sock *__mptcp_nmpc_sk(struct mptcp_sock *msk);
 bool __mptcp_close(struct sock *sk, long timeout);
 void mptcp_cancel_work(struct sock *sk);
-- 
2.43.0

