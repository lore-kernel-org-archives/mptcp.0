Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA783074B7
	for <mptcp@lists.linux.dev>; Thu, 20 Nov 2025 08:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763628015; cv=none; b=Iay3U4a9PyyFOSVXe79twbDI101AzvNBAk0RwR1VRpWm1PZTkYYGQBrgMnRclvChv1C4d8uuHWnOU64Qck+as8t4S2iFWCvuPVVLQmrY9q5AxXfB1wxw8Oyn+erX188y0gC1PaRPyN8sPTNxuRO9h6RHDCrNgTgdNarAs0Plfig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763628015; c=relaxed/simple;
	bh=gSrdQwDjm115Q1m52SVCeJQ0DEmbVlnHJWkV3DRQlB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=iKb6ZU+cuqmzajyMDVG2Fy+k8ycbqLDhh6one3ueqOBC3i7dzNqDVnhhthcJQ3zgbGuKIiVlraXOrb84FEIxE3glHV75SeBiaUb7k+MKrj6U0D0w4voisiORPjKAa/ugvvCyGl6YpmJ3EABhT0zVAwp2jmlBaAUP82ipcyE8a4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cl+FIihW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cl+FIihW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763628012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ikoc2Af4yKSVFSmlXaLBzBKrx2pjEEo9eIOeqYbV7dM=;
	b=cl+FIihWyIIZCycEiexIHpzgpDOVZB8mA/x9PcP0IgMr02cDGZZlJSCM0CZ5qLsldE9y3n
	3/u5G2cwh3JWgDGNzvvvFun8I989alYSD80Yas9hBrhktcfNJxzmBBRE3pW+Vt3AFmdHND
	83C5C3C+wd4ZmW4/HgMYQXDjkidsBCk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-TEkwmGk6MK6W9smpGqNIZQ-1; Thu,
 20 Nov 2025 03:40:09 -0500
X-MC-Unique: TEkwmGk6MK6W9smpGqNIZQ-1
X-Mimecast-MFC-AGG-ID: TEkwmGk6MK6W9smpGqNIZQ_1763628008
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2A3861954B06;
	Thu, 20 Nov 2025 08:40:08 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.89])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ECAEE30044DB;
	Thu, 20 Nov 2025 08:40:06 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: martineau@kernel.org
Subject: [PATCH v7 mptcp-next 6/6] mptcp: add receive queue awareness in tcp_rcv_space_adjust()
Date: Thu, 20 Nov 2025 09:39:50 +0100
Message-ID: <9b2b80f0d291661ec13066502cf92823873e5ef9.1763625391.git.pabeni@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 3ZtAQH-7uNHlenwJFlXNY1YJ723pDGlQI8ti8PIfsNI_1763628008
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This is the mptcp counter-part of commit ea33537d8292 ("tcp: add receive
queue awareness in tcp_rcv_space_adjust()").

Prior to this commit:

ESTAB 33165568 0      192.168.255.2:5201 192.168.255.1:53380 \
	skmem:(r33076416,rb33554432,t0,tb91136,f448,w0,o0,bl0,d0)

After:
ESTAB 3279168 0      192.168.255.2:5201 192.168.255.1]:53042 \
	skmem:(r3190912,rb3719956,t0,tb91136,f1536,w0,o0,bl0,d0)
(same tput)

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5dde016a108d..6f4220c8b5bb 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2131,11 +2131,13 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 	if (rtt_us == U32_MAX || time < (rtt_us >> 3))
 		return;
 
-	if (msk->rcvq_space.copied <= msk->rcvq_space.space)
+	copied = msk->rcvq_space.copied;
+	copied -= mptcp_inq_hint(sk);
+	if (copied <= msk->rcvq_space.space)
 		goto new_measure;
 
 	trace_mptcp_rcvbuf_grow(sk, time);
-	if (mptcp_rcvbuf_grow(sk, msk->rcvq_space.copied)) {
+	if (mptcp_rcvbuf_grow(sk, copied)) {
 		/* Make subflows follow along.  If we do not do this, we
 		 * get drops at subflow level if skbs can't be moved to
 		 * the mptcp rx queue fast enough (announced rcv_win can
@@ -2149,7 +2151,7 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 			slow = lock_sock_fast(ssk);
 			/* subflows can be added before tcp_init_transfer() */
 			if (tcp_sk(ssk)->rcvq_space.space)
-				tcp_rcvbuf_grow(ssk, msk->rcvq_space.copied);
+				tcp_rcvbuf_grow(ssk, copied);
 			unlock_sock_fast(ssk, slow);
 		}
 	}
-- 
2.51.1

