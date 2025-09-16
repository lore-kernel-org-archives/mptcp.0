Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69868374279
	for <mptcp@lists.linux.dev>; Tue, 16 Sep 2025 16:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758040060; cv=none; b=qCV42pJQN7AjTYI6PyZ3hiISLFuixz8oorZNSeJbvn0hADN5GWmtZ7ZXSWIGKV3/Vf5qwW9xP0spjpB1x02jZuQAueviJYxOyMuUE53EoYjfJyC36QBwefsxKZEsigQQ36zQqbm+GkWanzvD1TpF4ukHhw3BHrA0TG36WUJKiZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758040060; c=relaxed/simple;
	bh=+AEhzCnelXlzSTvMeEtRWt5Ke4jhJX/pG4yLqdJfx9U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=hvPXD1b+o9iKlKb0iBfxi4kJf+sFvhm8j6LL9JgXmWI9dpRdfcgZK5KUC65phCNZCzDGxA4kmSlGhhsI1toxIFfKNBv7nXkHsarZKA7tlf6cmJasJH0c3ePmTqUigFkT+IXYq63yTBAS09Tm+88FFFN7sRWLdaa7ThSkVmpGt4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aVOdP7f9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aVOdP7f9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758040058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9BgdZXOV9jOuHR2lFR2miw2wuXgEo9Gl3x3DleKQNXg=;
	b=aVOdP7f9IPc5cu/I0RwXC6Iemgr/uSNG93dxTCr6umwzD4U5g4nm1vinjwph9c0TPetcI6
	14bXp5bhdah4Oh8x+2kw5HEyPn3H3l2xTJAzdQuo5AO8tLNE1b/AvjmM3IdIkLiuUKDxDf
	XUNrZNVzd3PE2EpOl6AUZ89Hgipee8c=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-cKZtV1mMP2S33Jghpt58qg-1; Tue,
 16 Sep 2025 12:27:37 -0400
X-MC-Unique: cKZtV1mMP2S33Jghpt58qg-1
X-Mimecast-MFC-AGG-ID: cKZtV1mMP2S33Jghpt58qg_1758040056
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C07B195609F
	for <mptcp@lists.linux.dev>; Tue, 16 Sep 2025 16:27:36 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.160])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7F7A019560B8
	for <mptcp@lists.linux.dev>; Tue, 16 Sep 2025 16:27:35 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [MPTCP next 06/12] mptcp: factor out a basic skb coalesce helper
Date: Tue, 16 Sep 2025 18:27:16 +0200
Message-ID: <11c0bc6ea9c43b0da423bf5abe44834a887fd2d7.1758039775.git.pabeni@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 2yvrMSj1U9WXn6Ao96lUnilH7z4ynOrQDsP8X9-mtTA_1758040056
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The upcoming patch will introduced backlog processing for MPTCP
socket, and we want to leverage coalescing in such data path.

Factor out the relevant bits not touching memory accounting to
deal with such use-case.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 58744823effc8..e904571bb94e6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -141,22 +141,34 @@ static void mptcp_drop(struct sock *sk, struct sk_buff *skb)
 	__kfree_skb(skb);
 }
 
-static bool mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
-			       struct sk_buff *from)
+static int __mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
+				struct sk_buff *from, bool *fragstolen)
 {
-	bool fragstolen;
+	int limit = READ_ONCE(sk->sk_rcvbuf);
 	int delta;
 
 	if (unlikely(MPTCP_SKB_CB(to)->cant_coalesce) ||
 	    MPTCP_SKB_CB(from)->offset ||
-	    ((to->len + from->len) > (sk->sk_rcvbuf >> 3)) ||
-	    !skb_try_coalesce(to, from, &fragstolen, &delta))
-		return false;
+	    ((to->len + from->len) > (limit >> 3)) ||
+	    !skb_try_coalesce(to, from, fragstolen, &delta))
+		return 0;
 
 	pr_debug("colesced seq %llx into %llx new len %d new end seq %llx\n",
 		 MPTCP_SKB_CB(from)->map_seq, MPTCP_SKB_CB(to)->map_seq,
 		 to->len, MPTCP_SKB_CB(from)->end_seq);
 	MPTCP_SKB_CB(to)->end_seq = MPTCP_SKB_CB(from)->end_seq;
+	return delta;
+}
+
+static bool mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
+			       struct sk_buff *from)
+{
+	bool fragstolen;
+	int delta;
+
+	delta = __mptcp_try_coalesce(sk, to, from, &fragstolen);
+	if (!delta)
+		return false;
 
 	/* note the fwd memory can reach a negative value after accounting
 	 * for the delta, but the later skb free will restore a non
-- 
2.51.0

