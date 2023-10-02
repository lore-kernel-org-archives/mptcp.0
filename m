Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486BE79E4
	for <mptcp@lists.linux.dev>; Mon,  2 Oct 2023 09:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696238038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YwH14F1VO8hYubdZvT/SlXQGW2cYP91DjveWU/C/w8Y=;
	b=TeG2/PLuDc1ZXqiBZo8DKq04mMksd+FsBIhYWUK62CYQ7UdH3tFJ7G69IJ5l6d2R/rJPax
	VN8bckIGXQWOz6SMyLYJmhOO6kczY9ahQjShzTytnxwxrfJPQ7TrRQwW1GG729GqCFFFcw
	h+HEfefekAQuleWEt8FYyUJrFBvg0nc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-493-PAOTb1tuPrOYxjkJqjJ-yQ-1; Mon, 02 Oct 2023 05:13:56 -0400
X-MC-Unique: PAOTb1tuPrOYxjkJqjJ-yQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 699171C07821;
	Mon,  2 Oct 2023 09:13:56 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C6D4A2026D4B;
	Mon,  2 Oct 2023 09:13:55 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
Subject: [PATCH mptcp-next v2 2/2] Squash-to: "mptcp: give rcvlowat some love"
Date: Mon,  2 Oct 2023 11:13:42 +0200
Message-ID: <21dd84bd44a8d0839564bed351e7d77a16b68474.1696237983.git.pabeni@redhat.com>
In-Reply-To: <c71297499300a20bc41fe9c526d4a6cad08c176f.1696237983.git.pabeni@redhat.com>
References: <c71297499300a20bc41fe9c526d4a6cad08c176f.1696237983.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Christoph reported a couple of serious splat caused by
the mentioned patch.

mptcp_set_rcvlowat() can use msk->scaling_ratio, before
such field is initialized, causing a divide by zero: we
need to init it in the sock constructor.

Additionally the same function bogusly cast an msk to a
tcp_sock, causing memory corruption. The reproducer likely
clears the sk refcount for the next msk allocated into the
same slab.

The intent was to properly propagate the rcvbuf changes to
the subflows. Let's do that explicitly.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
--
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/442
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/443

since the above issues are introduced by the squash-to patch, I think
we can't have the tag in the final patch.

v1 -> v2:
 - use scaling_ratio define (Mat)
---
 net/mptcp/protocol.c |  1 +
 net/mptcp/sockopt.c  | 17 ++++++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6f9e116598ed..990fcf53074a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2758,6 +2758,7 @@ static void __mptcp_init_sock(struct sock *sk)
 	msk->rmem_fwd_alloc = 0;
 	WRITE_ONCE(msk->rmem_released, 0);
 	msk->timer_ival = TCP_RTO_MIN;
+	msk->scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
 
 	WRITE_ONCE(msk->first, NULL);
 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 340e87195a27..6b37946b5c52 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1473,6 +1473,7 @@ void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk)
  */
 int mptcp_set_rcvlowat(struct sock *sk, int val)
 {
+	struct mptcp_subflow_context *subflow;
 	int space, cap;
 
 	if (sk->sk_userlocks & SOCK_RCVBUF_LOCK)
@@ -1490,9 +1491,19 @@ int mptcp_set_rcvlowat(struct sock *sk, int val)
 		return 0;
 
 	space = __tcp_space_from_win(mptcp_sk(sk)->scaling_ratio, val);
-	if (space > sk->sk_rcvbuf) {
-		WRITE_ONCE(sk->sk_rcvbuf, space);
-		tcp_sk(sk)->window_clamp = val;
+	if (space <= sk->sk_rcvbuf)
+		return 0;
+
+	/* propagate the rcvbuf changes to all the subflows */
+	WRITE_ONCE(sk->sk_rcvbuf, space);
+	mptcp_for_each_subflow(mptcp_sk(sk), subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		bool slow;
+
+		slow = lock_sock_fast(ssk);
+		WRITE_ONCE(ssk->sk_rcvbuf, space);
+		tcp_sk(ssk)->window_clamp = val;
+		unlock_sock_fast(ssk, slow);
 	}
 	return 0;
 }
-- 
2.41.0

