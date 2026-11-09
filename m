Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794216270;
	b=MQnfj4oOqg4v0ZQ81Fuhg5e8zrkrpnHg1EJm/FX5vOba523xr2QcDIaeihbpiaYzPUo3
	 VPwPm+Oo0R0ixbcMOZshkHP8BfGs5KoXbMwYZff4qvb6Ewfx0uci0TBtn4TqOoksCKuXg
	 aNev+RCK5rMXv1T2qWj/ILKbOuugg9n8H5+S1OvPD6UTdyvs9aedPd8iEfFH8rdIob1LM
	 zxvfLhy6YzMXZBWV/hldjMi/RFLCFQhKNPRw8I5rfWYTuIqrRJl6lmiqQwI0t0/lfnGhW
	 /2ILyU5woqG2m5SO69cxHnHQO3sBgbAnTQRnVfYJp3lnRzG5CN3pdQyDYGoER3J1hEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216270;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Db2P/eDEIcGOl0NV3ch0kk0QVdprBo2Kt6IMss707oo=;
	b=QFyNyMUyVgdJqGFkagbTnm1Lt7J2gHGmEnJWZCgCF+ZtPPHgTOVhzN+CBzL3kvjYWrCL
	 LidjnEoc0MKIEAEgCM/tFwFvz80dEObYe7A7N3+emYqmKDBQ6DSqMiz8u+EVudrxC7QLI
	 lTOVieUDyl9m6OzTupfZNIrYEcjZpJVPEGxkvb1rIeCd9lwgLj8+LB0iaGL3uKpEmjdlk
	 9f1aZomuerIOBPuEJA3AmunyehPYjfy4USwQrnXA3A2MUOphIU786266gycnVRYjuBD+T
	 7dV0JfkdSm0/SJGPFqD9drWs9r9fvIzUxXvN7p/+8q/B5SnmaPxXUMLozcpbpkzF8XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WOgKDoH5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059876082BDA
	for <mptcp@lists.linux.dev>; Mon,  9 Nov 2026 09:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WOgKDoH5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A851F008A5
	for <mptcp@lists.linux.dev>; Mon,  9 Nov 2026 09:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794216269;
	bh=Db2P/eDEIcGOl0NV3ch0kk0QVdprBo2Kt6IMss707oo=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=WOgKDoH5Hnalt1BVOmLrFLdQjii/SFmWUgyPr5uFywFlKS5RSuAPaUkDiw7yRHTb6
	 kL/f3ZgOzlVCfMj/+KyZvxheiKgM79zhHoZVTgGDwqmrYaJeWLbvit/mIQDkrGr/NQ
	 ETetRAkOvnQuFAqqynoDMOpUNIo+wu/u6uxFudHIHaaThjF/SvJ6b3MrPa6gIRT4LR
	 qExIDbbMH8gAgsEVzXp9lLuhk1Sqs6p18XpcIF8z7owvNGxjVQO3BxE3LihSV2KJ6v
	 xXsh04Yvz9JCTGw8x9VwT/b8+GtACaZ6XmWk1u3deFL8lB7hmGSW6BC/7yWR7/fn18
	 MNViUSYgNBrjw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v24 8/8] mptcp: defer read_sock cleanup to mptcp_worker
Date: Mon,  9 Nov 2026 17:24:10 +0800
Message-ID: <c47e1e62a4cc0166578a001304309fe9cbdbfdda.1794215614.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794215614.git.tanggeliang@kylinos.cn>
References: <cover.1794215614.git.tanggeliang@kylinos.cn>
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

The existing backlog flush in mptcp_recv_skb() is now gated on
sock_owned_by_user(). This ensures process context callers flush the
backlog before processing skbs, while future BH context callers skip it.
The reason is that BH callers would already hold the msk spinlock, so
mptcp_data_lock() inside mptcp_move_skbs() would self-deadlock.

Initialize msk->read_copied in __mptcp_init_sock() and reset it in
mptcp_disconnect().

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 38 +++++++++++++++++++++++++++++++++-----
 net/mptcp/protocol.h |  2 ++
 2 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 683ffa8f6c7a..3f81a55e6e00 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3186,6 +3186,21 @@ static void mptcp_backlog_purge(struct sock *sk)
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
@@ -3261,6 +3276,9 @@ static void mptcp_worker(struct work_struct *work)
 	if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
 		__mptcp_retrans(sk);
 
+	if (test_and_clear_bit(MPTCP_WORK_READ_COMPLETE, &msk->flags))
+		mptcp_read_complete(sk);
+
 	fail_tout = msk->first ? READ_ONCE(mptcp_subflow_ctx(msk->first)->fail_tout) : 0;
 	if (fail_tout && time_after(jiffies, fail_tout))
 		mptcp_mp_fail_no_response(msk);
@@ -3304,6 +3322,7 @@ static void __mptcp_init_sock(struct sock *sk)
 	msk->last_data_sent = tcp_jiffies32;
 	msk->last_data_recv = tcp_jiffies32;
 	msk->last_ack_recv = tcp_jiffies32;
+	msk->read_copied = 0;
 
 	mptcp_pm_data_init(msk);
 	spin_lock_init(&msk->fallback_lock);
@@ -3751,6 +3770,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	msk->fastclosing = 0;
 	msk->tfo_iasn = 0;
 	msk->rcvd_dummy_seq = false;
+	msk->read_copied = 0;
 	mptcp_init_rtt_est(msk);
 
 	/* for fallback's sake */
@@ -4673,7 +4693,7 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 	struct sk_buff *skb;
 	u32 offset;
 
-	if (!list_empty(&msk->backlog_list))
+	if (sock_owned_by_user(sk) && !list_empty(&msk->backlog_list))
 		mptcp_move_skbs(sk);
 
 	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
@@ -4690,6 +4710,7 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 /*
  * Note:
  *	- It is assumed that the socket was locked by the caller.
+ *	- Can be invoked in BH scope.
  */
 static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 			     sk_read_actor_t recv_actor, bool noack)
@@ -4731,11 +4752,18 @@ static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
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
index 8c868bcbafb8..fb927bc3bcdc 100644
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
+	int		read_copied;
 	unsigned long	timer_ival;
 	u32		token;
 	u64		tfo_iasn;
-- 
2.55.0

