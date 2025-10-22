Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA61330325
	for <mptcp@lists.linux.dev>; Wed, 22 Oct 2025 14:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143546; cv=none; b=tpuZ6TDx8TR297NVwYnUrY/b9IuS/mOUY24h0ConSlJgLQ6d4n789Y9OewcY/zsTOmQV4XSkLQswAJrw5jm2zrYULNX2sXCp9W3PlYGfWMhE9aeiGVS/B3Zks6vtAmLT4mJ4cFIDLCHjHVAE3lZtNwEDnFGNyZKTOZNTuTQE8qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143546; c=relaxed/simple;
	bh=awA3VBsYZo3Op2bzU/pQGVj/YeDvjUparqV186Dl85E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=IcS/xU4InRDS4AkPeTgqEJz5702WnPNyUADj6AF8eQxwW7U6geIMsRq7n1oG4DhZdyerVbEVdCCyVkDkL17LLs0Mx03AndH3jjjheiPPnGqwRyoJ5n5JY09ERvohInHSrzQtIKRIdkxDqqRRmeWI2bbVLjx+OccitEfmxAEDzmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eIhcb3xT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eIhcb3xT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761143544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3wrNCfBcM2+0ja8CMsTK1rqUHGoAuuNWsOnjamBxLx8=;
	b=eIhcb3xT5QeGvOm8LMrvEOkVm9OcZW/GTIQ1MljxvhG8x9ALkXKJzNIwWzB/v9ThldE2bs
	vS7NieHmRoVvsZTKFce+7Y/8Kxx9S5VSODL3wrDipBYWKJjySXU1zH4xhA+Tv0cGzDNTPo
	6cYg9krFOVEHxDBNM3Fqc9VN3YfR+4w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-Q77VcR0MPJ6qDWngs4Pkqg-1; Wed,
 22 Oct 2025 10:32:19 -0400
X-MC-Unique: Q77VcR0MPJ6qDWngs4Pkqg-1
X-Mimecast-MFC-AGG-ID: Q77VcR0MPJ6qDWngs4Pkqg_1761143538
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6782D1805814;
	Wed, 22 Oct 2025 14:32:18 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.237])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F28B51954102;
	Wed, 22 Oct 2025 14:32:16 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH v6 mptcp-next 09/11] mptcp: drop the __mptcp_data_ready() helper
Date: Wed, 22 Oct 2025 16:31:52 +0200
Message-ID: <67952c23fbff74910a98b96d863cdb2468e9e011.1761142784.git.pabeni@redhat.com>
In-Reply-To: <cover.1761142784.git.pabeni@redhat.com>
References: <cover.1761142784.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TCNQUDISw-AK6wrHuL9otKAOlxAiC4W4GwaYX0V_QT4_1761143538
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
index 3653b10d24887e..c68a4b410e7e5b 100644
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

