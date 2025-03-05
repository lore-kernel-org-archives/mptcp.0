Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2C7539A
	for <mptcp@lists.linux.dev>; Wed,  5 Mar 2025 21:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741210165; cv=none; b=sNLx8SlHrMXQ9VS5Pl+uY8J1mAktF5uEh7Na08xTDn3ubb9q/t/ISKPsmkqWJ6s7/su4h+orJd5wEvYlSrV8pF0cuzRnfgXcUmdfiOkcVEVbtoIIKoKOsBdyX9DXQTfBDkL8U5Ar/AfnSD3MIS4/dAG0xBQzz/2plgqqQ1fd2jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741210165; c=relaxed/simple;
	bh=Kj2HFuLR7ABqRl8sMVo+I+lMaBgsRX48Dd7jjXkOC+M=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SmDpbJz/208P54GgkaBKz8Xl5BewmwJg+kRmPs0c9P3H/QTmDNOBz1np3kEgGijabfvEDANdkB1A42qzB07P5iTa8/vjnApxAUraLHWF6oup89Mm8f5LZaHzGgY6Jkdd/Zdm6Qk5znRIlEmZ0XljOgvG38rwSPCCB+3W8SS6LfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TN6iZ9YL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TN6iZ9YL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B762C4CED1;
	Wed,  5 Mar 2025 21:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741210165;
	bh=Kj2HFuLR7ABqRl8sMVo+I+lMaBgsRX48Dd7jjXkOC+M=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=TN6iZ9YLjen53No3sZPqqY1I75EkzNcfqplJAAyXLHH3zX0Cqa+qRQc53eYzfyO5x
	 lmZnPf718MEEp7Ar88lwWZzVKW9kff/kiNjXCnfboPzAmA1fLmJ9t3ksDkA/ghwy3K
	 lvDpf+Efid+ByFfXJJXwMHP8y0hTnLi74VBijVfk/gP0Tit+FBYCEXRmGbPGTQbBq2
	 3Sfhl+uwvtu4Uu5TOlwHfDq8prnnvObvqahDlvvF03fg5kDyCO4MvRw1VbSIKKvVOp
	 598aYugRxHH5m2YNttIvWmYnbzVe1Vcz62IzoSWl3+/d++z1RZet2QoXYhIbng/K2c
	 08LVdAzKt1yKg==
Date: Wed, 5 Mar 2025 13:29:24 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev, Davide Caratti <dcaratti@redhat.com>
Subject: Re: [PATCH mptcp-next v2 1/2] tcp: ulp: diag: always print the name
 if any
In-Reply-To: <20250305-mptcp-tcp-ulp-diag-cap-v2-1-d53fd80748eb@kernel.org>
Message-ID: <4fd2adc0-5a6b-05ad-e900-180fb61dea2b@kernel.org>
References: <20250305-mptcp-tcp-ulp-diag-cap-v2-0-d53fd80748eb@kernel.org> <20250305-mptcp-tcp-ulp-diag-cap-v2-1-d53fd80748eb@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 5 Mar 2025, Matthieu Baerts (NGI0) wrote:

> Since its introduction in commit 61723b393292 ("tcp: ulp: add functions
> to dump ulp-specific information"), the ULP diag info have been exported
> only if the requester had CAP_NET_ADMIN.
>
> At least the ULP name can be exported without CAP_NET_ADMIN. This will
> already help identifying which layer is being used, e.g. which TCP
> connections are in fact MPTCP subflow.
>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> net/ipv4/tcp_diag.c | 21 ++++++++++-----------
> 1 file changed, 10 insertions(+), 11 deletions(-)

Hi Matthieu -

Thanks for the v2, and also for splitting up the series. These TCP changes 
look good to me:

Acked-by: Mat Martineau <martineau@kernel.org>


>
> diff --git a/net/ipv4/tcp_diag.c b/net/ipv4/tcp_diag.c
> index f428ecf9120f2f596e1d67db2b2a0d0d0e211905..d8bba37dbffd8c6cc7fab2328a88b6ce6ea3e9f4 100644
> --- a/net/ipv4/tcp_diag.c
> +++ b/net/ipv4/tcp_diag.c
> @@ -83,7 +83,7 @@ static int tcp_diag_put_md5sig(struct sk_buff *skb,
> #endif
>
> static int tcp_diag_put_ulp(struct sk_buff *skb, struct sock *sk,
> -			    const struct tcp_ulp_ops *ulp_ops)
> +			    const struct tcp_ulp_ops *ulp_ops, bool net_admin)
> {
> 	struct nlattr *nest;
> 	int err;
> @@ -96,7 +96,7 @@ static int tcp_diag_put_ulp(struct sk_buff *skb, struct sock *sk,
> 	if (err)
> 		goto nla_failure;
>
> -	if (ulp_ops->get_info)
> +	if (net_admin && ulp_ops->get_info)
> 		err = ulp_ops->get_info(sk, skb);
> 	if (err)
> 		goto nla_failure;
> @@ -113,6 +113,7 @@ static int tcp_diag_get_aux(struct sock *sk, bool net_admin,
> 			    struct sk_buff *skb)
> {
> 	struct inet_connection_sock *icsk = inet_csk(sk);
> +	const struct tcp_ulp_ops *ulp_ops;
> 	int err = 0;
>
> #ifdef CONFIG_TCP_MD5SIG
> @@ -129,15 +130,13 @@ static int tcp_diag_get_aux(struct sock *sk, bool net_admin,
> 	}
> #endif
>
> -	if (net_admin) {
> -		const struct tcp_ulp_ops *ulp_ops;
> -
> -		ulp_ops = icsk->icsk_ulp_ops;
> -		if (ulp_ops)
> -			err = tcp_diag_put_ulp(skb, sk, ulp_ops);
> -		if (err)
> +	ulp_ops = icsk->icsk_ulp_ops;
> +	if (ulp_ops) {
> +		err = tcp_diag_put_ulp(skb, sk, ulp_ops, net_admin);
> +		if (err < 0)
> 			return err;
> 	}
> +
> 	return 0;
> }
>
> @@ -164,14 +163,14 @@ static size_t tcp_diag_get_aux_size(struct sock *sk, bool net_admin)
> 	}
> #endif
>
> -	if (net_admin && sk_fullsock(sk)) {
> +	if (sk_fullsock(sk)) {
> 		const struct tcp_ulp_ops *ulp_ops;
>
> 		ulp_ops = icsk->icsk_ulp_ops;
> 		if (ulp_ops) {
> 			size += nla_total_size(0) +
> 				nla_total_size(TCP_ULP_NAME_MAX);
> -			if (ulp_ops->get_info_size)
> +			if (net_admin && ulp_ops->get_info_size)
> 				size += ulp_ops->get_info_size(sk);
> 		}
> 	}
>
> -- 
> 2.47.1
>
>
