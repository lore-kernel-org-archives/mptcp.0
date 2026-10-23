Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792720752;
	b=c2e9eGtK0JIOvp8Ay1EPKyk7WobekvpqIV271wrxbQvgONmxAHgiiPt4XLxqW+S1EDdX
	 W8lfxiMkvhhEXx3KJCCWwcHjUBw0jE+8/vIr20HAtSHEedPoVmD9WQdPaFGUGKd5XZUb9
	 BBVJlU+8VB/E3kMghF2VSmeT1kFDOR+3A3g6PCyxfkXD09HzBa5f7kYoTwn8O0g6KEQxx
	 rnudByyl6hGwIZLU0DpK5KCp3Gne+my4lpkQbTZl29F5l7h8lUjMht0cjLJF0Zae53W5B
	 +tW6IuYQXOWgIVHCSOAIn/IHDmsYANXNNL5lJy0bv1qnvuza9WmDbRlJDP6DQNvcGMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792720752;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=RqybjaPV9Ri2JPP7lqjDXG1E9kIT7QMmog5K7Qgl5rU=;
	b=zHl3Ch3sSlTAmDkc6M6chHCc3y5GvMEySPS+VAW0FAd2P+3naEc+yTGK4eL4UUGU38TI
	 sHRM1D4GymhMT3bhwMFp9ad8LDbgm9Vx0CE565lWZolEfixTUvn/c19/sTLqfSN3J/paw
	 I9q+qAapNVPfvauU6wnV1s49oTP2DcC8+1KlFA2sZv4sCB07vsFx6UjlxPAef2q9bXh3s
	 0KP6O9JU4n1fIh0o7yzqBQopXSvE52zXsurpYgN3vvE/hNTuZVYh3wFjKRI6zZXHTRmDo
	 XZXdS5iP4ir24x0VJdveyFzCEfaUSGJdOjlvee0vWphWL+JU8o8z7U8u6BU70CSThGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ny/mwq3x";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6974606A319
	for <mptcp@lists.linux.dev>; Fri, 23 Oct 2026 01:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ny/mwq3x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B7E1F01825;
	Fri, 23 Oct 2026 01:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792720751;
	bh=RqybjaPV9Ri2JPP7lqjDXG1E9kIT7QMmog5K7Qgl5rU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ny/mwq3xzesLFJQMyRFIb9cjHw1kiqJj31UCpNNj17zJr5ZYXCiNBEXNF19rUskau
	 UsU3k+3yJdGKJHmUw3ZgVn3wFXjgRyicdfq3y4VE5Zb8zIj+a5o1oDmpK+vPObDIOZ
	 nlYiR+8mk+X2Yzkf9knGCML5rwwGiu7F7nCIElryU/RnA07FHG4vryEmE4bp2BDBOQ
	 gRHO/HP+doqIyMQbiiw75cRYpV9DF1OYRwD+EFCb0PaGnnJVPlz4U31FwLJYqrODBI
	 zCaroHkiVudboKbHtrVZfq56703fMg/kiOYrZzn2Wp98TuyTQXXjoLspWb9ViIkbmH
	 Yr/dWyGl8Z7Pg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v15 05/11] mptcp: defer read_sock cleanup to mptcp_worker
Date: Fri, 23 Oct 2026 09:58:46 +0800
Message-ID: <d3072fed79af4d6dc637fd7ecf2263ac0d189cc6.1792718041.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792718041.git.tanggeliang@kylinos.cn>
References: <cover.1792718041.git.tanggeliang@kylinos.cn>
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

From: Paolo Abeni <pabeni@redhat.com>

This is preparatory work for an upcoming kTLS-over-MPTCP series. When
MPTCP carries TLS, __mptcp_read_sock() will be reached from BH context
(via tls_strp_read_copyin() -> sk->sk_read_sock()), where calling
mptcp_rcv_space_adjust() and mptcp_cleanup_rbuf() inline is not safe:
both expect process context.

Move both calls to mptcp_worker(): __mptcp_read_sock() accumulates the
consumed byte count in msk->read_copied and signals the worker through
a new MPTCP_WORK_READ_COMPLETE bit. The worker drains the accumulator
under mptcp_data_lock() and runs the rcvbuf autotuning and RDB update
in process context. To prevent integer overflow when read_copied wraps
to negative values, mptcp_read_complete() only calls mptcp_cleanup_rbuf()
when read_copied > 0.

Since the worker now owns the post-read housekeeping, remove the backlog
flush from mptcp_recv_skb() (it ran mptcp_move_skbs() which is already
covered by mptcp_release_cb() when the worker calls release_sock()) and
drop the msk_owned_by_me() assertion from __mptcp_read_sock() (the BH
caller does not own the msk lock). Also drop the now-redundant
mptcp_recv_skb() call after the main loop in __mptcp_read_sock(): its
return value and offset output were unused, and fully-consumed SKBs are
already eaten by mptcp_eat_recv_skb() within the loop.

Initialize msk->read_copied in __mptcp_init_sock() and reset it in
mptcp_disconnect() alongside the other per-connection counters, so a
socket does not carry a stale byte count across connections.

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 37 ++++++++++++++++++++++++++++---------
 net/mptcp/protocol.h |  2 ++
 2 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 01eb7fb314e7..3c3ad8991799 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3149,6 +3149,21 @@ static void mptcp_backlog_purge(struct sock *sk)
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
@@ -3224,6 +3239,9 @@ static void mptcp_worker(struct work_struct *work)
 	if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
 		__mptcp_retrans(sk);
 
+	if (test_and_clear_bit(MPTCP_WORK_READ_COMPLETE, &msk->flags))
+		mptcp_read_complete(sk);
+
 	fail_tout = msk->first ? READ_ONCE(mptcp_subflow_ctx(msk->first)->fail_tout) : 0;
 	if (fail_tout && time_after(jiffies, fail_tout))
 		mptcp_mp_fail_no_response(msk);
@@ -3267,6 +3285,7 @@ static void __mptcp_init_sock(struct sock *sk)
 	msk->last_data_sent = tcp_jiffies32;
 	msk->last_data_recv = tcp_jiffies32;
 	msk->last_ack_recv = tcp_jiffies32;
+	msk->read_copied = 0;
 
 	mptcp_pm_data_init(msk);
 	spin_lock_init(&msk->fallback_lock);
@@ -3709,6 +3728,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	msk->bytes_received = 0;
 	msk->bytes_sent = 0;
 	msk->bytes_retrans = 0;
+	msk->read_copied = 0;
 	msk->rcvspace_init = 0;
 	msk->fastclosing = 0;
 	msk->tfo_skb_len = 0;
@@ -4638,9 +4658,6 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 	struct sk_buff *skb;
 	u32 offset;
 
-	if (!list_empty(&msk->backlog_list))
-		mptcp_move_skbs(sk);
-
 	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
 		offset = (u32)msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
 		if (offset < skb->len) {
@@ -4655,6 +4672,7 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 /*
  * Note:
  *	- It is assumed that the socket was locked by the caller.
+ *	- Can be invoked in BH scope.
  */
 static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 			     sk_read_actor_t recv_actor, bool noack)
@@ -4664,8 +4682,6 @@ static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 	int copied = 0;
 	u32 offset;
 
-	msk_owned_by_me(msk);
-
 	if (sk->sk_state == TCP_LISTEN)
 		return -ENOTCONN;
 	while ((skb = mptcp_recv_skb(sk, &offset)) != NULL) {
@@ -4696,11 +4712,14 @@ static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 	if (noack)
 		goto out;
 
-	mptcp_rcv_space_adjust(msk, copied);
-
+	/* The backlog flushing is only needed when some data is actually
+	 * moved and will take place in mptcp_release_cb() via
+	 * release_sock() in the worker.
+	 */
 	if (copied > 0) {
-		mptcp_recv_skb(sk, &offset);
-		mptcp_cleanup_rbuf(msk, copied);
+		msk->read_copied += copied;
+		set_bit(MPTCP_WORK_READ_COMPLETE, &msk->flags);
+		mptcp_schedule_work(sk);
 	}
 out:
 	return copied;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index fc39fd733860..a061609f6152 100644
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
 	u32		tfo_skb_len;
-- 
2.55.0

