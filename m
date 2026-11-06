Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965043;
	b=R8HVmgGSCMibYcACd6CkHOUEMx89O/v8ORIFQsOJi9I78j58iFu77hEjGY+g+RJAdSNf
	 3H29Zog145rEz4eXe+Ex2EKOYOhoYkMR1pDGw6yjDtn8By483MPkCiEibyvZIeOflFk3D
	 uHZaSX6nHO1yLxCHM0kgZJL3TlW+e8P+1bcVq3magX1KXY/St51k0IJkLO39nmJNhVmEO
	 h6tcZTNid9sOtMZMQ8e+xPloWI6vXSRXxPtPHXrWivne3dxdJwKGt8hOk196C6twQdRjQ
	 KUmX4FQZskwOZ2ySIEGX92qf7eNFG29ewMAOX7iqBObXaIj/hWPcI/5k1lEAsVEkr0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965043;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ghjivGT3KkRvOjBl9IdXDkTaN0jLumS52KQXvBF/FOA=;
	b=nfyuAmvR3Alcaqy1W1WJib/OTJbBW6VU7jLYPF6ElW+PZcjtW+bMKT/rFXF0bWOAqssG
	 8xHGSsZp3/VY0IKG9j3ReLywztGwSr1HRJ1CaDq0LHFirz6NVBULTQpZC+py/XqOIAyyL
	 BA6L29ThnNln+KbSoaStJmLb2q0gKndmUpvKDtnn3BoNX00Yl79DbV0h4RtIBVal3xJ+w
	 qH9RW+MBMA/yni0vv0Yyme4oKvbn6cs6TzFPpgp79mbg9LEYZO2TaFfeGcszQhUkjZFrE
	 Hay8nKbPxsAXusSsvqgs2K+NruUyBOYJ6kDfaYWBBRVL31HF+JlYjrUdVe8XqW/QNGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G5XXZhPQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E863A606C6FA
	for <mptcp@lists.linux.dev>; Fri,  6 Nov 2026 11:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G5XXZhPQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9031F008A1;
	Fri,  6 Nov 2026 11:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793965042;
	bh=ghjivGT3KkRvOjBl9IdXDkTaN0jLumS52KQXvBF/FOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G5XXZhPQTl54mAXLjAzG/fjretsK6G5hZd+ZKe1LDeDOJl9Lz46TdxXhTiF+9D587
	 Vqr6jtmmW0fY9BbWW1uT2UkaB1DCnIzxdpLXCKKU1UVkbxyFFOFKd8PGToX+nQ06Tw
	 L7Zo3LfOyFVNvVLrZbE18vUgwom6Xduhun75IBk1kHdQ6TYXft2GZhREv7ZOtwp7aQ
	 xhp/mTC3svz1bgW9OoNRqiLUgetLz7zUxYwhGUJqKpZXZ+I3Tmcwgc7nqaQHQCn/GC
	 WrSsVEx1JgzEclSqgdmDdUMLg+BjLdUy8MaOiNZPk9rtU0WSnFZQUAAQokOYFCjBgi
	 TL7XFZmuLUG1g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v22 8/8] mptcp: defer read_sock cleanup to mptcp_worker
Date: Fri,  6 Nov 2026 19:37:04 +0800
Message-ID: <2ad403ceaeb4a85913979b39448f90e2cc3a91b1.1793964796.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793964796.git.tanggeliang@kylinos.cn>
References: <cover.1793964796.git.tanggeliang@kylinos.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch prepares __mptcp_read_sock() for future MPTCP TLS support,
where it may be reached from BH context. In that case, calling
mptcp_rcv_space_adjust() and mptcp_cleanup_rbuf() is not safe as both
expect process context.

Note: The BH call path does not exist in the current tree. This is
groundwork for the upcoming TLS-over-MPTCP series. Currently, the only
callers are mptcp_splice_read() and svc_tcp_recvfrom(), both of which
hold lock_sock() and run in process context.

Conditionally defer cleanup to mptcp_worker(): when the caller doesn't
own the socket lock (BH context), accumulate consumed bytes in
msk->read_copied and signal the worker through MPTCP_WORK_READ_COMPLETE.
When the caller owns the lock (process context), perform inline cleanup
to avoid delaying window updates and autotuning.

Restore the backlog flush in mptcp_recv_skb() with a sock_owned_by_user()
check. This ensures process context callers flush the backlog before
processing skbs, while future BH context callers skip it to avoid
deadlock on mptcp_data_lock().

Initialize msk->read_copied in __mptcp_init_sock() and reset it in
mptcp_disconnect().

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 38 +++++++++++++++++++++++++++++++++-----
 net/mptcp/protocol.h |  2 ++
 2 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ced34e8cd25c..b23159d9044c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3162,6 +3162,21 @@ static void mptcp_backlog_purge(struct sock *sk)
 	sk_mem_reclaim(sk);
 }
 
+static void mptcp_read_complete(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	int read_copied;
+
+	mptcp_data_lock(sk);
+	read_copied = msk->read_copied;
+	msk->read_copied = 0;
+	mptcp_data_unlock(sk);
+
+	mptcp_rcv_space_adjust(msk, read_copied);
+	if (read_copied > 0)
+		mptcp_cleanup_rbuf(msk, read_copied);
+}
+
 static void mptcp_do_fastclose(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
@@ -3237,6 +3252,9 @@ static void mptcp_worker(struct work_struct *work)
 	if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
 		__mptcp_retrans(sk);
 
+	if (test_and_clear_bit(MPTCP_WORK_READ_COMPLETE, &msk->flags))
+		mptcp_read_complete(sk);
+
 	fail_tout = msk->first ? READ_ONCE(mptcp_subflow_ctx(msk->first)->fail_tout) : 0;
 	if (fail_tout && time_after(jiffies, fail_tout))
 		mptcp_mp_fail_no_response(msk);
@@ -3280,6 +3298,7 @@ static void __mptcp_init_sock(struct sock *sk)
 	msk->last_data_sent = tcp_jiffies32;
 	msk->last_data_recv = tcp_jiffies32;
 	msk->last_ack_recv = tcp_jiffies32;
+	msk->read_copied = 0;
 
 	mptcp_pm_data_init(msk);
 	spin_lock_init(&msk->fallback_lock);
@@ -3727,6 +3746,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	msk->fastclosing = 0;
 	msk->tfo_iasn = 0;
 	msk->rcvd_dummy_seq = false;
+	msk->read_copied = 0;
 	mptcp_init_rtt_est(msk);
 
 	/* for fallback's sake */
@@ -4649,7 +4669,7 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 	struct sk_buff *skb;
 	u32 offset;
 
-	if (!list_empty(&msk->backlog_list))
+	if (sock_owned_by_user(sk) && !list_empty(&msk->backlog_list))
 		mptcp_move_skbs(sk);
 
 	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
@@ -4666,6 +4686,7 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 /*
  * Note:
  *	- It is assumed that the socket was locked by the caller.
+ *	- Can be invoked in BH scope.
  */
 static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 			     sk_read_actor_t recv_actor, bool noack)
@@ -4707,11 +4728,18 @@ static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 	if (noack)
 		goto out;
 
-	mptcp_rcv_space_adjust(msk, copied);
-
 	if (copied > 0) {
-		mptcp_recv_skb(sk, &offset);
-		mptcp_cleanup_rbuf(msk, copied);
+		if (sock_owned_by_user(sk)) {
+			/* Process context: inline cleanup */
+			mptcp_rcv_space_adjust(msk, copied);
+			mptcp_recv_skb(sk, &offset);
+			mptcp_cleanup_rbuf(msk, copied);
+		} else {
+			/* BH context: defer to worker */
+			msk->read_copied += copied;
+			set_bit(MPTCP_WORK_READ_COMPLETE, &msk->flags);
+			mptcp_schedule_work(sk);
+		}
 	}
 out:
 	return copied;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index fa54f70ab501..3580cf66f303 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -117,6 +117,7 @@
 #define MPTCP_FALLBACK_DONE	2
 #define MPTCP_WORK_CLOSE_SUBFLOW 3
 #define MPTCP_RTX_ENABLED	4
+#define MPTCP_WORK_READ_COMPLETE 5
 
 /* MPTCP socket release cb flags */
 #define MPTCP_PUSH_PENDING	1
@@ -326,6 +327,7 @@ struct mptcp_sock {
 	u32		last_data_sent;
 	u32		last_data_recv;
 	u32		last_ack_recv;
+	int		read_copied;
 	unsigned long	timer_ival;
 	u32		token;
 	u64		tfo_iasn;
-- 
2.55.0

