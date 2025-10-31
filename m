Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E549F334C2E
	for <mptcp@lists.linux.dev>; Fri, 31 Oct 2025 17:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931770; cv=none; b=f08Eq9iN0HcvKVFCIhqR2+SxBT6Ca8+UJzkX5a8Xr99xmczwKZNfnxFuJfJLjuJYp5xLeojVEUQSzjYb3dyYxXrGwtzKrYXyAueKNK3S+bWkL/3V/KHhVh7DPZCkeCV6U617b+76Eg+NNvqlQiwVktgVj0eNOX9g1TVZ1T/UmLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931770; c=relaxed/simple;
	bh=uBldUIAo2WfmDfGgh1UzLBQjnA7eCdUsIqYqdoXJXns=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=n+j2iRPx9Xd5DNVvnHWwXBaoRYathx8IQWzC56UinD7/DsB2YZR//MemAtozl4sg0Utf9NUgJo1wAZW/KEgIllvnWrl2QzT+YXrFFHW7iC6c1FcZTZuzlAlhYOZ4dsdqbSHy2PHU9M3b5+skhvr+nFNta6NGWnIv/ZdimFLf4t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a07H4Yby; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a07H4Yby"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761931767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BnTiPN/8IDyIhBWnwmAJI9qOOaI+mIkNv8aACKmyldM=;
	b=a07H4Ybyjh5YDrToexeDUjRQj0cnaUX8myx8ZSDM2aqNr7inJSTa+jiWJPVzybEi/9QsMP
	HJrmzT4Vl59LkEQMgv9eprAydAtmjtgEKtstl5pHlKrGT4LqRcnGiaobwKSzZdOHdvvOAv
	Zxc18826wd2LMynkGWHIPTKk8KOiOoc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-MioydnfuM6qffGCeaygL9Q-1; Fri,
 31 Oct 2025 13:29:26 -0400
X-MC-Unique: MioydnfuM6qffGCeaygL9Q-1
X-Mimecast-MFC-AGG-ID: MioydnfuM6qffGCeaygL9Q_1761931765
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A715195606F
	for <mptcp@lists.linux.dev>; Fri, 31 Oct 2025 17:29:25 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.247])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 84BC530001A1
	for <mptcp@lists.linux.dev>; Fri, 31 Oct 2025 17:29:24 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 4/4] mptcp: add receive queue awareness in tcp_rcv_space_adjust()
Date: Fri, 31 Oct 2025 18:29:10 +0100
Message-ID: <4c75f202a33758222108c3766c1d80a87072628d.1761931390.git.pabeni@redhat.com>
In-Reply-To: <cover.1761931390.git.pabeni@redhat.com>
References: <cover.1761931390.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EkPEkGAFEJyGfzGWEJ9ZOayPEMklohxMaX7D_sxDsWs_1761931765
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
 net/mptcp/protocol.c | 50 +++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4fc1519baab6..37a90d644e7b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2105,6 +2105,27 @@ static void mptcp_rcv_space_init(struct mptcp_sock *msk, const struct sock *ssk)
 		msk->rcvq_space.space = TCP_INIT_CWND * TCP_MSS_DEFAULT;
 }
 
+static unsigned int mptcp_inq_hint(const struct sock *sk)
+{
+	const struct mptcp_sock *msk = mptcp_sk(sk);
+	const struct sk_buff *skb;
+
+	skb = skb_peek(&sk->sk_receive_queue);
+	if (skb) {
+		u64 hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
+
+		if (hint_val >= INT_MAX)
+			return INT_MAX;
+
+		return (unsigned int)hint_val;
+	}
+
+	if (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN))
+		return 1;
+
+	return 0;
+}
+
 /* receive buffer autotuning.  See tcp_rcv_space_adjust for more information.
  *
  * Only difference: Use highest rtt estimate of the subflows in use.
@@ -2133,10 +2154,12 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 	if (rtt_us == U32_MAX || time < (rtt_us >> 3))
 		return;
 
-	if (msk->rcvq_space.copied <= msk->rcvq_space.space)
+	copied = msk->rcvq_space.copied;
+	copied -= mptcp_inq_hint(sk);
+	if (copied <= msk->rcvq_space.space)
 		goto new_measure;
 
-	if (mptcp_rcvbuf_grow(sk, msk->rcvq_space.copied)) {
+	if (mptcp_rcvbuf_grow(sk, copied)) {
 
 		/* Make subflows follow along.  If we do not do this, we
 		 * get drops at subflow level if skbs can't be moved to
@@ -2150,7 +2173,7 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 			ssk = mptcp_subflow_tcp_sock(subflow);
 			slow = lock_sock_fast(ssk);
 			if (tcp_sk(ssk)->rcvq_space.space)
-				tcp_rcvbuf_grow(ssk, msk->rcvq_space.copied);
+				tcp_rcvbuf_grow(ssk, copied);
 			unlock_sock_fast(ssk, slow);
 		}
 	}
@@ -2233,27 +2256,6 @@ static bool mptcp_move_skbs(struct sock *sk)
 	return enqueued;
 }
 
-static unsigned int mptcp_inq_hint(const struct sock *sk)
-{
-	const struct mptcp_sock *msk = mptcp_sk(sk);
-	const struct sk_buff *skb;
-
-	skb = skb_peek(&sk->sk_receive_queue);
-	if (skb) {
-		u64 hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
-
-		if (hint_val >= INT_MAX)
-			return INT_MAX;
-
-		return (unsigned int)hint_val;
-	}
-
-	if (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN))
-		return 1;
-
-	return 0;
-}
-
 static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			 int flags, int *addr_len)
 {
-- 
2.51.0

