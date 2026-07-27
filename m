Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBE926F2B9
	for <mptcp@lists.linux.dev>; Mon, 27 Jul 2026 06:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785134244; cv=none; b=pV6pO4+6g/EpVAzjP77Sw8ZlMy7PvIyFMsEDE4JyVrP17w7deUJ7ItTc6+O+zmGP5zmJIuUwuQeNCbWoheEfzaxVEf55dFHTCfSBPBMYYWaOzhScFmxHtQVEVV6M3jS3Ai6CiJaF9ikGcNUrep45A6qp5L0J52YWI6WIXTmqwN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785134244; c=relaxed/simple;
	bh=wxmV1HuogoN8E7M9252o5kw3ENi2u+Og+FbDhjixy1s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O3jNfjcxZ6IpPETQARYzu1OxxzOYnheEKjvYzuudrSDB0pseS2nTiFDs5YwtqzLfWA5fHVrxQW2ujF8QD9m5tSjmSAaUo7u6nnRZCeB41HtouWlJWzYGjp6yWVcF0XmbGP2DBNPspUejmUMX3TuoJaLEY6Jq4a9Yln+ISfGUcGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5dTPmfH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5dTPmfH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83CD21F000E9;
	Mon, 27 Jul 2026 06:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785134243;
	bh=r1CnJFSFdR0TUSEey2tinkrurEj9r/IFCYqvcugRgkA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=H5dTPmfHvYqvnPnOsTt6cC9d5ZbWem45svTXHsvRE+u1SuT9I+8mi4ipQiGQcCgBz
	 pZC4gr/h76HL9DipiG/EvTPgW4rRpZ15WiEtu+uqmeqNdi8s9RiDeafjVUgiPDaFoi
	 Le8kNCy+nHgfMDcsJ34VEr0YJo4LYD6k4CpMRNM/+Xiq9wLNG+83mIo7l15EmNe1Rf
	 WmpNfJvAdtieYIiVZAE7ZAtgPadauxz8ir5ufXuJ6XV3LjZNsIBbmM1PMNC6zPBDUY
	 TbrlKrIEBhjByhFSSYCKaOpL5gD5SiTlolzTBv8ZltFttDMsAqcX3Zpyut9xSWxYir
	 VQa7KeW/+wk9w==
Message-ID: <13793643d394a86e9f16ca02c1f18cc75adf7a28.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v3 1/7] mptcp: drop unused @max arg of
 __mptcp_setsockopt_set_val
From: Geliang Tang <geliang@kernel.org>
To: Gang Yan <gang.yan@linux.dev>, mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Date: Mon, 27 Jul 2026 14:37:19 +0800
In-Reply-To: <20260727022849.20923-2-gang.yan@linux.dev>
References: <20260727022849.20923-1-gang.yan@linux.dev>
	 <20260727022849.20923-2-gang.yan@linux.dev>
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
> The @max argument is never read in the function body. Remove it and
> the
> MAX_TCP_KEEP* values passed by the TCP_KEEPIDLE/INTVL/KEEPCNT
> callers.

No, we shouldn't drop this "max" argument. Instead, we need to add some
code to check the "val" argument against the "max" argument in
__mptcp_setsockopt_set_val(), something like:

        if (val < 1 || val > max) 
                return -EINVAL;

> 
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> ---
>  net/mptcp/sockopt.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index fcf6feb2a9eb..9c4faa0d82ef 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -632,7 +632,7 @@ static int
> mptcp_setsockopt_sol_tcp_congestion(struct mptcp_sock *msk, sockptr_t
>  	return ret;
>  }
>  
> -static int __mptcp_setsockopt_set_val(struct mptcp_sock *msk, int
> max,
> +static int __mptcp_setsockopt_set_val(struct mptcp_sock *msk,
>  				      int (*set_val)(struct sock *,
> int),
>  				      int *msk_val, int val)
>  {
> @@ -876,18 +876,15 @@ static int mptcp_setsockopt_sol_tcp(struct
> mptcp_sock *msk, int optname,
>  		ret = __mptcp_setsockopt_sol_tcp_nodelay(msk, val);
>  		break;
>  	case TCP_KEEPIDLE:
> -		ret = __mptcp_setsockopt_set_val(msk,
> MAX_TCP_KEEPIDLE,
> -						
> &tcp_sock_set_keepidle_locked,
> +		ret = __mptcp_setsockopt_set_val(msk,
> &tcp_sock_set_keepidle_locked,
>  						 &msk-
> >keepalive_idle, val);
>  		break;
>  	case TCP_KEEPINTVL:
> -		ret = __mptcp_setsockopt_set_val(msk,
> MAX_TCP_KEEPINTVL,
> -						
> &tcp_sock_set_keepintvl,
> +		ret = __mptcp_setsockopt_set_val(msk,
> &tcp_sock_set_keepintvl,
>  						 &msk-
> >keepalive_intvl, val);
>  		break;
>  	case TCP_KEEPCNT:
> -		ret = __mptcp_setsockopt_set_val(msk,
> MAX_TCP_KEEPCNT,
> -						
> &tcp_sock_set_keepcnt,
> +		ret = __mptcp_setsockopt_set_val(msk,
> &tcp_sock_set_keepcnt,
>  						 &msk-
> >keepalive_cnt,
>  						 val);
>  		break;
