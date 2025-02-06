Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDF122577D
	for <mptcp@lists.linux.dev>; Thu,  6 Feb 2025 09:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738832710; cv=none; b=YaXXsfwlwIp4ctRi3tzAxtHI7LIby2kzfkJaP9AoTKHLIh3qOOqubGgHfh4in36741VTGm4wLqqPdI6HFvVjPdrqS556wa21kSjxAe4ZI/5aLDdwWH7Z928xOOxfBmETyWrfukZkIPhCYWAK6UkcvDINLNHys2tEfUwJcwS6Q+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738832710; c=relaxed/simple;
	bh=R5Umg4M3oug08UUDC8vXh8uvtSOxGxFqijHEh2c7tX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cNKcZHmZ+K6aArymOQBWaUgu/3IMkFb59cla4NGksjMK5MZVDBINfhLmoqwzWqMXGEgNbm6tsvA+Y3eV5BWT7vpSKQtqQDbdbGNsSTKqVp/k07ZOqTXiy9Z9QK+ZukLsyLN7SSX5tK7PbdEmObjndGetx9tqXmtmAzlL7HorXDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FyhU6Val; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FyhU6Val"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0562FC4CEE4;
	Thu,  6 Feb 2025 09:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738832710;
	bh=R5Umg4M3oug08UUDC8vXh8uvtSOxGxFqijHEh2c7tX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FyhU6ValymF+pjmiy6MOI4ENP9t2w6YWykAxuiF+gYv0qVgXO5F80/s9Dm63wV98A
	 e9yeOG4nJhUiTiPORFBsP/DsWUuNecbr7wraWCpzjvVt1CAIxoQOxGpzBCQAkDrUmT
	 UjAmjz/7eD8kpN2uYAr0LbtkKpUvJ7xGwK6lCMaZY3WdoIdKr5EwTmi+xleb5IdDr3
	 YJAD7WKqSjmKb+zdObJx6MmOjMwFDgPYEMinixKpBuoXhWlKp+8Go2lf3M4vwwJ4hb
	 uAJMbM5w+wXqo2oa98Q3CQa0YskotLxNS6XfDXbBGHQT9KySTSEsD+uufMr1Ct0KU8
	 5wIi8s1PdNtqg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v13 2/9] Revert "mptcp: add sched_data helpers"
Date: Thu,  6 Feb 2025 17:04:52 +0800
Message-ID: <faa21385be99fa196f8e3736ae61c5b4130bb824.1738832147.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1738832147.git.tanggeliang@kylinos.cn>
References: <cover.1738832147.git.tanggeliang@kylinos.cn>
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
index c09d5526d976..76fe99ffe10a 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -276,14 +276,6 @@ bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_subflow *it)
 {
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
index bac5c925a72f..a1d6d996aa93 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -718,8 +718,6 @@ void mptcp_subflow_queue_clean(struct sock *sk, struct sock *ssk);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
 u64 mptcp_wnd_end(const struct mptcp_sock *msk);
 void mptcp_set_timeout(struct sock *sk);
-struct mptcp_subflow_context *
-bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos);
 struct sock *__mptcp_nmpc_sk(struct mptcp_sock *msk);
 bool __mptcp_close(struct sock *sk, long timeout);
 void mptcp_cancel_work(struct sock *sk);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 37d86aadaeaa..c2a95d6590e7 100644
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
 
@@ -222,7 +201,6 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 	if (msk->sched == &mptcp_sched_default || !msk->sched)
 		return mptcp_sched_default_get_retrans(msk, &data);
 
-	mptcp_sched_data_set_contexts(msk, &data);
 	if (msk->sched->get_retrans)
 		return msk->sched->get_retrans(msk, &data);
 	return msk->sched->get_send(msk, &data);
-- 
2.43.0

