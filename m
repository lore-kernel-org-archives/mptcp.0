Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E8C3D561
	for <mptcp@lists.linux.dev>; Mon, 23 Dec 2024 10:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734948367; cv=none; b=jTdheYZu99jxc/LEaOHV6xJs6mDkogM0CLd6rh0nl6b1QzqobtOYGnVzoxHwmSmcs9GJzI7pzBFkSwyLo5dWOCbJ3e77ZVfQAhh3eAOfS+PU4Pv6APM5C7MHW8gTgNwjtI2Nl9fBPuW39foc4C9L9BIthkK+jqun4W9Ba3bMq5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734948367; c=relaxed/simple;
	bh=lDgxUD+eZbZckV4TztOt+cR29DvGQP6ggkbOAgge/OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uE1/IDfoW3qL6kwMY7Lp4/QQ05m9moAgp2X5DHSKB45JSumX1GSqiiRxZzLtwKV9N9uWujR3ky92+cZpeugNWOzLit8Kq9MBwhq8ewk2LSBDc8yraeWSadCyH1OP+Kf/CCA9kZht/M8oo+pUGCC3hhsEtDzPkG6A/teNtI5KaHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGuiZmOO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGuiZmOO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4ED8C4CED3;
	Mon, 23 Dec 2024 10:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734948367;
	bh=lDgxUD+eZbZckV4TztOt+cR29DvGQP6ggkbOAgge/OQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cGuiZmOOhz/fp5og7LFfmwEd+xoUARxNRa0LANRuXPqWFq3zTCVAHMEdPAvHjhfxs
	 vECniGzC3PVB8ak/NONdaDHdWFRnLoiV2kTOAZ+bbrPR7CMFnFxhkxM23v77dTjC3f
	 BQ3m3tiXjKbPpmIrmkAaVi/y6yh2aSbugpCg3rlUgGYC8BttgdINy8be79R/xCL+OE
	 wqYawGIvcEZCMy3EURdu1DO3hoFrr1vSFvQbYq+59gnL//JBiKmg0/Fkr+GPXBD+ZT
	 yIEMrL9O5Y1TLG69JBo2deN4IAHdcKcr6z3MhQQOqfvi2eu9bFjnwcgKjeW0iKdymf
	 9s5N0tg1OU76Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v12 02/10] Revert "mptcp: add sched_data helpers"
Date: Mon, 23 Dec 2024 18:05:44 +0800
Message-ID: <6d36db735da0536c9b151896173d551be6c0b569.1734947922.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1734947922.git.tanggeliang@kylinos.cn>
References: <cover.1734947922.git.tanggeliang@kylinos.cn>
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
index 6fe3f7badba9..57c4606a26ab 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -319,14 +319,6 @@ __bpf_kfunc static void bpf_mptcp_sock_release(struct mptcp_sock *msk)
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
index 05059603b21e..68fc050154b9 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -720,8 +720,6 @@ void mptcp_subflow_queue_clean(struct sock *sk, struct sock *ssk);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
 u64 mptcp_wnd_end(const struct mptcp_sock *msk);
 void mptcp_set_timeout(struct sock *sk);
-struct mptcp_subflow_context *
-bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos);
 struct sock *__mptcp_nmpc_sk(struct mptcp_sock *msk);
 bool __mptcp_close(struct sock *sk, long timeout);
 void mptcp_cancel_work(struct sock *sk);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 0b1e472e59a0..5d6c0582c473 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -154,26 +154,6 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
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
@@ -199,7 +179,6 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 
 	if (msk->sched == &mptcp_sched_default || !msk->sched)
 		return mptcp_sched_default_get_send(msk, &data);
-	mptcp_sched_data_set_contexts(msk, &data);
 	return msk->sched->get_send(msk, &data);
 }
 
@@ -221,7 +200,6 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 
 	if (msk->sched == &mptcp_sched_default || !msk->sched)
 		return mptcp_sched_default_get_retrans(msk, &data);
-	mptcp_sched_data_set_contexts(msk, &data);
 	if (!msk->sched->get_retrans)
 		return msk->sched->get_send(msk, &data);
 	return msk->sched->get_retrans(msk, &data);
-- 
2.45.2

