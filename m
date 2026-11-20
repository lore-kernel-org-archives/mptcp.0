Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795210216;
	b=uW/lDIrorOUzgMKi/4vTq2CJMCRNy0Ot7XdzCpcLzsOYWlNUDnCEI5vJ1H5/vBpYo0tm
	 ejJrr0VE9z9hcGP8sJNLQqawh1pSQUqfwX7t5E9ihZugJ2hQPF5jJqzc2brBklf2IJwRh
	 vFINFR0LDIHvi/WJYg6we3qRWLSwjvr7bUdDMMIAozT7Ol+nMhyObmOFAFPZpTWHX5MKy
	 LVzZxi0sK3TDnkNXzaJuTTm8yHn0Cd8vibAxv+ajOIbgI4Bb0BYsjB4OD7c4+7PrC7DMi
	 6Hrv839zAdd5SYh1jYCTJLchWQ3eBbf0TXzcb55jINBZWXpIRfmqb7DREBZ32cvGGvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795210216;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=zVMPNS9d+k0WzK5AcTZvqCESA9rhwI1dzla95MLvaAU=;
	b=O2hv1/JImPkEj3eIdjpZoLbSKiYqLy9aDkw2iMmeOJ694kKyQ/gBdyL5q4cIuQLLDezL
	 z60M3thAtlOpmjOwv+x7Z6AewjmkxjaZv4vTpMUxdrtdSrri6eIBpRHPR9MBrX6Z2InR/
	 cgUWoSouqcOVIIhBk8N/A9Hvy45c/CX7l/TdCbnjRIe3ImfGvA7EmT4H8B2ThPZRXXhSd
	 cnnIRfT7vdFjIuBI1JDrTNb/Ij+9NQ0RcwmNk5c5ucRGP9PWPlj6VbsFROUxTEuxseJuh
	 4j4oCPra+b/7OHzNexHWDO677PN+aY0lRzYawfjaj+d51xDf+ESROmyxsDG8a1ucYGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RvqRRR1L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E9E606A6A6;
	Fri, 20 Nov 2026 21:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RvqRRR1L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A5A1F000C0;
	Fri, 20 Nov 2026 21:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795210216;
	bh=zVMPNS9d+k0WzK5AcTZvqCESA9rhwI1dzla95MLvaAU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RvqRRR1LN7Ne9+SOccNFlpczKOQXNtrYX9XYLZ8ENMacJj1v7YIDY7NKVBAIAR+ZZ
	 /Chm0AlH7AnweE5An0iLxg+lAxeDf/vLd8JMzeCyNgSEXS/F9+jv6TmWsuxebfy4Xv
	 x8270VC6vD6ONpnOaMoZg4Mj2H582jBURGLlD+aek2Q3URXkube2DTKG8BqsJaGxfR
	 NWFuhE0TxdiwANrPAzD+7GICa9I6r7aj8lTg4UbP3ZI6uY5hihmq8CIKhnbA32Zh4E
	 hnZNFS78GLtCK0eDL9eFLTOma7leaD2+RcGk/B8giL4HR+2V/fncyqkN6L3mM4IB9q
	 gMmKyd8KkAx0g==
Message-ID: <cff77c51-64d1-4cc0-9da3-41832d3015b5@kernel.org>
Date: Fri, 20 Nov 2026 22:30:07 +0100
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
Subject: Re: [PATCH net-next v3 2/3] mptcp: avoid wrapping blackhole timeout
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
 "weiwan@google.com" <weiwan@google.com>, Gang Yan <yangang@kylinos.cn>
References: <cover.1794847474.git.x-professor@outlook.com>
 <33f003b094444e37f11f9328c783d8c5a42e841a.1794847474.git.x-professor@outlook.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <33f003b094444e37f11f9328c783d8c5a42e841a.1794847474.git.x-professor@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Yingjie,

On 16/11/2026 17:46, Yingjie Wang wrote:
> mptcp_active_should_disable() calculates the active-disable interval as
> multiplier * blackhole_timeout * HZ. Since all operands are 32-bit, a
> large blackhole_timeout can wrap the delay, even on 64-bit kernels, and
> make active MPTCP available again while the blackhole is still present.
> 
> With HZ=1000 and the maximum multiplier of 64, any timeout above 67108
> seconds wraps. For example, 67109 seconds should produce 4,294,976,000
> jiffies (about 50 days), but the calculation truncates it to 8,704
> jiffies (8.7 seconds).
> 
> This issue was found using a static analysis tool. It was confirmed with
> a loopback reproducer that induces 12 MPTCP blackholes and opens another
> connection 10 seconds later: with a 67109 second timeout, the unpatched
> kernel retried MP_CAPABLE. The reproducer needs neither kernel
> modifications nor error injection.
> 
> Compute the interval in u64 and cap it at MAX_JIFFY_OFFSET before adding
> it to the saved timestamp. On 32-bit kernels, the cap keeps the interval
> within the range that time_before() can compare. The sysctl input range
> is unchanged; values whose interval exceeds the cap are shortened to it.
> 
> With this patch, the same reproducer fell back to TCP without retrying
> MP_CAPABLE. The MPTCP selftests were not run; none of them sets this
> sysctl.
> 
> Fixes: 27069e7cb3d1 ("mptcp: disable active MPTCP in case of blackhole")
> Reviewed-by: Gang Yan <yangang@kylinos.cn>
> Signed-off-by: Yingjie Wang <x-professor@outlook.com>
> ---
>  net/mptcp/ctrl.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> index 63c5747f0f63..0b10e94e7f43 100644
> --- a/net/mptcp/ctrl.c
> +++ b/net/mptcp/ctrl.c
> @@ -487,6 +487,7 @@ bool mptcp_active_should_disable(struct sock *ssk)
>  	unsigned long timeout;
>  	int disable_times;
>  	int multiplier;
> +	u64 delay;
>  
>  	pernet = mptcp_get_pernet(net);
>  	blackhole_timeout = READ_ONCE(pernet->blackhole_timeout);
> @@ -501,12 +502,17 @@ bool mptcp_active_should_disable(struct sock *ssk)
>  	/* Paired with smp_mb__before_atomic() in mptcp_active_disable() */
>  	smp_rmb();
>  
> -	/* Limit timeout to max: 2^6 * initial timeout */
> +	/* Limit the backoff multiplier to 64. */
>  	multiplier = 1 << min(disable_times - 1, 6);
> +	delay = (u64)multiplier * blackhole_timeout * HZ;
>  
> -	/* Paired with the WRITE_ONCE() in mptcp_active_disable(). */
> +	/*
> +	 * Cap the delay for safe jiffies comparisons on 32-bit systems.
> +	 * The timestamp read is paired with WRITE_ONCE() in
> +	 * mptcp_active_disable().
> +	 */

Same here: no need to modify the comment here.

pw-bot: cr

>  	timeout = READ_ONCE(pernet->active_disable_stamp) +
> -		  multiplier * blackhole_timeout * HZ;
> +		  min(delay, MAX_JIFFY_OFFSET);
>  
>  	return time_before(jiffies, timeout);
>  }

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

