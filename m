Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B613002B6
	for <mptcp@lists.linux.dev>; Wed,  3 Dec 2025 18:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764786320; cv=none; b=OsMA6BMgTdQ8I3LIPnmJpRDPRs7QtSkmzX8j+kZ1OBnyCaZmknKZ0Gi6muLXFRNqt8P3TmZsCOGCwfeHT2CCFfFzr157PZwzoOBDsLs/men2hYmz1/PBozVxGz+wxMPlcmzxAWXDGTwtPZH3r4X3UShbc4vfynibIdvKHF8+66E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764786320; c=relaxed/simple;
	bh=OPc1i2YcovizJrx5xij2KqBskEdciCOX8oKORmsRCAA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=YFBoYQdeTsugUBFfb8enGCczrHk/wm95zpnuryBjbaSJq2OabJ9fKHYjldTtwBvAcaGa0IJ6ciP3en12xj8xUkjg0YSZH81mRb0GXR5Sh9mbrQ68cxUgjSdyq8G1GGQCyUpIyzFrC9WKg3tdbvhbk1vviFNi7Il9g0lsvbCyUok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HZd9amrl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HZd9amrl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764786316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xkRFqC/bBLytnxktmVT3PdAanA4cZb3w97brVIkmnsY=;
	b=HZd9amrlsZXuMiyCei4mUjs8hEYmLoM2kiHbfVn9+SsP3t2NlkqKvu0E5LTkA7RTtabWXQ
	+ghdPQp/Dsd8UiaDxjeLmjP96+Hj9xOiwd15E1QwGrae4/43LBfmUeXrGnkrMW21A6+/jj
	gjaOeDTsUv0QzmAkn1vAgqlGa/RqhUg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-BdLgJ4VHMr6VpjmpCmRIcg-1; Wed,
 03 Dec 2025 13:25:15 -0500
X-MC-Unique: BdLgJ4VHMr6VpjmpCmRIcg-1
X-Mimecast-MFC-AGG-ID: BdLgJ4VHMr6VpjmpCmRIcg_1764786314
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 27F6F180060D
	for <mptcp@lists.linux.dev>; Wed,  3 Dec 2025 18:25:14 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.2])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0D4C01954105
	for <mptcp@lists.linux.dev>; Wed,  3 Dec 2025 18:25:12 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next] mptcp: cleanup duplicate ack suppression on fastclose.
Date: Wed,  3 Dec 2025 19:25:07 +0100
Message-ID: <6d4733b0268246892cbbb8c2d3bcebce1714404a.1764786299.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7NwQiCDnCBC2saNDRnAfpNdhVFDuTSOqAlvAK1FjIQE_1764786314
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The current transition to TCP_CLOSE in __mptcp_close_ssk() is rather
obscure, especially since it's done unconditionally for all subflow.

Such action is needed only when disposing the given socket - that is
for MPJ subflows, or at mptcp close time.

Move the statement in a better place and explain it's role for future
memory.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index cd5a19ab3ba1..61066eb81412 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2533,9 +2533,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	if (dispose_it)
 		list_del(&subflow->node);
 
-	if (subflow->send_fastclose && ssk->sk_state != TCP_CLOSE)
-		tcp_set_state(ssk, TCP_CLOSE);
-
 	need_push = (flags & MPTCP_CF_PUSH) && __mptcp_retransmit_pending_data(sk);
 	if (!dispose_it) {
 		__mptcp_subflow_disconnect(ssk, subflow, flags);
@@ -2554,6 +2551,10 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		WARN_ON_ONCE(!sock_flag(ssk, SOCK_DEAD));
 		kfree_rcu(subflow, rcu);
 	} else {
+		/* Prevent __tcp_close() from sending additional resets */
+		if (subflow->send_fastclose && ssk->sk_state != TCP_CLOSE)
+			tcp_set_state(ssk, TCP_CLOSE);
+
 		/* otherwise tcp will dispose of the ssk and subflow ctx */
 		__tcp_close(ssk, 0);
 
-- 
2.52.0

