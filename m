Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F161318141
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 17:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758215727; cv=none; b=C7nTw9GtU5DtvXOjHwm0eiwTx4eUVO5zcsrogsOF9eky3N/29raeNsxLDGRbq83IwDAMkHxdcq284imBYoDVpxPgcB2EftZ/bEfMmFkP90J7GQFYdS87z9DUDdvxZu9ucvBOFMLHjXWciJjN0JzdNsz3ZiBR8g1I4/xDQqjI9D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758215727; c=relaxed/simple;
	bh=BgPhdrdnMUrDF6QE4hEQDaKWzF+KV4FIU9bSXHFzDbM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=DRPM0ZvpMD+JlwoAOiaZVY37wCfj04LvqnlTr032hYf+XQD+XJwyiekpooVgWRbw5PZ5LYXNwSJ7aMIaoqEA4eVhuWzK1A7vXTsGuYO52tNKSQEq90m5MKyuBosFueVZ0qbCfiq2vgOKnNdli72CXSERkVYBNCkGYPjYG5iEQiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CbWtluCy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CbWtluCy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758215725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ze3XXSf5NNapAc678mCZq40V7l/IA2/jAVok2jLrHus=;
	b=CbWtluCymzvaRy0Sa0lL9UmlsJ/nFma4pMgs8tqzCcD7pgqv4Wlf9PyH3mREL7hupUlxl9
	4acIu0eLwLQlmxs3SxNRlZuDO1LcEaQhuxHjkHuuS3hztzZNeP4+TtQvXjwHFYt1LHKcb8
	K/iU1DKn19+tMnnBUKrog1XxEmKZvfw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-eE_B8Q0BNGeUcE5PBbrD5w-1; Thu,
 18 Sep 2025 13:15:23 -0400
X-MC-Unique: eE_B8Q0BNGeUcE5PBbrD5w-1
X-Mimecast-MFC-AGG-ID: eE_B8Q0BNGeUcE5PBbrD5w_1758215722
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 39DFB19560A1
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 17:15:22 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.207])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6B1B330002C5
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 17:15:21 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 12/12] mptcp: make fallback backlog aware
Date: Thu, 18 Sep 2025 19:14:55 +0200
Message-ID: <969bb267528128e861970168da3264822be48b35.1758214564.git.pabeni@redhat.com>
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
X-Mimecast-MFC-PROC-ID: XSjJX1_NMo_84yGnPAlD9oaz629GFF-6f2zAA8SdtHk_1758215722
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

MPTCP can't relay on ack_seq outside the msk socket log scope. With
packets pending in the backlog, such value can be quite far from the
actual dummy correct sequence map value.

Fallback dummy mapping are in sequence by definition, generate the
data seq from the subflow sequence.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/subflow.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 9baf3e54e46f2..8a64a1934d784 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -491,6 +491,9 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
 	mptcp_crypto_key_sha(subflow->remote_key, NULL, &subflow->iasn);
 	subflow->iasn++;
 
+	/* for fallback's sake */
+	subflow->map_seq = subflow->iasn;
+
 	WRITE_ONCE(msk->remote_key, subflow->remote_key);
 	WRITE_ONCE(msk->ack_seq, subflow->iasn);
 	WRITE_ONCE(msk->can_ack, true);
@@ -1425,9 +1428,12 @@ static bool subflow_check_data_avail(struct sock *ssk)
 
 	skb = skb_peek(&ssk->sk_receive_queue);
 	subflow->map_valid = 1;
-	subflow->map_seq = READ_ONCE(msk->ack_seq);
 	subflow->map_data_len = skb->len;
 	subflow->map_subflow_seq = tcp_sk(ssk)->copied_seq - subflow->ssn_offset;
+	subflow->map_seq = __mptcp_expand_seq(subflow->map_seq,
+					      subflow->iasn +
+					      TCP_SKB_CB(skb)->seq -
+					      subflow->ssn_offset - 1);
 	WRITE_ONCE(subflow->data_avail, true);
 
 	/* last skb in closed fallback subflow: we are at data fin */
-- 
2.51.0

