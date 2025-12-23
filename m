Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C003A2882AA
	for <mptcp@lists.linux.dev>; Tue, 23 Dec 2025 16:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766507770; cv=none; b=t7r4GKwDr2ovga0/TRfBAsxR+PxmhTnAYz+QfEu3CgSYWdrxGnx1JNVWRnUprtjnlD6Ya2iY3+xZYV7NzOTGtUUTHofslf9xj/rLn/cWLRrr09kpPrcbcJTTOtIpmByJ4/kiqBRsqgBrzRG7CmnE+9k1eXDVhN5BIfGF8UjuZYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766507770; c=relaxed/simple;
	bh=qZne3ZHq4IxbzcNCBpVsK9Exbqp+wvRcTd2HA1LBxsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cou55XNKzwAE/RsNxBXrgekFSvZQ+fHYVPlAjS5pN/FI9oNSKUUCFXjMUXmgj1BoAQcjBtU1ZlM0nu44N+c6kwWqDHOn+rQb81oa3GD5FEdDYhkpyxWr1/or1Cqxhc8w/63BuufOu/IE7iquMOOIHiZHIzL/d2nlIe+0aaDz6uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Umd4Y34K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Umd4Y34K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 472FFC113D0;
	Tue, 23 Dec 2025 16:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766507770;
	bh=qZne3ZHq4IxbzcNCBpVsK9Exbqp+wvRcTd2HA1LBxsk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Umd4Y34KknCcEew7oSouMEVxznrUjEix5cx4vDRsSFjZUqJ5T3trBkeD+mDnuUXe5
	 tBgXI7EulXzx/dLVY2VBZnYpVJw68dP3zWINzkl5sPqYSsnSQ23NC69SzkUEspfOKs
	 /QDBVcWBT/7ntfSVjD5iKqTrah7AcGaUf4TfBEhGz2ynaT/aNBDQdRFMwudL8GimPG
	 i6k5p0eqDXJ0sITmlzf/QymqMsN67HN9gcvITJ9whNg3sZ/ZZFXRH/IbymrGAQQiYM
	 vsuP7Yj6Y/CWE/z7zPutGqOKKkuMe9iG7da0AIimGjOprThtuKYXoYma0RK0hTrX46
	 iJIpUdGbz1N/A==
Message-ID: <73c89089-b8fb-42a0-a86c-69af2e33eb0a@kernel.org>
Date: Tue, 23 Dec 2025 17:36:07 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC mptcp-next v5 1/8] tls: introduce struct tls_prot_ops
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>, Gang Yan <yangang@kylinos.cn>
References: <cover.1766372799.git.tanggeliang@kylinos.cn>
 <292fd0d8ad99a937e82440e4de45719388d959e8.1766372799.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <292fd0d8ad99a937e82440e4de45719388d959e8.1766372799.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 22/12/2025 04:15, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> To extend MPTCP support based on TCP TLS, a tls_prot_ops structure
> has been introduced for TLS, encapsulating both TCP-specific and
> MPTCP-specific helpers within this structure. A pointer to this
> structure, named 'ops', has been added to the tls_context. The places
> originally calling TLS-specific helpers have now been modified to
> indirectly invoke them via 'ops' pointer in the tls_context.

Thank you for this new version, it looks better!

(...)

> diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
> index 56ce0bc8317b..20f7eb438771 100644
> --- a/net/tls/tls_main.c
> +++ b/net/tls/tls_main.c

(...)

> @@ -760,6 +760,12 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
>  		ctx->rx_conf = conf;
>  	update_sk_prot(sk, ctx);
>  
> +	if (sk_is_tcp(sk))

I wonder if it would not be better to register each ops in an array /
list, and add the protocol number in the ops. Then here, use the right
ops corresponding to the sk->sk_protocol.

(I don't think you need 'sk_is_tcp()' here, I guess this helper can only
be called for a TCP connection. When MPTCP is added, only the protocol
will differ. Then 'sk_is_msk(sk)' is probably not needed)

> +		ctx->ops = &tls_tcp_ops;

I guess you should handle the case where ctx->ops is not set.

> +
> +	if (!tls_validate_prot_ops(ctx->ops))

I don't think this validation should be done for each connection. If
required, it should be done when registering the ops.

> +		return -EINVAL;

I think this block should come before "update_sk_prot()" (or you need to
cancel the update).

> +
>  	if (update)
>  		return 0;

(...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

