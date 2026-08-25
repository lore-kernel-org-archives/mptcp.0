Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92293016FB
	for <mptcp@lists.linux.dev>; Tue, 25 Aug 2026 07:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787644681; cv=none; b=ufriW5Vxk15ctsv0DO0mOOeaIQ4qMQB1OGFtSyU49ibRNaPR2I0IWyTS6rcx+42Qcs3qd1ovgRMf75flQFvDwVNHTUpiowCczv3L6l2QD5mvfJ+Wu02A0P5NS6EtICczptcDMHvAdDGglzAWlJpkR+PBDNFMi1bFSFSAVppqFkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787644681; c=relaxed/simple;
	bh=hc8M+nH0e7ZArtQvpcrEv6zSYi91EvJPoY7ULkTnj7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+r/0OIqFX+p2ptUwTZeQxofU7bD1qnlOig15uldStaTBYeCfLselMohC/ic1tkfTeChQizHPMtvQteAeAzgpPGYI8oJnJ1XvmRA9FD6AyCwORHjriTZ5w5i8IQ5UjbM8z7u42829rvCSRiaKlTSnkc/HgSmGCLBCSsiccVRgXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5IfOpCc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5IfOpCc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FCA41F00A3A;
	Tue, 25 Aug 2026 07:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787644679;
	bh=bqnu+YbO6DFJnR6Kz15ZvsBkeY9Xo3GHguirfyIfc2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a5IfOpCcpPPZcFPB3ku6WLkwnImVCc24CrWWljSZseu2I+Obd/ZITQ2nVIMZqDdH/
	 7QaNsiH/AQMBAnLUaUoNx8UGyPLMdUuSVX0gpVIxiLcZcx/rkaHYgOoO/4OEGH/5nL
	 3P2yjCgtARrhK3RksshS9h6iMTFLVKhRBM7brxNsork5DdWphJmTK8zt1FvMejx0wo
	 +Df7t5D8yH+KYyLFg2gOQdv582SaA0xgpo5t+MmtjJQGB+LfZhMBJlJzgmN7US9hnN
	 5S3mXy65WbU9Rf0qNemjF5mz3SelLC/12JIlHqAWUE+hQbCr4QdElrpFOj2rSS4q1/
	 uduLcO8XuZ/DA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 1/8] mptcp: use atomic64_t for msk->ack_seq
Date: Tue, 25 Aug 2026 15:57:29 +0800
Message-ID: <1d4ae9189eece66deaf4e7c47ff2e705341e31ff.1787644449.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1787644449.git.tanggeliang@kylinos.cn>
References: <cover.1787644449.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

msk->ack_seq is updated in process context without mptcp_data_lock()
and read concurrently in softirq via mptcp_write_options(). On 32-bit
architectures, 64-bit READ_ONCE/WRITE_ONCE compiles to two 32-bit
accesses, so a torn read could produce a corrupted MPTCP Data ACK.

Convert msk->ack_seq from u64 to atomic64_t to guarantee tear-free
accesses on all architectures. Also cache atomic64_read() in a local
variable in __mptcp_move_skb() and __mptcp_ofo_queue() to avoid
inconsistent repeated reads.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/trace/events/mptcp.h |  4 ++--
 net/mptcp/options.c          |  5 +++--
 net/mptcp/protocol.c         | 43 +++++++++++++++++++-----------------
 net/mptcp/protocol.h         |  2 +-
 net/mptcp/sockopt.c          |  2 +-
 net/mptcp/subflow.c          |  7 +++---
 6 files changed, 34 insertions(+), 29 deletions(-)

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index 22882bd03459..517b8129a95d 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -224,11 +224,11 @@ TRACE_EVENT(mptcp_rcvbuf_grow,
 		ofo_empty = RB_EMPTY_ROOT(&msk->out_of_order_queue);
 		__entry->ooo_space = ofo_empty ? 0 :
 				     MPTCP_SKB_CB(msk->ooo_last_skb)->end_seq -
-				     msk->ack_seq;
+				     atomic64_read(&msk->ack_seq);
 
 		__entry->rcvbuf = sk->sk_rcvbuf;
 		__entry->rcv_wnd = atomic64_read(&msk->rcv_wnd_sent) -
-				   msk->ack_seq;
+				   atomic64_read(&msk->ack_seq);
 		__entry->scaling_ratio = msk->scaling_ratio;
 		__entry->sport = ntohs(inet->inet_sport);
 		__entry->dport = ntohs(inet->inet_dport);
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index f87707110c75..16abb8c6485c 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1169,7 +1169,8 @@ bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, u64 data_fin_seq, bool us
 		return false;
 
 	WRITE_ONCE(msk->rcv_data_fin_seq,
-		   mptcp_expand_seq(READ_ONCE(msk->ack_seq), data_fin_seq, use_64bit));
+		   mptcp_expand_seq(atomic64_read(&msk->ack_seq),
+				    data_fin_seq, use_64bit));
 	WRITE_ONCE(msk->rcv_data_fin, 1);
 
 	return true;
@@ -1539,7 +1540,7 @@ void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
 			 */
 			subflow = mptcp_subflow_ctx(ssk);
 			msk = mptcp_sk(subflow->conn);
-			ack_seq = READ_ONCE(msk->ack_seq);
+			ack_seq = atomic64_read(&msk->ack_seq);
 			if (mpext->ack64) {
 				put_unaligned_be64(ack_seq, ptr);
 				ptr += 2;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f22d64ab1c53..88bdb65a9e87 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -451,10 +451,12 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 	u64 copy_len = MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_seq;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct sk_buff *tail;
+	u64 ack_seq;
 
 	mptcp_borrow_fwdmem(sk, skb);
 
-	if (MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq) {
+	ack_seq = atomic64_read(&msk->ack_seq);
+	if (MPTCP_SKB_CB(skb)->map_seq == ack_seq) {
 		/* in sequence */
 insert:
 		if (!mptcp_try_rmem_schedule(sk, skb)) {
@@ -464,7 +466,7 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 		}
 
 		msk->bytes_received += copy_len;
-		WRITE_ONCE(msk->ack_seq, msk->ack_seq + copy_len);
+		atomic64_add(copy_len, &msk->ack_seq);
 		tail = skb_peek_tail(&sk->sk_receive_queue);
 		if (tail && mptcp_try_coalesce(sk, tail, skb))
 			return true;
@@ -472,17 +474,17 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 		skb_set_owner_r(skb, sk);
 		__skb_queue_tail(&sk->sk_receive_queue, skb);
 		return true;
-	} else if (after64(MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq)) {
+	} else if (after64(MPTCP_SKB_CB(skb)->map_seq, ack_seq)) {
 		mptcp_data_queue_ofo(msk, skb);
 		return false;
 	}
 
 	/* Partial packet */
-	if (after64(MPTCP_SKB_CB(skb)->end_seq, msk->ack_seq)) {
-		copy_len = MPTCP_SKB_CB(skb)->end_seq - msk->ack_seq;
-		MPTCP_SKB_CB(skb)->offset += msk->ack_seq -
+	if (after64(MPTCP_SKB_CB(skb)->end_seq, ack_seq)) {
+		copy_len = MPTCP_SKB_CB(skb)->end_seq - ack_seq;
+		MPTCP_SKB_CB(skb)->offset += ack_seq -
 					     MPTCP_SKB_CB(skb)->map_seq;
-		MPTCP_SKB_CB(skb)->map_seq += msk->ack_seq -
+		MPTCP_SKB_CB(skb)->map_seq += ack_seq -
 					      MPTCP_SKB_CB(skb)->map_seq;
 		goto insert;
 	}
@@ -569,7 +571,7 @@ static bool mptcp_pending_data_fin(struct sock *sk, u64 *seq)
 	     (TCPF_ESTABLISHED | TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2))) {
 		u64 rcv_data_fin_seq = READ_ONCE(msk->rcv_data_fin_seq);
 
-		if (READ_ONCE(msk->ack_seq) == rcv_data_fin_seq) {
+		if (atomic64_read(&msk->ack_seq) == rcv_data_fin_seq) {
 			if (seq)
 				*seq = rcv_data_fin_seq;
 
@@ -710,7 +712,7 @@ static void mptcp_check_data_fin(struct sock *sk)
 	 */
 
 	if (mptcp_pending_data_fin(sk, &rcv_data_fin_seq)) {
-		WRITE_ONCE(msk->ack_seq, msk->ack_seq + 1);
+		atomic64_inc(&msk->ack_seq);
 		WRITE_ONCE(msk->rcv_data_fin, 0);
 
 		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | RCV_SHUTDOWN);
@@ -879,22 +881,22 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 {
 	struct sock *sk = (struct sock *)msk;
 	struct sk_buff *skb, *tail;
+	u64 end_seq, ack_seq;
 	bool moved = false;
 	struct rb_node *p;
-	u64 end_seq;
 
 	p = rb_first(&msk->out_of_order_queue);
 	pr_debug("msk=%p empty=%d\n", msk, RB_EMPTY_ROOT(&msk->out_of_order_queue));
 	while (p) {
+		ack_seq = atomic64_read(&msk->ack_seq);
 		skb = rb_to_skb(p);
-		if (after64(MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq))
+		if (after64(MPTCP_SKB_CB(skb)->map_seq, ack_seq))
 			break;
 
 		p = rb_next(p);
 		rb_erase(&skb->rbnode, &msk->out_of_order_queue);
 
-		if (unlikely(!after64(MPTCP_SKB_CB(skb)->end_seq,
-				      msk->ack_seq))) {
+		if (unlikely(!after64(MPTCP_SKB_CB(skb)->end_seq, ack_seq))) {
 			mptcp_drop(sk, skb);
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
 			continue;
@@ -903,18 +905,18 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 		end_seq = MPTCP_SKB_CB(skb)->end_seq;
 		tail = skb_peek_tail(&sk->sk_receive_queue);
 		if (!tail || !mptcp_ooo_try_coalesce(msk, tail, skb)) {
-			int delta = msk->ack_seq - MPTCP_SKB_CB(skb)->map_seq;
+			int delta = ack_seq - MPTCP_SKB_CB(skb)->map_seq;
 
 			/* skip overlapping data, if any */
 			pr_debug("uncoalesced seq=%llx ack seq=%llx delta=%d\n",
-				 MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq,
+				 MPTCP_SKB_CB(skb)->map_seq, ack_seq,
 				 delta);
 			MPTCP_SKB_CB(skb)->offset += delta;
 			MPTCP_SKB_CB(skb)->map_seq += delta;
 			__skb_queue_tail(&sk->sk_receive_queue, skb);
 		}
-		msk->bytes_received += end_seq - msk->ack_seq;
-		WRITE_ONCE(msk->ack_seq, end_seq);
+		msk->bytes_received += end_seq - ack_seq;
+		atomic64_set(&msk->ack_seq, end_seq);
 		moved = true;
 	}
 	return moved;
@@ -1072,7 +1074,7 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 
 static void mptcp_subflow_joined(struct mptcp_sock *msk, struct sock *ssk)
 {
-	mptcp_subflow_ctx(ssk)->map_seq = READ_ONCE(msk->ack_seq);
+	mptcp_subflow_ctx(ssk)->map_seq = atomic64_read(&msk->ack_seq);
 	msk->allow_infinite_fallback = false;
 	mptcp_event(MPTCP_EVENT_SUB_ESTABLISHED, msk, ssk, GFP_ATOMIC);
 }
@@ -2396,7 +2398,8 @@ static unsigned int mptcp_inq_hint(const struct sock *sk)
 
 	skb = skb_peek(&sk->sk_receive_queue);
 	if (skb) {
-		u64 hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
+		u64 hint_val = atomic64_read(&msk->ack_seq) -
+			       MPTCP_SKB_CB(skb)->map_seq;
 
 		if (hint_val >= INT_MAX)
 			return INT_MAX;
@@ -3678,7 +3681,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	mptcp_init_rtt_est(msk);
 
 	/* for fallback's sake */
-	WRITE_ONCE(msk->ack_seq, 0);
+	atomic64_set(&msk->ack_seq, 0);
 	atomic64_set(&msk->rcv_wnd_sent, 0);
 
 	WRITE_ONCE(sk->sk_shutdown, 0);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3d250e8204d5..4074fea9ba85 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -292,7 +292,7 @@ struct mptcp_sock {
 	u64		bytes_sent;
 	u64		snd_nxt;
 	u64		bytes_received;
-	u64		ack_seq;
+	atomic64_t	ack_seq;
 	atomic64_t	rcv_wnd_sent;
 	u64		rcv_data_fin_seq;
 	u64		bytes_retrans;
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 922f6ae5c80c..666827eb2c9a 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1101,7 +1101,7 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 	mptcp_data_lock(sk);
 	info->mptcpi_last_ack_recv = jiffies_to_msecs(now - msk->last_ack_recv);
 	info->mptcpi_snd_una = msk->snd_una;
-	info->mptcpi_rcv_nxt = msk->ack_seq;
+	info->mptcpi_rcv_nxt = atomic64_read(&msk->ack_seq);
 	info->mptcpi_bytes_acked = msk->bytes_acked;
 	mptcp_data_unlock(sk);
 }
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 2d7ccb01d234..6345c6ac43b2 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -491,7 +491,7 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
 	subflow->map_seq = subflow->iasn;
 
 	WRITE_ONCE(msk->remote_key, subflow->remote_key);
-	WRITE_ONCE(msk->ack_seq, subflow->iasn);
+	atomic64_set(&msk->ack_seq, subflow->iasn);
 	WRITE_ONCE(msk->can_ack, true);
 	atomic64_set(&msk->rcv_wnd_sent, subflow->iasn);
 }
@@ -1198,7 +1198,8 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 		data_len--;
 	}
 
-	map_seq = mptcp_expand_seq(READ_ONCE(msk->ack_seq), mpext->data_seq, mpext->dsn64);
+	map_seq = mptcp_expand_seq(atomic64_read(&msk->ack_seq),
+				   mpext->data_seq, mpext->dsn64);
 	WRITE_ONCE(mptcp_sk(subflow->conn)->use_64bit_ack, !!mpext->dsn64);
 
 	if (subflow->map_valid) {
@@ -1386,7 +1387,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 		if (unlikely(!READ_ONCE(msk->can_ack)))
 			goto fallback;
 
-		old_ack = READ_ONCE(msk->ack_seq);
+		old_ack = atomic64_read(&msk->ack_seq);
 		ack_seq = mptcp_subflow_get_mapped_dsn(subflow);
 		pr_debug("msk ack_seq=%llx subflow ack_seq=%llx\n", old_ack,
 			 ack_seq);
-- 
2.53.0

