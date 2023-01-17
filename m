Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AEF1FB6
	for <mptcp@lists.linux.dev>; Tue, 17 Jan 2023 07:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1673941040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TMGg0Tfh/BNDpXs4p5HbUKbtIyGBffJA+AN6MG0y4aM=;
	b=GVj9W2NpqiB81gDoM73MsppDvf1o5yAjahdkvY0OQpayUJcEAMFsiGC6qZKXGqcCtikqbX
	d4klTUnHgOIcytXN/8GVGkCtOjuWpS1Oek2uaq3xJGKrV6OwQnbQHhO96TYQoqunX8nQ4r
	6g44VCRZJbdLz7y+TKBw+TMa5N3Rows=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-524-GzpoIdafPGCXferUg0wB3g-1; Tue, 17 Jan 2023 02:37:18 -0500
X-MC-Unique: GzpoIdafPGCXferUg0wB3g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D2413811E6E
	for <mptcp@lists.linux.dev>; Tue, 17 Jan 2023 07:37:17 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.87])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5F0A640C2064
	for <mptcp@lists.linux.dev>; Tue, 17 Jan 2023 07:37:17 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 07/13] mptcp: move fastopen subflow check inside mptcp_sendmsg_fastopen()
Date: Tue, 17 Jan 2023 08:36:27 +0100
Message-Id: <3a304d195506dd6e5bf23015bbd0b97f105556ea.1673940640.git.pabeni@redhat.com>
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

So that we can avoid a bunch of check in fastpath. Additionally we
can specialize such check according to the specific fastopen method
- defer_connect vs MSG_FASTOPEN.

The latter bits will simplify the next patches.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index fc13f1e45137..9c4c729bf271 100644
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
2.39.0

