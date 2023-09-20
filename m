Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA1530FB4
	for <mptcp@lists.linux.dev>; Wed, 20 Sep 2023 12:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695213944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xhJKJObMrHZFvF25A77GRbyk5GXEbkVx5oAFGXN4BAM=;
	b=Pw1XDADvkfd8Ju2vQDy97XwFW+d2+oK6oN51vamxGjO6o+ndfmTp20rzcTFUwFkmhGqHQ0
	p/UeIGOLBsbe/mVbWCsL/Yfbw31YyHGiMPZKIc0J0eWZa/ZC/buQI0T5mFR+ZlR+3+LeXP
	iP3bAUxNmtjuf1LsV/IECMcpv6Fm74A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-47-W12-_6GPM9GXhOVP9xCFWA-1; Wed, 20 Sep 2023 08:45:43 -0400
X-MC-Unique: W12-_6GPM9GXhOVP9xCFWA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 43A1B185A797
	for <mptcp@lists.linux.dev>; Wed, 20 Sep 2023 12:45:43 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.123])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C5C0F10D14CB
	for <mptcp@lists.linux.dev>; Wed, 20 Sep 2023 12:45:42 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 3/4] mptcp: give rcvlowat some love.
Date: Wed, 20 Sep 2023 14:45:36 +0200
Message-ID: <bb0286644eee85deb7477164c371acdf98e4c66b.1695208066.git.pabeni@redhat.com>
In-Reply-To: <cover.1695208066.git.pabeni@redhat.com>
References: <cover.1695208066.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The MPTCP protocol allow setting sk_rcvlowat, but the value there
is currently ignored.

Additionally, the default subflows sk_rcvlowat basically disables per
subflow delayed ack: the MPTCP protocol move the incoming data from the
subflows into the msk socket as soon as the TCP stacks invokes the subflow
data_ready callback. Later, when __tcp_ack_snd_check() takes action,
the subflow-level copied_seq matches rcv_nxt, and that mandate for an
immediate ack.

Let the mptcp receive path be aware of such threshold, explicitly tracking
the amount of data available to be ready and checking vs sk_rcvlowat in
mptcp_poll() and before waking-up readers.

Additionally implement the set_rcvlowat() callback, to properly handle
the rcvbuf auto-tuning on sk_rcvlowat changes.

Finally to properly handle delayed ack, force the subflow level threshold
to 0 and instead explicitly ask for an immediate ack when the msk level th
is not reached.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 23 ++++++++++-------------
 net/mptcp/protocol.h | 20 ++++++++++++++++++++
 net/mptcp/sockopt.c  | 31 +++++++++++++++++++++++++++++++
 net/mptcp/subflow.c  | 12 ++++++++++--
 4 files changed, 71 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0a9d00e794d4..1de8eaccd48b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -861,9 +861,8 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 
 	/* Wake-up the reader only for in-sequence data */
 	mptcp_data_lock(sk);
-	if (move_skbs_to_msk(msk, ssk))
+	if (move_skbs_to_msk(msk, ssk) && mptcp_epollin_ready(sk))
 		sk->sk_data_ready(sk);
-
 	mptcp_data_unlock(sk);
 }
 
@@ -1928,6 +1927,7 @@ static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
 			if (!(flags & MSG_PEEK)) {
 				MPTCP_SKB_CB(skb)->offset += count;
 				MPTCP_SKB_CB(skb)->map_seq += count;
+				msk->bytes_consumed += count;
 			}
 			break;
 		}
@@ -1938,6 +1938,7 @@ static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
 			WRITE_ONCE(msk->rmem_released, msk->rmem_released + skb->truesize);
 			__skb_unlink(skb, &msk->receive_queue);
 			__kfree_skb(skb);
+			msk->bytes_consumed += count;
 		}
 
 		if (copied >= len)
@@ -2955,16 +2956,9 @@ void __mptcp_unaccepted_force_close(struct sock *sk)
 	__mptcp_destroy_sock(sk);
 }
 
-static __poll_t mptcp_check_readable(struct mptcp_sock *msk)
+static __poll_t mptcp_check_readable(struct sock *sk)
 {
-	/* Concurrent splices from sk_receive_queue into receive_queue will
-	 * always show at least one non-empty queue when checked in this order.
-	 */
-	if (skb_queue_empty_lockless(&((struct sock *)msk)->sk_receive_queue) &&
-	    skb_queue_empty_lockless(&msk->receive_queue))
-		return 0;
-
-	return EPOLLIN | EPOLLRDNORM;
+	return mptcp_epollin_ready(sk) ? EPOLLIN | EPOLLRDNORM : 0;
 }
 
 static void mptcp_check_listen_stop(struct sock *sk)
@@ -3002,7 +2996,7 @@ bool __mptcp_close(struct sock *sk, long timeout)
 		goto cleanup;
 	}
 
-	if (mptcp_check_readable(msk) || timeout < 0) {
+	if (mptcp_data_avail(msk) || timeout < 0) {
 		/* If the msk has read data, or the caller explicitly ask it,
 		 * do the MPTCP equivalent of TCP reset, aka MPTCP fastclose
 		 */
@@ -3135,6 +3129,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	msk->snd_data_fin_enable = false;
 	msk->rcv_fastclose = false;
 	msk->use_64bit_ack = false;
+	msk->bytes_consumed = 0;
 	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
 	mptcp_pm_data_reset(msk);
 	mptcp_ca_reset(sk);
@@ -3918,7 +3913,7 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 		mask |= EPOLLIN | EPOLLRDNORM | EPOLLRDHUP;
 
 	if (state != TCP_SYN_SENT && state != TCP_SYN_RECV) {
-		mask |= mptcp_check_readable(msk);
+		mask |= mptcp_check_readable(sk);
 		if (shutdown & SEND_SHUTDOWN)
 			mask |= EPOLLOUT | EPOLLWRNORM;
 		else
@@ -3956,6 +3951,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.sendmsg	   = inet_sendmsg,
 	.recvmsg	   = inet_recvmsg,
 	.mmap		   = sock_no_mmap,
+	.set_rcvlowat	   = mptcp_set_rcvlowat,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4057,6 +4053,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	   = inet6_compat_ioctl,
 #endif
+	.set_rcvlowat	   = mptcp_set_rcvlowat,
 };
 
 static struct proto mptcp_v6_prot;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 158b6fc19217..a895424bf112 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -268,6 +268,7 @@ struct mptcp_sock {
 	atomic64_t	rcv_wnd_sent;
 	u64		rcv_data_fin_seq;
 	u64		bytes_retrans;
+	u64		bytes_consumed;
 	int		rmem_fwd_alloc;
 	int		snd_burst;
 	int		old_wspace;
@@ -667,6 +668,24 @@ struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
 int mptcp_sched_get_send(struct mptcp_sock *msk);
 int mptcp_sched_get_retrans(struct mptcp_sock *msk);
 
+static inline u64 mptcp_data_avail(const struct mptcp_sock *msk)
+{
+	return READ_ONCE(msk->bytes_received) - READ_ONCE(msk->bytes_consumed);
+}
+
+static inline bool mptcp_epollin_ready(const struct sock *sk)
+{
+	/* mptcp doesn't have to deal with small skbs in the receive queue,
+	 * at it can always coalesce them
+	 */
+	return (mptcp_data_avail(mptcp_sk(sk)) >= sk->sk_rcvlowat) ||
+	       (mem_cgroup_sockets_enabled && sk->sk_memcg &&
+		mem_cgroup_under_socket_pressure(sk->sk_memcg)) ||
+	       READ_ONCE(tcp_memory_pressure);
+}
+
+int mptcp_set_rcvlowat(struct sock *sk, int val);
+
 static inline bool __tcp_can_send(const struct sock *ssk)
 {
 	/* only send if our side has not closed yet */
@@ -741,6 +760,7 @@ static inline bool mptcp_is_fully_established(struct sock *sk)
 	return inet_sk_state_load(sk) == TCP_ESTABLISHED &&
 	       READ_ONCE(mptcp_sk(sk)->fully_established);
 }
+
 void mptcp_rcv_space_init(struct mptcp_sock *msk, const struct sock *ssk);
 void mptcp_data_ready(struct sock *sk, struct sock *ssk);
 bool mptcp_finish_join(struct sock *sk);
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 453d6c78c25c..8351e4558379 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1456,9 +1456,40 @@ void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk)
 	 */
 	tcp_sk(ssk)->notsent_lowat = UINT_MAX;
 
+	ssk->sk_rcvlowat = 0;
+
 	if (READ_ONCE(subflow->setsockopt_seq) != msk->setsockopt_seq) {
 		sync_socket_options(msk, ssk);
 
 		subflow->setsockopt_seq = msk->setsockopt_seq;
 	}
 }
+
+/* unfortunaly this is different enough from the tcp version so
+ * that we can't factor it out
+ */
+int mptcp_set_rcvlowat(struct sock *sk, int val)
+{
+	int space, cap;
+
+	if (sk->sk_userlocks & SOCK_RCVBUF_LOCK)
+		cap = sk->sk_rcvbuf >> 1;
+	else
+		cap = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_rmem[2]) >> 1;
+	val = min(val, cap);
+	WRITE_ONCE(sk->sk_rcvlowat, val ? : 1);
+
+	/* Check if we need to signal EPOLLIN right now */
+	if (mptcp_epollin_ready(sk))
+		sk->sk_data_ready(sk);
+
+	if (sk->sk_userlocks & SOCK_RCVBUF_LOCK)
+		return 0;
+
+	space = __tcp_space_from_win(mptcp_sk(sk)->scaling_ratio, val);
+	if (space > sk->sk_rcvbuf) {
+		WRITE_ONCE(sk->sk_rcvbuf, space);
+		tcp_sk(sk)->window_clamp = val;
+	}
+	return 0;
+}
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 0a4465dcf56d..1301b0215f62 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1405,10 +1405,18 @@ static void subflow_data_ready(struct sock *sk)
 	WARN_ON_ONCE(!__mptcp_check_fallback(msk) && !subflow->mp_capable &&
 		     !subflow->mp_join && !(state & TCPF_CLOSE));
 
-	if (mptcp_subflow_data_available(sk))
+	if (mptcp_subflow_data_available(sk)) {
 		mptcp_data_ready(parent, sk);
-	else if (unlikely(sk->sk_err))
+
+		/* subflow-level lowat test are not relevant.
+		 * respect the msk-level threshold eventually mandating an immediate ack
+		 */
+		if (mptcp_data_avail(msk) < parent->sk_rcvlowat &&
+		    (tcp_sk(sk)->rcv_nxt - tcp_sk(sk)->rcv_wup) > inet_csk(sk)->icsk_ack.rcv_mss)
+			inet_csk(sk)->icsk_ack.pending |= ICSK_ACK_NOW;
+	} else if (unlikely(sk->sk_err)) {
 		subflow_error_report(sk);
+	}
 }
 
 static void subflow_write_space(struct sock *ssk)
-- 
2.41.0

