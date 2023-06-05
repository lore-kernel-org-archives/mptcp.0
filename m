Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9863525E
	for <mptcp@lists.linux.dev>; Mon,  5 Jun 2023 11:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1685963213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RIAa44Nw4Ko/G+F94N6U3VkU31K/U5QHtxIP0BOdoz4=;
	b=gkAMkj9NIW5dxVIQhuU2K2Q1pUCJJoFfcIqHKs219BHE/UIGnCyp1XOegwjTz7cfpCI1cP
	LfU5g0JEjP5JlldKxzhbkWfD7H99wxnv5tAfnVXlEGFKdOgc1eZDNPp52Khez1K1UposQH
	0X0//tdBtsnWdsE8YQu6WqXmVnOwLv0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-283-4IZT6kPDNW-VuuKOYxygpA-1; Mon, 05 Jun 2023 07:06:50 -0400
X-MC-Unique: 4IZT6kPDNW-VuuKOYxygpA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 11A988030D2;
	Mon,  5 Jun 2023 11:06:35 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.47])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 713F4C154D1;
	Mon,  5 Jun 2023 11:06:34 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
Subject: [PATCH mptcp-net 2/2] Squash-to: "mptcp: fix possible divide by zero in recvmsg()"
Date: Mon,  5 Jun 2023 13:06:29 +0200
Message-Id: <b9ce50f332a9b4065f628174eab8d18cd7c8c6e5.1685963110.git.pabeni@redhat.com>
In-Reply-To: <829e91b37a2fc12a9a43f20204d26adc0572a7d3.1685963110.git.pabeni@redhat.com>
References: <829e91b37a2fc12a9a43f20204d26adc0572a7d3.1685963110.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Just to be on the safe side, clear the sk_wait_pending flag
at clone time.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index cbfa4c3ddc3a..f2e9f72c1c9a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3209,6 +3209,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 		inet_sk(nsk)->pinet6 = mptcp_inet6_sk(nsk);
 #endif
 
+	nsk->sk_wait_pending = 0;
 	__mptcp_init_sock(nsk);
 
 	msk = mptcp_sk(nsk);
-- 
2.40.1

