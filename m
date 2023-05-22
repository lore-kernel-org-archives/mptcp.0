Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F6F1426A
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 13:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684763814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=frzZiu2GCi1zkq0JkA2nx1cq2Gwi2qjj5xfTbpeE7x4=;
	b=HUl5v25E16Y+GzDxszZTyqBSPAJqW3GDccIUZ3uhu5Gwv0LwpbbK1bpvrmI1poQwyUPbVB
	Z/USGQU6j8v0HHuK0F7Zuv2y0k8YEIXXc/MZnZ5lt3Ug7I9f5z3d+FYX5MVWONTbUJOKTr
	rb2JgCG+E1u1JZ5iYi5BKXDuvtZEcv8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-153-_qDCxhdLPJm4SlyfhtPkNQ-1; Mon, 22 May 2023 09:56:52 -0400
X-MC-Unique: _qDCxhdLPJm4SlyfhtPkNQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 893408032F5
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 13:56:52 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.191])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1865A492B0A
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 13:56:51 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 4/6] mptcp: track some aggregate data counters.
Date: Mon, 22 May 2023 15:56:30 +0200
Message-Id: <a4a971266621c3d915b10da7a24a5b38eabe34ee.1684763197.git.pabeni@redhat.com>
In-Reply-To: <cover.1684763196.git.pabeni@redhat.com>
References: <cover.1684763196.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Currently there are no data transfer counters accounting for all
the subflows used by a given MPTCP socket. The user-space can compute
such figures aggregating the subflow info, but that is inaccurate
if any subflow is closed before the MPTCP socket itself.

Add the new counters in the MPTCP socket itself and expose them
via the existing diag and sockopt. While touching mptcp_diag_fill_info(),
acquire the relevant locks before fetching the msk data, to ensure
better data consistency

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/uapi/linux/mptcp.h |  5 +++++
 net/mptcp/options.c        | 10 ++++++++--
 net/mptcp/protocol.c       | 12 +++++++++++-
 net/mptcp/protocol.h       |  4 ++++
 net/mptcp/sockopt.c        | 22 +++++++++++++++++-----
 5 files changed, 45 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 483d4d2a3646..0e12ec7e05d0 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -124,6 +124,11 @@ struct mptcp_info {
 	__u8	mptcpi_local_addr_used;
 	__u8	mptcpi_local_addr_max;
 	__u8	mptcpi_csum_enabled;
+	__u32	mptcpi_retransmits;
+	__u64	mptcpi_bytes_retrans;
+	__u64	mptcpi_bytes_sent;
+	__u64	mptcpi_bytes_received;
+	__u64	mptcpi_bytes_acked;
 };
 
 /*
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 4bdcd2b326bd..c254accb14de 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1026,6 +1026,12 @@ u64 __mptcp_expand_seq(u64 old_seq, u64 cur_seq)
 	return cur_seq;
 }
 
+static void __mptcp_snd_una_update(struct mptcp_sock *msk, u64 new_snd_una)
+{
+	msk->bytes_acked += new_snd_una - msk->snd_una;
+	msk->snd_una = new_snd_una;
+}
+
 static void ack_update_msk(struct mptcp_sock *msk,
 			   struct sock *ssk,
 			   struct mptcp_options_received *mp_opt)
@@ -1057,7 +1063,7 @@ static void ack_update_msk(struct mptcp_sock *msk,
 		__mptcp_check_push(sk, ssk);
 
 	if (after64(new_snd_una, old_snd_una)) {
-		msk->snd_una = new_snd_una;
+		__mptcp_snd_una_update(msk, new_snd_una);
 		__mptcp_data_acked(sk);
 	}
 	mptcp_data_unlock(sk);
@@ -1123,7 +1129,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 		/* on fallback we just need to ignore the msk-level snd_una, as
 		 * this is really plain TCP
 		 */
-		msk->snd_una = READ_ONCE(msk->snd_nxt);
+		__mptcp_snd_una_update(msk, READ_ONCE(msk->snd_nxt));
 
 		__mptcp_data_acked(subflow->conn);
 		mptcp_data_unlock(subflow->conn);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d93c8cdeeda7..edf26782fe2e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -378,6 +378,7 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
 
 	if (MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq) {
 		/* in sequence */
+		msk->bytes_received += copy_len;
 		WRITE_ONCE(msk->ack_seq, msk->ack_seq + copy_len);
 		tail = skb_peek_tail(&sk->sk_receive_queue);
 		if (tail && mptcp_try_coalesce(sk, tail, skb))
@@ -761,6 +762,7 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 			MPTCP_SKB_CB(skb)->map_seq += delta;
 			__skb_queue_tail(&sk->sk_receive_queue, skb);
 		}
+		msk->bytes_received += end_seq - msk->ack_seq;
 		msk->ack_seq = end_seq;
 		moved = true;
 	}
@@ -1513,8 +1515,10 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
 	 * that has been handed to the subflow for transmission
 	 * and skip update in case it was old dfrag.
 	 */
-	if (likely(after64(snd_nxt_new, msk->snd_nxt)))
+	if (likely(after64(snd_nxt_new, msk->snd_nxt))) {
+		msk->bytes_sent += snd_nxt_new - msk->snd_nxt;
 		msk->snd_nxt = snd_nxt_new;
+	}
 }
 
 void mptcp_check_and_set_pending(struct sock *sk)
@@ -2639,6 +2643,8 @@ static void __mptcp_retrans(struct sock *sk)
 			msk->last_snd = ssk;
 		}
 	}
+
+	msk->bytes_retrans += len;
 	dfrag->already_sent = max(dfrag->already_sent, len);
 
 reset_timer:
@@ -3153,6 +3159,10 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
 	mptcp_pm_data_reset(msk);
 	mptcp_ca_reset(sk);
+	msk->bytes_acked = 0;
+	msk->bytes_received = 0;
+	msk->bytes_sent = 0;
+	msk->bytes_retrans = 0;
 
 	WRITE_ONCE(sk->sk_shutdown, 0);
 	sk_error_report(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f9180ecce5e4..0283383a09f4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -261,10 +261,13 @@ struct mptcp_sock {
 	u64		local_key;
 	u64		remote_key;
 	u64		write_seq;
+	u64		bytes_sent;
 	u64		snd_nxt;
+	u64		bytes_received;
 	u64		ack_seq;
 	atomic64_t	rcv_wnd_sent;
 	u64		rcv_data_fin_seq;
+	u64		bytes_retrans;
 	int		rmem_fwd_alloc;
 	struct sock	*last_snd;
 	int		snd_burst;
@@ -273,6 +276,7 @@ struct mptcp_sock {
 						 * recovery related fields are under data_lock
 						 * protection
 						 */
+	u64		bytes_acked;
 	u64		snd_una;
 	u64		wnd_end;
 	unsigned long	timer_ival;
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index b4d04d5dc1f7..2464100ef820 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -888,7 +888,9 @@ static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 
 void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 {
+	struct sock *sk = (struct sock *)msk;
 	u32 flags = 0;
+	bool slow;
 
 	memset(info, 0, sizeof(*info));
 
@@ -914,11 +916,21 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 	if (READ_ONCE(msk->can_ack))
 		flags |= MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED;
 	info->mptcpi_flags = flags;
-	info->mptcpi_token = READ_ONCE(msk->token);
-	info->mptcpi_write_seq = READ_ONCE(msk->write_seq);
-	info->mptcpi_snd_una = READ_ONCE(msk->snd_una);
-	info->mptcpi_rcv_nxt = READ_ONCE(msk->ack_seq);
-	info->mptcpi_csum_enabled = READ_ONCE(msk->csum_enabled);
+	mptcp_data_lock(sk);
+	info->mptcpi_snd_una = msk->snd_una;
+	info->mptcpi_rcv_nxt = msk->ack_seq;
+	info->mptcpi_bytes_acked = msk->bytes_acked;
+	mptcp_data_unlock(sk);
+
+	slow = lock_sock_fast(sk);
+	info->mptcpi_csum_enabled = msk->csum_enabled;
+	info->mptcpi_token = msk->token;
+	info->mptcpi_write_seq = msk->write_seq;
+	info->mptcpi_retransmits = inet_csk(sk)->icsk_retransmits;
+	info->mptcpi_bytes_sent = msk->bytes_sent;
+	info->mptcpi_bytes_received = msk->bytes_received;
+	info->mptcpi_bytes_retrans = msk->bytes_retrans;
+	unlock_sock_fast(sk, slow);
 }
 EXPORT_SYMBOL_GPL(mptcp_diag_fill_info);
 
-- 
2.40.1

