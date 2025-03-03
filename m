Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691D41F3BA2
	for <mptcp@lists.linux.dev>; Mon,  3 Mar 2025 10:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998026; cv=none; b=FNaa3vt1wUaekrFMom+0UA178ItdLXVo50l+oCVvySyIWpuPCiGgI5vZVmpD9wsfu2/VlzqGrS1BfggEAnJMR3PAxJ12STQng34tVsgJBak1CDIHAqU6IOgFK77OLYiwE2YRbMFLDQ4tChpJfOwazW5i72yUIfuORvL22tlqPRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998026; c=relaxed/simple;
	bh=3w0UiAWIzMtUk5kXRKMpKaYmdGWKWd8bQ1iWq34N8Uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VgpFwotj/WOpbd06skmXNxYj8wQJ2xVWUqtPA8/vN0wBnoe95Nto72grq6IgvY+5nMlsoy6OdxgQ6jRHGZbuBYHMhG5CjhIdXyesMIU+YYqfZRTFawsKPN8ErryXP0+l5fEVHkotNH9I/YxIQSqtx0xl4aXnXlevRCnCaojcnbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqEwzPKB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqEwzPKB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40F0C4CED6;
	Mon,  3 Mar 2025 10:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740998026;
	bh=3w0UiAWIzMtUk5kXRKMpKaYmdGWKWd8bQ1iWq34N8Uo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AqEwzPKBBjg04zCGxdb4IifT6OBiOXP8/zjwPIqFPXP8ok5o/e3YtUZJ/YpR8ZUvK
	 RZ71DlBNCG6EjrAuZVsb6KRhl1x2h6taPU6erfU6g3P6tOqPZGiyjA4LV4f2a9eJi0
	 0WVR4tkJ204Hz1p3s30derAI4CH6dwdnI/OqrhaqDnf5/5MMzyXKVSZwRhis+WgoVK
	 ydAClRyMvwqhMVFq/SEqOeUANChf47pM5h8PHe0Vn4+arRZROdR2gJ6ej1js0hukER
	 05tbrgGTI2h8Ck6ZyA0IRqvyhWOSodyLK72q+Ux2oKEJmaGEw/FvE2ueSegvHqdNTC
	 a+PHeJmvSQrwQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Mat Martineau <martineau@kernel.org>
Subject: [PATCH mptcp-next v5 1/5] mptcp: add bpf_iter_task for mptcp_sock
Date: Mon,  3 Mar 2025 18:33:33 +0800
Message-ID: <7ff2760dcee1532f624e2ccf4fd67e83ec09a01b.1740997925.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740997925.git.tanggeliang@kylinos.cn>
References: <cover.1740997925.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

To make sure the mptcp_subflow bpf_iter is running in the
MPTCP context. This patch adds a simplified version of tracking
for it:

1. Add a 'struct task_struct *bpf_iter_task' field to struct
mptcp_sock.

2. Do a WRITE_ONCE(msk->bpf_iter_task, current) before calling
a MPTCP BPF hook, and WRITE_ONCE(msk->bpf_iter_task, NULL) after
the hook returns.

3. In bpf_iter_mptcp_subflow_new(), check

	"READ_ONCE(msk->bpf_scheduler_task) == current"

to confirm the correct task, return -EINVAL if it doesn't match.

Also creates helpers for setting, clearing and checking that value.

Suggested-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c |  1 +
 net/mptcp/protocol.h | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2b48cf648346..fec776c23fcd 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2726,6 +2726,7 @@ static void __mptcp_init_sock(struct sock *sk)
 	msk->scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
 
 	WRITE_ONCE(msk->first, NULL);
+	WRITE_ONCE(msk->bpf_iter_task, NULL);
 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
 	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
 	WRITE_ONCE(msk->allow_infinite_fallback, true);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ef1d43406f9b..836891bc28d5 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -327,6 +327,7 @@ struct mptcp_sock {
 	struct list_head conn_list;
 	struct list_head rtx_queue;
 	struct mptcp_data_frag *first_pending;
+	struct task_struct *bpf_iter_task;
 	struct list_head join_list;
 	struct sock	*first; /* The mptcp ops can safely dereference, using suitable
 				 * ONCE annotation, the subflow outside the socket
@@ -1291,4 +1292,19 @@ mptcp_token_join_cookie_init_state(struct mptcp_subflow_request_sock *subflow_re
 static inline void mptcp_join_cookie_init(void) {}
 #endif
 
+static inline void mptcp_set_bpf_iter_task(struct mptcp_sock *msk)
+{
+	WRITE_ONCE(msk->bpf_iter_task, current);
+}
+
+static inline void mptcp_clear_bpf_iter_task(struct mptcp_sock *msk)
+{
+	WRITE_ONCE(msk->bpf_iter_task, NULL);
+}
+
+static inline struct task_struct *mptcp_get_bpf_iter_task(struct mptcp_sock *msk)
+{
+	return READ_ONCE(msk->bpf_iter_task);
+}
+
 #endif /* __MPTCP_PROTOCOL_H */
-- 
2.43.0

