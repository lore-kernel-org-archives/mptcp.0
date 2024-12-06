Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602BB1FF7A1
	for <mptcp@lists.linux.dev>; Fri,  6 Dec 2024 12:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733487076; cv=none; b=hugH2RL00HnjIYqmDn6zOapiUyiNLhEH+NrLvV2E5s4DO6Hc6RfZLK0+6EVmWUBw34gMOoSJd1hMS3NDrtU2HxhRY76w2bIrqeDfK/Wr5wDBSJ4QHvlRcL7I7C9Viw24d+wlue4fw3FMCrfStn/0s+hAL279bCo/aAqKAb/+BM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733487076; c=relaxed/simple;
	bh=N5EAGa8ayyMc9yxv8vM4o2y/bFRDyp68LmtLa89ZyQU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=El6DRRQeKVBzFyN27IfP0vGgxekCIDIg2pM+gO52mm2LEblPEcYydZ4YQUWfX0NSMR77hIbcKRdGP7sAnVYr0vaK26wyCZpQxLdNz+VJG/XCOGX5wNjsjJ1e1VlN2vLRCsmysNZHhB3pvgmeC81jfJpmq2oWTgghj2Zjx4Q6vVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RgtZekYB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RgtZekYB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733487073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QbHFfINypOIognEw9lvtbTAUS0vFOuIKEc0jegXnfW0=;
	b=RgtZekYBTEzyUjal6vPaUHxDQn0EN4A5XTJTXysOkFI+CZCP49ARyhVNOn212PyaSuB+sc
	UNfOyPbF+998BSedyj4M8xFjOk7fqCpMdzuoeG4mBhui1AtHaZevuVBRvHVlF/sW52AxCm
	ftXzoUlFdCg3TSbyVw7iKVBn0q6uFkk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-g4r0PpvbMfuaaLPMNASjQQ-1; Fri,
 06 Dec 2024 07:11:12 -0500
X-MC-Unique: g4r0PpvbMfuaaLPMNASjQQ-1
X-Mimecast-MFC-AGG-ID: g4r0PpvbMfuaaLPMNASjQQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A0E6A1956053
	for <mptcp@lists.linux.dev>; Fri,  6 Dec 2024 12:11:11 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.243])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D30B319560A0
	for <mptcp@lists.linux.dev>; Fri,  6 Dec 2024 12:11:10 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 6/7] mptcp: cleanup mem accounting.
Date: Fri,  6 Dec 2024 13:11:08 +0100
Message-ID: <152364cf85476115c84f435d76a8f04da9e2d089.1733486870.git.pabeni@redhat.com>
In-Reply-To: <cover.1733486870.git.pabeni@redhat.com>
References: <cover.1733486870.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: U4IS2z8emBwCMJtN_JPlnBk38rox1CDOrxnvcvAvyzY_1733487071
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

After the previous patch, updating sk_forward_memory is cheap and
we can drop a lot of complexity from the MPTCP memory acconting,
removing the custom fwd mem allocations for rmem.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
 - keep 'snd_una' and recovery-related fields under the msk
   data lock
 - dropped unneeded code in __mptcp_move_skbs()
---
 net/mptcp/fastopen.c |   2 +-
 net/mptcp/protocol.c | 115 +++----------------------------------------
 net/mptcp/protocol.h |   4 +-
 3 files changed, 10 insertions(+), 111 deletions(-)

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
index 42d04de32560..4f27b0cafac5 100644
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
@@ -150,7 +139,7 @@ static bool mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 	 * negative one
 	 */
 	atomic_add(delta, &sk->sk_rmem_alloc);
-	mptcp_rmem_charge(sk, delta);
+	sk_mem_charge(sk, delta);
 	kfree_skb_partial(from, fragstolen);
 
 	return true;
@@ -165,44 +154,6 @@ static bool mptcp_ooo_try_coalesce(struct mptcp_sock *msk, struct sk_buff *to,
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
@@ -315,25 +266,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 
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
@@ -351,7 +284,7 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
 	skb_orphan(skb);
 
 	/* try to fetch required memory from subflow */
-	if (!mptcp_rmem_schedule(sk, ssk, skb->truesize)) {
+	if (!sk_rmem_schedule(sk, skb, skb->truesize)) {
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
 		goto drop;
 	}
@@ -375,7 +308,7 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
 		if (tail && mptcp_try_coalesce(sk, tail, skb))
 			return true;
 
-		mptcp_set_owner_r(skb, sk);
+		skb_set_owner_r(skb, sk);
 		__skb_queue_tail(&sk->sk_receive_queue, skb);
 		return true;
 	} else if (after64(MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq)) {
@@ -1983,9 +1916,10 @@ static int __mptcp_recvmsg_mskq(struct sock *sk,
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
@@ -2099,18 +2033,6 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
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
 	struct mptcp_subflow_context *subflow;
@@ -2134,7 +2056,6 @@ static bool __mptcp_move_skbs(struct sock *sk)
 			break;
 
 		slowpath = lock_sock_fast(ssk);
-		__mptcp_update_rmem(sk);
 		done = __mptcp_move_skbs_from_subflow(msk, ssk, &moved);
 
 		if (unlikely(ssk->sk_err))
@@ -2142,12 +2063,7 @@ static bool __mptcp_move_skbs(struct sock *sk)
 		unlock_sock_fast(ssk, slowpath);
 	} while (!done);
 
-	ret = moved > 0;
-	if (!RB_EMPTY_ROOT(&msk->out_of_order_queue) ||
-	    !skb_queue_empty(&sk->sk_receive_queue)) {
-		__mptcp_update_rmem(sk);
-		ret |= __mptcp_ofo_queue(msk);
-	}
+	ret = moved > 0 || __mptcp_ofo_queue(msk);
 	if (ret)
 		mptcp_check_data_fin((struct sock *)msk);
 	return ret;
@@ -2813,8 +2729,6 @@ static void __mptcp_init_sock(struct sock *sk)
 	INIT_WORK(&msk->work, mptcp_worker);
 	msk->out_of_order_queue = RB_ROOT;
 	msk->first_pending = NULL;
-	WRITE_ONCE(msk->rmem_fwd_alloc, 0);
-	WRITE_ONCE(msk->rmem_released, 0);
 	msk->timer_ival = TCP_RTO_MIN;
 	msk->scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
 
@@ -3040,8 +2954,6 @@ static void __mptcp_destroy_sock(struct sock *sk)
 
 	sk->sk_prot->destroy(sk);
 
-	WARN_ON_ONCE(READ_ONCE(msk->rmem_fwd_alloc));
-	WARN_ON_ONCE(msk->rmem_released);
 	sk_stream_kill_queues(sk);
 	xfrm_sk_free_policy(sk);
 
@@ -3399,8 +3311,6 @@ void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
 	/* move all the rx fwd alloc into the sk_mem_reclaim_final in
 	 * inet_sock_destruct() will dispose it
 	 */
-	sk_forward_alloc_add(sk, msk->rmem_fwd_alloc);
-	WRITE_ONCE(msk->rmem_fwd_alloc, 0);
 	mptcp_token_destroy(msk);
 	mptcp_pm_free_anno_list(msk);
 	mptcp_free_local_addr_list(msk);
@@ -3496,8 +3406,6 @@ static void mptcp_release_cb(struct sock *sk)
 		if (__test_and_clear_bit(MPTCP_SYNC_SNDBUF, &msk->cb_flags))
 			__mptcp_sync_sndbuf(sk);
 	}
-
-	__mptcp_update_rmem(sk);
 }
 
 /* MP_JOIN client subflow must wait for 4th ack before sending any data:
@@ -3668,12 +3576,6 @@ static void mptcp_shutdown(struct sock *sk, int how)
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
@@ -3832,7 +3734,6 @@ static struct proto mptcp_prot = {
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

