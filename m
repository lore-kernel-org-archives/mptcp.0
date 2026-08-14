Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535C1432E6C
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 13:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786714732; cv=none; b=mC+/K+FJnk++YnEk8KOpDkyUAvzKaGdmLnQoSW6rggSo8s48klEHeDxjG8IU4zMVYRztkAQWrio2wlrHfJYzQeZDlyw8Rmk8sCh1yt14L9P099YLfzQsuHyYeAhU7D3TIFyK33m7apB6lFetH1Tegki9OgfSotNg3dKBmDtxwZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786714732; c=relaxed/simple;
	bh=7egbk8BdLZFVc917cZELEcTiUGItdOARMnlbr/mN4Bk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=bM1KSAEHdWlzhZc4FjedEUe79JnBbWuvYcU5ziejY9BkIUXT/axTELrNEEu8nb+fgHQjUbstHRrnbz+xSPxjMGCr+BNyJRhkDICi7+Z9SCWLGXmUpF2l2BmNTOlxjuHBWDPvg6Z5i8lOJsBLloHcIXyTRY+vJLZdoLrsF5xwTzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y3Q3rUZk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y3Q3rUZk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786714728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K++/2TEDmYGi8tBJJj6M5b9OOqEs4w/1oBMQvj+0SyE=;
	b=Y3Q3rUZkrFvAjreYoewxlIJaTRzLUzlso1MMRTc+o6cMC+OO4sYA+DG6CvUSPaZb+1yPXm
	v8h/FkpFlJrSJyb4C8tcs+iXucU7QUsxcw8+7/Mr37fbJIiPL1KWLnNsSA3IvmsvgPE+w8
	Y2nqlG9xL7DR+gahRCWWFVwt3tWLowg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-HwzWae3xPyW_ufxZeBr78g-1; Fri,
 14 Aug 2026 09:38:34 -0400
X-MC-Unique: HwzWae3xPyW_ufxZeBr78g-1
X-Mimecast-MFC-AGG-ID: HwzWae3xPyW_ufxZeBr78g_1786714714
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EEF0F1955F3C
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 13:38:33 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.145])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3B86518005BD
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 13:38:32 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH resend mptcp-net 2/4] mptcp: avoid pruning for OoW data
Date: Fri, 14 Aug 2026 15:38:21 +0200
Message-ID: <9035d664610bd149b23f0380395419d0f2bbb4e0.1786713351.git.pabeni@redhat.com>
In-Reply-To: <cover.1786713351.git.pabeni@redhat.com>
References: <cover.1786713351.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SofnjoJqAjuS5iVt6z_W7VkcFT_vOHvhnQtjOJ5thkE_1786714714
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

