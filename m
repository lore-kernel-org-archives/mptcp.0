Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FDC207DF1
	for <mptcp@lists.linux.dev>; Wed,  4 Dec 2024 17:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733334553; cv=none; b=VNUxbeTW/6TDHVf0FdvwXk2EyH1pdrtxDuxmBoFhCk8S9T6orHG3PMbYQeaoYVueE8mcLA2vhtzLI9BYqeA7gLv/tY10RKyHY3zHflfDqfWdJDxgj5MQ+1QmpHK7sT9hgbKHcUjNdbN6B+q82SsgAep4yDy36i+0xj74xGsRfGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733334553; c=relaxed/simple;
	bh=CNB10lF6RH4rDjgTSL4Wzla24lpI3nRyRCPDj7083+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O3o62LCytyQqexMHCDriGD+QciHbsoiN15X7f4emSrN6RFX4n2TVLWvfhuG0qkZ5Xa/NEaByiHumtLL6BoubZz8/1FQiT00h3kRzuMovbhF66d4L05/h5xqpwLrrKbecW0dMKbB81TH9Plh02uCPPbtpClD3EfycXmjAAqn938I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sN783jms; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sN783jms"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D6FC4CECD;
	Wed,  4 Dec 2024 17:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733334552;
	bh=CNB10lF6RH4rDjgTSL4Wzla24lpI3nRyRCPDj7083+8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sN783jms2O1bHIZ5trgeCvgMOZsxpEXeYOixOYH4rWlVmhhH3x5Tmsj8bkh8uRfcl
	 N21yxLGWpNa7HqeR9G0oRR6uCssSodq4EPoNyjro1+Il/cZETwrGHHO2j0Ki86RZWx
	 lNWy5HGW7XYQhC49fqxW0yk3puJnAQR9lk4gqCmVSIBVEQn/d2yety3BLuDsVF4u+p
	 iiJwizlgDCDQvJ8J5X2SyBTOe32Is9AzKOHarhPFjVmzQtd0uxTTZ+A4eQO7sit6sw
	 qqQ6AMmmT0Nz9T+y+n1a8jG3dXTdXTjYC+OGI+1dIytdyPv9/cZlf7WrAsdmCCjZ0X
	 aTUs/rSmbPJ0Q==
Message-ID: <8ae81fdd-e402-4514-a446-0989bd49c32d@kernel.org>
Date: Wed, 4 Dec 2024 18:49:09 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3 9/9] mptcp: drop useless "err = 0" in
 subflow_destroy
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1730961809.git.tanggeliang@kylinos.cn>
 <6606e2c5b8b3536cad35baf722175a932242d820.1730961810.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <6606e2c5b8b3536cad35baf722175a932242d820.1730961810.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 07/11/2024 07:45, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Upon successful return, mptcp_pm_parse_addr() returns 0. There is no need
> to set "err = 0" after this. So after mptcp_nl_find_ssk() returns, just
> need to set "err = -ESRCH", then release and free msk socket if it returns
> NULL.
> 
> Also, no need to define the veriable "subflow" in subflow_destroy(), use
> mptcp_subflow_ctx(ssk) directly.
> 
> This patch doesn't change the behaviour of the code, just refactoring.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/pm_userspace.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 07e0c7259494..8545212f023e 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -535,19 +535,18 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
>  
>  	lock_sock(sk);
>  	ssk = mptcp_nl_find_ssk(msk, &addr_l.addr, &addr_r);
> -	if (ssk) {
> -		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
> -
> -		spin_lock_bh(&msk->pm.lock);
> -		mptcp_userspace_pm_delete_local_addr(msk, &addr_l);
> -		spin_unlock_bh(&msk->pm.lock);
> -		mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
> -		mptcp_close_ssk(sk, ssk, subflow);
> -		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMSUBFLOW);
> -		err = 0;

OK to drop 'err = 0' but...

> -	} else {
> +	if (!ssk) {
>  		err = -ESRCH;
> +		release_sock(sk);
> +		goto destroy_err;

... I think it is always best to reduce the number of exit path: so
here, I think it is best to add a new label before release_sock(sk)
below, instead of duplicating this release_sock(sk). Something like:

      ssk = mptcp_nl_find_ssk(...);
      if (!ssk) {
          err = -ESRCH;
          goto release_sock;
      }

      (...)

  release_sock:
      release_sock(sk);

  destroy_err:
      (...)

WDYT?

>  	}
> +
> +	spin_lock_bh(&msk->pm.lock);
> +	mptcp_userspace_pm_delete_local_addr(msk, &addr_l);
> +	spin_unlock_bh(&msk->pm.lock);
> +	mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
> +	mptcp_close_ssk(sk, ssk, mptcp_subflow_ctx(ssk));
> +	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMSUBFLOW);
>  	release_sock(sk);
>  
>  destroy_err:

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

