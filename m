Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793696259;
	b=U/goqkUIW0GwQMOTv4QA7IiKbZSQx19QjORyE7W8CxF3alYZIMFZlu+Y0kXafmB2ryOQ
	 uuCGGm54b+gzDXZvrMwdbEZCce0A/ooUgaLe4EuEO6Eqvdjv/OtrqkuUA0PwJAhAfSzXU
	 UxYdhen0pqmMD+hlQOHBHTaaP6LXy7FB/uJGCeATQY/BtSFZ+eVpZs5osL07E/s/AEBgS
	 R70GO1CmAaxGl3oAovsYXgqGLBwr2lkEaMajhvkUPM629/xGN3O0i58B5yCwYbq/tTH6T
	 oP3EVbKWlTosqF1QqaoPm+SIh+fpe7YXiF8+N7MKNSgxJq+O5S8U4VozLR+sUNO0Hew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793696259;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=oMhmyIHQITW8+f0NpI/j7JCrVNR2HsEBSFaVwzb1ERI=;
	b=O4nldXy3+VPfKmuJlrvjH17+vHqwobICRM2IsHaCwULnJtlGkBEqNmNhy0PYPsRCLrXB
	 GzTA/I8W9yzCtVzYf+e7qUB7q/H0fV5rid5Hmt46hfLBEBIm/KlNjAnhOZCT/eQ4X9+Ib
	 ehz4t8qRvCF1S3WajtAhSNHgDVs9gMfa8SK1hbfYAF28S77GhyxHBrJ5VZ7odadcJ3aST
	 JGN7FM9TBAnujxZOiA86Qn3w5RnjWIPAQCgVn3HQf2rJDoP71Q3dEJeJx2MP4o+HZCjO+
	 trDxrE5kVizWgqGz+p2uNAow6+lRjpr3o0/SRQdejEVGpO3OLWUHJG3mRsp8Z2+RjAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W05LwyrA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D1D606A32D
	for <mptcp@lists.linux.dev>; Tue,  3 Nov 2026 08:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W05LwyrA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6ED71F000C1;
	Tue,  3 Nov 2026 08:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793696259;
	bh=oMhmyIHQITW8+f0NpI/j7JCrVNR2HsEBSFaVwzb1ERI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W05LwyrAb3oaQsjoWDhdx5HiqbPZW6kfF1ZpI/qZwVC8H1dvJK30UBtYkFsLUCoAA
	 hiADN/LimuY2M6JYvSiqrsE70W69EvvgyTpAYN/Xjq7Fm4HJZTPIMMAktdyREhTLs1
	 tvju0K6xFw7S9w/sCxA76strVF8QS4+dNK9UXJpZxLvEY50HwtOx3zzEgQZCd9Niqw
	 BQdDw1lQEUjnFr4TBiZ84e4ylZGNz20ovuEkaOsfn3I3tFIXq/GihIhp6MTHm6RxUh
	 i3vHqJ6zC5uN/wt7ui1GSx7BUfL5C+qhK4jRv/fp63YZb3ZiZ5+O/5lhWPpBQGCP/H
	 j6jBccRByLsow==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v20 6/6] mptcp: defer read_sock cleanup to mptcp_worker
Date: Tue,  3 Nov 2026 16:57:25 +0800
Message-ID: <278ffcf759c109e3753112e62cb7c53b58159650.1793695518.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793695518.git.tanggeliang@kylinos.cn>
References: <cover.1793695518.git.tanggeliang@kylinos.cn>
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

When MPTCP carries TLS, __mptcp_read_sock() may be reached from BH
context (via tls_strp_read_copyin() -> sk->sk_read_sock()), where
calling mptcp_rcv_space_adjust() and mptcp_cleanup_rbuf() is not safe
as both expect process context.

Conditionally defer cleanup to mptcp_worker(): when the caller doesn't
own the socket lock (BH context), accumulate consumed bytes in
msk->read_copied and signal the worker through MPTCP_WORK_READ_COMPLETE.
When the caller owns the lock (process context), perform inline cleanup
to avoid delaying window updates and autotuning.

Replace msk_owned_by_me() assertion with DEBUG_NET_WARN_ON_ONCE using
lockdep_sock_is_held() to verify proper locking for both process and
BH contexts.

Also remove the backlog flush from mptcp_recv_skb() (covered by
mptcp_release_cb()) and drop the redundant mptcp_recv_skb() call after
the main loop.

Initialize msk->read_copied in __mptcp_init_sock() and reset it in
mptcp_disconnect().

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 41 +++++++++++++++++++++++++++++++++--------
 net/mptcp/protocol.h |  2 ++
 2 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3e10b06b7772..25f0d10373d2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3156,6 +3156,21 @@ static void mptcp_backlog_purge(struct sock *sk)
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
@@ -3231,6 +3246,9 @@ static void mptcp_worker(struct work_struct *work)
 	if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
 		__mptcp_retrans(sk);
 
+	if (test_and_clear_bit(MPTCP_WORK_READ_COMPLETE, &msk->flags))
+		mptcp_read_complete(sk);
+
 	fail_tout = msk->first ? READ_ONCE(mptcp_subflow_ctx(msk->first)->fail_tout) : 0;
 	if (fail_tout && time_after(jiffies, fail_tout))
 		mptcp_mp_fail_no_response(msk);
@@ -3274,6 +3292,7 @@ static void __mptcp_init_sock(struct sock *sk)
 	msk->last_data_sent = tcp_jiffies32;
 	msk->last_data_recv = tcp_jiffies32;
 	msk->last_ack_recv = tcp_jiffies32;
+	msk->read_copied = 0;
 
 	mptcp_pm_data_init(msk);
 	spin_lock_init(&msk->fallback_lock);
@@ -3721,6 +3740,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	msk->fastclosing = 0;
 	msk->tfo_iasn = 0;
 	msk->rcvd_dummy_seq = false;
+	msk->read_copied = 0;
 	mptcp_init_rtt_est(msk);
 
 	/* for fallback's sake */
@@ -4643,9 +4663,6 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 	struct sk_buff *skb;
 	u32 offset;
 
-	if (!list_empty(&msk->backlog_list))
-		mptcp_move_skbs(sk);
-
 	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
 		offset = (u32)msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
 		if (offset < skb->len) {
@@ -4660,6 +4677,7 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 /*
  * Note:
  *	- It is assumed that the socket was locked by the caller.
+ *	- Can be invoked in BH scope.
  */
 static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 			     sk_read_actor_t recv_actor, bool noack)
@@ -4669,7 +4687,7 @@ static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 	int copied = 0;
 	u32 offset;
 
-	msk_owned_by_me(msk);
+	DEBUG_NET_WARN_ON_ONCE(!lockdep_sock_is_held(sk));
 
 	if (sk->sk_state == TCP_LISTEN)
 		return -ENOTCONN;
@@ -4701,11 +4719,18 @@ static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
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

