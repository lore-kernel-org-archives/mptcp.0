Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830FD2163B8
	for <mptcp@lists.linux.dev>; Mon,  9 Dec 2024 09:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737785; cv=none; b=qjlb+A+Gq4xADg6gHRTzo1/CTnw5EXcaoT7x3mc8tpZ3j7YV1qnxz8S1OyV5Tjat/1X+SJmxSibvZFBDtR3L0GV2dsBDjzi5ND90yUp5hwTcfHBHuwzT6w5H4BpASR5cV2umHf1purBjUUEohsJnYVUnGtll1NN6fEdTVIlIxRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737785; c=relaxed/simple;
	bh=wyrmivQNQCfbSFI4XHlRb9hYdqZQG4n+lfAtLYCea/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C+6ODs2K7ENjWFwra3kAxlrHOujC5nSPjMoXHZFKEls+Knv8VB4wVrAohvMS0JMZ5znJSz1Fq4m1Vzks+Odm4vDnwG49pVn5R0jIMs7hYVOkuSCQUeg7HBq89aZO3BktbIlGWWXA6t8O0WN3rXCU0wp3WM8ID0++gwAkAcy5J8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sOg1dx+z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sOg1dx+z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E991C4CEE1;
	Mon,  9 Dec 2024 09:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733737785;
	bh=wyrmivQNQCfbSFI4XHlRb9hYdqZQG4n+lfAtLYCea/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sOg1dx+zpT6GbdqxfKZeQONH0K2b+nIct31AzQ9SmpZT+V4Mx2FSKYT4R15EX7ryc
	 VM9vec+WyITOHpZoxOdwVguYxUxZ3lfko6D+dUIIXiZ0kDOByjJFLAuPyETjR8EXT2
	 IxooIcNokBml9G7kCQDjY1Gv9Rx8sCnoimrqf2ptarzAeV/CC05t2nLH36CyyRUwqy
	 KLEVgZx1Ovdn1VKFq1Dk1IbPGOW+DwgRsglogCNRK/ehDN08txg5nBdvdy/P27H8h2
	 UML+0yk1iS7wmLKdwgd2F+KwgYWEthJxKyfaivEtG7jqq/zFhLCkviv99kdjXDSsdY
	 dmwP6EGA5g7ZA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 7/9] Revert "mptcp: add sched_data helpers"
Date: Mon,  9 Dec 2024 17:49:23 +0800
Message-ID: <6de10177907a606dfccb8dd6dd7be0d246b8299a.1733737459.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733737459.git.tanggeliang@kylinos.cn>
References: <cover.1733737459.git.tanggeliang@kylinos.cn>
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
index 10d3db6323dc..8a9c7a91dd7a 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -305,14 +305,6 @@ __bpf_kfunc static void bpf_mptcp_sock_release(struct mptcp_sock *msk)
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
index 78a7cfb84c69..1e6b6b85b850 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -727,8 +727,6 @@ void mptcp_subflow_queue_clean(struct sock *sk, struct sock *ssk);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
 u64 mptcp_wnd_end(const struct mptcp_sock *msk);
 void mptcp_set_timeout(struct sock *sk);
-struct mptcp_subflow_context *
-bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos);
 struct sock *__mptcp_nmpc_sk(struct mptcp_sock *msk);
 bool __mptcp_close(struct sock *sk, long timeout);
 void mptcp_cancel_work(struct sock *sk);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 6da60e35932f..df7dbcfa3b71 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -141,26 +141,6 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
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
@@ -187,7 +167,6 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 	data.reinject = false;
 	if (msk->sched == &mptcp_sched_default || !msk->sched)
 		return mptcp_sched_default_get_subflow(msk, &data);
-	mptcp_sched_data_set_contexts(msk, &data);
 	return msk->sched->get_subflow(msk, &data);
 }
 
@@ -210,6 +189,5 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 	data.reinject = true;
 	if (msk->sched == &mptcp_sched_default || !msk->sched)
 		return mptcp_sched_default_get_subflow(msk, &data);
-	mptcp_sched_data_set_contexts(msk, &data);
 	return msk->sched->get_subflow(msk, &data);
 }
-- 
2.45.2

