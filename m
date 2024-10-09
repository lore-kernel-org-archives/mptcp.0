Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7328D18E351
	for <mptcp@lists.linux.dev>; Wed,  9 Oct 2024 10:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728469811; cv=none; b=FOufPnviAuMFHG692n8aHS2VKxVPsuDdunb3Ekfd/WGnXCdnyvqZ/4mBulwuWgiFxNaSnwDaQoRugnHMAGwdRaVxhDAlEtwTPtzSfNTJ7Vmv2ST57EYIRqIwZsVbsmSsePiXaxA/nYSgX4ByIBEUCvPmjgKeZzhZZ3DP7z10w+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728469811; c=relaxed/simple;
	bh=WWtgYKOKxBp7nrH4PEuI6PQK+sKRIGaUVr1hgcjLieA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mDs5vvEKj0iFrqFaUnEJATghzTn81fPI7SlQCt0b6vGTYAUYNIV9Pr8kSit3yOZg/rs4HehusmxC65fjk1icZLEvo2cjck0TQYav1YV0WRUDjH+IXdBLchK4eMPJtyQHCcIHyUNfOAp5OMLptwPYSFim0hukFl64TfdQ4MseLAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=am7/o+Pi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="am7/o+Pi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57388C4CECC;
	Wed,  9 Oct 2024 10:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728469811;
	bh=WWtgYKOKxBp7nrH4PEuI6PQK+sKRIGaUVr1hgcjLieA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=am7/o+PiwLwzhybgcq/YkKjXYstPPmnQ0ORcT++8Vc0einTPVZe88NtS4H/azGcj8
	 V+ZarLJiO/vSXD4JrLnSpkm17IO2edj+qbaPsnr6c938wFvnknXD17Z5SNwlsv1ngB
	 sjjNDHyU+r5mNIb9PcS+KY+mwP32r/psg4oEoSXc+EPl4LLPUx4GmCh/xW+YAtFQkk
	 wpovR3XPlZFPUFjpbP3YaZvx7HrmCEsg+7nv+sXyLrhP9JiEHwGvhGB2O03Nf9IFng
	 EyUPhejtDPDqi9TDn3a6pKGIHb+WSGRzSiTGvE0PIvA/bRws4wzZ6a3IJbr+CmkuLm
	 97u2Q/XYxlRAw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 08/10] Revert "mptcp: add sched_data helpers"
Date: Wed,  9 Oct 2024 18:29:49 +0800
Message-ID: <d6f9ef71c44048da7173f6bcf2f75c7df4e42b2d.1728469555.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728469555.git.tanggeliang@kylinos.cn>
References: <cover.1728469555.git.tanggeliang@kylinos.cn>
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
index c9aefe9eec14..03160ea280f6 100644
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
@@ -304,7 +296,6 @@ static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
 };
 
 BTF_KFUNCS_START(bpf_mptcp_struct_ops_kfunc_ids)
-BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx_by_pos)
 BTF_ID_FLAGS(func, mptcp_set_timeout)
 BTF_ID_FLAGS(func, mptcp_wnd_end)
 BTF_ID_FLAGS(func, tcp_stream_memory_free)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f1e90e7b2431..9df56c21756d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -721,8 +721,6 @@ void mptcp_subflow_queue_clean(struct sock *sk, struct sock *ssk);
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

