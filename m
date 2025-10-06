Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7112925B31B
	for <mptcp@lists.linux.dev>; Mon,  6 Oct 2025 08:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759738351; cv=none; b=TgW95xwBuYZGK/8AUnVNTiIo8fGBO7kx5hEcw2zN+JMgdY47HhI4N4pQpv3cBgjK5ejtVvWvOY4KTXKYayh6UUiE4U9ro4odCLYmyl3dvs2nBL8faS1gOUm4xDzjHDftCDAa3scQvuBmn0IpXcZaCbdDMS6xiMk1WJsEcz05FJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759738351; c=relaxed/simple;
	bh=0oKTmU7OdCTyMZp3uwIrT+i0lLKCSdyOYRqTZOKbHg8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=ObK02VonVAf8jYG5/Pz/gmpAA2QkYHFHLx9MpdoWhLKH3UpjXKq7C5LowcV5+M0FMeezlL7zE/vKNe5VObQRnG3SIm5onyGhx9V2wp0UGEY/DpD4bFq75Xz9G38bkAzyceupG0oQdv86qSof9Hytp7AmBgdtYlJ/wK7t8QE5tMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JYyWfa1R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYyWfa1R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759738348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TI+V32yqwyyJNJfbK6CWiex3mp7/4O3p50gfIMhMP9Y=;
	b=JYyWfa1RNA6OF2K99xnW180+yTt9uwSrI/oNagCUUoaMt3gvuu3ZbdIFgJ2zi5zgMaDNcr
	deKbjBdKaWBBv0bDmC8USnHDWfL46FX9pNsvxPuOP0A48LBkoijd476tyyVYaJsIIi4BU1
	zLnLgaWJ6SXUROMJYwFvwccArEcDA/Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-5Sj34GgSPziqd0_aKX8JVA-1; Mon,
 06 Oct 2025 04:12:27 -0400
X-MC-Unique: 5Sj34GgSPziqd0_aKX8JVA-1
X-Mimecast-MFC-AGG-ID: 5Sj34GgSPziqd0_aKX8JVA_1759738346
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A4EB3180034C
	for <mptcp@lists.linux.dev>; Mon,  6 Oct 2025 08:12:26 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.92])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C9A7C1800578
	for <mptcp@lists.linux.dev>; Mon,  6 Oct 2025 08:12:25 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v5 mptcp-next 08/10] mptcp: drop the __mptcp_data_ready() helper
Date: Mon,  6 Oct 2025 10:12:07 +0200
Message-ID: <3a00908a19b756f2bea3b67a95380e81d11555db.1759737859.git.pabeni@redhat.com>
In-Reply-To: <cover.1759737859.git.pabeni@redhat.com>
References: <cover.1759737859.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kMFyfbc4ZHJBdXnm-H3DdhaLsiP7dUxdMrNXcg_7eSg_1759738346
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

It adds little clarity and there is a single user of such helper,
just inline it in the caller.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
  - v4 -> v5:
    split out of main backlog patch, to make the latter smaller
---
 net/mptcp/protocol.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e354f16f4a79f..05ee6bd26b7fa 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -838,18 +838,10 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
 	return moved;
 }
 
-static void __mptcp_data_ready(struct sock *sk, struct sock *ssk)
-{
-	struct mptcp_sock *msk = mptcp_sk(sk);
-
-	/* Wake-up the reader only for in-sequence data */
-	if (move_skbs_to_msk(msk, ssk) && mptcp_epollin_ready(sk))
-		sk->sk_data_ready(sk);
-}
-
 void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+	struct mptcp_sock *msk = mptcp_sk(sk);
 
 	/* The peer can send data while we are shutting down this
 	 * subflow at msk destruction time, but we must avoid enqueuing
@@ -859,10 +851,14 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 		return;
 
 	mptcp_data_lock(sk);
-	if (!sock_owned_by_user(sk))
-		__mptcp_data_ready(sk, ssk);
-	else
+	if (!sock_owned_by_user(sk)) {
+		/* Wake-up the reader only for in-sequence data */
+		if (move_skbs_to_msk(msk, ssk) && mptcp_epollin_ready(sk))
+			sk->sk_data_ready(sk);
+		
+	} else {
 		__set_bit(MPTCP_DEQUEUE, &mptcp_sk(sk)->cb_flags);
+	}
 	mptcp_data_unlock(sk);
 }
 
-- 
2.51.0

