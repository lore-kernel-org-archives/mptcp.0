Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D36319E96D
	for <mptcp@lists.linux.dev>; Wed, 27 May 2026 05:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779860823; cv=none; b=ncXyypN/GBblP1TP3CmTYp2cIk/ZHc2dPJnLsXC2T9JA3qWvxScTxG35Z2J84m6Lj0v7tN8Qy3meESCDMYEd37CZJZ/wdzxs8rkkAhcAJEqItEl3HquJTuMsr066/DFOCALb37GaBR0ier8T31uxX/uZ5AYNMEmhdBtrbseKO5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779860823; c=relaxed/simple;
	bh=C1TMyBTJxj7pFDnjYu7jVPZAD84F7M7QxhahcezpxiI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bmf5z1TmWEQ5gjhWQVKCb+lfj7IjbvpabaTzqLFGgK/YtUoDyGPFgboDvttOcMWPthCPAkvJtCjzPzXFwtXDwUNWU+WK2viYgEi9bZftAcG5ONrnqSvWtIItnibYCKtiZzr4FLo7y+GOhv3mzfFMrD1Fmz0w4pDaIaQMVMF0j90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4xaSGL4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4xaSGL4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0EC1F000E9;
	Wed, 27 May 2026 05:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779860821;
	bh=djUP5a8Egha9nYN5xhOaXmGRsaq9qCFtm0JVVBjJZ50=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=e4xaSGL4NA/f4ti7hSgizLnXmI++sqn9oKgOgt2qG7HwuLxAuNVm/QYEjsnnEl9Nn
	 echRlhk5jhB5KA/AWwIuKyEN00z6ZGYxQ9gJnCM8pWNbPVSvMqCfcWASvC+Yi0AGN5
	 5xE0EV6+hyWu1ITTUhWc0iJxvF5F/ZtRONBd49uQKwEy3U+LzQ/IWtHcxg8ZA0MQBC
	 1GeLsDgapbqO7G/zr6MBioxb0UJxbiPie8n/iSaeWiQYIPiiGgtbRwo8iJ8jNUlkDB
	 aesC3yEMh/WQX5ihIsOqaeitWlZIv7OKghVezknJQSjQ5XxXY4/WQsq3aOQ1zYDzoB
	 eT79DHQ4NM8lA==
Message-ID: <52022434fe4b2996253b5fc2af7ea98aa987bcb5.camel@kernel.org>
Subject: Re: [PATCH v8 mptcp-next 9/9] mptcp: let the retrans scheduler do
 its job.
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>, gang.yan@linux.dev
Date: Wed, 27 May 2026 13:46:56 +0800
In-Reply-To: <a35934164aad8a08ed8108853cff7a282e5c25ef.1779485511.git.pabeni@redhat.com>
References: <cover.1779485511.git.pabeni@redhat.com>
	 <a35934164aad8a08ed8108853cff7a282e5c25ef.1779485511.git.pabeni@redhat.com>
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

On Fri, 2026-05-22 at 23:43 +0200, Paolo Abeni wrote:
> Currently the MPTCP core enforces that when MPTCP-level retrans timer
> fires, at most a single dfrag is retransmitted. If some corner-cases
> it
> may be necessary retransmit multiple dfrags, and the MPTCP socket
> will
> need to wait multiple retrans timeout to accomplish that.
> 
> Remove the mentioned constraint, allowing to transmit multiple dfrags
> per
> retrans period, as long as the scheduler keeps selecting subflows for
> retransmissions and pending data is available in the rtx queue.
> The default scheduler will transmit a dfrag per available subflow.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v7 -> v8
>   - fix corner-case retrans_seq update
> 
> v4 -> v5:
>   - fixed already_sent update
> 
> v3 -> v4:
>   - avoid quadratic behavior, fix retrans_seq update
>   - fix rtx timer re-schedule miss
> 
> v2 -> v3:
>   - fix infinite loop issue (should address tls tests failures)
> 
> v1 -> v2:
>   - fix retrans sequence update (sashiko)
> 
> Note:
>  - sashiko see issues when dfrag = mptcp_rtx_head(sk) != NULL and
>    dfrag->already_sent == 0. That condition should not possible: if
>    mptcp_rtx_head() is not NULL there should be some data already
>    sent.
> ---
>  net/mptcp/protocol.c | 117 +++++++++++++++++++++++++++++++----------
> --
>  1 file changed, 85 insertions(+), 32 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 4ebe45e8a3d2..892fc44dffac 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1197,13 +1197,6 @@ static void __mptcp_clean_una_wakeup(struct
> sock *sk)
>  	mptcp_write_space(sk);
>  }
>  
> -static void mptcp_clean_una_wakeup(struct sock *sk)
> -{
> -	mptcp_data_lock(sk);
> -	__mptcp_clean_una_wakeup(sk);
> -	mptcp_data_unlock(sk);
> -}
> -
>  static void mptcp_enter_memory_pressure(struct sock *sk)
>  {
>  	struct mptcp_subflow_context *subflow;
> @@ -2824,8 +2817,12 @@ static void mptcp_check_fastclose(struct
> mptcp_sock *msk)
>  	sk_error_report(sk);
>  }
>  
> -/* Retransmit the specified data fragment on all the selected
> subflows. */
> -static int __mptcp_push_retrans(struct sock *sk, struct
> mptcp_data_frag *dfrag)
> +/*
> + * Retransmit the specified data fragment on all the selected
> subflows,
> + * starting from the specified sequence
> + */
> +static int __mptcp_push_retrans(struct sock *sk, struct
> mptcp_data_frag *dfrag,
> +				u64 sent_seq)
>  {
>  	struct mptcp_sendmsg_info info = { .data_lock_held = true,
> };
>  	struct mptcp_sock *msk = mptcp_sk(sk);
> @@ -2835,6 +2832,7 @@ static int __mptcp_push_retrans(struct sock
> *sk, struct mptcp_data_frag *dfrag)
>  
>  	mptcp_for_each_subflow(msk, subflow) {
>  		if (READ_ONCE(subflow->scheduled)) {
> +			u16 offset = sent_seq - dfrag->data_seq;
>  			u16 copied = 0;
>  
>  			mptcp_subflow_set_scheduled(subflow, false);
> @@ -2844,9 +2842,12 @@ static int __mptcp_push_retrans(struct sock
> *sk, struct mptcp_data_frag *dfrag)
>  			lock_sock(ssk);
>  
>  			/* limit retransmission to the bytes already
> sent on some subflows */
> -			info.sent = 0;
> +			info.sent = offset;
>  			info.limit = READ_ONCE(msk->csum_enabled) ?
> dfrag->data_len :
>  								   
> dfrag->already_sent;
> +			DEBUG_NET_WARN_ON_ONCE(!before64(sent_seq,
> +							 dfrag-
> >data_seq +
> +							
> info.limit));

When I tested NVMe MPTCP TLS based on this series, I encountered the
following error:

 ------------[ cut here ]------------
 !before64(sent_seq, dfrag->data_seq + info.limit)
 WARNING: net/mptcp/protocol.c:2879 at
__mptcp_push_retrans+0x562/0x6f0, CPU#5: kworker/5:2H/823
 Modules linked in: mptcp_diag tcp_diag inet_diag sch_netem
 CPU: 5 UID: 0 PID: 823 Comm: kworker/5:2H Not tainted 7.1.0-rc4+ #11
PREEMPT(full)
 Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
 Workqueue: nvmet_tcp_wq nvmet_tcp_io_work
 RIP: 0010:__mptcp_push_retrans+0x562/0x6f0

I printed the "info.limit" value at that time and found it to be 0:

if (!before64(sent_seq, dfrag->data_seq + info.limit))
  pr_info("not ok sent_seq=%llu dfrag->data_seq=%llu info.limit=%u\n",
          sent_seq, dfrag->data_seq, info.limit);

# Starting 4 threads
[  358.532991][  T257] MPTCP: not ok sent_seq=4607903646123206498
dfrag->data_seq=4607903646123206498 info.limit=0
[  360.946058][   T90] MPTCP: not ok sent_seq=12604043601802564894
dfrag->data_seq=12604043601802564894 info.limit=0

It seems we need to remove this DEBUG_NET_WARN_ON_ONCE().

Thanks,
-Geliang

>  
>  			/*
>  			 * make the whole retrans decision, xmit,
> disallow
> @@ -2890,45 +2891,97 @@ static void __mptcp_retrans(struct sock *sk)
>  	struct mptcp_sock *msk = mptcp_sk(sk);
>  	struct mptcp_subflow_context *subflow;
>  	struct mptcp_data_frag *dfrag;
> +	bool retransmitted = false;
> +	u64 retrans_seq;
>  	int err, len;
>  
> -	mptcp_clean_una_wakeup(sk);
> -
> -	/* first check ssk: need to kick "stale" logic */
> -	err = mptcp_sched_get_retrans(msk);
> +	mptcp_data_lock(sk);
> +	__mptcp_clean_una_wakeup(sk);
> +	retrans_seq = msk->snd_una;
>  	dfrag = mptcp_rtx_head(sk);
> +	mptcp_data_unlock(sk);
> +	if (!dfrag)
> +		goto check_data_fin;
> +
> +	for (;;) {
> +		bool already_retrans;
> +		u64 sent_seq;
> +
> +		/* The scheduler may clean the RTX queue. */
> +		get_page(dfrag->page);
> +
> +		/* The default scheduler will kick "stale" logic. */
> +		err = mptcp_sched_get_retrans(msk);
> +		if (err) {
> +			put_page(dfrag->page);
> +			break;
> +		}
> +
> +		/* Incoming acks can have moved retrans sequence
> after
> +		 * the current dfrag, if so try to start again from
> RTX head.
> +		 */
> +		mptcp_data_lock(sk);
> +		already_retrans = !dfrag->already_sent ||
> +				  !before64(msk->snd_una, dfrag-
> >data_seq +
> +					    dfrag->already_sent);
> +		put_page(dfrag->page);
> +		if (already_retrans) {
> +			__mptcp_clean_una_wakeup(sk);
> +			retrans_seq = msk->snd_una;
> +			dfrag = mptcp_rtx_head(sk);
> +		} else if (after64(msk->snd_una, retrans_seq)) {
> +			retrans_seq = msk->snd_una;
> +		}
> +		mptcp_data_unlock(sk);
> +		if (!dfrag)
> +			break;
> +
> +		len = __mptcp_push_retrans(sk, dfrag, retrans_seq);
> +		if (len < 0)
> +			goto clear_scheduled;
> +
> +		retransmitted = true;
> +		retrans_seq += len;
> +		msk->bytes_retrans += len;
> +		dfrag->already_sent = max_t(u16, dfrag-
> >already_sent,
> +					    retrans_seq - dfrag-
> >data_seq);
> +
> +		/* With csum enabled retransmission can send new
> data. */
> +		sent_seq = dfrag->already_sent + dfrag->data_seq;
> +		if (after64(sent_seq, msk->snd_nxt))
> +			msk->snd_nxt = sent_seq;
> +
> +		/* Attempt the next fragment only if the current one
> is
> +		 * completely retransmitted.
> +		 */
> +		if (before64(retrans_seq, dfrag->data_seq + dfrag-
> >data_len))
> +			break;
> +
> +		dfrag = list_is_last(&dfrag->list, &msk->rtx_queue)
> ?
> +				NULL : list_next_entry(dfrag, list);
> +		if (!dfrag || !dfrag->already_sent)
> +			break;
> +	}
> +
> +	/* Data fin retransmission needed only if no data
> retransmission took
> +	 * place, and RTX queue is empty.
> +	 */
> +check_data_fin:
>  	if (!dfrag) {
> -		if (mptcp_data_fin_enabled(msk)) {
> +		if (!retransmitted && mptcp_data_fin_enabled(msk)) {
>  			struct inet_connection_sock *icsk =
> inet_csk(sk);
>  
>  			WRITE_ONCE(icsk->icsk_retransmits,
>  				   icsk->icsk_retransmits + 1);
>  			mptcp_set_datafin_timeout(sk);
>  			mptcp_send_ack(msk);
> -
>  			goto reset_timer;
>  		}
>  
>  		if (!mptcp_send_head(sk))
>  			goto clear_scheduled;
> -
> -		goto reset_timer;
>  	}
>  
> -	if (err)
> -		goto reset_timer;
> -
> -	len = __mptcp_push_retrans(sk, dfrag);
> -	if (len < 0)
> -		goto clear_scheduled;
> -
> -	msk->bytes_retrans += len;
> -	dfrag->already_sent = max(dfrag->already_sent, len);
> -
> -	/* With csum enabled retransmission can send new data. */
> -	if (after64(dfrag->already_sent + dfrag->data_seq, msk-
> >snd_nxt))
> -		msk->snd_nxt = dfrag->already_sent + dfrag-
> >data_seq;
> -
>  reset_timer:
>  	mptcp_check_and_set_pending(sk);
>  
