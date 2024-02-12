Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8533A36B08
	for <mptcp@lists.linux.dev>; Mon, 12 Feb 2024 15:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707751159; cv=none; b=LRIkTLmvazuS7SMmWSe5kcfl8OGzsYW5Hotfv/CD0+WfCvVUA4PoO/TYeOWa728yhMIB0ONHetUoDhodX1NBWya7ImFmAocvSxYPMaZxjv2/gZasb/hQHp0c0LTG7EitgjiKJ7IdRWL4Lp7y7eM7yrrxZsCjoFFRVIYm0H+ju/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707751159; c=relaxed/simple;
	bh=pDEiuX9Vt365IB0XnMQ/OB1GkfrZIHjXV44caWvgmeo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lT7RLec+g+QgX7fFVxFVtSWjJUHXPRF4qPoB+SZbS6IQXYdDsU84NXARWQEWvf6R01Bv7slCp11PDqg6vpYgy8J4Ol0KUKUa6krsChh8SEIGIroGSw0ijvch6cDKCAKDWbMkGXblqGuHZTx9uEV0LZ8BCLY24b9fWXAr3iZ5tbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TAeQk3du; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TAeQk3du"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707751156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zQBnd+viPBCBAgqeTOWwevoOaE30PTky+Hj/QUjJ1Ks=;
	b=TAeQk3duVGfwWlBlfXK89Lmh85eRFI3snVgJ+0JTdn0HAAXd4De5+q0wJ5ij0km1ash0ts
	aY8/Vd1GLY8+D/JEaiMn7DKq3jO5rdIb2seEp0TPPBT9OdpVEv6zHl4FtefalEX6EFW9iR
	Ih4DpjlkD/F3Xism0V3gyr4MaePLeq0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-WjsFVSGZMy2OKaYdz1wwOQ-1; Mon, 12 Feb 2024 10:19:15 -0500
X-MC-Unique: WjsFVSGZMy2OKaYdz1wwOQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B6B328A67E8
	for <mptcp@lists.linux.dev>; Mon, 12 Feb 2024 15:19:14 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.193])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 454D3492BC6
	for <mptcp@lists.linux.dev>; Mon, 12 Feb 2024 15:19:14 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [mptcp-next v2 1/7] mptcp: push ad DSS boundaries
Date: Mon, 12 Feb 2024 16:18:56 +0100
Message-ID: <50740f793884616dd10374327029408dcd25dacc.1707739536.git.pabeni@redhat.com>
In-Reply-To: <cover.1707739536.git.pabeni@redhat.com>
References: <cover.1707739536.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

when inserting not contiguous data in the subflow write queue,
the protocol creates a new skb and prevent the TCP stack from
merging it later with already queued skbs by setting the EOR marker.

Still no push flag is explicitly set at the end of previous GSO
packet, making the aggregation on the receiver side sub-optimal -
and packetdrill self-tests less predictable.

Explicitly mark the end of not contiguous DSS with the push flag.

Fixes: 6d0060f600ad ("mptcp: Write MPTCP DSS headers to outgoing data packets")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3017b01ac488..21b3729c65ac 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1265,6 +1265,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 		mpext = mptcp_get_ext(skb);
 		if (!mptcp_skb_can_collapse_to(data_seq, skb, mpext)) {
 			TCP_SKB_CB(skb)->eor = 1;
+			tcp_mark_push(tcp_sk(ssk), skb);
 			goto alloc_skb;
 		}
 
-- 
2.43.0

