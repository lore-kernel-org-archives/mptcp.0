Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170C03FFFA5
	for <mptcp@lists.linux.dev>; Fri, 21 Aug 2026 07:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787295918; cv=none; b=gcgGgwawHGZkmk4x5gfYynLZyjF28DglISn3qFokQqAyCmJYcWIPeU/3t9oGNPO5jHsYhP2Dc8+lXjMxV2rntAt945MJIY8VPhBxdNEp/9k8AQQZVHAxeyIQmoUWBfc3EZ65xv69SMIOyGbYx1n1SoSgc1dpeNMoBEh0DyBN14U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787295918; c=relaxed/simple;
	bh=uZtPmNXuFAwFl4YRBC45VpFjPpnxucTKp752jhqQzGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=COv9J59ISLtTQCHPaQED0PHwUYu2XPOH3qmNZvm+q0ToHcarkrTJinEFM3sXlsGi9H8iSRBs5ddcb3/Qi6wkv35fDusODuuG+WnyEqkXUsfbtfuVSMvksKhLBhw5QSuh/bv83lLa1Qgsz/0+puoXXlznzWxWHzh776YeP1u4MNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cew8t3JD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cew8t3JD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 207781F00A3A;
	Fri, 21 Aug 2026 07:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787295916;
	bh=5dRZOUouUxq4mYVPWXC2931tqPPGuOSj2Sicpt9YSCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cew8t3JDHtAngaBRakTE33lId8FEr2NANrbOTFZlmhZ7NviD3c+VTVQSKqGuob7dY
	 YMZxWime7klB7zlIkN5CDaSTooJeh0T9uA/482TDCTzvoirvh18m+Y3OSjIBNwR1dj
	 jLTSHZkCCmr/7yyGH2CpwDVGPkTDxcpVU1bmOaXpib3Pby5xzFwOeKocD+NnL24c+t
	 85jfU5UO00c83giNNyo6YP0m/HIx4hV5lv8VLXBCrQBR9aU8w6GhhmsaVw+p2nkczT
	 FmAhaATD/SUbLrHLT9quWostRBmkUIDyblW+5PB9b6BQgHpck+vapqAwSLhXRsBr2U
	 w4VJoJVXmOQkQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v4 5/7] mptcp: defer read_sock cleanup to mptcp_worker
Date: Fri, 21 Aug 2026 15:04:26 +0800
Message-ID: <874b60464d67b886f0425b79f75bd2919cc3ec46.1787295147.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1787295147.git.tanggeliang@kylinos.cn>
References: <cover.1787295147.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

When MPTCP carries TLS, the data path runs under mptcp_data_lock().
Reaching sk->sk_data_ready(sk) synchronously ends up at
tls_strp_check_rcv() -> mptcp_recv_skb() -> mptcp_move_skbs(), which
calls mptcp_data_lock() on the same sk and recurses on sk_lock.slock.

The TLS path is not the only constraint: before the mptcp_recv_skb()
calls, the TLS code would also reach __mptcp_read_sock(), which calls
mptcp_rcv_space_adjust() and mptcp_cleanup_rbuf(). Both require holding
the msk socket lock in process context, while the mptcp/TLS caller is
in BH scope.

Fix this by deferring sk->sk_data_ready(sk) to mptcp_worker() via a new
MPTCP_WORK_READ_COMPLETE bit, reusing the existing mptcp_schedule_work()/
mptcp_cancel_work() infrastructure. The wakeup bit is consumed after the
SOCK_DEAD && TCP_CLOSE destroy branch, so a socket that reaches the destroy
path drops the pending wakeup rather than running it post-free.

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 25 +++++++++++++++++++------
 net/mptcp/protocol.h |  2 ++
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a5caeb552869..d38c5eec5471 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3130,6 +3130,15 @@ static void mptcp_backlog_purge(struct sock *sk)
 	sk_mem_reclaim(sk);
 }
 
+static void mptcp_read_complete(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
+	mptcp_cleanup_rbuf(msk, msk->read_copied);
+	mptcp_rcv_space_adjust(msk, msk->read_copied);
+	msk->read_copied = 0;
+}
+
 static void mptcp_do_fastclose(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
@@ -3206,6 +3215,9 @@ static void mptcp_worker(struct work_struct *work)
 	if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
 		__mptcp_retrans(sk);
 
+	if (test_and_clear_bit(MPTCP_WORK_READ_COMPLETE, &msk->flags))
+		mptcp_read_complete(sk);
+
 	fail_tout = msk->first ? READ_ONCE(mptcp_subflow_ctx(msk->first)->fail_tout) : 0;
 	if (fail_tout && time_after(jiffies, fail_tout))
 		mptcp_mp_fail_no_response(msk);
@@ -4580,9 +4592,6 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 	struct sk_buff *skb;
 	u32 offset;
 
-	if (!list_empty(&msk->backlog_list))
-		mptcp_move_skbs(sk);
-
 	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
 		offset = (u32)msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
 		if (offset < skb->len) {
@@ -4597,6 +4606,7 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 /*
  * Note:
  *	- It is assumed that the socket was locked by the caller.
+ *	- Can be invoked in BH scope.
  */
 static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 			     sk_read_actor_t recv_actor, bool noack)
@@ -4638,11 +4648,14 @@ static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 	if (noack)
 		goto out;
 
-	mptcp_rcv_space_adjust(msk, copied);
-
+	/* The backlog flushing is only needed when some data is actually
+	 * moved and will take place in the workers's release callback.
+	 */
 	if (copied > 0) {
 		mptcp_recv_skb(sk, &offset);
-		mptcp_cleanup_rbuf(msk, copied);
+		msk->read_copied += copied;
+		set_bit(MPTCP_WORK_READ_COMPLETE, &msk->flags);
+		mptcp_schedule_work(sk);
 	}
 out:
 	return copied;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3a677a88ee4c..f08803593d66 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -117,6 +117,7 @@
 #define MPTCP_FALLBACK_DONE	2
 #define MPTCP_WORK_CLOSE_SUBFLOW 3
 #define MPTCP_RTX_DISABLED	4
+#define MPTCP_WORK_READ_COMPLETE 5
 
 /* MPTCP socket release cb flags */
 #define MPTCP_PUSH_PENDING	1
@@ -312,6 +313,7 @@ struct mptcp_sock {
 	u32		last_data_sent;
 	u32		last_data_recv;
 	u32		last_ack_recv;
+	int		read_copied;
 	unsigned long	timer_ival;
 	u32		token;
 	u32		tfo_skb_len;
-- 
2.53.0

