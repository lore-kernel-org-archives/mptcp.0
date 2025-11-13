Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D559D23F294
	for <mptcp@lists.linux.dev>; Thu, 13 Nov 2025 23:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763075261; cv=none; b=CcNeObaB5RskSnumlpN6FgoEMRa9iLXu4pVYtdU3EzlzsWIk22FdivPhjKhg/C9r4YncBLADgpJmFf2+4oxmhyxFR8T5Qrv2z7rA+LYR2ewuRw5TgawMATU+CSbSS4ncZA6ofUta5pPQPcC1MrDLDCZxfe7TrxlA1K8YWk0Hbls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763075261; c=relaxed/simple;
	bh=GynJi2mTkwYogh0URQ0zMi7Vg6g3Msh+JcDpa95ZU14=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=FkexcYWFwP9nPBGbcKyOQUIbU32Z9AY1trliNJPV7bCZH7NFLiBlz//w3FbxlCE0AGza4eAHxlnkeDXPc3MztR2KjBr5czeMFDT8gcKk2Yyn2Z0KqCUPIcMpbGHTvweUY2WGyjk/XXs/h4ZjhUnwps6IuzH2j9lZr02uRZzGmlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TQZX0Q2X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TQZX0Q2X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763075258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I3uQGdHbuCbghLxW9LzLdFhFvV+YY5c43LPbc3tcdik=;
	b=TQZX0Q2XplNfczynw+xbEAuRW3O8fsOReHRDeRJhicCPrSvNpM0WUhUzcoTbafFSRO8+DW
	FmVFc9L82yp5fAucL9T9OYm+WGLtXFIFu+LJiJaXCLyZ1VUsqcuDdNAQKKNNoxZQGVpGDy
	lc93vWcGEaokWBfhUPddEti9IBlnvG0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-209-VjeTsUQ7NU6WQrgMG2Te-g-1; Thu,
 13 Nov 2025 18:07:34 -0500
X-MC-Unique: VjeTsUQ7NU6WQrgMG2Te-g-1
X-Mimecast-MFC-AGG-ID: VjeTsUQ7NU6WQrgMG2Te-g_1763075253
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3DDB21956089
	for <mptcp@lists.linux.dev>; Thu, 13 Nov 2025 23:07:33 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.100])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AC072300018D
	for <mptcp@lists.linux.dev>; Thu, 13 Nov 2025 23:07:30 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 3/3] mptcp: do not drop partial packets.
Date: Fri, 14 Nov 2025 00:05:31 +0100
Message-ID: <c9b426a4e163aa3c4fe8b80c79f1a610f47ae7d8.1763075056.git.pabeni@redhat.com>
In-Reply-To: <cover.1763075056.git.pabeni@redhat.com>
References: <cover.1763075056.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EkcsJQgxuP3udEuWG5JRlf5SMFFWaR1c49NU_Mfy9u8_1763075253
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
index f5761bff288c..78ac8ba80e59 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -385,6 +385,10 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 
 	mptcp_borrow_fwdmem(sk, skb);
 
+	/* Check for zero window.*/
+	if (atomic64_read(&msk->rcv_wnd_sent) == msk->ack_seq)
+		goto drop;
+
 	if (MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq) {
 		/* in sequence */
 		msk->bytes_received += copy_len;
@@ -393,18 +397,27 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
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
index 86ce58ae533d..43a2ff058ba5 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -497,7 +497,8 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
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

