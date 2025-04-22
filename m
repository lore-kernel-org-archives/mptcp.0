Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BDE1EFF8E
	for <mptcp@lists.linux.dev>; Tue, 22 Apr 2025 11:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745320718; cv=none; b=lUD8cmi16DHCjom37Vgn3MgiR5H6CreOV7roP/mSGaZsAK+a7Lgm/3W9ZnRWkLKItggDcEC8qArkUustzdLY/Vgdm8EfrbscZST0w4lZ3myLISzZx9kXMeUrIYef5w5erUJvHl173IXeV3JreoOP3E0FzddUCT/WbhHl4iZZfMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745320718; c=relaxed/simple;
	bh=9v2GwHVK+pzEOrlq+tFp/dt9nz6ES1vE87BVYXTlBzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jOrz2GuseuBw21E1PPZDCgFGwrcZI0p2j2wjFvsY8p5mDg9Z4GGbon/LV8ec11Tgs3Bs1wqktED/7FMrFu3CkS3lAaC0e12WIpKyABk5StOqJUOvfwgPjYcQkawQXZAxZGddEF14rAXrsMkWpdq/GII7UHDsrWxLVu/10XYG3Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQlF6+rR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQlF6+rR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73213C4CEF0;
	Tue, 22 Apr 2025 11:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745320718;
	bh=9v2GwHVK+pzEOrlq+tFp/dt9nz6ES1vE87BVYXTlBzM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bQlF6+rRNghFDB22xufqVPn7MVFttSDJqFvWXaS9aOJHMScBexee+EcJ6RhKwF/b5
	 wCMl5xzmq8xYDkJNxFbVfuPZBpP71sL+yrwSvH34pj8y/LikojFoT/8Xd4M9ySR0Kn
	 jdGpKXcMQi80Yt3/meHuhqBmuCsqATSIAaezD4G/HSXlxjUCFR9UGY1R0FFeCgS3pw
	 4+5GCg4wlyb+vGYEcDkvtzVXkXx+H2Lja1hNEmpTVJ9ir2oSp57dX/U0QZPHNYxX9S
	 2RbTfqm944C3KM48uxeqFEAanigiLx8w0VemdNHyy0RtPVX2g30WhX11iv5TuvfVJb
	 qKp2TCp2eKZ4g==
Message-ID: <4f396f53-aed8-4d59-a9b7-56827e1f0139@kernel.org>
Date: Tue, 22 Apr 2025 13:18:34 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v1 1/2] mptcp: add TCP_MAXSEG sockopt support
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1745314165.git.tanggeliang@kylinos.cn>
 <73d0d8594eaee83d2902ca23c3972ec5e6d628f4.1745314165.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <73d0d8594eaee83d2902ca23c3972ec5e6d628f4.1745314165.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 22/04/2025 11:30, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The TCP_MAXSEG socket option is currently not supported by MPTCP, mainly
> because it has never been requested before. But there are still valid
> use-cases, e.g. with HAProxy.
> 
> This patch adds its support in MPTCP by propagating the value to all
> subflows.

Thank you for looking at that.

> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/515
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/sockopt.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 3caa0a9d3b38..3014713b037c 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -798,6 +798,24 @@ static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
>  	return ret;
>  }
>  
> +static int mptcp_setsockopt_sol_tcp_maxseg(struct mptcp_sock *msk,
> +					   sockptr_t optval,
> +					   unsigned int optlen)

Might be good to have a generic helper, similar to
mptcp_setsockopt_first_sf_only(), no?

  mptcp_setsockopt_all_subflows()

> +{
> +	struct mptcp_subflow_context *subflow;
> +
> +	mptcp_for_each_subflow(msk, subflow) {

If there is no subflows (listening sockets?), you might need to call
mptcp_setsockopt_first_sf_only(), no?

> +		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +		int ret;
> +
> +		ret = tcp_setsockopt(ssk, SOL_TCP, TCP_MAXSEG, optval, optlen);

No need to lock around this call?

> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
>  				    sockptr_t optval, unsigned int optlen)
>  {
> @@ -819,6 +837,8 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
>  	case TCP_FASTOPEN_NO_COOKIE:
>  		return mptcp_setsockopt_first_sf_only(msk, SOL_TCP, optname,
>  						      optval, optlen);
> +	case TCP_MAXSEG:
> +		return mptcp_setsockopt_sol_tcp_maxseg(msk, optval, optlen);
>  	}
>  
>  	ret = mptcp_get_int_option(msk, optval, optlen, &val);
> @@ -1368,6 +1388,13 @@ static int mptcp_put_int_option(struct mptcp_sock *msk, char __user *optval,
>  	return 0;
>  }
>  
> +static int mptcp_getsockopt_sol_tcp_maxseg(struct mptcp_sock *msk,
> +					   char __user *optval,
> +					   int __user *optlen)
> +{
> +	return tcp_getsockopt(msk->first, SOL_TCP, TCP_MAXSEG, optval, optlen);

Same here: no need to lock? Also, msk->first can be NULL for listening
sockets, no?

Anyway, I think it is best not to change the way the socket options are
handled today: the socket option is propagated to existing and future
subflows. Look how "msk->keepalive_intvl" is handled in sockopt.c for
example.

- setsockopt: store the value (in case of success) in the msk.
- getsockopt: return this value (mptcp_put_int_option())

WDYT?

> +}
> +
>  static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
>  				    char __user *optval, int __user *optlen)
>  {
> @@ -1407,6 +1434,8 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
>  		return mptcp_put_int_option(msk, optval, optlen, msk->notsent_lowat);
>  	case TCP_IS_MPTCP:
>  		return mptcp_put_int_option(msk, optval, optlen, 1);
> +	case TCP_MAXSEG:
> +		return mptcp_getsockopt_sol_tcp_maxseg(msk, optval, optlen);
>  	}
>  	return -EOPNOTSUPP;
>  }

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

