Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E22420484
	for <mptcp@lists.linux.dev>; Thu, 27 Aug 2026 10:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787828274; cv=none; b=mdz+pi+mYW0uHgsckI6I8r2MnCfDzakHUKcUWrB6wrRXJ6/DeJnBIhKTVqQgJCucq0fRTRv54r/Sl++oGJPOE1oyDcuzcfwIoquvmqN7MJ/1vKjPlH8Mk7UnaovpK/6Hkp2Higrg0VUX4oLWhD965LMrYCWWXPGrlYNkRtgqG4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787828274; c=relaxed/simple;
	bh=s2E9CElz3DwGnrCeq956/eeaDlXNeQ7sjpmqtxtG1w8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P4aAYV/+YJMD0hrMQgSUtdXIBmT7X1pHyKGtWgqQTaLuFuOWW5rkmG9O8245KKuzt5vNB2e2RrIKlYDoDZjkFx16v+Eos+FL5Eg9PQTHTwWMLpK/rxfuVdxXN4ye33rHxXKxEVt4Tj7PZM8Su5KaUMFIXSTzF4n4Pm8Px/0c9Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MR7HrHja; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MR7HrHja"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2281F000E9;
	Thu, 27 Aug 2026 10:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787828272;
	bh=njQ0DkGGt1ENAJGJ20ZRcFTW50PxNCQ8kmEeB2XQENk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MR7HrHjaqbEXgwsMk6KJWISVClFtTBgtiCdtHIMabbBl9ZqTrWvk1aA1AAakEwVp/
	 h90UXTTMOBzpiWhrGEY3lzG9Ta4KymAXZx+ksQTcIaXKPQNNmuamNjV48QyTO7Onzb
	 lnQhKzIYaKE2YTw533t0TRmZ3VDZ+0LsoUbjiikjedJx5M27pfCXdi5KF9ELYHa6h1
	 2eW+SFSkwleaVtX3hRchFd2IkrkO/mzkarRicqI5pAQorqGOXDoCirWY4knRvRaTFJ
	 QaphTB9KPGLWSA67Bn43eHBOPkE7j5iX9YmadMFWKYpy/4wmuU/jkxaHCBffifCksj
	 mrysLqGu/u9sg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v9 03/11] mptcp: drop the cant_coalesce CB field
Date: Thu, 27 Aug 2026 18:57:27 +0800
Message-ID: <244b45259a9c7f22e16fd95997d540340ec45a31.1787827525.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1787827525.git.tanggeliang@kylinos.cn>
References: <cover.1787827525.git.tanggeliang@kylinos.cn>
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
 net/mptcp/protocol.c | 37 +++++++++++++++++++++++++++++++++++--
 net/mptcp/protocol.h |  4 +++-
 net/mptcp/subflow.c  | 10 ++++++++++
 4 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index 0012690a2202..e72fb982614a 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -50,12 +50,12 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 	MPTCP_SKB_CB(skb)->end_seq = 0;
 	MPTCP_SKB_CB(skb)->offset = 0;
 	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
-	MPTCP_SKB_CB(skb)->cant_coalesce = 1;
 
 	mptcp_data_lock(sk);
 	DEBUG_NET_WARN_ON_ONCE(sock_owned_by_user_nocheck(sk));
 
 	msk = mptcp_sk(sk);
+	msk->rcvd_dummy_seq = true;
 	mptcp_borrow_fwdmem(sk, skb);
 	skb_set_owner_r(skb, sk);
 	__skb_queue_tail(&sk->sk_receive_queue, skb);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 39371a16b8bf..7d1422518aad 100644
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
 
@@ -438,6 +436,28 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
 	skb_dst_drop(skb);
 }
 
+void __mptcp_sync_rcv_sequence(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sk_buff *skb;
+	u64 ack_seq;
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
+	ack_seq = atomic64_read(&msk->ack_seq);
+	offset = MPTCP_SKB_CB(skb)->offset;
+	MPTCP_SKB_CB(skb)->map_seq = ack_seq - skb->len + offset;
+	MPTCP_SKB_CB(skb)->end_seq = ack_seq;
+}
+
 static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 {
 	u64 copy_len = MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_seq;
@@ -447,6 +467,12 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 
 	mptcp_borrow_fwdmem(sk, skb);
 
+	/* Be sure to sync the eventual fastopen dummy mapping before any other
+	 * skb lands into the msk.
+	 */
+	if (unlikely(msk->rcvd_dummy_seq))
+		__mptcp_sync_rcv_sequence(sk);
+
 	ack_seq = atomic64_read(&msk->ack_seq);
 	if (MPTCP_SKB_CB(skb)->map_seq == ack_seq) {
 		/* in sequence */
@@ -3914,6 +3940,13 @@ static void mptcp_release_cb(struct sock *sk)
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
index 29405d045291..839b1a36fc60 100644
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
@@ -1174,6 +1175,7 @@ void mptcp_event_pm_listener(const struct sock *ssk,
 			     enum mptcp_event_type event);
 bool mptcp_userspace_pm_active(const struct mptcp_sock *msk);
 
+void __mptcp_sync_rcv_sequence(struct sock *sk);
 void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subflow,
 					      struct request_sock *req);
 int mptcp_pm_genl_fill_addr(struct sk_buff *msg,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8dc200d8d072..a6f231c6b4bf 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -478,6 +478,8 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
 				   struct mptcp_subflow_context *subflow,
 				   const struct mptcp_options_received *mp_opt)
 {
+	struct sock *sk = (struct sock *)msk;
+
 	/* active MPC subflow will reach here multiple times:
 	 * at subflow_finish_connect() time and at 4th ack time
 	 */
@@ -496,6 +498,14 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
 	atomic64_set(&msk->ack_seq, subflow->iasn);
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

