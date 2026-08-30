Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1FD3B8939
	for <mptcp@lists.linux.dev>; Sun, 30 Aug 2026 14:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788100386; cv=none; b=riktXD2fdl464/cl5ZkpiRUYpzMX6WUUNf/L0fjeFId5rg5F3kqzSwcj3P84yuUqapaKUNJ5GynVe5zprRYgSLT6RMGVtF01jhfhp6nG1qTJ93sOFAbcfBwxLeyXvyCLeeCk45yXUt1LtA1EvEVuuerQUpT9Bi2HaPqbnphVRWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788100386; c=relaxed/simple;
	bh=urginTObowodeRcGuqJIKGV3OPBIQ4aM/62x22g6DDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tK37GSGif4erIUK0VGt9w4vBklt55nuG39Mx0tOngG1FSMLxY0i6UVcKAof82RW4piZ89X68i7LyOAnws9hfHiKh4WHvvB/gEod/HE5rz6AsAJHIoA37FlGKh+6p3F0Z5HKCPi9YgftIolsYyq8eaG0eX/g1wQz/piBJs2HlnVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqKJXZTo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqKJXZTo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B481F000E9;
	Sun, 30 Aug 2026 14:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788100383;
	bh=qqhopj+5NVN/xe4XHZ+60k4SK4btVhiAwL+vq+Lg3KQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AqKJXZTowlo+7ePLrr2h+28/FMOGgQSwyjxtEwf76nnDux5CV87MoI+pJfx4RxQVz
	 8EcMXUDShxm79YkzI4DgTg4a56sHhQXrjCEbLpw4Miu70UX1VJpRTv6PNvSIg1IiMm
	 33Ld1eERIzb3TsTDbZ4bUNG46pBpHVL0mgEd0vQLKuQiswBMiXCQC1EUZZgMxX92uS
	 oZAdZZq6rxeWeAIdf3Lc2qv6cH5Er01WZXLbAirdNmCofzrMU1FANRV3xSif2SAVxp
	 7bpcIV6nAm/INpjxZzQ4cros0jNHaB9Ow/MPzjH5RaBbseJJ6bclEPa2hG69BCBaFI
	 5gV96fE0u2CPA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v11 02/10] mptcp: drop the cant_coalesce CB field
Date: Sun, 30 Aug 2026 22:32:45 +0800
Message-ID: <9c4207364112c74aa95d31c3a207700945d684e1.1788099847.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788099847.git.tanggeliang@kylinos.cn>
References: <cover.1788099847.git.tanggeliang@kylinos.cn>
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
 net/mptcp/fastopen.c |  6 ++++--
 net/mptcp/protocol.c | 40 ++++++++++++++++++++++++++++++++++++++--
 net/mptcp/protocol.h |  4 +++-
 net/mptcp/subflow.c  | 10 ++++++++++
 4 files changed, 55 insertions(+), 5 deletions(-)

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
index eeb6fa247fbe..834bf540117b 100644
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
@@ -446,6 +464,17 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 
 	mptcp_borrow_fwdmem(sk, skb);
 
+	if (test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
+		/* Ensure we see the updated ack_seq after seeing the flag */
+		smp_rmb();
+
+		/* Be sure to sync the eventual fastopen dummy mapping before
+		 * any other skb lands into the msk.
+		 */
+		if (unlikely(msk->rcvd_dummy_seq))
+			__mptcp_sync_rcv_sequence(sk);
+	}
+
 	if (MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq) {
 		/* in sequence */
 insert:
@@ -3901,6 +3930,13 @@ static void mptcp_release_cb(struct sock *sk)
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
index 482d4a549881..767021ac65a9 100644
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
index 2d7ccb01d234..ed3a48cf9c97 100644
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
@@ -494,6 +496,14 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
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

