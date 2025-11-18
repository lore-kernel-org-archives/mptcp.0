Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC5C2222D1
	for <mptcp@lists.linux.dev>; Tue, 18 Nov 2025 04:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763438519; cv=none; b=ghuF7GtvxdFbLyPjbefw12jbtxvhCKI3qDhOx8A/mkurATjrYaR4n1Yy5DdXfb0cco07Xt7hBrk5OWTziGMQHsxaVRe5Rc/BHuHgLe36lr/lQbUP7zHEixpqWihWEZCeMMbvFPQjd3kVP49uzmzIEq5HHlS3aQwKJ2bq8XEcRlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763438519; c=relaxed/simple;
	bh=zoyg5NDiQaKaJCwCEchfcn2pfpoRETFMehLiecMxx3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DhhwiwW43eo0JC9v7pEp3tRKVPTTV5mfOyRmEnPmVgPmJCpb7UQ1AlirXMt/4GwalEjz7WQXkUClxcVZHzBOlIKtALgvqRps3Fp2Jaj7fIfVHti3PHHUYH3cyQj6PCzeL8e7lz+8tMzG2BTTf31gOA2U20b9wXOz93KLYXyqhrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsDsNdvi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsDsNdvi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E6AC4CEF1;
	Tue, 18 Nov 2025 04:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763438518;
	bh=zoyg5NDiQaKaJCwCEchfcn2pfpoRETFMehLiecMxx3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bsDsNdvinq6OEcV9tl/p0FrIW2z9uVFJHamHIg8TThYfbpLZ59xl6kHAuKxFBVl9s
	 FWcJX/12uHkn5Kl70q7+7OlGNzWsoYCy6+tmvYS6bmbMl7KvbFHRWe2K6ujHkfJIz9
	 F0abwaDpvIZLAgKH7tPXH9ZSnsiz+Ib6bc0lL5o67WwvxfAEMxlXfCqsz6VTdqzUwd
	 n0YJ/bM84uJtSAGtfbN/WPMouyGKKAvJgYHTQgZVzB9NRFFX6Z3dUavu41zeowihdf
	 qyMqLEKe0eCH1Ei+kR8K5Fx1NNQkafTSkHxCMUQLS4pkykdnVsuJMb/UyVdqCoZcAv
	 R2HVSj4fjWZww==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next 05/10] tls: add MPTCP protocol support
Date: Tue, 18 Nov 2025 12:01:26 +0800
Message-ID: <f852b0b50927168c9971d258bd615638d9f02265.1763438045.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763438045.git.tanggeliang@kylinos.cn>
References: <cover.1763438045.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Extend TLS subsystem to support MPTCP protocol by implementing
MPTCP-specific versions of key operations:

- mptcp_sendmsg_locked() for TLS record transmission
- mptcp_inq_hint() and mptcp_recv_skb() for receive side handling
- mptcp_read_sock() and mptcp_read_done() for data reading

Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h  | 34 ++++++++++++++++++++++++
 net/mptcp/protocol.c | 61 ++++++++++++++++++++++++++++++++++++++------
 net/tls/tls_main.c   |  7 +++--
 net/tls/tls_strp.c   | 20 ++++++++++++---
 4 files changed, 108 insertions(+), 14 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 4cf59e83c1c5..6efa70d93353 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -237,6 +237,17 @@ static inline __be32 mptcp_reset_option(const struct sk_buff *skb)
 }
 
 void mptcp_active_detect_blackhole(struct sock *sk, bool expired);
+
+int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t len);
+
+unsigned int mptcp_inq_hint(const struct sock *sk);
+
+struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off);
+
+int mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
+		    sk_read_actor_t recv_actor);
+
+void mptcp_read_done(struct sock *sk, size_t len);
 #else
 
 static inline void mptcp_init(void)
@@ -323,6 +334,29 @@ static inline struct request_sock *mptcp_subflow_reqsk_alloc(const struct reques
 static inline __be32 mptcp_reset_option(const struct sk_buff *skb)  { return htonl(0u); }
 
 static inline void mptcp_active_detect_blackhole(struct sock *sk, bool expired) { }
+
+static inline int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t len)
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
+static inline int mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
+				  sk_read_actor_t recv_actor)
+{
+	return 0;
+}
+
+static inline void mptcp_read_done(struct sock *sk, size_t len) { }
 #endif /* CONFIG_MPTCP */
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 873c1a93b777..a9181e71bc66 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1861,7 +1861,7 @@ static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
 	}
 }
 
-static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
+int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct page_frag *pfrag;
@@ -1872,8 +1872,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	/* silently ignore everything else */
 	msg->msg_flags &= MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | MSG_FASTOPEN;
 
-	lock_sock(sk);
-
 	mptcp_rps_record_subflows(msk);
 
 	if (unlikely(inet_test_bit(DEFER_CONNECT, sk) ||
@@ -1981,7 +1979,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		__mptcp_push_pending(sk, msg->msg_flags);
 
 out:
-	release_sock(sk);
 	return copied;
 
 do_error:
@@ -1992,6 +1989,17 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
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
@@ -2223,7 +2231,7 @@ static bool mptcp_move_skbs(struct sock *sk)
 	return enqueued;
 }
 
-static unsigned int mptcp_inq_hint(const struct sock *sk)
+unsigned int mptcp_inq_hint(const struct sock *sk)
 {
 	const struct mptcp_sock *msk = mptcp_sk(sk);
 	const struct sk_buff *skb;
@@ -4271,7 +4279,7 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 	return mask;
 }
 
-static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
+struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct sk_buff *skb;
@@ -4295,8 +4303,8 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
  * Note:
  *	- It is assumed that the socket was locked by the caller.
  */
-static int mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
-			   sk_read_actor_t recv_actor)
+int mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
+		    sk_read_actor_t recv_actor)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	size_t len = sk->sk_rcvbuf;
@@ -4453,6 +4461,43 @@ static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
 	return ret;
 }
 
+void mptcp_read_done(struct sock *sk, size_t len)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sk_buff *skb;
+	size_t left;
+	u32 offset;
+
+	sock_owned_by_me(sk);
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
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 56ce0bc8317b..eb1842722267 100644
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
@@ -401,6 +403,7 @@ static void tls_sk_proto_close(struct sock *sk, long timeout)
 static __poll_t tls_sk_poll(struct file *file, struct socket *sock,
 			    struct poll_table_struct *wait)
 {
+	const struct proto_ops *ops = READ_ONCE(sock->ops);
 	struct tls_sw_context_rx *ctx;
 	struct tls_context *tls_ctx;
 	struct sock *sk = sock->sk;
@@ -409,7 +412,7 @@ static __poll_t tls_sk_poll(struct file *file, struct socket *sock,
 	u8 shutdown;
 	int state;
 
-	mask = tcp_poll(file, sock, wait);
+	mask = ops->poll(file, sock, wait);
 
 	state = inet_sk_state_load(sk);
 	shutdown = READ_ONCE(sk->sk_shutdown);
diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index 98e12f0ff57e..3985e77f3351 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -132,6 +132,8 @@ int tls_strp_msg_cow(struct tls_sw_context_rx *ctx)
 	tls_strp_anchor_free(strp);
 	strp->anchor = skb;
 
+	strp->sk->sk_protocol == IPPROTO_MPTCP ?
+	mptcp_read_done(strp->sk, strp->stm.full_len) :
 	tcp_read_done(strp->sk, strp->stm.full_len);
 	strp->copy_mode = 1;
 
@@ -383,6 +385,8 @@ static int tls_strp_read_copyin(struct tls_strparser *strp)
 	desc.count = 1; /* give more than one skb per call */
 
 	/* sk should be locked here, so okay to do read_sock */
+	strp->sk->sk_protocol == IPPROTO_MPTCP ?
+	mptcp_read_sock(strp->sk, &desc, tls_strp_copyin) :
 	tcp_read_sock(strp->sk, &desc, tls_strp_copyin);
 
 	return desc.error;
@@ -464,8 +468,10 @@ static void tls_strp_load_anchor_with_queue(struct tls_strparser *strp, int len)
 	struct sk_buff *first;
 	u32 offset;
 
-	first = tcp_recv_skb(strp->sk, tp->copied_seq, &offset);
-	if (WARN_ON_ONCE(!first))
+	first = strp->sk->sk_protocol == IPPROTO_MPTCP ?
+		mptcp_recv_skb(strp->sk, &offset) :
+		tcp_recv_skb(strp->sk, tp->copied_seq, &offset);
+	if (!first)
 		return;
 
 	/* Bestow the state onto the anchor */
@@ -490,7 +496,9 @@ bool tls_strp_msg_load(struct tls_strparser *strp, bool force_refresh)
 	DEBUG_NET_WARN_ON_ONCE(!strp->stm.full_len);
 
 	if (!strp->copy_mode && force_refresh) {
-		if (unlikely(tcp_inq(strp->sk) < strp->stm.full_len)) {
+		if (unlikely((strp->sk->sk_protocol == IPPROTO_MPTCP ?
+			      mptcp_inq_hint(strp->sk) :
+			      tcp_inq(strp->sk)) < strp->stm.full_len)) {
 			WRITE_ONCE(strp->msg_ready, 0);
 			memset(&strp->stm, 0, sizeof(strp->stm));
 			return false;
@@ -513,7 +521,9 @@ static int tls_strp_read_sock(struct tls_strparser *strp)
 {
 	int sz, inq;
 
-	inq = tcp_inq(strp->sk);
+	inq = strp->sk->sk_protocol == IPPROTO_MPTCP ?
+	      mptcp_inq_hint(strp->sk) :
+	      tcp_inq(strp->sk);
 	if (inq < 1)
 		return 0;
 
@@ -586,6 +596,8 @@ void tls_strp_msg_done(struct tls_strparser *strp)
 	WARN_ON(!strp->stm.full_len);
 
 	if (likely(!strp->copy_mode))
+		strp->sk->sk_protocol == IPPROTO_MPTCP ?
+		mptcp_read_done(strp->sk, strp->stm.full_len) :
 		tcp_read_done(strp->sk, strp->stm.full_len);
 	else
 		tls_strp_flush_anchor_copy(strp);
-- 
2.51.0

