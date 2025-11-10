Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A91D31326F
	for <mptcp@lists.linux.dev>; Mon, 10 Nov 2025 14:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762785667; cv=none; b=kcaX16iDowxsNrcyslbBdCjxtitSNVCImlDacdXALe7Rar4lwgOoxXgo0y8HHJZ/FTNOEs0cVU9CPFU9HuauHSLpznWtDfYY1MzozbWrMzMRIOeDlAMFX9MXV5RcqjC/9gG5kbvwmTz0jtNTNO+o1O6Q6ihe2WBd9+BmJjFVdNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762785667; c=relaxed/simple;
	bh=EgV2R6F+0LqHYkfqQRAwvV1UrCnRE0FIHMSHA9r+b4c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Umf8pD0LDG+tFHkawFPIyBYkZRmZxzuHEqSAtk2VgfmyXyhqMyDKcx2DdRe1NKeYTUtUhNZCuVE//9h6BCfpoYzj2lkvJDGNNlhtBKf9dg1eYJdk3WqJShGqwyNw8jEjY1zp04i/rDBAUeOCxBrr6yDtwcivlzBKV/+6+dFjP2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bMxbRlJr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bMxbRlJr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762785663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SJGNCwQl5wSBllZiJyMo3hkv4dJ72wI0oI1jVAuRZ+U=;
	b=bMxbRlJrRt+Q41Y4UBWQsUDhI2dKQADvTjvM4PqeLt7czr3d+s3vBK4dgyo7EgPuH33a/t
	/ERN4/Q4wk0TfkdbeI4MeCxYN6ILaQKnrRwUTnTvu/uxk3InXH9Gg6yPiGE2FXpXpR5cbs
	pZZf47k+DfoH8fxehtCnYTIa/gnHLQs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-QXfSv2ObPzi3A-49_zM3Rg-1; Mon,
 10 Nov 2025 09:41:01 -0500
X-MC-Unique: QXfSv2ObPzi3A-49_zM3Rg-1
X-Mimecast-MFC-AGG-ID: QXfSv2ObPzi3A-49_zM3Rg_1762785661
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0CE8D180045C
	for <mptcp@lists.linux.dev>; Mon, 10 Nov 2025 14:41:01 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.226.92])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2E67A196FC8B
	for <mptcp@lists.linux.dev>; Mon, 10 Nov 2025 14:40:59 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 2/2] mptcp: do not drop partial packets.
Date: Mon, 10 Nov 2025 15:40:46 +0100
Message-ID: <3f9762916cd8100647b200d9d9d284cc19f1f54f.1762785316.git.pabeni@redhat.com>
In-Reply-To: <cover.1762785316.git.pabeni@redhat.com>
References: <cover.1762785316.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kIIp7ty3usfq5DdVTFDuv_IUI4HW_4Hcw9fwMI5DVNU_1762785661
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Currently MPTCP drops partial packets for no good reason at all.
Instead we should just skip the already acked bytes.

Also add a missing check for zero window.

Fixes: ab174ad8ef76 ("mptcp: move ooo skbs into msk out of order queue.")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
Note: this does not avoid the WARN(), but makes the received
data avail to user-space.
We should also add a MIB for zerowin drop, but that should be a follow-up
patch, I think.
---
 net/mptcp/protocol.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

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
-- 
2.51.1

