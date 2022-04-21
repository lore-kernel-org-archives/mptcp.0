Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5071F1FBE
	for <mptcp@lists.linux.dev>; Thu, 21 Apr 2022 14:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1650550840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/+PlDzX3BInqcc0tHCS3Q4FtxV2bsrUdYWwDuwua/Og=;
	b=glhxFKRBEBpWxUneEbZtPs25TRWCQ3NiiowHIEE8Q5fyswdKUROJi24Zw3FTxG10W4iTRX
	/6dt7h592Nq/Yq2hGGVB3J76t0xWbBY3YPqfUbZ//n3kvfzpqEdesQJAkjRJz6g2UPA8b6
	lQjzdl/oyQv+fX3HopWs0WvqwIOnAgY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-5leVGC77Mq6sKL-37v4_aQ-1; Thu, 21 Apr 2022 10:20:38 -0400
X-MC-Unique: 5leVGC77Mq6sKL-37v4_aQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 930802822A25
	for <mptcp@lists.linux.dev>; Thu, 21 Apr 2022 14:20:38 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.32.181.152])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4487514A4F80
	for <mptcp@lists.linux.dev>; Thu, 21 Apr 2022 14:20:38 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 1/5] mptcp: really share subflow snd_wnd
Date: Thu, 21 Apr 2022 16:20:15 +0200
Message-Id: <4d20fad8c4fbc23b033045c4a333408f4802afe7.1650550242.git.pabeni@redhat.com>
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

As per RFC, mptcp subflows use a "shared" snd_wnd: the effective
window is the maximum among the current values received on all
subflows. Without such feature a data transfer using multiple
subflows could block.

Window sharing is currently implemented in the RX side:
__tcp_select_window uses the mptcp-level receive buffer to compute
the announced window.

That is not enough: the TCP stack will stick to the window size
received on the given subflow; we need to propagate the msk window
value on each subflow at xmit time.

Change the packet scheduler to ignore the subflow level window
and use instead the msk level one

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6d59bfdd6bbd..0223a44d6b29 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1141,19 +1141,20 @@ struct mptcp_sendmsg_info {
 	bool data_lock_held;
 };
 
-static int mptcp_check_allowed_size(struct mptcp_sock *msk, u64 data_seq,
-				    int avail_size)
+static int mptcp_check_allowed_size(const struct mptcp_sock *msk, struct sock *ssk,
+				    u64 data_seq, int avail_size)
 {
 	u64 window_end = mptcp_wnd_end(msk);
+	u64 mptcp_snd_wnd;
 
 	if (__mptcp_check_fallback(msk))
 		return avail_size;
 
-	if (!before64(data_seq + avail_size, window_end)) {
-		u64 allowed_size = window_end - data_seq;
+	mptcp_snd_wnd = window_end - data_seq;
+	avail_size = min_t(unsigned int, mptcp_snd_wnd, avail_size);
 
-		return min_t(unsigned int, allowed_size, avail_size);
-	}
+	if (unlikely(tcp_sk(ssk)->snd_wnd < mptcp_snd_wnd))
+		tcp_sk(ssk)->snd_wnd = min_t(u64, U32_MAX, mptcp_snd_wnd);
 
 	return avail_size;
 }
@@ -1305,7 +1306,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	}
 
 	/* Zero window and all data acked? Probe. */
-	copy = mptcp_check_allowed_size(msk, data_seq, copy);
+	copy = mptcp_check_allowed_size(msk, ssk, data_seq, copy);
 	if (copy == 0) {
 		u64 snd_una = READ_ONCE(msk->snd_una);
 
@@ -1498,11 +1499,16 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	 * to check that subflow has a non empty cwin.
 	 */
 	ssk = send_info[SSK_MODE_ACTIVE].ssk;
-	if (!ssk || !sk_stream_memory_free(ssk) || !tcp_sk(ssk)->snd_wnd)
+	if (!ssk || !sk_stream_memory_free(ssk))
 		return NULL;
 
-	burst = min_t(int, MPTCP_SEND_BURST_SIZE, tcp_sk(ssk)->snd_wnd);
+	burst = min_t(int, MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
 	wmem = READ_ONCE(ssk->sk_wmem_queued);
+	if (!burst) {
+		msk->last_snd = NULL;
+		return ssk;
+	}
+
 	subflow = mptcp_subflow_ctx(ssk);
 	subflow->avg_pacing_rate = div_u64((u64)subflow->avg_pacing_rate * wmem +
 					   READ_ONCE(ssk->sk_pacing_rate) * burst,
-- 
2.35.1

