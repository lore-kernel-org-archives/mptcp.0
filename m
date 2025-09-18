Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056513168E1
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 17:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758215719; cv=none; b=fH7ZrHezvWikbO5VISaERvFNqIG6pM//oIc5g3TcLsc55niuoyzMhEYFox/E2Hmb+KHNNTNTzJIYtHIpgaSMVkJ9oK4Uwbwogufkl4Q/6JjxwpeDzlFcgkYexR1fhQQSd4zIel+iHMITVwPyNHPsyCPGZRUPsUQTVHvwnO+u5A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758215719; c=relaxed/simple;
	bh=37lawkX4xUrL567DXWA341zwSnEcjp+qFo+1e47ekOw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=CRMufqtqbubrtzsOAdRLxpI3t+H82JCTYO6qFk/oZD+iHSan/PhfbdUQULY5euTZyeBxKEFOLHNuz1lvEW0d6Vc2UF68MwqGNM6e7CZLhCF6PwI7KtFGQicKBaaOIBhl9D3BwKKMjeJEMnxvYNKZzn8ATqzL9wm0u+nCgKEB5vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eeo1MEV3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eeo1MEV3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758215716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MzF3xNMM885VbNTF3N9SH9lRQwPn/JFEuUZRwF5/6Po=;
	b=eeo1MEV3tbCX0inBbf6o9uKQsc6ilAgIIs9nvHO71xrN3hJcm+72Zp7YS2Q/GS0L8HTsFv
	KnU8fJgwWq5wB8mHmI8V8X/Ot1Lh6d5foz3zNvDLGQ3rwqtm2zuxwgjaRke0IV+0K8i+7X
	nnRphs1dZGGMRO0E4eEww+IJ1RdkqYs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-Ywh8iZHnMt-GtnAWsghS_w-1; Thu,
 18 Sep 2025 13:15:15 -0400
X-MC-Unique: Ywh8iZHnMt-GtnAWsghS_w-1
X-Mimecast-MFC-AGG-ID: Ywh8iZHnMt-GtnAWsghS_w_1758215714
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 534261955F6A
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 17:15:14 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.207])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 773A930002C5
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 17:15:13 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 07/12] mptcp: minor move_skbs_to_msk() cleanup
Date: Thu, 18 Sep 2025 19:14:49 +0200
Message-ID: <7874130ef3d034155655104b22712fa3c3c1d028.1758214564.git.pabeni@redhat.com>
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
X-Mimecast-MFC-PROC-ID: DimF5w9HRJzEWjDquHOYc672JS5UXZFOyk8NlkYclWE_1758215714
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Such function is called only by __mptcp_data_ready(), which in turn
is always invoked when msk is not owned by the user: we can drop the
redundant, related check.

Additionally mptcp needs to propagate the socket error only for
current subflow.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 66ad9a38a6082..02be42d3d11e6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -810,12 +810,8 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
 
 	moved = __mptcp_move_skbs_from_subflow(msk, ssk);
 	__mptcp_ofo_queue(msk);
-	if (unlikely(ssk->sk_err)) {
-		if (!sock_owned_by_user(sk))
-			__mptcp_error_report(sk);
-		else
-			__set_bit(MPTCP_ERROR_REPORT,  &msk->cb_flags);
-	}
+	if (unlikely(ssk->sk_err))
+		__mptcp_subflow_error_report(sk, ssk);
 
 	/* If the moves have caught up with the DATA_FIN sequence number
 	 * it's time to ack the DATA_FIN and change socket state, but
-- 
2.51.0

