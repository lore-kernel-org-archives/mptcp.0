Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863903C13
	for <mptcp@lists.linux.dev>; Mon, 26 Sep 2022 15:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1664206039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oUp6ZOCWD3mRDvNxNNh7kusiz4x1Mr4ZE6oROEjI0jI=;
	b=Vu8yLPh/S8qP7zrF2pafSvXuyesnkUEeNEkv+lDIjnNIJ8k2mnAG0e3jmzFMA3wWoTT1wk
	On011dsCgJL/z84cDoenaaGqmDXu7Bf5KEwEioAY0/GGbCB6ratK9VLekv4tHcOLUt2xMe
	WkH5XXnsXOX+3FXfNlqkOMKod6kua30=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-294-GTRbfExCP96TTypQh7yfRA-1; Mon, 26 Sep 2022 11:27:18 -0400
X-MC-Unique: GTRbfExCP96TTypQh7yfRA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7843287B2A2
	for <mptcp@lists.linux.dev>; Mon, 26 Sep 2022 15:27:18 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.223])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 080CD492B06
	for <mptcp@lists.linux.dev>; Mon, 26 Sep 2022 15:27:17 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next] mptcp: update misleading comments.
Date: Mon, 26 Sep 2022 17:27:11 +0200
Message-Id: <870262a8c7ca7eb682da90684f2ff193a818924b.1664205929.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The MPTCP data path is quite complex and hard to understend even
without some foggy comments referring to modified code and/or
completely misleading from the beginning.

Update a few of them to more accurately describing the current
status.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c99eb4ce948e..8feb684408f7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -662,9 +662,9 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 
 		skb = skb_peek(&ssk->sk_receive_queue);
 		if (!skb) {
-			/* if no data is found, a racing workqueue/recvmsg
-			 * already processed the new data, stop here or we
-			 * can enter an infinite loop
+			/* With racing move_skbs_to_msk() and __mptcp_move_skbs(),
+			 * a different CPU can have already processed the pending
+			 * data, stop here or we can enter an infinite loop
 			 */
 			if (!moved)
 				done = true;
@@ -672,9 +672,9 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 		}
 
 		if (__mptcp_check_fallback(msk)) {
-			/* if we are running under the workqueue, TCP could have
-			 * collapsed skbs between dummy map creation and now
-			 * be sure to adjust the size
+			/* Under fallback skbs have no MPTCP extension and TCP could
+			 * collapse them between the dummy map creation and the
+			 * current dequeue. Be sure to adjust the map size.
 			 */
 			map_remaining = skb->len;
 			subflow->map_data_len = skb->len;
@@ -3767,7 +3767,7 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 	if (sk->sk_shutdown & RCV_SHUTDOWN)
 		mask |= EPOLLIN | EPOLLRDNORM | EPOLLRDHUP;
 
-	/* This barrier is coupled with smp_wmb() in tcp_reset() */
+	/* This barrier is coupled with smp_wmb() in __mptcp_error_report() */
 	smp_rmb();
 	if (sk->sk_err)
 		mask |= EPOLLERR;
-- 
2.37.3

