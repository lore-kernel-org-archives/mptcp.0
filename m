Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795210211;
	b=xFdamHWe4TY9QT7Ur7+nCNtGdjF178mc6aMGk7wEMtP7imLapoFc9LcthrLfJ2oeMaZF
	 NB7w0m5jiGQkQK+SAHS9yQv6HDCH1aqUmvVtZOf9s5pDbAJKh5OwzZz0yheKMQpxa1RYo
	 uiJFbFRvvmdZgL/R5IqVv/Hh8KEbpdD48voxWflgYYjc1kmnsgzSBxoV2g3fN0+3ulq3g
	 DaFR1EjUtSt3EJy/LsGULZU/HUiChrmTrsPyOna+6pCc2XNIb745Is/9riqOLzIYea9Oh
	 esgMVRcD0TNiGHx6eBc5ZiyFPrMF35X4skougy+r1eJBLJB6ykxxzTiAs62zZXi3YGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795210211;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=sw31mzwT+UqmrkUG9lWyVe9VpMnfxIYOQHb/oNJWdSM=;
	b=CZUWH3c0w2MYAkAwERVOqxBiUnAvt/bp+UvYK3K49Ft1ouHKl+U6ENqOqqH4fFGhHoNc
	 zGfzZL549g1ZGA1f0gW70hO1s/C2F7Bv4ylymYy7PSjX/fdW4/S4eBVBBvjDbGJpBh2gM
	 uRJG9jSRbMl3q2SjnrteqvGqdNylDCOMt/lgVfDql6l0Yx4KMK5lql83Jfz3jX20bTuw/
	 1pA1ajI9RAQP02pyPa0/B6u+5DcAZwAvf9NPnB7UeclFO2Qg2CJA6tpY4071jeH7r+oP/
	 vbV8Vx7BLSWQ+PoL2tQYbkrzJ3mVYu6GXMq83GBT5jBW/WPjjFoLSTiifFOlIjNUVKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CVHlY6ck;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F452606A335;
	Fri, 20 Nov 2026 21:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CVHlY6ck
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1CB1F000CF;
	Fri, 20 Nov 2026 21:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795210211;
	bh=sw31mzwT+UqmrkUG9lWyVe9VpMnfxIYOQHb/oNJWdSM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=CVHlY6ckQW+B8DeE7Y5kZ1gXkFtA6laawbursrs25Wzkgv26yQAzria8BE55QHvV8
	 UGO5+nHU37RqSmx9TCbMa93IrXvSDncgtddF4WPyNvl39LE9ONq9hM+Cb3UoogjLxO
	 peZYTzIud0fKNxWJ9tTm/rE+2tHC3jwH9KQ2yiRHBuXU2NIce/nfnki2iPHnAQvmHc
	 pLpU4UCoRcF+/eYJ0Nz8poNqbOtWqlMlEpK96JK4eXKfLLW862uQz7ziou+ihyQxq4
	 i/uEC8kPzX9D65w9AEe9MECWKppE5iqWr/3kus44fzGU3o9zi2hqGiR9i1QQXKfjmw
	 aY75os8wqoc9g==
Message-ID: <656870cc-3a3b-433c-ba8a-dc883c4fb414@kernel.org>
Date: Fri, 20 Nov 2026 22:29:57 +0100
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next v3 1/3] tcp: avoid wrapping Fast Open blackhole
 timeout
Content-Language: fr
To: Yingjie Wang <x-professor@outlook.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "mptcp@lists.linux.dev" <mptcp@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "corbet@lwn.net" <corbet@lwn.net>,
 "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
 "rdunlap@infradead.org" <rdunlap@infradead.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "edumazet@kernel.org" <edumazet@kernel.org>,
 "ncardwell@google.com" <ncardwell@google.com>,
 "gang.yan@linux.dev" <gang.yan@linux.dev>,
 "kuniyu@google.com" <kuniyu@google.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
 "martineau@kernel.org" <martineau@kernel.org>,
 "geliang@kernel.org" <geliang@kernel.org>,
 "ycheng@google.com" <ycheng@google.com>,
 "weiwan@google.com" <weiwan@google.com>
References: <cover.1794847474.git.x-professor@outlook.com>
 <963cd91054a37f6308da9a327d9bb027a0306cb6.1794847474.git.x-professor@outlook.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <963cd91054a37f6308da9a327d9bb027a0306cb6.1794847474.git.x-professor@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Yingjie,

On 16/11/2026 17:46, Yingjie Wang wrote:
> tcp_fastopen_active_should_disable() calculates the active-disable
> interval as multiplier * tfo_bh_timeout * HZ. Since all operands are
> 32-bit, a large tcp_fastopen_blackhole_timeout_sec can wrap the delay,
> even on 64-bit kernels, and re-enable active Fast Open too soon.
> 
> With HZ=1000 and the maximum multiplier of 64, any timeout above 67108
> seconds wraps. For example, 67109 seconds should produce 4,294,976,000
> jiffies (about 50 days), but the calculation truncates it to 8,704
> jiffies (8.7 seconds).
> 
> This issue was found using a static analysis tool. It was confirmed with
> a loopback reproducer that induces 12 Fast Open blackholes and opens
> another connection 10 seconds later: with a 67109 second timeout, the
> unpatched kernel retried active Fast Open. The reproducer needs neither
> kernel modifications nor error injection.
> 
> Compute the interval in u64 and cap it at MAX_JIFFY_OFFSET before adding
> it to the saved timestamp. On 32-bit kernels, the cap keeps the interval
> within the range that time_before() can compare, which limits the longest
> backoff there to about 12.4 days at HZ=1000.
> 
> Also limit the writable initial timeout to one day, so the exponential
> backoff does not start from an impractically long period. Writes above
> 86400 seconds, which were previously accepted, now fail with -EINVAL and
> leave the current value unchanged. The wider calculation is still needed
> below that limit, as the 67109 second example shows.
> 
> With this patch, the same reproducer kept active Fast Open disabled, and
> the sysctl accepts 86400 and rejects 86401. The TCP selftests were not
> run; none of them sets this sysctl.
> 
> Fixes: cf1ef3f0719b ("net/tcp_fastopen: Disable active side TFO in certain scenarios")

I guess you can drop the Fixes tag, not to backport this to stable as it
somehow changes the behaviour as Eric said in the v2. Same ton the later
patches.

> Signed-off-by: Yingjie Wang <x-professor@outlook.com>
> ---
>  Documentation/networking/ip-sysctl.rst |  1 +
>  net/ipv4/sysctl_net_ipv4.c             |  1 +
>  net/ipv4/tcp_fastopen.c                | 12 +++++++++---
>  3 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
> index 0b7bfbd98a92..dc33f82a8997 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -1055,6 +1055,7 @@ tcp_fastopen_blackhole_timeout_sec - INTEGER
>  	get detected right after Fastopen is re-enabled and will reset to
>  	initial value when the blackhole issue goes away.
>  	0 to disable the blackhole detection.
> +	The maximum value is one day (86400 seconds).
>  
>  	By default, it is set to 0 (feature is disabled).
>  
> diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
> index 9df93ad219db..fb0f3124836d 100644
> --- a/net/ipv4/sysctl_net_ipv4.c
> +++ b/net/ipv4/sysctl_net_ipv4.c
> @@ -1152,6 +1152,7 @@ static const struct ctl_table ipv4_net_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_tfo_blackhole_detect_timeout,
>  		.extra1		= SYSCTL_ZERO,
> +		.extra2		= &one_day_secs,
>  	},
>  #ifdef CONFIG_IP_ROUTE_MULTIPATH
>  	{
> diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
> index 7f7eb3cc1c04..883f0f1e7e07 100644
> --- a/net/ipv4/tcp_fastopen.c
> +++ b/net/ipv4/tcp_fastopen.c
> @@ -613,6 +613,7 @@ bool tcp_fastopen_active_should_disable(struct sock *sk)
>  	unsigned long timeout;
>  	int tfo_da_times;
>  	int multiplier;
> +	u64 delay;
>  
>  	if (!tfo_bh_timeout)
>  		return false;
> @@ -624,12 +625,17 @@ bool tcp_fastopen_active_should_disable(struct sock *sk)
>  	/* Paired with smp_mb__before_atomic() in tcp_fastopen_active_disable() */
>  	smp_rmb();
>  
> -	/* Limit timeout to max: 2^6 * initial timeout */
> +	/* Limit the backoff multiplier to 64. */
>  	multiplier = 1 << min(tfo_da_times - 1, 6);
> +	delay = (u64)multiplier * tfo_bh_timeout * HZ;
>  
> -	/* Paired with the WRITE_ONCE() in tcp_fastopen_active_disable(). */
> +	/*
> +	 * Cap the delay for safe jiffies comparisons on 32-bit systems.
> +	 * The timestamp read is paired with WRITE_ONCE() in
> +	 * tcp_fastopen_active_disable().
> +	 */

I don't think modifying the comment is worth it. If someone wants more
details about the capping, they can already you long message, no need to
add noise everywhere with long LLM generated comments.

>  	timeout = READ_ONCE(sock_net(sk)->ipv4.tfo_active_disable_stamp) +
> -		  multiplier * tfo_bh_timeout * HZ;
> +		  min(delay, MAX_JIFFY_OFFSET);
>  	if (time_before(jiffies, timeout))
>  		return true;
>  

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

