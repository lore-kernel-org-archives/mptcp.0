Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E41937288F
	for <mptcp@lists.linux.dev>; Tue, 16 Sep 2025 16:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758040062; cv=none; b=X7JcFLeAItLB0mq88FThgRU0eabW0B8IBDrRlFby56PAjYcPBxUQ3/tSUhI2aM3SmAmoPg/vhQf2D5CmwCwkW9krqj4fxU7Y5Xn7iRsgQqnEVfujhgI50Fa9+eDEeBtNIRxrRZbslJE1vfUfwsFsKGN7uqmU5B2TAzIIdVSWMBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758040062; c=relaxed/simple;
	bh=PJtgScV8dzM5VgAM+a+8gNGgfjKjAFecr98H5bv0vH0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=q9WEf2Ert8dAWGTX1ePIyxdR1qBf9S1QkYbPfIMrlRIVaGhPonycKBpoxugeO5FuLVZ88y+RsjO98/gAUL6BbWh0qqDbp6E75mWzXAog2tqzxfS1Pl65vqWk6geE4CDir6qwCXbNgubfW6HnHDnTj6GY7RsH3hpvp8cuu0RavFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YHj2JLuL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YHj2JLuL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758040060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5o3xrUX/cHr+FIAFtYZDDKD6Fq96KT2JfZrc8infc3U=;
	b=YHj2JLuL0LhvtMMqICf7WsBibNDByLQATxy910pL97LK/bZY2OkrlvgwQsf4rSiRNHg0a+
	iuvU/59fhXwf1mk2LtdZCtCAgLu6Myky83D5AFJG5/1fR298sOIPDvlqz9WiOYK7/nkntF
	2SvNI6f0KxMUsn1Z/4dvDeFN+LLkOcM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-288-vIZRQ4EtPMKSJWkUGa7yQQ-1; Tue,
 16 Sep 2025 12:27:38 -0400
X-MC-Unique: vIZRQ4EtPMKSJWkUGa7yQQ-1
X-Mimecast-MFC-AGG-ID: vIZRQ4EtPMKSJWkUGa7yQQ_1758040058
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF7FE1800578
	for <mptcp@lists.linux.dev>; Tue, 16 Sep 2025 16:27:37 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.160])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0829319560B8
	for <mptcp@lists.linux.dev>; Tue, 16 Sep 2025 16:27:36 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [MPTCP next 07/12] mptcp: minor move_skbs_to_msk() cleanup
Date: Tue, 16 Sep 2025 18:27:17 +0200
Message-ID: <e8b5426ad03fcfae6daa9e97eb075bb9274a3f75.1758039775.git.pabeni@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 0BNPMNDUVDA1yJRNvFP4Uxu4p9p657yDXlq8ttwvWaY_1758040058
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
index e904571bb94e6..251760183118a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -799,12 +799,8 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
 
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

