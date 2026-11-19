Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795065048;
	b=UaP6AHd254LZ7gosXn2P1r5Cgu1jFvThthz5pNoNGuSqVz6yKuYQkhMV3Kel7ucXHxKQ
	 D27EICr18LDqBGFUT+EWY1p/BRbNY8nZAN4MpX8nlcuts+reeMlC0gClrLbBDFhoJjSwU
	 IXACBNhXiV3hIw6llHg1/0V3zrJvnmH0W0vHFdDANq2Pdre9LGaEdRg8Pkr4w2cJJ3hlE
	 MeN1iPAESb5DW+YgITqUzQpS7CeqXAUmJYVeIM+fxsHyXtyDpDtC48ej53D3sAsjb72xT
	 f9l9PPdhVkZz60gtYrj+CFctyRG/yDv1Ht6rkACnf5DXUsYFrjEkWjt0gKOEysJp/PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795065048;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=336irn6sLSYJ78bfcfdsItY2oD4ov91vRce4DfWay1s=;
	b=JevohL3YZowFcAMvhS7XD19FhmgYmBfbqUWTbNIaFQ9lB5JKx/edSiz9L9ma5Zg91nPl
	 QI67t6fMK2Q8E8yWZ4zEl2rUZyqZtvT4L/G0B/unaWwi0Mm0SiYAZWP6RAzuqRuKxva8L
	 2R5dEzya758bG00o2mMIF6/PTO291/B1R0AmRBVNRXOaAIwARwoTN0GREKH4Khk/QEVuL
	 5GNI/3GVNDFd7hGNlJBb7mh8Kd6t/mFRvy6c3FfRSqScStnIYw5ArQ7ZwFJAtZjMnIUMa
	 zVa7oA/zkU8epctOzvKryYy5TxqPhR1TSHPB3BX4yWptG7bxdF9fVAshnr/yBTCmtOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kpnjmAkN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21F9606A320
	for <mptcp@lists.linux.dev>; Thu, 19 Nov 2026 05:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kpnjmAkN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7AA01F000CC
	for <mptcp@lists.linux.dev>; Thu, 19 Nov 2026 05:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795065047;
	bh=336irn6sLSYJ78bfcfdsItY2oD4ov91vRce4DfWay1s=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=kpnjmAkNnScS08SzMMrRjMkuboumac4FzVaq4LLCA33NBnirqQWOzkOHmS4/+eWQ2
	 N6sf9Qf2TEnOp2r4xcJ86AO+KSAl3qws5/48Ri8IHgKyweeYxh9KADzyqmXpu3fRsc
	 f5FDNB7diMvH8TiF/eYCVZSomxNIntdkczk43LKeMsPkvksNvkNc0NXmCUsICbdjS3
	 nA1zDO0u1Uz5kQnyfN493KBZ/5R+AracXjlMzoZluW+A2J7Y1Hllx4CQislV5TNMRD
	 17UOen4OWQS92fHuf3lI7GhOO7bL6On5hjq/Ozjq4qJY2acGFGPBxOy+1KHKKXD4SY
	 x5Xbp3mEY3lpw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v29 4/8] mptcp: drop the cant_coalesce CB field
Date: Thu, 19 Nov 2026 13:10:30 +0800
Message-ID: <d93502137d925de91e85c9b4c41ef492f70aa7e9.1795063943.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795063943.git.tanggeliang@kylinos.cn>
References: <cover.1795063943.git.tanggeliang@kylinos.cn>
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
index 485520a7f377..6548f8c703d6 100644
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
 
@@ -3677,6 +3706,8 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	msk->bytes_retrans = 0;
 	msk->rcvspace_init = 0;
 	msk->fastclosing = 0;
+	msk->tfo_iasn = 0;
+	msk->rcvd_dummy_seq = false;
 	mptcp_init_rtt_est(msk);
 
 	/* for fallback's sake */
@@ -3879,6 +3910,9 @@ static void mptcp_release_cb(struct sock *sk)
 		struct list_head join_list, skbs;
 		bool spool_bl;
 
+		if (__test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags))
+			__mptcp_sync_rcv_sequence(sk);
+
 		spool_bl = mptcp_can_spool_backlog(sk, &skbs);
 		if (!flags && !spool_bl)
 			break;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6dc9ccf7ec7f..ee07f17eecd5 100644
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
index 6f07544bfe40..8f64a9aef2c1 100644
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
+		__set_bit(MPTCP_SYNC_SEQ, &msk->cb_flags);
 }
 
 static void mptcp_propagate_state(struct sock *sk, struct sock *ssk,
-- 
2.55.0

