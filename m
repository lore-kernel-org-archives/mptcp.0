Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8B1264614
	for <mptcp@lists.linux.dev>; Thu, 23 Oct 2025 06:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761201499; cv=none; b=XyLNEJ8t5eoVDfhhSPMdigwbbaDSW3ZYNM7dX1+EZg2AcZuAXePTPzt6qR50mULoAKxpCwHghdURJ93UxttHbrE3LHgDIqzjTDL4IXWj/IFstbu4KRnqS5wbZW6y9HmAinOA9sTn9eFuanupbHNbfLOmyjZDbR/BhcREhqVwMn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761201499; c=relaxed/simple;
	bh=2JzocRVVllaQfHbgWVgvOL8JCfmsjJF9Z9lkIkXKdno=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hEoV6752u+anlUovhoFbt8VJVPSH2H4m+x5y99bIuJC7oinYuRlcxgwHcrLw/uz0XoGOBFc+73OhMHoDXFoxiVeXvsnzwjgtzA7K7Tp1VhJaoKhnZg0kiq+SpuTJVVWaia2L0XopmVhe1zdYcxBqXMfq98G5d5tTXKjUxTLitqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0HxbBW6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0HxbBW6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3D1C4CEE7;
	Thu, 23 Oct 2025 06:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761201499;
	bh=2JzocRVVllaQfHbgWVgvOL8JCfmsjJF9Z9lkIkXKdno=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=l0HxbBW61ci30JWiUAy84sj+/hifCjjvyZpSrhJKLtMnMyktSNY4ZSWG0C5TDl/j3
	 95XO7zBTD8oGpatelYgWLRvxDrRr+i/l9oJMA7byJPHfRX/gkf2tBiCFlAHhWTEMIt
	 nCq4INgTFimKe/eR6wdrOGDctA5EBg/eUdQDNgH6IITggq2DV1En6TK4F1wyO3J9Q0
	 tABzGZ6/YL3up1oLIPwqfeEMJJRc/DTAlrMMAYh/s9S7y+zwDzdAHFHGNXCGBVvAX5
	 EclD60HBEBeM3JlljtJ94teSRRkBz4MocY7eqE2rdlzZuZhvEpn1DpbGrhLbPBs2jh
	 ZCCm5VBitoYZw==
Message-ID: <a3d3cb61a6c9efa7237e3d15e3ed6c2051fabb04.camel@kernel.org>
Subject: Re: [PATCH v6 mptcp-next 09/11] mptcp: drop the
 __mptcp_data_ready() helper
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>
Date: Thu, 23 Oct 2025 14:38:14 +0800
In-Reply-To: <67952c23fbff74910a98b96d863cdb2468e9e011.1761142784.git.pabeni@redhat.com>
References: <cover.1761142784.git.pabeni@redhat.com>
	 <67952c23fbff74910a98b96d863cdb2468e9e011.1761142784.git.pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2025-10-22 at 16:31 +0200, Paolo Abeni wrote:
> It adds little clarity and there is a single user of such helper,
> just inline it in the caller.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>   - v4 -> v5:
>     split out of main backlog patch, to make the latter smaller
> ---
>  net/mptcp/protocol.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 3653b10d24887e..c68a4b410e7e5b 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -838,18 +838,10 @@ static bool move_skbs_to_msk(struct mptcp_sock
> *msk, struct sock *ssk)
>  	return moved;
>  }
>  
> -static void __mptcp_data_ready(struct sock *sk, struct sock *ssk)
> -{
> -	struct mptcp_sock *msk = mptcp_sk(sk);
> -
> -	/* Wake-up the reader only for in-sequence data */
> -	if (move_skbs_to_msk(msk, ssk) && mptcp_epollin_ready(sk))
> -		sk->sk_data_ready(sk);
> -}
> -
>  void mptcp_data_ready(struct sock *sk, struct sock *ssk)
>  {
>  	struct mptcp_subflow_context *subflow =
> mptcp_subflow_ctx(ssk);
> +	struct mptcp_sock *msk = mptcp_sk(sk);
>  
>  	/* The peer can send data while we are shutting down this
>  	 * subflow at msk destruction time, but we must avoid
> enqueuing
> @@ -859,10 +851,14 @@ void mptcp_data_ready(struct sock *sk, struct
> sock *ssk)
>  		return;
>  
>  	mptcp_data_lock(sk);
> -	if (!sock_owned_by_user(sk))
> -		__mptcp_data_ready(sk, ssk);
> -	else
> +	if (!sock_owned_by_user(sk)) {
> +		/* Wake-up the reader only for in-sequence data */
> +		if (move_skbs_to_msk(msk, ssk) &&
> mptcp_epollin_ready(sk))
> +			sk->sk_data_ready(sk);
> +		

nit:

There's an extra blank line here.

Thanks,
-Geliang

> +	} else {
>  		__set_bit(MPTCP_DEQUEUE, &mptcp_sk(sk)->cb_flags);
> +	}
>  	mptcp_data_unlock(sk);
>  }
>  

