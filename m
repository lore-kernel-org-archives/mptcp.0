Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A78720468E
	for <mptcp@lists.linux.dev>; Sat, 22 Nov 2025 08:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763801139; cv=none; b=bDmUvXJiUas2wYep87muESSCsmH+4KmZY9qZP+fLpi+hf0pe7zT17kOUurMtg962CT4KCmRt3sdtd05tJypoofMJ1csWYbCrP1WDj0l7T4+/20NszBxjynrJZXXsrmCY6EzMqzWcYaHUaPaeFKgj4+PYDZEIUy4A8hSiKdx+2+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763801139; c=relaxed/simple;
	bh=5oD+cx5b8zX4HYWLmhLKo8bWgMLYOgMqpQugEi47zdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qu2U9VE5Q/EwpZm/Hh2n6GIM9XeDtTD3Kz8xdz43NJ+Ljz2TUVJIstbOB0IOD1SW9YA6NLUaY/xBadyAjUahtR1okDEOdsSX1e/MIPwKIDAB2qvJ5BYiYNukwkyP5F3hGWKYAqKAi4B7lz7cwmUqw0aW6i+s3tw+uHxgUSsDBc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZmQjO1J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZmQjO1J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D98DC116D0;
	Sat, 22 Nov 2025 08:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763801139;
	bh=5oD+cx5b8zX4HYWLmhLKo8bWgMLYOgMqpQugEi47zdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pZmQjO1J7i1L0vvEfO1tNAZRc9SGS+ut9i7sND66uX7UhiXRTb0i5U9Vrih69ZrXs
	 nB1nQQ5dtHHWpXOX2atA8OuHFk6wb6HuO17uFoG03PMr925D8P4DAUO1BlGz30F8Yf
	 WQbY9cvq94AQRqYAKy6DO+fj4Z1p7jhPTnpsDT5ylqAJY+ADCFyUy8up1mKF5PLH9g
	 0vbdojlbiWOIZ3CrwGgX4FiYni7yTuEGdVL8bQ7+eu3LOAFD6bN1UHqFUFRyNAib0i
	 SH8eA6nTaugGt00qr08sWoqpvc17FDPhyHfSS/UxkNRr+PJuWXKq5ystuZdAZU/NA3
	 oN02P3RTKK0OA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v3 4/8] tls: add MPTCP protocol support
Date: Sat, 22 Nov 2025 16:45:23 +0800
Message-ID: <2a0f438fbd4c5ddf7d8153bfc8aa44cfefa58c45.1763800601.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763800601.git.tanggeliang@kylinos.cn>
References: <cover.1763800601.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

To extend MPTCP support based on TCP TLS, corresponding MPTCP-specific
helpers have been implemented, including:

- mptcp_sendmsg_locked() for TLS record transmission
- mptcp_inq_hint() and mptcp_recv_skb() for receive side handling
- mptcp_read_done() for data reading
- mptcp_disconnect() for connection teardown.

TLS implementation switches between the respective TCP and MPTCP helpers
based on the detected protocol.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h  | 33 +++++++++++++++++++++++
 net/mptcp/protocol.c | 62 +++++++++++++++++++++++++++++++++++++-------
 net/tls/tls_device.c |  8 ++++--
 net/tls/tls_main.c   |  6 ++++-
 net/tls/tls_strp.c   | 16 +++++++++---
 net/tls/tls_sw.c     |  4 ++-
 6 files changed, 113 insertions(+), 16 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 4cf59e83c1c5..1fca3bca439c 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -237,6 +237,16 @@ static inline __be32 mptcp_reset_option(const struct sk_buff *skb)
 }
 
 void mptcp_active_detect_blackhole(struct sock *sk, bool expired);
+
+int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t len);
+
+unsigned int mptcp_inq_hint(const struct sock *sk);
+
+struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off);
+
+void mptcp_read_done(struct sock *sk, size_t len);
+
+int mptcp_disconnect(struct sock *sk, int flags);
 #else
 
 static inline void mptcp_init(void)
@@ -323,6 +333,29 @@ static inline struct request_sock *mptcp_subflow_reqsk_alloc(const struct reques
 static inline __be32 mptcp_reset_option(const struct sk_buff *skb)  { return htonl(0u); }
 
 static inline void mptcp_active_detect_blackhole(struct sock *sk, bool expired) { }
+
+static inline int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg,
+				       size_t len)
+{
+	return 0;
+}
+
+static inline unsigned int mptcp_inq_hint(const struct sock *sk)
+{
+	return 0;
+}
+
+static inline struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
+{
+	return NULL;
+}
+
+static inline void mptcp_read_done(struct sock *sk, size_t len) { }
+
+static inline int mptcp_disconnect(struct sock *sk, int flags)
+{
+	return 0;
+}
 #endif /* CONFIG_MPTCP */
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b31724523ed5..5d796b42bc6b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1752,8 +1752,6 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 	}
 }
 
-static int mptcp_disconnect(struct sock *sk, int flags);
-
 static int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
 				  size_t len, int *copied_syn)
 {
@@ -1862,7 +1860,7 @@ static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
 	}
 }
 
-static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
+int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct page_frag *pfrag;
@@ -1873,8 +1871,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	/* silently ignore everything else */
 	msg->msg_flags &= MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | MSG_FASTOPEN;
 
-	lock_sock(sk);
-
 	mptcp_rps_record_subflows(msk);
 
 	if (unlikely(inet_test_bit(DEFER_CONNECT, sk) ||
@@ -1982,7 +1978,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		__mptcp_push_pending(sk, msg->msg_flags);
 
 out:
-	release_sock(sk);
 	return copied;
 
 do_error:
@@ -1993,6 +1988,17 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	goto out;
 }
 
+static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
+{
+	int ret;
+
+	lock_sock(sk);
+	ret = mptcp_sendmsg_locked(sk, msg, len);
+	release_sock(sk);
+
+	return ret;
+}
+
 static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied);
 
 static void mptcp_eat_recv_skb(struct sock *sk, struct sk_buff *skb)
@@ -2224,7 +2230,7 @@ static bool mptcp_move_skbs(struct sock *sk)
 	return enqueued;
 }
 
-static unsigned int mptcp_inq_hint(const struct sock *sk)
+unsigned int mptcp_inq_hint(const struct sock *sk)
 {
 	const struct mptcp_sock *msk = mptcp_sk(sk);
 	const struct sk_buff *skb;
@@ -3329,7 +3335,7 @@ static void mptcp_destroy_common(struct mptcp_sock *msk)
 	mptcp_pm_destroy(msk);
 }
 
-static int mptcp_disconnect(struct sock *sk, int flags)
+int mptcp_disconnect(struct sock *sk, int flags)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
@@ -4271,7 +4277,7 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 	return mask;
 }
 
-static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
+struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct sk_buff *skb;
@@ -4453,6 +4459,44 @@ static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
 	return ret;
 }
 
+void mptcp_read_done(struct sock *sk, size_t len)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sk_buff *skb;
+	size_t left;
+	u32 offset;
+
+	msk_owned_by_me(msk);
+
+	if (sk->sk_state == TCP_LISTEN)
+		return;
+
+	left = len;
+	while (left && (skb = mptcp_recv_skb(sk, &offset)) != NULL) {
+		int used;
+
+		used = min_t(size_t, skb->len - offset, left);
+		left -= used;
+		msk->bytes_consumed += used;
+		MPTCP_SKB_CB(skb)->offset += used;
+		MPTCP_SKB_CB(skb)->map_seq += used;
+
+		if (skb->len > offset + used)
+			break;
+
+		mptcp_eat_recv_skb(sk, skb);
+	}
+
+	mptcp_rcv_space_adjust(msk, len - left);
+
+	/* Clean up data we have read: This will do ACK frames. */
+	if (left != len) {
+		mptcp_recv_skb(sk, &offset);
+		mptcp_cleanup_rbuf(msk, len - left);
+	}
+}
+EXPORT_SYMBOL(mptcp_read_done);
+
 static const struct proto_ops mptcp_stream_ops = {
 	.family		   = PF_INET,
 	.owner		   = THIS_MODULE,
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 82ea407e520a..9a69037b9a1f 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -805,7 +805,9 @@ void tls_device_rx_resync_new_rec(struct sock *sk, u32 rcd_len, u32 seq)
 		/* head of next rec is already in, note that the sock_inq will
 		 * include the currently parsed message when called from parser
 		 */
-		sock_data = tcp_inq(sk);
+		sock_data = sk->sk_protocol == IPPROTO_MPTCP ?
+			    mptcp_inq_hint(sk) :
+			    tcp_inq(sk);
 		if (sock_data > rcd_len) {
 			trace_tls_device_rx_resync_nh_delay(sk, sock_data,
 							    rcd_len);
@@ -864,7 +866,9 @@ static void tls_device_core_ctrl_rx_resync(struct tls_context *tls_ctx,
 	rxm = strp_msg(skb);
 
 	/* head of next rec is already in, parser will sync for us */
-	if (tcp_inq(sk) > rxm->full_len) {
+	if ((sk->sk_protocol == IPPROTO_MPTCP ?
+	     mptcp_inq_hint(sk) :
+	     tcp_inq(sk)) > rxm->full_len) {
 		trace_tls_device_rx_resync_nh_schedule(sk);
 		ctx->resync_nh_do_now = 1;
 	} else {
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 56ce0bc8317b..7d7bde1702c1 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -194,7 +194,9 @@ int tls_push_sg(struct sock *sk,
 		bvec_set_page(&bvec, p, size, offset);
 		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
 
-		ret = tcp_sendmsg_locked(sk, &msg, size);
+		ret = sk->sk_protocol == IPPROTO_MPTCP ?
+		      mptcp_sendmsg_locked(sk, &msg, size) :
+		      tcp_sendmsg_locked(sk, &msg, size);
 
 		if (ret != size) {
 			if (ret > 0) {
@@ -907,6 +909,8 @@ static int tls_setsockopt(struct sock *sk, int level, int optname,
 
 static int tls_disconnect(struct sock *sk, int flags)
 {
+	if (sk->sk_protocol == IPPROTO_MPTCP)
+		return mptcp_disconnect(sk, flags);
 	return -EOPNOTSUPP;
 }
 
diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index 98e12f0ff57e..0fd19c6a579a 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -132,6 +132,8 @@ int tls_strp_msg_cow(struct tls_sw_context_rx *ctx)
 	tls_strp_anchor_free(strp);
 	strp->anchor = skb;
 
+	strp->sk->sk_protocol == IPPROTO_MPTCP ?
+	mptcp_read_done(strp->sk, strp->stm.full_len) :
 	tcp_read_done(strp->sk, strp->stm.full_len);
 	strp->copy_mode = 1;
 
@@ -464,7 +466,9 @@ static void tls_strp_load_anchor_with_queue(struct tls_strparser *strp, int len)
 	struct sk_buff *first;
 	u32 offset;
 
-	first = tcp_recv_skb(strp->sk, tp->copied_seq, &offset);
+	first = strp->sk->sk_protocol == IPPROTO_MPTCP ?
+		mptcp_recv_skb(strp->sk, &offset) :
+		tcp_recv_skb(strp->sk, tp->copied_seq, &offset);
 	if (WARN_ON_ONCE(!first))
 		return;
 
@@ -490,7 +494,9 @@ bool tls_strp_msg_load(struct tls_strparser *strp, bool force_refresh)
 	DEBUG_NET_WARN_ON_ONCE(!strp->stm.full_len);
 
 	if (!strp->copy_mode && force_refresh) {
-		if (unlikely(tcp_inq(strp->sk) < strp->stm.full_len)) {
+		if (unlikely((strp->sk->sk_protocol == IPPROTO_MPTCP ?
+			      mptcp_inq_hint(strp->sk) :
+			      tcp_inq(strp->sk)) < strp->stm.full_len)) {
 			WRITE_ONCE(strp->msg_ready, 0);
 			memset(&strp->stm, 0, sizeof(strp->stm));
 			return false;
@@ -513,7 +519,9 @@ static int tls_strp_read_sock(struct tls_strparser *strp)
 {
 	int sz, inq;
 
-	inq = tcp_inq(strp->sk);
+	inq = strp->sk->sk_protocol == IPPROTO_MPTCP ?
+	      mptcp_inq_hint(strp->sk) :
+	      tcp_inq(strp->sk);
 	if (inq < 1)
 		return 0;
 
@@ -586,6 +594,8 @@ void tls_strp_msg_done(struct tls_strparser *strp)
 	WARN_ON(!strp->stm.full_len);
 
 	if (likely(!strp->copy_mode))
+		strp->sk->sk_protocol == IPPROTO_MPTCP ?
+		mptcp_read_done(strp->sk, strp->stm.full_len) :
 		tcp_read_done(strp->sk, strp->stm.full_len);
 	else
 		tls_strp_flush_anchor_copy(strp);
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 9937d4c810f2..375f6f8304c3 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1958,7 +1958,9 @@ tls_read_flush_backlog(struct sock *sk, struct tls_prot_info *prot,
 		return false;
 
 	max_rec = prot->overhead_size - prot->tail_size + TLS_MAX_PAYLOAD_SIZE;
-	if (done - *flushed_at < SZ_128K && tcp_inq(sk) > max_rec)
+	if (done - *flushed_at < SZ_128K && (sk->sk_protocol == IPPROTO_MPTCP ?
+					     mptcp_inq_hint(sk) :
+					     tcp_inq(sk)) > max_rec)
 		return false;
 
 	*flushed_at = done;
-- 
2.51.0

