Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527E1125AA
	for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 11:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689334205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oW/3/VAyLX4PVQgaYKd3zEporKJgsSAzMh9yP7KMWBo=;
	b=C28bP1bKoZjWH4d+/oCTEW7503Wf/LUsDnXpWgE20GXt+YVYJGr9IPz/s2fUuTy79S4nZk
	dfyy/VjMsvNvbLxu4NfEOGLuuOflldSVBBgJftlUTgjV6kZDGwWT2H+9GX2VRtjSI5AiUe
	Jxyr5B7zpiRdeIUuoy2yHUiyBe0eJHQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-461-3FirrM1iMTmxeepKqHAzfQ-1; Fri, 14 Jul 2023 07:30:04 -0400
X-MC-Unique: 3FirrM1iMTmxeepKqHAzfQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E046680123E
	for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 11:30:03 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.62])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6EB2D2166B25
	for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 11:30:03 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 09/13] mptcp: avoid unneeded indirection in mptcp_stream_accept()
Date: Fri, 14 Jul 2023 13:29:40 +0200
Message-ID: <0641bf5383a1af49107c8f61ed667223f8c216e9.1689334116.git.pabeni@redhat.com>
In-Reply-To: <cover.1689334116.git.pabeni@redhat.com>
References: <cover.1689334116.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

We are going to remove the first subflow socket soon, so avoid
the additional indirection at accept() time. Instead access
directly the first subflow sock, and update mptcp_accept() to
operate on it. This allows dropping a duplicated check in
mptcp_accept().

No functional changes intended.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
  - changed mptcp_accept() to better clarify why we could remove
    the 2nd msk->first check there.
---
 net/mptcp/protocol.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index bed379bea8e3..dbc17fdac0ef 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3216,25 +3216,17 @@ void mptcp_rcv_space_init(struct mptcp_sock *msk, const struct sock *ssk)
 	WRITE_ONCE(msk->wnd_end, msk->snd_nxt + tcp_sk(ssk)->snd_wnd);
 }
 
-static struct sock *mptcp_accept(struct sock *sk, int flags, int *err,
+static struct sock *mptcp_accept(struct sock *ssk, int flags, int *err,
 				 bool kern)
 {
-	struct mptcp_sock *msk = mptcp_sk(sk);
-	struct socket *listener;
 	struct sock *newsk;
 
-	listener = READ_ONCE(msk->subflow);
-	if (WARN_ON_ONCE(!listener)) {
-		*err = -EINVAL;
-		return NULL;
-	}
-
-	pr_debug("msk=%p, listener=%p", msk, mptcp_subflow_ctx(listener->sk));
-	newsk = inet_csk_accept(listener->sk, flags, err, kern);
+	pr_debug("ssk=%p, listener=%p", ssk, mptcp_subflow_ctx(ssk));
+	newsk = inet_csk_accept(ssk, flags, err, kern);
 	if (!newsk)
 		return NULL;
 
-	pr_debug("msk=%p, subflow is mptcp=%d", msk, sk_is_mptcp(newsk));
+	pr_debug("newsk=%p, subflow is mptcp=%d", newsk, sk_is_mptcp(newsk));
 	if (sk_is_mptcp(newsk)) {
 		struct mptcp_subflow_context *subflow;
 		struct sock *new_mptcp_sock;
@@ -3251,9 +3243,9 @@ static struct sock *mptcp_accept(struct sock *sk, int flags, int *err,
 		}
 
 		newsk = new_mptcp_sock;
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEPASSIVEACK);
+		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPCAPABLEPASSIVEACK);
 	} else {
-		MPTCP_INC_STATS(sock_net(sk),
+		MPTCP_INC_STATS(sock_net(ssk),
 				MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
 	}
 
@@ -3803,8 +3795,7 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 			       int flags, bool kern)
 {
 	struct mptcp_sock *msk = mptcp_sk(sock->sk);
-	struct socket *ssock;
-	struct sock *newsk;
+	struct sock *ssk, *newsk;
 	int err;
 
 	pr_debug("msk=%p", msk);
@@ -3812,11 +3803,11 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 	/* Buggy applications can call accept on socket states other then LISTEN
 	 * but no need to allocate the first subflow just to error out.
 	 */
-	ssock = READ_ONCE(msk->subflow);
-	if (!ssock)
+	ssk = READ_ONCE(msk->first);
+	if (!ssk)
 		return -EINVAL;
 
-	newsk = mptcp_accept(sock->sk, flags, &err, kern);
+	newsk = mptcp_accept(ssk, flags, &err, kern);
 	if (!newsk)
 		return err;
 
-- 
2.41.0

