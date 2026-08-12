Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0686447986C
	for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 17:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786554514; cv=none; b=XR6Lkk8L0/A0TX1avPy0eEhPOZX/x6GKOctQMQ7nD1OukhmOojMId6fTIY4cF8B+1WhCNeelysHHQBrdLQ+Qly37oObhzlofdB/koOp7e0HIrwJFln27sKDZnAsTKO1Ugt6zXlzw3uO7TaECHKE4tn6LLtJeo4AQfPg2diwh/GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786554514; c=relaxed/simple;
	bh=ADsFdpePGYXfBor74YWWVIDAGHMELG8aFyt4q070sz0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=UhpimQLF1hHqRYtAQeVlDa7UOhsRAnrUKUWNpzHTuj1iRNSK88nl5ndv5M2yj02Cez/wGeFhzkV0YXBlM9eL02BrPnX0NCrh0O//ZBdan+b4wgSb2/Tah7RtiSlVZbuI4Le8YBn+GUEVcWYlrIX03xBOG4i2QPtu3U9Fg2zMHV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZRLLWERa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZRLLWERa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786554510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cs25WEdfvYuA2Y8Klql5aaljxZ6QkCST6kYh+ssuAik=;
	b=ZRLLWERao12fwUIlsk3xitbRQBtc5agkC4pCBepcxtU7CaTMtVXEyOikvBCwo1fmiG/ZJe
	WRlSB0IkCLxQQGj3YZzAtDamSY1NR5ceW34lyCTZCVuyN472texx6/Z9ZVQbRkkA2MyTFC
	liz/csidcAZlM+QB2kT4lZNmdYtMKP8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-50vVZ_tbNPiHlniLhKDsIg-1; Wed,
 12 Aug 2026 13:08:29 -0400
X-MC-Unique: 50vVZ_tbNPiHlniLhKDsIg-1
X-Mimecast-MFC-AGG-ID: 50vVZ_tbNPiHlniLhKDsIg_1786554508
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F2D818002E8
	for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 17:08:28 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.162])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 74385180034F
	for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 17:08:27 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 4/4] mptcp: do not reschedule the RTX timer for fallback sockets
Date: Wed, 12 Aug 2026 19:08:16 +0200
Message-ID: <517def06b272a22027775a60334f3f68347510ae.1786553006.git.pabeni@redhat.com>
In-Reply-To: <cover.1786553006.git.pabeni@redhat.com>
References: <cover.1786553006.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 241loAVDrbP58Rf8o3PGwdar8JgPyEDAKaaUuHIm3ts_1786554508
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

On fallback socket the retrans timer is a quite convoluted no-op, but
currently nothing prevents the MPTCP core to keep rescheduling it.

Additionally gate RTX timer reset to the msk not being fallen back to
TCP yet. To avoid adding multiple tests in fast-path, use a new flags
bit for such condition.

Fixes: b51f9b80c032 ("mptcp: introduce MPTCP retransmission timer")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
In fact so convoluted that sashiko thinks otherwise. Sashiko:
in case of fallback there could be a single active subflow; it can't
become stale
---
 net/mptcp/protocol.c | 11 ++++++++---
 net/mptcp/protocol.h |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b311fe30c785..f22d64ab1c53 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -96,6 +96,7 @@ bool __mptcp_try_fallback(struct mptcp_sock *msk, int fb_mib)
 
 	msk->allow_subflows = false;
 	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
+	set_bit(MPTCP_RTX_DISABLED, &msk->flags);
 	__MPTCP_INC_STATS(net, fb_mib);
 	spin_unlock_bh(&msk->fallback_lock);
 	return true;
@@ -1121,13 +1122,14 @@ static bool mptcp_rtx_timer_pending(struct sock *sk)
 
 static void mptcp_reset_rtx_timer(struct sock *sk)
 {
+	struct mptcp_sock *msk = mptcp_sk(sk);
 	unsigned long tout;
 
-	/* prevent rescheduling on close */
-	if (unlikely(inet_sk_state_load(sk) == TCP_CLOSE))
+	/* Prevent rescheduling on close and in case of fallback. */
+	if (test_bit(MPTCP_RTX_DISABLED, &msk->flags))
 		return;
 
-	tout = mptcp_sk(sk)->timer_ival;
+	tout = msk->timer_ival;
 	sk_reset_timer(sk, &sk->mptcp_retransmit_timer, jiffies + tout);
 }
 
@@ -3360,6 +3362,9 @@ void mptcp_set_state(struct sock *sk, int state)
 		 * transition from TCP_SYN_RECV to TCP_CLOSE_WAIT.
 		 */
 		break;
+	case TCP_CLOSE:
+		set_bit(MPTCP_RTX_DISABLED, &mptcp_sk(sk)->flags);
+		fallthrough;
 	default:
 		if (oldstate == TCP_ESTABLISHED || oldstate == TCP_CLOSE_WAIT)
 			MPTCP_DEC_STATS(sock_net(sk), MPTCP_MIB_CURRESTAB);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7e168e450fb0..f9300d644ff3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -116,6 +116,7 @@
 #define MPTCP_WORK_RTX		1
 #define MPTCP_FALLBACK_DONE	2
 #define MPTCP_WORK_CLOSE_SUBFLOW 3
+#define MPTCP_RTX_DISABLED	4
 
 /* MPTCP socket release cb flags */
 #define MPTCP_PUSH_PENDING	1
-- 
2.55.0

