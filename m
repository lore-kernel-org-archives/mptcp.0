Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B13C433CE
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 07:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729064018; cv=none; b=dHA25r8yRZqueoxWrwgJkc8ibJvBtn4R2HzD11QTWIu1psX/fA/u4J+bhZHhonIXGROlhz9loMjgDQWmCVeAKUZn0BJH955hkbre1NdaDh3Fh+Ujx85GHcrsIanWC4P58FuYY3rA9FMKKGgIE7cOp/SZoBPOSdCgHQ/vvRGlXKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729064018; c=relaxed/simple;
	bh=MjN0T44+dZJ53UIGm4AzzT/hLa5oX37WYHBmpMD8qEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OokA0uIHOF01HjMAwaJgAV4WfyyO+tBFlLgGybvAXCeW+bgeMKGVgEt2r/np+HBeJFwNyp9E1Jp8wzrzqY8CBYQ4qlqxHTZGKV8yhS0Y1OEMARnwELlGSZ+c0miTprC5ax7HAkHPpZjxQTZbaqO8MToOeoXfECMMxJnD0dzL5mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7OVmpEu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7OVmpEu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1802BC4CECF;
	Wed, 16 Oct 2024 07:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729064018;
	bh=MjN0T44+dZJ53UIGm4AzzT/hLa5oX37WYHBmpMD8qEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k7OVmpEujrnUDXuKt36s0g1HXxfA7p0gvDmxwxvqsRGQ43HF0QKF4tEY/DjgSRzp/
	 aJO+cGWYnRWEjevvh8Zu7U4vKnUkIkQ9Yt3YUpVAuGoN6WdA6LsruQ2Bo8i51trEMs
	 FUCjnr+kNNE/M7xFZLZw35c470cZWufxzbgKzU3ooGMjLxSmOpNtx6temkvAqJfVhl
	 OQLtuJz4TNdTAc0uKtNzM+X5muwTJwnHdoH8dV2tUgSzvI6P7aASnmAIPJK1SfFfTH
	 wD0RewNl9YrfGhu33oBrzQkcJtaP2H0BEV6VByzTAh9B91HQ0BqSZoWDjuYLi4TGOA
	 cVPjLNDXSYT7Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 8/9] Revert "bpf: Export more bpf_burst related functions"
Date: Wed, 16 Oct 2024 15:33:15 +0800
Message-ID: <4da1aa50077637236c6528bb90d8ff2ef1d563e1.1729063444.git.tanggeliang@kylinos.cn>
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

This reverts commit 371136b55b559e2ef4d117a901b9f96ee036a175.
---
 net/mptcp/bpf.c      | 11 -----------
 net/mptcp/protocol.c |  4 ++--
 net/mptcp/protocol.h |  3 ---
 3 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 19dbf28018f5..1ff26069b9fd 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -279,11 +279,6 @@ bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int p
 	return data->contexts[pos];
 }
 
-__bpf_kfunc bool bpf_mptcp_subflow_queues_empty(struct sock *sk)
-{
-	return tcp_rtx_queue_empty(sk);
-}
-
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_mptcp_common_kfunc_ids)
@@ -304,12 +299,6 @@ static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
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

