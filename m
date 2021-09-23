Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F4B29CA
	for <mptcp@lists.linux.dev>; Thu, 23 Sep 2021 10:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1632391732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7gHemA35fkUVsjKJxC3BJ8N5NBN8o8z0rO3dZwxUvY0=;
	b=hD4ITq5nKA+NG+cxilkzlOpOdKl6UtE8ECzeWzm2GGx7re08Uc48yOgdAAPaB7TkNIOOAZ
	Z7ZZUuUJskb+jgyDGD5zAnPR9t2KsTsaDGr9bKqGGftQA/BNiSMoynf0aMIvRAI3obTeWS
	kz3nqZrKXNDGUsAiVRI2KqYpl7OU7Vc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-oieLsKPzNnihcbhz3y-_fw-1; Thu, 23 Sep 2021 06:08:50 -0400
X-MC-Unique: oieLsKPzNnihcbhz3y-_fw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0B3810144E3
	for <mptcp@lists.linux.dev>; Thu, 23 Sep 2021 10:08:49 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.195.157])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 392BB5D9CA
	for <mptcp@lists.linux.dev>; Thu, 23 Sep 2021 10:08:49 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] mptcp: fix possible stall on recvmsg()
Date: Thu, 23 Sep 2021 12:08:43 +0200
Message-Id: <0a9c1bd78a8f0c5a57a19cf5ce58df4e507e1d7e.1632391713.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

recvmsg() can enter an infinite loop if the caller provides the
MSG_WAITALL, the data present in the receive queue is not
sufficient to fulfill the request and no more data is received by
the peer.

When the above happens, mptcp_wait_data() will always return with
no wait, as the MPTCP_DATA_READY flag checked by such function is
set and never cleared in such code path.

Before releasing the mptcp socket lock, we must explicitly update
such bit status. The code is already there at recvmsg() completion,
factor out an helper and use it both at recvmsg() completion and
before calling mptcp_wait_data().

Fixes: 7a6a6cbc3e59 ("mptcp: recvmsg() can drain data from multiple subflow")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
Note:
- for net-next we could possibly consider removing the DATA_READY
flag and switch to checking directly sk_receive_queue instead
---
 net/mptcp/protocol.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index dbcebf56798f..6b334f9b6242 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1759,11 +1759,32 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	return copied ? : ret;
 }
 
+static bool __mptcp_move_skbs(struct mptcp_sock *msk);
+
+static void mptcp_update_ready_flag(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
+	if (skb_queue_empty_lockless(&sk->sk_receive_queue) &&
+	    skb_queue_empty(&msk->receive_queue)) {
+		/* entire backlog drained, clear DATA_READY. */
+		clear_bit(MPTCP_DATA_READY, &msk->flags);
+
+		/* .. race-breaker: ssk might have gotten new data
+		 * after last __mptcp_move_skbs() returned false.
+		 */
+		if (unlikely(__mptcp_move_skbs(msk)))
+			set_bit(MPTCP_DATA_READY, &msk->flags);
+	}
+}
+
 static void mptcp_wait_data(struct sock *sk, long *timeo)
 {
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
+	mptcp_update_ready_flag(sk);
+
 	add_wait_queue(sk_sleep(sk), &wait);
 	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
 
@@ -2080,17 +2101,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		mptcp_wait_data(sk, &timeo);
 	}
 
-	if (skb_queue_empty_lockless(&sk->sk_receive_queue) &&
-	    skb_queue_empty(&msk->receive_queue)) {
-		/* entire backlog drained, clear DATA_READY. */
-		clear_bit(MPTCP_DATA_READY, &msk->flags);
-
-		/* .. race-breaker: ssk might have gotten new data
-		 * after last __mptcp_move_skbs() returned false.
-		 */
-		if (unlikely(__mptcp_move_skbs(msk)))
-			set_bit(MPTCP_DATA_READY, &msk->flags);
-	}
+	mptcp_update_ready_flag(sk);
 
 out_err:
 	if (cmsg_flags && copied >= 0) {
-- 
2.26.3

