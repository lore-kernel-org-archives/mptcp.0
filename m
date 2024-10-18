Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129514207A
	for <mptcp@lists.linux.dev>; Fri, 18 Oct 2024 16:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729267247; cv=none; b=AfxrBiG2F8odOKeh7f/HOFajR64cvpQWjnpp2z5+giAEIynRJXN80MGaJuLe5T+qU6oEQu/iAp51sz2HiK6EHP8Y35pFcN5ee/H3axUpq/otmK5CAubWG/8wWVwU9mHfDtSN/e5FJXMB1uXFcPBVYHtmpCENNNGwZQs/3xYdYX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729267247; c=relaxed/simple;
	bh=Kbg/woWQyt8SzsP3SFPPdsPppNrlRZawsUM/d+hlE0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJwn6jC6E5rKc0vTJgNNpJ2jtq1iuL+c7y/mHPFCjg+pJxOPndRkZguOwpRUIHY8oW967vV4ilEpk9Pvy2O3QB8gF4mnwNoNrOm71juMPaSZXsRjJpHBtJ/+PRZu6JGkSVUErWBu+t1V+aZdC1fMAiU2QizYRuK8lY5RqqAv4Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eg3TedHb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eg3TedHb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB6EC4CEC3;
	Fri, 18 Oct 2024 16:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729267246;
	bh=Kbg/woWQyt8SzsP3SFPPdsPppNrlRZawsUM/d+hlE0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eg3TedHb6IRLqJOjjoolmvhv06DK5YTObYMQwNsoatAg61Fms/umMDVURAOYlJZnJ
	 CSUYy6sGIWuGxiqOz4g/bxQPb2isZjB37uNAXPtk/+MokI2bDOvREB++bJhf75ttXM
	 DjMhwugBlLqNF+nroJ6kbQQtwDFpCgpX2ti9mjUcQbmzT5pAkw04rf93rSdAdwZdQv
	 jqoyEW0E25iM+Pjczbuoa+d5kUpMNLqeIeeFHVKbdC2sp7bcKEpI7gmr7mAz0+N4GG
	 t8QmSSJ46x8TgVZiZ08wJ5SxLH/2eY6YbG75niSGqgHj++1nBLRnT3d4soJomxYioD
	 2NrAwpmdpWbEA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v12 7/8] Revert "bpf: Export more bpf_burst related functions"
Date: Sat, 19 Oct 2024 00:00:27 +0800
Message-ID: <ff7743a0ee2fbecfe30b9ff5719be44add530827.1729267039.git.tanggeliang@kylinos.cn>
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

