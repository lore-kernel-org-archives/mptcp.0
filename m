Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8646F2D9789
	for <mptcp@lists.linux.dev>; Thu, 20 Nov 2025 08:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763628009; cv=none; b=mDWjV0f8lgSX0UHjVVhJB28opMP+PZUaX9YBruM+xRI/ovzJyaCJajBiZsqTljfCCvW5c1ZxGdWLHyCx9SBsoIfF0Xd5YDgv+EftfIMikCDtKjln+iTo113p1bR9PKfXaH5dD+7RQaPw88C0v9+Ex8iID5+hO+cms/e2KPSDO/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763628009; c=relaxed/simple;
	bh=BptF/KopwGiedURcoRj3W1/F6WZNSbGRSKtLJtmeocw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=rz24/votO0gX1egItf7BpiRnSdm1nERyves3MIQ9euWiA/+mNW5iQG7ukyIOqgOd75AdOZH1XPIRS4anwPDJ1RqF5FCcSrQeZYioS/lJj9gkKkp/8pILjlpjKeQh3AhNBB7WYt//AMgN6y/RW21u+/dQzuzQNf4nu5RI8DJ4cys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K8UbKtd1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K8UbKtd1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763628006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W9hFOFktoE5+jnuEW3U7u6oJwwx87zQVPK58e+dZDwk=;
	b=K8UbKtd1E94h5hC36jU4yNfJsNnSeun6I4CBa+Y6Hg30KM9sEezTZ9+lR+Z4kABalo0Iwm
	YxomxWTc21rnCenKaTzqZ6D9ftb2DZERwIkUjb0RzJherkcccEG8GHT+i4FkvLFSgoh41J
	L5RrJ74Wv/ooBtp2tMByd0VUeCZONgQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-wEsfFdg8PXWQKuL7hUto7w-1; Thu,
 20 Nov 2025 03:40:02 -0500
X-MC-Unique: wEsfFdg8PXWQKuL7hUto7w-1
X-Mimecast-MFC-AGG-ID: wEsfFdg8PXWQKuL7hUto7w_1763628001
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D2D8180035D;
	Thu, 20 Nov 2025 08:40:01 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.89])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 27BA93001E83;
	Thu, 20 Nov 2025 08:39:59 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: martineau@kernel.org
Subject: [PATCH v7 mptcp-next 2/6] mptcp: do not account for OoO in mptcp_rcvbuf_grow()
Date: Thu, 20 Nov 2025 09:39:46 +0100
Message-ID: <069348a7ea6d0ee86d1003a89dc343c540efa776.1763625391.git.pabeni@redhat.com>
In-Reply-To: <cover.1763625391.git.pabeni@redhat.com>
References: <cover.1763625391.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PDMIgSD45TnBwmQ3cM2Rh2Xrj-E7-bFlZFX07sl3_0I_1763628001
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

MPTCP-level OoOs are physiological when multiple subflows are active
concurrently and will not cause retransmissions nor are caused by
drops.

Accounting for them in mptcp_rcvbuf_grow() causes the rcvbuf slowly
drifting towards tcp_rmem[2].

Remove such accounting. Note that subflows will still account for TCP-level
OoO when the MPTCP-level rcvbuf is propagated.

This also closes a subtle and very unlikely race condition with rcvspace
init; active sockets with user-space holding the msk-level socket lock,
could complete such initialization in the receive callback, after that the
first OoO data reaches the rcvbuf and potentially triggering a divide by
zero Oops.

Fixes: e118cdc34dd1 ("mptcp: rcvbuf auto-tuning improvement")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 64f592a7897c..e31ccc4bbb2d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -226,9 +226,6 @@ static bool mptcp_rcvbuf_grow(struct sock *sk, u32 newval)
 	do_div(grow, oldval);
 	rcvwin += grow << 1;
 
-	if (!RB_EMPTY_ROOT(&msk->out_of_order_queue))
-		rcvwin += MPTCP_SKB_CB(msk->ooo_last_skb)->end_seq - msk->ack_seq;
-
 	cap = READ_ONCE(net->ipv4.sysctl_tcp_rmem[2]);
 
 	rcvbuf = min_t(u32, mptcp_space_from_win(sk, rcvwin), cap);
@@ -352,9 +349,6 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 end:
 	skb_condense(skb);
 	skb_set_owner_r(skb, sk);
-	/* do not grow rcvbuf for not-yet-accepted or orphaned sockets. */
-	if (sk->sk_socket)
-		mptcp_rcvbuf_grow(sk, msk->rcvq_space.space);
 }
 
 static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
-- 
2.51.1

