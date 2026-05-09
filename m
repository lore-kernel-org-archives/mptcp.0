Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A3C3148D2
	for <mptcp@lists.linux.dev>; Sat,  9 May 2026 07:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778312956; cv=none; b=a3yPRq+w4zIZuYmiOMnTWB2snVJPEySelYZNrEwQ/RBQ4zjj/PWo+dJekJImI31vl8cYKEni2BzHaVmex1jBK0gEDJeynyEjDN9+dB0mu6wyqlC97NE1FcZgeKL6yrnG3DaMGIxCMdy/Cg0Uhgyo+iuUYWCb040Jr2wDSYHo9BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778312956; c=relaxed/simple;
	bh=3VCa83AcpaacCx65vxHhpDCf+g+R7ZQ5GWRpiU2rC1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=A+ekN2m8AEKicwljCEmrVb6D2Y04+PyTHNbNvoAfl8q3HuZ1P42Ay/TXGhQvhBgyYhaKezhfTf+tym9hXmOw7bPS7raDQmr2i2T3PeoWzraZ9RgIeWAd1n4Cyc6pFaCLhx8T2hpRgIe/Xls9MczHo/OD9RbK2kG4qOfAxoz7nRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AgRAkukG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AgRAkukG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778312954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jJ8n5T+90W+nWBesYEPr/vtutLq1A528Fq/2kDkYXXg=;
	b=AgRAkukGyhaQPf9SIeMYJLo1l2f5+EZ6zNiKXxoBXraFpx69dZrYQTPThpchS3xoYGwFpk
	5wrKehcLk+4pxfnc5HQ7NfQys4VbGiQRMx08pvKjDlqG2F32yDcVZ9TWCYopdo07Gz3KD2
	Cv79uH3KtrQWWujJW65k68Mq082JADE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-252-_IfQotUXNVOZiW2CSxs5BA-1; Sat,
 09 May 2026 03:49:10 -0400
X-MC-Unique: _IfQotUXNVOZiW2CSxs5BA-1
X-Mimecast-MFC-AGG-ID: _IfQotUXNVOZiW2CSxs5BA_1778312949
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 10B8A195608B;
	Sat,  9 May 2026 07:49:09 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.24])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EC84A18004A3;
	Sat,  9 May 2026 07:49:07 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH mptcp-next 01/12] mptcp: do not drop partial packets
Date: Sat,  9 May 2026 09:48:21 +0200
Message-ID: <2a88c5905617e57f9523a7a47c9f4e49e80ec81f.1778312843.git.pabeni@redhat.com>
In-Reply-To: <cover.1778312843.git.pabeni@redhat.com>
References: <cover.1778312843.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OlZDIguJcW6LvCGkCLBwdAXaSRBVCT1G-o2doQpZgKE_1778312949
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Shardul Bankar <shardul.b@mpiricsoftware.com>

When a packet arrives with map_seq < ack_seq < end_seq, the beginning
of the packet has already been acknowledged but the end contains new
data.  Currently the entire packet is dropped as "old data," forcing
the sender to retransmit.

Instead, skip the already-acked bytes by adjusting the skb offset and
enqueue only the new portion.  Update bytes_received and ack_seq to
reflect the new data consumed.

A previous attempt at this fix (commit 1d2ce718811a ("mptcp: do not
drop partial packets"), reverted in commit bf39160c4218 ("Revert
"mptcp: do not drop partial packets"")) also added a zero-window
check and changed rcv_wnd_sent initialization, which caused test
regressions.  This version addresses only the partial packet handling
without modifying receive window accounting.

Fixes: ab174ad8ef76 ("mptcp: move ooo skbs into msk out of order queue.")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/600
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
[pabeni@redhat.com: update map]
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v2 -> v3:
  - update map_seq, too
v2: https://lore.kernel.org/mptcp/20260422143931.43281-1-shardul.b@mpiricsoftware.com/

Note:
 - this introduces some code duplication. will be cleaned-up in
   later patches
---
 net/mptcp/protocol.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 93e7a42fc65c..ce8372fb3c6a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -397,12 +397,26 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 		return false;
 	}
 
-	/* old data, keep it simple and drop the whole pkt, sender
-	 * will retransmit as needed, if needed.
+	/* Completely old data? */
+	if (!after64(MPTCP_SKB_CB(skb)->end_seq, msk->ack_seq)) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
+		mptcp_drop(sk, skb);
+		return false;
+	}
+
+	/* Partial packet: map_seq < ack_seq < end_seq.
+	 * Skip the already-acked bytes and enqueue the new data.
 	 */
-	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
-	mptcp_drop(sk, skb);
-	return false;
+	copy_len = MPTCP_SKB_CB(skb)->end_seq - msk->ack_seq;
+	MPTCP_SKB_CB(skb)->offset += msk->ack_seq - MPTCP_SKB_CB(skb)->map_seq;
+	MPTCP_SKB_CB(skb)->map_seq += msk->ack_seq -
+				      MPTCP_SKB_CB(skb)->map_seq;
+	msk->bytes_received += copy_len;
+	WRITE_ONCE(msk->ack_seq, msk->ack_seq + copy_len);
+
+	skb_set_owner_r(skb, sk);
+	__skb_queue_tail(&sk->sk_receive_queue, skb);
+	return true;
 }
 
 static void mptcp_stop_rtx_timer(struct sock *sk)
-- 
2.54.0

