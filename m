Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBA23FC2
	for <mptcp@lists.linux.dev>; Tue, 21 Sep 2021 11:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1632224381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=itGcEwyjOs6Bt2rWM6D9pm2ZYUhnjp9s3RQJk57xkOo=;
	b=Hub10yDhUzNkQQDEEL2g52TlgNotwefxfJUAE1D7UHyykbXCbkb4cd00zQaJK0C8VbOQez
	jCSAkK4FU7d3mzXYuddp8Y7+oum/Wul1kz3cz0X2SENtZqRjRKypmdkhQWZaeiMM1gtR9U
	t9jvH+JdrUw6Gw26JVLjuCiF/EDXtpA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-HypfdXYhNc2UZXaHJpvhHQ-1; Tue, 21 Sep 2021 07:39:40 -0400
X-MC-Unique: HypfdXYhNc2UZXaHJpvhHQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2B49BBEE0
	for <mptcp@lists.linux.dev>; Tue, 21 Sep 2021 11:39:39 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.195.132])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2883660C17
	for <mptcp@lists.linux.dev>; Tue, 21 Sep 2021 11:39:38 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 2/3] Squash-to: "mptcp: stop relying on tcp_tx_skb_cache"
Date: Tue, 21 Sep 2021 13:39:26 +0200
Message-Id: <b0574a5a499744d3815bc2c52aa41cb128c6ea6f.1632217366.git.pabeni@redhat.com>
In-Reply-To: <cover.1632217366.git.pabeni@redhat.com>
References: <cover.1632217366.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

