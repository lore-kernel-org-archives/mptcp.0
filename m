Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBC8883F
	for <mptcp@lists.linux.dev>; Mon,  6 Apr 2026 12:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775478003; cv=none; b=XElrlNE5JiF7hyuDZsSNvFd+gwzZXB8i7UUBPYHr9buqcLyRvaQF596MNiNGzeOai3iD+FBP7xXGrk8HvI4SCRLj7JUjH63bhg4HFp9R7RfepDJzJ/gq+xt5H7FWixlaEPQCUeYYNhFYpNaMfkaXBtjw7j8ZjfMRie2Q6DiBOSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775478003; c=relaxed/simple;
	bh=yu87zsM6mquPHbAYNsGPq0ZTbz7svypenMg041qtb4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=enwNQNcCG59yK/ozyBk8zejgcIqDleOkwwRgP+RkTVIcRqfwb89WWLiGpJb1fxd8sEy3uTWGWmSPpypiYGm8556cmAHyHscVxICnuiLpz7JOJhTBDMxSW6Em+oeAiU1s2RpbKOvnNAsD6QzuJlUv1BHZVxZBRrg91N2okmVWN18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4Y3p9kW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4Y3p9kW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26395C19425;
	Mon,  6 Apr 2026 12:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775478002;
	bh=yu87zsM6mquPHbAYNsGPq0ZTbz7svypenMg041qtb4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R4Y3p9kWdjSPgEu3M0HwZFuXfjUp08Z6cZ9IWVWL1qKw4S0/s/au6nBMjl19WVp3C
	 GljQ1pIqm8vBnqedaN3YSpINPWoxTrfHNbrnqh/5M4trd4NlsdHiYCVJH/+ZA/XVFO
	 muVUbo/wfjNiu3WhmI58aQ/RVW3G+Y66a3boHTDw/Ul1YA5sbdE3FU7I7Zrwb6qy7t
	 LmJ/EYTlJwNLvLMktAvvkGoesUbBjQmyMHXjV/iCi5gcQXM+9tnEYSYLoH80umdVzT
	 gfosEv5oDTtLW/muZ60a7w8ADE57LddH6k+pjlr+PGIfQNlPmpysWwN2h/pT3X8fTr
	 obi9xrj7FmX7A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v14 03/15] tls: add tls_prot_ops pointer to tls_proto
Date: Mon,  6 Apr 2026 20:18:43 +0800
Message-ID: <20bb89c2ac4a4bafa5f9cd54691b53043b22aab6.1775476921.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1775476921.git.tanggeliang@kylinos.cn>
References: <cover.1775476921.git.tanggeliang@kylinos.cn>
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
 net/tls/tls_main.c | 16 ++++++++++++----
 net/tls/tls_strp.c | 33 ++++++++++++++++++++++-----------
 net/tls/tls_sw.c   |  7 +++++--
 4 files changed, 40 insertions(+), 17 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index 3c73e61ce4a3..9d01e151035d 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -243,6 +243,7 @@ struct tls_proto {
 	struct rcu_head			rcu;
 	struct list_head		list;
 	const struct proto		*prot;
+	const struct tls_prot_ops	*ops;
 	struct proto prots[TLS_NUM_CONFIG][TLS_NUM_CONFIG];
 	struct proto_ops proto_ops[TLS_NUM_CONFIG][TLS_NUM_CONFIG];
 };
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 9a555793fd76..637cb6aa8288 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -196,13 +196,13 @@ int tls_push_sg(struct sock *sk,
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
@@ -417,14 +417,14 @@ static __poll_t tls_sk_poll(struct file *file, struct socket *sock,
 	u8 shutdown;
 	int state;
 
-	mask = tcp_poll(file, sock, wait);
+	tls_ctx = tls_get_ctx(sk);
+	mask = tls_ctx->proto->ops->poll(file, sock, wait);
 
 	state = inet_sk_state_load(sk);
 	shutdown = READ_ONCE(sk->sk_shutdown);
 	if (unlikely(state != TCP_ESTABLISHED || shutdown & RCV_SHUTDOWN))
 		return mask;
 
-	tls_ctx = tls_get_ctx(sk);
 	ctx = tls_sw_ctx_rx(tls_ctx);
 	psock = sk_psock_get(sk);
 
@@ -1006,6 +1006,7 @@ static void tls_proto_cleanup(void)
 static struct tls_proto *tls_build_proto(struct sock *sk)
 {
 	struct proto *prot = READ_ONCE(sk->sk_prot);
+	struct tls_prot_ops *ops;
 	struct tls_proto *proto;
 
 	proto = tls_proto_find(prot);
@@ -1020,6 +1021,12 @@ static struct tls_proto *tls_build_proto(struct sock *sk)
 		return proto;
 	}
 
+	ops = tls_prot_ops_find(sk->sk_protocol);
+	if (!ops) {
+		mutex_unlock(&tls_proto_mutex);
+		return NULL;
+	}
+
 	proto = kzalloc(sizeof(*proto), GFP_KERNEL);
 	if (!proto) {
 		mutex_unlock(&tls_proto_mutex);
@@ -1027,6 +1034,7 @@ static struct tls_proto *tls_build_proto(struct sock *sk)
 	}
 
 	proto->prot = prot;
+	proto->ops = ops;
 	build_protos(proto->prots, prot);
 	build_proto_ops(proto->proto_ops,
 			sk->sk_socket->ops);
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
index 20f8fc84c5f5..ca61e0e7ecb9 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1953,13 +1953,14 @@ tls_read_flush_backlog(struct sock *sk, struct tls_prot_info *prot,
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
@@ -2445,6 +2446,7 @@ int tls_rx_msg_size(struct tls_strparser *strp, struct sk_buff *skb)
 	size_t cipher_overhead;
 	size_t data_len = 0;
 	int ret;
+	u32 seq;
 
 	/* Verify that we have a full TLS header, or wait for more data */
 	if (strp->stm.offset + prot->prepend_size > skb->len)
@@ -2487,8 +2489,9 @@ int tls_rx_msg_size(struct tls_strparser *strp, struct sk_buff *skb)
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

