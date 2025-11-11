Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3803A1D0B
	for <mptcp@lists.linux.dev>; Tue, 11 Nov 2025 17:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762882706; cv=none; b=Qxdv1EDwGMG3clJKr7a0P4WAUCPfiqs9awV0IdfrYPcxAH8fiMP4wbttW88OfAvOI56rq5hd/Qb1g91G4yz8whGPF1/NP7RLVD6EwIxhDuUhzRX+T7RAdoHUxtThIhQ9TByqAilgslq6rvjE+uyqZiC327sY9IoJNp6RLWLB2Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762882706; c=relaxed/simple;
	bh=oMyLNUg4iu6TqLH5y/e++9SwWlCr+1/HwtCqWABmNR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=AHwvOcNJzKzC2yCbeMNbJQ5U6AC/8E3pUFJ+xQ5R4WFNjiMj9ez5gl7CqEc1Nsd8WlhfjgigaFzP6NEN84HcWHF1iQ2Kmp1Udd9XuEChW/RSR+hGp3o2mTKodQd9lJRUTMXOXyFCuj7PMi8IXY5urfqnlIZty9P2G0IPZhMXiiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIlwlYqy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIlwlYqy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49176C4CEF5;
	Tue, 11 Nov 2025 17:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762882705;
	bh=oMyLNUg4iu6TqLH5y/e++9SwWlCr+1/HwtCqWABmNR4=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=IIlwlYqymM8WTGgjkEi3xDa8S6TnEHOfXhnK4TBcSj1+VXp1SL93hkC/Pv4D+Zhc5
	 zsd2xqdpS9SXqavSUPdhWS2wyj44B1Cdm3GsvalyYcUL5diEE2mV6FH1/8yPzyyLJE
	 285+5vyf3oq6bPHjSyToS8jhdul+vQrZ77bptaqMts1WvLGVMG4p8kbkvSGfWkPr+R
	 6fEOmIgpLni7J1MkP9DBUuixR2029ZaJgxFZCqK9B/61yiTtvbLrdboRHrI7aMlueD
	 RXa5QlSbABmivdg4rvU5ysfhOfTUoIoO/OhAcqMGklfMjnq5rKZFH+khN0JPu7D25q
	 GBF/R6hRQjlww==
Message-ID: <a2449ccf-69a5-4503-a687-074b4436223a@kernel.org>
Date: Tue, 11 Nov 2025 18:38:23 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net 1/3] net: factor-out _sk_charge() helper
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>
References: <cover.1762551942.git.pabeni@redhat.com>
 <063e2bc8e98ce050286eb4309bf4bd47716cc3f8.1762551942.git.pabeni@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <063e2bc8e98ce050286eb4309bf4bd47716cc3f8.1762551942.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 07/11/2025 22:55, Paolo Abeni wrote:
> Move out of __inet_accept() the code dealing charging newly
> accepted socket to memcg. MPTCP will soon use it to on a per
> subflow basis, in different contexts.
> 
> No functional changes intended.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  include/net/sock.h |  2 ++
>  net/core/sock.c    | 18 ++++++++++++++++++
>  net/ipv4/af_inet.c | 17 +----------------
>  3 files changed, 21 insertions(+), 16 deletions(-)
> 
> diff --git a/include/net/sock.h b/include/net/sock.h
> index a5f36ea9d46f..38d48cfe0741 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1631,6 +1631,8 @@ static inline void sk_mem_uncharge(struct sock *sk, int size)
>  	sk_mem_reclaim(sk);
>  }
>  
> +void __sk_charge(struct sock *sk, gfp_t gfp);
> +
>  #if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
>  static inline void sk_owner_set(struct sock *sk, struct module *owner)
>  {
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 3b74fc71f51c..b26a6cdc9bcd 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -3448,6 +3448,24 @@ void __sk_mem_reclaim(struct sock *sk, int amount)
>  }
>  EXPORT_SYMBOL(__sk_mem_reclaim);
>  
> +void __sk_charge(struct sock *sk, gfp_t gfp)
> +{
> +	int amt;
> +
> +	gfp |= __GFP_NOFAIL;
> +	if (mem_cgroup_from_sk(sk)) {
> +		/* The socket has not been accepted yet, no need
> +		 * to look at newsk->sk_wmem_queued.
> +		 */
> +		amt = sk_mem_pages(sk->sk_forward_alloc +
> +				   atomic_read(&sk->sk_rmem_alloc));
> +		if (amt)
> +			mem_cgroup_sk_charge(sk, amt, gfp);
> +	}
> +
> +	kmem_cache_charge(sk, gfp);
> +}
> +
>  int sk_set_peek_off(struct sock *sk, int val)
>  {
>  	WRITE_ONCE(sk->sk_peek_off, val);
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index a31b94ce8968..08d811f11896 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -756,23 +756,8 @@ EXPORT_SYMBOL(inet_stream_connect);
>  void __inet_accept(struct socket *sock, struct socket *newsock, struct sock *newsk)
>  {
>  	if (mem_cgroup_sockets_enabled) {
> -		gfp_t gfp = GFP_KERNEL | __GFP_NOFAIL;
> -
>  		mem_cgroup_sk_alloc(newsk);
> -
> -		if (mem_cgroup_from_sk(newsk)) {
> -			int amt;
> -
> -			/* The socket has not been accepted yet, no need
> -			 * to look at newsk->sk_wmem_queued.
> -			 */
> -			amt = sk_mem_pages(newsk->sk_forward_alloc +
> -					   atomic_read(&newsk->sk_rmem_alloc));
> -			if (amt)
> -				mem_cgroup_sk_charge(newsk, amt, gfp);
> -		}
> -
> -		kmem_cache_charge(newsk, gfp);

Mmh, this code has been moved from inet_csk_accept() to __inet_accept()
in net-next only, see commit 4a997d49d92a ("tcp: Save lock_sock() for
memcg in inet_csk_accept()."):

  https://lore.kernel.org/20251014235604.3057003-2-kuniyu@google.com

Should we only apply these patches in our export branch, for net-next?
If yes, then I guess we should remove the Fixes tag in patch 3/3.

> +		__sk_charge(newsk, GFP_KERNEL);
>  	}
>  
>  	sock_rps_record_flow(newsk);

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

