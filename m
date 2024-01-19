Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D6E81F
	for <mptcp@lists.linux.dev>; Fri, 19 Jan 2024 01:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705626218; cv=none; b=AXuAm0JGr2rlbUs5Ll+DUgNss1uoiRPhQhgmWaMFtg/0QwWa58t1W9ati5u0VkzeOaK5EeBZPLWOmfspWfZfgOf3fDXoYoBVbuvCzzS/rr9xNvrOFHaAPPcPRjHa5AkcLmUfVDYvvgg2CSfu0vVQ4BLGaoW6GyreHOTkIFp5uHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705626218; c=relaxed/simple;
	bh=5VJUB6HmKB9SPS7LH8jWbuLidmHO1YI1CFVYTzUzVvM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jDdHTeIF0WyeKNPD6Zn7TdQdsVsQfuGub9UsblzyPTWzHrsiXA+OSfSi9t5zcbS/m/2jQLydV1Ut5P2Pk88Vv4Z53K9WLXF1vi85r0om0DtLVkut0+RxpAZb77LILt0W0Mx+XC4zLxf/alifXwCpArUcZP7kRr8SMPFpK1zdQzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=scniTL6B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="scniTL6B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFFAC433C7;
	Fri, 19 Jan 2024 01:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705626218;
	bh=5VJUB6HmKB9SPS7LH8jWbuLidmHO1YI1CFVYTzUzVvM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=scniTL6BGueqNiNXzNx6Bp4//RiUwSSUkW0Vr7yhbpFI9UFdgyU/qXGir2CNGhn59
	 Pm8bdr5ZVA7UQaIfNl6Lv7b0qx9zMznaw9Q0KqJto/P47PC39yo/0CZHMFCzlIkppe
	 AWTktpYzedzny0LpgHoPC0UL7SUnGtSc7bqZS1m9g7lUJNBF2VA3yyDFBUdJTNE04C
	 u1zBAUG4axviK8PO9bLwwgmMee6xN+Zc9hivF0iaxBAx7Oy+qa3AkB/hAp0C1Bl19C
	 +vcbhMfQ59BAjX3Wfe1Eb7oH9sopWSXWF7cKzJOD4iPzStCexCZv1+CAZEeOourW/K
	 IafpWr/sknStg==
Date: Thu, 18 Jan 2024 17:03:37 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 2/5] mptcp: annotate lockless access for the
 tx path
In-Reply-To: <92930a7b962611507f4bb87671d97f526ece5952.1705427537.git.pabeni@redhat.com>
Message-ID: <348ef69e-3d3f-fb7d-2388-174ef14e3209@kernel.org>
References: <cover.1705427537.git.pabeni@redhat.com> <92930a7b962611507f4bb87671d97f526ece5952.1705427537.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 16 Jan 2024, Paolo Abeni wrote:

> The mptcp-level TX path info (write_seq, bytes_sent, snd_nxt) are under
> the msk socket lock protection, and are accessed lockless in a few spots.
>
> Always mark the write operations with WRITE_ONCE, read operations
> outside the lock with READ_ONCE and drop the annotation for read
> under such lock.
>
> To simplify the annotations move mptcp_pending_data_fin_ack() from
> __mptcp_data_acked() to __mptcp_clean_una(), under the msk socket
> lock, where such call would belong.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/options.c  |  2 +-
> net/mptcp/protocol.c | 14 ++++++--------
> net/mptcp/protocol.h |  2 +-
> 3 files changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index cebbd0bc32aa..51b00d7e7c89 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1061,7 +1061,7 @@ static void ack_update_msk(struct mptcp_sock *msk,
> 		msk->wnd_end = new_wnd_end;
>
> 	/* this assumes mptcp_incoming_options() is invoked after tcp_ack() */
> -	if (after64(msk->wnd_end, READ_ONCE(msk->snd_nxt)))
> +	if (after64(msk->wnd_end, snd_nxt))

Is it ok to remove this READ_ONCE()? The snd_nxt local is stored before 
the data_lock is acquired.

- Mat

> 		__mptcp_check_push(sk, ssk);
>
> 	if (after64(new_snd_una, old_snd_una)) {
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 9ad672a10c11..679d4576d2c1 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1033,13 +1033,14 @@ static void __mptcp_clean_una(struct sock *sk)
> 		msk->recovery = false;
>
> out:
> -	if (snd_una == READ_ONCE(msk->snd_nxt) &&
> -	    snd_una == READ_ONCE(msk->write_seq)) {
> +	if (snd_una == msk->snd_nxt && snd_una == msk->write_seq) {
> 		if (mptcp_rtx_timer_pending(sk) && !mptcp_data_fin_enabled(msk))
> 			mptcp_stop_rtx_timer(sk);
> 	} else {
> 		mptcp_reset_rtx_timer(sk);
> 	}
> +	if (mptcp_pending_data_fin_ack(sk))
> +		mptcp_schedule_work(sk);
> }
>
> static void __mptcp_clean_una_wakeup(struct sock *sk)
> @@ -1499,7 +1500,7 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
> 	 */
> 	if (likely(after64(snd_nxt_new, msk->snd_nxt))) {
> 		msk->bytes_sent += snd_nxt_new - msk->snd_nxt;
> -		msk->snd_nxt = snd_nxt_new;
> +		WRITE_ONCE(msk->snd_nxt, snd_nxt_new);
> 	}
> }
>
> @@ -3210,8 +3211,8 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
> 	if (mp_opt->suboptions & OPTION_MPTCP_CSUMREQD)
> 		WRITE_ONCE(msk->csum_enabled, true);
>
> -	msk->write_seq = subflow_req->idsn + 1;
> -	msk->snd_nxt = msk->write_seq;
> +	WRITE_ONCE(msk->write_seq, subflow_req->idsn + 1);
> +	WRITE_ONCE(msk->snd_nxt, msk->write_seq);
> 	msk->snd_una = msk->write_seq;
> 	msk->wnd_end = msk->snd_nxt + req->rsk_rcv_wnd;
> 	msk->setsockopt_seq = mptcp_sk(sk)->setsockopt_seq;
> @@ -3316,9 +3317,6 @@ void __mptcp_data_acked(struct sock *sk)
> 		__mptcp_clean_una(sk);
> 	else
> 		__set_bit(MPTCP_CLEAN_UNA, &mptcp_sk(sk)->cb_flags);
> -
> -	if (mptcp_pending_data_fin_ack(sk))
> -		mptcp_schedule_work(sk);
> }
>
> void __mptcp_check_push(struct sock *sk, struct sock *ssk)
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 3af85643328e..d05ec76dd7c2 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -402,7 +402,7 @@ static inline struct mptcp_data_frag *mptcp_rtx_head(struct sock *sk)
> {
> 	struct mptcp_sock *msk = mptcp_sk(sk);
>
> -	if (msk->snd_una == READ_ONCE(msk->snd_nxt))
> +	if (msk->snd_una == msk->snd_nxt)
> 		return NULL;
>
> 	return list_first_entry_or_null(&msk->rtx_queue, struct mptcp_data_frag, list);
> -- 
> 2.43.0
>
>
>
