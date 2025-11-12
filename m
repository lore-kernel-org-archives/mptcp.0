Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58182FD7D8
	for <mptcp@lists.linux.dev>; Wed, 12 Nov 2025 09:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940485; cv=none; b=HM9uzBuhYnMPDxCXgBGjmEHhiOaNGPAgMfbE4sSP9WREbGHI0teUylmv7VP2skWC6Pz3vEUHGzw8xcahYcb+/XPZPZPy6VBwFtUA7dCBJnVRpt7IRxUbSez1JEJCudqeuc6qyE6lgfMdXqFeY9uKK8H1xzn5y7XxiQO6pBlCFII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940485; c=relaxed/simple;
	bh=7RS+fImQz2wXeS0IGgWHrzBUAqWJ3kjuFW3bZ0MHXV4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=liiPuuPpsdrBdtdRQlJLqEY6tujMa23rbOo8z64bxPkW/1Eti5OuLhhzyk6C7BisKZLs7sbU8acqKVjE1A54cwPukK4MjR1dnqEJNLaOunOpLg1ylW6KWzGK2xO2QjEmCytgP4FroJlNnVlBlLpa3aNW4WuG4wMgEJ7j+mpGYRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N/4NRr/w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/4NRr/w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762940483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NL9+tDaUTNARL7xn5nRZGTuAkpmCvJqa1blRxIrXs8g=;
	b=N/4NRr/w/iZTNuFKpE/Cyld18HPEtIvO6WUrrSLv5E9NNFDkOukDL3OVswYgSxPg096Ytb
	PijG5Bh9vjcg5bckOGmUnGU2yxKdXjh0P95DGnjtFzT1g6Zr5fBM+3+eFsFB5mfEuXGDfG
	9gN0/KJCQFFnItkNHwi5pEnP/1rN2jc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-CiWU_n6lO-yRoYVuuvkMPA-1; Wed,
 12 Nov 2025 04:41:21 -0500
X-MC-Unique: CiWU_n6lO-yRoYVuuvkMPA-1
X-Mimecast-MFC-AGG-ID: CiWU_n6lO-yRoYVuuvkMPA_1762940480
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D16F9180034D
	for <mptcp@lists.linux.dev>; Wed, 12 Nov 2025 09:41:20 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.120])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F16251955F1A
	for <mptcp@lists.linux.dev>; Wed, 12 Nov 2025 09:41:19 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v4 mptcp-next 6/6] mptcp: add receive queue awareness in tcp_rcv_space_adjust()
Date: Wed, 12 Nov 2025 10:41:06 +0100
Message-ID: <ba459ac039f30f4b81cb97be2d0963e7b5216e05.1762940290.git.pabeni@redhat.com>
In-Reply-To: <cover.1762940290.git.pabeni@redhat.com>
References: <cover.1762940290.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZmisBhQz80OtEalBL7xHFflUL-ZOnrbT-aCUgdNwgRc_1762940480
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This is the mptcp counter-part of commit ea33537d8292 ("tcp: add receive
queue awareness in tcp_rcv_space_adjust()").

Prior to this commit:

ESTAB 33165568 0      192.168.255.2:5201 192.168.255.1:53380 \
	skmem:(r33076416,rb33554432,t0,tb91136,f448,w0,o0,bl0,d0)

After:
ESTAB 3279168 0      192.168.255.2:5201 192.168.255.1]:53042 \
	skmem:(r3190912,rb3719956,t0,tb91136,f1536,w0,o0,bl0,d0)
(same tput)

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9a0a4bfa25e6..a9dbdb413c7e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2137,11 +2137,13 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 	if (rtt_us == U32_MAX || time < (rtt_us >> 3))
 		return;
 
-	if (msk->rcvq_space.copied <= msk->rcvq_space.space)
+	copied = msk->rcvq_space.copied;
+	copied -= mptcp_inq_hint(sk);
+	if (copied <= msk->rcvq_space.space)
 		goto new_measure;
 
 	trace_mptcp_rcvbuf_grow(sk, time);
-	if (mptcp_rcvbuf_grow(sk, msk->rcvq_space.copied)) {
+	if (mptcp_rcvbuf_grow(sk, copied)) {
 		/* Make subflows follow along.  If we do not do this, we
 		 * get drops at subflow level if skbs can't be moved to
 		 * the mptcp rx queue fast enough (announced rcv_win can
@@ -2155,7 +2157,7 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 			slow = lock_sock_fast(ssk);
 			/* subflows can be added before tcp_init_transfer() */
 			if (tcp_sk(ssk)->rcvq_space.space)
-				tcp_rcvbuf_grow(ssk, msk->rcvq_space.copied);
+				tcp_rcvbuf_grow(ssk, copied);
 			unlock_sock_fast(ssk, slow);
 		}
 	}
-- 
2.51.1

