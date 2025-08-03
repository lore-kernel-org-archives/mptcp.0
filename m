Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1198F58
	for <mptcp@lists.linux.dev>; Sun,  3 Aug 2025 12:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754223014; cv=none; b=OSo9jhflInnNJN9ZfQrcfrY7r8pUpai2ne09k3iK2oIxA2uIYifKty9K5kjMf/2SktDmRxLXsCix8ke/HOPu6Z0CKXT2LXLoauFQZZ3+vgQBbmxSiGFJ1knUT+qHiLgxjTK+E3N/0qc8nQJEwgbnX8+iNp/UaYMEWRCBOROXcUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754223014; c=relaxed/simple;
	bh=yG3WNwAMdj1MiHPyuwx2+ejyQg30jsE4DqgxdRn8bmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Me8/j3pOt+BeC+KpNziAHjtId3DNXo5OOjGdpL0Jos/Icwj1EZvGfg8wD0swdZaKFFR4/YnGjXfMu3C91EbZRi9Q3vHuMze/GcgOxBBYB3P+o8tJsbuAzPw+z5DxpLv9PE/4CfrmZmLxqfllefGe1y6apXZO+REa86WD1ssCB4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkLZEYar; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkLZEYar"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B414C4CEEB;
	Sun,  3 Aug 2025 12:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754223014;
	bh=yG3WNwAMdj1MiHPyuwx2+ejyQg30jsE4DqgxdRn8bmE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nkLZEYarxVNi4C4jHSERLykuEMnMgEZknly6Y7kN4kNzEehDPLlj1SaPAG9GARkUh
	 imuT5zkdDyM/ElvKd1skczG0qrQj6GVgglkoP8HPyP9E7D03wZ0RlltvdV3ZhjN18j
	 QqU6oK+f8z8b0FuZoh0UwqFEvIHURReOGH/tVyG4j5komdFjnmB4qGw0zk8FJjsshu
	 1Cv2OTeUzm6Ipl8Pq7I7QpR8YkRTFU2bZxiUmJUKKUWtz9JX9PwLUfidtmOd06kaWl
	 qggK+5lgl8ENvPmZlT0okxfRFUnU89Vx+NNydHYElSUqyr3+I66Q3u5bbF6Bf7RAqy
	 aLoD2LfiCBktg==
Message-ID: <79652ff2-96ce-4c11-a955-59ef59300abc@kernel.org>
Date: Sun, 3 Aug 2025 14:10:10 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2] mptcp: adapt ADD_ADDR timeout to maximum
 subflow RTO
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <40706ad511220729207ccd7cf48e320e4d0d7dea.1754028199.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <40706ad511220729207ccd7cf48e320e4d0d7dea.1754028199.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 01/08/2025 08:07, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Currently the ADD_ADDR option is retransmitted with a fixed timeout. This
> patch makes the retransmission timeout adaptive by using the maximum RTO
> among all the subflows, while still capping it at the configured maximum
> value (add_addr_timeout_max). This improves responsiveness when
> establishing new subflows.
> 
> Specifically:
> 1. Adds mptcp_adjust_add_addr_timeout() helper to compute the adaptive
> timeout.
> 2. Uses maximum subflow RTO (icsk_rto) when available.

"when available": this worries me and is linked to my question from v1:
I don't know if ["icsk->icsk_rto"] will be set to a correct value when
we will look, no?

I guess it will be set by TCP only when retransmissions will be needed,
no? So maybe not set when sending an ADD_ADDR? Or set at the wrong
value, no?

some mptcp_join.sh subtests are failing, maybe because the
retransmissions are done too frequently, no? Also, it is suspicious that
the ADD_ADDR packetdrill tests are still passing: are they not checking
for retransmissions done once every second? (or maybe the tolerance is
too high → best to check with a packet trace)

> 3. Applies exponential backoff based on retransmission count.
> 4. Maintains fallback to configured max timeout when no RTO data exists.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/576
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> v2:
>  - do not rename add_addr_timeout
>  - use icsk->icsk_rto instead of tp->srtt_us
>  - increase the time after each retransmission
> v1:
>  - https://patchwork.kernel.org/project/mptcp/cover/cover.1753777199.git.tanggeliang@kylinos.cn/
> ---
>  net/mptcp/pm.c | 34 +++++++++++++++++++++++++++++++---
>  1 file changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 687dbb59d084..22198609be2f 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -268,6 +268,28 @@ int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
>  	return -EINVAL;
>  }
>  
> +static unsigned int mptcp_adjust_add_addr_timeout(struct mptcp_sock *msk,
> +						  const struct net *net,
> +						  u8 retrans_times)
> +{
> +	unsigned int timeout = mptcp_get_add_addr_timeout(net);
> +	struct mptcp_subflow_context *subflow;
> +	unsigned int icsk_rto = 0;
> +
> +	mptcp_for_each_subflow(msk, subflow) {
> +		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +		struct inet_connection_sock *icsk = inet_csk(ssk);
> +
> +		if (icsk->icsk_rto > icsk_rto)
> +			icsk_rto = icsk->icsk_rto;
> +	}
> +
> +	if (icsk_rto && icsk_rto < timeout)
> +		timeout = icsk_rto;
> +
> +	return timeout << retrans_times;
> +}
> +
>  static void mptcp_pm_add_timer(struct timer_list *timer)
>  {
>  	struct mptcp_pm_add_entry *entry = timer_container_of(entry, timer,
> @@ -302,7 +324,9 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
>  
>  	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
>  		sk_reset_timer(sk, timer,
> -			       jiffies + mptcp_get_add_addr_timeout(sock_net(sk)));
> +			       jiffies + mptcp_adjust_add_addr_timeout(msk,
> +								       sock_net(sk),
> +								       entry->retrans_times));
>  
>  	spin_unlock_bh(&msk->pm.lock);
>  
> @@ -354,7 +378,9 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
>  			return false;
>  
>  		sk_reset_timer(sk, &add_entry->add_timer,
> -			       jiffies + mptcp_get_add_addr_timeout(net));
> +			       jiffies + mptcp_adjust_add_addr_timeout(msk,
> +								       net,
> +								       add_entry->retrans_times));

(I guess you can also set it to 0 here, no? If yes, all in one line?)

>  		return true;
>  	}
>  
> @@ -370,7 +396,9 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
>  
>  	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
>  	sk_reset_timer(sk, &add_entry->add_timer,
> -		       jiffies + mptcp_get_add_addr_timeout(net));
> +		       jiffies + mptcp_adjust_add_addr_timeout(msk,
> +							       net,
> +							       add_entry->retrans_times));

(I guess you can also set it to 0 here, no? If yes, all in one line?)

>  
>  	return true;
>  }

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

