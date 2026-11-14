Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794664878;
	b=sRKhCk4a5FshtodlEQZUYSPmkh2DRgr411xUUXiMrmaoB80+tAGcjTq7K7homeT1IGLr
	 474kU6y538SQRhusJFjxLUuvCIx767BulCLaLcBq997KqLQ2uONRrhOfTwNsz8iUIeTwT
	 NWpk5aTe3rF8TQR8MjDWdOaRK2F4diFjwSThQgv19FU/77JXJH6+H8Lk745pZ209lg5P0
	 hS0XyAtYGxvT5fWGl+LFNOQAZSwlWl+QHLyf9e74Yv6TGzzEtrS07pep9UfmXHfuLOLTs
	 J/41Xv7gjF0KjZQkjRKBppdHMXqOrCUUwcPSWKekcjTGbHsjRl9g7zBxiO0T0qFlBDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794664878;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WqwLh6dlFrrTy4ZHEOR0s3SkQsEy8qJ/O9U+FZwKuUU=;
	b=3C59U+qNsaqdmJCNm8NsHPp8gkmt08dEN5wHL8DrcTwu6AQY5WJhQ+dIse9D0k4Lpklw
	 fp+H3QlpeNKRN47Y2KqVXrRvtEz4jEvXeSuTgtY7Rh92dkYmJy1INGxiTsnr02M9o44kT
	 pQTeD6n2Y+M4rJkK3kvAp01g9KjmyONPBrMpJHfRNzbHJGjdojkX2v52PbYaF/UrN6yID
	 sLVA6iYLx/9lsadP50Lzs7UR6AGoUnZyMj5b//84K3h54ZVlhagBu4n+dCIFFk/RtPtLs
	 CR08FlSf+emYofF4zHFasO36teZFu+tvjrquJ/gY9WhTONtXCknIr8cYKYtFhGGvsEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PRwnOAUx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD59606A327
	for <mptcp@lists.linux.dev>; Sat, 14 Nov 2026 14:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PRwnOAUx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B9D1F000C5
	for <mptcp@lists.linux.dev>; Sat, 14 Nov 2026 14:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794664878;
	bh=WqwLh6dlFrrTy4ZHEOR0s3SkQsEy8qJ/O9U+FZwKuUU=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=PRwnOAUxzC5r4k4oWYGSZxBzdsE56HfqNV6T4cCOVR1gZRszm7RqmEwk+UeJDLO0X
	 2owyYw69ZujmMsjVpUolOFT4W/kIvrI+ujuc6duXlvaDflm+WpkMx0hCoXehBjGTIh
	 xfQY6QkOloeMYsLsWjExuyDzT2hLYvHxx+GiJRvB+iMzWaSuKopcUspCtGw4SOUhZQ
	 viQM4XapGvlO25nbNp5nLF5Z4AZ4ftkVB53ED8atNUFKffoe00Q/WFtlmHdirlA1JE
	 9iI6s5TMe2Rmp6m06LticwLpD9wO/0K7pduobEmFBqxoM+nrLv0kg4hCnoCXv6KXLS
	 BsV/QPIfCqEFw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v27 5/8] mptcp: drop the cant_coalesce CB field
Date: Sat, 14 Nov 2026 22:01:01 +0800
Message-ID: <fa94d3136758974ad5a26837ee39da26e5c24f12.1794663678.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794663678.git.tanggeliang@kylinos.cn>
References: <cover.1794663678.git.tanggeliang@kylinos.cn>
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

Such field is used to ensure in-sequence processing in case of fastopen.
Instead let's perform synchronization of the fastopen skb sequence
when the IASN becomes available with the 3rd ack.

When the cant_coalesce field has been introduced, commit f03afb3aeb9d
("mptcp: drop __mptcp_fastopen_gen_msk_ackseq()") noted that updating the
already queued skb for passive fastopen socket at 3rd ack time would be
difficult and race prone. The main point is that such update don't need
to be synchronously performed at 3rd ack time, but is sufficient to
perform it before the next segment is introduced into the msk.

To such extent, add __mptcp_sync_rcv_sequence() to update the TFO skb
map_seq and end_seq using the IASN stored in msk->tfo_iasn, and call it
from __mptcp_move_skb() before any new skb lands into the msk.

When the 3rd ack arrives while the msk is owned by user space, defer the
sync via MPTCP_SYNC_SEQ in cb_flags. subflow_set_remote_key() stores
tfo_iasn and either calls __mptcp_sync_rcv_sequence() directly (when the
socket is not locked) or sets MPTCP_SYNC_SEQ for deferred processing.

mptcp_move_skbs() and mptcp_release_cb() check MPTCP_SYNC_SEQ at each
iteration before spooling the backlog, using __test_and_clear_bit() since
the cb_flags are protected by the msk data lock. A rcvd_dummy_seq flag
tracks whether the TFO skb still carries the dummy mapping and needs
synchronization.

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/fastopen.c |  6 ++++--
 net/mptcp/protocol.c | 40 +++++++++++++++++++++++++++++++++++++---
 net/mptcp/protocol.h |  5 ++++-
 net/mptcp/subflow.c  |  8 ++++++++
 4 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index f717750906ff..e18b31028e7e 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -9,6 +9,7 @@
 void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subflow,
 					      struct request_sock *req)
 {
+	struct mptcp_sock *msk;
 	struct sock *sk, *ssk;
 	struct sk_buff *skb;
 	struct tcp_sock *tp;
@@ -49,15 +50,16 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 	MPTCP_SKB_CB(skb)->end_seq = 0;
 	MPTCP_SKB_CB(skb)->offset = 0;
 	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
-	MPTCP_SKB_CB(skb)->cant_coalesce = 1;
 
 	mptcp_data_lock(sk);
 	DEBUG_NET_WARN_ON_ONCE(sock_owned_by_user_nocheck(sk));
 
+	msk = mptcp_sk(sk);
+	msk->rcvd_dummy_seq = true;
 	mptcp_borrow_fwdmem(sk, skb);
 	skb_set_owner_r(skb, sk);
 	__skb_queue_tail(&sk->sk_receive_queue, skb);
-	mptcp_sk(sk)->bytes_received += skb->len;
+	msk->bytes_received += skb->len;
 
 	sk->sk_data_ready(sk);
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 16b81e8dc90e..41fc2429d2fe 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -168,7 +168,6 @@ static bool __mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 	int limit = READ_ONCE(sk->sk_rcvbuf);
 
 	if (MPTCP_SKB_CB(from)->map_seq != MPTCP_SKB_CB(to)->end_seq ||
-	    unlikely(MPTCP_SKB_CB(to)->cant_coalesce) ||
 	    MPTCP_SKB_CB(from)->offset ||
 	    ((to->len + from->len) > (limit >> 3)) ||
 	    !skb_try_coalesce(to, from, fragstolen, delta))
@@ -430,7 +429,6 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
 	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + copy_len;
 	MPTCP_SKB_CB(skb)->offset = offset;
 	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
-	MPTCP_SKB_CB(skb)->cant_coalesce = 0;
 
 	__skb_unlink(skb, &ssk->sk_receive_queue);
 
@@ -438,6 +436,25 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
 	skb_dst_drop(skb);
 }
 
+void __mptcp_sync_rcv_sequence(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sk_buff *skb;
+
+	if (likely(!msk->rcvd_dummy_seq))
+		return;
+
+	/* User space can have already received the TFO skb. */
+	msk->rcvd_dummy_seq = false;
+	skb = skb_peek_tail(&sk->sk_receive_queue);
+	if (!skb)
+		return;
+
+	MPTCP_SKB_CB(skb)->map_seq = msk->tfo_iasn - skb->len +
+				     MPTCP_SKB_CB(skb)->offset;
+	MPTCP_SKB_CB(skb)->end_seq = msk->tfo_iasn;
+}
+
 static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 {
 	u64 copy_len = MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_seq;
@@ -446,6 +463,12 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 
 	mptcp_borrow_fwdmem(sk, skb);
 
+	/* Be sure to sync the eventual fastopen dummy mapping before any other
+	 * skb lands into the msk.
+	 */
+	if (unlikely(msk->rcvd_dummy_seq))
+		__mptcp_sync_rcv_sequence(sk);
+
 	if (MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq) {
 		/* in sequence */
 insert:
@@ -2377,7 +2400,13 @@ static bool mptcp_move_skbs(struct sock *sk)
 	u32 moved = 0;
 
 	mptcp_data_lock(sk);
-	while (mptcp_can_spool_backlog(sk, &skbs)) {
+	while (1) {
+		if (__test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags))
+			__mptcp_sync_rcv_sequence(sk);
+
+		if (!mptcp_can_spool_backlog(sk, &skbs))
+			break;
+
 		mptcp_data_unlock(sk);
 		enqueued |= __mptcp_move_skbs(sk, &skbs, &moved);
 
@@ -3676,6 +3705,8 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	msk->bytes_retrans = 0;
 	msk->rcvspace_init = 0;
 	msk->fastclosing = 0;
+	msk->tfo_iasn = 0;
+	msk->rcvd_dummy_seq = false;
 	mptcp_init_rtt_est(msk);
 
 	/* for fallback's sake */
@@ -3878,6 +3909,9 @@ static void mptcp_release_cb(struct sock *sk)
 		struct list_head join_list, skbs;
 		bool spool_bl;
 
+		if (__test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags))
+			__mptcp_sync_rcv_sequence(sk);
+
 		spool_bl = mptcp_can_spool_backlog(sk, &skbs);
 		if (!flags && !spool_bl)
 			break;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3be60da12924..b4e49d719200 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -126,13 +126,13 @@
 #define MPTCP_FLUSH_JOIN_LIST	5
 #define MPTCP_SYNC_STATE	6
 #define MPTCP_SYNC_SNDBUF	7
+#define MPTCP_SYNC_SEQ		8
 
 struct mptcp_skb_cb {
 	u64 map_seq;
 	u64 end_seq;
 	u32 offset;
 	u8  has_rxtstamp;
-	u8  cant_coalesce;
 };
 
 #define MPTCP_SKB_CB(__skb)	((struct mptcp_skb_cb *)&((__skb)->cb[0]))
@@ -325,6 +325,7 @@ struct mptcp_sock {
 	u32		last_ack_recv;
 	unsigned long	timer_ival;
 	u32		token;
+	u64		tfo_iasn;
 	unsigned long	flags;
 	unsigned long	cb_flags;
 	bool		recovery;		/* closing subflow write queue reinjected */
@@ -336,6 +337,7 @@ struct mptcp_sock {
 	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
 	bool		csum_enabled;
 	bool		allow_infinite_fallback;
+	bool		rcvd_dummy_seq;
 	u8		pending_state; /* A subflow asked to set this sk_state,
 					* protected by the msk data lock
 					*/
@@ -1193,6 +1195,7 @@ void mptcp_event_pm_listener(const struct sock *ssk,
 			     enum mptcp_event_type event);
 bool mptcp_userspace_pm_active(const struct mptcp_sock *msk);
 
+void __mptcp_sync_rcv_sequence(struct sock *sk);
 void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subflow,
 					      struct request_sock *req);
 int mptcp_pm_genl_fill_addr(struct sk_buff *msg,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 6f07544bfe40..f9dfb6662e3c 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -519,6 +519,8 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
 				   struct mptcp_subflow_context *subflow,
 				   const struct mptcp_options_received *mp_opt)
 {
+	struct sock *sk = (struct sock *)msk;
+
 	/* active MPC subflow will reach here multiple times:
 	 * at subflow_finish_connect() time and at 4th ack time
 	 */
@@ -537,6 +539,12 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
 	WRITE_ONCE(msk->ack_seq, subflow->iasn);
 	WRITE_ONCE(msk->can_ack, true);
 	atomic64_set(&msk->rcv_wnd_sent, subflow->iasn);
+	msk->tfo_iasn = subflow->iasn;
+
+	if (!sock_owned_by_user(sk))
+		__mptcp_sync_rcv_sequence(sk);
+	else
+		set_bit(MPTCP_SYNC_SEQ, &msk->cb_flags);
 }
 
 static void mptcp_propagate_state(struct sock *sk, struct sock *ssk,
-- 
2.55.0

