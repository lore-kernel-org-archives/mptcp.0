Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE670111BD
	for <mptcp@lists.linux.dev>; Mon, 10 Jul 2023 12:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688993731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=925XH7rhHy4oeT94nvedTJLpn0V7Xv3qUcI6KTOzJz0=;
	b=Fa+x6ouuu/1OC0OVj1nlP5+AgcsFD3niAHNQOmdomi7Gs2Mbk8felShU5SlbZldz4OVXfM
	qCU7SMZco6DvVU311YBuxhZn7kr8/syJ36n0YIItMTgM1HMWslOcROhkKTLAiCKgKhbzxO
	OQI8IfPP/drhWRDILyZ8+3SjcihNkiw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-YRApKD9oPF2V6HYRRULJ-Q-1; Mon, 10 Jul 2023 08:55:29 -0400
X-MC-Unique: YRApKD9oPF2V6HYRRULJ-Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 710DA380671E
	for <mptcp@lists.linux.dev>; Mon, 10 Jul 2023 12:55:29 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 00C89C09A09
	for <mptcp@lists.linux.dev>; Mon, 10 Jul 2023 12:55:28 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 09/14] mptcp: avoid additional indirection in mptcp_poll()
Date: Mon, 10 Jul 2023 14:55:04 +0200
Message-ID: <e3f2b0397e0d8fd03ca5c30bd34c3ddd973ba4eb.1688993569.git.pabeni@redhat.com>
In-Reply-To: <cover.1688993569.git.pabeni@redhat.com>
References: <cover.1688993569.git.pabeni@redhat.com>
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

We are going to remove the first subflow socket soon, so avoid
the addictional indirection at poll() time. Instead access
directly the first subflow sock.

No functional changes intended.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c5da7a172ee9..4e5c9770d8d6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3884,12 +3884,12 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 	state = inet_sk_state_load(sk);
 	pr_debug("msk=%p state=%d flags=%lx", msk, state, msk->flags);
 	if (state == TCP_LISTEN) {
-		struct socket *ssock = READ_ONCE(msk->subflow);
+		struct sock *ssk = READ_ONCE(msk->first);
 
-		if (WARN_ON_ONCE(!ssock || !ssock->sk))
+		if (WARN_ON_ONCE(!ssk))
 			return 0;
 
-		return inet_csk_listen_poll(ssock->sk);
+		return inet_csk_listen_poll(ssk);
 	}
 
 	shutdown = READ_ONCE(sk->sk_shutdown);
-- 
2.41.0

