Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5629070
	for <mptcp@lists.linux.dev>; Fri,  4 Jun 2021 16:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1622824927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gZyTc8FxxcN+wp8MGmZr8V9U6eKULP2pTp3Fi2OgBOc=;
	b=BPNEgarNyN2ige70q+/D1wvChRf9VhVHK8mrGV5qa9eEKtLPLfb14h29T48j2PxZSQvfVZ
	UyqBcVdwDtXg4kP4HMvHwWOeP66nTYJHQfCoV5rOGfheFbFtx/Co2beA3siC4JU96B6/Lm
	XWoMydVP8ydPKDHw2fduICf/ZLPP2Zk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-uvw_GbhROWW3NCOzsW19yQ-1; Fri, 04 Jun 2021 12:42:02 -0400
X-MC-Unique: uvw_GbhROWW3NCOzsW19yQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95FD81936B67
	for <mptcp@lists.linux.dev>; Fri,  4 Jun 2021 16:42:01 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-115-13.ams2.redhat.com [10.36.115.13])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 104822BFF6
	for <mptcp@lists.linux.dev>; Fri,  4 Jun 2021 16:42:00 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next] mptcp: refine mptcp_cleanup_rbuf
Date: Fri,  4 Jun 2021 18:41:53 +0200
Message-Id: <ed4e9f7d165ec01c45b9f9b9d0a11dab5a17dcdd.1622824500.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

The current cleanup rbuf tries a bit too hard to avoid acquiring
the subflow socket lock. We may end-up delaying the needed ack,
or skip acking a blocked subflow.

Address the above extending the conditions used to trigger the cleanup
to reflect more closely what TCP does and invoking tcp_cleanup_rbuf()
on all the active subflows.

Note that we can't replicate the exact tests implemented in
tcp_cleanup_rbuf(), as MPTCP lacks some of the required info - e.g.
ping-pong mode.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
This addresses the low tput I mesured in tests where BHs and U/S
processes runs on the same CPU, see scenario 4) in:

https://lore.kernel.org/mptcp/9af85be18465b0f9595459764013568456453ce9.camel@redhat.com/

notes:

-  this does not fix completely:

https://github.com/multipath-tcp/mptcp_net-next/issues/137

but figures are now more stable.

- while perfing all the above spotted:

https://github.com/multipath-tcp/mptcp_net-next/issues/200

which is bad!

---
 net/mptcp/protocol.c | 44 ++++++++++++++++----------------------------
 net/mptcp/protocol.h |  1 -
 2 files changed, 16 insertions(+), 29 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f9fd905d2d3b..40e97dd6c09f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -457,34 +457,29 @@ static bool mptcp_subflow_cleanup_rbuf(struct sock *ssk)
 
 static void mptcp_cleanup_rbuf(struct mptcp_sock *msk)
 {
-	struct sock *ack_hint = READ_ONCE(msk->ack_hint);
 	int old_space = READ_ONCE(msk->old_wspace);
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
-	bool cleanup;
+	int space =  __mptcp_space(sk);
+	bool cleanup, rx_empty;
 
-	/* this is a simple superset of what tcp_cleanup_rbuf() implements
-	 * so that we don't have to acquire the ssk socket lock most of the time
-	 * to do actually nothing
-	 */
-	cleanup = __mptcp_space(sk) - old_space >= max(0, old_space);
-	if (!cleanup)
-		return;
+	cleanup = (space > 0) && (space >= (old_space << 1));
+	rx_empty = !atomic_read(&sk->sk_rmem_alloc);
 
-	/* if the hinted ssk is still active, try to use it */
-	if (likely(ack_hint)) {
-		mptcp_for_each_subflow(msk, subflow) {
-			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		const struct inet_connection_sock *icsk;
+		const struct tcp_sock *tp = tcp_sk(sk);
 
-			if (ack_hint == ssk && mptcp_subflow_cleanup_rbuf(ssk))
-				return;
-		}
+		icsk = inet_csk(ssk);
+		if (cleanup ||
+		    (inet_csk_ack_scheduled(sk) &&
+		     ((READ_ONCE(tp->rcv_nxt) - READ_ONCE(tp->rcv_wup) >
+		       READ_ONCE(icsk->icsk_ack.rcv_mss)) ||
+		       (rx_empty && READ_ONCE(icsk->icsk_ack.pending) &
+				    (ICSK_ACK_PUSHED2|ICSK_ACK_PUSHED)))))
+			mptcp_subflow_cleanup_rbuf(ssk);
 	}
-
-	/* otherwise pick the first active subflow */
-	mptcp_for_each_subflow(msk, subflow)
-		if (mptcp_subflow_cleanup_rbuf(mptcp_subflow_tcp_sock(subflow)))
-			return;
 }
 
 static bool mptcp_check_data_fin(struct sock *sk)
@@ -629,7 +624,6 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 			break;
 		}
 	} while (more_data_avail);
-	WRITE_ONCE(msk->ack_hint, ssk);
 
 	*bytes += moved;
 	return done;
@@ -1912,7 +1906,6 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
 		__mptcp_update_rmem(sk);
 		done = __mptcp_move_skbs_from_subflow(msk, ssk, &moved);
 		mptcp_data_unlock(sk);
-		tcp_cleanup_rbuf(ssk, moved);
 
 		if (unlikely(ssk->sk_err))
 			__mptcp_error_report(sk);
@@ -1928,7 +1921,6 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
 		ret |= __mptcp_ofo_queue(msk);
 		__mptcp_splice_receive_queue(sk);
 		mptcp_data_unlock(sk);
-		mptcp_cleanup_rbuf(msk);
 	}
 	if (ret)
 		mptcp_check_data_fin((struct sock *)msk);
@@ -2177,9 +2169,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	if (ssk == msk->last_snd)
 		msk->last_snd = NULL;
 
-	if (ssk == msk->ack_hint)
-		msk->ack_hint = NULL;
-
 	if (ssk == msk->first)
 		msk->first = NULL;
 
@@ -2394,7 +2383,6 @@ static int __mptcp_init_sock(struct sock *sk)
 	msk->rmem_released = 0;
 	msk->tx_pending_data = 0;
 
-	msk->ack_hint = NULL;
 	msk->first = NULL;
 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
 	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 160c2ab09f19..9dea0734808e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -240,7 +240,6 @@ struct mptcp_sock {
 	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
 	bool		csum_enabled;
 	spinlock_t	join_list_lock;
-	struct sock	*ack_hint;
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
 	struct rb_root  out_of_order_queue;
-- 
2.26.3

