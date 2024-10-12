Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1821E511
	for <mptcp@lists.linux.dev>; Sat, 12 Oct 2024 13:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728740555; cv=none; b=esuXQfyMHLS/Pg0GA10n7R8+zJWhDWVBZJQHuEN1inE+SmpNCuTmhm4qNHsNnp4TFZy8/zmLac6enxRNrk+dYZV+/Bt4MnhNuNH2OpiP3dMe4DnuOSgkDOPfzpLsEpeVtPHBXJIdjz7EFiFCyiU4hraYmGMfvu+ZZKtCF/R//EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728740555; c=relaxed/simple;
	bh=Gz6HbhDzNQZ8VvZImuhA0bSkF4NjHsir9HNmr/KM86k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i7BRZ/yJnAxTE9sX0wbGvj55SYfok/nD+8Kq4zvbwrLiYkmoaoVBoHmBPNLATQ8pxK9sk6TC1xbZNcA0a/Fl9nOubUU3sYqQ8Q7h7fdIGcvkXzC+Jcj3WUYTIS5/zyMqSEe/ENzeSs2f6fQtOZbYbkGBTvxGyoSBdpZFOiNBbP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jU7m2COb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jU7m2COb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0439BC4CECE;
	Sat, 12 Oct 2024 13:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728740554;
	bh=Gz6HbhDzNQZ8VvZImuhA0bSkF4NjHsir9HNmr/KM86k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jU7m2CObMddHak64qchaBGvufVO9N0Bbm8dMOgBRvf7t0jP+NMnJKVnF5vRk4ZPUq
	 dCJaeHIy9wsLxDkDa4JCIcOm0gMCKx+4Y/ePA1v3QP5WWsqVA4RypWkTVpDFm3olW2
	 Am+2VHI/DpXNxH8lpwS9SBiTRU2TrgxSuOAMQhEGne2UnBz+oFRy0t+la106g1jn35
	 oHIEebrUqBMTQzcbizVD1bsfWEN4KnktFC1mk+lb7YqgYBRGtkq2eItlEqEF9d1TqR
	 AJgZ4CmL8tOLWJAblgI/Z5tG/ye2pcs5eqUn0/6cvR+MgpftpYGDKP4ko36zJW8sSG
	 Cr5ictDQfHJvg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 01/11] Revert "mptcp: add sched_data helpers"
Date: Sat, 12 Oct 2024 21:42:06 +0800
Message-ID: <29e13e7fb70f446ec82e9a53341719d11475fa01.1728738219.git.tanggeliang@kylinos.cn>
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

Drop this patch.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c      |  8 --------
 net/mptcp/protocol.h |  2 --
 net/mptcp/sched.c    | 22 ----------------------
 3 files changed, 32 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 9b87eee13955..681a76f7c6a8 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -271,14 +271,6 @@ __bpf_kfunc void bpf_mptcp_sock_release(struct mptcp_sock *msk)
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
 __bpf_kfunc bool bpf_mptcp_subflow_queues_empty(struct sock *sk)
 {
 	return tcp_rtx_queue_empty(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b963e68451b1..e774f28a6f8d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -723,8 +723,6 @@ void mptcp_sock_graft(struct sock *sk, struct socket *parent);
 u64 mptcp_wnd_end(const struct mptcp_sock *msk);
 void mptcp_set_timeout(struct sock *sk);
 bool bpf_mptcp_subflow_queues_empty(struct sock *sk);
-struct mptcp_subflow_context *
-bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos);
 struct sock *__mptcp_nmpc_sk(struct mptcp_sock *msk);
 bool __mptcp_close(struct sock *sk, long timeout);
 void mptcp_cancel_work(struct sock *sk);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 5257bc6c8cd6..78ed508ebc1b 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -143,26 +143,6 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
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
@@ -189,7 +169,6 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 	data.reinject = false;
 	if (msk->sched == &mptcp_sched_default || !msk->sched)
 		return mptcp_sched_default_get_subflow(msk, &data);
-	mptcp_sched_data_set_contexts(msk, &data);
 	return msk->sched->get_subflow(msk, &data);
 }
 
@@ -212,6 +191,5 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 	data.reinject = true;
 	if (msk->sched == &mptcp_sched_default || !msk->sched)
 		return mptcp_sched_default_get_subflow(msk, &data);
-	mptcp_sched_data_set_contexts(msk, &data);
 	return msk->sched->get_subflow(msk, &data);
 }
-- 
2.43.0

