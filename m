Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95E2248F47
	for <mptcp@lists.linux.dev>; Sun,  4 Jan 2026 09:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767519320; cv=none; b=c0X48UILoLrkzNuzyqyRKVPADYMjoY1pGRO6+xkzZThSsa4sTMfAp/OSWL/HCOXPZfRtUPob9yGeQ+q4MRiePxBAng6jX4G5lHnBVUUW4Oo54WUcbvIyHqPsPRvvX5R75qmaBV1BkhzVgg0NcOvqmyP4rhKovyH6kKitM9DVFWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767519320; c=relaxed/simple;
	bh=hLu4//MUmVzrCtXNYRdgKzJ//Lk1VhPUAXEvOIqcENI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sjbQoYprYs5gUSFMdQSlk12ZW3JM+Fg6Ut0Y22JHaLU+gvXhVT4A9QBw7/Lx2ZbDwPGe7rdCBs9FKog3XkNPyXsROimCaigE/Y/m+G4wGg6j1hbaFOvE8TbnVNkuSVJSYlmhnzCV3hZiO/ft5udTyxQlSfJ6zmwXziMe9vjM9Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEquVGZW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEquVGZW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3527C4CEF7;
	Sun,  4 Jan 2026 09:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767519320;
	bh=hLu4//MUmVzrCtXNYRdgKzJ//Lk1VhPUAXEvOIqcENI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aEquVGZWcey3Ahresubi3diAdJEkWPBYZcRqu/el6immr2hPfekC3Zpni5483RpZ9
	 f1h0ZuEWM5GB65/p9d0Er2S9pZaZPbAZSOWNSw584w5OvSc7t4WMcTYSp5uioTjwsc
	 3aeGmfRyUepPEBh8Nf38WY2652cEj4pBt0UAm5DhlQ/olJ9RRs+j3VZaIOj0MYYOEO
	 lMnD1+ugJREe5tDBGdFBFWxxb5G2f5AbOeSNjoCqqQNyKzR6aBRg+lkJw7HypOcube
	 ZL8QjesEOT/KjCWkJF7cCk1v2+RBz8xPZO8jOmLEHk299t/QplJRcIQYO9ECXma10P
	 f0mIF9X+kY6Tg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v6 02/10] tls: add ops in tls_context
Date: Sun,  4 Jan 2026 17:35:03 +0800
Message-ID: <26e538fc7e23e250e041b872794a5b915e6cc0ec.1767518836.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1767518836.git.tanggeliang@kylinos.cn>
References: <cover.1767518836.git.tanggeliang@kylinos.cn>
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
 include/net/tls.h    |  1 +
 net/tls/tls_device.c |  4 ++--
 net/tls/tls_main.c   | 11 ++++++++---
 net/tls/tls_strp.c   | 28 +++++++++++++++++++---------
 net/tls/tls_sw.c     |  5 +++--
 5 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index 34c39d3d284f..47b9b17d87ec 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -275,6 +275,7 @@ struct tls_context {
 	struct sock *sk;
 
 	void (*sk_destruct)(struct sock *sk);
+	const struct tls_prot_ops *ops;
 
 	union tls_crypto_context crypto_send;
 	union tls_crypto_context crypto_recv;
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 82ea407e520a..c03bd4c41bc8 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -805,7 +805,7 @@ void tls_device_rx_resync_new_rec(struct sock *sk, u32 rcd_len, u32 seq)
 		/* head of next rec is already in, note that the sock_inq will
 		 * include the currently parsed message when called from parser
 		 */
-		sock_data = tcp_inq(sk);
+		sock_data = tls_ctx->ops->inq(sk);
 		if (sock_data > rcd_len) {
 			trace_tls_device_rx_resync_nh_delay(sk, sock_data,
 							    rcd_len);
@@ -864,7 +864,7 @@ static void tls_device_core_ctrl_rx_resync(struct tls_context *tls_ctx,
 	rxm = strp_msg(skb);
 
 	/* head of next rec is already in, parser will sync for us */
-	if (tcp_inq(sk) > rxm->full_len) {
+	if (tls_ctx->ops->inq(sk) > rxm->full_len) {
 		trace_tls_device_rx_resync_nh_schedule(sk);
 		ctx->resync_nh_do_now = 1;
 	} else {
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 42d72539ecd3..5d58351e2a03 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -194,7 +194,7 @@ int tls_push_sg(struct sock *sk,
 		bvec_set_page(&bvec, p, size, offset);
 		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
 
-		ret = tcp_sendmsg_locked(sk, &msg, size);
+		ret = ctx->ops->sendmsg_locked(sk, &msg, size);
 
 		if (ret != size) {
 			if (ret > 0) {
@@ -409,14 +409,14 @@ static __poll_t tls_sk_poll(struct file *file, struct socket *sock,
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
 
@@ -809,6 +809,11 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
 		ctx->tx_conf = conf;
 	else
 		ctx->rx_conf = conf;
+	spin_lock(&tls_prot_ops_lock);
+	ctx->ops = tls_prot_ops_find(sk->sk_protocol);
+	spin_unlock(&tls_prot_ops_lock);
+	if (!ctx->ops)
+		return -EINVAL;
 	update_sk_prot(sk, ctx);
 
 	if (update)
diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index 98e12f0ff57e..3e79a8cfaadf 100644
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
+	seq = ctx->ops->get_seq(first);
 
 	/* Make sure there's no duplicate data in the queue,
 	 * and the decrypted status matches.
@@ -449,7 +454,7 @@ static bool tls_strp_check_queue_ok(struct tls_strparser *strp)
 		len -= skb->len;
 		skb = skb->next;
 
-		if (TCP_SKB_CB(skb)->seq != seq)
+		if (ctx->ops->get_seq(skb) != seq)
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
index 9937d4c810f2..a36f23aae603 100644
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
@@ -2489,7 +2490,7 @@ int tls_rx_msg_size(struct tls_strparser *strp, struct sk_buff *skb)
 	}
 
 	tls_device_rx_resync_new_rec(strp->sk, data_len + TLS_HEADER_SIZE,
-				     TCP_SKB_CB(skb)->seq + strp->stm.offset);
+				     tls_ctx->ops->get_seq(skb) + strp->stm.offset);
 	return data_len + TLS_HEADER_SIZE;
 
 read_failure:
-- 
2.51.0

