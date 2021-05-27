Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D01170
	for <mptcp@lists.linux.dev>; Thu, 27 May 2021 16:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1622134398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3+HuBRfU/qb/NiMgJ4TcpPumyAhp4ui4+Pe6lYR3Hsw=;
	b=LzQW/u28OVomHPSpn5cAj7uhuW+LPorh23z2XDcNKN32+jNcKs4RBPc6Lw0mFsiiwNt7S4
	1qQohuk3t2HyzbfiKx8ndISSkzTWtIDUbUMyoX1ifWUvRVGNtYmo+yUVOUHGJ+zmO/yibJ
	7FU3nhive+PUgB6aq/P9Q1qNHx1fjKc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-b_us29eDNWCzWDgAgzFGgA-1; Thu, 27 May 2021 12:53:16 -0400
X-MC-Unique: b_us29eDNWCzWDgAgzFGgA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9C3F501E8
	for <mptcp@lists.linux.dev>; Thu, 27 May 2021 16:53:15 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-114-53.ams2.redhat.com [10.36.114.53])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2FAAE510ED
	for <mptcp@lists.linux.dev>; Thu, 27 May 2021 16:53:15 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 1/2] mptcp: don't clear MPTCP_DATA_READY in sk_wait_event()
Date: Thu, 27 May 2021 18:53:04 +0200
Message-Id: <f5012973f81c910c876c599ad5956ecc7c31a40e.1622132917.git.pabeni@redhat.com>
In-Reply-To: <cover.1622132917.git.pabeni@redhat.com>
References: <cover.1622132917.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

If we don't flush entirely the receive queue, we need set
again such bit later. We can simply avoid clearing it.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1e77d2defd28..a08ea8867716 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1711,7 +1711,7 @@ static void mptcp_wait_data(struct sock *sk, long *timeo)
 	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
 
 	sk_wait_event(sk, timeo,
-		      test_and_clear_bit(MPTCP_DATA_READY, &msk->flags), &wait);
+		      test_bit(MPTCP_DATA_READY, &msk->flags), &wait);
 
 	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
 	remove_wait_queue(sk_sleep(sk), &wait);
@@ -2032,10 +2032,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		 */
 		if (unlikely(__mptcp_move_skbs(msk)))
 			set_bit(MPTCP_DATA_READY, &msk->flags);
-	} else if (unlikely(!test_bit(MPTCP_DATA_READY, &msk->flags))) {
-		/* data to read but mptcp_wait_data() cleared DATA_READY */
-		set_bit(MPTCP_DATA_READY, &msk->flags);
 	}
+
 out_err:
 	if (cmsg_flags && copied >= 0) {
 		if (cmsg_flags & MPTCP_CMSG_TS)
-- 
2.26.3

