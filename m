Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3B922EE4
	for <mptcp@lists.linux.dev>; Mon, 10 Mar 2025 03:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741577420; cv=none; b=E2djapohy8+8bRGvK67RbaLL27k+eXh1FD8IvqDrK4X9BaytRPs0mBva18e+B77TCbC9s//2XLSUSRMJEtqHgUyvoPHC5f1dNDz4err9USwrgsCCxMI2W2qepuzE8aM11GBfpWbKHiuONfsr61Arokxws35/YbD0bX7OJ9M52ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741577420; c=relaxed/simple;
	bh=ZPyqeWtAAyzggjqfBXFFiPHEAFD3EZHgalVFPFNrj/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YFHa8I8MPUS23bC4csp7wjroeIqDEEp57Th4Ar+dZBxFD0k4/zatcKX+ecc5Q6vdhH3qZMTI9CazU47SGrrP8U3iE29C4IkJqRbQw8lVpXV9yrh7fooHbQjaAC+GLmf9KiFYUTj136wJyDOLdf4RwM7h1rRZTYh5n/h4CH+ZEnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmYrumJi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmYrumJi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E396C4CEED;
	Mon, 10 Mar 2025 03:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741577420;
	bh=ZPyqeWtAAyzggjqfBXFFiPHEAFD3EZHgalVFPFNrj/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MmYrumJiIoGxdhYzRde0dNMr7UqVDPRsceFl7SpYfOGJaj7g28sEgDsKbDhKZMSnb
	 rVdIDPdJhVDc5t82fXT4+ULyl882m2WcsgReKq784yoXdDSwOikixWaDE/l2aR1T5X
	 NrwykLSofeJmrUnv5mvroe24tDwVSwW6qbdeVHvq76OcAe0WlOY32RItxeKAE+v3Yf
	 uw+F1AFzEuwzyOcv/5qu2VVKn0Q/hbczlEJzjmHjHrwZ4R+tEbdjgA7bPhBvyiIKil
	 BFuNH+JqVGGsJ5lH4PxSzacNBOpJgeFKv4Vjef7+lgYNM94skue5e1waazlab0nzUk
	 1BL4MO0lgLQEA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Mat Martineau <martineau@kernel.org>
Subject: [PATCH mptcp-next v3 1/2] mptcp: add bpf_iter_task for mptcp_sock
Date: Mon, 10 Mar 2025 11:30:09 +0800
Message-ID: <e04cc2fa5f500097ac7d95afb94f68d0d8dc0057.1741577149.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741577149.git.tanggeliang@kylinos.cn>
References: <cover.1741577149.git.tanggeliang@kylinos.cn>
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
 net/mptcp/bpf.c      |  2 ++
 net/mptcp/protocol.c |  1 +
 net/mptcp/protocol.h | 20 ++++++++++++++++++++
 net/mptcp/sched.c    | 15 +++++++++++----
 4 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index c0da9ac077e4..0a78604742c7 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -261,6 +261,8 @@ bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subflow *it,
 		return -EINVAL;
 
 	msk = mptcp_sk(sk);
+	if (!mptcp_check_bpf_iter_task(msk))
+		return -EINVAL;
 
 	msk_owned_by_me(msk);
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 01157ad2e2dc..d98e48ce8cd8 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2729,6 +2729,7 @@ static void __mptcp_init_sock(struct sock *sk)
 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
 	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
 	WRITE_ONCE(msk->allow_infinite_fallback, true);
+	mptcp_clear_bpf_iter_task(msk);
 	msk->recovery = false;
 	msk->subflow_id = 1;
 	msk->last_data_sent = tcp_jiffies32;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3492b256ecba..1c6958d64291 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -334,6 +334,7 @@ struct mptcp_sock {
 				 */
 	struct mptcp_pm_data	pm;
 	struct mptcp_sched_ops	*sched;
+	struct task_struct *bpf_iter_task;
 	struct {
 		u32	space;	/* bytes copied in last measurement window */
 		u32	copied; /* bytes copied in this measurement window */
@@ -1291,4 +1292,23 @@ mptcp_token_join_cookie_init_state(struct mptcp_subflow_request_sock *subflow_re
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
+static inline bool mptcp_check_bpf_iter_task(struct mptcp_sock *msk)
+{
+	struct task_struct *task = READ_ONCE(msk->bpf_iter_task);
+
+	if (task && task == current)
+		return true;
+	return false;
+}
+
 #endif /* __MPTCP_PROTOCOL_H */
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index f09f7eb1d63f..161398f8960c 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -155,6 +155,7 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 int mptcp_sched_get_send(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
+	int ret;
 
 	msk_owned_by_me(msk);
 
@@ -176,12 +177,16 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 
 	if (msk->sched == &mptcp_sched_default || !msk->sched)
 		return mptcp_sched_default_get_send(msk);
-	return msk->sched->get_send(msk);
+	mptcp_set_bpf_iter_task(msk);
+	ret = msk->sched->get_send(msk);
+	mptcp_clear_bpf_iter_task(msk);
+	return ret;
 }
 
 int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
+	int ret;
 
 	msk_owned_by_me(msk);
 
@@ -196,7 +201,9 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 
 	if (msk->sched == &mptcp_sched_default || !msk->sched)
 		return mptcp_sched_default_get_retrans(msk);
-	if (msk->sched->get_retrans)
-		return msk->sched->get_retrans(msk);
-	return msk->sched->get_send(msk);
+	mptcp_set_bpf_iter_task(msk);
+	ret = msk->sched->get_retrans ? msk->sched->get_retrans(msk) :
+					msk->sched->get_send(msk);
+	mptcp_clear_bpf_iter_task(msk);
+	return ret;
 }
-- 
2.43.0

