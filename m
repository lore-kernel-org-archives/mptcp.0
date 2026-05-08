Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6562230648C
	for <mptcp@lists.linux.dev>; Fri,  8 May 2026 09:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778233711; cv=none; b=e7km77e5i4XpiTUt4WvDzVNjxFzElPzwEJNSxFWwoFe/ub4eMV31NgnW+YRFBiFZ8XeVWnwud9LK5/jS8gOLsGNgVZKo6tqj/AY7jY+NsiUh33sePO1WfmleW14jfijqapOoR6qk7W8l3qEp3F0ggvjv6sMZ7gy96pFaw3PWRLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778233711; c=relaxed/simple;
	bh=ORPM2fqQvM0dJeCplrj4qUIZ9eItY+EAvlG1tmq4I84=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=hMxiWF/zyLb+Mfm4/fuav9Vsz+E78omw1Fs76EJFXqJ0N6TtBvjUEwoaZtXj9yZpdoSqHgjRyk0PimxUDA1lGyL7Uragz0mFFFm/OQ6Rw/3tMwE0HMmiq2MMqaVJ6GjGlmNZFD4sVO3lIH5Ff5mJUrRlXlbnlizhjJS4Xm9p8aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TJyLVUXN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TJyLVUXN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778233709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jsO9UQrlGYpRD6nFl9mJZJXO1zad+NZW0qSNQNxGvd0=;
	b=TJyLVUXNic1gCgUCQbduqkgnGS/3NMCrL3rTKW1EZDYbnCRSlWPi/BvyygmrD3o27jH8FY
	/RmfQCpUh1IkK/u+gaLKRXfv7fyPwk83wDtp5hNg0Q0UKRB0aBRKMS2upovSGRmJLQZvbY
	14UjhiIk/VlDvJO6afEi8374IaQJolA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-dXTM0u3UNhmWGHKSmyDJrg-1; Fri,
 08 May 2026 05:48:28 -0400
X-MC-Unique: dXTM0u3UNhmWGHKSmyDJrg-1
X-Mimecast-MFC-AGG-ID: dXTM0u3UNhmWGHKSmyDJrg_1778233707
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2FD33195608B
	for <mptcp@lists.linux.dev>; Fri,  8 May 2026 09:48:27 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.219])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5F03619560A2
	for <mptcp@lists.linux.dev>; Fri,  8 May 2026 09:48:26 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] mptcp: reset rcv wnd on disconnect
Date: Fri,  8 May 2026 11:48:22 +0200
Message-ID: <71899029874998e8436cab708b41cbc029772ad9.1778233686.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: f3ICXXGRfsPk0vy5IU3uyu35lS2KpEqUhLHg3hhC0aY_1778233707
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

If the MPTCP socket fallback to TCP before the MP handshake completion,
the IASN remain 0, and the rcv_wnd_sent filed is not explicitly
initialized, just incremented over time with the data transfer.

At disconnect time such value is not cleared. If the next connection falls
back to TCP before the MP handshake completion, the data transfer will
keep incrementing the receive window end sequence starting from the last
value used in the previous connection: the announced window will be
unrelated from the actual receiver buffer size and likely too big.

Address the issue zeroing the field at disconnect time.

Fixes: b29fcfb54cd7 ("mptcp: full disconnect implementation")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
Note that sockopt status is not reset (yet); that should not cause
functional issues and mirrors plain TCP behavior.
---
 net/mptcp/protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 17b9a8c13ebf..42cb55a5d617 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3472,6 +3472,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 
 	/* for fallback's sake */
 	WRITE_ONCE(msk->ack_seq, 0);
+	atomic64_set(&msk->rcv_wnd_sent, 0);
 
 	WRITE_ONCE(sk->sk_shutdown, 0);
 	sk_error_report(sk);
-- 
2.54.0

