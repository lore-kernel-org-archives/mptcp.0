Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52970279788
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 10:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758277328; cv=none; b=KXDqNWfO1sNeBiy097QlcDat43PVfoP3c3Qr8knCNTnwnUqQHtEmljIiTfzpBO7wKiz9/8LZGl79PnYBaEt00auDC+oGHXsGT67yqnVoKSBMSFxNsc7Sqd9CW7qVt04Zx6yNWHYh5uQt9Jnfe5L8+VRSfcfDEbAblOfOiOMcdfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758277328; c=relaxed/simple;
	bh=ybZT3cTqdt4/zQ5eoawC3m9fAdwqwGktPdi3cXSlsgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=i4Drc0dkJeWd2fwHSZqZgLgOZwS53VzY1JYvlty+NuBx8vFgxDy2cNvfkhhP57TmR0xuICiTxvTfuAKEFOhRc2iftbtT2sFj56RPhytLSwDMSrXRi9tshid7yiqIix2X1VbptXZt0G0EOKUZGoTx9jewZdvS6Lyuu7d43nqL3tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpM56GIZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpM56GIZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D1EC4CEF0;
	Fri, 19 Sep 2025 10:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758277327;
	bh=ybZT3cTqdt4/zQ5eoawC3m9fAdwqwGktPdi3cXSlsgA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=WpM56GIZZ3R004pF7b04HKsI8EKe3UlXXBLr5cEiF+iQP9tw9fuvnPeyLkrFw8Hge
	 Ojam2B7aJJzI0Jlg88mYz3vnovCUMv10f9wAPXBpWeMmqEzs01qBuieLh17cmSxJ4s
	 5z4nKL1oDBD741sODVKlomr8dTRW/D5VEOUmezvlZ4Cl/nrB7YTJZNJgWzVdigFqIj
	 KNg13WmbyKaJQYjInAnOZG1nN3BXkG6y5svCXjS8vEhM7akK9HUP+3qwu1rHdMWX76
	 dURm09A+XtpyhEebX02rVKKhUIFOVoB6MuNx3QWEpxnGWR9ATICOO9sVjnYOEH8kAQ
	 l1OSu4yJptEQQ==
Message-ID: <897ee294-654e-4f94-a6e2-836f1a4d1c7f@kernel.org>
Date: Fri, 19 Sep 2025 12:22:06 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 03/12] mptcp: rcvbuf auto-tuning improvement
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1758214563.git.pabeni@redhat.com>
 <41db4ac9e54972274efd501dc110c5820def3412.1758214563.git.pabeni@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <41db4ac9e54972274efd501dc110c5820def3412.1758214563.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 18/09/2025 19:14, Paolo Abeni wrote:
> Apply to the MPTCP auto-tuning the same improvements introduced for the
> TCP protocol by the merge commit 2da35e4b4df9 ("Merge branch
> 'tcp-receive-side-improvements'").
> 
> The main difference is that TCP subflow and the main MPTCP socket need
> to account separately for OoO: MPTCP does not care for TCP-level OoO
> and vice versa, as a consequence do not reflect MPTCP-level rcvbuf
> increase due to OoO packets at the subflow level.
> 
> This refeactor additionally allow dropping the msk receive buffer update
> at receive time, as the latter only intended to cope with subflow receive
> buffer increase due to OoO packets.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/487
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/559
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Thank you for looking at that!

> ---
> v1 -> v2:
>   - fix unused variable
>   - reword the commit message
> ---
>  net/mptcp/protocol.c | 92 ++++++++++++++++++++------------------------
>  net/mptcp/protocol.h |  4 +-
>  2 files changed, 44 insertions(+), 52 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 9d95d24781509..162abafe3f320 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -179,6 +179,30 @@ static bool mptcp_ooo_try_coalesce(struct mptcp_sock *msk, struct sk_buff *to,
>  	return mptcp_try_coalesce((struct sock *)msk, to, from);
>  }
>  
> +static bool mptcp_rcvbuf_grow(struct sock *sk)

detail: can we add the similar comment as the one below for
mptcp_data_queue_ofo()?

   /* "inspired" by tcp_rcvbuf_grow(), main differences:
    * - ...

I can do the modification when applying the patches.

> +{
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	int rcvwin, rcvbuf;
> +
> +	if (!READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_moderate_rcvbuf) ||
> +	    (sk->sk_userlocks & SOCK_RCVBUF_LOCK))
> +		return false;
> +
> +	rcvwin = ((u64)msk->rcvq_space.space << 1);

Why do you need the u64 cast here? (and the parenthesis)

> +
> +	if (!RB_EMPTY_ROOT(&msk->out_of_order_queue))
> +		rcvwin += MPTCP_SKB_CB(msk->ooo_last_skb)->end_seq - msk->ack_seq;
> +
> +	rcvbuf = min_t(u64, mptcp_space_from_win(sk, rcvwin),
> +		       READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_rmem[2]));

detail: mptcp_space_from_win() and *sysctl_tcp_rmem are on 32 bits, no
need to do a 'min_t(u64)'. Maybe we can copy what is done in
tcp_rcvbuf_grow()?

  rcvbuf = min_t(u32, ...

While at it, could we get even closer to tcp_rcvbuf_grow()? Declaring
and using 'net' and 'cap' variable + keep the comments? By doing that,
it would be easier to spot differences :)

I can also do the modifications when applying the patches if you prefer.

The suggested modifications are minor, and the rest looks good to me!

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

