Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793086426;
	b=pQEfLiL6AGw08YJ94fb5TQ1+mN2qHFQH+2JQ49BcrX7Ra/AEFlGs78s5/MdLxZ3Kkebi
	 I8mumyKWyyysJu4kYQtbYnRLslWCURb/qJ9huWx4Qr5B6unQm9ucwt3l7OPclSHhCFo/o
	 LHBID6xY/wxsVxEbHJgQDdB5BChpdU8vZga02yVc8DzPuKyrKS+i6+3pByLUuYwMksJta
	 gwvRQu0/N93aVaoCvHIbj9kXfCWMoGnmQps0VcCLxg64WrwTC8GCrgURjVoIokRJBC3rr
	 3FT0Au3secx0Q55ZjodDWb81blmx3g9lWa8MI/c0deUQZxZzLm45fXXAndq8wVwNJUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793086426;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=xdNLewiC+WJ4scEMDf+9ddu98aPTZ9LTAVT9XHDtmF0=;
	b=ryRqHWaHmfWx9IDoMmCHcsVJH03VzTa4pw5vxq0KZ/BnzenksYuCJMxMcIjfpokuVa82
	 ipvWKbeO77XOwGjAemnJaM+4miWpvUSevaMLQnwoOaTTqpwKz8tPVHUjlRvCkaWdt+JKK
	 ygl12zMAug/DnnbaGJGWOhAFxicAZw75QDQg1nLtcIer8D9R1B7E2foVbJjhmNIVC80DG
	 XqsZuWyCu+RaLzv+J4rbEA4SUN/+ZvCGIyByC5kWT3TGvX0/CYcGvYXdbNBM7rEAJNYI9
	 U4Xz0ihUpVOvR0G0IShjqLv1xGo9RDzeihSK2kytDfc3g1y+3GLdyyUN0xzgFaBY+ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WfIuhn0v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B702606A31D
	for <mptcp@lists.linux.dev>; Tue, 27 Oct 2026 07:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WfIuhn0v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B1F1F01825;
	Tue, 27 Oct 2026 07:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793086426;
	bh=xdNLewiC+WJ4scEMDf+9ddu98aPTZ9LTAVT9XHDtmF0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WfIuhn0vDOLfU19QjgrtBRRSiHKAjJsba4k9ZVwSvcy0PcrZA47eSX8nTpnKNZWSL
	 YwYZr9ZXY2AlByzgp5FVRwBBGnK8BuE/nv0Y+7EIwsjdh0HmyoS9MkxyCmqt8yXBBP
	 skN2WRP16E+XhkWWAAN4c+IXWxxpJPvppc+3qiVIcXcp6pFd2bmChAxytdbEfQKSP+
	 9bB9kOUFc6bwPOuLR8I5w2/jIsBuLvyCyd04QNef/qjTrH8S1JSTh5bxrN3VKFM/07
	 39Wq4Kg5Wy4lyXxFtqktXGH1MmOAAnYqRoWsHex79TU4MPQoTTGBR5o2XjCM+tIG8O
	 +VqF2T1Ra1QDA==
Message-ID: <d802ebc3-477b-4e86-b4d9-9fa2a3005e40@kernel.org>
Date: Tue, 27 Oct 2026 08:33:42 +0100
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC net-next v10] mptcp: normalize seq numbers reported in
 mptcp_info
Content-Language: fr
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>, mptcp@lists.linux.dev
Cc: shardul.b@mpiricsoftware.com, janak@mpiric.us, kalpanjani009@gmail.com
References: <20261027062750.2095515-1-kalpan.jani@mpiricsoftware.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20261027062750.2095515-1-kalpan.jani@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kalpan,

On 27/10/2026 07:27, Kalpan Jani wrote:
> Normalize the MPTCP sequence fields relative to the initial data sequence
> number baselines.
> 
> Keep the normalized values available to privileged diagnostic requests,
> while zeroing them in INET_DIAG_INFO for callers without CAP_NET_ADMIN.
> 
> Normalize MPTCP_SUBFLOW_ATTR_MAP_SEQ against remote_idsn as well, so
> subflow mapping sequence numbers use the same remote sequence space as
> mptcpi_rcv_nxt.
> 
> Pass requester capability state to idiag_get_info callbacks. Other
> protocol callbacks retain their existing behavior.
> 
> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/445
> Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
> ---
> Changes since v9:

Thank you for the new version!

> - Keep normalized sequence values available to privileged diagnostic
>   requests and zero the three sequence fields for unprivileged
>   INET_DIAG_INFO callers.
> - Pass requester capability state to idiag_get_info callbacks while
>   preserving existing behavior for other protocol callbacks.

I think it should be one or the other: the suggestion to disable the
different fields for non net-admin is a sort of workaround not to have
to deal with the possible issues reported by Sashiko.

If we take this route, the only modifications on MPTCP side would be in
the diag files (or if you have fixes, they can be in separated patches).
Also, it would be easier to split this change in two: exposing the
net_admin boolean, then modifying MPTCP to hide data.

BTW, using the bytes sent/received was not something that could be used
here?

> - Normalize MPTCP_SUBFLOW_ATTR_MAP_SEQ relative to remote_idsn so it
>   uses the same remote sequence-number baseline as mptcpi_rcv_nxt.

I guess it would be 0 for non net-admin.

(...)

> diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
> index 34b77aa87d0a4..362161bf39fe3 100644
> --- a/net/ipv4/inet_diag.c
> +++ b/net/ipv4/inet_diag.c
> @@ -276,7 +276,7 @@ int inet_sk_diag_fill(struct sock *sk, struct inet_connection_sock *icsk,
>  	}
>  
>  	if (!icsk) {
> -		handler->idiag_get_info(sk, r, NULL);
> +		handler->idiag_get_info(sk, r, NULL, net_admin);
>  		goto out;
>  	}
>  
> @@ -327,7 +327,7 @@ int inet_sk_diag_fill(struct sock *sk, struct inet_connection_sock *icsk,
>  			goto errout;
>  	}
>  
> -	handler->idiag_get_info(sk, r, info);
> +	handler->idiag_get_info(sk, r, info, net_admin);
>  
>  	if (ext & (1 << (INET_DIAG_INFO - 1)) && handler->idiag_get_aux)
>  		if (handler->idiag_get_aux(sk, net_admin, skb) < 0)
> @@ -1027,7 +1027,7 @@ int inet_diag_handler_get_info(struct sk_buff *skb, struct sock *sk)
>  	if (attr)
>  		info = nla_data(attr);
>  
> -	handler->idiag_get_info(sk, r, info);
> +	handler->idiag_get_info(sk, r, info, false);

I didn't check, but can you not extract the capability from the skb?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

