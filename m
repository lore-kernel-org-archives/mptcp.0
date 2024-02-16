Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E085812E
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 11:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708082943; cv=none; b=DzA1sdX7p7jYZlKs7FwJ85QlDMXZfdvQjulbyYZsVOgMiTGlUsJd2DsFIcZjIPHCj1hEEY8U5Voi2K0rEM5sLlhbqdeliXZSV6QgsQdPWccI8eoehPLayLmepkgRDKpjRf3XeYjPjglsf2c2E8RzXDDX0aap9X9f1FroVsgnkmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708082943; c=relaxed/simple;
	bh=eftXQxxgj1iZ31Isyz/h1FmrBP367vowtkPMW//1n8Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Javu5iObh4MCvxWhCrwqwGDa4JSA3QCIMng1pmbRQdJKQ2zohQoj4kw56tma5y/y/jwvMJ3TZI9DX06bvK7/Jg58PZO58YTU3c0dNhzUQ6T0ef1kHrRibraQDp3sH8Lj07CppjeQ7a5r8ZISvYn3nAfKCl/gH3WIKqXJi7Cgr8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QuEpsO1E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QuEpsO1E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708082940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kSuy3gfqq1e5kUOm1iauKOUUlWQHrskJVh4dyXVfLJI=;
	b=QuEpsO1EOqEqmz/okO684BIvYsYLkSBEHFJF7QwH9KAZAI5K0iGbLdeCQUK7XisnJeOmsv
	OeNTBGIfKGbU6vhUBRy7dzTKvQKNp+vLy8P78JJZTZ1LrFBoh0jKvqPHg6JRr0+/DjlB3J
	+wXfLaP4PZxmXV8c9GClD0truK1PoSU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-rvDdOp2GMXCz_8KSi3KS4g-1; Fri, 16 Feb 2024 06:28:58 -0500
X-MC-Unique: rvDdOp2GMXCz_8KSi3KS4g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A21F880350F
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 11:28:58 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.51])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 312BD492BE2
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 11:28:58 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v3 net-next 1/7] mptcp: push at DSS boundaries
Date: Fri, 16 Feb 2024 12:28:12 +0100
Message-ID: <70d4b98c5eede368e82d9238b3ca33fbf7c3e57e.1708082765.git.pabeni@redhat.com>
In-Reply-To: <cover.1708082765.git.pabeni@redhat.com>
References: <cover.1708082765.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
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
v2 -> v3:
 - fixed subj typo (Mat)
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

