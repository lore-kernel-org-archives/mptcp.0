Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137F17F8
	for <mptcp@lists.linux.dev>; Fri, 26 Jul 2024 00:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721954383; cv=none; b=lG7AL7Fp68ohD2zLdfF8m7SVRLFeTwS/Hpctd751JU/I/1/tShrUwKj6QIdBFlNii7ZjuAC23zjO5Hndba2YJUVgknJgdf6bQkssk1cegxAacSF+oj/UIOUjiIGw6+3N/hB1uI3qrbavnUyyipg27COpLCxpfSBKMrXq3rcL98w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721954383; c=relaxed/simple;
	bh=jGg3iXOq2YVcX5oA0WjAeakwppsqVn8xVlehPxICiJc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=A51wt1WeGAP35Dz9eINswjd8crwHw3h4rjr/idWjms9XPNjAVYB5/KK6AakojrBP4bWErQtKmx81P/RGxcfNsf9OIYzPz399JfkfvMp4CUb7sYqd2Wu7KPsksC+LpYUpsd5FPrN+nYsCGgjrNk1P3EjCKYbqPE1RdbwN60MNlR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qz718QQM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qz718QQM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2CEC116B1;
	Fri, 26 Jul 2024 00:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721954382;
	bh=jGg3iXOq2YVcX5oA0WjAeakwppsqVn8xVlehPxICiJc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Qz718QQMO1u2Wdoe2cKtkZ4gVn2yqCslpYsjLzodev/N7MeIOtWaH3cE2Fzp8vaSj
	 xesDErO1Met8hkXY8bK5svqf+Si2DrKXOYWyoedafHl9wx4Tmtn7nvJrEXC85ZsEk7
	 rtdx9KimZ2C09RlPWum/Ag4kCvuYs9R/F0X3adjfGWOHId45xFRKBu8V4wwzg4R1aF
	 v2S+t9v+M6uzcTSvkPyeMZ3s/P0o7pqXl2JwVDBDex1e9Gc0mzd4hFJqGuJY6ZkkWC
	 O6o6b289q/y1rk+/dMkYGC2KNQ3Opl9Q/iHifCaUVC1kkFq0vj8EKvlKCZv0m/WTuZ
	 ZzyKuMTFlYCAw==
Date: Thu, 25 Jul 2024 17:39:41 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net 1/2] mptcp: fix bad RCVPRUNED mib accounting
In-Reply-To: <51cd83cb7690d756e9a71797b133bdd9f286de76.1721921695.git.pabeni@redhat.com>
Message-ID: <c271e123-2f51-3450-eb46-99975e52804f@kernel.org>
References: <51cd83cb7690d756e9a71797b133bdd9f286de76.1721921695.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 25 Jul 2024, Paolo Abeni wrote:

> Since its introduction, the mentioned MIB accounted for the wrong
> event: wake-up being skipped as not-needed on some edge condition
> instead of incoming skb being dropped after landing in the (subflow)
> receive queue.
>
> Move the increment in the correct location.
>
> Fixes: ce599c516386 ("mptcp: properly account bulk freed memory")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/protocol.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index b3a48d97f009..13777c35496c 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -350,8 +350,10 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
> 	skb_orphan(skb);
>
> 	/* try to fetch required memory from subflow */
> -	if (!mptcp_rmem_schedule(sk, ssk, skb->truesize))
> +	if (!mptcp_rmem_schedule(sk, ssk, skb->truesize)) {
> +		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);

Hi Paolo -

MIB change LGTM:

Reviewed-by: Mat Martineau <martineau@kernel.org>

> 		goto drop;
> +	}
>
> 	has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
>
> @@ -844,10 +846,8 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
> 		sk_rbuf = ssk_rbuf;
>
> 	/* over limit? can't append more skbs to msk, Also, no need to wake-up*/
> -	if (__mptcp_rmem(sk) > sk_rbuf) {
> -		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
> +	if (__mptcp_rmem(sk) > sk_rbuf)
> 		return;
> -	}
>
> 	/* Wake-up the reader only for in-sequence data */
> 	mptcp_data_lock(sk);
