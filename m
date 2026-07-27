Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95D23DB321
	for <mptcp@lists.linux.dev>; Mon, 27 Jul 2026 06:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785134381; cv=none; b=FJSFAMEJ5zFecHx1OpJZQCa9+kfUKG3sm2nPdYrBA5Tw2PU+eAstrh9kBUJu+hDjCwn8CoVyMz8/wSKLtyO5ztGzDHQrUT8GTDdoToigrzugQa/H8MIFuLvTHPe+gf6Ujq8L9Bw6/k7DUpnVMTfM008VOHmlH3VFd829cyBGYrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785134381; c=relaxed/simple;
	bh=LIESWp+brPwVctgS76XGh6b24Xy0ixAvB0N1rSlUCC8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d5Uwnp/clkGnZz6wvxtPsLzNcjy1J5tCUTZrP7JUUMwC511thgRvNHPMiMTF+KQeTXAxLjAzwGeEzEYlkJEtH6I9X0kOtq0WwKjKAoCJpBgcMOYhFiQcHiccrX96z4AP1PSNl4/WNUw83AS1UgqfeU5Rnb82f9Ajkro1WR0XZnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZwTwakJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZwTwakJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8446E1F000E9;
	Mon, 27 Jul 2026 06:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785134379;
	bh=lmz+lmZo88MFgRPJ0ImtgjwckQvz8avgaJH3zQwC0Lk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JZwTwakJvas630ulgusXRiL15J+Dwk09U/5rlv37euxaTqbKB4Phuga+Qq0GWrnNO
	 TNOFzUhNcr2B/fG4O+HQR8kW4nrYypeIb+abZMR6rTvQPs87JQAy1ubExnIwKtduAh
	 uy6QnzEO4jZrUDlwiECAalVUFufVKmdkr/QT8Iccfg+WRUAWj7oMWYzwcdiqAoK4qU
	 EMfJJe25csU1/m6jHkSXWV/mrpka/Mu7JI1BqrEtoGnBP6tJVbzGlchoH5CJeHsy+N
	 PXO2lm3tB/ezpxvT/Cxtf31F2Ae898r8qw/XctCb9B/ikB3na+8OYkJhTPFcYDNRw1
	 N8WDlAd39heTA==
Message-ID: <13ffac6c4624bb4c3fee240d50027e892f52a49a.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v3 2/7] mptcp: take TCP_MAXSEG handling into
 __mptcp_setsockopt_set_val
From: Geliang Tang <geliang@kernel.org>
To: Gang Yan <gang.yan@linux.dev>, mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Date: Mon, 27 Jul 2026 14:39:36 +0800
In-Reply-To: <20260727022849.20923-3-gang.yan@linux.dev>
References: <20260727022849.20923-1-gang.yan@linux.dev>
	 <20260727022849.20923-3-gang.yan@linux.dev>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2026-07-27 at 10:28 +0800, Gang Yan wrote:
> From: Gang Yan <yangang@kylinos.cn>
> 
> mptcp_setsockopt_all_sf is only used in 'TCP_MAXSEG', and it can be
> replaced with __mptcp_setsockopt_set_val.
> 
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> ---
>  net/ipv4/tcp.c      | 1 +
>  net/mptcp/sockopt.c | 5 ++---
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index b427f924608c..5915d0e62f43 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -3830,6 +3830,7 @@ int tcp_sock_set_maxseg(struct sock *sk, int
> val)
>  	WRITE_ONCE(tcp_sk(sk)->rx_opt.user_mss, val);
>  	return 0;
>  }
> +EXPORT_SYMBOL(tcp_sock_set_maxseg);
>  
>  /*
>   *	Socket option code for TCP.
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 9c4faa0d82ef..a7d4135757e7 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -889,9 +889,8 @@ static int mptcp_setsockopt_sol_tcp(struct
> mptcp_sock *msk, int optname,
>  						 val);
>  		break;
>  	case TCP_MAXSEG:
> -		msk->maxseg = val;
> -		ret = mptcp_setsockopt_all_sf(msk, SOL_TCP, optname,
> optval,
> -					      optlen);
> +		ret = __mptcp_setsockopt_set_val(msk,
> &tcp_sock_set_maxseg,
> +						 &msk->maxseg, val);

So, here you do need to pass in MAX_TCP_MAXSEG, and you need to
consider what would be a reasonable value to define it as.

>  		break;
>  	default:
>  		ret = -ENOPROTOOPT;
