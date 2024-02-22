Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71803ECC
	for <mptcp@lists.linux.dev>; Thu, 22 Feb 2024 02:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708569179; cv=none; b=PbP92R8RQWYVgByLGTlOR7B6iBhbhj/auUIGoksB1PMukXwXfinMIVXgsiW6UKILWQtUjUfwUYxPjM2CsGgDcUKJAIf7Ew4jCf55a6z2TEbiR+2oIkOYkT5D8iM8RHnpBECqzlsjvHYkuohjl52+KcFWS1AKSkLChJD9oEjuDhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708569179; c=relaxed/simple;
	bh=VBpSxzyRJi2v8asVXDtRz9CJD0WLZ/2fE+mqp1RcvBg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=md8g0bRvVvQY0KmKIbRrkL5KmVqjIs3mmExMORdgTGVcFK/EXsxpCHV9+3lbKZ8veYMo2lfh4YuJWPSGt/HqkVuL9F4PeLW51oeb4sRYTe/1YTdDEJTW6VLpPaeVvHm1gCYeNR8otXqB5IECHLwYSYwLnGy2niJEKsfQ9D6cs5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtqM2G8v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtqM2G8v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72DDC433F1;
	Thu, 22 Feb 2024 02:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708569179;
	bh=VBpSxzyRJi2v8asVXDtRz9CJD0WLZ/2fE+mqp1RcvBg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=BtqM2G8v6svDJtTXlZc4Q5YynItOSPNWaMhJey8D1wlHPFgzN8rhctliIR75sZg/9
	 8Wwsc6qgGaETSj/VouF9S16tNpJwG0S90IUCiyG+cySwYYGVZQIeBPnZbL/tiNRPvW
	 /eCZnw0v02bWWkqe4BCp6tctDaCyYAJ19zCgM0KLWisxnOjveNw+lmy16FENSs7Vdb
	 BdK5uaEA8in1IzbnvdJUGQkKTsG9rPSjYlfRErzXRfVuWPfoCReWi8I0VfnndRp8Z4
	 PwhGgrB/c0kM52G9cAlz6zo3iCuaYBVdjWeDmGus4oA+bThnwqpsqextmPE2Nj0r4X
	 kgLCgZ7HXfQAA==
Date: Wed, 21 Feb 2024 18:32:58 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Davide Caratti <dcaratti@redhat.com>
cc: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net] mptcp: fix double-free on socket dismantle
In-Reply-To: <47b5459f6b9b07c5a669d5a5233b35cf6ec601ac.1708532911.git.dcaratti@redhat.com>
Message-ID: <dfe6b689-b36e-a38d-aed0-8894c99e382d@kernel.org>
References: <47b5459f6b9b07c5a669d5a5233b35cf6ec601ac.1708532911.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 21 Feb 2024, Davide Caratti wrote:

> when MPTCP server accepts an incoming connection, it clones its listener
> socket. However, the pointer to 'inet_opt' for the new socket has the same
> value as the original one: as a consequence, on program exit it's possible
> to observe the following splat:
>
...
>
> Something similar (a refcount underflow) happens with CALIPSO/IPv6. Fix
> this by duplicating IP / IPv6 options after clone, so that
> ip{,6}_sock_destruct() doesn't end up freeing the same memory area twice.
>
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> ---
> net/mptcp/protocol.c | 49 ++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 49 insertions(+)

Thanks Davide. Looks good to me, and the appropriate "fixes" tag goes all 
the way back to the beginning:

Fixes: cf7da0d66cc1 ("mptcp: Create SUBFLOW socket for incoming connections")

Reviewed-by: Mat Martineau <martineau@kernel.org>


>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 50dcba41b6ef..352334bda0e3 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3202,8 +3202,50 @@ static struct ipv6_pinfo *mptcp_inet6_sk(const struct sock *sk)
>
> 	return (struct ipv6_pinfo *)(((u8 *)sk) + offset);
> }
> +
> +static void mptcp_copy_ip6_options(struct sock *newsk, const struct sock *sk)
> +{
> +	const struct ipv6_pinfo *np = inet6_sk(sk);
> +	struct ipv6_txoptions *opt;
> +	struct ipv6_pinfo *newnp;
> +
> +	newnp = inet6_sk(newsk);
> +
> +	rcu_read_lock();
> +	opt = rcu_dereference(np->opt);
> +	if (opt) {
> +		opt = ipv6_dup_options(newsk, opt);
> +		if (!opt)
> +			net_warn_ratelimited("%s: Failed to copy ip6 options\n", __func__);
> +	}
> +	RCU_INIT_POINTER(newnp->opt, opt);
> +	rcu_read_unlock();
> +}
> #endif
>
> +static void mptcp_copy_ip_options(struct sock *newsk, const struct sock *sk)
> +{
> +	struct ip_options_rcu *inet_opt, *newopt = NULL;
> +	const struct inet_sock *inet = inet_sk(sk);
> +	struct inet_sock *newinet;
> +
> +	newinet = inet_sk(newsk);
> +
> +	rcu_read_lock();
> +	inet_opt = rcu_dereference(inet->inet_opt);
> +	if (inet_opt) {
> +		newopt = sock_kmalloc(newsk, sizeof(*inet_opt) +
> +				      inet_opt->opt.optlen, GFP_ATOMIC);
> +		if (newopt)
> +			memcpy(newopt, inet_opt, sizeof(*inet_opt) +
> +			       inet_opt->opt.optlen);
> +		else
> +			net_warn_ratelimited("%s: Failed to copy ip options\n", __func__);
> +	}
> +	RCU_INIT_POINTER(newinet->inet_opt, newopt);
> +	rcu_read_unlock();
> +}
> +
> struct sock *mptcp_sk_clone_init(const struct sock *sk,
> 				 const struct mptcp_options_received *mp_opt,
> 				 struct sock *ssk,
> @@ -3224,6 +3266,13 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
>
> 	__mptcp_init_sock(nsk);
>
> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> +	if (nsk->sk_family == AF_INET6)
> +		mptcp_copy_ip6_options(nsk, sk);
> +	else
> +#endif
> +		mptcp_copy_ip_options(nsk, sk);
> +
> 	msk = mptcp_sk(nsk);
> 	WRITE_ONCE(msk->local_key, subflow_req->local_key);
> 	WRITE_ONCE(msk->token, subflow_req->token);
> -- 
> 2.43.0
>
>
>
