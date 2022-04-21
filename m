Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95C31FBE
	for <mptcp@lists.linux.dev>; Thu, 21 Apr 2022 14:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1650550841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HysrGFLfwusrd53mt5VTm/xDXivI7TUWaCPA66/u1M4=;
	b=S0rFywG8+/WyU4vw8uVpplFK540nPlePW5J+RYJDQZs1su01KDbE6+4hO95s8/sZTNMaHE
	cZfNOt8wXn5BiEaygE9nXairemEkiwORYxQ1ndilK2Dr1HDcTdPvt//rOJoiCfK7xPYAsj
	SGue8WF8nnSJo6j9qOFfInAbv8ZPz3U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-166-F8vCFtOjOAWqihLSbPMMMg-1; Thu, 21 Apr 2022 10:20:40 -0400
X-MC-Unique: F8vCFtOjOAWqihLSbPMMMg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 25BDE18A6581
	for <mptcp@lists.linux.dev>; Thu, 21 Apr 2022 14:20:40 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.32.181.152])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CB89414A4F86
	for <mptcp@lists.linux.dev>; Thu, 21 Apr 2022 14:20:39 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 4/5] mptcp: never shrink offered window
Date: Thu, 21 Apr 2022 16:20:18 +0200
Message-Id: <ef40c18f55a966ad3d3c68307a543df2a8424a94.1650550242.git.pabeni@redhat.com>
In-Reply-To: <cover.1650550242.git.pabeni@redhat.com>
References: <cover.1650550242.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

As per RFC, the offered MPTCP-level window should never shrink.
While we currently track the right edge, we don't enforce the
above constraint on the wire.
Additionally, concurrent xmit on different subflows can end-up in
erroneous right edge update.
Address the above explicitly updating the announced window and
protecting the update with an additional atomic operation (sic)

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 v1 -> v2:
 - convert rcv_wnd_sent to atomic64: cmpxchg64 is not supported by
   every arch, while atomic64_t has no such issue

RFC -> v1:
 - rebased on previous patch
---
 net/mptcp/options.c  | 52 ++++++++++++++++++++++++++++++++++++++------
 net/mptcp/protocol.c |  8 +++----
 net/mptcp/protocol.h |  2 +-
 3 files changed, 50 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 2570911735ab..df58130da4dc 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1224,20 +1224,58 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 	return true;
 }
 
-static void mptcp_set_rwin(const struct tcp_sock *tp)
+static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
 {
 	const struct sock *ssk = (const struct sock *)tp;
-	const struct mptcp_subflow_context *subflow;
+	struct mptcp_subflow_context *subflow;
+	u64 ack_seq, rcv_wnd_old, rcv_wnd_new;
 	struct mptcp_sock *msk;
-	u64 ack_seq;
+	u32 new_win;
+	u64 win;
 
 	subflow = mptcp_subflow_ctx(ssk);
 	msk = mptcp_sk(subflow->conn);
 
-	ack_seq = READ_ONCE(msk->ack_seq) + tp->rcv_wnd;
+	ack_seq = READ_ONCE(msk->ack_seq);
+	rcv_wnd_new = ack_seq + tp->rcv_wnd;
+
+	rcv_wnd_old = atomic64_read(&msk->rcv_wnd_sent);
+	if (after64(rcv_wnd_new, rcv_wnd_old)) {
+		u64 rcv_wnd;
+
+		for (;;) {
+			rcv_wnd = atomic64_cmpxchg(&msk->rcv_wnd_sent, rcv_wnd_old, rcv_wnd_new);
+
+			if (rcv_wnd == rcv_wnd_old)
+				break;
+			if (before64(rcv_wnd_new, rcv_wnd))
+				goto raise_win;
+			rcv_wnd_old = rcv_wnd;
+		};
+		return;
+	}
+
+	if (rcv_wnd_new != rcv_wnd_old) {
+raise_win:
+		win = rcv_wnd_old - ack_seq;
+		tp->rcv_wnd = min_t(u64, win, U32_MAX);
+		new_win = tp->rcv_wnd;
 
-	if (after64(ack_seq, READ_ONCE(msk->rcv_wnd_sent)))
-		WRITE_ONCE(msk->rcv_wnd_sent, ack_seq);
+		/* Make sure we do not exceed the maximum possible
+		 * scaled window.
+		 */
+		if (unlikely(th->syn))
+			new_win = min(new_win, 65535U) << tp->rx_opt.rcv_wscale;
+		if (!tp->rx_opt.rcv_wscale &&
+		    sock_net(ssk)->ipv4.sysctl_tcp_workaround_signed_windows)
+			new_win = min(new_win, MAX_TCP_WINDOW);
+		else
+			new_win = min(new_win, (65535U << tp->rx_opt.rcv_wscale));
+
+		/* RFC1323 scaling applied */
+		new_win >>= tp->rx_opt.rcv_wscale;
+		th->window = htons(new_win);
+	}
 }
 
 u16 __mptcp_make_csum(u64 data_seq, u32 subflow_seq, u16 data_len, __wsum sum)
@@ -1554,7 +1592,7 @@ void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
 	}
 
 	if (tp)
-		mptcp_set_rwin(tp);
+		mptcp_set_rwin(tp, th);
 }
 
 __be32 mptcp_get_reset_option(const struct sk_buff *skb)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 098f8f7d6366..653757ea0aca 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -216,7 +216,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 
 	seq = MPTCP_SKB_CB(skb)->map_seq;
 	end_seq = MPTCP_SKB_CB(skb)->end_seq;
-	max_seq = READ_ONCE(msk->rcv_wnd_sent);
+	max_seq = atomic64_read(&msk->rcv_wnd_sent);
 
 	pr_debug("msk=%p seq=%llx limit=%llx empty=%d", msk, seq, max_seq,
 		 RB_EMPTY_ROOT(&msk->out_of_order_queue));
@@ -225,7 +225,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 		mptcp_drop(sk, skb);
 		pr_debug("oow by %lld, rcv_wnd_sent %llu\n",
 			 (unsigned long long)end_seq - (unsigned long)max_seq,
-			 (unsigned long long)msk->rcv_wnd_sent);
+			 (unsigned long long)atomic64_read(&msk->rcv_wnd_sent));
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_NODSSWINDOW);
 		return;
 	}
@@ -3008,7 +3008,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 		mptcp_crypto_key_sha(msk->remote_key, NULL, &ack_seq);
 		ack_seq++;
 		WRITE_ONCE(msk->ack_seq, ack_seq);
-		WRITE_ONCE(msk->rcv_wnd_sent, ack_seq);
+		atomic64_set(&msk->rcv_wnd_sent, ack_seq);
 	}
 
 #if !IS_ENABLED(CONFIG_KASAN)
@@ -3303,9 +3303,9 @@ void mptcp_finish_connect(struct sock *ssk)
 	WRITE_ONCE(msk->write_seq, subflow->idsn + 1);
 	WRITE_ONCE(msk->snd_nxt, msk->write_seq);
 	WRITE_ONCE(msk->ack_seq, ack_seq);
-	WRITE_ONCE(msk->rcv_wnd_sent, ack_seq);
 	WRITE_ONCE(msk->can_ack, 1);
 	WRITE_ONCE(msk->snd_una, msk->write_seq);
+	atomic64_set(&msk->rcv_wnd_sent, ack_seq);
 
 	mptcp_pm_new_connection(msk, ssk, 0);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f542aeaa5b09..4672901d0dfe 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -257,7 +257,7 @@ struct mptcp_sock {
 	u64		write_seq;
 	u64		snd_nxt;
 	u64		ack_seq;
-	u64		rcv_wnd_sent;
+	atomic64_t	rcv_wnd_sent;
 	u64		rcv_data_fin_seq;
 	int		rmem_fwd_alloc;
 	struct sock	*last_snd;
-- 
2.35.1

