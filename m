Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C903F382397
	for <mptcp@lists.linux.dev>; Fri, 21 Aug 2026 07:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787295914; cv=none; b=QgUtvhxyG7zddoRQJbPsZ48rDdE7W5+WJO5E1xeI0SRfYVx1bQAukZjOZjdwkvZEIjiyncZSAVdEHy2v8oiZWJa86xql5f89nyhoNqmQpMzP3LbzSxtjH6oj2VlSN9M6RzADEGWtSJVw0XZNlD62yEHo5up3E657LuxHRdv0oQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787295914; c=relaxed/simple;
	bh=FF9t7DvzA3YGwxttEkHzInvaq7R7OsEOQDMNyydOYVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uDcb+JRF08/+BXSO8DyQGm0dn61AO593f9KczNdYodnlTwHC0SHkQm9Ykl6hb7zpRKoh3A3LLtjyT3lTLcmoWFbJYk9o3GFIjZJyyNC7CQhRxWTXrbYsbWyycokBwV4ZJKD6FwD3TOFwpQPJMUCmHEtXehvkD6hAyahjTc5URZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqHnus3H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqHnus3H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C231F00A3D;
	Fri, 21 Aug 2026 07:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787295910;
	bh=VeiqD9yCPC4NEg8Kf8reIo4b5sVsKflBDvRyQ62EGuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nqHnus3HCjyPu/zFpBD1+vaIkKdZvx7849Wqb62DgTY/P5eTqwu14VuGzf5B05XhY
	 7KHzgdZe9sKAvJgCOrQZv9i/QWKGAJchSRcEdGKqWJzxFDdealgp6dB7CfF8b7gSUI
	 hUHkXRpJGI4BFltwtKMITTVMU2h26An5KYGWIUtOFFc1kWcFRbOWOAP2H0XN9R4N19
	 O7Y9AS+uTTuBNjpwTBRcV1yZ6Pl5IP0ZZ1+ScCBw6S7DhEE9f3lDQdOylzTUegSLFO
	 SLKdeOYuCuZwlXdmRjQg7pJMs//naIbEa9k5UX501CtHrs7fGrpNPxLdV4U2qd4D2X
	 fLykIJq4/aBlQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v4 2/7] mptcp: drop the cant_coalesce CB field
Date: Fri, 21 Aug 2026 15:04:23 +0800
Message-ID: <02044fca8ba48c6db2c8ecd5ca9af60706b6241c.1787295147.git.tanggeliang@kylinos.cn>
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

There is still a potential race in mptcp_inq_hint() that will be addressed
by a later patch in the series.

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/fastopen.c |  2 +-
 net/mptcp/protocol.c | 30 ++++++++++++++++++++++++++++--
 net/mptcp/protocol.h |  4 +++-
 net/mptcp/subflow.c  |  7 +++++++
 4 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index f717750906ff..d6895c2200cc 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -49,11 +49,11 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 	MPTCP_SKB_CB(skb)->end_seq = 0;
 	MPTCP_SKB_CB(skb)->offset = 0;
 	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
-	MPTCP_SKB_CB(skb)->cant_coalesce = 1;
 
 	mptcp_data_lock(sk);
 	DEBUG_NET_WARN_ON_ONCE(sock_owned_by_user_nocheck(sk));
 
+	mptcp_sk(sk)->rcvd_dummy_seq = true;
 	mptcp_borrow_fwdmem(sk, skb);
 	skb_set_owner_r(skb, sk);
 	__skb_queue_tail(&sk->sk_receive_queue, skb);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7421b44934f0..7944ee0f93b1 100644
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
 
@@ -438,6 +436,26 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
 	skb_dst_drop(skb);
 }
 
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
@@ -446,6 +464,12 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 
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
@@ -3895,6 +3919,8 @@ static void mptcp_release_cb(struct sock *sk)
 			__mptcp_error_report(sk);
 		if (__test_and_clear_bit(MPTCP_SYNC_SNDBUF, &msk->cb_flags))
 			__mptcp_sync_sndbuf(sk);
+		if (test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags))
+			__mptcp_sync_rcv_sequence(sk);
 	}
 }
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3d250e8204d5..0b20cacf56a8 100644
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
@@ -313,6 +313,7 @@ struct mptcp_sock {
 	u32		token;
 	unsigned long	flags;
 	unsigned long	cb_flags;
+	bool		rcvd_dummy_seq;
 	bool		recovery;		/* closing subflow write queue reinjected */
 	bool		can_ack;
 	bool		fully_established;
@@ -1172,6 +1173,7 @@ void mptcp_event_pm_listener(const struct sock *ssk,
 			     enum mptcp_event_type event);
 bool mptcp_userspace_pm_active(const struct mptcp_sock *msk);
 
+void __mptcp_sync_rcv_sequence(struct sock *sk);
 void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subflow,
 					      struct request_sock *req);
 int mptcp_pm_genl_fill_addr(struct sk_buff *msg,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 2d7ccb01d234..7e3ff0fb08b1 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -476,6 +476,8 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
 				   struct mptcp_subflow_context *subflow,
 				   const struct mptcp_options_received *mp_opt)
 {
+	struct sock *sk = (struct sock *)msk;
+
 	/* active MPC subflow will reach here multiple times:
 	 * at subflow_finish_connect() time and at 4th ack time
 	 */
@@ -494,6 +496,11 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
 	WRITE_ONCE(msk->ack_seq, subflow->iasn);
 	WRITE_ONCE(msk->can_ack, true);
 	atomic64_set(&msk->rcv_wnd_sent, subflow->iasn);
+
+	if (!sock_owned_by_user(sk))
+		__mptcp_sync_rcv_sequence(sk);
+	else
+		set_bit(MPTCP_SYNC_SEQ, &msk->cb_flags);
 }
 
 static void mptcp_propagate_state(struct sock *sk, struct sock *ssk,
-- 
2.53.0

