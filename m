Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858653BB22
	for <mptcp@lists.linux.dev>; Mon,  8 Apr 2024 08:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712564625; cv=none; b=Smj5ut136pzg40jMG8C85azELZwdjnzHpHFPPgCwewVyvoY/CxDhJYXggjnp3Z2tXl91xxA1Aa/2W3+ULwO8Rt7oWrydk/Twd9hgv/M5m3pajZaOUirPJjIZd03NCX3kZbdFVNAlLR3EAihlrktq+5LFoM+oY0KuN8m12xFuUwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712564625; c=relaxed/simple;
	bh=/TMai2EQ3GNgCdPBtPpotVfdDHi1ogmdjsJRQJGDij0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LbS1GYtqBQzR933teBq9ewVtTEkEoc6iKzMigcTPYejQWAkSN2vy+hO3S0rP+9eOHgvKzOsr/t8c58UUuzTj7Bhr7iaHoeqwOrVa/xDelPIoZ691G5EcMcsq2NJ2gy/z+AMpk0/Tib+GJXdQOT4wRaGBGB4VMGuHdtoFeTdLd4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Io+8xean; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Io+8xean"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A84C433F1;
	Mon,  8 Apr 2024 08:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712564625;
	bh=/TMai2EQ3GNgCdPBtPpotVfdDHi1ogmdjsJRQJGDij0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Io+8xeanLgwFg9HcseLO84RUPSTETQ9RUOb4JfkVkquO3mUQbZA/ulenrs4TeBnyy
	 nuWXGVQGeHllWnG3pejzTYJ+FGBHTXzBfpwYBShTSSvRaULBGOtUN13n/lPBJcKx4n
	 3KGT4XAG1RN4Vv1+UTJf70rBJZtmAT2VHfpqq/cCjS38MU2ulTju9c2HnUT0eIKCNL
	 qWMI46hUh/RqhJZXgFK69F4M2nl9nVya9OCOGn6phy8R3H9idynD4L1sZjRXMh2E/7
	 0Sb7vZW+gbLJa4IzlFjS+ocoKsJitZHGP1a/rCMHca8icVcq/ENewu0xMp8Fl0LKF6
	 kpYzOO5EQDRAw==
Message-ID: <ce361a99-6f83-48f7-bc0e-cefa78d9ce6f@kernel.org>
Date: Mon, 8 Apr 2024 10:23:41 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2] Squash to "mptcp: add last time fields in
 mptcp_info"
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <7930751788d3bc8155898d4a22bdd6efca8cfde0.1712486293.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <7930751788d3bc8155898d4a22bdd6efca8cfde0.1712486293.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 07/04/2024 12:38, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Please append the following lines into the commit log:
> 
> '''
> Since msk->last_ack_recv needs to be protected by mptcp_data_lock/unlock,
> and lock_sock_fast can sleep and be quite slow, move the entire
> mptcp_data_lock/unlock block after the lock/unlock_sock_fast block.
> Then mptcpi_last_data_sent and mptcpi_last_data_recv are set in
> lock/unlock_sock_fast block, while mptcpi_last_ack_recv is set in
> mptcp_data_lock/unlock block.
> '''
> 
> v2:
>  - move the entire mptcp_data_lock()/mptcp_data_unlock() block after
> the lock_sock_fast()/unlock_sock_fast() block.
>  - can't move it inside lock_sock_fast()/unlock_sock_fast() block, this
>    causes a deadlock.

Thank you for this v2, it looks good to me!

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/sockopt.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 2ec2fdf9f4af..40b262b2c24a 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -896,9 +896,9 @@ static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
>  void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
>  {
>  	struct sock *sk = (struct sock *)msk;
> -	u32 now = tcp_jiffies32;
>  	u32 flags = 0;
>  	bool slow;
> +	u32 now;
>  
>  	memset(info, 0, sizeof(*info));
>  
> @@ -927,12 +927,6 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
>  	if (READ_ONCE(msk->can_ack))
>  		flags |= MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED;
>  	info->mptcpi_flags = flags;
> -	mptcp_data_lock(sk);
> -	info->mptcpi_snd_una = msk->snd_una;
> -	info->mptcpi_rcv_nxt = msk->ack_seq;
> -	info->mptcpi_bytes_acked = msk->bytes_acked;
> -	info->mptcpi_last_ack_recv = jiffies_to_msecs(now - msk->last_ack_recv);
> -	mptcp_data_unlock(sk);
>  
>  	slow = lock_sock_fast(sk);
>  	info->mptcpi_csum_enabled = READ_ONCE(msk->csum_enabled);
> @@ -944,9 +938,17 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
>  	info->mptcpi_bytes_retrans = msk->bytes_retrans;
>  	info->mptcpi_subflows_total = info->mptcpi_subflows +
>  		__mptcp_has_initial_subflow(msk);
> +	now = tcp_jiffies32;
>  	info->mptcpi_last_data_sent = jiffies_to_msecs(now - msk->last_data_sent);
>  	info->mptcpi_last_data_recv = jiffies_to_msecs(now - msk->last_data_recv);
>  	unlock_sock_fast(sk, slow);
> +
> +	mptcp_data_lock(sk);
> +	info->mptcpi_snd_una = msk->snd_una;
> +	info->mptcpi_rcv_nxt = msk->ack_seq;
> +	info->mptcpi_bytes_acked = msk->bytes_acked;
> +	info->mptcpi_last_ack_recv = jiffies_to_msecs(now - msk->last_ack_recv);

Detail: I suggest moving this line just after 'mptcp_data_lock(sk)',
just to have all the "last time" counters next to each others.

I can do that when applying the patch.

> +	mptcp_data_unlock(sk);
>  }
>  EXPORT_SYMBOL_GPL(mptcp_diag_fill_info);
>  

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

