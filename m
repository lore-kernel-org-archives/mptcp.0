Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63231C07E7
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 09:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729071239; cv=none; b=jqao9yMmhGuYhnot89AGWC1y25Fg7GgeyL7SF9JLyI0V6a5xq5jOFUsjYIdIi2wsOQUUEI9mPpRfInBQkJwIkRYBjJAA5S0RBMVmeAyTw1BH2HaaAstS0LB1IU46ds+5f8jcMRZcJ3XwaWVsIzs2zezlmGzn+W2dp22TlGGl9Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729071239; c=relaxed/simple;
	bh=1UQflbaRWbUGF0gq1UCMSZllwZAKny3U8udYKTwqYf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mg87/L7v5VjJZ/x59WQ3fsPeglj4Kew5CGdFTFASGEIRXLcq9CCIxpvaaAx1m5u9eknIB8mwHetdw288RYA8c8mEUduvM76wAEo1elNAdmZBXgSrm0wpCjKTg43ZR1dC+YTDy52VtgRp2WljpZnpwfiNG6NTFD5kdTxfNMCAehk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKkJr/TY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKkJr/TY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A6EC4CEC5;
	Wed, 16 Oct 2024 09:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729071239;
	bh=1UQflbaRWbUGF0gq1UCMSZllwZAKny3U8udYKTwqYf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AKkJr/TYSUSJC4yWE7yG8yOB+9GEOL6s6yM2VgKHPaXBeW7X/nuYE7pj22RCzJZRA
	 6r3BXQkZFm3ANwyTlzl+wi7v+J7fnaN7tGXlv5SzhCP79pWyw2+Zjy5ACM7kmOc+q1
	 GFlnjGTpUk2o1CnDdG7Fq4Bf/r2hXlHR6ctzp0EgMJO6Hb8vVhMQyxnqf9A+XDBqE+
	 BD9+os0iImHMbOpc9nGl22QGVD/mWZrekRG/geH1okDZY0Hce5AtX5ijuDJZmd/p4U
	 X2rh+U7MxAWlvHTK7L6pJ9gLZUKvX4mvQ0ghSnDm8n1Bk/6jjWfgHPhv9UTFx3LA6y
	 BRK9pEpR1s5Tg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 01/10] Revert "mptcp: add sched_data helpers"
Date: Wed, 16 Oct 2024 17:33:37 +0800
Message-ID: <c57461b141432f6a42c1ecbd6437a1f68869cd17.1729070999.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729070999.git.tanggeliang@kylinos.cn>
References: <cover.1729070999.git.tanggeliang@kylinos.cn>
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
index 0a14cc45d240..bca8b5332737 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -271,14 +271,6 @@ __bpf_kfunc static void bpf_mptcp_sock_release(struct mptcp_sock *msk)
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
index 8079dc7a6507..c81fe379b0f8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -736,8 +736,6 @@ void mptcp_subflow_queue_clean(struct sock *sk, struct sock *ssk);
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

