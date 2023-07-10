Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7971580C
	for <mptcp@lists.linux.dev>; Mon, 10 Jul 2023 12:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688993731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UrC9q6f4wAQiDuC9mUcBejtHFHUSxiR/Q2Ex1BywahA=;
	b=G5RlGLNbFUMuoMq6++rB3a0a1haPtOB2eARwLT6M3fBik3reX6WvNCI5Rp2hu4YgPyWoZJ
	7PzajSLyHO5UYD/OsHbELxOtosH/Cjfw+w1YjIX14pEFpnXfs+akk9flLdzf5sy43les2y
	sDfpnBDeMiImlS9uKVC6unvaai+kPBE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-167-hllK6_9iPrObaER9rbbbaQ-1; Mon, 10 Jul 2023 08:55:30 -0400
X-MC-Unique: hllK6_9iPrObaER9rbbbaQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 31EEC104458D
	for <mptcp@lists.linux.dev>; Mon, 10 Jul 2023 12:55:30 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B5E07C09A09
	for <mptcp@lists.linux.dev>; Mon, 10 Jul 2023 12:55:29 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 10/14] mptcp: avoid unneeded indirection in mptcp_stream_accept()
Date: Mon, 10 Jul 2023 14:55:05 +0200
Message-ID: <7e485259a201fdac1807c56746bd437d4335edd1.1688993569.git.pabeni@redhat.com>
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
the addictional indirection at accept() time. Instead access
directly the first subflow sock.

No functional changes intended.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4e5c9770d8d6..00cfed1d0ebd 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3220,17 +3220,12 @@ static struct sock *mptcp_accept(struct sock *sk, int flags, int *err,
 				 bool kern)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
-	struct socket *listener;
-	struct sock *newsk;
+	struct sock *ssk, *newsk;
 
-	listener = READ_ONCE(msk->subflow);
-	if (WARN_ON_ONCE(!listener)) {
-		*err = -EINVAL;
-		return NULL;
-	}
+	ssk = READ_ONCE(msk->first);
 
-	pr_debug("msk=%p, listener=%p", msk, mptcp_subflow_ctx(listener->sk));
-	newsk = inet_csk_accept(listener->sk, flags, err, kern);
+	pr_debug("msk=%p, listener=%p", msk, mptcp_subflow_ctx(ssk));
+	newsk = inet_csk_accept(ssk, flags, err, kern);
 	if (!newsk)
 		return NULL;
 
@@ -3801,7 +3796,6 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 			       int flags, bool kern)
 {
 	struct mptcp_sock *msk = mptcp_sk(sock->sk);
-	struct socket *ssock;
 	struct sock *newsk;
 	int err;
 
@@ -3810,8 +3804,7 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 	/* Buggy applications can call accept on socket states other then LISTEN
 	 * but no need to allocate the first subflow just to error out.
 	 */
-	ssock = READ_ONCE(msk->subflow);
-	if (!ssock)
+	if (!READ_ONCE(msk->first))
 		return -EINVAL;
 
 	newsk = mptcp_accept(sock->sk, flags, &err, kern);
-- 
2.41.0

