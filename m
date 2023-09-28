Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC99347A3
	for <mptcp@lists.linux.dev>; Thu, 28 Sep 2023 15:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695916359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AAD7iJsB28SiRc/ZuLF0zuYPQFNkaicbaNcdjE6xdLE=;
	b=XWiMkG/+0mKSKXWHthm6PgjH8RjFORwF7bVJJNVmmRoAaD/Gbp4JgFm8xXkBY4OXyE9xuI
	QRLOBXRzYmbo36HtgZLHhmPER+KRoh9cXTc6QEihH+J0JPTTFEjiRyLtyNFiFPVV8V63ro
	7b7fZOssGkpbvc/Cec6tzYtSZM3QQCw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-490-M0eREsdCM1WHRJblAcGfNw-1; Thu, 28 Sep 2023 11:52:37 -0400
X-MC-Unique: M0eREsdCM1WHRJblAcGfNw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4547729AA386;
	Thu, 28 Sep 2023 15:52:37 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.139])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A2E37492B16;
	Thu, 28 Sep 2023 15:52:36 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
Subject: [PATCH mptcp-next] Squash-to: "mptcp: give rcvlowat some love"
Date: Thu, 28 Sep 2023 17:52:31 +0200
Message-ID: <56f04f69f7e7c37e0a1820787f7e9063a50bf937.1695911979.git.pabeni@redhat.com>
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
---
 net/mptcp/protocol.c |  2 ++
 net/mptcp/sockopt.c  | 17 ++++++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6f9e116598ed..3ef6368e26f6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2758,6 +2758,8 @@ static void __mptcp_init_sock(struct sock *sk)
 	msk->rmem_fwd_alloc = 0;
 	WRITE_ONCE(msk->rmem_released, 0);
 	msk->timer_ival = TCP_RTO_MIN;
+	msk->scaling_ratio = (1200 << TCP_RMEM_TO_WIN_SCALE) /
+			     SKB_TRUESIZE(4096);
 
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

