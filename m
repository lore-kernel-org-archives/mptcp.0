Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7482B34BA24
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 02:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780020643; cv=none; b=jDcG3AXF63DhKLzHfS/TPyYnKVR4DA+RFbU7oCtkhofy47Y1dbpqd6LNbXtLPO9cfHNPlDaehXtBkP4Behb9VJdALjEvfSdVeP64CXMsYepAc64JspqjdDgvzkT1op6vJGp7jQuLadPmNUjFxYcqRjz+QDvn+ooounawhHQ5vjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780020643; c=relaxed/simple;
	bh=zwMFLNjg72gd0/m3Z9NeTYdjGPc4fatBTJG4k1hBVqI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QbfDE474B2XcfHyEx8MV104dbPu8MYridWblsTlCSKtzolRI74dEs+JFH1brwc2QuIbVxoXEn7ndLo86mK5nMI8er8QkXDy1+LWGrGZTkP/544qAMSqre8Apdia+mQIIbOg7F0UQPJXiv8Ytx3CxhmsYelsmb87+O4ALBueWeyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZGHneTV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZGHneTV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18EB21F000E9;
	Fri, 29 May 2026 02:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780020642;
	bh=Mi/hVyOs/FGczNgc0peG2HAcglsfPjVq735zVc1k6kI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=GZGHneTVTjBwMTN8Wr8ongOnh/0KMhAXTHaCUAG5xx9fC36g1gJetOJDd9hsU8uVj
	 JmhtlZi2eVQhJbnfPUzlcSAKLouKs05wyO+s8uj2+2QPqlz4/lfgwep8xFQV1gVlcd
	 d7aZT2QSDR4vUwVnAYV764/KgNd20ZKviBxFcCTdvcbpWcyk7nBgW1IlU38JaDAG5S
	 +SyoDns0jSiLC1Nk1z62Pym81Vnqk+Uuex7rv7kq+ZMF3OpLjW5GTCP1zHNL73QRFs
	 Fe8IIzkM5PK9Ch8TMZLDk6/0fpuTN7iAh+OxMRVGlxPRk33k+/s2aztXIwLVa3dz6K
	 KeIdTGoO4Atmg==
Date: Thu, 28 May 2026 19:10:41 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: MPTCP Linux <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-next v3 04/16] mptcp: pm: avoid computing add_addr
 size twice
In-Reply-To: <20260520-mptcp-add-addr6-port-ts-v3-4-bffa658a7678@kernel.org>
Message-ID: <b3b7a176-b03e-9825-aaa0-0a4269fe93e2@kernel.org>
References: <20260520-mptcp-add-addr6-port-ts-v3-0-bffa658a7678@kernel.org> <20260520-mptcp-add-addr6-port-ts-v3-4-bffa658a7678@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 20 May 2026, Matthieu Baerts (NGI0) wrote:

> mptcp_add_addr_len helper was called twice: in mptcp_pm_add_addr_signal,
> then just after in mptcp_established_options_add_addr. Both to check
> the remaining space.
>
> The second call is not needed: if there is not enough space,
> mptcp_pm_add_addr_signal will return false, and the caller,
> mptcp_established_options_add_addr, will do the same without re-checking
> the size again. Instead, mptcp_pm_add_addr_signal can directly set the
> size.
>
> Note that the returned size can be negative when other suboptions are
> dropped, e.g. to send an echo ADD_ADDR with a v4 address, and no port.
>
> While at it, move mptcp_add_addr_len to pm.c, as it is now only used
> from there, once, and use a bool for 'ret' in mptcp_pm_add_addr_signal.
>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> v2: reset size in mptcp_pm_add_addr_signal if other options are dropped.
> ---
> net/mptcp/options.c  | 16 +++-------------
> net/mptcp/pm.c       | 26 ++++++++++++++++++++++----
> net/mptcp/protocol.h | 17 +----------------
> 3 files changed, 26 insertions(+), 33 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 231010aaf163..c6d57997110d 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -659,34 +659,25 @@ static bool mptcp_established_options_add_addr(struct sock *sk,
> 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
> 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
> 	bool drop_other_suboptions = false;
> -	unsigned int opt_size = *size;
> 	struct mptcp_addr_info addr;
> 	bool echo;
> -	int len;
>
> 	/* add addr will strip the existing options, be sure to avoid breaking
> 	 * MPC/MPJ handshakes
> 	 */
> 	if (!mptcp_pm_should_add_signal(msk) ||
> 	    (opts->suboptions & (OPTION_MPTCP_MPJ_ACK | OPTION_MPTCP_MPC_ACK)) ||
> -	    !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, &addr,
> -		    &echo, &drop_other_suboptions))
> +	    !mptcp_pm_add_addr_signal(msk, skb, size, remaining, &addr, &echo,
> +				      &drop_other_suboptions))
> 		return false;
>
> 	/*
> 	 * Later on, mptcp_write_options() will enforce mutually exclusion with
> 	 * DSS, bail out if such option is set and we can't drop it.
> 	 */
> -	if (drop_other_suboptions)
> -		remaining += opt_size;
> -	else if (opts->suboptions & OPTION_MPTCP_DSS)
> +	if (!drop_other_suboptions && opts->suboptions & OPTION_MPTCP_DSS)
> 		return false;
>
> -	len = mptcp_add_addr_len(addr.family, echo, !!addr.port);
> -	if (remaining < len)
> -		return false;
> -
> -	*size = len;
> 	if (drop_other_suboptions) {
> 		pr_debug("drop other suboptions\n");
> 		opts->suboptions = 0;
> @@ -697,7 +688,6 @@ static bool mptcp_established_options_add_addr(struct sock *sk,
> 		 * options
> 		 */
> 		opts->ahmac = 0;
> -		*size -= opt_size;
> 	}
> 	opts->addr = addr;
> 	opts->suboptions |= OPTION_MPTCP_ADD_ADDR;
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index e78a248414fb..07536d5ba1ab 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -887,14 +887,30 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
> 	}
> }
>
> +static unsigned int mptcp_add_addr_len(int family, bool echo, bool port)
> +{
> +	u8 len = TCPOLEN_MPTCP_ADD_ADDR_BASE;

I'm not sure why this helper originally used u8 internally and then 
returned an unsigned int... This would be a good time to make everything 
consistantly 'int'.

- Mat


> +
> +	if (family == AF_INET6)
> +		len = TCPOLEN_MPTCP_ADD_ADDR6_BASE;
> +	if (!echo)
> +		len += MPTCPOPT_THMAC_LEN;
> +	/* account for 2 trailing 'nop' options */
> +	if (port)
> +		len += TCPOLEN_MPTCP_PORT_LEN + TCPOLEN_MPTCP_PORT_ALIGN;
> +
> +	return len;
> +}
> +
> bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
> -			      unsigned int opt_size, unsigned int remaining,
> +			      int *size, int remaining,
> 			      struct mptcp_addr_info *addr, bool *echo,
> 			      bool *drop_other_suboptions)
> {
> 	bool skip_add_addr = false;
> -	int ret = false;
> +	bool ret = false;
> 	u8 add_addr;
> +	int len = 0;
> 	u8 family;
> 	bool port;
>
> @@ -909,7 +925,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
> 	 * if any, will be carried by the 'original' TCP ack
> 	 */
> 	if (skb && skb_is_tcp_pure_ack(skb)) {
> -		remaining += opt_size;
> +		len -= *size;
> 		*drop_other_suboptions = true;
> 	}
>
> @@ -926,7 +942,8 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
> 		family = msk->pm.local.family;
> 	}
>
> -	if (remaining < mptcp_add_addr_len(family, *echo, port)) {
> +	len += mptcp_add_addr_len(family, *echo, port);
> +	if (len > remaining) {
> 		struct net *net = sock_net((struct sock *)msk);
>
> 		if (!*drop_other_suboptions)
> @@ -942,6 +959,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
> 	}
>
> 	ret = true;
> +	*size = len;
>
> drop_signal_mark:
> 	WRITE_ONCE(msk->pm.addr_signal, add_addr);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 6f3c73ad4284..6fb5caeebc35 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -1209,23 +1209,8 @@ static inline bool mptcp_pm_is_kernel(const struct mptcp_sock *msk)
> 	return READ_ONCE(msk->pm.pm_type) == MPTCP_PM_TYPE_KERNEL;
> }
>
> -static inline unsigned int mptcp_add_addr_len(int family, bool echo, bool port)
> -{
> -	u8 len = TCPOLEN_MPTCP_ADD_ADDR_BASE;
> -
> -	if (family == AF_INET6)
> -		len = TCPOLEN_MPTCP_ADD_ADDR6_BASE;
> -	if (!echo)
> -		len += MPTCPOPT_THMAC_LEN;
> -	/* account for 2 trailing 'nop' options */
> -	if (port)
> -		len += TCPOLEN_MPTCP_PORT_LEN + TCPOLEN_MPTCP_PORT_ALIGN;
> -
> -	return len;
> -}
> -
> bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
> -			      unsigned int opt_size, unsigned int remaining,
> +			      int *size, int remaining,
> 			      struct mptcp_addr_info *addr, bool *echo,
> 			      bool *drop_other_suboptions);
> bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
>
> -- 
> 2.53.0
>
>
>
