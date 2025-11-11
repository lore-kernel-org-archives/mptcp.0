Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7286934D38B
	for <mptcp@lists.linux.dev>; Tue, 11 Nov 2025 07:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762845850; cv=none; b=HrYrT3DR+ihE+CfL5Rw8nJgnEBIQjYbaVYw1ZVOdpdvpVfqD9HgWvtwvmGXpjNf74965yPb343908S5EU231vvkX4+1RHjhKxdt9h83QsbgXtWWAFZCnj0M3Di+5CwOF4achjmnkzMRg1VXd2UO6I05VE5XrVqjTPxFcS38rauc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762845850; c=relaxed/simple;
	bh=OOLuuc+zgXtUc27pIlODuoNqZ3TYrfZjrgqTPotuRhQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jCbrCdjI8gcvLOXwwCuNmev0bSJmb1quOUFOr6CaSJ0K2LxvHGw9rviWR6gkKvqICkQjNML1bsEHB7EsYEyEeFdqH27ME5cbj4Wsb6M+Vc38HZ+trCk9aTDJTBP5oHqtw159H8/eMeirlVdzFyFm/oN36K7/ot77ktKgul+ZBA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFCU7o1r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFCU7o1r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BBB5C19425;
	Tue, 11 Nov 2025 07:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762845846;
	bh=OOLuuc+zgXtUc27pIlODuoNqZ3TYrfZjrgqTPotuRhQ=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=lFCU7o1rw4X6q79U0503wqZAPoTH6htWct1heqLZz7HWa7k2xeXvZg1Q4ClGGaOzd
	 i/n6lNQhmFFlzCndQIxea4SiSzocxC096vMui6LWaveKpSBvVQB+6kgFtzighUj+pq
	 bQfUjA3MTP0ql+1Tz4hlXI+2Ukorn0oWuh77RqXYXPzHA/0eGzzR7m7INQY55UVuL/
	 bjiO39TZ6PNTPeawKgAcvchi8ZMnjEKpD/0lTAqNJFgycIe3HpsaAj4/OBSybKgQW6
	 PbBtYxrP9kUbSXA3JLojqMFpqsUOumb9gvjPF74+OofF1KyMLW37FaC2Zm3MKlQK7L
	 /waUz6ve4CZYQ==
Message-ID: <06529ee9879cbd96d8dd177bcec7e2ac02b6a174.camel@kernel.org>
Subject: Re: [PATCH mptcp-net 1/3] net: factor-out _sk_charge() helper
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Date: Tue, 11 Nov 2025 15:24:04 +0800
In-Reply-To: <063e2bc8e98ce050286eb4309bf4bd47716cc3f8.1762551942.git.pabeni@redhat.com>
References: <cover.1762551942.git.pabeni@redhat.com>
	 <063e2bc8e98ce050286eb4309bf4bd47716cc3f8.1762551942.git.pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Paolo,

On Fri, 2025-11-07 at 22:55 +0100, Paolo Abeni wrote:
> Move out of __inet_accept() the code dealing charging newly
> accepted socket to memcg. MPTCP will soon use it to on a per
> subflow basis, in different contexts.
> 
> No functional changes intended.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

This patch looks good to me.

    Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> ---
>  include/net/sock.h |  2 ++
>  net/core/sock.c    | 18 ++++++++++++++++++
>  net/ipv4/af_inet.c | 17 +----------------
>  3 files changed, 21 insertions(+), 16 deletions(-)
> 
> diff --git a/include/net/sock.h b/include/net/sock.h
> index a5f36ea9d46f..38d48cfe0741 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1631,6 +1631,8 @@ static inline void sk_mem_uncharge(struct sock
> *sk, int size)
>  	sk_mem_reclaim(sk);
>  }
>  
> +void __sk_charge(struct sock *sk, gfp_t gfp);
> +
>  #if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
>  static inline void sk_owner_set(struct sock *sk, struct module
> *owner)
>  {
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 3b74fc71f51c..b26a6cdc9bcd 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -3448,6 +3448,24 @@ void __sk_mem_reclaim(struct sock *sk, int
> amount)
>  }
>  EXPORT_SYMBOL(__sk_mem_reclaim);
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
> +				   atomic_read(&sk->sk_rmem_alloc));
> +		if (amt)
> +			mem_cgroup_sk_charge(sk, amt, gfp);
> +	}
> +
> +	kmem_cache_charge(sk, gfp);
> +}
> +
>  int sk_set_peek_off(struct sock *sk, int val)
>  {
>  	WRITE_ONCE(sk->sk_peek_off, val);
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index a31b94ce8968..08d811f11896 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -756,23 +756,8 @@ EXPORT_SYMBOL(inet_stream_connect);
>  void __inet_accept(struct socket *sock, struct socket *newsock,
> struct sock *newsk)
>  {
>  	if (mem_cgroup_sockets_enabled) {
> -		gfp_t gfp = GFP_KERNEL | __GFP_NOFAIL;
> -
>  		mem_cgroup_sk_alloc(newsk);
> -
> -		if (mem_cgroup_from_sk(newsk)) {
> -			int amt;
> -
> -			/* The socket has not been accepted yet, no
> need
> -			 * to look at newsk->sk_wmem_queued.
> -			 */
> -			amt = sk_mem_pages(newsk->sk_forward_alloc +
> -					   atomic_read(&newsk-
> >sk_rmem_alloc));
> -			if (amt)
> -				mem_cgroup_sk_charge(newsk, amt,
> gfp);
> -		}
> -
> -		kmem_cache_charge(newsk, gfp);
> +		__sk_charge(newsk, GFP_KERNEL);
>  	}
>  
>  	sock_rps_record_flow(newsk);

