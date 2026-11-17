Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794957221;
	b=pMo+VpYqKRNwZSuO7Ih4KTolfojJFXPIHkVzzcxJkqwR2Mx7PeqLeShljVvaTUdX8vJD
	 v+4Zxs7ndZybhNSUbamUNzZWhNFWZ67kebgowbpoqT+BQ8x9vxzzQVcJQvEHqCzo/8MFP
	 ZLFTTNOhEpEVZWE8enjrgfl17zkJhal6Ru3opmTD7jXSL2RUlwdIsxiTGTDOWt6wvDUM3
	 gzStqrNP/LFQfaOiC9+Dw0GJNntQDX0dbWhh8NEKpAGA9cRu6dVJR9KZGYDuENKAAbNrx
	 7ly09GXEgbRPRZdK/ILyd6QqNWodRV5SfqBPkKKzW3w5GbRrpPCGQYTkf8E1hW4r1Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794957221;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=AWIMa0ygDuVqH17MMOqdCGLShtW1ekZiV8aTkIfR0Gk=;
	b=Kn+RgMOZ4Be7lMqMpqmgDnPBJ1oH60DiMgzhTd7wDq0JsdWc9K7lIpoOccxYIM64W8dO
	 JXkqsDzmxsqkW5KxhTM41xvGDWn0HDNcrWlef1CKSktXA5F+aa7eaJGqMw05nAggGchmR
	 KX9JH93SHdqXwhsot3T/qGjQegEGiwYDbWm0tYZlkrnR9N2vmtOzd3/eDnO4dX56bIPZW
	 Zw/0YHFP0y2KikEuzV0ZkNLzsW5HYw+jlvLuNd9o+lhag17cC5Bb1FdqyX1iPjTGfSPYA
	 3Vy5vbkJ06geASdJLq8PS7gWvtPX+lNFr89AZb7l3ScRaMIwaeTLevPBpo+CL1lUmSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FynJ+w4g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9341606A334;
	Tue, 17 Nov 2026 23:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FynJ+w4g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242551F000C5;
	Tue, 17 Nov 2026 23:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794957220;
	bh=AWIMa0ygDuVqH17MMOqdCGLShtW1ekZiV8aTkIfR0Gk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FynJ+w4gGMX4VQ0jDP6XaEA6DNb5QnmjjVA4982A9Ur9seV+Pkk79fVOccSKHcsn7
	 R6u2ARdAHimxvN9e0OMq0sIOiY9k3SrgQTgfGsv3/hbfE9mUFWh/TFOrdVa/Sr78Jx
	 kwJe/3K0Q+PYKucVVT/lI6oQaPZ440twj5aYLSGGhWTiTd8AgI1DRIpDAA6PAUiL19
	 AymhaD+DppgZNL6SFWYhLzaz08yvve3Y3GEQy2eoivQhQ7noKYFS24CWmkIUCJbK7G
	 8EqT/ycH6By1bw37Jg5U9IzlnzthO+NtYwAQMD9JKg+idcIEoiHNeEupmshjLn6xpw
	 cxFuD2Zs0S24g==
Subject: Re: [PATCH v2 net-next 3/7] tcp: Stop collapsing if not bloated.
From: netdev-bot+sashiko@kernel.org
To: kuniyu@google.com
Cc: edumazet@kernel.org, ncardwell@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, matttbe@kernel.org, martineau@kernel.org,
 horms@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org,
 mptcp@lists.linux.dev
Date: Tue, 17 Nov 2026 23:13:39 +0000
Message-ID: <179495721972.3136.4014039511718024400@kernel.org>
In-Reply-To: <20261116230555.2305867-4-kuniyu@google.com>
References: <20261116230555.2305867-4-kuniyu@google.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The header comment of tcp_collapse() in net/ipv4/tcp_input.c now
  reads "Collapse contiguous sequence of skbs head..tail with sequence…

--

tcp: Stop collapsing if not bloated.

With this change, tcp_collapse() starts collapsing only at a bloated skb.
It extends the range over consecutive collapsible skbs that are bloated
or overlapping, copies that sub-range, and then restarts to look for the
next one. The end parameter is dropped from tcp_collapse(), and both
callers are updated.

> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 598d4ff3e1f4b..d2d4796984f39 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -5839,7 +5839,7 @@ static struct sk_buff *tcp_collapse_one(struct sock *sk, struct sk_buff *skb,
>  }
>  
>  /* Collapse contiguous sequence of skbs head..tail with
> - * sequence numbers start..end.
> + * sequence numbers start..sub_end.

[Severity: Low]
This isn't a bug, but could the header comment of tcp_collapse() be
reworded?

sub_end is not a parameter. It is a local variable that the second loop
recomputes for each sub-range, so callers never see it.

The comment also still describes collapsing a single contiguous range.
After this patch, one call can collapse several separate sub-ranges
between head and tail, with uncollapsed skbs left between them:

	/* Second, find consecutive collapsible skb. */
	sub_end = TCP_SKB_CB(skb)->end_seq;
	...
	goto restart;

The comment stays the same through the rest of the series, up to
"selftest: packetdrill: Add test for tcp_collapse()."

>   *
>   * If tail is NULL, this means until the end of the queue.
>   *

[ ... ]

> +	/* Second, find consecutive collapsible skb. */
> +	sub_end = TCP_SKB_CB(skb)->end_seq;
> +
> +	for (n = tcp_skb_next(skb, list); n && n != tail; n = tcp_skb_next(n, list)) {

[ ... ]

> +		sub_end = TCP_SKB_CB(n)->end_seq;
> +	}

[ ... ]

> +
> +	goto restart;
>  end:
>  	skb_queue_walk_safe(&tmp, skb, n)
>  		tcp_rbtree_insert(root, skb);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261116230555.2305867-1-kuniyu%40google.com
