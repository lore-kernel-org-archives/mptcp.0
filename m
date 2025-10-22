Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5F02F99AA
	for <mptcp@lists.linux.dev>; Wed, 22 Oct 2025 07:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761118812; cv=none; b=G14jcL/O7QDWC0Uoj2Smp4tMzDZSlh0UYeefb+f4a/aRH0cIi5FAUtbn85SQD83nXK4ccPk1aY/kYpU0AmgbDxoD0wCEV03X87uTEKOlUepyWpS7DsNfdtSwPORVfYloP5B8u/PXvGODfKIMT+BJ6E4oy4KZl01Z1o2EfwZ8dfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761118812; c=relaxed/simple;
	bh=ZV045TWTTBHO6HPJmA8MUX/gVcFbzpVRHDXqNrh1x0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=qch+CaSMMgCfwUBMFkKygi9p8Rsvdm8o0AhOA+BXKve/c6y1LbPOpNrL9YWlvyz/EnUZjIRmZZUSAaZjsCGyy4y3TKHLSmj19iivAiZ7elQxf3lLjiFwkrrwVKd1Cg8NCPz1lTA2HcqEUmDTIjy+L+4spKJLX9LXvf8dl7eEpV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=arFzcJx7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="arFzcJx7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761118809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/FuiYWIrz4pVRA7JMDxqtGl9pEUDGhUtlFNvwcAddB0=;
	b=arFzcJx7anUg+uAiT/z0L7bstCpnDr8hyaWfPMZCl9/3GVyVJMmH1NzfhZiVm+KI2b3kX+
	OLrAfalELpg1KL6ahtdXT0iWbPBcYti/IKPpDeNwtKSsaSVte+f9tr8VNwG/3j8a6msSxZ
	PDF7KFzFyPE0RYWnujYgacA+nuRfy7o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-vy9in1qdMVqCJYlaRLjoiQ-1; Wed,
 22 Oct 2025 03:40:07 -0400
X-MC-Unique: vy9in1qdMVqCJYlaRLjoiQ-1
X-Mimecast-MFC-AGG-ID: vy9in1qdMVqCJYlaRLjoiQ_1761118806
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A875D195608F;
	Wed, 22 Oct 2025 07:40:06 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.237])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 442C330001BF;
	Wed, 22 Oct 2025 07:40:04 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: geliang@kernel.org,
	Mat Martineau <martineau@kernel.org>
Subject: [PATCH v2 mptcp-net 1/2] mptcp: restore window probe
Date: Wed, 22 Oct 2025 09:39:58 +0200
Message-ID: <d893a96e57649febf9c0a1e5efa5cf94347bfd62.1761118636.git.pabeni@redhat.com>
In-Reply-To: <cover.1761118636.git.pabeni@redhat.com>
References: <cover.1761118636.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nJV4-rvbiM0OoF9yjCxYTyP2UakIAO6bp5-ZQ6Xeqm4_1761118806
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Since commit 72377ab2d671 ("mptcp: more conservative check for zero
probes") the MPTCP-level zero window probe check is always disabled, as
the TCP-level write queue always contains at least the newly allocated
skb.

Refine the relevant check tacking in account that the above condition
and that such skb can have zero length.

Fixes: 72377ab2d671 ("mptcp: more conservative check for zero probes")
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
  - drop unneeded changes (Mat)
---
 net/mptcp/protocol.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index bde76b7311f986..a7fa69cf79f106 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1339,7 +1339,12 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	if (copy == 0) {
 		u64 snd_una = READ_ONCE(msk->snd_una);
 
-		if (snd_una != msk->snd_nxt || tcp_write_queue_tail(ssk)) {
+		/* No need for zero probe if there are any data pending
+		 * either at the msk or ssk level; skb is the current write
+		 * queue tail and can be empty at this point.
+		 */
+		if (snd_una != msk->snd_nxt || skb->len ||
+		    skb != tcp_send_head(ssk)) {
 			tcp_remove_empty_skb(ssk);
 			return 0;
 		}
-- 
2.51.0

