Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72E37C0A8
	for <mptcp@lists.linux.dev>; Mon, 22 Jan 2024 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936136; cv=none; b=FDY7LIimK5YjC8cSxjX3QyjNy1JLc95ugw1nGgJZDwZQVhhU2fyVgGhdzIVnKi4MmJ/m178kNGRWhJm4LNOVibGlRbV0V6b34C6uFCRjf2acJn8Lh3AwLjpEJ4PUK6ePexuVJmE35EzCLsy1m1JMJ2iVRNGznOz+7WzyCoFtcsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936136; c=relaxed/simple;
	bh=d+8CI2uMCsgL1BPzno67QAdv0HRtvXP4YoJamTPQCDE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pXdXqU0tB070KYhY6VYPL2uZuH/8BwfN7u89sJ/AzNzNE0hOOYXNzGC2c5niUrPDUobuxtPwv7PuP6oHcW8smYeA2u9ah2CgOIt77cAr3HLbt9tg8NvrO88Az0H/mlCZbrwQT9W1gDoG5SKD4HyQ6X66/L3fMjafZkAF30zERxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dCL/Tf31; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dCL/Tf31"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705936133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IUsbV3x6gstmuw+xD6xLceLMmB9XZwsqFdjfq/0Oi8o=;
	b=dCL/Tf31wr2QGK+hbR3VZnDOw7H/rlR0iOHuqwoTTeTzKWLx/AcU5Qh2j4jp4yaHP9kZYN
	RWJ4i3Fm+m1Y34tJuqc0CiBKXisTHveLA0IioaOsPqD2XuIpgqNE5NSJiXJjwAh4oUWS5A
	/b/MIk6dNMaXOJyWEkql7p0V7BriRmk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-9osGyCUJOHiAvFRkIULs4Q-1; Mon, 22 Jan 2024 10:08:52 -0500
X-MC-Unique: 9osGyCUJOHiAvFRkIULs4Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 32FC5870828
	for <mptcp@lists.linux.dev>; Mon, 22 Jan 2024 15:08:51 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.226.128])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B66221C060AF
	for <mptcp@lists.linux.dev>; Mon, 22 Jan 2024 15:08:50 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 1/7] mptcp: push ad DSS boundaries
Date: Mon, 22 Jan 2024 16:08:38 +0100
Message-ID: <59d94e4297902d25829276df006615bbdd5f717f.1705836321.git.pabeni@redhat.com>
In-Reply-To: <cover.1705836321.git.pabeni@redhat.com>
References: <cover.1705836321.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

when inserting/creating skbs on the subflow write queue, if
the to-be-appended data don't is not contiguous to the tail data,
the protocol creates a new skb and prevent the TCP stack from
merging it later by setting the EOR marker.

Still no push flag is explicitly set at the end of previous GSO
packet, making the aggregation on the receiver side sub-optimal -
and packetdrill self-tests less predictable.

Explicitly mark the end of not contiguous DSS with the push flag.

Fixes: 6d0060f600ad ("mptcp: Write MPTCP DSS headers to outgoing data packets")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
This could also land on next, as needed, dropping the fixes tag
---
 net/mptcp/protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 744b4d6f15f4..4d7131f96ebf 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1264,6 +1264,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 		mpext = mptcp_get_ext(skb);
 		if (!mptcp_skb_can_collapse_to(data_seq, skb, mpext)) {
 			TCP_SKB_CB(skb)->eor = 1;
+			tcp_mark_push(tcp_sk(ssk), skb);
 			goto alloc_skb;
 		}
 
-- 
2.43.0

