Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9994D20FAA5
	for <mptcp@lists.linux.dev>; Fri,  4 Oct 2024 13:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728046808; cv=none; b=Ss7r66HW8aac7HSZmMcBve9l/kAHesUAI7QQw3YTi4p5JeHdhTwcIjm1BOMlL2VtbzAqb5Im3/bsvfd6adliQhHoB42re2wj2A7FALo3Dp03qrgR8ZJdkUQMBsZwgLDWjE9r/t/SMk14wBMmqeG2uREj+/Cd3svbDN/0d+212w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728046808; c=relaxed/simple;
	bh=r01hSFySfF4YeqSWniiKuZPkj6/4PQQ8wZvIJB7E9WI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bcOdi98VjzJTkJt1RtZyfCpC2UqtOw4a0zDSXRKZ3EZByKNuuv4lAK8fSd23XRwIf7Ea01ASeCNQzgVbI9JF6VGT7bjtg+Pw/4Dc3ck8RGExdJfcXHf6Q8J/TV6MHnIaBxs5XPJlbat/7WgpGiRFW7AxN1Rb2hxxhdbUyq32EHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVnFhbuu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVnFhbuu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 781EBC4CEC6;
	Fri,  4 Oct 2024 13:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728046808;
	bh=r01hSFySfF4YeqSWniiKuZPkj6/4PQQ8wZvIJB7E9WI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WVnFhbuuuAHt3flS1OhhFUN2g2Q75pxkJvskNcj6DIxsABK40fsS5Z3MyLXhsW1Dr
	 dUmbl/2kW0IHkmOxhHt3wQSZ3i79WP1xmxvF1Kh/cmlqbOrxdBatKpshlVh0cDV7HM
	 qHMziwq+dywem4UvagfzmYSiOZfmC0JjDdbhHjeHuYuZChHuV6cwKOJ9mOXXhcH7mK
	 LAxRQdPB1LNHcQxfn7ePXaudk3uJx187uqyJMNgwKvfP49LKhcqLpF2YxfyqR4OOtS
	 0gwtSLSP3D60trH31416tkpNGauhp22IY2q+g3UI4FodnMCXzpXe8Slu4TWd3p0rby
	 0ujGrDuslcXoQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 8/9] Revert "mptcp: add sched_data helpers"
Date: Fri,  4 Oct 2024 20:59:48 +0800
Message-ID: <3eaae3c3c85914174f1185217b816a49332004ed.1728046491.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728046491.git.tanggeliang@kylinos.cn>
References: <cover.1728046491.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c      |  9 ---------
 net/mptcp/protocol.h |  2 --
 net/mptcp/sched.c    | 22 ----------------------
 3 files changed, 33 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 02f5fadd0f89..2980129a4bc6 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -276,14 +276,6 @@ __bpf_kfunc void bpf_mptcp_sock_release(struct mptcp_sock *msk)
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
@@ -310,7 +302,6 @@ static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
 };
 
 BTF_KFUNCS_START(bpf_mptcp_struct_ops_kfunc_ids)
-BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx_by_pos)
 BTF_ID_FLAGS(func, mptcp_set_timeout)
 BTF_ID_FLAGS(func, mptcp_wnd_end)
 BTF_ID_FLAGS(func, tcp_stream_memory_free)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a47aa7938afa..6c39c54a3889 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -725,8 +725,6 @@ void mptcp_subflow_queue_clean(struct sock *sk, struct sock *ssk);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
 u64 mptcp_wnd_end(const struct mptcp_sock *msk);
 void mptcp_set_timeout(struct sock *sk);
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

