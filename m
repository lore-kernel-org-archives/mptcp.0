Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C31A264A97
	for <mptcp@lists.linux.dev>; Tue,  9 Jun 2026 02:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780971582; cv=none; b=R8T2MZbdaT3RFdlFjcM994KFpHX7UYhtFHqe73GJKwRuj6HL0UWN+Pztpkz4VSWwa7ooxOF+XrwzCr0Vw0P46DYcxsoSD2BKlt0ojH9AtgwxaPRbtaY5BNDQS0r4yZYcg5Zb3I+1jw4a/vCLPgVFiLQVeL8XrfFUgOPp47/xoHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780971582; c=relaxed/simple;
	bh=pqRq/1RrAXPBJjMUV6qBozcpqo1D/bbXHw115OkoJwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uUInEEqWnNacBJ7GWq4V/Dke18FfjDYfa3fE4H2gf3K6qvflKqojA9mKsE/W9lZt1vn5jDwTvJ6s4Ypm89RDCPBn1av3SM8nUmdax8OCVcpD6hPeUhm/PRlwdBsShkPwYOBbUPdRO3BI5NFJnPIOpZ6OGdqouIaxYXwbkjYszmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AimX/RJU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AimX/RJU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896A81F00898;
	Tue,  9 Jun 2026 02:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780971581;
	bh=NrL6nbS6CSD7R9XRHoCXnzi8cv0IF/yWwr3xYUK+z4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AimX/RJUgySpNF3f0ZizS2tX6DaiCCbWz5PC8nLJp5gi+4cgGH2j33upsk/xnuDm3
	 LB/c0dYqM+eT9cgSw67kC/Y7c6cbgOAt0rY6l/pqDmTXQ4e3zDzlerHwWSMrXN/hH0
	 f+YqFqnKd4bTt6vW59/Z5qFuY+MlIMdJnMU9HM9VCL8P4p+azpBGEXcrUfVgHJq8Sm
	 LOBaPpxS2Hul8Fj/gKhzt+h0kZgRYYUPloI8WjVxSxANIr5cTOqVOH4IxSnpkq8aoR
	 phfjsGW8H12p6tsCXxlJtRr/7kzglUu5/2GA5Zvy4Pq5H8XEoVv0F8jNShUXU1z8cD
	 MZwMPyKaT5krQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v25 09/22] tls: store protocol ops pointer in tls_proto
Date: Tue,  9 Jun 2026 10:18:35 +0800
Message-ID: <9f9de39e4de11d60ce71a52ee0e07b809f35e79d.1780970284.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780970284.git.tanggeliang@kylinos.cn>
References: <cover.1780970284.git.tanggeliang@kylinos.cn>
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
 net/tls/tls_main.c | 13 ++++++++++++-
 net/tls/tls_strp.c | 26 ++++++++++++++++++--------
 net/tls/tls_sw.c   |  5 +++--
 4 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index 2cf5153465af..443d596f694f 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -241,6 +241,7 @@ struct tls_prot {
 	struct list_head		list;
 	int				ip_ver;
 	const struct proto		*prot;
+	const struct tls_prot_ops	*ops;
 	struct proto prots[TLS_NUM_CONFIG][TLS_NUM_CONFIG];
 	struct proto_ops proto_ops[TLS_NUM_CONFIG][TLS_NUM_CONFIG];
 };
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 6f6fc2b08d3d..fa7727881e74 100644
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
@@ -241,7 +242,7 @@ int tls_push_sg(struct sock *sk,
 	ctx->splicing_pages = true;
 	while (1) {
 		/* is sending application-limited? */
-		tcp_rate_check_app_limited(sk);
+		ctx->prot->ops->check_app_limited(sk);
 		p = sg_page(sg);
 retry:
 		bvec_set_page(&bvec, p, size, offset);
@@ -373,6 +374,7 @@ static void tls_prot_put(struct tls_prot *prot)
 		spin_lock_bh(&tls_prot_lock);
 		list_del_rcu(&prot->list);
 		spin_unlock_bh(&tls_prot_lock);
+		module_put(prot->ops->owner);
 		call_rcu(&prot->rcu, tls_prot_free);
 	}
 }
@@ -1045,6 +1047,7 @@ static struct tls_prot *tls_build_proto(struct sock *sk)
 	int ip_ver = sk->sk_family == AF_INET6 ? TLSV6 : TLSV4;
 	struct proto *prot = READ_ONCE(sk->sk_prot);
 	struct tls_prot *proto, *cache;
+	struct tls_prot_ops *ops;
 
 	if (!sk->sk_socket)
 		return NULL;
@@ -1065,8 +1068,16 @@ static struct tls_prot *tls_build_proto(struct sock *sk)
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
index 36ab5d221eed..2dca7637a0ca 100644
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
@@ -391,6 +392,7 @@ static int tls_strp_read_copyin(struct tls_strparser *strp)
 
 static int tls_strp_read_copy(struct tls_strparser *strp, bool qshort)
 {
+	struct tls_context *ctx = tls_get_ctx(strp->sk);
 	struct skb_shared_info *shinfo;
 	struct page *page;
 	int need_spc, len;
@@ -399,7 +401,7 @@ static int tls_strp_read_copy(struct tls_strparser *strp, bool qshort)
 	 * to read the data out. Otherwise the connection will stall.
 	 * Without pressure threshold of INT_MAX will never be ready.
 	 */
-	if (likely(qshort && !tcp_epollin_ready(strp->sk, INT_MAX)))
+	if (likely(qshort && !ctx->prot->ops->epollin_ready(strp->sk)))
 		return 0;
 
 	shinfo = skb_shinfo(strp->anchor);
@@ -435,12 +437,13 @@ static int tls_strp_read_copy(struct tls_strparser *strp, bool qshort)
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
@@ -450,7 +453,7 @@ static bool tls_strp_check_queue_ok(struct tls_strparser *strp)
 		len -= skb->len;
 		skb = skb->next;
 
-		if (TCP_SKB_CB(skb)->seq != seq)
+		if (ctx->prot->ops->get_skb_seq(skb) != seq)
 			return false;
 		if (skb_cmp_decrypted(first, skb))
 			return false;
@@ -461,11 +464,11 @@ static bool tls_strp_check_queue_ok(struct tls_strparser *strp)
 
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
 
@@ -559,6 +562,11 @@ void tls_strp_check_rcv(struct tls_strparser *strp)
 /* Lower sock lock held */
 void tls_strp_data_ready(struct tls_strparser *strp)
 {
+	struct tls_context *ctx = tls_get_ctx(strp->sk);
+
+	if (!ctx)
+		return;
+
 	/* This check is needed to synchronize with do_tls_strp_work.
 	 * do_tls_strp_work acquires a process lock (lock_sock) whereas
 	 * the lock held here is bh_lock_sock. The two locks can be
@@ -566,7 +574,7 @@ void tls_strp_data_ready(struct tls_strparser *strp)
 	 * allows a thread in BH context to safely check if the process
 	 * lock is held. In this case, if the lock is held, queue work.
 	 */
-	if (sock_owned_by_user_nocheck(strp->sk)) {
+	if (ctx->prot->ops->lock_is_held(strp->sk)) {
 		queue_work(tls_strp_wq, &strp->work);
 		return;
 	}
@@ -586,10 +594,12 @@ static void tls_strp_work(struct work_struct *w)
 
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
index d833ee14d62e..4d0308d4e005 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2470,6 +2470,7 @@ bool tls_sw_sock_is_readable(struct sock *sk)
 int tls_rx_msg_size(struct tls_strparser *strp, struct sk_buff *skb)
 {
 	struct tls_context *tls_ctx = tls_get_ctx(strp->sk);
+	const struct tls_prot_ops *ops = tls_ctx->prot->ops;
 	struct tls_prot_info *prot = &tls_ctx->prot_info;
 	char header[TLS_HEADER_SIZE + TLS_MAX_IV_SIZE];
 	size_t cipher_overhead;
@@ -2487,7 +2488,7 @@ int tls_rx_msg_size(struct tls_strparser *strp, struct sk_buff *skb)
 	}
 
 	/* Linearize header to local buffer */
-	ret = skb_copy_bits(skb, strp->stm.offset, header, prot->prepend_size);
+	ret = ops->skb_get_header(skb, strp->stm.offset, header, prot->prepend_size);
 	if (ret < 0)
 		goto read_failure;
 
@@ -2518,7 +2519,7 @@ int tls_rx_msg_size(struct tls_strparser *strp, struct sk_buff *skb)
 	}
 
 	tls_device_rx_resync_new_rec(strp->sk, data_len + TLS_HEADER_SIZE,
-				     TCP_SKB_CB(skb)->seq + strp->stm.offset);
+				     ops->get_skb_seq(skb) + strp->stm.offset);
 	return data_len + TLS_HEADER_SIZE;
 
 read_failure:
-- 
2.43.0

