Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF6A314D35
	for <mptcp@lists.linux.dev>; Fri, 24 Apr 2026 10:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777027140; cv=none; b=Xh/4L4pQCis1MsF09dyEX6EeqYUJQGINWk3KH+nUx/x5q5eHYh2ESGEjJrbK+ZFWAP8vgg1B5kYN2yMgTQI1LJD6RnFADcxdb0+0CAgw+nlqsZDCfKlCuw2LOFepDPh2yXj2vdllY29HdF8iXok9wJBZ//mRciJ7VlVzASXxZ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777027140; c=relaxed/simple;
	bh=vH9GvOuvFNjqaTZkkNTe9MPmBlrFcscM6IVaZz5QB+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kpFcZ8hEzQVs71ZYxN68kSvcJyLgoGLevHHbNeVFoqh7ETffie+BQ9JUHHMrUJbe1sVetqWRrbEquTqxNDNFixgptyBxkRH77bnfzPMVB7k1zTKMU116A7iVAFXA+lBkZowcaQuwYFbwGzdFDYLuJ5ZxRc/mNdPKflpJWrH8AaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3GakBZK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3GakBZK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E244FC2BCB4;
	Fri, 24 Apr 2026 10:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777027140;
	bh=vH9GvOuvFNjqaTZkkNTe9MPmBlrFcscM6IVaZz5QB+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h3GakBZKApTQKtB2U0aWd0ImKHfKTIokmT75xUyCZd6GNTRZDk08xLFmA6wCUeA6i
	 VaFrZF/Z7I6y7+vCZIUoYjmOYqVTgBz9F8ovi3IVR6d3IaFJolMgSLMZ2aViR18voN
	 xvp9NLvxE0+cDXUgnYyvUP9PVQP9sVHbb/IGLgt6dMpUo6kAVRLGxh9icwKz1GV/vn
	 COWltQoBDQczeyxDeLF5O31/XUzE2C/P8J6yQv9MnKhd/pGP7m06CSPRMNQV8mcuZJ
	 EXt0+K/tURHsg1H1WN4I4xh5oRrTApGFdrAh4P3G6ognBsmQz1Z12ZdhtTew0HT7kR
	 PUuIAMBlkFyaw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v17 03/15] tls: add tls_prot_ops pointer to tls_proto
Date: Fri, 24 Apr 2026 18:38:27 +0800
Message-ID: <a33e1a65cc8e5feb698542b92762d4f0d8cb7d12.1777026753.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777026753.git.tanggeliang@kylinos.cn>
References: <cover.1777026753.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

A pointer to struct tls_prot_ops, named 'ops', has been added to struct
tls_proto. The places originally calling TLS-specific helpers have now
been modified to indirectly invoke them via 'ops' pointer in tls_proto.

In tls_build_proto(), proto->ops is assigned either 'tls_mptcp_ops' or
'tls_tcp_ops' based on the socket protocol.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/tls.h  |  1 +
 net/tls/tls_main.c | 20 ++++++++++++++++----
 net/tls/tls_strp.c | 32 +++++++++++++++++++++-----------
 net/tls/tls_sw.c   |  6 ++++--
 4 files changed, 42 insertions(+), 17 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index 032a618d4a87..b6e355350352 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -249,6 +249,7 @@ struct tls_proto {
 	refcount_t			refcnt;
 	struct list_head		list;
 	const struct proto		*prot;
+	const struct tls_prot_ops	*ops;
 	struct proto prots[TLS_NUM_PROTS][TLS_NUM_CONFIG][TLS_NUM_CONFIG];
 	struct proto_ops proto_ops[TLS_NUM_PROTS][TLS_NUM_CONFIG][TLS_NUM_CONFIG];
 };
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 76faed44fcad..6cb52e285177 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -225,13 +225,13 @@ int tls_push_sg(struct sock *sk,
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
@@ -465,14 +465,16 @@ static __poll_t tls_sk_poll(struct file *file, struct socket *sock,
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
 
@@ -1030,6 +1032,7 @@ static struct tls_proto *tls_build_proto(struct sock *sk)
 {
 	int ip_ver = sk->sk_family == AF_INET6 ? TLSV6 : TLSV4;
 	struct proto *prot = READ_ONCE(sk->sk_prot);
+	struct tls_prot_ops *ops;
 	struct tls_proto *proto;
 
 	mutex_lock(&tls_proto_mutex);
@@ -1037,11 +1040,20 @@ static struct tls_proto *tls_build_proto(struct sock *sk)
 	if (proto)
 		goto out;
 
+	rcu_read_lock();
+	ops = tls_prot_ops_find(sk->sk_protocol);
+	if (!ops) {
+		rcu_read_unlock();
+		goto out;
+	}
+	rcu_read_unlock();
+
 	proto = kzalloc_obj(*proto, GFP_KERNEL);
 	if (!proto)
 		goto out;
 
 	proto->prot = prot;
+	proto->ops = ops;
 	refcount_set(&proto->refcnt, 1);
 	build_protos(proto->prots[ip_ver], prot);
 	build_proto_ops(proto->proto_ops[ip_ver],
diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index 98e12f0ff57e..763f9a06589e 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -120,6 +120,7 @@ struct sk_buff *tls_strp_msg_detach(struct tls_sw_context_rx *ctx)
 int tls_strp_msg_cow(struct tls_sw_context_rx *ctx)
 {
 	struct tls_strparser *strp = &ctx->strp;
+	struct tls_context *tls_ctx = tls_get_ctx(strp->sk);
 	struct sk_buff *skb;
 
 	if (strp->copy_mode)
@@ -132,7 +133,7 @@ int tls_strp_msg_cow(struct tls_sw_context_rx *ctx)
 	tls_strp_anchor_free(strp);
 	strp->anchor = skb;
 
-	tcp_read_done(strp->sk, strp->stm.full_len);
+	tls_ctx->proto->ops->read_done(strp->sk, strp->stm.full_len);
 	strp->copy_mode = 1;
 
 	return 0;
@@ -376,6 +377,7 @@ static int tls_strp_copyin(read_descriptor_t *desc, struct sk_buff *in_skb,
 
 static int tls_strp_read_copyin(struct tls_strparser *strp)
 {
+	struct tls_context *ctx = tls_get_ctx(strp->sk);
 	read_descriptor_t desc;
 
 	desc.arg.data = strp;
@@ -383,13 +385,14 @@ static int tls_strp_read_copyin(struct tls_strparser *strp)
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
@@ -398,7 +401,7 @@ static int tls_strp_read_copy(struct tls_strparser *strp, bool qshort)
 	 * to read the data out. Otherwise the connection will stall.
 	 * Without pressure threshold of INT_MAX will never be ready.
 	 */
-	if (likely(qshort && !tcp_epollin_ready(strp->sk, INT_MAX)))
+	if (likely(qshort && !ctx->proto->ops->epollin_ready(strp->sk)))
 		return 0;
 
 	shinfo = skb_shinfo(strp->anchor);
@@ -434,12 +437,13 @@ static int tls_strp_read_copy(struct tls_strparser *strp, bool qshort)
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
@@ -449,7 +453,7 @@ static bool tls_strp_check_queue_ok(struct tls_strparser *strp)
 		len -= skb->len;
 		skb = skb->next;
 
-		if (TCP_SKB_CB(skb)->seq != seq)
+		if (ctx->proto->ops->get_skb_seq(skb) != seq)
 			return false;
 		if (skb_cmp_decrypted(first, skb))
 			return false;
@@ -460,11 +464,11 @@ static bool tls_strp_check_queue_ok(struct tls_strparser *strp)
 
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
 
@@ -483,6 +487,7 @@ static void tls_strp_load_anchor_with_queue(struct tls_strparser *strp, int len)
 
 bool tls_strp_msg_load(struct tls_strparser *strp, bool force_refresh)
 {
+	int inq = tls_get_ctx(strp->sk)->proto->ops->inq(strp->sk);
 	struct strp_msg *rxm;
 	struct tls_msg *tlm;
 
@@ -490,7 +495,7 @@ bool tls_strp_msg_load(struct tls_strparser *strp, bool force_refresh)
 	DEBUG_NET_WARN_ON_ONCE(!strp->stm.full_len);
 
 	if (!strp->copy_mode && force_refresh) {
-		if (unlikely(tcp_inq(strp->sk) < strp->stm.full_len)) {
+		if (unlikely(inq < strp->stm.full_len)) {
 			WRITE_ONCE(strp->msg_ready, 0);
 			memset(&strp->stm, 0, sizeof(strp->stm));
 			return false;
@@ -511,9 +516,10 @@ bool tls_strp_msg_load(struct tls_strparser *strp, bool force_refresh)
 /* Called with lock held on lower socket */
 static int tls_strp_read_sock(struct tls_strparser *strp)
 {
+	struct tls_context *ctx = tls_get_ctx(strp->sk);
 	int sz, inq;
 
-	inq = tcp_inq(strp->sk);
+	inq = ctx->proto->ops->inq(strp->sk);
 	if (inq < 1)
 		return 0;
 
@@ -556,6 +562,8 @@ void tls_strp_check_rcv(struct tls_strparser *strp)
 /* Lower sock lock held */
 void tls_strp_data_ready(struct tls_strparser *strp)
 {
+	struct tls_context *ctx = tls_get_ctx(strp->sk);
+
 	/* This check is needed to synchronize with do_tls_strp_work.
 	 * do_tls_strp_work acquires a process lock (lock_sock) whereas
 	 * the lock held here is bh_lock_sock. The two locks can be
@@ -563,7 +571,7 @@ void tls_strp_data_ready(struct tls_strparser *strp)
 	 * allows a thread in BH context to safely check if the process
 	 * lock is held. In this case, if the lock is held, queue work.
 	 */
-	if (sock_owned_by_user_nocheck(strp->sk)) {
+	if (ctx->proto->ops->lock_is_held(strp->sk)) {
 		queue_work(tls_strp_wq, &strp->work);
 		return;
 	}
@@ -583,10 +591,12 @@ static void tls_strp_work(struct work_struct *w)
 
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
index 94d2ae0daa8c..34b9359cb0c0 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1963,13 +1963,14 @@ tls_read_flush_backlog(struct sock *sk, struct tls_prot_info *prot,
 		       size_t len_left, size_t decrypted, ssize_t done,
 		       size_t *flushed_at)
 {
+	int inq = tls_get_ctx(sk)->proto->ops->inq(sk);
 	size_t max_rec;
 
 	if (len_left <= decrypted)
 		return false;
 
 	max_rec = prot->overhead_size - prot->tail_size + TLS_MAX_PAYLOAD_SIZE;
-	if (done - *flushed_at < SZ_128K && tcp_inq(sk) > max_rec)
+	if (done - *flushed_at < SZ_128K && inq > max_rec)
 		return false;
 
 	*flushed_at = done;
@@ -2451,6 +2452,7 @@ int tls_rx_msg_size(struct tls_strparser *strp, struct sk_buff *skb)
 {
 	struct tls_context *tls_ctx = tls_get_ctx(strp->sk);
 	struct tls_prot_info *prot = &tls_ctx->prot_info;
+	u32 seq = tls_ctx->proto->ops->get_skb_seq(skb);
 	char header[TLS_HEADER_SIZE + TLS_MAX_IV_SIZE];
 	size_t cipher_overhead;
 	size_t data_len = 0;
@@ -2498,7 +2500,7 @@ int tls_rx_msg_size(struct tls_strparser *strp, struct sk_buff *skb)
 	}
 
 	tls_device_rx_resync_new_rec(strp->sk, data_len + TLS_HEADER_SIZE,
-				     TCP_SKB_CB(skb)->seq + strp->stm.offset);
+				     seq + strp->stm.offset);
 	return data_len + TLS_HEADER_SIZE;
 
 read_failure:
-- 
2.53.0

