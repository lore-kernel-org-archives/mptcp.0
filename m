Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA971FB0
	for <mptcp@lists.linux.dev>; Tue, 17 Jan 2023 07:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1673941038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3HjysDh572wY9Js9r3sfPKUTwXRf2DKKbBeaZSRym/g=;
	b=NKeAILqW46BVkuoxmA6c1glJyHJOIJSx5NAWmfE5mZ9Hm9pks3IrGFQ9n3nlPemLFmYFDX
	D8IjrxQHIGK/SdX4R2WJ9wWcCrnLLko5XDGsSYacQ6FMZiOSqEtBPQ9c7QaDe37lLnUbUr
	8zZpBwEBbvX1cxxPKehf/51yqPegfBs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-520-RMIZ-_zGMJ64jjcZ3KmzlA-1; Tue, 17 Jan 2023 02:37:17 -0500
X-MC-Unique: RMIZ-_zGMJ64jjcZ3KmzlA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1864D802D2A
	for <mptcp@lists.linux.dev>; Tue, 17 Jan 2023 07:37:17 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.87])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9BDA340C2004
	for <mptcp@lists.linux.dev>; Tue, 17 Jan 2023 07:37:16 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 06/13] mptcp: avoid unneeded __mptcp_nmpc_socket() usage
Date: Tue, 17 Jan 2023 08:36:26 +0100
Message-Id: <a809732108e9de6cbf1989f7d89410dcbcec6a0d.1673940640.git.pabeni@redhat.com>
In-Reply-To: <cover.1673940640.git.pabeni@redhat.com>
References: <cover.1673940640.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

In a few spots the mptcp code invokes the __mptcp_nmpc_socket() helper
multiple times under the same socket lock scope. Additionally, in such
places, the socket status ensure that threre is not an MP capable
handshake running.

Under the above condition we can replace the later __mptcp_nmpc_socket()
helper invocation with direct access to the msk->subflow pointer and
better document such access is not supposed to fail with WARN().

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d298d629b3b2..fc13f1e45137 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3172,7 +3172,7 @@ static struct sock *mptcp_accept(struct sock *sk, int flags, int *err,
 	struct socket *listener;
 	struct sock *newsk;
 
-	listener = __mptcp_nmpc_socket(msk);
+	listener = msk->subflow;
 	if (WARN_ON_ONCE(!listener)) {
 		*err = -EINVAL;
 		return NULL;
@@ -3392,7 +3392,7 @@ static int mptcp_get_port(struct sock *sk, unsigned short snum)
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct socket *ssock;
 
-	ssock = __mptcp_nmpc_socket(msk);
+	ssock = msk->subflow;
 	pr_debug("msk=%p, subflow=%p", msk, ssock);
 	if (WARN_ON_ONCE(!ssock))
 		return -EINVAL;
@@ -3738,7 +3738,10 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 
 	pr_debug("msk=%p", msk);
 
-	ssock = __mptcp_nmpc_socket(msk);
+	/* buggy applications can call accept on socket states other then LISTEN
+	 * but no need to allocate the first subflow just to error out.
+	 */
+	ssock = msk->subflow;
 	if (!ssock)
 		return -EINVAL;
 
-- 
2.39.0

