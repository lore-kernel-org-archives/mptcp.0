Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11191CD1B
	for <mptcp@lists.linux.dev>; Tue, 16 Jan 2024 18:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705428989; cv=none; b=HHktR06uqve/2R/bOxrq9pgGAKyhmHOixLpRx6QUA+YAjmg97/L8pjfDsam5pMKJhZYT4cYXaF+mICMVG7Fdv5naCh+8a1ErTgEmbo9kH4BYp7NtyXwa7McDJ/gg8Kb6ur9lw9KFEXlLEDEpFq3EUPXH5BZ8sqB6coIDOy7aKe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705428989; c=relaxed/simple;
	bh=y+7fepVWg86hWUrppBQKM+NamxBRB/xvWHMfEJv/MJQ=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:Received:From:To:
	 Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 X-Scanned-By:X-Mimecast-Spam-Score:X-Mimecast-Originator:
	 Content-Transfer-Encoding:Content-Type; b=EReaQLJurS1x4Zr6sqkoE3fYDuHlegCjmrpYX4uGNAq//2eVCUjV52wz4Zyugha+AOeRi+YAF9PJ9wT21v/dy+b7hC5qUK5Y1KainsPdjPVLKXipoBV5xioCj42wPZrcuhBI7PcpC+iPkFuZ4r/X6GLrh4xWJMklrnS9MzFXtFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Js/CDT0V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Js/CDT0V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705428986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bub5QgJl/76M9NKFacI0j+kLeA11yHpnDb3Puq8YKE8=;
	b=Js/CDT0V2coul/7YYDLUW21kVgALuc4BKg0yWMymIIkAkVh/GBb6IfEjr/qr+8mebEkgQd
	noVc3DbA7IhziJZmA9G0r8DNwqYbrKXTM/zhE/+2YHXYiBwKVkV1zpSBFj/unnFevBfM1K
	C6fyyAWXO1o9Ggzq1cmcL+qUiMnXQMA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-l3zYHLiwORS6mGLIKcAGqw-1; Tue,
 16 Jan 2024 13:16:25 -0500
X-MC-Unique: l3zYHLiwORS6mGLIKcAGqw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD5173869141
	for <mptcp@lists.linux.dev>; Tue, 16 Jan 2024 18:16:24 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.11])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5C1431121306
	for <mptcp@lists.linux.dev>; Tue, 16 Jan 2024 18:16:24 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 3/5] mptcp: annotate lockless access for RX path fields.
Date: Tue, 16 Jan 2024 19:16:12 +0100
Message-ID: <bd0f2eb66cae1a6e6b8d0735b0a81fbaf30c2650.1705427537.git.pabeni@redhat.com>
In-Reply-To: <cover.1705427537.git.pabeni@redhat.com>
References: <cover.1705427537.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The following fields:

ack_seq
snd_una
wnd_end
rmem_fwd_alloc

are protected by the data lock end accessed lockless in a few
spots. Ensure ONCE annotation for write (under such lock) and for
lockless read.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/options.c  |  6 +++---
 net/mptcp/protocol.c | 19 +++++++++++--------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 51b00d7e7c89..23e317ffc901 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1031,7 +1031,7 @@ u64 __mptcp_expand_seq(u64 old_seq, u64 cur_seq)
 static void __mptcp_snd_una_update(struct mptcp_sock *msk, u64 new_snd_una)
 {
 	msk->bytes_acked += new_snd_una - msk->snd_una;
-	msk->snd_una = new_snd_una;
+	WRITE_ONCE(msk->snd_una, new_snd_una);
 }
 
 static void ack_update_msk(struct mptcp_sock *msk,
@@ -1058,7 +1058,7 @@ static void ack_update_msk(struct mptcp_sock *msk,
 	new_wnd_end = new_snd_una + tcp_sk(ssk)->snd_wnd;
 
 	if (after64(new_wnd_end, msk->wnd_end))
-		msk->wnd_end = new_wnd_end;
+		WRITE_ONCE(msk->wnd_end, new_wnd_end);
 
 	/* this assumes mptcp_incoming_options() is invoked after tcp_ack() */
 	if (after64(msk->wnd_end, snd_nxt))
@@ -1072,7 +1072,7 @@ static void ack_update_msk(struct mptcp_sock *msk,
 
 	trace_ack_update_msk(mp_opt->data_ack,
 			     old_snd_una, new_snd_una,
-			     new_wnd_end, msk->wnd_end);
+			     new_wnd_end, READ_ONCE(msk->wnd_end));
 }
 
 bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, u64 data_fin_seq, bool use_64bit)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 679d4576d2c1..35a5a2f54362 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -410,6 +410,7 @@ static void mptcp_close_wake_up(struct sock *sk)
 		sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_IN);
 }
 
+/* called under the msk socket lock */
 static bool mptcp_pending_data_fin_ack(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -441,16 +442,17 @@ static void mptcp_check_data_fin_ack(struct sock *sk)
 	}
 }
 
+/* can be called with no lock acquired */
 static bool mptcp_pending_data_fin(struct sock *sk, u64 *seq)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
 	if (READ_ONCE(msk->rcv_data_fin) &&
-	    ((1 << sk->sk_state) &
+	    ((1 << inet_sk_state_load(sk)) &
 	     (TCPF_ESTABLISHED | TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2))) {
 		u64 rcv_data_fin_seq = READ_ONCE(msk->rcv_data_fin_seq);
 
-		if (msk->ack_seq == rcv_data_fin_seq) {
+		if (READ_ONCE(msk->ack_seq) == rcv_data_fin_seq) {
 			if (seq)
 				*seq = rcv_data_fin_seq;
 
@@ -748,7 +750,7 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 			__skb_queue_tail(&sk->sk_receive_queue, skb);
 		}
 		msk->bytes_received += end_seq - msk->ack_seq;
-		msk->ack_seq = end_seq;
+		WRITE_ONCE(msk->ack_seq, end_seq);
 		moved = true;
 	}
 	return moved;
@@ -985,6 +987,7 @@ static void dfrag_clear(struct sock *sk, struct mptcp_data_frag *dfrag)
 	put_page(dfrag->page);
 }
 
+/* called under both the msk socket lock and the data lock */
 static void __mptcp_clean_una(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -2115,7 +2118,7 @@ static unsigned int mptcp_inq_hint(const struct sock *sk)
 
 	skb = skb_peek(&msk->receive_queue);
 	if (skb) {
-		u64 hint_val = msk->ack_seq - MPTCP_SKB_CB(skb)->map_seq;
+		u64 hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
 
 		if (hint_val >= INT_MAX)
 			return INT_MAX;
@@ -2762,7 +2765,7 @@ static void __mptcp_init_sock(struct sock *sk)
 	__skb_queue_head_init(&msk->receive_queue);
 	msk->out_of_order_queue = RB_ROOT;
 	msk->first_pending = NULL;
-	msk->rmem_fwd_alloc = 0;
+	WRITE_ONCE(msk->rmem_fwd_alloc, 0);
 	WRITE_ONCE(msk->rmem_released, 0);
 	msk->timer_ival = TCP_RTO_MIN;
 	msk->scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
@@ -2978,7 +2981,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 
 	sk->sk_prot->destroy(sk);
 
-	WARN_ON_ONCE(msk->rmem_fwd_alloc);
+	WARN_ON_ONCE(READ_ONCE(msk->rmem_fwd_alloc));
 	WARN_ON_ONCE(msk->rmem_released);
 	sk_stream_kill_queues(sk);
 	xfrm_sk_free_policy(sk);
@@ -3213,8 +3216,8 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 
 	WRITE_ONCE(msk->write_seq, subflow_req->idsn + 1);
 	WRITE_ONCE(msk->snd_nxt, msk->write_seq);
-	msk->snd_una = msk->write_seq;
-	msk->wnd_end = msk->snd_nxt + req->rsk_rcv_wnd;
+	WRITE_ONCE(msk->snd_una, msk->write_seq);
+	WRITE_ONCE(msk->wnd_end, msk->snd_nxt + req->rsk_rcv_wnd);
 	msk->setsockopt_seq = mptcp_sk(sk)->setsockopt_seq;
 	mptcp_init_sched(msk, mptcp_sk(sk)->sched);
 
-- 
2.43.0

