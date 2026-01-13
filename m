Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41989387375
	for <mptcp@lists.linux.dev>; Tue, 13 Jan 2026 09:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768295372; cv=none; b=g05bL4c52LdI32NfZp6gNlc/ZRS6H9YSNJ5L2RpgLRqlmHqA6Q0LcHgSGmHef9M0xs80GnprjKVygT0LwTRfahhWWamOZjva7uYKzhmIIO4fa4dfKsJhRsBjYWKpIt4s3kmP1qrwKqprN5hr8sL3Pj+xws/smI9CHk7fPzIzkSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768295372; c=relaxed/simple;
	bh=PaN9BsAa0rXJt9Y4NO/ODPWLtg4xVtpTvyxvBJdE1mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gSRfCOB71Tek56IHVkxVCKAScE3yT5I+8B0thaFH6pDxDD3HF84NWO9BOy/1JJ3v6rtx9QDlr88lLZ+XJQ1OGb5kKr50PBR1l6UIrwpipYU5v6MBgmkzPnC5oz04vk4pTBI9Qdj7xlOoChhbla1qAkq5gBXynjAQ/5Dzi7H0Cls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZT1WRIoA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZT1WRIoA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E6FC116C6;
	Tue, 13 Jan 2026 09:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768295371;
	bh=PaN9BsAa0rXJt9Y4NO/ODPWLtg4xVtpTvyxvBJdE1mQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZT1WRIoAvyiUrxfedSmrz5vX+FBm55ufqKYGQ5J+AX3DIhjqnuOGgsl8akMWDuv0a
	 GpOwUk7m84pMtP8QuZ/0ehQ5xNHcVm9mceIPA3DuBWgWMrge/H8f5OHOJEQYmItkWE
	 QwD243OZYfoMIoGCLCbUqeZMoUkA/wkeSFLs6Trx8aUIG5hensPTDHMxkXnFfIH2Q1
	 5+UFEkO1D1h228EoikFBiZdNQc0Ex30v5OyYUal8Ges9R1xjg1PxPabvguMuOBNNd5
	 kPRd4Hky3qhn/31kjFRbVzgie7c0N1t85Sxkol5Mx5+ipi8rPjeH8wn56mOXsEHvHc
	 w5DJ0M6r1Lwwg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v8 3/9] tls: add ops in tls_context
Date: Tue, 13 Jan 2026 17:09:11 +0800
Message-ID: <e72b624a7528405e3d8c821c5797bef70bc0ed86.1768294706.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1768294706.git.tanggeliang@kylinos.cn>
References: <cover.1768294706.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

A pointer to struct tls_prot_ops, named 'ops', has been added to struct
tls_context. The places originally calling TLS-specific helpers have now
been modified to indirectly invoke them via 'ops' pointer in tls_context.

In do_tls_setsockopt_conf(), ctx->ops is assigned either 'tls_mptcp_ops'
or 'tls_tcp_ops' based on the socket protocol.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/tls.h  |  1 +
 net/tls/tls_main.c | 13 +++++++++----
 net/tls/tls_strp.c | 28 +++++++++++++++++++---------
 net/tls/tls_sw.c   |  7 +++++--
 4 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index 5f730fb6e801..d9b2a8d2a25b 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -276,6 +276,7 @@ struct tls_context {
 	struct sock *sk;
 
 	void (*sk_destruct)(struct sock *sk);
+	const struct tls_prot_ops *ops;
 
 	union tls_crypto_context crypto_send;
 	union tls_crypto_context crypto_recv;
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 525f0641d3d0..af45919652f8 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -206,13 +206,13 @@ int tls_push_sg(struct sock *sk,
 	ctx->splicing_pages = true;
 	while (1) {
 		/* is sending application-limited? */
-		tcp_rate_check_app_limited(sk);
+		ctx->ops->check_app_limited(sk);
 		p = sg_page(sg);
 retry:
 		bvec_set_page(&bvec, p, size, offset);
 		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
 
-		ret = tcp_sendmsg_locked(sk, &msg, size);
+		ret = ctx->ops->sendmsg_locked(sk, &msg, size);
 
 		if (ret != size) {
 			if (ret > 0) {
@@ -427,14 +427,14 @@ static __poll_t tls_sk_poll(struct file *file, struct socket *sock,
 	u8 shutdown;
 	int state;
 
-	mask = tcp_poll(file, sock, wait);
+	tls_ctx = tls_get_ctx(sk);
+	mask = tls_ctx->ops->poll(file, sock, wait);
 
 	state = inet_sk_state_load(sk);
 	shutdown = READ_ONCE(sk->sk_shutdown);
 	if (unlikely(state != TCP_ESTABLISHED || shutdown & RCV_SHUTDOWN))
 		return mask;
 
-	tls_ctx = tls_get_ctx(sk);
 	ctx = tls_sw_ctx_rx(tls_ctx);
 	psock = sk_psock_get(sk);
 
@@ -1094,6 +1094,11 @@ static int tls_init(struct sock *sk)
 	ctx->tx_conf = TLS_BASE;
 	ctx->rx_conf = TLS_BASE;
 	ctx->tx_max_payload_len = TLS_MAX_PAYLOAD_SIZE;
+	ctx->ops = tls_prot_ops_find(sk->sk_protocol);
+	if (!ctx->ops) {
+		rc = -EINVAL;
+		goto out;
+	}
 	update_sk_prot(sk, ctx);
 out:
 	write_unlock_bh(&sk->sk_callback_lock);
diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index 98e12f0ff57e..f3d5c4325683 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -120,6 +120,7 @@ struct sk_buff *tls_strp_msg_detach(struct tls_sw_context_rx *ctx)
 int tls_strp_msg_cow(struct tls_sw_context_rx *ctx)
 {
 	struct tls_strparser *strp = &ctx->strp;
+	struct tls_context *tls_ctx;
 	struct sk_buff *skb;
 
 	if (strp->copy_mode)
@@ -132,7 +133,8 @@ int tls_strp_msg_cow(struct tls_sw_context_rx *ctx)
 	tls_strp_anchor_free(strp);
 	strp->anchor = skb;
 
-	tcp_read_done(strp->sk, strp->stm.full_len);
+	tls_ctx = tls_get_ctx(strp->sk);
+	tls_ctx->ops->read_done(strp->sk, strp->stm.full_len);
 	strp->copy_mode = 1;
 
 	return 0;
@@ -376,6 +378,7 @@ static int tls_strp_copyin(read_descriptor_t *desc, struct sk_buff *in_skb,
 
 static int tls_strp_read_copyin(struct tls_strparser *strp)
 {
+	struct tls_context *ctx = tls_get_ctx(strp->sk);
 	read_descriptor_t desc;
 
 	desc.arg.data = strp;
@@ -383,13 +386,14 @@ static int tls_strp_read_copyin(struct tls_strparser *strp)
 	desc.count = 1; /* give more than one skb per call */
 
 	/* sk should be locked here, so okay to do read_sock */
-	tcp_read_sock(strp->sk, &desc, tls_strp_copyin);
+	ctx->ops->read_sock(strp->sk, &desc, tls_strp_copyin);
 
 	return desc.error;
 }
 
 static int tls_strp_read_copy(struct tls_strparser *strp, bool qshort)
 {
+	struct tls_context *ctx = tls_get_ctx(strp->sk);
 	struct skb_shared_info *shinfo;
 	struct page *page;
 	int need_spc, len;
@@ -398,7 +402,7 @@ static int tls_strp_read_copy(struct tls_strparser *strp, bool qshort)
 	 * to read the data out. Otherwise the connection will stall.
 	 * Without pressure threshold of INT_MAX will never be ready.
 	 */
-	if (likely(qshort && !tcp_epollin_ready(strp->sk, INT_MAX)))
+	if (likely(qshort && !ctx->ops->epollin_ready(strp->sk, INT_MAX)))
 		return 0;
 
 	shinfo = skb_shinfo(strp->anchor);
@@ -434,12 +438,13 @@ static int tls_strp_read_copy(struct tls_strparser *strp, bool qshort)
 static bool tls_strp_check_queue_ok(struct tls_strparser *strp)
 {
 	unsigned int len = strp->stm.offset + strp->stm.full_len;
+	struct tls_context *ctx = tls_get_ctx(strp->sk);
 	struct sk_buff *first, *skb;
 	u32 seq;
 
 	first = skb_shinfo(strp->anchor)->frag_list;
 	skb = first;
-	seq = TCP_SKB_CB(first)->seq;
+	seq = ctx->ops->get_skb_seq(first);
 
 	/* Make sure there's no duplicate data in the queue,
 	 * and the decrypted status matches.
@@ -449,7 +454,7 @@ static bool tls_strp_check_queue_ok(struct tls_strparser *strp)
 		len -= skb->len;
 		skb = skb->next;
 
-		if (TCP_SKB_CB(skb)->seq != seq)
+		if (ctx->ops->get_skb_seq(skb) != seq)
 			return false;
 		if (skb_cmp_decrypted(first, skb))
 			return false;
@@ -460,11 +465,12 @@ static bool tls_strp_check_queue_ok(struct tls_strparser *strp)
 
 static void tls_strp_load_anchor_with_queue(struct tls_strparser *strp, int len)
 {
+	struct tls_context *ctx = tls_get_ctx(strp->sk);
 	struct tcp_sock *tp = tcp_sk(strp->sk);
 	struct sk_buff *first;
 	u32 offset;
 
-	first = tcp_recv_skb(strp->sk, tp->copied_seq, &offset);
+	first = ctx->ops->recv_skb(strp->sk, tp->copied_seq, &offset);
 	if (WARN_ON_ONCE(!first))
 		return;
 
@@ -483,6 +489,7 @@ static void tls_strp_load_anchor_with_queue(struct tls_strparser *strp, int len)
 
 bool tls_strp_msg_load(struct tls_strparser *strp, bool force_refresh)
 {
+	struct tls_context *ctx = tls_get_ctx(strp->sk);
 	struct strp_msg *rxm;
 	struct tls_msg *tlm;
 
@@ -490,7 +497,7 @@ bool tls_strp_msg_load(struct tls_strparser *strp, bool force_refresh)
 	DEBUG_NET_WARN_ON_ONCE(!strp->stm.full_len);
 
 	if (!strp->copy_mode && force_refresh) {
-		if (unlikely(tcp_inq(strp->sk) < strp->stm.full_len)) {
+		if (unlikely(ctx->ops->inq(strp->sk) < strp->stm.full_len)) {
 			WRITE_ONCE(strp->msg_ready, 0);
 			memset(&strp->stm, 0, sizeof(strp->stm));
 			return false;
@@ -511,9 +518,10 @@ bool tls_strp_msg_load(struct tls_strparser *strp, bool force_refresh)
 /* Called with lock held on lower socket */
 static int tls_strp_read_sock(struct tls_strparser *strp)
 {
+	struct tls_context *ctx = tls_get_ctx(strp->sk);
 	int sz, inq;
 
-	inq = tcp_inq(strp->sk);
+	inq = ctx->ops->inq(strp->sk);
 	if (inq < 1)
 		return 0;
 
@@ -583,10 +591,12 @@ static void tls_strp_work(struct work_struct *w)
 
 void tls_strp_msg_done(struct tls_strparser *strp)
 {
+	struct tls_context *ctx = tls_get_ctx(strp->sk);
+
 	WARN_ON(!strp->stm.full_len);
 
 	if (likely(!strp->copy_mode))
-		tcp_read_done(strp->sk, strp->stm.full_len);
+		ctx->ops->read_done(strp->sk, strp->stm.full_len);
 	else
 		tls_strp_flush_anchor_copy(strp);
 
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 9937d4c810f2..c932725b75e6 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1952,13 +1952,14 @@ tls_read_flush_backlog(struct sock *sk, struct tls_prot_info *prot,
 		       size_t len_left, size_t decrypted, ssize_t done,
 		       size_t *flushed_at)
 {
+	struct tls_context *tls_ctx = tls_get_ctx(sk);
 	size_t max_rec;
 
 	if (len_left <= decrypted)
 		return false;
 
 	max_rec = prot->overhead_size - prot->tail_size + TLS_MAX_PAYLOAD_SIZE;
-	if (done - *flushed_at < SZ_128K && tcp_inq(sk) > max_rec)
+	if (done - *flushed_at < SZ_128K && tls_ctx->ops->inq(sk) > max_rec)
 		return false;
 
 	*flushed_at = done;
@@ -2446,6 +2447,7 @@ int tls_rx_msg_size(struct tls_strparser *strp, struct sk_buff *skb)
 	size_t cipher_overhead;
 	size_t data_len = 0;
 	int ret;
+	u32 seq;
 
 	/* Verify that we have a full TLS header, or wait for more data */
 	if (strp->stm.offset + prot->prepend_size > skb->len)
@@ -2488,8 +2490,9 @@ int tls_rx_msg_size(struct tls_strparser *strp, struct sk_buff *skb)
 		goto read_failure;
 	}
 
+	seq = tls_ctx->ops->get_skb_seq(skb);
 	tls_device_rx_resync_new_rec(strp->sk, data_len + TLS_HEADER_SIZE,
-				     TCP_SKB_CB(skb)->seq + strp->stm.offset);
+				     seq + strp->stm.offset);
 	return data_len + TLS_HEADER_SIZE;
 
 read_failure:
-- 
2.51.0

