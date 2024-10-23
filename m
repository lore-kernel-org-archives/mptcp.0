Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FC518953D
	for <mptcp@lists.linux.dev>; Wed, 23 Oct 2024 09:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729676451; cv=none; b=kymID1Wz5TUieg8CFWeAdLTaKKUXWYtIL9N8In1uBs91NnSMperCnVxvg2Iwz+zZEFOxZN0A+VB1iNAtOvDBpVUwj2dZuyKmUVKDbuT5fT2sfwiqceGiiC03h7W+7ZVzJk/BFx+pj/s75DvVj/7nIZTz6Ro2oQ04DWYJOfQTV5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729676451; c=relaxed/simple;
	bh=nwOv9/U6zYgGffloFt06J2kTn5sP+ujGZmTojwCBnmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dZHejW6Ij0ZDQl8h5PguQRTc53NcVrqE6gjKEtTKwJW307DUlgcODg/MmRQkhmqabO/zPwq2zdKcM3NJQ43gv2jNKC8VGQpAFROC1iJ8myOgclsIIYbYT5dvjQ8c6GU8Ym7BY2c1KYk+1bGJrUuuiPFN6vMqc9Z4dWUu84SYRRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aykAraqP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aykAraqP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535F3C4CEC6;
	Wed, 23 Oct 2024 09:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729676451;
	bh=nwOv9/U6zYgGffloFt06J2kTn5sP+ujGZmTojwCBnmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aykAraqPfZIPgnRn0sDoCPlXrY0nrT7zxjSGqapOwIK8388HuH2+B+O/epuMbuFhL
	 fxebVWHJl475IOXnwf0aGVivFiiwsejp1Ig3fKTp0tY1WHs9+FFB1711XV2447Q/di
	 1kRto8dhhVtrcsRlyj8VVDEVCqlrtWQPbp4qtES777G7fTkF2aKl2OpdXl5zE7ozXB
	 F/26Hhtf+1kAWN1tUzy+2ZwxZWpFm4jTN/mpV7n1jxC8va8CsVONYDrQ8tH4Mp99Z2
	 XxrrRUw9Ugu05MJHLp3cTs6+vl7ipPwqBvO4DFgFSbEVAdE9fhD/ueDmIj4Lj8ESWD
	 fW3Q7W4KxKYQA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 12/13] Revert "mptcp: add sched_data helpers"
Date: Wed, 23 Oct 2024 17:40:22 +0800
Message-ID: <df2e20690d138694ec76828d87db492e21bc450f.1729676320.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1729676320.git.tanggeliang@kylinos.cn>
References: <cover.1729676320.git.tanggeliang@kylinos.cn>
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
index 4aee81814c82..13bdcbe34e1f 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -284,14 +284,6 @@ __bpf_kfunc static void bpf_mptcp_sock_release(struct mptcp_sock *msk)
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
index 46bc7adb4763..1656686b98a3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -722,8 +722,6 @@ void mptcp_subflow_queue_clean(struct sock *sk, struct sock *ssk);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
 u64 mptcp_wnd_end(const struct mptcp_sock *msk);
 void mptcp_set_timeout(struct sock *sk);
-struct mptcp_subflow_context *
-bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos);
 struct sock *__mptcp_nmpc_sk(struct mptcp_sock *msk);
 bool __mptcp_close(struct sock *sk, long timeout);
 void mptcp_cancel_work(struct sock *sk);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index d7be9c453488..d8ab234f4410 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -148,26 +148,6 @@ void mptcp_release_sched(struct mptcp_sock *msk)
 	bpf_module_put(sched, sched->owner);
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
@@ -194,7 +174,6 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 	data.reinject = false;
 	if (msk->sched == &mptcp_sched_default || !msk->sched)
 		return mptcp_sched_default_get_subflow(msk, &data);
-	mptcp_sched_data_set_contexts(msk, &data);
 	return msk->sched->get_subflow(msk, &data);
 }
 
@@ -217,6 +196,5 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 	data.reinject = true;
 	if (msk->sched == &mptcp_sched_default || !msk->sched)
 		return mptcp_sched_default_get_subflow(msk, &data);
-	mptcp_sched_data_set_contexts(msk, &data);
 	return msk->sched->get_subflow(msk, &data);
 }
-- 
2.45.2

