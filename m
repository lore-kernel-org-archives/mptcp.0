Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7B83E0250
	for <mptcp@lists.linux.dev>; Mon, 31 Aug 2026 10:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788172093; cv=none; b=mFvgsnOrLoC9YBTRfoY88yIiOnQ8DtldNRuJREMS4bW2J/BwgA/gmwH+dnq8mkrxB0+m/TcdWXPBZ2dTMuVg19L5P11UwnORiiV8ooSuLPdkdNx3/L5hSF2a6VougrQ4GsSuga0Dt1qKgXbYsxiY/226gHT7kZZMsfis8WtRK+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788172093; c=relaxed/simple;
	bh=95j6rm6XRyFi3rcmV2l4nzYLejUasMyxZWfAOePeYTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rn3DeE45aj34lhf6pmmfOQJAmfk+mpNkeG0RwLzRxAx/CaEiYwTV/VXBjPW3VlouHogeIk4U5LC8u566gMqUvMJpNdIFb8JKlz7e+6jhMm2a4Mph5bzZdN2Ykq8BtkDGf+SCrUAkWz2b9ecaerWI/abv2usLlK0WAsMN/b5O+ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/5BQeY1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/5BQeY1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB49F1F00A3D;
	Mon, 31 Aug 2026 10:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788172091;
	bh=1PSNbIzgUHKgjisKnQ9Ec+p79c6uhyVUBG/zrce6jFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b/5BQeY17lnMUTj7nEZcL3LhsWrqtR0OJaCH6CjQBivuaUzD+abdaSu/29N/db+4b
	 mMwoK7vo9BSVpKBnoKEiqa19LgrF5j1IsxiOWcE5Pb4cxXZIy9JTjVudXU198arS+C
	 lwfe/HhROJG/5u8UQKPulFz5CeXG/xLnQO98ZV0psbRO4Dpqn+7E+km4irAIxE0BpA
	 fwWCJIzh/VVGkHhT5aKVXmfR1yZ+JKuJdQIFmYUa7QwDHkSsu42cMALWg4DM8knk9+
	 1OHVIH0DpU8ZbgljWZodNnkJf/2wmDA/rI/QHsxpc01Jc6O0X/qvSqU1sZ716Au8cO
	 AxXsxPOvVUlQw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v12 05/10] mptcp: defer read_sock cleanup to mptcp_worker
Date: Mon, 31 Aug 2026 18:27:13 +0800
Message-ID: <d762f0862ef7524c71e629b85f88a2153230a927.1788171508.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788171508.git.tanggeliang@kylinos.cn>
References: <cover.1788171508.git.tanggeliang@kylinos.cn>
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
 net/mptcp/protocol.c | 32 ++++++++++++++++++++++++--------
 net/mptcp/protocol.h |  2 ++
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 57933d024558..9bcca31501e7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3140,6 +3140,20 @@ static void mptcp_backlog_purge(struct sock *sk)
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
+	mptcp_cleanup_rbuf(msk, read_copied);
+}
+
 static void mptcp_do_fastclose(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
@@ -3216,6 +3230,9 @@ static void mptcp_worker(struct work_struct *work)
 	if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
 		__mptcp_retrans(sk);
 
+	if (test_and_clear_bit(MPTCP_WORK_READ_COMPLETE, &msk->flags))
+		mptcp_read_complete(sk);
+
 	fail_tout = msk->first ? READ_ONCE(mptcp_subflow_ctx(msk->first)->fail_tout) : 0;
 	if (fail_tout && time_after(jiffies, fail_tout))
 		mptcp_mp_fail_no_response(msk);
@@ -4602,9 +4619,6 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 	struct sk_buff *skb;
 	u32 offset;
 
-	if (!list_empty(&msk->backlog_list))
-		mptcp_move_skbs(sk);
-
 	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
 		offset = (u32)msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
 		if (offset < skb->len) {
@@ -4619,6 +4633,7 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 /*
  * Note:
  *	- It is assumed that the socket was locked by the caller.
+ *	- Can be invoked in BH scope.
  */
 static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 			     sk_read_actor_t recv_actor, bool noack)
@@ -4628,8 +4643,6 @@ static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 	int copied = 0;
 	u32 offset;
 
-	msk_owned_by_me(msk);
-
 	if (sk->sk_state == TCP_LISTEN)
 		return -ENOTCONN;
 	while ((skb = mptcp_recv_skb(sk, &offset)) != NULL) {
@@ -4660,11 +4673,14 @@ static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
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
index f46b9aa4840a..b3414745fcaa 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -117,6 +117,7 @@
 #define MPTCP_FALLBACK_DONE	2
 #define MPTCP_WORK_CLOSE_SUBFLOW 3
 #define MPTCP_RTX_ENABLED	4
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

