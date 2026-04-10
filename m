Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271013AD53F
	for <mptcp@lists.linux.dev>; Fri, 10 Apr 2026 09:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775812377; cv=none; b=WlKhFneWrNskbihiXyH8K8+36BHLWm2FMsNUFqzWqFcktuOD1tQRI22lDlq6oN+R+JnWob2nSbCk621Fm2gFxbxwDJ8w+SavKsH1Qbe9hGG8GhjaGgvhzhaRknHLtXhEtWUgT+uPlzBfaGZ1L7NHxyVxPkvjFor1Ut2TWh5dbac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775812377; c=relaxed/simple;
	bh=h34D2+ncpP6apR8rS36g2oEjVvk9sXKeBY3bxXEmbac=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ef5rqWr6RbK9mXyi/FhrhoOSN1MbPk29qwzvg72VCEQcA2wNhoT0O8A6/CU1Oq7ilPHr4h0Ma46pjRfzXn46W5k4Zj1vtbKqNOGTDqoayc3oTergsvmXD5yG6M8XnP/3xrv9c5V9XPZQXJpRB12LQ71EMv+/VGTKQY37DIe2Cpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlJmxYry; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlJmxYry"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614E3C19421
	for <mptcp@lists.linux.dev>; Fri, 10 Apr 2026 09:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775812376;
	bh=h34D2+ncpP6apR8rS36g2oEjVvk9sXKeBY3bxXEmbac=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=AlJmxYryirWnqc8fGvbuYL1O2v42Y4FLgD3pyBxMD1lqZXErMWrSnuNgOQ7ssigMs
	 /QpMy7Q2fhTgpjJRdo9ZnekRV57VWc3MHI2UA5j9FRwJb9QJgi/XRPcNAkHc4AU/Jy
	 Gi7xjh7cXtFAUBJg539OEHdPPpPI9U8hUVXoyP9SqvEYxOcvBq4UfAe4U/uik/tQ7s
	 VATIvLIBfoW58/zQOfXPHn9tqrwT1Nfgb6sEunEgW+E9pQB4TgM8C9NLfXnGEShFFw
	 WuYGRGtbTRqP1OsckhjHmRVp9sfK3IFBWo1ls1IqbAPpUq5kP60oWQOO4AI9Njgmks
	 mAlpIKa0P9zkg==
Message-ID: <a42212ec-b8f6-450d-877b-3b05b0fc550d@kernel.org>
Date: Fri, 10 Apr 2026 11:12:54 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 05/16] mptcp: pm: retrans ADD_ADDR: skip
 inactive subflows
Content-Language: fr
To: MPTCP Linux <mptcp@lists.linux.dev>
References: <20260409-mptcp-inc-limits-v1-0-0e45fa30d914@kernel.org>
 <20260409-mptcp-inc-limits-v1-5-0e45fa30d914@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260409-mptcp-inc-limits-v1-5-0e45fa30d914@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello

On 09/04/2026 22:51, Matthieu Baerts (NGI0) wrote:
> When looking at the maximum RTO amongst the subflows, inactive subflows
> were taken into account: that includes stale ones, and the initial one
> if it has been already been closed.
> 
> Unusable subflows are now simply skipped. Stale ones are used as an
> alternative: if there are only stale ones, to take their maximum RTO and
> avoid to eventually fallback to net.mptcp.add_addr_timeout, which is set
> to 2 minutes by default.
> 
> Fixes: 30549eebc4d8 ("mptcp: make ADD_ADDR retransmission timeout adaptive")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  net/mptcp/pm.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 78a2ad71700b..e954dc46e6bc 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -305,20 +305,27 @@ static unsigned int mptcp_adjust_add_addr_timeout(struct mptcp_sock *msk)
>  	const struct net *net = sock_net((struct sock *)msk);
>  	unsigned int rto = mptcp_get_add_addr_timeout(net);
>  	struct mptcp_subflow_context *subflow;
> -	unsigned int max = 0;
> +	unsigned int max = 0, max_stale = 0;
>  
>  	mptcp_for_each_subflow(msk, subflow) {
>  		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
>  		struct inet_connection_sock *icsk = inet_csk(ssk);
>  
> -		if (icsk->icsk_rto > max)
> +		if (!__mptcp_subflow_active(subflow))
> +			continue;
> +
> +		if (unlikely(subflow->stale)) {
> +			if (icsk->icsk_rto > max_stale)
> +				max_stale = icsk->icsk_rto;
> +		} else {

I accidentally removed the condition here, it should be:

  } else if (icsk->icsk_rto > max) {

>  			max = icsk->icsk_rto;
> +		}
>  	}
>  
> -	if (max && max < rto)
> -		rto = max;
> +	if (max)
> +		return max < rto ? max : rto;
>  
> -	return rto;
> +	return max_stale && max_stale < rto ? max_stale : rto;
>  }
>  
>  static void mptcp_pm_add_timer(struct timer_list *timer)
> 

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

