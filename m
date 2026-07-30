Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566863644C9
	for <mptcp@lists.linux.dev>; Thu, 30 Jul 2026 01:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785375164; cv=none; b=Cf3OYLCV1ZXlbc083DWBK6CJp8c529RjoeXafhTpmK3KSa+40QPG35+nk5R//WJXMddjGI6qBlGFsJ0+2HNbDyUEn0lXwsfphH0eqUrMvM5ca4wu5IeqqEN71CsDwikXQUl4hCFl54+BQK0W1wyweHIAhBTytzkMCbLEwgnw2OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785375164; c=relaxed/simple;
	bh=4vYHGEX2lZyTfYNbSiVZmscmBWMSMJm+tT0o/fwowuc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ImPKxnI6FRyS6Kvp5kldRvDoAJZD1vsaGJWl0wgU8CUotvEmhBhPXpzNH10pZwi22LqILdLMBe3DeYRkRYRMitbZxt0p06s7ItnchDp99DpWcPTt+61TPwFyj8KpX2t/IEuEZxwPuwm1dlbgQrF5EPJmxVEFCzcQew9RfNH//8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UuWl1Y7n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuWl1Y7n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866A31F000E9;
	Thu, 30 Jul 2026 01:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785375161;
	bh=reVoKpv32DOkZyUvPy9h+W1A2WKTlSA8msWDNCkjRtg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UuWl1Y7nDm78SsZ7sIHmx+hfJlxlc/kX1HsHQA4xv9Hb3m742anGGwVQo2MrV103Y
	 aLm1BcYCi5ys2CWqR88ALT6koGzuDGHO/W+LmZH/mLxgJCFbydcJ0PqYmxq7EEwLN8
	 VAw4ermbW88b7o3LXKiWj5v1Uw6cpVVySCv4pCNcQkcrhIxeGBuoDPnMt4kfbTyuuv
	 WyOAdyOXxCRMaMvIMs4fGRxphhxFRqOid1XaqPjfdEcuLhzMaK1hRuXWuZhHPEj4G/
	 uus4eZEnlpMVKnGsY2SvfHEkzCkeNuBZFA61hAWnlHH76aUc/LTo9GLTSUEsvwlawN
	 zSU8LoL+ybDhA==
Message-ID: <7a48107cdf8184b2314ea5c8dde1ea99e36c8240.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 3/6] mptcp: remove CB offset field
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>
Date: Thu, 30 Jul 2026 09:32:34 +0800
In-Reply-To: <ac89aa00bb102ab121e9090a353b6dc452f5fb43.1785150300.git.tanggeliang@kylinos.cn>
References: <cover.1785150300.git.tanggeliang@kylinos.cn>
	 <ac89aa00bb102ab121e9090a353b6dc452f5fb43.1785150300.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Paolo,

On Mon, 2026-07-27 at 19:29 +0800, Geliang Tang wrote:
> From: Paolo Abeni <pabeni@redhat.com>
> 
> Instead, use a new msk-level field to track the bytes already
> consumed
> inside each skb, carrying the amount of bytes already copied to
> user-space, alike what TCP is already doing.
> 
> The newly introduce `copied_seq` field is always accessed under the
> msk
> socket lock, delegating the synchronization with IASN to the msk
> release
> CB, when the socket is owned by the user-space at remote key
> reception
> time. Such synchronization preserves any partial progress (copy) made
> on
> the TFO packet.
> 
> Note that the explicit synchronization in __mptcp_move_skb() is
> needed to
> ensure that the TFO skb in the receive queue got its map_seq synched
> before the next skb lands into the receive queue when spooling the
> backlog
> at mptcp_release_cb() time, as the release CB synchronization will
> happen
> later.
> 
> Prior to this patch, the TFO skb dummy mapping was always ignored,
> now it
> affects the `copied_seq` initial update: be sure to extends the sign
> correctly of such mapping initialization time.
> 
> Overall this simplify a bit the __mptcp_recvmsg_mskq(),
> mptcp_inq_hint()
> and the __mptcp_move_skb() code and will also make possible the next
> patch.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/mptcp/fastopen.c |  15 ++++--
>  net/mptcp/protocol.c | 126 +++++++++++++++++++----------------------
> --
>  net/mptcp/protocol.h |   8 ++-
>  net/mptcp/subflow.c  |   7 ++-
>  4 files changed, 77 insertions(+), 79 deletions(-)
> 
> diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
> index d6895c2200cc..421a50a85547 100644
> --- a/net/mptcp/fastopen.c
> +++ b/net/mptcp/fastopen.c
> @@ -9,6 +9,7 @@
>  void mptcp_fastopen_subflow_synack_set_params(struct
> mptcp_subflow_context *subflow,
>  					      struct request_sock
> *req)
>  {
> +	struct mptcp_sock *msk;
>  	struct sock *sk, *ssk;
>  	struct sk_buff *skb;
>  	struct tcp_sock *tp;
> @@ -44,20 +45,24 @@ void
> mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context
> *subf
>  	subflow->ssn_offset += skb->len;
>  	has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
>  
> -	/* Only the sequence delta is relevant */
> -	MPTCP_SKB_CB(skb)->map_seq = -skb->len;
> +	/* The TFO segment data sits before the IASN; before
> receiving
> +	 * the remote key, IASN is assumed being 0.
> +	 */
> +	MPTCP_SKB_CB(skb)->map_seq = -(u64)skb->len;
>  	MPTCP_SKB_CB(skb)->end_seq = 0;
> -	MPTCP_SKB_CB(skb)->offset = 0;
>  	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
>  
>  	mptcp_data_lock(sk);
>  	DEBUG_NET_WARN_ON_ONCE(sock_owned_by_user_nocheck(sk));
>  
> -	mptcp_sk(sk)->rcvd_dummy_seq = true;
> +	msk = mptcp_sk(sk);
> +	msk->rcvd_dummy_seq = true;
> +	msk->copied_seq = MPTCP_SKB_CB(skb)->map_seq;
> +	msk->tfo_skb_len = skb->len;
>  	mptcp_borrow_fwdmem(sk, skb);
>  	skb_set_owner_r(skb, sk);
>  	__skb_queue_tail(&sk->sk_receive_queue, skb);
> -	mptcp_sk(sk)->bytes_received += skb->len;
> +	msk->bytes_received += skb->len;
>  
>  	sk->sk_data_ready(sk);
>  
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index c0b6e312816f..74a426bf6680 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -28,7 +28,7 @@
>  #include "protocol.h"
>  #include "mib.h"
>  
> -static unsigned int mptcp_inq_hint(const struct sock *sk);
> +static unsigned int mptcp_inq_hint(struct sock *sk);
>  
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/mptcp.h>
> @@ -160,7 +160,6 @@ static bool __mptcp_try_coalesce(struct sock *sk,
> struct sk_buff *to,
>  	int limit = READ_ONCE(sk->sk_rcvbuf);
>  
>  	if (MPTCP_SKB_CB(from)->map_seq != MPTCP_SKB_CB(to)->end_seq
> ||
> -	    MPTCP_SKB_CB(from)->offset ||
>  	    ((to->len + from->len) > (limit >> 3)) ||
>  	    !skb_try_coalesce(to, from, fragstolen, delta))
>  		return false;
> @@ -342,8 +341,7 @@ static void mptcp_data_queue_ofo(struct
> mptcp_sock *msk, struct sk_buff *skb)
>  	skb_set_owner_r(skb, sk);
>  }
>  
> -static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb,
> int offset,
> -			   int copy_len)
> +static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb,
> int offset)
>  {
>  	struct mptcp_subflow_context *subflow =
> mptcp_subflow_ctx(ssk);
>  	bool has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
> @@ -352,9 +350,9 @@ static void mptcp_init_skb(struct sock *ssk,
> struct sk_buff *skb, int offset,
>  	 * mptcp_subflow_get_mapped_dsn() is based on the current
> tp->copied_seq
>  	 * value
>  	 */
> -	MPTCP_SKB_CB(skb)->map_seq =
> mptcp_subflow_get_mapped_dsn(subflow);
> -	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq +
> copy_len;
> -	MPTCP_SKB_CB(skb)->offset = offset;
> +	MPTCP_SKB_CB(skb)->map_seq =
> mptcp_subflow_get_mapped_dsn(subflow) -
> +				     offset;
> +	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq +
> skb->len;
>  	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
>  
>  	__skb_unlink(skb, &ssk->sk_receive_queue);
> @@ -420,8 +418,8 @@ void __mptcp_sync_rcv_sequence(struct sock *sk)
>  	if (!skb)
>  		return;
>  
> -	MPTCP_SKB_CB(skb)->map_seq = msk->ack_seq - skb->len;
> -	MPTCP_SKB_CB(skb)->end_seq = msk->ack_seq;
> +	MPTCP_SKB_CB(skb)->map_seq = mptcp_iasn(msk) - skb->len;
> +	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq +
> skb->len;
>  }
>  
>  static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)

Here Sashiko complained that the fastopen code does not update
msk->copied_seq:

	/* Be sure to sync the eventual fastopen dummy mapping before
	 * any other skb lands into the msk.
	 */
	if (unlikely(msk->rcvd_dummy_seq))
		__mptcp_sync_rcv_sequence(sk);

So I changed it to in v2:

        if (unlikely(msk->rcvd_dummy_seq)) {
                msk->copied_seq += mptcp_iasn(msk);
                __mptcp_sync_rcv_sequence(sk);
                /* Release cb() would otherwise re-base copied_seq
                 * again.
                 */
                test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags);
        }

I'm not sure if this change is correct.

> @@ -450,6 +448,7 @@ static bool __mptcp_move_skb(struct sock *sk,
> struct sk_buff *skb)
>  	}
>  
>  	if (MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq) {
> +add_queue:
>  		/* in sequence */
>  		msk->bytes_received += copy_len;
>  		WRITE_ONCE(msk->ack_seq, msk->ack_seq + copy_len);
> @@ -463,28 +462,18 @@ static bool __mptcp_move_skb(struct sock *sk,
> struct sk_buff *skb)
>  	} else if (after64(MPTCP_SKB_CB(skb)->map_seq, msk-
> >ack_seq)) {
>  		mptcp_data_queue_ofo(msk, skb);
>  		return false;
> -	}
> +	} else if (after64(MPTCP_SKB_CB(skb)->end_seq, msk-
> >ack_seq)) {
> +		/* Partial packet: map_seq < ack_seq < end_seq. */
> +		int delta = msk->ack_seq - MPTCP_SKB_CB(skb)-
> >map_seq;
>  
> -	/* Completely old data? */
> -	if (!after64(MPTCP_SKB_CB(skb)->end_seq, msk->ack_seq)) {
> -		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
> -		mptcp_drop(sk, skb);
> -		return false;
> +		copy_len -= delta;
> +		goto add_queue;
>  	}
>  
> -	/* Partial packet: map_seq < ack_seq < end_seq.
> -	 * Skip the already-acked bytes and enqueue the new data.
> -	 */
> -	copy_len = MPTCP_SKB_CB(skb)->end_seq - msk->ack_seq;
> -	MPTCP_SKB_CB(skb)->offset += msk->ack_seq -
> MPTCP_SKB_CB(skb)->map_seq;
> -	MPTCP_SKB_CB(skb)->map_seq += msk->ack_seq -
> -				      MPTCP_SKB_CB(skb)->map_seq;
> -	msk->bytes_received += copy_len;
> -	WRITE_ONCE(msk->ack_seq, msk->ack_seq + copy_len);
> -
> -	skb_set_owner_r(skb, sk);
> -	__skb_queue_tail(&sk->sk_receive_queue, skb);
> -	return true;
> +	/* Completely old data. */
> +	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
> +	mptcp_drop(sk, skb);
> +	return false;
>  }
>  
>  static void mptcp_stop_rtx_timer(struct sock *sk)
> @@ -829,7 +818,7 @@ static bool __mptcp_move_skbs_from_subflow(struct
> mptcp_sock *msk,
>  		if (offset < skb->len) {
>  			size_t len = skb->len - offset;
>  
> -			mptcp_init_skb(ssk, skb, offset, len);
> +			mptcp_init_skb(ssk, skb, offset);
>  
>  			if (own_msk) {
>  				mptcp_subflow_lend_fwdmem(subflow,
> skb);
> @@ -896,8 +885,6 @@ static bool __mptcp_ofo_queue(struct mptcp_sock
> *msk)
>  			pr_debug("uncoalesced seq=%llx ack seq=%llx
> delta=%d\n",
>  				 MPTCP_SKB_CB(skb)->map_seq, msk-
> >ack_seq,
>  				 delta);
> -			MPTCP_SKB_CB(skb)->offset += delta;
> -			MPTCP_SKB_CB(skb)->map_seq += delta;
>  			__skb_queue_tail(&sk->sk_receive_queue,
> skb);
>  		}
>  		msk->bytes_received += end_seq - msk->ack_seq;
> @@ -2134,34 +2121,23 @@ static void mptcp_eat_recv_skb(struct sock
> *sk, struct sk_buff *skb)
>  }
>  
>  static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
> -				size_t len, int flags, int
> copied_total,
> +				size_t len, int flags, u64 *seq,
>  				struct scm_timestamping_internal
> *tss,
>  				int *cmsg_flags, struct sk_buff
> **last)
>  {
>  	struct mptcp_sock *msk = mptcp_sk(sk);
>  	struct sk_buff *skb, *tmp;
> -	int total_data_len = 0;
>  	int copied = 0;
>  
>  	skb_queue_walk_safe(&sk->sk_receive_queue, skb, tmp) {
> -		u32 delta, offset = MPTCP_SKB_CB(skb)->offset;
> +		u64 offset = *seq - MPTCP_SKB_CB(skb)->map_seq;
>  		u32 data_len = skb->len - offset;
>  		u32 count;
>  		int err;
>  
> -		if (flags & MSG_PEEK) {
> -			/* skip already peeked skbs */
> -			if (total_data_len + data_len <=
> copied_total) {
> -				total_data_len += data_len;
> -				*last = skb;
> -				continue;
> -			}
> -
> -			/* skip the already peeked data in the
> current skb */
> -			delta = copied_total - total_data_len;
> -			offset += delta;
> -			data_len -= delta;
> -		}
> +		/* Skip the already peeked data. */
> +		if (offset >= skb->len)
> +			continue;

And here Sashiko complained about a risk of an infinite loop. So in the
next version, v2, I added *last = skb here:

                /* Skip the already peeked data. */
                if (offset >= skb->len) {
                        *last = skb;
                        continue;
                }

Please give me some feedback.

Thanks,
-Geliang

>  
>  		count = min_t(size_t, len - copied, data_len);
>  		if (!(flags & MSG_TRUNC)) {
> @@ -2179,14 +2155,12 @@ static int __mptcp_recvmsg_mskq(struct sock
> *sk, struct msghdr *msg,
>  		}
>  
>  		copied += count;
> +		*seq += count;
>  
>  		if (!(flags & MSG_PEEK)) {
>  			msk->bytes_consumed += count;
> -			if (count < data_len) {
> -				MPTCP_SKB_CB(skb)->offset += count;
> -				MPTCP_SKB_CB(skb)->map_seq += count;
> +			if (count < data_len)
>  				break;
> -			}
>  
>  			mptcp_eat_recv_skb(sk, skb);
>  		} else {
> @@ -2339,25 +2313,23 @@ static bool mptcp_move_skbs(struct sock *sk)
>  	return enqueued;
>  }
>  
> -static unsigned int mptcp_inq_hint(const struct sock *sk)
> +static unsigned int mptcp_inq_hint(struct sock *sk)
>  {
>  	const struct mptcp_sock *msk = mptcp_sk(sk);
> -	const struct sk_buff *skb;
> -
> -	skb = skb_peek(&sk->sk_receive_queue);
> -	if (skb) {
> -		u64 hint_val = READ_ONCE(msk->ack_seq) -
> MPTCP_SKB_CB(skb)->map_seq;
> +	u64 hint_val;
>  
> -		if (hint_val >= INT_MAX)
> -			return INT_MAX;
> -
> -		return (unsigned int)hint_val;
> -	}
> +	/* Avoid races vs ack_seq updates. */
> +	mptcp_data_lock(sk);
> +	hint_val = msk->ack_seq - msk->copied_seq;
> +	mptcp_data_unlock(sk);
> +	if (hint_val >= INT_MAX)
> +		return INT_MAX;
>  
> -	if (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown &
> RCV_SHUTDOWN))
> +	if (!hint_val &&
> +	    (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown &
> RCV_SHUTDOWN)))
>  		return 1;
>  
> -	return 0;
> +	return (unsigned int)hint_val;
>  }
>  
>  static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t
> len,
> @@ -2366,6 +2338,7 @@ static int mptcp_recvmsg(struct sock *sk,
> struct msghdr *msg, size_t len,
>  	struct mptcp_sock *msk = mptcp_sk(sk);
>  	struct scm_timestamping_internal tss;
>  	int copied = 0, cmsg_flags = 0;
> +	u64 peek_seq, *seq;
>  	int target;
>  	long timeo;
>  
> @@ -2385,6 +2358,11 @@ static int mptcp_recvmsg(struct sock *sk,
> struct msghdr *msg, size_t len,
>  
>  	len = min_t(size_t, len, INT_MAX);
>  	target = sock_rcvlowat(sk, flags & MSG_WAITALL, len);
> +	seq = &msk->copied_seq;
> +	if (flags & MSG_PEEK) {
> +		peek_seq = msk->copied_seq;
> +		seq = &peek_seq;
> +	}
>  
>  	if (unlikely(msk->recvmsg_inq))
>  		cmsg_flags = MPTCP_CMSG_INQ;
> @@ -2394,7 +2372,7 @@ static int mptcp_recvmsg(struct sock *sk,
> struct msghdr *msg, size_t len,
>  		int err, bytes_read;
>  
>  		bytes_read = __mptcp_recvmsg_mskq(sk, msg, len -
> copied, flags,
> -						  copied, &tss,
> &cmsg_flags,
> +						  seq, &tss,
> &cmsg_flags,
>  						  &last);
>  		if (unlikely(bytes_read < 0)) {
>  			if (!copied)
> @@ -2449,6 +2427,10 @@ static int mptcp_recvmsg(struct sock *sk,
> struct msghdr *msg, size_t len,
>  			err = copied ? : err;
>  			goto out_err;
>  		}
> +
> +		/* Recompute peek offset after eventual seq resync.
> */
> +		if (flags & MSG_PEEK)
> +			peek_seq = msk->copied_seq + copied;
>  	}
>  
>  	mptcp_cleanup_rbuf(msk, copied);
> @@ -3626,11 +3608,13 @@ static int mptcp_disconnect(struct sock *sk,
> int flags)
>  	msk->bytes_retrans = 0;
>  	msk->rcvspace_init = 0;
>  	msk->fastclosing = 0;
> +	msk->tfo_skb_len = 0;
>  	mptcp_init_rtt_est(msk);
>  
>  	/* for fallback's sake */
>  	WRITE_ONCE(msk->ack_seq, 0);
>  	atomic64_set(&msk->rcv_wnd_sent, 0);
> +	msk->copied_seq = 0;
>  
>  	WRITE_ONCE(sk->sk_shutdown, 0);
>  	sk_error_report(sk);
> @@ -3855,8 +3839,10 @@ static void mptcp_release_cb(struct sock *sk)
>  			__mptcp_error_report(sk);
>  		if (__test_and_clear_bit(MPTCP_SYNC_SNDBUF, &msk-
> >cb_flags))
>  			__mptcp_sync_sndbuf(sk);
> -		if (__test_and_clear_bit(MPTCP_SYNC_SEQ, &msk-
> >cb_flags))
> +		if (__test_and_clear_bit(MPTCP_SYNC_SEQ, &msk-
> >cb_flags)) {
> +			msk->copied_seq += mptcp_iasn(msk);
>  			__mptcp_sync_rcv_sequence(sk);
> +		}
>  	}
>  }
>  
> @@ -4517,7 +4503,7 @@ static struct sk_buff *mptcp_recv_skb(struct
> sock *sk, u32 *off)
>  		mptcp_move_skbs(sk);
>  
>  	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
> -		offset = MPTCP_SKB_CB(skb)->offset;
> +		offset = msk->copied_seq - MPTCP_SKB_CB(skb)-
> >map_seq;
>  		if (offset < skb->len) {
>  			*off = offset;
>  			return skb;
> @@ -4559,11 +4545,9 @@ static int __mptcp_read_sock(struct sock *sk,
> read_descriptor_t *desc,
>  		copied += count;
>  
>  		msk->bytes_consumed += count;
> -		if (count < data_len) {
> -			MPTCP_SKB_CB(skb)->offset += count;
> -			MPTCP_SKB_CB(skb)->map_seq += count;
> +		msk->copied_seq += count;
> +		if (count < data_len)
>  			break;
> -		}
>  
>  		mptcp_eat_recv_skb(sk, skb);
>  		if (!desc->count)
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 19b6eafece71..730af40ec9bc 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -129,7 +129,6 @@
>  struct mptcp_skb_cb {
>  	u64 map_seq;
>  	u64 end_seq;
> -	u32 offset;
>  	u8  has_rxtstamp;
>  };
>  
> @@ -289,6 +288,7 @@ struct mptcp_sock {
>  	u64		bytes_sent;
>  	u64		snd_nxt;
>  	u64		bytes_received;
> +	u64		copied_seq;
>  	u64		ack_seq;
>  	atomic64_t	rcv_wnd_sent;
>  	u64		rcv_data_fin_seq;
> @@ -308,6 +308,7 @@ struct mptcp_sock {
>  	u32		last_ack_recv;
>  	unsigned long	timer_ival;
>  	u32		token;
> +	u32		tfo_skb_len;
>  	unsigned long	flags;
>  	unsigned long	cb_flags;
>  	bool		rcvd_dummy_seq;
> @@ -860,6 +861,11 @@ struct sock *mptcp_subflow_get_retrans(struct
> mptcp_sock *msk);
>  int mptcp_sched_get_send(struct mptcp_sock *msk);
>  int mptcp_sched_get_retrans(struct mptcp_sock *msk);
>  
> +static inline u64 mptcp_iasn(const struct mptcp_sock *msk)
> +{
> +	return msk->ack_seq - msk->bytes_received + msk-
> >tfo_skb_len;
> +}
> +
>  static inline u64 mptcp_data_avail(const struct mptcp_sock *msk)
>  {
>  	return READ_ONCE(msk->bytes_received) - READ_ONCE(msk-
> >bytes_consumed);
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index ea9b697c0300..d0af5cb6f1b3 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -499,10 +499,13 @@ static void subflow_set_remote_key(struct
> mptcp_sock *msk,
>  	WRITE_ONCE(msk->can_ack, true);
>  	atomic64_set(&msk->rcv_wnd_sent, subflow->iasn);
>  
> -	if (!sock_owned_by_user(sk))
> +	if (!sock_owned_by_user(sk)) {
> +		/* User space could have already read partially the
> TFO skb */
> +		msk->copied_seq += subflow->iasn;
>  		__mptcp_sync_rcv_sequence(sk);
> -	else
> +	} else {
>  		__set_bit(MPTCP_SYNC_SEQ, &msk->cb_flags);
> +	}
>  }
>  
>  static void mptcp_propagate_state(struct sock *sk, struct sock *ssk,
