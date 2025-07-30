Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE4B26CE18
	for <mptcp@lists.linux.dev>; Wed, 30 Jul 2025 09:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753867576; cv=none; b=csfjwbUzJwdOxA/dqfV2iX9nixuqJ+qAngDNZKRYGSiPmQ2O0cH+KQ/LUJ7+X/FA2zokJL5OpHT2sydVPo870G0yOKZZf8/WtObDbyNscw7DYQGgiadW65oTiGKzsFle0M/utpk9a0dXsrucLPk+pS/4b33uB4/4dTiPanSo6Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753867576; c=relaxed/simple;
	bh=QN4lviOAaBLySaqOB6/WfaCFmFYmZiMjX8iOWPgfy/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IaYFX3dcss1vCO9zOEeemE2K4Zm/mDHaubTOYWfgDX/FxWuqHt+wd0Vbph/+Xek/LND111nVVlKkkd1MYkfW1AuNotuOB/eKTCR/85Hx6yFYPakQ5EjCjdbfpjgWVq2nIypPeZo8/TQHLquJ3Z8VapdjT2DdzbVuPvPfMGz3K1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPOCJsLZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPOCJsLZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E26C4CEF5;
	Wed, 30 Jul 2025 09:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753867576;
	bh=QN4lviOAaBLySaqOB6/WfaCFmFYmZiMjX8iOWPgfy/E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VPOCJsLZy5AmHYfG+4HfQBvKnsWnWLPlDxSuj6/QtWiwWxoWm0Nz7rN+/JC/BLs6E
	 NhnU47l+evae7aWXqFxMpa2t7jwJ1jYg8wUhMo7E6DGx4Js0nGhr9WXebG2Z7DC9Tr
	 5QsuiDIIfH01eQ1+r8iDEWVToYMC6+TW7j8CwKHdavbYAZrBVJgTT04tFLoujpaU0f
	 Fz+oMDwdifzad4zxgtRYa3O7FSjIxdl74MJqolDLLenC63FdjAzNHBSHHxwysL0+7N
	 3kwdE20FtboYmCq0yVzP3s/KOENE8lWSPqpZcU32vjIG/dAyi9uOqybrQ37P+Q9DpU
	 8j4RIGwrz5QNw==
Message-ID: <b56526fb-0807-4309-84af-5c38289e2ec4@kernel.org>
Date: Wed, 30 Jul 2025 11:26:13 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 2/3] mptcp: make ADD_ADDR timeout adaptive to
 subflow RTT
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1753777199.git.tanggeliang@kylinos.cn>
 <12b2e330c05554b030615375f82b5af1fb7b8289.1753777199.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <12b2e330c05554b030615375f82b5af1fb7b8289.1753777199.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 29/07/2025 10:22, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch makes the ADD_ADDR retransmission timeout adaptive by using
> the maximum subflow RTT, while still capping it at the configured max
> value (add_addr_timeout_max). This improves responsiveness when
> establishing new subflows.
> 
> The change:
>  - Adds mptcp_get_add_addr_timeout() helper
>  - Uses subflow RTT when available
>  - Falls back to max timeout otherwise
> 

Can you add the Closes tag here, so GitHub will automatically close the
ticket when this patch will be applied?

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/576

> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/pm.c | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 40e8ebe566e5..bf4d92293e1e 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -268,6 +268,27 @@ int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
>  	return -EINVAL;
>  }
>  
> +static unsigned int mptcp_get_add_addr_timeout(struct mptcp_sock *msk,
> +					       const struct net *net)
> +{
> +	unsigned int timeout = mptcp_get_add_addr_timeout_max(net);
> +	struct mptcp_subflow_context *subflow;
> +	unsigned int srtt_us = 0;
> +
> +	mptcp_for_each_subflow(msk, subflow) {
> +		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +		struct tcp_sock *tp = tcp_sk(ssk);
> +
> +		if (srtt_us < tp->srtt_us)

(detail: it feels more logical do have "if (tp->srtt_us > srtt_us)" if
you look for the max, but the result is the same)

> +			srtt_us = tp->srtt_us;
> +	}
> +
> +	if (srtt_us && srtt_us < timeout)

I don't think you can do that: timeout is in jiffies, while srtt_us is
in µsec. You need to use "usecs_to_jiffies(srtt_us)"

> +		timeout = srtt_us;

Taking just srtt_us doesn't seem to be a good idea as the ADD_ADDR echo
is supposed to arrive around srtt_us: this will certainly cause too
aggressive ADD_ADDR retransmissions if timeout is around the time the
echo is supposed to arrive.

I think we should imitate TCP here: using srtt_us and rttvar_us. (Or
start with "srtt_us << 1"?). Or maybe better to use "icsk->icsk_rto"
instead, but I don't know if it will be set to a correct value when we
will look, no?

> +
> +	return timeout;
> +}
> +
>  static void mptcp_pm_add_timer(struct timer_list *timer)
>  {
>  	struct mptcp_pm_add_entry *entry = timer_container_of(entry, timer,
> @@ -302,7 +323,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
>  
>  	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
>  		sk_reset_timer(sk, timer,
> -			       jiffies + mptcp_get_add_addr_timeout_max(sock_net(sk)));
> +			       jiffies + mptcp_get_add_addr_timeout(msk, sock_net(sk)));

I wonder if we should increase the time after each retransmission,
similar to what is done in TCP (timeout << entry->retrans_times). We
could keep it linear, but because this time now depends on the measured
srtt, it might be better to have an exponential backoff. It will still
need to be bounded to the max. In this case, it might be easier to pass
entry->retrans_times to mptcp_get_add_addr_timeout())

>  
>  	spin_unlock_bh(&msk->pm.lock);
>  
> @@ -354,7 +375,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
>  			return false;
>  
>  		sk_reset_timer(sk, &add_entry->add_timer,
> -			       jiffies + mptcp_get_add_addr_timeout_max(net));
> +			       jiffies + mptcp_get_add_addr_timeout(msk, net));
>  		return true;
>  	}
>  
> @@ -370,7 +391,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
>  
>  	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
>  	sk_reset_timer(sk, &add_entry->add_timer,
> -		       jiffies + mptcp_get_add_addr_timeout_max(net));
> +		       jiffies + mptcp_get_add_addr_timeout(msk, net));
>  
>  	return true;
>  }

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

