Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA276382390
	for <mptcp@lists.linux.dev>; Fri,  5 Jun 2026 01:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780622647; cv=none; b=WT1Y9sulLmGuls67oOr2kfHhAt+v6ZTDNLACOb3UZ3Dl0/nnnInDpsfWt78qcT9oSHnaRRLZWZuPAIp35DFeIzTn6c5AUqhqb2Aee40KiJWCULPbZENql/Fqu11sEIerYMpIzkztqfj2tcif0mxkxkNhzhKiZdspvJAwjSQi33U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780622647; c=relaxed/simple;
	bh=iTjr1YvwdPAQZ3srY59dYyDwoU+CAaj4OCmkFOo01qU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ETr1o6mYljDBJwyO1fuOXSmlVCat+YfAd/tGa4qsKVJ2gIMkB0PPqaL6FqlyYhXiSNib1j5674KuK3XHfxI5tI59mNA0adaYZf1vrl/fC1RPtHvYOVT/aJMEdmjIKZ0po5XNqfjT5tTM23fs1gQ9GN0pXCgaj8j4Zhk7oJ59va4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=De6tsDHN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="De6tsDHN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C41D1F00893;
	Fri,  5 Jun 2026 01:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780622641;
	bh=mzI5vWVfW2vznxFt+VbCaPVGNkkAniaXSNGqT3iP190=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=De6tsDHNNSeqpoWJnLbU1apppH4p+AqUkuh0GHA8yY1d4NHAhQFsXSgPlPD9/mWJZ
	 yuRDigxPmXo4PsYHaApLDHTY0Lq1exxC/WTsU9k2Oev3vWmib5SoFAWz2io9tZwM77
	 0MXRUq7QeBGnNvqULTdKUSP4Nl1yt0ZHAMEs3GTr3SrBAeh5GDzYba4PvAobwAhcfL
	 XvvlpbhV1WQr3kRbKsehbjlLk5LQ/DxgcYJ1/I42kyLlSnY7iqzfmXfzrh7M+h3Ukx
	 RgyNRhkfVdGo3URxViz9TqmlC8sCsBYJQPxgjA7EzISkayVraId08PlxqMw1vNNhsd
	 3do1UqdRRhNFQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	yangang@kylinos.cn,
	qiang.zhang@linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next v24 05/18] tls: store protocol ops pointer in tls_proto
Date: Fri,  5 Jun 2026 09:22:45 +0800
Message-ID: <9f65c6bf95a29b3d9dca0ddad3023cf76322911a.1780621326.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780621326.git.tanggeliang@kylinos.cn>
References: <cover.1780621326.git.tanggeliang@kylinos.cn>
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
 net/tls/tls_main.c | 35 ++++++++++++++++++++++++---
 net/tls/tls_strp.c | 59 +++++++++++++++++++++++++++++-----------------
 net/tls/tls_sw.c   | 30 +++++++++++++----------
 4 files changed, 88 insertions(+), 37 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index 5a905065a77a..11d567c85950 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -248,6 +248,7 @@ struct tls_prot {
 	struct list_head		list;
 	int				ip_ver;
 	const struct proto		*prot;
+	const struct tls_prot_ops	*ops;
 	struct proto prots[TLS_NUM_CONFIG][TLS_NUM_CONFIG];
 	struct proto_ops proto_ops[TLS_NUM_CONFIG][TLS_NUM_CONFIG];
 };
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 6983820b22d7..f7525109a393 100644
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
@@ -241,13 +242,13 @@ int tls_push_sg(struct sock *sk,
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
@@ -373,6 +374,7 @@ static void tls_prot_put(struct tls_prot *prot)
 		spin_lock_bh(&tls_prot_lock);
 		list_del_rcu(&prot->list);
 		spin_unlock_bh(&tls_prot_lock);
+		module_put(prot->ops->owner);
 		call_rcu(&prot->rcu, tls_prot_free);
 	}
 }
@@ -466,6 +468,24 @@ static void tls_sk_proto_close(struct sock *sk, long timeout)
 		tls_ctx_free(sk, ctx);
 }
 
+static __poll_t tls_prot_poll(struct file *file, struct socket *sock,
+			      struct poll_table_struct *wait)
+{
+	struct tls_context *tls_ctx;
+	struct sock *sk = sock->sk;
+
+	tls_ctx = tls_get_ctx(sk);
+	if (!tls_ctx) {
+		__poll_t mask = 0;
+
+		if (sk->sk_protocol == IPPROTO_TCP)
+			mask = tcp_poll(file, sock, wait);
+		return mask;
+	}
+
+	return tls_ctx->prot->ops->poll(file, sock, wait);
+}
+
 static __poll_t tls_sk_poll(struct file *file, struct socket *sock,
 			    struct poll_table_struct *wait)
 {
@@ -477,7 +497,7 @@ static __poll_t tls_sk_poll(struct file *file, struct socket *sock,
 	u8 shutdown;
 	int state;
 
-	mask = tcp_poll(file, sock, wait);
+	mask = tls_prot_poll(file, sock, wait);
 
 	state = inet_sk_state_load(sk);
 	shutdown = READ_ONCE(sk->sk_shutdown);
@@ -1045,6 +1065,7 @@ static struct tls_prot *tls_build_proto(struct sock *sk)
 	int ip_ver = sk->sk_family == AF_INET6 ? TLSV6 : TLSV4;
 	struct proto *prot = READ_ONCE(sk->sk_prot);
 	struct tls_prot *proto, *cache;
+	struct tls_prot_ops *ops;
 
 	if (!sk->sk_socket)
 		return NULL;
@@ -1065,8 +1086,16 @@ static struct tls_prot *tls_build_proto(struct sock *sk)
 		return cache;
 	}
 
+	ops = tls_prot_ops_find(sk->sk_protocol);
+	if (!ops || !try_module_get(ops->owner)) {
+		spin_unlock_bh(&tls_prot_lock);
+		kfree(proto);
+		return NULL;
+	}
+
 	proto->ip_ver = ip_ver;
 	proto->prot = prot;
+	proto->ops = ops;
 	refcount_set(&proto->refcnt, 1);
 	build_protos(proto->prots, prot);
 	build_proto_ops(proto->proto_ops,
diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index c72e88317627..4622c7c062cc 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -42,6 +42,8 @@ static struct sk_buff *
 tls_strp_skb_copy(struct tls_strparser *strp, struct sk_buff *in_skb,
 		  int offset, int len)
 {
+	struct tls_context *ctx = tls_get_ctx(strp->sk);
+	const struct tls_prot_ops *ops = ctx->prot->ops;
 	struct sk_buff *skb;
 	int i, err;
 
@@ -53,9 +55,9 @@ tls_strp_skb_copy(struct tls_strparser *strp, struct sk_buff *in_skb,
 	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
 
-		WARN_ON_ONCE(skb_copy_bits(in_skb, offset,
-					   skb_frag_address(frag),
-					   skb_frag_size(frag)));
+		WARN_ON_ONCE(ops->skb_copy_bits(in_skb, offset,
+						skb_frag_address(frag),
+						skb_frag_size(frag)));
 		offset += skb_frag_size(frag);
 	}
 
@@ -120,6 +122,7 @@ struct sk_buff *tls_strp_msg_detach(struct tls_sw_context_rx *ctx)
 int tls_strp_msg_cow(struct tls_sw_context_rx *ctx)
 {
 	struct tls_strparser *strp = &ctx->strp;
+	struct tls_context *tls_ctx = tls_get_ctx(strp->sk);
 	struct sk_buff *skb;
 
 	if (strp->copy_mode)
@@ -132,7 +135,7 @@ int tls_strp_msg_cow(struct tls_sw_context_rx *ctx)
 	tls_strp_anchor_free(strp);
 	strp->anchor = skb;
 
-	tcp_read_done(strp->sk, strp->stm.full_len);
+	tls_ctx->prot->ops->read_done(strp->sk, strp->stm.full_len);
 	strp->copy_mode = 1;
 
 	return 0;
@@ -211,6 +214,8 @@ static int tls_strp_copyin_frag(struct tls_strparser *strp, struct sk_buff *skb,
 				struct sk_buff *in_skb, unsigned int offset,
 				size_t in_len)
 {
+	struct tls_context *ctx = tls_get_ctx(strp->sk);
+	const struct tls_prot_ops *ops = ctx->prot->ops;
 	unsigned int nfrag = skb->len / PAGE_SIZE;
 	size_t len, chunk;
 	skb_frag_t *frag;
@@ -228,10 +233,10 @@ static int tls_strp_copyin_frag(struct tls_strparser *strp, struct sk_buff *skb,
 	if (!strp->stm.full_len) {
 		/* Assume one page is more than enough for headers */
 		chunk =	min_t(size_t, len, PAGE_SIZE - skb_frag_size(frag));
-		WARN_ON_ONCE(skb_copy_bits(in_skb, offset,
-					   skb_frag_address(frag) +
-					   skb_frag_size(frag),
-					   chunk));
+		WARN_ON_ONCE(ops->skb_copy_bits(in_skb, offset,
+						skb_frag_address(frag) +
+						skb_frag_size(frag),
+						chunk));
 
 		skb->len += chunk;
 		skb->data_len += chunk;
@@ -266,10 +271,10 @@ static int tls_strp_copyin_frag(struct tls_strparser *strp, struct sk_buff *skb,
 	while (len && strp->stm.full_len > skb->len) {
 		chunk =	min_t(size_t, len, strp->stm.full_len - skb->len);
 		chunk = min_t(size_t, chunk, PAGE_SIZE - skb_frag_size(frag));
-		WARN_ON_ONCE(skb_copy_bits(in_skb, offset,
-					   skb_frag_address(frag) +
-					   skb_frag_size(frag),
-					   chunk));
+		WARN_ON_ONCE(ops->skb_copy_bits(in_skb, offset,
+						skb_frag_address(frag) +
+						skb_frag_size(frag),
+						chunk));
 
 		skb->len += chunk;
 		skb->data_len += chunk;
@@ -376,6 +381,7 @@ static int tls_strp_copyin(read_descriptor_t *desc, struct sk_buff *in_skb,
 
 static int tls_strp_read_copyin(struct tls_strparser *strp)
 {
+	struct tls_context *ctx = tls_get_ctx(strp->sk);
 	read_descriptor_t desc;
 
 	desc.arg.data = strp;
@@ -383,13 +389,14 @@ static int tls_strp_read_copyin(struct tls_strparser *strp)
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
@@ -398,7 +405,7 @@ static int tls_strp_read_copy(struct tls_strparser *strp, bool qshort)
 	 * to read the data out. Otherwise the connection will stall.
 	 * Without pressure threshold of INT_MAX will never be ready.
 	 */
-	if (likely(qshort && !tcp_epollin_ready(strp->sk, INT_MAX)))
+	if (likely(qshort && !ctx->prot->ops->epollin_ready(strp->sk)))
 		return 0;
 
 	shinfo = skb_shinfo(strp->anchor);
@@ -434,12 +441,13 @@ static int tls_strp_read_copy(struct tls_strparser *strp, bool qshort)
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
@@ -449,7 +457,7 @@ static bool tls_strp_check_queue_ok(struct tls_strparser *strp)
 		len -= skb->len;
 		skb = skb->next;
 
-		if (TCP_SKB_CB(skb)->seq != seq)
+		if (ctx->prot->ops->get_skb_seq(skb) != seq)
 			return false;
 		if (skb_cmp_decrypted(first, skb))
 			return false;
@@ -460,11 +468,11 @@ static bool tls_strp_check_queue_ok(struct tls_strparser *strp)
 
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
 
@@ -483,6 +491,7 @@ static void tls_strp_load_anchor_with_queue(struct tls_strparser *strp, int len)
 
 bool tls_strp_msg_load(struct tls_strparser *strp, bool force_refresh)
 {
+	struct tls_context *ctx = tls_get_ctx(strp->sk);
 	struct strp_msg *rxm;
 	struct tls_msg *tlm;
 
@@ -490,7 +499,8 @@ bool tls_strp_msg_load(struct tls_strparser *strp, bool force_refresh)
 	DEBUG_NET_WARN_ON_ONCE(!strp->stm.full_len);
 
 	if (!strp->copy_mode && force_refresh) {
-		if (unlikely(tcp_inq(strp->sk) < strp->stm.full_len)) {
+		if (unlikely(ctx->prot->ops->inq(strp->sk) <
+			     strp->stm.full_len)) {
 			WRITE_ONCE(strp->msg_ready, 0);
 			memset(&strp->stm, 0, sizeof(strp->stm));
 			return false;
@@ -511,9 +521,10 @@ bool tls_strp_msg_load(struct tls_strparser *strp, bool force_refresh)
 /* Called with lock held on lower socket */
 static int tls_strp_read_sock(struct tls_strparser *strp)
 {
+	struct tls_context *ctx = tls_get_ctx(strp->sk);
 	int sz, inq;
 
-	inq = tcp_inq(strp->sk);
+	inq = ctx->prot->ops->inq(strp->sk);
 	if (inq < 1)
 		return 0;
 
@@ -556,6 +567,8 @@ void tls_strp_check_rcv(struct tls_strparser *strp)
 /* Lower sock lock held */
 void tls_strp_data_ready(struct tls_strparser *strp)
 {
+	struct tls_context *ctx = tls_get_ctx(strp->sk);
+
 	/* This check is needed to synchronize with do_tls_strp_work.
 	 * do_tls_strp_work acquires a process lock (lock_sock) whereas
 	 * the lock held here is bh_lock_sock. The two locks can be
@@ -563,7 +576,7 @@ void tls_strp_data_ready(struct tls_strparser *strp)
 	 * allows a thread in BH context to safely check if the process
 	 * lock is held. In this case, if the lock is held, queue work.
 	 */
-	if (sock_owned_by_user_nocheck(strp->sk)) {
+	if (ctx->prot->ops->lock_is_held(strp->sk)) {
 		queue_work(tls_strp_wq, &strp->work);
 		return;
 	}
@@ -583,10 +596,12 @@ static void tls_strp_work(struct work_struct *w)
 
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
index 964ebc268ee4..01d831bafd6b 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -154,9 +154,11 @@ static int skb_nsg(struct sk_buff *skb, int offset, int len)
         return __skb_nsg(skb, offset, len, 0);
 }
 
-static int tls_padding_length(struct tls_prot_info *prot, struct sk_buff *skb,
+static int tls_padding_length(struct tls_context *tls_ctx, struct sk_buff *skb,
 			      struct tls_decrypt_arg *darg)
 {
+	const struct tls_prot_ops *ops = tls_ctx->prot->ops;
+	struct tls_prot_info *prot = &tls_ctx->prot_info;
 	struct strp_msg *rxm = strp_msg(skb);
 	struct tls_msg *tlm = tls_msg(skb);
 	int sub = 0;
@@ -170,8 +172,8 @@ static int tls_padding_length(struct tls_prot_info *prot, struct sk_buff *skb,
 		while (content_type == 0) {
 			if (offset < prot->prepend_size)
 				return -EBADMSG;
-			err = skb_copy_bits(skb, rxm->offset + offset,
-					    &content_type, 1);
+			err = ops->skb_copy_bits(skb, rxm->offset + offset,
+						 &content_type, 1);
 			if (err)
 				return err;
 			if (content_type)
@@ -1539,6 +1541,7 @@ static int tls_decrypt_sg(struct sock *sk, struct iov_iter *out_iov,
 {
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
+	const struct tls_prot_ops *ops = tls_ctx->prot->ops;
 	struct tls_prot_info *prot = &tls_ctx->prot_info;
 	int n_sgin, n_sgout, aead_size, err, pages = 0;
 	struct sk_buff *skb = tls_strp_msg(ctx);
@@ -1618,9 +1621,9 @@ static int tls_decrypt_sg(struct sock *sk, struct iov_iter *out_iov,
 		memcpy(&dctx->iv[iv_offset], tls_ctx->rx.iv,
 		       prot->iv_size + prot->salt_size);
 	} else {
-		err = skb_copy_bits(skb, rxm->offset + TLS_HEADER_SIZE,
-				    &dctx->iv[iv_offset] + prot->salt_size,
-				    prot->iv_size);
+		err = ops->skb_copy_bits(skb, rxm->offset + TLS_HEADER_SIZE,
+					 &dctx->iv[iv_offset] + prot->salt_size,
+					 prot->iv_size);
 		if (err < 0)
 			goto exit_free;
 		memcpy(&dctx->iv[iv_offset], tls_ctx->rx.iv, prot->salt_size);
@@ -1734,7 +1737,7 @@ tls_decrypt_sw(struct sock *sk, struct tls_context *tls_ctx,
 		return tls_decrypt_sw(sk, tls_ctx, msg, darg);
 	}
 
-	pad = tls_padding_length(prot, darg->skb, darg);
+	pad = tls_padding_length(tls_ctx, darg->skb, darg);
 	if (pad < 0) {
 		if (darg->skb != tls_strp_msg(ctx))
 			consume_skb(darg->skb);
@@ -1763,7 +1766,7 @@ tls_decrypt_device(struct sock *sk, struct msghdr *msg,
 	if (err <= 0)
 		return err;
 
-	pad = tls_padding_length(prot, tls_strp_msg(ctx), darg);
+	pad = tls_padding_length(tls_ctx, tls_strp_msg(ctx), darg);
 	if (pad < 0)
 		return pad;
 
@@ -1811,7 +1814,7 @@ static int tls_check_pending_rekey(struct sock *sk, struct tls_context *ctx,
 	if (rxm->full_len < 1)
 		return 0;
 
-	err = skb_copy_bits(skb, rxm->offset, &hs_type, 1);
+	err = ctx->prot->ops->skb_copy_bits(skb, rxm->offset, &hs_type, 1);
 	if (err < 0) {
 		DEBUG_NET_WARN_ON_ONCE(1);
 		return err;
@@ -1987,7 +1990,8 @@ tls_read_flush_backlog(struct sock *sk, struct tls_prot_info *prot,
 		return false;
 
 	max_rec = prot->overhead_size - prot->tail_size + TLS_MAX_PAYLOAD_SIZE;
-	if (done - *flushed_at < SZ_128K && tcp_inq(sk) > max_rec)
+	if (done - *flushed_at < SZ_128K &&
+	    tls_get_ctx(sk)->prot->ops->inq(sk) > max_rec)
 		return false;
 
 	*flushed_at = done;
@@ -2485,7 +2489,8 @@ int tls_rx_msg_size(struct tls_strparser *strp, struct sk_buff *skb)
 	}
 
 	/* Linearize header to local buffer */
-	ret = skb_copy_bits(skb, strp->stm.offset, header, prot->prepend_size);
+	ret = tls_ctx->prot->ops->skb_copy_bits(skb, strp->stm.offset, header,
+						prot->prepend_size);
 	if (ret < 0)
 		goto read_failure;
 
@@ -2516,7 +2521,8 @@ int tls_rx_msg_size(struct tls_strparser *strp, struct sk_buff *skb)
 	}
 
 	tls_device_rx_resync_new_rec(strp->sk, data_len + TLS_HEADER_SIZE,
-				     TCP_SKB_CB(skb)->seq + strp->stm.offset);
+				     tls_ctx->prot->ops->get_skb_seq(skb) +
+				     strp->stm.offset);
 	return data_len + TLS_HEADER_SIZE;
 
 read_failure:
-- 
2.53.0

