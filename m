Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6772505AF
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 15:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297229; cv=none; b=rJ9W2zFnwiBiTHTay69CEePyhiitzY4VdzxsAPCikWV5Upimg3bt3DDESfEGJ6w8qXMNExYShRZG0g0RL1KGoiV7bvp+WiRx2FitEEEpDqE6VTgCgBICj5vxK0n7naRa5CgJh79pJ1DDbimKLhaeWSTvTDI3rvth5LuGSoLgKSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297229; c=relaxed/simple;
	bh=iAk9vAqzYYHZFIYPQEV97rMnlF28ztGVhSBzCPolCZQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=MxGPEKDM1kuDMlgQOqxXJYFbv9wAmlL34j0OaNmlZuN1jvAy2uwWtP777oSHaAG5x9JvRlTZr1QQ0Y9HADXg8xPgauyoalQ7OMAX/CEN1WBUQeKSyHe8XtLtjxl6tidd1SdLZeu+F6RIPxGNbos/4od1myG06CPJyZ2rKWXmDKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TMj+qoAG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TMj+qoAG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758297226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SB0keMRJCj4LZh81uFy12X67Aef/jHRbynACS4wQha4=;
	b=TMj+qoAGDXh7Ljfy77f3jZbqALGlWR854p8/H1n+L0QZ6GWeeZsHbr9NL1ITYVryYzlYh+
	cm4weK1rZ5UgwbAcAS3hV5CKQJ3ae275TiJ/NESI9MiHFGF5OsqFFWjmTEz3+A+BQMMbaL
	ecoFvzYnpKyrSnfgm1eoL1v2zbkH92o=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-0uN0OJTUMVyRN-kc4kn6Zw-1; Fri,
 19 Sep 2025 11:53:45 -0400
X-MC-Unique: 0uN0OJTUMVyRN-kc4kn6Zw-1
X-Mimecast-MFC-AGG-ID: 0uN0OJTUMVyRN-kc4kn6Zw_1758297225
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F141B1955D61
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 15:53:44 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.255])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D86001800452
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 15:53:43 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [MPTCP next v3 05/12] mptcp: remove unneeded mptcp_move_skb()
Date: Fri, 19 Sep 2025 17:53:19 +0200
Message-ID: <03ffaacc72b31e3b822cff59bbde8a9867ff34a0.1758296923.git.pabeni@redhat.com>
In-Reply-To: <cover.1758296923.git.pabeni@redhat.com>
References: <cover.1758296923.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 61EwaH7HR6a60C82bquzsCYvEit73x0-t3zY0R_bccA_1758297225
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Since commit b7535cfed223 ("mptcp: drop legacy code around RX EOF"),
sk_shutdown can't change during the main recvmsg loop, we can drop
the related race breaker.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Tested-by: Geliang Tang <geliang@kernel.org>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3aa03da781ba3..909c611d5b528 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2207,14 +2207,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
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

