Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBEF238171
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 15:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297223; cv=none; b=ar2H4IAyB5WkEgrp/f3oNYrhTS7hmrOZOgqgMXZYin16brb7Rp+oKaPvqtzncFdeaCs677JumUxxEivj8rHnYSuOTK5E6d9hqEPt9YmrWnMbQbJdWa9ckC5LzYxt7I3CdDUJcndLga8ntB2VXrHoHjriLRnEZBRPzIRW1iWbYCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297223; c=relaxed/simple;
	bh=qdda2Wdi9fTdcrtN0KrGI1q1zV2gpAPEK1O0CItX9as=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=ober6EmvnC5oIGNdLkh9EYiQQ/B0hxCbxtcwBWsyxSM30beHAmqUbLV/B+Dmg8q5JuivjgSrRwLHhU4iWNEbgg0X5Fhny7mZyIA6B12jVUgVrd6iG0LjKO6t7NvJgEDz7SF4p82pPiCNZ0SSwCo1WdPHjBXrCS02N29rJih0p4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pfr3VsIT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pfr3VsIT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758297220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OObWxAKQ1wd0hNQYGk8h+U9TuSaEjC81KerF0JiIV8I=;
	b=Pfr3VsITG6eLJYZ3Sm/XWt7318/BiXg6mAzQl8gn2tEYHZueejYy7FFxiIzuJpu58kVLA/
	mGo3K5ZNAXqJvJ6kPnf5KwI8xRYIRyxrgeJgyDJQl3PXSyz8AphdyuIIdcd7WVNddrDza2
	Q26m0qW47uILE32kJTob+XgX68tl8nM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-cqOt-_CqOvmrD9nadNiLwg-1; Fri,
 19 Sep 2025 11:53:39 -0400
X-MC-Unique: cqOt-_CqOvmrD9nadNiLwg-1
X-Mimecast-MFC-AGG-ID: cqOt-_CqOvmrD9nadNiLwg_1758297218
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D75941800366
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 15:53:38 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.255])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EB18E1800452
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 15:53:37 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [MPTCP next v3 01/12] mptcp: leverage skb deferral free
Date: Fri, 19 Sep 2025 17:53:15 +0200
Message-ID: <57290c1e6cdd4a157f2bbb64a77d3afe6705c9e3.1758296923.git.pabeni@redhat.com>
In-Reply-To: <cover.1758296923.git.pabeni@redhat.com>
References: <cover.1758296923.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PUYLoB3wCuhQPNnkoIW_9FcAa7LjQZ-7aPxt8DPQFu8_1758297218
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Usage of the skb deferral API is straight-forward; with multiple
subflows actives this allow moving part of the received application
load into multiple CPUs.

Also fix a typo in the related comment.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Tested-by: Geliang Tang <geliang@kernel.org>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7933291e991ce..9d95d24781509 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1943,12 +1943,13 @@ static int __mptcp_recvmsg_mskq(struct sock *sk,
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

