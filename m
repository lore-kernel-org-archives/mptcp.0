Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5EA1A070E
	for <mptcp@lists.linux.dev>; Fri, 29 Nov 2024 17:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732902322; cv=none; b=IhEFbmB1XVDZIUOZfiUzw38JIST8ShiellkEei2It6AMfJuNC2mXKkW0NnLaMZdiZV8CchsutksE8AprGDHZendg8OQ+MhQzg+T1tqTO2+Pjgqg/Fv3Zc29xyiUFTuZzhDGWGet/JKsS9+s99jnmacyfA2L1Yhw6vaVHCDRpCxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732902322; c=relaxed/simple;
	bh=FZI2lemmeR+nrc4WD0RZe1ZnDIJfOzyxzEWBrQhEims=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=fB36JtjeDyx/edfMwIk0Qqztfg7KfFSVojB5Gb3kR3YzdO0RtPKgAQ0JUWhZZseLCUFbwLEfUZXJQv1GtS1VF9QpfzYZ5uPggHYsBzZgMCykI2DDNP/T7o89CVdj93lArmWu+u2GRRgFRynDTTDFrPWHYqxFGgCEBzDmnKGBkKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ncwum9dd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ncwum9dd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732902319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e4RnZFFyit9FQqtEwqA5J8bEFC1AhKqS3f7kg2+hLtw=;
	b=Ncwum9ddHvb/TSS01POkkclXuLx7JalOAishLUJ0kwVUnvflxfWeJwj5UPbtChLMq0t+17
	WQqcfIznR/FU7G0tkr6yyHVPGgHdt1V4EZ/i9aS7E6f0bcYyC1j8xVT0cdMAt5ipxGmPNi
	CkfHnMFk+fcJZZxfASOG3BPpVS3y5yc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-151-F9MweMufNXy84vDs2RDQ9Q-1; Fri,
 29 Nov 2024 12:45:17 -0500
X-MC-Unique: F9MweMufNXy84vDs2RDQ9Q-1
X-Mimecast-MFC-AGG-ID: F9MweMufNXy84vDs2RDQ9Q
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F7F21955DA1
	for <mptcp@lists.linux.dev>; Fri, 29 Nov 2024 17:45:17 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.89])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 436621955D45
	for <mptcp@lists.linux.dev>; Fri, 29 Nov 2024 17:45:16 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next-next 3/3] mptcp: cleanup mem accounting.
Date: Fri, 29 Nov 2024 18:45:05 +0100
Message-ID: <e45cdca27e17296f261f5ce6d033581f02871c58.1732902181.git.pabeni@redhat.com>
In-Reply-To: <cover.1732902181.git.pabeni@redhat.com>
References: <cover.1732902181.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ItM6mI8LXktsBZFKL28fWWftL2VHfk5e_vac-_U_WmQ_1732902317
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

After the previous patch, updating sk_forward_memory is cheap and
we can drop a lot of complexity from the MPTCP memory acconting,
removing the custom fwd mem allocations for rmem.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/fastopen.c |   2 +-
 net/mptcp/protocol.c | 128 ++++---------------------------------------
 net/mptcp/protocol.h |   4 +-
 3 files changed, 13 insertions(+), 121 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index fb945c0d50bf..b0f1dddfb143 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -51,7 +51,7 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 	mptcp_data_lock(sk);
 	DEBUG_NET_WARN_ON_ONCE(sock_owned_by_user_nocheck(sk));
 
-	mptcp_set_owner_r(skb, sk);
+	skb_set_owner_r(skb, sk);
 	__skb_queue_tail(&sk->sk_receive_queue, skb);
 	mptcp_sk(sk)->bytes_received += skb->len;
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 159add48f6d9..426acc03a932 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -118,17 +118,6 @@ static void mptcp_drop(struct sock *sk, struct sk_buff *skb)
 	__kfree_skb(skb);
 }
 
-static void mptcp_rmem_fwd_alloc_add(struct sock *sk, int size)
-{
-	WRITE_ONCE(mptcp_sk(sk)->rmem_fwd_alloc,
-		   mptcp_sk(sk)->rmem_fwd_alloc + size);
-}
-
-static void mptcp_rmem_charge(struct sock *sk, int size)
-{
-	mptcp_rmem_fwd_alloc_add(sk, -size);
-}
-
 static bool mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 			       struct sk_buff *from)
 {
@@ -149,7 +138,7 @@ static bool mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 	 * negative one
 	 */
 	atomic_add(delta, &sk->sk_rmem_alloc);
-	mptcp_rmem_charge(sk, delta);
+	sk_mem_charge(sk, delta);
 	kfree_skb_partial(from, fragstolen);
 
 	return true;
@@ -164,44 +153,6 @@ static bool mptcp_ooo_try_coalesce(struct mptcp_sock *msk, struct sk_buff *to,
 	return mptcp_try_coalesce((struct sock *)msk, to, from);
 }
 
-static void __mptcp_rmem_reclaim(struct sock *sk, int amount)
-{
-	amount >>= PAGE_SHIFT;
-	mptcp_rmem_charge(sk, amount << PAGE_SHIFT);
-	__sk_mem_reduce_allocated(sk, amount);
-}
-
-static void mptcp_rmem_uncharge(struct sock *sk, int size)
-{
-	struct mptcp_sock *msk = mptcp_sk(sk);
-	int reclaimable;
-
-	mptcp_rmem_fwd_alloc_add(sk, size);
-	reclaimable = msk->rmem_fwd_alloc - sk_unused_reserved_mem(sk);
-
-	/* see sk_mem_uncharge() for the rationale behind the following schema */
-	if (unlikely(reclaimable >= PAGE_SIZE))
-		__mptcp_rmem_reclaim(sk, reclaimable);
-}
-
-static void mptcp_rfree(struct sk_buff *skb)
-{
-	unsigned int len = skb->truesize;
-	struct sock *sk = skb->sk;
-
-	atomic_sub(len, &sk->sk_rmem_alloc);
-	mptcp_rmem_uncharge(sk, len);
-}
-
-void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk)
-{
-	skb_orphan(skb);
-	skb->sk = sk;
-	skb->destructor = mptcp_rfree;
-	atomic_add(skb->truesize, &sk->sk_rmem_alloc);
-	mptcp_rmem_charge(sk, skb->truesize);
-}
-
 /* "inspired" by tcp_data_queue_ofo(), main differences:
  * - use mptcp seqs
  * - don't cope with sacks
@@ -314,25 +265,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 
 end:
 	skb_condense(skb);
-	mptcp_set_owner_r(skb, sk);
-}
-
-static bool mptcp_rmem_schedule(struct sock *sk, struct sock *ssk, int size)
-{
-	struct mptcp_sock *msk = mptcp_sk(sk);
-	int amt, amount;
-
-	if (size <= msk->rmem_fwd_alloc)
-		return true;
-
-	size -= msk->rmem_fwd_alloc;
-	amt = sk_mem_pages(size);
-	amount = amt << PAGE_SHIFT;
-	if (!__sk_mem_raise_allocated(sk, size, amt, SK_MEM_RECV))
-		return false;
-
-	mptcp_rmem_fwd_alloc_add(sk, amount);
-	return true;
+	skb_set_owner_r(skb, sk);
 }
 
 static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
@@ -350,7 +283,7 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
 	skb_orphan(skb);
 
 	/* try to fetch required memory from subflow */
-	if (!mptcp_rmem_schedule(sk, ssk, skb->truesize)) {
+	if (!sk_rmem_schedule(sk, skb, skb->truesize)) {
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
 		goto drop;
 	}
@@ -374,7 +307,7 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
 		if (tail && mptcp_try_coalesce(sk, tail, skb))
 			return true;
 
-		mptcp_set_owner_r(skb, sk);
+		skb_set_owner_r(skb, sk);
 		__skb_queue_tail(&sk->sk_receive_queue, skb);
 		return true;
 	} else if (after64(MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq)) {
@@ -1077,17 +1010,10 @@ static void __mptcp_clean_una(struct sock *sk)
 
 static void __mptcp_clean_una_wakeup(struct sock *sk)
 {
-	lockdep_assert_held_once(&sk->sk_lock.slock);
-
 	__mptcp_clean_una(sk);
 	mptcp_write_space(sk);
 }
 
-static void mptcp_clean_una_wakeup(struct sock *sk)
-{
-	__mptcp_clean_una_wakeup(sk);
-}
-
 static void mptcp_enter_memory_pressure(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow;
@@ -1992,9 +1918,10 @@ static int __mptcp_recvmsg_mskq(struct sock *sk,
 		}
 
 		if (!(flags & MSG_PEEK)) {
-			/* we will bulk release the skb memory later */
+			/* avoid the indirect call, we know the destructor is sock_wfree */
 			skb->destructor = NULL;
-			WRITE_ONCE(msk->rmem_released, msk->rmem_released + skb->truesize);
+			atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
+			sk_mem_uncharge(sk, skb->truesize);
 			__skb_unlink(skb, &sk->sk_receive_queue);
 			__kfree_skb(skb);
 			msk->bytes_consumed += count;
@@ -2107,18 +2034,6 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 	msk->rcvq_space.time = mstamp;
 }
 
-static void __mptcp_update_rmem(struct sock *sk)
-{
-	struct mptcp_sock *msk = mptcp_sk(sk);
-
-	if (!msk->rmem_released)
-		return;
-
-	atomic_sub(msk->rmem_released, &sk->sk_rmem_alloc);
-	mptcp_rmem_uncharge(sk, msk->rmem_released);
-	WRITE_ONCE(msk->rmem_released, 0);
-}
-
 static bool __mptcp_move_skbs(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -2133,7 +2048,6 @@ static bool __mptcp_move_skbs(struct sock *sk)
 			break;
 
 		slowpath = lock_sock_fast(ssk);
-		__mptcp_update_rmem(sk);
 		done = __mptcp_move_skbs_from_subflow(msk, ssk, &moved);
 
 		if (unlikely(ssk->sk_err))
@@ -2143,10 +2057,9 @@ static bool __mptcp_move_skbs(struct sock *sk)
 
 	ret = moved > 0;
 	if (!RB_EMPTY_ROOT(&msk->out_of_order_queue) ||
-	    !skb_queue_empty(&sk->sk_receive_queue)) {
-		__mptcp_update_rmem(sk);
+	    !skb_queue_empty(&sk->sk_receive_queue))
 		ret |= __mptcp_ofo_queue(msk);
-	}
+
 	if (ret)
 		mptcp_check_data_fin((struct sock *)msk);
 	return ret;
@@ -2371,17 +2284,13 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
 	 * some data in the mptcp rtx queue has not really xmitted yet.
 	 * keep it simple and re-inject the whole mptcp level rtx queue
 	 */
-	mptcp_data_lock(sk);
 	__mptcp_clean_una_wakeup(sk);
 	rtx_head = mptcp_rtx_head(sk);
-	if (!rtx_head) {
-		mptcp_data_unlock(sk);
+	if (!rtx_head)
 		return false;
-	}
 
 	msk->recovery_snd_nxt = msk->snd_nxt;
 	msk->recovery = true;
-	mptcp_data_unlock(sk);
 
 	msk->first_pending = rtx_head;
 	msk->snd_burst = 0;
@@ -2640,7 +2549,7 @@ static void __mptcp_retrans(struct sock *sk)
 	int ret, err;
 	u16 len = 0;
 
-	mptcp_clean_una_wakeup(sk);
+	__mptcp_clean_una_wakeup(sk);
 
 	/* first check ssk: need to kick "stale" logic */
 	err = mptcp_sched_get_retrans(msk);
@@ -2813,8 +2722,6 @@ static void __mptcp_init_sock(struct sock *sk)
 	INIT_WORK(&msk->work, mptcp_worker);
 	msk->out_of_order_queue = RB_ROOT;
 	msk->first_pending = NULL;
-	WRITE_ONCE(msk->rmem_fwd_alloc, 0);
-	WRITE_ONCE(msk->rmem_released, 0);
 	msk->timer_ival = TCP_RTO_MIN;
 	msk->scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
 
@@ -3040,8 +2947,6 @@ static void __mptcp_destroy_sock(struct sock *sk)
 
 	sk->sk_prot->destroy(sk);
 
-	WARN_ON_ONCE(READ_ONCE(msk->rmem_fwd_alloc));
-	WARN_ON_ONCE(msk->rmem_released);
 	sk_stream_kill_queues(sk);
 	xfrm_sk_free_policy(sk);
 
@@ -3399,8 +3304,6 @@ void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
 	/* move all the rx fwd alloc into the sk_mem_reclaim_final in
 	 * inet_sock_destruct() will dispose it
 	 */
-	sk_forward_alloc_add(sk, msk->rmem_fwd_alloc);
-	WRITE_ONCE(msk->rmem_fwd_alloc, 0);
 	mptcp_token_destroy(msk);
 	mptcp_pm_free_anno_list(msk);
 	mptcp_free_local_addr_list(msk);
@@ -3493,8 +3396,6 @@ static void mptcp_release_cb(struct sock *sk)
 		if (__test_and_clear_bit(MPTCP_SYNC_SNDBUF, &msk->cb_flags))
 			__mptcp_sync_sndbuf(sk);
 	}
-
-	__mptcp_update_rmem(sk);
 }
 
 /* MP_JOIN client subflow must wait for 4th ack before sending any data:
@@ -3665,12 +3566,6 @@ static void mptcp_shutdown(struct sock *sk, int how)
 		__mptcp_wr_shutdown(sk);
 }
 
-static int mptcp_forward_alloc_get(const struct sock *sk)
-{
-	return READ_ONCE(sk->sk_forward_alloc) +
-	       READ_ONCE(mptcp_sk(sk)->rmem_fwd_alloc);
-}
-
 static int mptcp_ioctl_outq(const struct mptcp_sock *msk, u64 v)
 {
 	const struct sock *sk = (void *)msk;
@@ -3828,7 +3723,6 @@ static struct proto mptcp_prot = {
 	.hash		= mptcp_hash,
 	.unhash		= mptcp_unhash,
 	.get_port	= mptcp_get_port,
-	.forward_alloc_get	= mptcp_forward_alloc_get,
 	.stream_memory_free	= mptcp_stream_memory_free,
 	.sockets_allocated	= &mptcp_sockets_allocated,
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ad940cc1f26f..a0d46b69746d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -278,7 +278,6 @@ struct mptcp_sock {
 	u64		rcv_data_fin_seq;
 	u64		bytes_retrans;
 	u64		bytes_consumed;
-	int		rmem_fwd_alloc;
 	int		snd_burst;
 	int		old_wspace;
 	u64		recovery_snd_nxt;	/* in recovery mode accept up to this seq;
@@ -293,7 +292,6 @@ struct mptcp_sock {
 	u32		last_ack_recv;
 	unsigned long	timer_ival;
 	u32		token;
-	int		rmem_released;
 	unsigned long	flags;
 	unsigned long	cb_flags;
 	bool		recovery;		/* closing subflow write queue reinjected */
@@ -384,7 +382,7 @@ static inline void msk_owned_by_me(const struct mptcp_sock *msk)
  */
 static inline int __mptcp_rmem(const struct sock *sk)
 {
-	return atomic_read(&sk->sk_rmem_alloc) - READ_ONCE(mptcp_sk(sk)->rmem_released);
+	return atomic_read(&sk->sk_rmem_alloc);
 }
 
 static inline int mptcp_win_from_space(const struct sock *sk, int space)
-- 
2.45.2

