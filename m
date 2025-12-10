Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F153081BE
	for <mptcp@lists.linux.dev>; Wed, 10 Dec 2025 10:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765360983; cv=none; b=svqBvaR5nqykGZ7Dk/3kMtBSQpeIPcKhF8EAVw/tnGZ//5C8x7D/EfdfdeepUGNs6hTh9g7PjeWrfw0lALr3gjMn2oByhORDLhLBjq7umXte682ZUHDsrGkJ77VpQXFaErNtMuTVpwB3frpTBbf3SaH/hVjLZ7zzvrkrFyxbRJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765360983; c=relaxed/simple;
	bh=2XQ2sMN+MComRS2KpFRsH1SCqOmxB+x4+JWmkyszU8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lBsxo2RblaFC9mPXXSsQoTlSu44pGp0bpMUyWDg2APT+OkOPQ9+H0Rg6mUbU7I69yrYbMECsz5zR1WbmD/q7M4f97kDU4G/KDjKtRg0l3JJixPRldSyO5mEAed+G5HrnG0u2zMsxEriw/ckzDSPLs7vwIC7p6akAPVT4YQDgkW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+23vG1f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+23vG1f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A5AC113D0;
	Wed, 10 Dec 2025 10:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765360983;
	bh=2XQ2sMN+MComRS2KpFRsH1SCqOmxB+x4+JWmkyszU8o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=p+23vG1fl6HiJRBM8T1W5MaF95oAfnVH/VqeL6cDTgbMmqjDX+nDSTXdfkv4eLKvJ
	 12Txpvxf/MwsjNL7+XDGLU+lind0V5UESytNHiPK8foy2hZAFEFD+9r4MciPGWViPn
	 /Qit8a6pIbbWEZSn5OkfMIwl4oEhot/pKRXfbJOCbXEWUO9WaRY4WzEo/M5mUXbqlJ
	 WzAbt3hSVN4U1T0jsVC9JkafL3sbqC8nXPrbzKh6pC4kMwJbunMh4ogHSWr5tWt7mX
	 SW1EgvmD1nxT/odSyaioZks6nNChd9Iyau/N7kEHarz6jvZDm/uoY/CX7q37Ri6GSw
	 JwT51FVP5eWBA==
Message-ID: <3109f99b-3eb2-478f-a062-37a92a7ba035@kernel.org>
Date: Wed, 10 Dec 2025 11:03:00 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 2/2] mptcp: add sk_is_msk helper
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1765354225.git.tanggeliang@kylinos.cn>
 <1c8e8e95896e6f34a677eec690bc9edf493fd4fe.1765354225.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <1c8e8e95896e6f34a677eec690bc9edf493fd4fe.1765354225.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 10/12/2025 09:12, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch introduces a sk_is_msk() helper modeled after sk_is_tcp() to
> determine whether the socket is an MPTCP one. Unlike sk_is_mptcp(), which
> accepts a subflow socket as its parameter, this new helper specifically
> accepts an MPTCP socket parameter.
> 
> Note: This helper will be useful in the subsequent "MPTCP KTLS support"
> series.

It might be easier to introduce it there then, see below.

> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  include/net/mptcp.h  | 12 ++++++++++++
>  net/mptcp/protocol.h |  2 +-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 4cf59e83c1c5..82660374859a 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -150,6 +150,13 @@ static inline bool rsk_drop_req(const struct request_sock *req)
>  	return tcp_rsk(req)->is_mptcp && tcp_rsk(req)->drop_req;
>  }
>  
> +static inline bool sk_is_msk(const struct sock *sk)
> +{
> +	return sk_is_inet(sk) &&
> +	       sk->sk_type == SOCK_STREAM &&
> +	       sk->sk_protocol == IPPROTO_MPTCP;
> +}
> +
>  void mptcp_space(const struct sock *ssk, int *space, int *full_space);
>  bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
>  		       unsigned int *size, struct mptcp_out_options *opts);
> @@ -258,6 +265,11 @@ static inline bool rsk_drop_req(const struct request_sock *req)
>  	return false;
>  }
>  
> +static inline bool sk_is_msk(const struct sock *sk)

I do wonder if we shouldn't take this opportunity to rename sk_is_mptcp
to something less confusing: sk has to be a TCP sk and we are looking at
subflows, not MPTCP socket... tp_is_subflow or tp_is_mptcp or
tp_is_mptcp_subflow or sk_is_subflow or ...

But to be discussed first: sk_is_mptcp is mainly used in TCP code and
that might cause issues for the backports.

I don't know what people think about that. We already discussed that before:

  https://github.com/multipath-tcp/mptcp_net-next/issues/453

Same for rsk_is_mptcp.

> +{
> +	return false;
> +}
> +
>  static inline bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
>  				     unsigned int *size,
>  				     struct mptcp_out_options *opts)
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index f418a0a0fa51..8f1fd74ecaa3 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -404,7 +404,7 @@ static inline void msk_owned_by_me(const struct mptcp_sock *msk)
>  })
>  #define mptcp_sk(ptr) ({						\
>  	typeof(ptr) _ptr = (ptr);					\
> -	WARN_ON(_ptr->sk_protocol != IPPROTO_MPTCP);			\
> +	WARN_ON(!sk_is_msk(_ptr));					\

Same here, I don't think we should/need to do that.

>  	container_of_const(_ptr, struct mptcp_sock, sk.icsk_inet.sk);	\
>  })
>  

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

