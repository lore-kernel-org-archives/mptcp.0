Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BC63ADBA3
	for <mptcp@lists.linux.dev>; Thu, 28 May 2026 09:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779960454; cv=none; b=PSRmBI2M44+zUDLWeUSh5ZUwT0YaGtCm5V9uLbttNNyRmiFd5BfwgMyfT9qR8AzPA2gWLMbEqvXn6I8GsIlF+5GDBm6I5hskQZd1/4KiOhFJatnLbfX33ti5s6+LWnjkSi4f8OnqVyUqT2DgiD0WaHoiEwQ2rfM+TiJywbs4Sxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779960454; c=relaxed/simple;
	bh=3r4/HrLSOKgFkCKe+mpLvoM7nQMlqUyUwBZ0Ryrbs4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XelO5389z4lsA5qBomwt7tYeLHB3ThyZaRaS2w66ib7zuOn0yAWar9C8NVN5vLl7AQOY+mhHl3Q+FQgQ5CimVOPWlxPtC7m+ksXZKX6+guqI58kQC09mZjQZjbBUMDm1164yxqESDK+J/utPRyQsnQBWGRuu5chz7jUA0PvqSPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qr4uakQC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qr4uakQC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818C31F000E9;
	Thu, 28 May 2026 09:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779960450;
	bh=UzmcisxeoFQDNkWmGR3ysbJf0q0FkP93GgxceaTkAqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qr4uakQCmu3Bvv3HRM0c2wSh3a0LgvsgNOA8RHRVIBUvVYrBntT5lKe0YikDximcx
	 fgN2IsIoBF8HhlQ2H8FbABRPHNsvOQupGhPlClyRr+RUsZhZL99RaExTl1rdWw6i+Z
	 CXLuAUkPEJCtTh9DVVztYm3Pmb2aiTmCkQDWTDjokBBxtMA/OGLLEl9+9KsM9ym4UL
	 LHrq1vjdapYZw5USqYxi2/EwAPE3k3DaDk3maythxMvPIWKLMMNn/luv8U0SiLP5i9
	 /pl8IRpdEXwPIWq/2xYmJQ0IoMz9wtliawwQvcCM6Nxw4zScE8nS29+vYyajwdf2yi
	 +ueC6LXXGFuVw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v21 04/18] tls: store protocol ops pointer in tls_proto
Date: Thu, 28 May 2026 17:26:55 +0800
Message-ID: <f597a173841fd2f1e6785be5ca0731e9f36dbafb.1779959644.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779959644.git.tanggeliang@kylinos.cn>
References: <cover.1779959644.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

A pointer to struct tls_prot_ops, named 'ops', has been added to struct
tls_prot. The places originally calling TLS-specific helpers have now
been modified to indirectly invoke them via 'ops' pointer in tls_prot.

In tls_build_proto(), prot->ops is assigned either 'tls_mptcp_ops' or
'tls_tcp_ops' based on the socket protocol.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/tls.h  |  1 +
 net/tls/tls_main.c | 15 +++++++++++++--
 net/tls/tls_strp.c | 33 ++++++++++++++++++++++-----------
 net/tls/tls_sw.c   |  6 ++++--
 4 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index 83c9ce6c36f8..de7a80eaadfe 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -246,6 +246,7 @@ struct tls_prot {
 	struct list_head		list;
 	int				ip_ver;
 	const struct proto		*prot;
+	const struct tls_prot_ops	*ops;
 	struct proto prots[TLS_NUM_CONFIG][TLS_NUM_CONFIG];
 	struct proto_ops proto_ops[TLS_NUM_CONFIG][TLS_NUM_CONFIG];
 };
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 9669a3acff00..dab69488214b 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -156,6 +156,7 @@ static void tls_prot_cleanup(void)
 	spin_lock_bh(&tls_prot_lock);
 	list_for_each_entry_safe(prot, tmp, &tls_prot_list, list) {
 		list_del_rcu(&prot->list);
+		module_put(prot->ops->owner);
 		call_rcu(&prot->rcu, tls_prot_free);
 	}
 	spin_unlock_bh(&tls_prot_lock);
@@ -244,13 +245,13 @@ int tls_push_sg(struct sock *sk,
 	ctx->splicing_pages = true;
 	while (1) {
 		/* is sending application-limited? */
-		tcp_rate_check_app_limited(sk);
+		ctx->prot->ops->check_app_limited(sk);
 		p = sg_page(sg);
 retry:
 		bvec_set_page(&bvec, p, size, offset);
 		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
 
-		ret = tcp_sendmsg_locked(sk, &msg, size);
+		ret = ctx->prot->ops->sendmsg_locked(sk, &msg, size);
 
 		if (ret != size) {
 			if (ret > 0) {
@@ -376,6 +377,7 @@ static void tls_prot_put(struct tls_prot *prot)
 		spin_lock_bh(&tls_prot_lock);
 		list_del_rcu(&prot->list);
 		spin_unlock_bh(&tls_prot_lock);
+		module_put(prot->ops->owner);
 		call_rcu(&prot->rcu, tls_prot_free);
 	}
 }
@@ -1045,6 +1047,7 @@ static struct tls_prot *tls_build_proto(struct sock *sk)
 	int ip_ver = sk->sk_family == AF_INET6 ? TLSV6 : TLSV4;
 	struct proto *proto = READ_ONCE(sk->sk_prot);
 	struct tls_prot *prot, *cache;
+	struct tls_prot_ops *ops;
 
 	prot = kzalloc_obj(*prot, GFP_KERNEL);
 	if (!prot)
@@ -1058,8 +1061,16 @@ static struct tls_prot *tls_build_proto(struct sock *sk)
 		return cache;
 	}
 
+	ops = tls_prot_ops_find(sk->sk_protocol);
+	if (!ops || !try_module_get(ops->owner)) {
+		spin_unlock_bh(&tls_prot_lock);
+		kfree(prot);
+		return NULL;
+	}
+
 	prot->ip_ver = ip_ver;
 	prot->prot = proto;
+	prot->ops = ops;
 	refcount_set(&prot->refcnt, 1);
 	build_protos(prot->prots, proto);
 	build_proto_ops(prot->proto_ops,
diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index c72e88317627..c88cb966649b 100644
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
+	tls_ctx->prot->ops->read_done(strp->sk, strp->stm.full_len);
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
+	ctx->prot->ops->read_sock(strp->sk, &desc, tls_strp_copyin);
 
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
+	if (likely(qshort && !ctx->prot->ops->epollin_ready(strp->sk)))
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
+	seq = ctx->prot->ops->get_skb_seq(first);
 
 	/* Make sure there's no duplicate data in the queue,
 	 * and the decrypted status matches.
@@ -449,7 +453,7 @@ static bool tls_strp_check_queue_ok(struct tls_strparser *strp)
 		len -= skb->len;
 		skb = skb->next;
 
-		if (TCP_SKB_CB(skb)->seq != seq)
+		if (ctx->prot->ops->get_skb_seq(skb) != seq)
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
+	first = ctx->prot->ops->recv_skb(strp->sk, &offset);
 	if (WARN_ON_ONCE(!first))
 		return;
 
@@ -483,6 +487,7 @@ static void tls_strp_load_anchor_with_queue(struct tls_strparser *strp, int len)
 
 bool tls_strp_msg_load(struct tls_strparser *strp, bool force_refresh)
 {
+	struct tls_context *ctx = tls_get_ctx(strp->sk);
 	struct strp_msg *rxm;
 	struct tls_msg *tlm;
 
@@ -490,7 +495,8 @@ bool tls_strp_msg_load(struct tls_strparser *strp, bool force_refresh)
 	DEBUG_NET_WARN_ON_ONCE(!strp->stm.full_len);
 
 	if (!strp->copy_mode && force_refresh) {
-		if (unlikely(tcp_inq(strp->sk) < strp->stm.full_len)) {
+		if (unlikely(ctx->prot->ops->inq(strp->sk) <
+			     strp->stm.full_len)) {
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
+	inq = ctx->prot->ops->inq(strp->sk);
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
+	if (ctx->prot->ops->lock_is_held(strp->sk)) {
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
+		ctx->prot->ops->read_done(strp->sk, strp->stm.full_len);
 	else
 		tls_strp_flush_anchor_copy(strp);
 
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 964ebc268ee4..4cac7a90851a 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1987,7 +1987,8 @@ tls_read_flush_backlog(struct sock *sk, struct tls_prot_info *prot,
 		return false;
 
 	max_rec = prot->overhead_size - prot->tail_size + TLS_MAX_PAYLOAD_SIZE;
-	if (done - *flushed_at < SZ_128K && tcp_inq(sk) > max_rec)
+	if (done - *flushed_at < SZ_128K &&
+	    tls_get_ctx(sk)->prot->ops->inq(sk) > max_rec)
 		return false;
 
 	*flushed_at = done;
@@ -2516,7 +2517,8 @@ int tls_rx_msg_size(struct tls_strparser *strp, struct sk_buff *skb)
 	}
 
 	tls_device_rx_resync_new_rec(strp->sk, data_len + TLS_HEADER_SIZE,
-				     TCP_SKB_CB(skb)->seq + strp->stm.offset);
+				     tls_ctx->prot->ops->get_skb_seq(skb) +
+				     strp->stm.offset);
 	return data_len + TLS_HEADER_SIZE;
 
 read_failure:
-- 
2.53.0

