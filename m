Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794811163;
	b=xp3V4bECipOrkLBlbSSiVrrX0Lde80lpvGewa9roXtypEaEWGATOImhWrTxI7P288WHU
	 Cwd5XFlT6tqeDuXugyaABVmqG+hVwBB0WeQOHBWNSZrpfpYOsjl/2m3hOVnHtk0dOym4/
	 d06aJAR+oJsRtLPkwfPHUv1En4273V4evx3uCBLXRvb5DuQXkktBJQbSnqtLlrITNQmFO
	 ZN9rLER0B6HeWHVYr2vjrGVA9rusRRJDvOx9qEHKA2n+gaq7Tsx4HdHsEJ93RqDmSdlCJ
	 RihgxaC/u59l9HX6Oe0CPOStc/5ITh+elA387kiRH9RHYztcvikzHTJ7C2tv9FTPhig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794811163;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WK8inA3IFsWtHUFK24xWAGucL0hGl070+HCXtq/hBR0=;
	b=RRrNXxQjIo8cc/jxC03qeCBzR+DKX4ebRcayFS0beOigJq4nS04eZJPacMrgAaQR1tNX
	 a8Ol8a7cxDnOyoUK+zwSN2VpkF+XZWj/CD3CytsKMqyyOiptUHbnQlCpqh/VXloPlF7iS
	 S3gksOkqu9ApF2ZP8PmkEUmB3G6CqieVOoMqz9jPZo1gwHxYW62v7ENp5SwI6I2t/LY8v
	 a27LrQUj7IVuDjPjt4DQ8Qv3JWJ5dp3+oOvY2m1riRWDraMvqc6wgD21iWHJf6i31NJEm
	 U2bluQuefWhRZ3G5EM07loeTUupAgFW74knhRJHHkKm6VJnSWh4Qwi7Mlw0+XDydacg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="LqmL/9XJ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4F3606A31C
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 06:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LqmL/9XJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909411F000D1
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 06:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794811163;
	bh=WK8inA3IFsWtHUFK24xWAGucL0hGl070+HCXtq/hBR0=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=LqmL/9XJLA909bTAfb2i3+4UisJPlTbTjR3pb277t1FqrNAJp3U+8/xg9ajOJDYQv
	 WtjDZjgipZ96HtHKeJ9P1iyLTQZmkyqPggUOLk8ge1GiM6HVftFaX+lNn/d5MTUJ4N
	 rU3/5RtT9mEUB/o4eAU5WWc0DPDrpsOZ0pIm9Hzf/6xOXrM+siDgsesUngECwM3/14
	 RhGekx0nKAk/FC5nCOYYKi4oBwtRdOvFqnqZIp/ISCSYNsR4dNvyGECQ0KQWjCTLAD
	 nnyerV//1EMSQ+meZq7mTY6os/lVSYta2glBjbb7GHFctKA9HEqLBi79xCcADuWVao
	 zWvIl7bJ9M73A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v28 11/11] mptcp: defer read_sock cleanup to mptcp_worker
Date: Mon, 16 Nov 2026 14:39:04 +0800
Message-ID: <f2ed3479f40b044646d03ccbfe0347c7f6a40dc7.1794810809.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794810809.git.tanggeliang@kylinos.cn>
References: <cover.1794810809.git.tanggeliang@kylinos.cn>
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

Conditionally defer cleanup to mptcp_worker(): when the caller doesn't
own the socket lock (BH context), accumulate consumed bytes in
msk->read_copied and signal the worker through MPTCP_WORK_READ_COMPLETE.
When the caller owns the lock (process context), perform inline cleanup
to avoid delaying window updates and autotuning.

The existing backlog flush in mptcp_recv_skb() is now gated on
sock_owned_by_user(). This ensures process context callers flush the
backlog before processing skbs, while future BH context callers skip it.
The reason is that BH callers would already hold the msk spinlock, so
mptcp_data_lock() inside mptcp_move_skbs() would self-deadlock.

Initialize msk->read_copied in __mptcp_init_sock() and reset it in
mptcp_disconnect().

Note: The BH call path does not exist in the current tree. This is
groundwork for the upcoming MPTCP TLS series. Currently, the only
in-tree caller is mptcp_splice_read(), which holds lock_sock() and runs
in process context.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 38 +++++++++++++++++++++++++++++++++-----
 net/mptcp/protocol.h |  2 ++
 2 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 50ae8cdec8a4..6988f6128368 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3165,6 +3165,21 @@ static void mptcp_backlog_purge(struct sock *sk)
 	sk_mem_reclaim(sk);
 }
 
+static void mptcp_read_complete(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	u32 read_copied;
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
@@ -3240,6 +3255,9 @@ static void mptcp_worker(struct work_struct *work)
 	if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
 		__mptcp_retrans(sk);
 
+	if (test_and_clear_bit(MPTCP_WORK_READ_COMPLETE, &msk->flags))
+		mptcp_read_complete(sk);
+
 	fail_tout = msk->first ? READ_ONCE(mptcp_subflow_ctx(msk->first)->fail_tout) : 0;
 	if (fail_tout && time_after(jiffies, fail_tout))
 		mptcp_mp_fail_no_response(msk);
@@ -3283,6 +3301,7 @@ static void __mptcp_init_sock(struct sock *sk)
 	msk->last_data_sent = tcp_jiffies32;
 	msk->last_data_recv = tcp_jiffies32;
 	msk->last_ack_recv = tcp_jiffies32;
+	msk->read_copied = 0;
 
 	mptcp_pm_data_init(msk);
 	spin_lock_init(&msk->fallback_lock);
@@ -3730,6 +3749,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	msk->fastclosing = 0;
 	msk->tfo_iasn = 0;
 	msk->rcvd_dummy_seq = false;
+	msk->read_copied = 0;
 	mptcp_init_rtt_est(msk);
 
 	/* for fallback's sake */
@@ -4652,7 +4672,7 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 	struct sk_buff *skb;
 	u32 offset;
 
-	if (!list_empty(&msk->backlog_list))
+	if (sock_owned_by_user(sk) && !list_empty(&msk->backlog_list))
 		mptcp_move_skbs(sk);
 
 	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
@@ -4669,6 +4689,7 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 /*
  * Note:
  *	- It is assumed that the socket was locked by the caller.
+ *	- Can be invoked in BH scope.
  */
 static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 			     sk_read_actor_t recv_actor, bool noack)
@@ -4710,11 +4731,18 @@ static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
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
index 86634c04f499..4b4b591b1e55 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -117,6 +117,7 @@
 #define MPTCP_FALLBACK_DONE	2
 #define MPTCP_WORK_CLOSE_SUBFLOW 3
 #define MPTCP_RTX_ENABLED	4
+#define MPTCP_WORK_READ_COMPLETE 5
 
 /* MPTCP socket release cb flags */
 #define MPTCP_PUSH_PENDING	1
@@ -328,6 +329,7 @@ struct mptcp_sock {
 	u32		last_data_sent;
 	u32		last_data_recv;
 	u32		last_ack_recv;
+	u32		read_copied;
 	unsigned long	timer_ival;
 	u32		token;
 	u64		tfo_iasn;
-- 
2.55.0

