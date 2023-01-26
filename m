Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D62E538D
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 21:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1674767147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bzWL1HuscBbtIJFe1LwpR9LWyBzCHG08zDJ/2EvOVPE=;
	b=YyF/OC7s0ue5mutcEMNfxONMhmz0lItFEGzHOV84MzZnS7s5cpEFqTlE2cf/oDnUe5m0HJ
	Bq8Kggg3Pyd6U8Xb+CZ0BhSXC2KgGZDgm8cgnrb644GU1jxMJofM5XPcpZ9sj1wHBIC5Ti
	j7CjaFyt8qj/rZDlJ1jtwCDx6q8slRI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-204-_iWo2nSeNkK6jAIgakUaHg-1; Thu, 26 Jan 2023 16:05:45 -0500
X-MC-Unique: _iWo2nSeNkK6jAIgakUaHg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 696D1382C96A
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 21:05:45 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F3224492C14
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 21:05:44 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v3 mptcp-next 08/15] mptcp: move fastopen subflow check inside mptcp_sendmsg_fastopen()
Date: Thu, 26 Jan 2023 22:05:13 +0100
Message-Id: <a19d69d0a062f913bc528dbc80cc1a60fd8cdf2c.1674767058.git.pabeni@redhat.com>
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

So that we can avoid a bunch of check in fastpath. Additionally we
can specialize such check according to the specific fastopen method
- defer_connect vs MSG_FASTOPEN.

The latter bits will simplify the next patches.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 834bdc975387..a9df49722e89 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1694,13 +1694,27 @@ static void mptcp_set_nospace(struct sock *sk)
 
 static int mptcp_disconnect(struct sock *sk, int flags);
 
-static int mptcp_sendmsg_fastopen(struct sock *sk, struct sock *ssk, struct msghdr *msg,
+static int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
 				  size_t len, int *copied_syn)
 {
 	unsigned int saved_flags = msg->msg_flags;
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sock *ssk;
 	int ret;
 
+	/* on flags based fastopen the mptcp is supposed to create the
+	 * first subflow right now. Otherwise we are in the defer_connect
+	 * path, and the first subflow must be already present.
+	 * Since the defer_connect flag is cleared after the first succsful
+	 * fastopen attempt, no need to check for additional subflow status.
+	 */
+	if (msg->msg_flags & MSG_FASTOPEN && !__mptcp_nmpc_socket(msk))
+		return -EINVAL;
+	if (!msk->first)
+		return -EINVAL;
+
+	ssk = msk->first;
+
 	lock_sock(ssk);
 	msg->msg_flags |= MSG_DONTWAIT;
 	msk->connect_flags = O_NONBLOCK;
@@ -1723,6 +1737,7 @@ static int mptcp_sendmsg_fastopen(struct sock *sk, struct sock *ssk, struct msgh
 	} else if (ret && ret != -EINPROGRESS) {
 		mptcp_disconnect(sk, 0);
 	}
+	inet_sk(sk)->defer_connect = 0;
 
 	return ret;
 }
@@ -1731,7 +1746,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct page_frag *pfrag;
-	struct socket *ssock;
 	size_t copied = 0;
 	int ret = 0;
 	long timeo;
@@ -1741,12 +1755,10 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	lock_sock(sk);
 
-	ssock = __mptcp_nmpc_socket(msk);
-	if (unlikely(ssock && (inet_sk(ssock->sk)->defer_connect ||
-			       msg->msg_flags & MSG_FASTOPEN))) {
+	if (unlikely(inet_sk(sk)->defer_connect || msg->msg_flags & MSG_FASTOPEN)) {
 		int copied_syn = 0;
 
-		ret = mptcp_sendmsg_fastopen(sk, ssock->sk, msg, len, &copied_syn);
+		ret = mptcp_sendmsg_fastopen(sk, msg, len, &copied_syn);
 		copied += copied_syn;
 		if (ret == -EINPROGRESS && copied_syn > 0)
 			goto out;
-- 
2.39.1

