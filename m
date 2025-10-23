Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7180E3328E1
	for <mptcp@lists.linux.dev>; Thu, 23 Oct 2025 15:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761232286; cv=none; b=N5ITZqC3eCBFAGAjVCcS3WWJ7tzZYAd/Y1HXhqXdezpw+U40TOddOe5tDKYjJK60rsRtpKygvI5ekU0IduwSy47ruCN6S0eVpa44U8LLvi/JElh59NQ8cLxF2Ud+EvUMldS6dNeCvM4sQY0mENGQ5L7SJV1LNUI5D8lKWssOWjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761232286; c=relaxed/simple;
	bh=ZXE7BvbyCwRNvytNOq65KWppRnNTUwQxFuTZXUQj5rU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cqPzdZJnTBK0YwojD0PkGcTij6gxR6ERYyB2QedXmvfelJ/3b4wumZN01InLOUvIzy23xnoRphsTpdQNQENmt+Y9woulPUbPCIRdRjXLUK2wdSpGH5idng3knhg2CcU6nlXyoKOe5mrONWeCo0oY83suVNvBV4nh1Ugjoc7NMZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OcOFUUPI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OcOFUUPI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761232283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SRqKUOUVEXiavLmyIlFhGFwULLiLNapZMl3tZxYcNcw=;
	b=OcOFUUPIkFk2q9vyQiIbMWcNuOzdlyUTp9NQbLIAmvT9uENh3d392faElgLSzeSFXdmHvk
	Luf78eoYU+S1N/piPy1e5DvTvEU7L1SrnRz5wACdqLA9KIYTLWBD2A9Y8x0eEAXMG+fKHv
	M90NKptGzmZ4RqLHmsi7Yh2/Pq171C8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-EUuVfjEPMRyR5HUPPnaMiQ-1; Thu, 23 Oct 2025 11:11:22 -0400
X-MC-Unique: EUuVfjEPMRyR5HUPPnaMiQ-1
X-Mimecast-MFC-AGG-ID: EUuVfjEPMRyR5HUPPnaMiQ_1761232281
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-426d4f59cbcso1230923f8f.1
        for <mptcp@lists.linux.dev>; Thu, 23 Oct 2025 08:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761232281; x=1761837081;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SRqKUOUVEXiavLmyIlFhGFwULLiLNapZMl3tZxYcNcw=;
        b=jx+Vr83wmEb1xqHZi8/1uAwcMZikzQ9C85vlnP01OLeAt4YVUytH4ktdcwQCmDMn8j
         7mxxueuavC5/gJWyKpbjqa4mgeD0T7pyIiQ8KNR4sDbY6QjbxUpCZVzk1Woi/r124TNb
         wRX032GL1XU6OtKdBD8i7cKkrRrYBu2oIjXUVTuCy633Gd2ifArC43bTXRjjWjFjryek
         NdIGWMcq/R8sHFaratMuiRBRFpM93BvTkhswNyWuhCTIye4oq1EqqsfRct5z5KV0Jyi4
         sxKzAbtmSeEXlwFFsIvokPjz4dg6YtlPzjPdMsfqXBI+uexweFnlQLRXomLvmiM+dqG5
         7WTQ==
X-Gm-Message-State: AOJu0YysONmTWIeqi6RiXTNX3m07uVwSBlFInKfWYuE84M+fGIfxnjtt
	/IyoevtaP572qwqFVRAQchAfIOUqHA6dUilNZtjhsTqbigDoFIL5elkWki+bOanYO6DZP4OB2kV
	BJATf/UXNCtUc5HwNCyG1w46rWOyGxRSi14gHkaxjAMowY96TpFd4+BVQARA3g6ruV+mvzactF5
	zh58gu/+LqLLyBBpAquFzTHHDmQfsTxzQKStf3OA==
X-Gm-Gg: ASbGncs0+E0Tw0u71A5kDpLOAmTRLlqkgqgNBnKTuWRvDdMu1kUrVcL3yydMyRZkIZp
	M8tLzDm6XYxGU/fOAjZ3xSYttNdzehW/MKqWI6PUeyrAzluIJAY58aMhGz8r/nPxhSmZNlvPOcF
	nKpIet4o/2kH7TxsGIxRPzHaSkSR7ij74e8zT3gkepz3pGi8k8gB365UigujbMG4wTIGPaP8qTf
	EsLW/nvdA83ec5t4ir9di2/WDtoIIV70owFR/rjWbU3MIL2jHu2QLQsTXQOFyOzO8AvBK4YYV7b
	H+NW410qmPUwutE5CbG4J0p6wyU8Kvxe/zmki+2j5F3Ra70OSVX1ou+45Wp8kqZylnPWi0S1lqN
	DM6TaZ4G/AZHUkVAaFf/SYh7TqQsc92mqQnM2y26AFcoSS2Y=
X-Received: by 2002:a05:600c:34d2:b0:46f:b42e:e38f with SMTP id 5b1f17b1804b1-475c4004b2emr60692265e9.19.1761232280560;
        Thu, 23 Oct 2025 08:11:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKKcwmBYoXw3sxxM54d55MXXytzUR4rpRMbVRaHENod4f1r+TreasG7o2em7UZq1y2cg/HnQ==
X-Received: by 2002:a05:600c:34d2:b0:46f:b42e:e38f with SMTP id 5b1f17b1804b1-475c4004b2emr60691885e9.19.1761232279923;
        Thu, 23 Oct 2025 08:11:19 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475cae9f8eesm42248145e9.6.2025.10.23.08.11.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 08:11:19 -0700 (PDT)
Message-ID: <3feb8c2a-2098-4626-8bf2-edd66f679463@redhat.com>
Date: Thu, 23 Oct 2025 17:11:18 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 mptcp-next 11/11] mptcp: leverage the backlog for RX
 packet processing
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
References: <cover.1761142784.git.pabeni@redhat.com>
 <2201f259d2176bca0ad37500a352658f7ef5a1f0.1761142784.git.pabeni@redhat.com>
In-Reply-To: <2201f259d2176bca0ad37500a352658f7ef5a1f0.1761142784.git.pabeni@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uqDOtUsq4ZOVAoibTSIUT55IJuOsaP8WWCqQE7HjQW0_1761232281
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/22/25 4:31 PM, Paolo Abeni wrote:
> When the msk socket is owned or the msk receive buffer is full,
> move the incoming skbs in a msk level backlog list. This avoid
> traversing the joined subflows and acquiring the subflow level
> socket lock at reception time, improving the RX performances.
> 
> When processing the backlog, use the fwd alloc memory borrowed from
> the incoming subflow. skbs exceeding the msk receive space are
> not dropped; instead they are kept into the backlog until the receive
> buffer is freed. Dropping packets already acked at the TCP level is
> explicitly discouraged by the RFC and would corrupt the data stream
> for fallback sockets.
> 
> Move the conditional reschedule in release_cb() to take action only
> after the first loop iteration, to avoid rescheduling just before
> releasing the lock.
> 
> Special care is needed to avoid adding skbs to the backlog of a closed
> msk and to avoid leaving dangling references into the backlog
> at subflow closing time.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v5 -> v6:
>   - do backlog len update asap to advise the correct window.
>   - explicitly bound backlog processing loop to the maximum BL len
> 
> v4 -> v5:
>   - consolidate ssk rcvbuf accunting in __mptcp_move_skb(), remove
>     some code duplication
>   - return soon in __mptcp_add_backlog() when dropping skbs due to
>     the msk closed. This avoid later UaF
> ---
>  net/mptcp/protocol.c | 151 +++++++++++++++++++++++++++----------------
>  net/mptcp/protocol.h |   2 +-
>  2 files changed, 96 insertions(+), 57 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 5a1d8f9e0fb0ec..0aae17ab77edb2 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -696,7 +696,7 @@ static void __mptcp_add_backlog(struct sock *sk, struct sk_buff *skb)
>  }
>  
>  static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
> -					   struct sock *ssk)
> +					   struct sock *ssk, bool own_msk)
>  {
>  	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
>  	struct sock *sk = (struct sock *)msk;
> @@ -712,9 +712,6 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
>  		struct sk_buff *skb;
>  		bool fin;
>  
> -		if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
> -			break;
> -
>  		/* try to move as much data as available */
>  		map_remaining = subflow->map_data_len -
>  				mptcp_subflow_get_map_offset(subflow);
> @@ -742,9 +739,12 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
>  			int bmem;
>  
>  			bmem = mptcp_init_skb(ssk, skb, offset, len);
> -			sk_forward_alloc_add(sk, bmem);
> +			if (own_msk)
> +				sk_forward_alloc_add(sk, bmem);
> +			else
> +				msk->borrowed_mem += bmem;
>  
> -			if (true)
> +			if (own_msk && sk_rmem_alloc_get(sk) < sk->sk_rcvbuf)
>  				ret |= __mptcp_move_skb(sk, skb);
>  			else
>  				__mptcp_add_backlog(sk, skb);
> @@ -866,7 +866,7 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
>  	struct sock *sk = (struct sock *)msk;
>  	bool moved;
>  
> -	moved = __mptcp_move_skbs_from_subflow(msk, ssk);
> +	moved = __mptcp_move_skbs_from_subflow(msk, ssk, true);
>  	__mptcp_ofo_queue(msk);
>  	if (unlikely(ssk->sk_err))
>  		__mptcp_subflow_error_report(sk, ssk);
> @@ -898,9 +898,8 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
>  		/* Wake-up the reader only for in-sequence data */
>  		if (move_skbs_to_msk(msk, ssk) && mptcp_epollin_ready(sk))
>  			sk->sk_data_ready(sk);
> -		
>  	} else {
> -		__set_bit(MPTCP_DEQUEUE, &mptcp_sk(sk)->cb_flags);
> +		__mptcp_move_skbs_from_subflow(msk, ssk, false);
>  	}
>  	mptcp_data_unlock(sk);
>  }
> @@ -2135,60 +2134,92 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
>  	msk->rcvq_space.time = mstamp;
>  }
>  
> -static struct mptcp_subflow_context *
> -__mptcp_first_ready_from(struct mptcp_sock *msk,
> -			 struct mptcp_subflow_context *subflow)
> +static bool __mptcp_move_skbs(struct sock *sk, struct list_head *skbs, u32 *delta)
>  {
> -	struct mptcp_subflow_context *start_subflow = subflow;
> +	struct sk_buff *skb = list_first_entry(skbs, struct sk_buff, list);
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	bool moved = false;
> +
> +	*delta = 0;
> +	while (1) {
> +		/* If the msk recvbuf is full stop, don't drop */
> +		if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
> +			break;
> +
> +		prefetch(skb->next);
> +		list_del(&skb->list);
> +		*delta += skb->truesize;
> +
> +		moved |= __mptcp_move_skb(sk, skb);
> +		if (list_empty(skbs))
> +			break;
>  
> -	while (!READ_ONCE(subflow->data_avail)) {
> -		subflow = mptcp_next_subflow(msk, subflow);
> -		if (subflow == start_subflow)
> -			return NULL;
> +		skb = list_first_entry(skbs, struct sk_buff, list);
>  	}
> -	return subflow;
> +
> +	__mptcp_ofo_queue(msk);
> +	if (moved)
> +		mptcp_check_data_fin((struct sock *)msk);
> +	return moved;
>  }
>  
> -static bool __mptcp_move_skbs(struct sock *sk)
> +static bool mptcp_can_spool_backlog(struct sock *sk, u32 moved,
> +				    struct list_head *skbs)
>  {
> -	struct mptcp_subflow_context *subflow;
>  	struct mptcp_sock *msk = mptcp_sk(sk);
> -	bool ret = false;
>  
> -	if (list_empty(&msk->conn_list))
> +	if (list_empty(&msk->backlog_list))
>  		return false;
>  
> -	subflow = list_first_entry(&msk->conn_list,
> -				   struct mptcp_subflow_context, node);
> -	for (;;) {
> -		struct sock *ssk;
> -		bool slowpath;
> +	/* Borrowed mem could be zero only in the unlikely event that the bl
> +	 * is full
> +	 */
> +	if (likely(msk->borrowed_mem)) {
> +		sk_forward_alloc_add(sk, msk->borrowed_mem);
> +		msk->borrowed_mem = 0;
> +		sk->sk_reserved_mem = msk->backlog_len;

With the above I intended to prevent the fwd memory handling from
releasing backlog_len bytes. Re-reading the relevant code, it does not
allow that (experimentation confirmed), see:

https://elixir.bootlin.com/linux/v6.18-rc2/source/include/net/sock.h#L1593

and:

https://elixir.bootlin.com/linux/v6.18-rc2/source/include/net/sock.h#L1580

This will need some more care. Also patch 2 will require some
significant rework.

@Mat, @Matttbe: could you please consider merging patches 1,3-9?

I think they should be pretty uncontroversial, would make the series
more manegeable for future iterations (and would alleviate my
frustration to make this thing work correctly).

Thanks!

Paolo


> +	}
>  
> -		/*
> -		 * As an optimization avoid traversing the subflows list
> -		 * and ev. acquiring the subflow socket lock before baling out
> -		 */
> -		if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
> -			break;
> +	/* Limit the backlog loop to the maximum backlog size; moved skbs are
> +	 * accounted on both the backlog and the receive buffer; the caller
> +	 * should update the backlog usage ASAP, to avoid underestimate the
> +	 * rcvwnd.
> +	 */
> +	if (moved > sk->sk_rcvbuf || sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
> +		return false;
>  
> -		subflow = __mptcp_first_ready_from(msk, subflow);
> -		if (!subflow)
> -			break;
> +	INIT_LIST_HEAD(skbs);
> +	list_splice_init(&msk->backlog_list, skbs);
> +	return true;
> +}
>  
> -		ssk = mptcp_subflow_tcp_sock(subflow);
> -		slowpath = lock_sock_fast(ssk);
> -		ret = __mptcp_move_skbs_from_subflow(msk, ssk) || ret;
> -		if (unlikely(ssk->sk_err))
> -			__mptcp_error_report(sk);
> -		unlock_sock_fast(ssk, slowpath);
> +static void mptcp_backlog_spooled(struct sock *sk, u32 moved,
> +				  struct list_head *skbs)
> +{
> +	struct mptcp_sock *msk = mptcp_sk(sk);
>  
> -		subflow = mptcp_next_subflow(msk, subflow);
> -	}
> +	WRITE_ONCE(msk->backlog_len, msk->backlog_len - moved);
> +	list_splice(skbs, &msk->backlog_list);
> +	sk->sk_reserved_mem = msk->backlog_len;
> +}
>  
> -	__mptcp_ofo_queue(msk);
> -	if (ret)
> -		mptcp_check_data_fin((struct sock *)msk);
> -	return ret;
> +static bool mptcp_move_skbs(struct sock *sk)
> +{
> +	u32 moved, total_moved = 0;
> +	struct list_head skbs;
> +	bool enqueued = false;
> +
> +	mptcp_data_lock(sk);
> +	while (mptcp_can_spool_backlog(sk, total_moved, &skbs)) {
> +		mptcp_data_unlock(sk);
> +		enqueued |= __mptcp_move_skbs(sk, &skbs, &moved);
> +
> +		mptcp_data_lock(sk);
> +		total_moved += moved;
> +		mptcp_backlog_spooled(sk, moved, &skbs);
> +	}
> +	mptcp_data_unlock(sk);
> +	return enqueued;
>  }
>  
>  static unsigned int mptcp_inq_hint(const struct sock *sk)
> @@ -2254,7 +2285,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>  
>  		copied += bytes_read;
>  
> -		if (skb_queue_empty(&sk->sk_receive_queue) && __mptcp_move_skbs(sk))
> +		if (!list_empty(&msk->backlog_list) && mptcp_move_skbs(sk))
>  			continue;
>  
>  		/* only the MPTCP socket status is relevant here. The exit
> @@ -3521,20 +3552,22 @@ void __mptcp_check_push(struct sock *sk, struct sock *ssk)
>  
>  #define MPTCP_FLAGS_PROCESS_CTX_NEED (BIT(MPTCP_PUSH_PENDING) | \
>  				      BIT(MPTCP_RETRANSMIT) | \
> -				      BIT(MPTCP_FLUSH_JOIN_LIST) | \
> -				      BIT(MPTCP_DEQUEUE))
> +				      BIT(MPTCP_FLUSH_JOIN_LIST))
>  
>  /* processes deferred events and flush wmem */
>  static void mptcp_release_cb(struct sock *sk)
>  	__must_hold(&sk->sk_lock.slock)
>  {
>  	struct mptcp_sock *msk = mptcp_sk(sk);
> +	u32 moved, total_moved = 0;
>  
>  	for (;;) {
>  		unsigned long flags = (msk->cb_flags & MPTCP_FLAGS_PROCESS_CTX_NEED);
> -		struct list_head join_list;
> +		struct list_head join_list, skbs;
> +		bool spool_bl;
>  
> -		if (!flags)
> +		spool_bl = mptcp_can_spool_backlog(sk, total_moved, &skbs);
> +		if (!flags && !spool_bl)
>  			break;
>  
>  		INIT_LIST_HEAD(&join_list);
> @@ -3550,20 +3583,26 @@ static void mptcp_release_cb(struct sock *sk)
>  		msk->cb_flags &= ~flags;
>  		spin_unlock_bh(&sk->sk_lock.slock);
>  
> +		if (total_moved)
> +			cond_resched();
> +
>  		if (flags & BIT(MPTCP_FLUSH_JOIN_LIST))
>  			__mptcp_flush_join_list(sk, &join_list);
>  		if (flags & BIT(MPTCP_PUSH_PENDING))
>  			__mptcp_push_pending(sk, 0);
>  		if (flags & BIT(MPTCP_RETRANSMIT))
>  			__mptcp_retrans(sk);
> -		if ((flags & BIT(MPTCP_DEQUEUE)) && __mptcp_move_skbs(sk)) {
> +		if (spool_bl && __mptcp_move_skbs(sk, &skbs, &moved)) {
>  			/* notify ack seq update */
>  			mptcp_cleanup_rbuf(msk, 0);
>  			sk->sk_data_ready(sk);
>  		}
>  
> -		cond_resched();
>  		spin_lock_bh(&sk->sk_lock.slock);
> +		if (spool_bl) {
> +			total_moved += moved;
> +			mptcp_backlog_spooled(sk, moved, &skbs);
> +		}
>  	}
>  
>  	if (__test_and_clear_bit(MPTCP_CLEAN_UNA, &msk->cb_flags))
> @@ -3796,7 +3835,7 @@ static int mptcp_ioctl(struct sock *sk, int cmd, int *karg)
>  			return -EINVAL;
>  
>  		lock_sock(sk);
> -		if (__mptcp_move_skbs(sk))
> +		if (mptcp_move_skbs(sk))
>  			mptcp_cleanup_rbuf(msk, 0);
>  		*karg = mptcp_inq_hint(sk);
>  		release_sock(sk);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index d814e8151458d5..9e2a44546354a0 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -124,7 +124,6 @@
>  #define MPTCP_FLUSH_JOIN_LIST	5
>  #define MPTCP_SYNC_STATE	6
>  #define MPTCP_SYNC_SNDBUF	7
> -#define MPTCP_DEQUEUE		8
>  
>  struct mptcp_skb_cb {
>  	u64 map_seq;
> @@ -301,6 +300,7 @@ struct mptcp_sock {
>  	u32		last_ack_recv;
>  	unsigned long	timer_ival;
>  	u32		token;
> +	u32		borrowed_mem;
>  	unsigned long	flags;
>  	unsigned long	cb_flags;
>  	bool		recovery;		/* closing subflow write queue reinjected */

