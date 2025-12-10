Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E234B2264C7
	for <mptcp@lists.linux.dev>; Wed, 10 Dec 2025 09:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765360452; cv=none; b=e5LTyif2rUiUQr65YshV3asCwhymNXJgQ1jcdHvfRNmSDFvfyh0SKa33di+leGG8B5flyjSd6XZtmoUmwzcI9A7+g9GpsvO6FGRakKEzHIvKiAwTkoL0t2ty24uv5wJTEbdWyi0qnKrm6XziERv1xE/ChGtMkD3HVBDeIDeS7Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765360452; c=relaxed/simple;
	bh=v0HPEpZNi3ydQ9HpfXiDKLDUXRqaXKOq7o4910dAYe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a61oyOqcBaVOhNMEeF7+HeNDuF8nAP80rWVAkNjWIYczVhiX27SGzfL09jDjGJwTjKSeO0jHeZuJkdTIqtFvTTpVQOHupWvjZejxUp6pOwOxxbrRzEPzO36K3wQjlDQEbhjAgBp/6U+6Vqj4Lh8EVE+40n6v+nGNrXA128Jud1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcuzVyJY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcuzVyJY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD326C4CEF1;
	Wed, 10 Dec 2025 09:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765360451;
	bh=v0HPEpZNi3ydQ9HpfXiDKLDUXRqaXKOq7o4910dAYe8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IcuzVyJYHz+iP8PnU6O8sSKWCPWBNaisspFnIizz+UUZBEjgK7Yt4RBmfAaNwD3SM
	 Duc0fGqf/L0Lql6pqf6A1DFSnJAEWC3qhMz7NHB+pX2xyTEDAJDF/U4RKH0IdibTiq
	 jOioI94JXoDa9G6Y2M9nZwoxPUDhq4dX1IVx7kTYuSME+AUYjIJrsCSC0WKvIScJD5
	 993mTggqwKR3BlIhLHtiHKEf5boAHxiaBdwmet2RyBsGxWBc5Fzs8AgQp+++lrlEYd
	 Fu6cBRnCDjhGf0uTEoDtsDFaoO4Ox0Xmzro5dw05btklKan0Y5vYaYOYEm48F7FDcS
	 RDPs1gMPKva2Q==
Message-ID: <b0db8dd7-a0dd-4673-bfa5-a62ebf8facc5@kernel.org>
Date: Wed, 10 Dec 2025 10:54:08 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 1/2] mptcp: use sk_is_tcp helper
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1765354225.git.tanggeliang@kylinos.cn>
 <f33c663ae39d50dbca2623822519f5628c04f9f0.1765354225.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <f33c663ae39d50dbca2623822519f5628c04f9f0.1765354225.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

Thank you for the patches.

On 10/12/2025 09:12, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch enhances the validation by using sk_is_tcp to determine whether
> the socket is a TCP socket. This approach is more rigorous than simply
> checking if sk_protocol equals IPPROTO_TCP, as the helper also verifies
> sk_family and sk_type.
> 
> Note: The modifications in the bpf_sk_stream_memory_free section should be
> squashed into the commit "bpf: Export mptcp packet scheduler helpers".
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/bpf.c      | 4 ++--
>  net/mptcp/protocol.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index b261551f5d1b..372a21b96495 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -193,7 +193,7 @@ static struct bpf_struct_ops bpf_mptcp_sched_ops = {
>  
>  struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
>  {
> -	if (sk && sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk))
> +	if (sk && sk_fullsock(sk) && sk_is_tcp(sk) && sk_is_mptcp(sk))

I know that BPF has a few extra "hidden" checks: are you adding this
because you saw issues where the protocol could be set to TCP, but the
family and type are not the expected ones?

If not, it might be harder to justify these patches upstream.

>  		return mptcp_sk(mptcp_subflow_ctx(sk)->conn);
>  
>  	return NULL;
> @@ -294,7 +294,7 @@ __bpf_kfunc static bool bpf_sk_stream_memory_free(const struct sock *sk__ign)
>  	const struct sock *sk = sk__ign;
>  
>  	if (sk && sk_fullsock(sk) &&
> -	    sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk))
> +	    sk_is_tcp(sk) && sk_is_mptcp(sk))
>  		return sk_stream_memory_free(sk);
>  
>  	return NULL;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index cd5266099993..f418a0a0fa51 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -399,7 +399,7 @@ static inline void msk_owned_by_me(const struct mptcp_sock *msk)
>  #undef tcp_sk
>  #define tcp_sk(ptr) ({								\
>  	typeof(ptr) _ptr = (ptr);						\
> -	WARN_ON(_ptr->sk_protocol != IPPROTO_TCP);				\
> +	WARN_ON(!sk_is_tcp(_ptr));						\

I don't think we should change that here. That will potentially cause
issues with kunit, but also the check here is mainly to catch that
'tcp_sk()' is not called with an MPTCP socket. So only the protocol
check is needed.

>  	container_of_const(_ptr, struct tcp_sock, inet_conn.icsk_inet.sk);	\
>  })
>  #define mptcp_sk(ptr) ({						\

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

