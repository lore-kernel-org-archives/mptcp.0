Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD0A2459EA
	for <mptcp@lists.linux.dev>; Tue, 11 Nov 2025 07:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762845859; cv=none; b=UFzwpdpDGyGw6Fzd5mKv4B5Bk27xFDpEIVu+ZTQDeYpn/9jqBIhoixwOOvHiUobJ4G/1niRRueDy7XOnJ7+5DvBeYtdUqQF9q9yBc8DuT7HC5ZA8mo8KTiAx1ANfDOd3S/C5/Fua8Je+iNpinbwYWyKxzahZpXGwJfPHpv6tm6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762845859; c=relaxed/simple;
	bh=sEdmj8Lj1mgXrPKA+9Yu54ma4hFS2QbS65spjcksIPk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Kiytr58+TIV6nM8vNS/Yk+36IsqcS1SJeujiK+VgNkk+Yofwr14C3KEisHT1a7HoYJ8LoBxp/bjIMHNnR9OeXz+f2qwr0+E9MYvITbZjBm0Je2++4+5ccPR2U8qBrUB9DfDyXImhw273TUA8jSe6GnaFY5lAqwWrOel4qQ4kk+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PAK+sJVY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PAK+sJVY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762845856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V/BGcv991J+xA3PFXi+73VQusjZjSrBjXTe19NuSE8w=;
	b=PAK+sJVYKTzXU4Wqr+0kyJo0JszQVuWP4grhLfChEkzvIPTax5wLe74b0mvsmJMbwIrqVR
	arb+ND2Y2/dMhOGl3I6s34tKpX2z9BDcbGcCyAUYXD8ZTFRbd8rzBt0i05mLyqO2VXsEZq
	Q+YmD+RLHu72jVMoTAm40gqWpmp5aek=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-3yR_-TI7Pam5mtqoAADyzA-1; Tue,
 11 Nov 2025 02:24:14 -0500
X-MC-Unique: 3yR_-TI7Pam5mtqoAADyzA-1
X-Mimecast-MFC-AGG-ID: 3yR_-TI7Pam5mtqoAADyzA_1762845854
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 07F17195605C
	for <mptcp@lists.linux.dev>; Tue, 11 Nov 2025 07:24:14 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.226.92])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 137B6195608E
	for <mptcp@lists.linux.dev>; Tue, 11 Nov 2025 07:24:12 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-net 2/2] mptcp: do not drop partial packets.
Date: Tue, 11 Nov 2025 08:24:06 +0100
Message-ID: <5fe0aeae7501fc5837847a9e13ad883a8f039e64.1762845791.git.pabeni@redhat.com>
In-Reply-To: <cover.1762845791.git.pabeni@redhat.com>
References: <cover.1762845791.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aGR3LjVE9vMQ2rngWduET-WEfPKs50DeSU54_U1r7yc_1762845854
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Currently MPTCP drops partial packets for no good reason at all.
Instead we should just skip the already acked bytes.

Also add a missing check for zero window, which in turn requires
properly initializing the rcv_wnd_sent at connection creation time.

Fixes: ab174ad8ef76 ("mptcp: move ooo skbs into msk out of order queue.")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
Notes:
- We should also add a MIB for zerowin drop, but that should be a follow-up
patch, I think.
- based on top of 'mptcp: autotune related improvement', but targeting net,
  will have a conflict in __mptcp_move_skb().
---
 net/mptcp/protocol.c | 27 ++++++++++++++++++++-------
 net/mptcp/subflow.c  |  3 ++-
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7b966f105f89..e3330141a6da 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -378,6 +378,10 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 
 	mptcp_borrow_fwdmem(sk, skb);
 
+	/* Check for zero window.*/
+	if (atomic64_read(&msk->rcv_wnd_sent) == msk->ack_seq)
+		goto drop;
+
 	if (MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq) {
 		/* in sequence */
 		msk->bytes_received += copy_len;
@@ -386,18 +390,27 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 		if (tail && mptcp_try_coalesce(sk, tail, skb))
 			return true;
 
-		skb_set_owner_r(skb, sk);
-		__skb_queue_tail(&sk->sk_receive_queue, skb);
-		return true;
+		goto enqueue;
 	} else if (after64(MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq)) {
 		mptcp_data_queue_ofo(msk, skb);
 		return false;
 	}
 
-	/* old data, keep it simple and drop the whole pkt, sender
-	 * will retransmit as needed, if needed.
-	 */
-	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
+	/* Check for old data. */
+	if (!after64(MPTCP_SKB_CB(skb)->end_seq, msk->ack_seq)) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
+		goto drop;
+	}
+
+	/* Partial packet, seq < rcv_next < end_seq. */
+	MPTCP_SKB_CB(skb)->offset += msk->ack_seq - MPTCP_SKB_CB(skb)->map_seq;
+
+enqueue:
+	skb_set_owner_r(skb, sk);
+	__skb_queue_tail(&sk->sk_receive_queue, skb);
+	return true;
+
+drop:
 	mptcp_drop(sk, skb);
 	return false;
 }
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 39bf69e73975..0db832b5ddca 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -496,7 +496,8 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
 	WRITE_ONCE(msk->remote_key, subflow->remote_key);
 	WRITE_ONCE(msk->ack_seq, subflow->iasn);
 	WRITE_ONCE(msk->can_ack, true);
-	atomic64_set(&msk->rcv_wnd_sent, subflow->iasn);
+	atomic64_set(&msk->rcv_wnd_sent, subflow->iasn +
+		     tcp_receive_window(tcp_sk(subflow->tcp_sock)));
 }
 
 static void mptcp_propagate_state(struct sock *sk, struct sock *ssk,
-- 
2.51.1

