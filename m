Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4CD30F942
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 17:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758215717; cv=none; b=kiACWJRitl5OjFoyowC/ZIJ+pnMg1AX8LLFtGQuf5FRZfDrnUW0qeFKMUrGn608JPKFdK9ooqXLaS3iVuY77Pyxo8/gVuTEwsmbrufPXJ2FqlTqMWZyr++vumlkGIFtRumPmy7VdwjzhS9WRYe2DWiAZVT3Ji+q/+8zUqJBKeq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758215717; c=relaxed/simple;
	bh=K6ctqniz4MqCgYN4M0X3wK8RLcGTd7ob4n5kuhH/XWc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=lwhyhsHMCHW14I3jLjDsN5d5YW5N86TBLhPKg5LpfmTI8GbTbnIvHvADssyV7YIXOo5ri/Z+JaRT8X1t8svIx0KmkwJZq8ieayAL/m4FR06EPDO4h1yFk3qiog2tb8ht1Ytyu9vO1FohSlIjUbcErG7en4InYTgSAHYVCN27Bw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TxVqm0cB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TxVqm0cB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758215714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g16rwBZNuHoXhhZOSYTD1NsXSEHq8MGZ70HBC/qLjJM=;
	b=TxVqm0cBSt9IeS4jPOyOzOg2X/FL2h0v+ZTgFiIz73+3SGYUn0bHpu6gCX0pUekGftNYwt
	Nv2TNXz8Nhq4A9xQWBtXK5GtSVmQkBGlwbFYZ2oDvNQtRZzXp/0B0sEOvEgJO8QOvxn0hW
	wI5fECiHXVnM9dNKSkeUDpcQvueuERw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-UaygwrG6P0OOAud6UAzMdQ-1; Thu,
 18 Sep 2025 13:15:12 -0400
X-MC-Unique: UaygwrG6P0OOAud6UAzMdQ-1
X-Mimecast-MFC-AGG-ID: UaygwrG6P0OOAud6UAzMdQ_1758215711
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A2E11195608E
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 17:15:11 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.207])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C562730002C6
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 17:15:10 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 05/12] mptcp: remove unneeded mptcp_move_skb()
Date: Thu, 18 Sep 2025 19:14:47 +0200
Message-ID: <ef7887b4b1762d95f5fa64659083153d476ba467.1758214564.git.pabeni@redhat.com>
In-Reply-To: <cover.1758214563.git.pabeni@redhat.com>
References: <cover.1758214563.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: k2L4mIf6OUxF6Rz8ln4YO3puvidMBLFoNdUGtOpPtMA_1758215711
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Since commit b7535cfed223 ("mptcp: drop legacy code around RX EOF"),
sk_shutdown can't change during the main recvmsg loop, we can drop
the related race breaker.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 048056b29a92d..19b5b925e2acc 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2202,14 +2202,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 				break;
 			}
 
-			if (sk->sk_shutdown & RCV_SHUTDOWN) {
-				/* race breaker: the shutdown could be after the
-				 * previous receive queue check
-				 */
-				if (__mptcp_move_skbs(sk))
-					continue;
+			if (sk->sk_shutdown & RCV_SHUTDOWN)
 				break;
-			}
 
 			if (sk->sk_state == TCP_CLOSE) {
 				copied = -ENOTCONN;
-- 
2.51.0

