Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BDB309EFF
	for <mptcp@lists.linux.dev>; Sun, 10 May 2026 21:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778447054; cv=none; b=l532Qzic3s26OtleooLrxon4mNFe5xEzCWvy9dxn24Tv7kin7svWNEqLCnDPUgRbt34dJRDm2SOiKtyepjNn1b5K58W3LOA30pypSj06KWNtgBjgDRPYPBBExvDSRJiyQTUAr4SrP3S2G2mOiWy6vxo4J05LVbYGrpfwSw8pyo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778447054; c=relaxed/simple;
	bh=Ml5BLMtyJK2LiUcowBDl8ihobjZmA32EQafBiIyVVNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=TeqReF1ZdQWk6W0iVQKRNxk4KFBEl1zzXM2reHAr1w6TtLyj+nQMDsiFkjPFbXr6cF1UOUnqPvIZK7USvWPmHdo73A8ovXHDz+Yc7zlaUyvxKuvEJDXay4RPrsAR+lG4fp/yOuW7Kkr6E30Jb4Qh4/rBIhWklNkykT5PUOaitpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YBA3vHUd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YBA3vHUd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778447052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8AixwgeFqOhxu0pDnr2fatbuYiYL1k0AK6GHQS5GuNY=;
	b=YBA3vHUdxBjkPbHFsyUTfOeopEp4q0zp1RuuJ121XqBzuay1HitibW0ulYQt8xDITRf86/
	eTtOyvpqdnGIOK/MbEeZHhXdvW6vBC2BnQ2VvGirWCpcpYTsmj9NW5JrHepDJylKUlxRwQ
	zyMtXTpe9h1SUP5nMzxJx3PTkhuIJ+g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-2TImg1-FOQqcRKDT2yrNyw-1; Sun,
 10 May 2026 17:04:09 -0400
X-MC-Unique: 2TImg1-FOQqcRKDT2yrNyw-1
X-Mimecast-MFC-AGG-ID: 2TImg1-FOQqcRKDT2yrNyw_1778447048
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E25219560AA;
	Sun, 10 May 2026 21:04:08 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.4])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6EA11180034E;
	Sun, 10 May 2026 21:04:07 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH mptcp-next v5 05/12] mptcp: drop the cant_coalesce CB field
Date: Sun, 10 May 2026 23:03:40 +0200
Message-ID: <0456a5eb7187828dc64282a98d3c78e197b5595f.1778446731.git.pabeni@redhat.com>
In-Reply-To: <cover.1778446731.git.pabeni@redhat.com>
References: <cover.1778446731.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TVoUd13mfsgFqnFOQcjR7J7xwUtETEnN6teKBO5HqGM_1778447048
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

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

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/fastopen.c |  2 +-
 net/mptcp/protocol.c | 28 ++++++++++++++++++++++++++--
 net/mptcp/protocol.h |  4 +++-
 net/mptcp/subflow.c  |  7 +++++++
 4 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index 082c46c0f50e..c7d5bee8088e 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -48,11 +48,11 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
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
index 479e653ddc0d..6909586a3090 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -160,7 +160,6 @@ static bool __mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 	int limit = READ_ONCE(sk->sk_rcvbuf);
 
 	if (MPTCP_SKB_CB(from)->map_seq != MPTCP_SKB_CB(to)->end_seq ||
-	    unlikely(MPTCP_SKB_CB(to)->cant_coalesce) ||
 	    MPTCP_SKB_CB(from)->offset ||
 	    ((to->len + from->len) > (limit >> 3)) ||
 	    !skb_try_coalesce(to, from, fragstolen, delta))
@@ -357,7 +356,6 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
 	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + copy_len;
 	MPTCP_SKB_CB(skb)->offset = offset;
 	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
-	MPTCP_SKB_CB(skb)->cant_coalesce = 0;
 
 	__skb_unlink(skb, &ssk->sk_receive_queue);
 
@@ -365,6 +363,24 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
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
+	MPTCP_SKB_CB(skb)->map_seq = msk->ack_seq - skb->len;
+	MPTCP_SKB_CB(skb)->end_seq = msk->ack_seq;
+}
+
 static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 {
 	u64 copy_len = MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_seq;
@@ -373,6 +389,12 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 
 	mptcp_borrow_fwdmem(sk, skb);
 
+	/* Be sure to sync the eventual fastopen dummy mapping before any other
+	 * skb lands into the msk.
+	 */
+	if (unlikely(msk->rcvd_dummy_seq))
+		__mptcp_sync_rcv_sequence(sk);
+
 	/* Can't drop packets for fallback socket this late, or the stream
 	 * will break.
 	 */
@@ -3707,6 +3729,8 @@ static void mptcp_release_cb(struct sock *sk)
 			__mptcp_error_report(sk);
 		if (__test_and_clear_bit(MPTCP_SYNC_SNDBUF, &msk->cb_flags))
 			__mptcp_sync_sndbuf(sk);
+		if (__test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags))
+			__mptcp_sync_rcv_sequence(sk);
 	}
 }
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 661600f8b573..16a1f4531dad 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -124,13 +124,13 @@
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
@@ -310,6 +310,7 @@ struct mptcp_sock {
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
index d562e149606f..5f371bf773f8 100644
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
@@ -496,6 +498,11 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
 	WRITE_ONCE(msk->ack_seq, subflow->iasn);
 	WRITE_ONCE(msk->can_ack, true);
 	atomic64_set(&msk->rcv_wnd_sent, subflow->iasn);
+
+	if (!sock_owned_by_user(sk))
+		__mptcp_sync_rcv_sequence(sk);
+	else
+		__set_bit(MPTCP_SYNC_SEQ, &msk->cb_flags);
 }
 
 static void mptcp_propagate_state(struct sock *sk, struct sock *ssk,
-- 
2.54.0

