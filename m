Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017211DC9B5
	for <mptcp@lists.linux.dev>; Thu, 23 Apr 2026 06:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776926009; cv=none; b=NUsIPNGur9FV+7BvSNR8UWepPd203VBgXoDVfb/z5lHfDnYGLaaVnne3cppKyqpmwFJM4oM0NO++hD14qayC62h4zq5lAl41l39zFWPzwxY/ACbdyUjSRMxijzbxW0lAEPW5AvIGKHbMmfGkqNqQWgz7d3pESE4v5ayJ9n3Nljk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776926009; c=relaxed/simple;
	bh=XBl7QhZuYO+GloVqdLIVLDocOg/voRz7QXEe2A/8g1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nFGxBB7CEE3Uu9/Y1f0dS++SoCcsEhvM52mfyh5t8h7aNyDJ4ZTu0kxyBRog0G76V8YioMcRo4Ed1QbE38z9Tcyokuh/OT/7S+HVfJN4IT6rqsdTMucS1rRZBttH2m5uhJPcCosMG0Fy72AGmkVtWQrjC9TAiVuZHo7VcY27JDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEm5xaHO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEm5xaHO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA77C2BCB2;
	Thu, 23 Apr 2026 06:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776926008;
	bh=XBl7QhZuYO+GloVqdLIVLDocOg/voRz7QXEe2A/8g1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jEm5xaHO+/GxuV93LWD6OEPwhlFWMnu/HHFRKpx3XQq8FUEST90Zy0hc+uIZayonJ
	 dn6f/K5HAh+E8GmseIjVO9IJ3qukWk/Z7VYR050cNGzMOQqW4ebpNZ+SrUQ29VRio1
	 wK4eGQOfog8/YGvn0HQMbXSvaNoajGjeKdF4KAXytA/3eRaSRbvN//wHMDZwHsu+vX
	 GVrMB5LOfpKZV0lu57UvZ9uJtW+tMJCThxS3bYKNwLgffSc0Q5Hztkws1F1rqD6CZ+
	 CFIRP+5fbtPRwKbXySy33lKS/2CH4KtPsPkJxS+HsA+lgnYlLUroCe1PG16jExJt1T
	 33LkAm2b+f3BA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next v16 04/16] tls: replace direct protocol calls with tls_proto->ops
Date: Thu, 23 Apr 2026 14:32:57 +0800
Message-ID: <b6ad7a658554a0565216abc6ec4d8fa712bd0e64.1776924681.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1776924681.git.tanggeliang@kylinos.cn>
References: <cover.1776924681.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The places originally calling TLS-specific helpers have now been modified
to indirectly invoke them via 'ops' pointer in tls_proto. Make TLS code
protocol-agnostic.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/tls/tls_main.c | 10 ++++++----
 net/tls/tls_strp.c | 33 ++++++++++++++++++++++-----------
 net/tls/tls_sw.c   |  7 +++++--
 3 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 68308a42899b..5cb344ae2721 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -228,13 +228,13 @@ int tls_push_sg(struct sock *sk,
 	ctx->splicing_pages = true;
 	while (1) {
 		/* is sending application-limited? */
-		tcp_rate_check_app_limited(sk);
+		ctx->proto->ops->check_app_limited(sk);
 		p = sg_page(sg);
 retry:
 		bvec_set_page(&bvec, p, size, offset);
 		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
 
-		ret = tcp_sendmsg_locked(sk, &msg, size);
+		ret = ctx->proto->ops->sendmsg_locked(sk, &msg, size);
 
 		if (ret != size) {
 			if (ret > 0) {
@@ -459,14 +459,16 @@ static __poll_t tls_sk_poll(struct file *file, struct socket *sock,
 	u8 shutdown;
 	int state;
 
-	mask = tcp_poll(file, sock, wait);
+	tls_ctx = tls_get_ctx(sk);
+	if (!tls_ctx || !tls_ctx->proto || !tls_ctx->proto->ops)
+		return 0;
+	mask = tls_ctx->proto->ops->poll(file, sock, wait);
 
 	state = inet_sk_state_load(sk);
 	shutdown = READ_ONCE(sk->sk_shutdown);
 	if (unlikely(state != TCP_ESTABLISHED || shutdown & RCV_SHUTDOWN))
 		return mask;
 
-	tls_ctx = tls_get_ctx(sk);
 	ctx = tls_sw_ctx_rx(tls_ctx);
 	psock = sk_psock_get(sk);
 
diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index 98e12f0ff57e..94407b639820 100644
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
+	tls_ctx->proto->ops->read_done(strp->sk, strp->stm.full_len);
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
+	ctx->proto->ops->read_sock(strp->sk, &desc, tls_strp_copyin);
 
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
+	if (likely(qshort && !ctx->proto->ops->epollin_ready(strp->sk)))
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
+	seq = ctx->proto->ops->get_skb_seq(first);
 
 	/* Make sure there's no duplicate data in the queue,
 	 * and the decrypted status matches.
@@ -449,7 +454,7 @@ static bool tls_strp_check_queue_ok(struct tls_strparser *strp)
 		len -= skb->len;
 		skb = skb->next;
 
-		if (TCP_SKB_CB(skb)->seq != seq)
+		if (ctx->proto->ops->get_skb_seq(skb) != seq)
 			return false;
 		if (skb_cmp_decrypted(first, skb))
 			return false;
@@ -460,11 +465,11 @@ static bool tls_strp_check_queue_ok(struct tls_strparser *strp)
 
 static void tls_strp_load_anchor_with_queue(struct tls_strparser *strp, int len)
 {
-	struct tcp_sock *tp = tcp_sk(strp->sk);
+	struct tls_context *ctx = tls_get_ctx(strp->sk);
 	struct sk_buff *first;
 	u32 offset;
 
-	first = tcp_recv_skb(strp->sk, tp->copied_seq, &offset);
+	first = ctx->proto->ops->recv_skb(strp->sk, &offset);
 	if (WARN_ON_ONCE(!first))
 		return;
 
@@ -483,6 +488,7 @@ static void tls_strp_load_anchor_with_queue(struct tls_strparser *strp, int len)
 
 bool tls_strp_msg_load(struct tls_strparser *strp, bool force_refresh)
 {
+	struct tls_context *ctx = tls_get_ctx(strp->sk);
 	struct strp_msg *rxm;
 	struct tls_msg *tlm;
 
@@ -490,7 +496,7 @@ bool tls_strp_msg_load(struct tls_strparser *strp, bool force_refresh)
 	DEBUG_NET_WARN_ON_ONCE(!strp->stm.full_len);
 
 	if (!strp->copy_mode && force_refresh) {
-		if (unlikely(tcp_inq(strp->sk) < strp->stm.full_len)) {
+		if (unlikely(ctx->proto->ops->inq(strp->sk) < strp->stm.full_len)) {
 			WRITE_ONCE(strp->msg_ready, 0);
 			memset(&strp->stm, 0, sizeof(strp->stm));
 			return false;
@@ -511,9 +517,10 @@ bool tls_strp_msg_load(struct tls_strparser *strp, bool force_refresh)
 /* Called with lock held on lower socket */
 static int tls_strp_read_sock(struct tls_strparser *strp)
 {
+	struct tls_context *ctx = tls_get_ctx(strp->sk);
 	int sz, inq;
 
-	inq = tcp_inq(strp->sk);
+	inq = ctx->proto->ops->inq(strp->sk);
 	if (inq < 1)
 		return 0;
 
@@ -556,6 +563,8 @@ void tls_strp_check_rcv(struct tls_strparser *strp)
 /* Lower sock lock held */
 void tls_strp_data_ready(struct tls_strparser *strp)
 {
+	struct tls_context *ctx = tls_get_ctx(strp->sk);
+
 	/* This check is needed to synchronize with do_tls_strp_work.
 	 * do_tls_strp_work acquires a process lock (lock_sock) whereas
 	 * the lock held here is bh_lock_sock. The two locks can be
@@ -563,7 +572,7 @@ void tls_strp_data_ready(struct tls_strparser *strp)
 	 * allows a thread in BH context to safely check if the process
 	 * lock is held. In this case, if the lock is held, queue work.
 	 */
-	if (sock_owned_by_user_nocheck(strp->sk)) {
+	if (ctx->proto->ops->lock_is_held(strp->sk)) {
 		queue_work(tls_strp_wq, &strp->work);
 		return;
 	}
@@ -583,10 +592,12 @@ static void tls_strp_work(struct work_struct *w)
 
 void tls_strp_msg_done(struct tls_strparser *strp)
 {
+	struct tls_context *ctx = tls_get_ctx(strp->sk);
+
 	WARN_ON(!strp->stm.full_len);
 
 	if (likely(!strp->copy_mode))
-		tcp_read_done(strp->sk, strp->stm.full_len);
+		ctx->proto->ops->read_done(strp->sk, strp->stm.full_len);
 	else
 		tls_strp_flush_anchor_copy(strp);
 
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 94d2ae0daa8c..af8b60ddcc00 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1963,13 +1963,14 @@ tls_read_flush_backlog(struct sock *sk, struct tls_prot_info *prot,
 		       size_t len_left, size_t decrypted, ssize_t done,
 		       size_t *flushed_at)
 {
+	struct tls_context *tls_ctx = tls_get_ctx(sk);
 	size_t max_rec;
 
 	if (len_left <= decrypted)
 		return false;
 
 	max_rec = prot->overhead_size - prot->tail_size + TLS_MAX_PAYLOAD_SIZE;
-	if (done - *flushed_at < SZ_128K && tcp_inq(sk) > max_rec)
+	if (done - *flushed_at < SZ_128K && tls_ctx->proto->ops->inq(sk) > max_rec)
 		return false;
 
 	*flushed_at = done;
@@ -2455,6 +2456,7 @@ int tls_rx_msg_size(struct tls_strparser *strp, struct sk_buff *skb)
 	size_t cipher_overhead;
 	size_t data_len = 0;
 	int ret;
+	u32 seq;
 
 	/* Verify that we have a full TLS header, or wait for more data */
 	if (strp->stm.offset + prot->prepend_size > skb->len)
@@ -2497,8 +2499,9 @@ int tls_rx_msg_size(struct tls_strparser *strp, struct sk_buff *skb)
 		goto read_failure;
 	}
 
+	seq = tls_ctx->proto->ops->get_skb_seq(skb);
 	tls_device_rx_resync_new_rec(strp->sk, data_len + TLS_HEADER_SIZE,
-				     TCP_SKB_CB(skb)->seq + strp->stm.offset);
+				     seq + strp->stm.offset);
 	return data_len + TLS_HEADER_SIZE;
 
 read_failure:
-- 
2.51.0

