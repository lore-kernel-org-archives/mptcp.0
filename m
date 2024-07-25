Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC16018028
	for <mptcp@lists.linux.dev>; Thu, 25 Jul 2024 15:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721922849; cv=none; b=YxCjq9PhXnMuiG/Pnhkp8oyExS+rjm/7FE5/8KlIBg6Ubv7ek/t1mz+xCqYOTnuisX9v96ddcpussHnvgr+InENxwvnlT7+HU4tNcghBf9QfHQ+MQ2j3QsqnBUA3gSjR0tTn1GWjOB9+Mf2iRpI32ATKIBOlx0L04VP7eMuLBvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721922849; c=relaxed/simple;
	bh=IyCs+VbGr404x5lLdnoqQtpWbbIzR/l0xNQDc4s3BBA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VTUJqvGIvPlSaaDONgYy4NvJH1WLD+lhQqxYblCDIeiJg3S6N7f4fceWRr4/I76FIh8pMOYXWWWzAsyEGHUcGHUUQJd97qXmT/yKA+DZrDTSVXFBbOeJN1yOlgRm0sr5uXXRivUUHUbehn8Tuz++AhEdvEaSXiAwRvDOdvpMSOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JYc6gWcO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYc6gWcO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721922846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mcW98vQ813RCOoFiWFDgr4Z4qFruY/l35pQIUmPG5t4=;
	b=JYc6gWcOT2p+ty8x2V8KhVHd49V2bEiW1+7+sqQztvJeWyJ2qkUsdeam1Ax3D52K7DG3YC
	rP3Qjk8YcIqdWq7IBJ/9u7/MwKQr1napKJmlGc303BDcYxHP/6QVOXbjg1cezVyVumc5rx
	0mkZf4w17go3/RYRYfN23O5jpxa9/yI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-205-0PkQVwuTNxus1WicnNYMOg-1; Thu,
 25 Jul 2024 11:54:05 -0400
X-MC-Unique: 0PkQVwuTNxus1WicnNYMOg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A50FA1955F0D
	for <mptcp@lists.linux.dev>; Thu, 25 Jul 2024 15:54:04 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.2])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9D4FF1955D44
	for <mptcp@lists.linux.dev>; Thu, 25 Jul 2024 15:54:03 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 1/2] mptcp: fix bad RCVPRUNED mib accounting
Date: Thu, 25 Jul 2024 17:53:52 +0200
Message-ID: <51cd83cb7690d756e9a71797b133bdd9f286de76.1721921695.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Since its introduction, the mentioned MIB accounted for the wrong
event: wake-up being skipped as not-needed on some edge condition
instead of incoming skb being dropped after landing in the (subflow)
receive queue.

Move the increment in the correct location.

Fixes: ce599c516386 ("mptcp: properly account bulk freed memory")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b3a48d97f009..13777c35496c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -350,8 +350,10 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
 	skb_orphan(skb);
 
 	/* try to fetch required memory from subflow */
-	if (!mptcp_rmem_schedule(sk, ssk, skb->truesize))
+	if (!mptcp_rmem_schedule(sk, ssk, skb->truesize)) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
 		goto drop;
+	}
 
 	has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
 
@@ -844,10 +846,8 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 		sk_rbuf = ssk_rbuf;
 
 	/* over limit? can't append more skbs to msk, Also, no need to wake-up*/
-	if (__mptcp_rmem(sk) > sk_rbuf) {
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
+	if (__mptcp_rmem(sk) > sk_rbuf)
 		return;
-	}
 
 	/* Wake-up the reader only for in-sequence data */
 	mptcp_data_lock(sk);
-- 
2.45.2

