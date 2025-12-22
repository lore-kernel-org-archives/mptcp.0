Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEED02F851
	for <mptcp@lists.linux.dev>; Mon, 22 Dec 2025 03:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766373336; cv=none; b=ok7swazXLkKnDoMK3QAU/qakF73lsGjOdNgXKM8U7MFMG5ttixHvfXIAewb+dv6FZTZCP1Rb1ZPoitFgSnj2PxZwYJE8GCO4G86ax/CHM14Xoj7VnS2AF0dYj1Q0g5uGgbAM5trZ6oleqm5qP46C8+vQ8py5uxo3lquu/tZLSzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766373336; c=relaxed/simple;
	bh=Z/NE3DPlGydWCx4M6NaQpjVoEukmmM9d2f/UcwH5EIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjjztF4Wm0E6F5bNvCaT7g6n8ZbhLk4WSwr9Cqm3nMgLBF8jH12URtEikB9YeyJXhuMAYBzsBWIYv8cbYjHpA7mOEk1d2o1/tpnKdAcAdtdGxsMx040YoBWLcpM9xtSl5TswZTx7UCKyHaXbzy/+9EdEmbEiz8omuV846/l5E5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duJfigDa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duJfigDa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27DCCC16AAE;
	Mon, 22 Dec 2025 03:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766373336;
	bh=Z/NE3DPlGydWCx4M6NaQpjVoEukmmM9d2f/UcwH5EIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=duJfigDaBcdQsX8as77HKDy3CA/WWoxvdRYwBnJcjPgHZmXf+08/E+9nV4N5YKvwc
	 bXP/HSVY31jw0qhMLo+FCA0dz1w3gUbqcBPmZWSnv9dy8yZvLvrH09io7ystpvp7DM
	 /KzokmMEmv3XVPL+d0IVum3Py82i+O5JaxKgmEf+17hVqdMCT0VNp5FTrBjAavsI3R
	 whPCmV0K1q+jzNxTkCPqQky8Y7dyMaL7r2dAsFw6VQcvVoE1fghKXfotOcfhXuLn+2
	 un9kAkz7mNp4wO3uQItGjHXhyJ9DxVUi1U3fQ9ShcD9MPRSCLSAE/KipafLFJukTbt
	 qQL1aIFmCBivQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v5 1/8] tls: introduce struct tls_prot_ops
Date: Mon, 22 Dec 2025 11:15:20 +0800
Message-ID: <292fd0d8ad99a937e82440e4de45719388d959e8.1766372799.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1766372799.git.tanggeliang@kylinos.cn>
References: <cover.1766372799.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

To extend MPTCP support based on TCP TLS, a tls_prot_ops structure
has been introduced for TLS, encapsulating both TCP-specific and
MPTCP-specific helpers within this structure. A pointer to this
structure, named 'ops', has been added to the tls_context. The places
originally calling TLS-specific helpers have now been modified to
indirectly invoke them via 'ops' pointer in the tls_context.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/tcp.h    |  5 +++++
 include/net/tls.h    | 42 ++++++++++++++++++++++++++++++++++++++++++
 net/tls/tls_device.c |  4 ++--
 net/tls/tls_main.c   | 12 +++++++++---
 net/tls/tls_strp.c   | 28 +++++++++++++++++++---------
 net/tls/tls_sw.c     |  5 +++--
 6 files changed, 80 insertions(+), 16 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index f5f6119f7716..a0a2d4d63b15 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2953,4 +2953,9 @@ enum skb_drop_reason tcp_inbound_hash(struct sock *sk,
 		const void *saddr, const void *daddr,
 		int family, int dif, int sdif);
 
+static inline u32 tcp_get_seq(struct sk_buff *skb)
+{
+	return TCP_SKB_CB(skb)->seq;
+}
+
 #endif	/* _TCP_H */
diff --git a/include/net/tls.h b/include/net/tls.h
index ebd2550280ae..985ac326d59c 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -220,6 +220,47 @@ struct tls_prot_info {
 	u16 tail_size;
 };
 
+#define TLS_PROT_OPS_NAME_MAX	16
+
+struct tls_prot_ops {
+	char			name[TLS_PROT_OPS_NAME_MAX];
+
+	int (*inq)(struct sock *sk);
+	int (*sendmsg_locked)(struct sock *sk, struct msghdr *msg, size_t size);
+	struct sk_buff *(*recv_skb)(struct sock *sk, u32 seq, u32 *off);
+	void (*read_done)(struct sock *sk, size_t len);
+	u32 (*get_seq)(struct sk_buff *skb);
+	int (*read_sock)(struct sock *sk, read_descriptor_t *desc,
+			 sk_read_actor_t recv_actor);
+	__poll_t (*poll)(struct file *file, struct socket *sock,
+			 struct poll_table_struct *wait);
+	bool (*epollin_ready)(const struct sock *sk, int target);
+};
+
+static inline bool tls_validate_prot_ops(const struct tls_prot_ops *ops)
+{
+	if (ops->inq || ops->sendmsg_locked ||
+	    ops->recv_skb || ops->read_done ||
+	    ops->get_seq || ops->read_sock ||
+	    ops->poll || ops->epollin_ready)
+		return true;
+
+	pr_err("%s does not implement required ops\n", ops->name);
+	return false;
+}
+
+static const struct tls_prot_ops tls_tcp_ops = {
+	.name		= "tcp",
+	.inq		= tcp_inq,
+	.sendmsg_locked	= tcp_sendmsg_locked,
+	.recv_skb	= tcp_recv_skb,
+	.read_done	= tcp_read_done,
+	.get_seq	= tcp_get_seq,
+	.read_sock	= tcp_read_sock,
+	.poll		= tcp_poll,
+	.epollin_ready	= tcp_epollin_ready,
+};
+
 struct tls_context {
 	/* read-only cache line */
 	struct tls_prot_info prot_info;
@@ -258,6 +299,7 @@ struct tls_context {
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
index 56ce0bc8317b..20f7eb438771 100644
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
 
@@ -760,6 +760,12 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
 		ctx->rx_conf = conf;
 	update_sk_prot(sk, ctx);
 
+	if (sk_is_tcp(sk))
+		ctx->ops = &tls_tcp_ops;
+
+	if (!tls_validate_prot_ops(ctx->ops))
+		return -EINVAL;
+
 	if (update)
 		return 0;
 
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

