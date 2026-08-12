Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F429470E85
	for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 17:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786554516; cv=none; b=C4ElQxtUJuiLFWJl/FP/3CHHq488vXBNMQad5zUhO24YAo9bigNrU7wXo11x5xZa//E/V9E1W42nKt/1WfKavRtESEwbcrQPCJhbLw7UZGTp3RS8shXf+4fh1jvNebzvjqXNcoteOBY5ClMrGwNHyo2p/eT3Q5c6s5Q/yfdm+2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786554516; c=relaxed/simple;
	bh=7egbk8BdLZFVc917cZELEcTiUGItdOARMnlbr/mN4Bk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=UPIxK2vaYIVYVrsHFT23h6B1h3QTlKK9eoUNyy+bAG2cZc5j2OuCa1dUDjjStRk/I7q2De1Fflvg/+3bNwjuQkzNwL0B80ImstET9cuyh5eJXtW6aaEHTHx/sXvyvi2TVpQN/lndLTyKcwzHD4XgquhD2dy0PG6UO/LuKGrFPlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RiA2+Rh+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RiA2+Rh+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786554514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K++/2TEDmYGi8tBJJj6M5b9OOqEs4w/1oBMQvj+0SyE=;
	b=RiA2+Rh+6Vdrb8QGl01qgKWTPdMRC1q4whr0Vb+LQV4uCAj2QX9gHqw3XIXG9g8XMyWAsY
	rR9+5hMCiNs5Q5OCGHF1qM56YoHnSxWaLfkiKMcL1cPNGtS6SjO5O3rbo/KAlSQl+WoV3w
	hBmUYrrQJhbna3iSJvGQLOT0Cr1wvlo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-475-icAy_wB-N7-ur-v_4Svg9g-1; Wed,
 12 Aug 2026 13:08:26 -0400
X-MC-Unique: icAy_wB-N7-ur-v_4Svg9g-1
X-Mimecast-MFC-AGG-ID: icAy_wB-N7-ur-v_4Svg9g_1786554506
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C933619560B9
	for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 17:08:25 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.162])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 157DA180034C
	for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 17:08:24 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 2/4] mptcp: avoid pruning for OoW data
Date: Wed, 12 Aug 2026 19:08:14 +0200
Message-ID: <1e1fa2d6fb756ab5a88a17c0d6e834f361cb9bdb.1786553006.git.pabeni@redhat.com>
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
X-Mimecast-MFC-PROC-ID: TMtbP3dPdgtTSoGDA5wOpUIdcmvx5P9_eA4ch1Mmhm8_1786554506
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Pruning is expansive and destructive, do it only when we expect
to accept the skb triggering the cleanup.

Fixes: e468d371180d ("mptcp: implemented OoO queue pruning")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f879b1061f2d..2ee23e9411be 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -313,12 +313,6 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 	u64 seq, end_seq, max_seq;
 	struct sk_buff *skb1;
 
-	if (!mptcp_try_rmem_schedule(sk, skb)) {
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
-		mptcp_drop(sk, skb);
-		return;
-	}
-
 	seq = MPTCP_SKB_CB(skb)->map_seq;
 	end_seq = MPTCP_SKB_CB(skb)->end_seq;
 	max_seq = atomic64_read(&msk->rcv_wnd_sent);
@@ -335,6 +329,12 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 		return;
 	}
 
+	if (!mptcp_try_rmem_schedule(sk, skb)) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
+		mptcp_drop(sk, skb);
+		return;
+	}
+
 	p = &msk->out_of_order_queue.rb_node;
 	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OFOQUEUE);
 	if (RB_EMPTY_ROOT(&msk->out_of_order_queue)) {
-- 
2.55.0

