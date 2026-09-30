Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87F136680E
	for <mptcp@lists.linux.dev>; Wed, 30 Sep 2026 02:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790735139; cv=none; b=LaoAGeyNpblr8sHAG6LGe4U0qWCd06+fIMGFnFTBo7CelvUk4+VaQZmVNzaC4bUycJMczdRzSW3iZmVFHkqFKx1UPbfoMBonfV32IuXoB/ylBl7naiFC3aVG/PtAVKKRT+/kDOVUSlm3U/4M5GckeP/U5PpgRzrotbsuKqfwMuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790735139; c=relaxed/simple;
	bh=cUQEbX3DFv7WjPWFWqe3LxF+Qkn3uyRmqf3MLP0e+gE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CPxGNsZCNLban/IjZr40u24xozGEwj4E92nZbLOH2cWZ9r1MRRjN9dxeB8X3lsxW+5CU9czAOowNmiWifsuvAN6dLlo25Ap67QRzNyvyF1J709/uiFYrl/Y67W6ZkDnO3c6HVobci4aGrHmabApmEX5GA0wTpiID7376c0sEStc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVA4grf+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVA4grf+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110A51F000FF;
	Wed, 30 Sep 2026 02:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790735137;
	bh=OT1NhVM1rCW4x3rGnsb6phyZBE8ieXZ6FwbSPdYzGlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mVA4grf+hfvAEVkPwb4sMlgCTiuaLMaduPwa4nNDbBhz1hOdkgWGoLdp8hJeT+NaI
	 WGOcHGy1zo22qP32Mp/GMiiWvN2Y4eN+FM0W+wtuSwcp4/62p0aBEW51XXfCoKGwMj
	 0dM2Pu/NjXU+zIu9wOWqj2FyNg3EGtdYQSEdWMKto9XKi6yN0nDufLlDXH967HacsS
	 UbKkqL8BUu6/pNIhBlUX8ELedROln9JPWu0H4p4bxjeHE3Ll7VJSZTLyy8tSFSXcHP
	 B9CdZajxE1gZ//JEz8X28OO0Z+XPbmB8jEvNygOrxn1LebWGNZZUykn7qA7vzyDUga
	 HiDgCkt31PyIg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	pabeni@redhat.com
Cc: Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v14 02/11] mptcp: drop the cant_coalesce CB field
Date: Wed, 30 Sep 2026 10:23:36 +0800
Message-ID: <dde0b48c30a611359c56ca28a40f3f3cd498f092.1790734083.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790734083.git.tanggeliang@kylinos.cn>
References: <cover.1790734083.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

Such field is used to ensure in-sequence processing in case of fastopen.
Instead let's perform synchronization of the fastopen skb sequence
when the IASN becomes available with the 3rd ack.

When the `cant_coalesce` field has been introduced, commit f03afb3aeb9d
("mptcp: drop __mptcp_fastopen_gen_msk_ackseq()") noted that updating the
already queued skb for passive fastopen socket at 3rd ack time would be
difficult and race prone. The main point is that such update don't need
to be synchronously performed at 3rd ack time, but is sufficient to
perform it before the next segment is introduced into the msk.

To such extent, add an explicit test in __mptcp_move_skb(). Performance
wise this trades a conditional in the fast path - in __mptcp_try_coalesce()
- with a similar one in __mptcp_move_skb() and a couple more in slow paths.

After this change the user-space will always observe consistent sequence
numbers in the receive queue, even in the TFO dummy mapping case.

Also add locking in mptcp_inq_hint() to avoid races with ack_seq updates
during the fastopen sequence synchronization.

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/fastopen.c |  6 +++--
 net/mptcp/protocol.c | 57 ++++++++++++++++++++++++++++++++++++++++----
 net/mptcp/protocol.h |  4 +++-
 net/mptcp/subflow.c  | 10 ++++++++
 4 files changed, 69 insertions(+), 8 deletions(-)

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
index dcb3ba098702..1d3f29240387 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -29,7 +29,7 @@
 #include "protocol.h"
 #include "mib.h"
 
-static unsigned int mptcp_inq_hint(const struct sock *sk);
+static unsigned int mptcp_inq_hint(struct sock *sk);
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/mptcp.h>
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
 
@@ -438,6 +436,27 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
 	skb_dst_drop(skb);
 }
 
+/* Caller must hold the msk data lock */
+void __mptcp_sync_rcv_sequence(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sk_buff *skb;
+	u32 offset;
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
+	offset = MPTCP_SKB_CB(skb)->offset;
+	MPTCP_SKB_CB(skb)->map_seq = msk->ack_seq - skb->len + offset;
+	MPTCP_SKB_CB(skb)->end_seq = msk->ack_seq;
+}
+
 static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 {
 	u64 copy_len = MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_seq;
@@ -446,6 +465,19 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 
 	mptcp_borrow_fwdmem(sk, skb);
 
+	if (test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
+		/* Ensure we see the updated ack_seq after seeing the flag */
+		smp_rmb();
+
+		mptcp_data_lock(sk);
+		/* Be sure to sync the eventual fastopen dummy mapping before
+		 * any other skb lands into the msk.
+		 */
+		if (unlikely(msk->rcvd_dummy_seq))
+			__mptcp_sync_rcv_sequence(sk);
+		mptcp_data_unlock(sk);
+	}
+
 	if (MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq) {
 		/* in sequence */
 insert:
@@ -2383,15 +2415,23 @@ static bool mptcp_move_skbs(struct sock *sk)
 	return enqueued;
 }
 
-static unsigned int mptcp_inq_hint(const struct sock *sk)
+static unsigned int mptcp_inq_hint(struct sock *sk)
 {
 	const struct mptcp_sock *msk = mptcp_sk(sk);
 	const struct sk_buff *skb;
+	u64 hint_val;
 
 	skb = skb_peek(&sk->sk_receive_queue);
 	if (skb) {
-		u64 hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
+		/* Avoid races vs ack_seq updates and MPTCP_SYNC_SEQ flag. */
+		mptcp_data_lock(sk);
+		if (test_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
+			mptcp_data_unlock(sk);
+			return 0;
+		}
 
+		hint_val = msk->ack_seq - MPTCP_SKB_CB(skb)->map_seq;
+		mptcp_data_unlock(sk);
 		if (hint_val >= INT_MAX)
 			return INT_MAX;
 
@@ -3903,6 +3943,13 @@ static void mptcp_release_cb(struct sock *sk)
 			__mptcp_error_report(sk);
 		if (__test_and_clear_bit(MPTCP_SYNC_SNDBUF, &msk->cb_flags))
 			__mptcp_sync_sndbuf(sk);
+		if (test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
+			/* Ensure we see the updated ack_seq after seeing
+			 * the flag
+			 */
+			smp_rmb();
+			__mptcp_sync_rcv_sequence(sk);
+		}
 	}
 }
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4bf04f9ecbd9..cfc86d00ab2f 100644
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
@@ -327,6 +327,7 @@ struct mptcp_sock {
 	u32		token;
 	unsigned long	flags;
 	unsigned long	cb_flags;
+	bool		rcvd_dummy_seq;
 	bool		recovery;		/* closing subflow write queue reinjected */
 	bool		can_ack;
 	bool		fully_established;
@@ -1187,6 +1188,7 @@ void mptcp_event_pm_listener(const struct sock *ssk,
 			     enum mptcp_event_type event);
 bool mptcp_userspace_pm_active(const struct mptcp_sock *msk);
 
+void __mptcp_sync_rcv_sequence(struct sock *sk);
 void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subflow,
 					      struct request_sock *req);
 int mptcp_pm_genl_fill_addr(struct sk_buff *msg,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 14aa82647c3d..807f6c5bbcf8 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -480,6 +480,8 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
 				   struct mptcp_subflow_context *subflow,
 				   const struct mptcp_options_received *mp_opt)
 {
+	struct sock *sk = (struct sock *)msk;
+
 	/* active MPC subflow will reach here multiple times:
 	 * at subflow_finish_connect() time and at 4th ack time
 	 */
@@ -498,6 +500,14 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
 	WRITE_ONCE(msk->ack_seq, subflow->iasn);
 	WRITE_ONCE(msk->can_ack, true);
 	atomic64_set(&msk->rcv_wnd_sent, subflow->iasn);
+
+	if (!sock_owned_by_user(sk)) {
+		__mptcp_sync_rcv_sequence(sk);
+	} else {
+		/* Ensure ack_seq is visible before setting the flag */
+		smp_wmb();
+		set_bit(MPTCP_SYNC_SEQ, &msk->cb_flags);
+	}
 }
 
 static void mptcp_propagate_state(struct sock *sk, struct sock *ssk,
-- 
2.53.0

