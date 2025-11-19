Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF03357A3F
	for <mptcp@lists.linux.dev>; Wed, 19 Nov 2025 12:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763554404; cv=none; b=XERiBrL4erf2B6dKo5AX7dLh0safTcPH4N22bQ6UUlCBJVIxQGMlfvD3pnMX8vwsF4XARsBa5ClVpt/55Of/YAS4oPO4mcHqUKIkbzinhR7B19uVn0TuiW7i7PjgBM13T8aADnn/tVC+V8waAANyT6jWNI28lkG8cjBPLBBkK7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763554404; c=relaxed/simple;
	bh=p3AY75uxgulzMgO3Ds0xv+pom+rcMnnCPMLqDx7YRN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=UDEfGaC/UdeM3v0jNzyA9nZsXUlz2CODukR26ePaE2dOcn8PKOhLiIB86kemIE+kwpYUIFiV8/a3BhqcmMndv4IHsLujF89ze+YODaggW2y7lEL4GFNoKdbYPa6Cf0BaFSlObW0l06DBFBX/COF0cwnypf7FWpAh2LeWpvU3vzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZaCFlE6u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZaCFlE6u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763554401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ZkNVVjsQQbyymzRFR61as68eh0OnfAaAeVOWC4eVw8=;
	b=ZaCFlE6uqerFtT7VIyg07KQ+yg/ECYN4AU/9inmcvGAKZ3ngKLqWOMXK3J+qWmDUbSHaju
	7bhsl6zuc/ryw3tgLpEWre98vyX+mgT5JMC6rq09uSViBvELdOk4sSgDitcTMXbDioZ4K1
	wyIiMbdsk1ao+svRWqWkTs5J14e7LsU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-waQqM_SUPpueUclHDcSiMw-1; Wed,
 19 Nov 2025 07:13:14 -0500
X-MC-Unique: waQqM_SUPpueUclHDcSiMw-1
X-Mimecast-MFC-AGG-ID: waQqM_SUPpueUclHDcSiMw_1763554391
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7C0EF1800451;
	Wed, 19 Nov 2025 12:13:11 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.89])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 54249195608E;
	Wed, 19 Nov 2025 12:13:09 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: martineau@kernel.org
Subject: [PATCH mptcp-next v5 5/5] mptcp: add receive queue awareness in tcp_rcv_space_adjust()
Date: Wed, 19 Nov 2025 13:12:58 +0100
Message-ID: <9b71450237deb12a03c8d05cedd5e8593950db0b.1763553361.git.pabeni@redhat.com>
In-Reply-To: <cover.1763553361.git.pabeni@redhat.com>
References: <cover.1763553361.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 35XTA34F2T-2GNhZcRehtqikImTXd2qMZu0Hpt09Azw_1763554391
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
index e30e408c4f52..aaaf5357084e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2136,11 +2136,13 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
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
@@ -2154,7 +2156,7 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
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

