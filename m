Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC59371EB2
	for <mptcp@lists.linux.dev>; Tue, 16 Sep 2025 16:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758040054; cv=none; b=dHB6g5KOK4yc7XSEIPREAhGbh/WcPA0zZ14Zgv3vr7hk6tVsDEVtEFQwa2LikOzbAivSsS9vEYNcSB7Rhzl4kwEbytYXOspXnS9AKzUv89AqqMfKM2RxbHjzlFPtpwTjJdspYytTjicbXtI6ac61e7oh9VrPgw+LFrOm8o1OBNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758040054; c=relaxed/simple;
	bh=2Z2yknyfCbepGGBX5iwovAXZ9csRYcEcN+ucgXLdVsI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=iOkhUdJBcYhDo40Ft9q8Go1VVt1dNih68l04dBnJ+wvtQxv8rG3LNHS9jh7MLzlNk3UNoMupO6E36NLa0pzvYhyNBOffmsbfB4Qd3bENia+LTwVV5nmn2IakzKzW4W2LwUMANDo4JpHiDhK156zWmYKgdNmdmNOAj6YOQ6Ph9LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=crpsvyKt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="crpsvyKt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758040051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6C79Vquxdp59KsW/DAVb9ZIpmsK+9KCNv3rVcxOyLfg=;
	b=crpsvyKtU/BRtOAoZteIXfAbg/szFIEnY8yPyMdK1TVZq30pdc5yJIRcBc68lX4tccE81V
	YvapjXY1qlbjrMXh++bdOCxcfSUI2b4PS92M91x5gGaCF96e+x9WCyD5mL0dUbtNSmwgqQ
	Qyof6iQe/rtu89ODltGATovUQOLvBfA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-Ie-edlZQPgas1Gkgv7KVHw-1; Tue,
 16 Sep 2025 12:27:30 -0400
X-MC-Unique: Ie-edlZQPgas1Gkgv7KVHw-1
X-Mimecast-MFC-AGG-ID: Ie-edlZQPgas1Gkgv7KVHw_1758040049
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 552271800576
	for <mptcp@lists.linux.dev>; Tue, 16 Sep 2025 16:27:29 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.160])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 734DB19560B8
	for <mptcp@lists.linux.dev>; Tue, 16 Sep 2025 16:27:28 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [MPTCP next 01/12] mptcp: leverage skb deferral free
Date: Tue, 16 Sep 2025 18:27:11 +0200
Message-ID: <91fd56b60fb3766c3568013a123baf1968985869.1758039775.git.pabeni@redhat.com>
In-Reply-To: <cover.1758039775.git.pabeni@redhat.com>
References: <cover.1758039775.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xb8Li5uFQxZJu9k5zLPFZ1GguuEDKDBA6ICu8EsUjwA_1758040049
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Usage of the skb deferral API is straight-forward; with multiple
subflows actives this allow moving part of the received application
load into multiple CPUs.

Also fix a typo in the related comment.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f2e7282394804..c51aede20779d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1913,12 +1913,13 @@ static int __mptcp_recvmsg_mskq(struct sock *sk,
 		}
 
 		if (!(flags & MSG_PEEK)) {
-			/* avoid the indirect call, we know the destructor is sock_wfree */
+			/* avoid the indirect call, we know the destructor is sock_rfree */
 			skb->destructor = NULL;
+			skb->sk = NULL;
 			atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
 			sk_mem_uncharge(sk, skb->truesize);
 			__skb_unlink(skb, &sk->sk_receive_queue);
-			__kfree_skb(skb);
+			skb_attempt_defer_free(skb);
 			msk->bytes_consumed += count;
 		}
 
-- 
2.51.0

