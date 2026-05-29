Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3842031F9B3
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 13:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780061225; cv=none; b=gdlTK3UOCaUT7tJVWdE3Vlb7D1bOaZPHGrlVwy4+Eot5KHSAwq85sMQyH3C+l6JyP+1f9lSTPlUxxtYFtX5iDBdE6BpVL1fc3/6LqnUDHU6GwOXevTJvO9WrNcbtmQ4eaavp3ydPkhiZ+b1EiPBjMBSYmuIXjzkAJE/f46TuqBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780061225; c=relaxed/simple;
	bh=QxaObgIICADmL1fwr8smD3bJ5Oo8I10qwjXnsoVDqrA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NLJyat/pHjyWd+zZRAZg+M3cxodUQ/O7YGNiFhd1gUkGxy6JklG+RDvVY5V48RgfdtyfGN6gEQZo6/FEOfJqHBmpcbVjXBGxZitfpdOTuD2FLWs6gG8fBdsLDHongsb+gss1g8K4Kgz17YTED3y1bjiBhWHTnDktDPKhulU2pvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFHzfajc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFHzfajc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B1A1F00893;
	Fri, 29 May 2026 13:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780061223;
	bh=OUp/dM1XC4UOs3Ko7uKH/FZxjPSoGUM/B+4hyDiEb+0=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=bFHzfajc3SEHwE/3MwAUHDPW6zxbcbA+6OxM5snJNgD0u7W553BLM4l+GWK5RVGv3
	 fkH3RJYT+VH9A0e9o3Vga3rVelO2/RUtfy3L0bEqGUZTcIxUpZhHMRwg8JwSYuyDMI
	 IphvJwI1oK+rmxU3xwFz3OBubBHqrwFuMaoaFY+lhWgwDCcG1qrtIIxNeSVRYuLDcg
	 AeFOMwjsI02U6g8SxQu1Y1rNxAayvf0eRopQEkIwZaLh94FjgkMhLjgHobmuBau3y2
	 AjhukOZcVUG960f7S9UB7urlsf3hEwrn9PgHYqFpU+Xn5wMXd0GY06vie5g29Mb1um
	 XRWqpax3tkILw==
Message-ID: <61de072a8e750ec6c7d7228cca6d7d55885e0abf.camel@kernel.org>
Subject: Re: [PATCH v10 mptcp-next 3/3] mptcp: let the retrans scheduler do
 its job.
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Date: Fri, 29 May 2026 21:27:00 +0800
In-Reply-To: <199d3b27cc1f092a1bca686963103f922d0d27cd.1780049797.git.pabeni@redhat.com>
References: <cover.1780049797.git.pabeni@redhat.com>
	 <199d3b27cc1f092a1bca686963103f922d0d27cd.1780049797.git.pabeni@redhat.com>
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

On Fri, 2026-05-29 at 12:44 +0200, Paolo Abeni wrote:
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
> v9 -> v10:
>   - simpler handling for data-fin rtx
> 
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
>  - sashiko may see issues when dfrag = mptcp_rtx_head(sk) != NULL and
>    dfrag->already_sent == 0. That condition should not possible: if
>    mptcp_rtx_head() is not NULL there should be some data already
>    sent.
>  - sashiko may see missing data-fin rtx when the initial `dfrag` is
>    not NULL. data-fin RTX is NOT needed in such scenario.
> ---
>  net/mptcp/protocol.c | 119 +++++++++++++++++++++++++++++++----------
> --
>  1 file changed, 87 insertions(+), 32 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 51756800edc2..7fe618e22d1b 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1201,13 +1201,6 @@ static void __mptcp_clean_una_wakeup(struct
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
> @@ -2830,8 +2823,12 @@ static void mptcp_check_fastclose(struct
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
> @@ -2841,6 +2838,7 @@ static int __mptcp_push_retrans(struct sock
> *sk, struct mptcp_data_frag *dfrag)
>  
>  	mptcp_for_each_subflow(msk, subflow) {
>  		if (READ_ONCE(subflow->scheduled)) {
> +			u16 offset = sent_seq - dfrag->data_seq;
>  			u16 copied = 0;
>  
>  			mptcp_subflow_set_scheduled(subflow, false);
> @@ -2850,9 +2848,12 @@ static int __mptcp_push_retrans(struct sock
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

Same as I reported in v8 of this patch [1], when testing based on v10 I
encountered the following error:

# Starting 4 threads
[  879.268966][ T4341] ------------[ cut here ]------------
[  879.269413][ T4341] !before64(sent_seq, dfrag->data_seq +
info.limit)
[  879.269417][ T4341] WARNING: net/mptcp/protocol.c:2883 at
__mptcp_push_retrans+0x562/0x6f0, CPU#18: kworker/18:6H/4341
[  879.271883][ T4341] Modules linked in: mptcp_diag tcp_diag inet_diag
sch_netem
[  879.272450][ T4341] CPU: 18 UID: 0 PID: 4341 Comm: kworker/18:6H Not
tainted 7.1.0-rc5+ #94 PREEMPT(full) 
[  879.272813][ T4341] Hardware name: Bochs Bochs, BIOS Bochs
01/01/2011
[  879.273225][ T4341] Workqueue: nvmet_tcp_wq nvmet_tcp_io_work
[  879.273527][ T4341] RIP: 0010:__mptcp_push_retrans+0x562/0x6f0

Thanks,
-Geliang

[1]
https://patchwork.kernel.org/project/mptcp/patch/a35934164aad8a08ed8108853cff7a282e5c25ef.1779485511.git.pabeni@redhat.com/

>  
>  			/*
>  			 * make the whole retrans decision, xmit,
> disallow
> @@ -2896,14 +2897,85 @@ static void __mptcp_retrans(struct sock *sk)
>  	struct mptcp_sock *msk = mptcp_sk(sk);
>  	struct mptcp_subflow_context *subflow;
>  	struct mptcp_data_frag *dfrag;
> +	bool need_retrans;
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
> -	if (!dfrag) {
> +	need_retrans = !!dfrag;
> +	mptcp_data_unlock(sk);
> +	if (!dfrag)
> +		goto check_data_fin;
> +
> +	for (;;) {
> +		bool already_retrans;
> +		u64 sent_seq;
> +
> +		/* The default scheduler will kick "stale" logic,
> that in
> +		 * turn can process incoming acks and clean the RTX
> queue;
> +		 * ensure that the current dfrag will still be
> around
> +		 * afterwards.
> +		 */
> +		get_page(dfrag->page);
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
> +			need_retrans = !!dfrag;
> +		} else if (after64(msk->snd_una, retrans_seq)) {
> +			retrans_seq = msk->snd_una;
> +		}
> +		mptcp_data_unlock(sk);
> +		if (!dfrag)
> +			break;
> +
> +		/* Can fail only in case of fallback. */
> +		len = __mptcp_push_retrans(sk, dfrag, retrans_seq);
> +		if (len < 0)
> +			goto clear_scheduled;
> +
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
> +			WRITE_ONCE(msk->snd_nxt, sent_seq);
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
> +	/* Attempt data-fin retransmission only when the RTX queue
> is empty. */
> +	if (!need_retrans) {
> +check_data_fin:
>  		if (mptcp_data_fin_enabled(msk)) {
>  			struct inet_connection_sock *icsk =
> inet_csk(sk);
>  
> @@ -2911,30 +2983,13 @@ static void __mptcp_retrans(struct sock *sk)
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
> -		WRITE_ONCE(msk->snd_nxt, dfrag->already_sent +
> dfrag->data_seq);
> -
>  reset_timer:
>  	mptcp_check_and_set_pending(sk);
>  
