Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083EF3629AC
	for <mptcp@lists.linux.dev>; Tue, 16 Sep 2025 16:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758040060; cv=none; b=oIHbYGimfGwHTBMKalmUOg/lvD2VwoTDRzaxn8XLZz2vre7w5nQcuU5sZiONDjvnqBZmLFWM1FnZ/AinqqIWDxzBPyIgphfv241h86H9iUbEgxq0ElQ7CyrThn6JHToAdjSDbAI8NQZU8k51K5OCUkXopIfFPG7+rSVLjztGriM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758040060; c=relaxed/simple;
	bh=UrN2bCtaGuZZZlsrb7Sues0FQIRls8b3Id+lIBxhb5s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Tom6/qEFpO2iMeCmvSgnAphdP0d0IV3jYE6qJsx1jBd/bg2ss48xBYxq4c1AwOXYFnclU5GBWv1BfrhIdUhJj/RaYD7TNak9yCE3rSGKDWffzfPXPzcnmwhgJQPwdOf10Ksn9TRRwnrT/16Zw4mycna3/ZLnn8oXRI9u+eSzr4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YO8/AQ3J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YO8/AQ3J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758040058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hmPrS0XVlJrinw2xqry3vXCE+9sjdJPdx2HjxpLbHHQ=;
	b=YO8/AQ3JFH/3wLQf0QY3+DgOFIqZrcgreGXUKJWeVd1frVESf35vIvgl4X7BCOmfry0PyD
	3vOhLxP5ZeWXWjB/Q85TRWtnLpMfkaSP0nJZ1dCbJe3h1Lo/imxVs/bwL93wC3+ON8JM6u
	jFOdl9iz6rThg8SOipA/4/DVQhCuCvY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-rDTxUEbNMJydj86wqC_C5Q-1; Tue,
 16 Sep 2025 12:27:35 -0400
X-MC-Unique: rDTxUEbNMJydj86wqC_C5Q-1
X-Mimecast-MFC-AGG-ID: rDTxUEbNMJydj86wqC_C5Q_1758040055
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 02ABE1956096
	for <mptcp@lists.linux.dev>; Tue, 16 Sep 2025 16:27:35 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.160])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 20FD019560B8
	for <mptcp@lists.linux.dev>; Tue, 16 Sep 2025 16:27:33 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [MPTCP next 05/12] mptcp: remove unneeded mptcp_move_skb()
Date: Tue, 16 Sep 2025 18:27:15 +0200
Message-ID: <5df965245b1785907e6f54c6ea9b63b74dde9d0e.1758039775.git.pabeni@redhat.com>
In-Reply-To: <cover.1758039775.git.pabeni@redhat.com>
References: <cover.1758039775.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XoOalvxalZJGTFF3dDGEhhP-1aCHnrpGWv1iDWNwWtQ_1758040055
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
index 879157a1f4fb1..58744823effc8 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2173,14 +2173,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
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

