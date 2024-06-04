Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1934C91
	for <mptcp@lists.linux.dev>; Tue,  4 Jun 2024 15:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717513970; cv=none; b=kMN1K2HNpsGKIOeD4pqzH16Q9PDehnfLT+fk+bK2V+qIlbcW4ArmyjaarRF2gYgNNiYLr/zxoHQlKTqP76GOiUd5cErJ8Bop98N3oYE+c9P/ukBBNVcM1o9bqwJjLKNCDrgiqNVtc3BV4QZApt7Ta12ZnCXpAp2eVsLZPAuO6pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717513970; c=relaxed/simple;
	bh=4mTIPnVDqRAWaWo2P3xfyXByKlvb+qMN3xsNPaQ8GGM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CZonkshNsE5rHS8gfChdl2x1pBVVxEe0Tugr+Gupmh1gPRKLxRQrH94wd4pB8FOhe/dv5lW1BPXyopS8Hk92fY84fwgZJcKzUWaerkB4ttbYxYnKz1IG6Qe24LH6BoUW91KbH05nN7xPMbcr84tpERgG6x/YDv3vWLREyag4IjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eyL/RXmu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eyL/RXmu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717513967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qvJ+E+cNvqgeDmz68puB1pObXsq4qGK+Yu025xgHkzs=;
	b=eyL/RXmuhaIVkU+B1K72DUEqrdMxALG70VDL9g5JJCDIRprLJMGPxweNv+5F71sGF5S2Mk
	pnuRM7imVfizEgnqdXE7NGMzpKVm7DJiAKfbp3iwa05S8GmbxalnPAtqp9jg47uNJ4+adN
	TyE82w4rcVdBmH7dXXCDPzRSYfsCGJs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-w5POvcGyNXW2ob5G6TxQ_Q-1; Tue, 04 Jun 2024 11:12:46 -0400
X-MC-Unique: w5POvcGyNXW2ob5G6TxQ_Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 45059185A78E
	for <mptcp@lists.linux.dev>; Tue,  4 Jun 2024 15:12:44 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.192])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C66B91C060D2
	for <mptcp@lists.linux.dev>; Tue,  4 Jun 2024 15:12:43 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] mptcp: ensure snd_una is properly initialized on connect
Date: Tue,  4 Jun 2024 17:12:36 +0200
Message-ID: <61aae3730b8c35c2e0b8b70f5f2fe5170067f5c8.1717512099.git.pabeni@redhat.com>
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

This is strictly related to commit fb7a0d334894 ("mptcp: ensure snd_nxt
is properly initialized on connect"). It turns out that syzkaller can
trigger the retransmit after fallback and before processing any other
incoming packet - so that snd_una is still left uninitialized.

Address the issue explicitly initializing snd_una together with snd_nxt
and write_seq.

Suggested-by: Mat Martineau <martineau@kernel.org>
Fixes: 8fd738049ac3 ("mptcp: fallback in case of simultaneous connect")
Cc: stable@vger.kernel.org
Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/485
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2f8f32cd31d3..1c5b7796daaf 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3735,6 +3735,7 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 
 	WRITE_ONCE(msk->write_seq, subflow->idsn);
 	WRITE_ONCE(msk->snd_nxt, subflow->idsn);
+	WRITE_ONCE(msk->snd_una, subflow->idsn);
 	if (likely(!__mptcp_check_fallback(msk)))
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEACTIVE);
 
-- 
2.43.2

