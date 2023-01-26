Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1412D5394
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 21:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1674767146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JkUrhK5E+YtOHOwAYuuFmNTmpdiOGuMyo5qvL7mD8LU=;
	b=MKBq6lgT8pskZnxtgAN95VEn5WfrG7L6ynAX/AnxztrD8YQqr5aggBFgc9oDLI0Zs+y5i5
	Y8mnZ89k0jc4f7kGi9SL9UrLKxcR6niuTWJAedRuoRQzD60fJg+MFbpm3PvpUiMdz9jvZh
	3sAwQcp4nm40N7FukbECrwX7iNBhMDI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-20-OlOSk5ExMiSA1NVAR1yTqQ-1; Thu, 26 Jan 2023 16:05:44 -0500
X-MC-Unique: OlOSk5ExMiSA1NVAR1yTqQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AE1971991C42
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 21:05:44 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 433F2492C14
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 21:05:44 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v3 mptcp-next 07/15] mptcp: avoid unneeded __mptcp_nmpc_socket() usage
Date: Thu, 26 Jan 2023 22:05:12 +0100
Message-Id: <ad7db805f729070278ea28a8dbdf4d563384d48d.1674767058.git.pabeni@redhat.com>
In-Reply-To: <cover.1674767058.git.pabeni@redhat.com>
References: <cover.1674767058.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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
index 562277283367..834bdc975387 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3181,7 +3181,7 @@ static struct sock *mptcp_accept(struct sock *sk, int flags, int *err,
 	struct socket *listener;
 	struct sock *newsk;
 
-	listener = __mptcp_nmpc_socket(msk);
+	listener = msk->subflow;
 	if (WARN_ON_ONCE(!listener)) {
 		*err = -EINVAL;
 		return NULL;
@@ -3401,7 +3401,7 @@ static int mptcp_get_port(struct sock *sk, unsigned short snum)
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct socket *ssock;
 
-	ssock = __mptcp_nmpc_socket(msk);
+	ssock = msk->subflow;
 	pr_debug("msk=%p, subflow=%p", msk, ssock);
 	if (WARN_ON_ONCE(!ssock))
 		return -EINVAL;
@@ -3747,7 +3747,10 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 
 	pr_debug("msk=%p", msk);
 
-	ssock = __mptcp_nmpc_socket(msk);
+	/* buggy applications can call accept on socket states other then LISTEN
+	 * but no need to allocate the first subflow just to error out.
+	 */
+	ssock = msk->subflow;
 	if (!ssock)
 		return -EINVAL;
 
-- 
2.39.1

