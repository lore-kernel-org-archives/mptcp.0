Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFF42FB3
	for <mptcp@lists.linux.dev>; Mon, 20 Sep 2021 17:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1632158683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=itGcEwyjOs6Bt2rWM6D9pm2ZYUhnjp9s3RQJk57xkOo=;
	b=QO6xdZXxmoCKd8RMd+9uc8tupMcYk6siWmdRUT4/G8o7ROm85SFU9EObH60XuyeQdi7T8C
	u+pO64YTW/SSqABFpHlfDeck/QY664JFqjvLtHLaJqIaPbjHZZC3Gs2Ek/C63id7B66E8W
	QosvfRO5ORV2i2WPWa8zcxI0tQarc04=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-K4-7-mpyPz6BC9s98UT0eg-1; Mon, 20 Sep 2021 13:24:42 -0400
X-MC-Unique: K4-7-mpyPz6BC9s98UT0eg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EED91104FC0E
	for <mptcp@lists.linux.dev>; Mon, 20 Sep 2021 17:24:41 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.11])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 670076060F
	for <mptcp@lists.linux.dev>; Mon, 20 Sep 2021 17:24:41 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 2/3] Squash-to: "mptcp: stop relying on tcp_tx_skb_cache"
Date: Mon, 20 Sep 2021 19:24:28 +0200
Message-Id: <b0574a5a499744d3815bc2c52aa41cb128c6ea6f.1632158356.git.pabeni@redhat.com>
In-Reply-To: <cover.1632158356.git.pabeni@redhat.com>
References: <cover.1632158356.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

fix build after helper rename

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 48e0e3a945e4..87ee409d68ab 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1240,7 +1240,7 @@ static struct sk_buff *__mptcp_alloc_tx_skb(struct sock *sk, struct sock *ssk, g
 		return NULL;
 
 	if (likely(sk_wmem_schedule(ssk, skb->truesize))) {
-		skb_entail(ssk, skb);
+		tcp_skb_entail(ssk, skb);
 		return skb;
 	}
 	kfree_skb(skb);
-- 
2.26.3

