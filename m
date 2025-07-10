Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84792E6D22
	for <mptcp@lists.linux.dev>; Thu, 10 Jul 2025 17:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752169269; cv=none; b=aR115VSG9GjLMVQmCg1kW74BlfpcnMJNdqO/i39OSZM7Rq2L4mZYXWnkEyUOx9i2kBmhKqFatQZDhc5uWbPvIZ8eiJeHWc6jKw+NreTiWuKxgjjIQUEtgeuqiNDsBbMxSOeOonc/YUs1dCfxSfLL8KVE8FM+9xDMP7Q5tv+R6r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752169269; c=relaxed/simple;
	bh=6F62nwAB6t9FGCW5XCFtFe6aUrxPqZJELVLos8z1N3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sbyUR6nn6CbquSk6PW9wlJ4gwD2nw2NleTHFk74boT+OdpPDC1hTn+x+Zpf1fboFwNiWKU9qkNNoelwatddXYn5FNqu1KYkynaSC9KUzFojnAp54VAsCDbXVaw5thJl3JoWX96wJem5T+1msi1myIX9/YqOtTHmohnrzL3IWVTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhYRzVBb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhYRzVBb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84539C4CEE3;
	Thu, 10 Jul 2025 17:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752169269;
	bh=6F62nwAB6t9FGCW5XCFtFe6aUrxPqZJELVLos8z1N3Y=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=KhYRzVBbDFms2JLA5UpLT2TcCt7OZXYd78nuyQ1CoHXT+EXXZUjTvFm0mE0sI2JXH
	 e3tX9TGFVVYci/rjc+qm9tdygug0L52LpVFKLrktQXdXxBjFB0XgnzSzv7aN6H9vdw
	 TiPIqjzr6UNRILAxEjvjGSUoRX9IZmwd9rUmXzdhln0HwWReoDDDV4a2nt2YhcYRuk
	 b/hWZBufXrRmtJ0vjfc9MUa1GcttG8r5gBeM3B8W+yA0dEaO5dKNbN136i3JDxp37h
	 45mW4mkhb32xFp5BLb1o4mg9MFmZKSLCUNYVgJJ/+f3kGD9GNhgA7XfT0hHge+Kcdg
	 Rrsb33/q79bfg==
Message-ID: <bab09d84-a327-449d-95df-882a7bedf3f8@kernel.org>
Date: Thu, 10 Jul 2025 19:41:08 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v3 mptcp-net 1/5] mptcp: make fallback action and fallback
 decision atomic
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1752073685.git.pabeni@redhat.com>
 <2cc6457002f97221dd59b49841efc2816dcc1617.1752073685.git.pabeni@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <2cc6457002f97221dd59b49841efc2816dcc1617.1752073685.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 09/07/2025 17:12, Paolo Abeni wrote:
> Syzkaller reported the following splat:

(...)

> Since we need to track the 'fallback is possible' condition and the
> fallback status separately, there are a few possible races open between
> the check and the actual fallback action.
> 
> Add a spinlock to protect the fallback related information and use
> it close all the possible related races. While at it also remove the
> too-early clearing of allow_infinite_fallback in __mptcp_subflow_connect():
> the field will be correctly cleared by subflow_finish_connect() if/
> when the connection will complete successfully.
> 
> If fallback is not possible, as per RFC, reset the current subflow.
> 
> Since the fallback operation can now fail and return value should be
> checked, rename the helper accordingly.
> 
> Reported by: Matthieu Baerts <matttbe@kernel.org>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/570
> Reported-by: syzbot+5cf807c20386d699b524@syzkaller.appspotmail.com
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/555
> Fixes: 0530020a7c8f ("mptcp: track and update contiguous data status")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v2 -> v3:
>   - fix return vale check in check_fully_established()
>   - add WARN when hitting 'impossible' fallback failures.
>   - drop empty line
>   - mptcp_do_fallback -> mptcp_try_fallback

Thank you for the v3!

> 
> v1 -> v2:
>   - remove unneeded and racing allow_infinite_fallback in
>     __mptcp_subflow_connect()
>   - really close race in subflow_check_data_avail()
> 
> Sharing earlier to feed syzkaller.
> Hopefully a follow-up on mptcp-net-next will cleanup a bit the fallback
> handling, I tried to minimize the delta for backport's sake

syzkaller is still OK with this v3!

(...)

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 1de42dc4e8ea..4ddf3a1e0085 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -560,10 +560,9 @@ static bool mptcp_check_data_fin(struct sock *sk)
>  
>  static void mptcp_dss_corruption(struct mptcp_sock *msk, struct sock *ssk)
>  {
> -	if (READ_ONCE(msk->allow_infinite_fallback)) {
> +	if (mptcp_try_fallback(ssk)) {
>  		MPTCP_INC_STATS(sock_net(ssk),
>  				MPTCP_MIB_DSSCORRUPTIONFALLBACK);
> -		mptcp_do_fallback(ssk);
>  	} else {
>  		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSCORRUPTIONRESET);
>  		mptcp_subflow_reset(ssk);
> @@ -803,6 +802,14 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
>  	if (sk->sk_state != TCP_ESTABLISHED)
>  		return false;
>  
> +	spin_lock_bh(&msk->fallback_lock);
> +	if (__mptcp_check_fallback(msk)) {
> +		spin_unlock_bh(&msk->fallback_lock);
> +		return false;
> +	}
> +	mptcp_subflow_joined(msk, ssk);
> +	spin_unlock_bh(&msk->fallback_lock);

(just to be sure, do you prefer to explicitly have the lock and fallback
check here and in mptcp_finish_join, and not in mptcp_subflow_joined?)
> +
>  	/* attach to msk socket only after we are sure we will deal with it
>  	 * at close time
>  	 */
> @@ -811,7 +818,6 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
>  
>  	mptcp_subflow_ctx(ssk)->subflow_id = msk->subflow_id++;
>  	mptcp_sockopt_sync_locked(msk, ssk);
> -	mptcp_subflow_joined(msk, ssk);
>  	mptcp_stop_tout_timer(sk);
>  	__mptcp_propagate_sndbuf(sk, ssk);
>  	return true;
> @@ -1136,10 +1142,14 @@ static void mptcp_update_infinite_map(struct mptcp_sock *msk,
>  	mpext->infinite_map = 1;
>  	mpext->data_len = 0;
>  
> +	if (!mptcp_try_fallback(ssk)) {
> +		mptcp_subflow_reset(ssk);
> +		return;
> +	}
> +
>  	MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPTX);
>  	mptcp_subflow_ctx(ssk)->send_infinite_map = 0;
>  	pr_fallback(msk);
> -	mptcp_do_fallback(ssk);
>  }
>  
>  #define MPTCP_MAX_GSO_SIZE (GSO_LEGACY_MAX_SIZE - (MAX_TCP_HEADER + 1))
> @@ -2543,9 +2553,9 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
>  
>  static void __mptcp_retrans(struct sock *sk)
>  {
> +	struct mptcp_sendmsg_info info = { .data_lock_held = true, };

(You might have missed my comment in the v2, or I missed your reply)

Is this modification needed? I might have missed something (or used
later?), but it looks like this 'data_lock_held' is not used here or in
mptcp_sendmsg_frag(). Then no need to set it to true, no?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

