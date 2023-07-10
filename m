Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2D5107B5
	for <mptcp@lists.linux.dev>; Mon, 10 Jul 2023 12:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688993724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CaDbT0AbMW2VG7IkI6iHpvyId7hdGT/wZljMZEIMCT4=;
	b=SA/Y7if4M7E1M17Fq0/tN+NOKqHJZDN5TRJ27WUV0k0jatf36kLg+9ynmdvQIuA4V6vXBE
	ZuJf7XxnI3lrwQRuzNGA31Z0zL10DyddJJKbLPHURZN++TL3NnjzBHFtKGyY+Y9bzvVtBf
	9Crz9ta76UznyvmDZ8S1X5ZmHAXHi68=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-434-PHXmCYJ0OFaLXmL3jn0ETQ-1; Mon, 10 Jul 2023 08:55:23 -0400
X-MC-Unique: PHXmCYJ0OFaLXmL3jn0ETQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 615641C08782
	for <mptcp@lists.linux.dev>; Mon, 10 Jul 2023 12:55:23 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E5A66C51488
	for <mptcp@lists.linux.dev>; Mon, 10 Jul 2023 12:55:22 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 01/14] mptcp: more accurate NL event generation.
Date: Mon, 10 Jul 2023 14:54:56 +0200
Message-ID: <2dff178d492953373f5d7215aea15676b0e6079c.1688993569.git.pabeni@redhat.com>
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

Currently the mptcp code generate a "new listener" event even
if the actual listen() syscall fails. Address the issue moving
the event generation call under the successful branch.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
this could possibly go via -net, but is used by later patches and
is not really critical IMHO.
Eventually the additional tag would be:
Fixes: f8c9dfbd875b ("mptcp: add pm listener events")
---
 net/mptcp/protocol.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 497bc17b5223..8b5c78f582f7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3762,10 +3762,9 @@ static int mptcp_listen(struct socket *sock, int backlog)
 	if (!err) {
 		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
 		mptcp_copy_inaddrs(sk, ssock->sk);
+		mptcp_event_pm_listener(ssock->sk, MPTCP_EVENT_LISTENER_CREATED);
 	}
 
-	mptcp_event_pm_listener(ssock->sk, MPTCP_EVENT_LISTENER_CREATED);
-
 unlock:
 	release_sock(sk);
 	return err;
-- 
2.41.0

