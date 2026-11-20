Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795186720;
	b=q8lCYBOYnzM5TpAcXN3UskqH9p+5O8WvUUGtO7KWJxFGrf2TOJId6i0cEn2MxN+PZyrb
	 xkzYsyzWQzdYQY5d5klLzVXeKuGBNivz/ArCKVl/EXQZSga/GHbdNXtORRytIkzXcdXEz
	 wB48u2+mqY51XwUa2j2kcA2sXZpA4WsFpx8Bby0XdN7yAt8YS8B+SL+Rw4SfaE20tnaKo
	 j53YWQnQpBhH3Tkqy0dfUXYCg8OxdhCccNFUiSGz5OX9k/FzwO/4xb//XaOUkdVoWrtMv
	 zKIIgjUOEuVuVXUV9pvHDWATzf7NKh6FyTl009W3NNTvnGxjztpBaEACBBSbLnU26+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795186720;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=ffzCtB1XDBdjH4GLa/H0NDzYUrlRWJv6NL3GPNbLVuk=;
	b=l5c23LizbKNYEvhWOIn5L4sxLLzC7XguBl5XGrGACN/uUM5kSEo2U1ml7TAkrcjrwWOs
	 FUNA1gQTodb+X7qBMW9fCMoEXSO9pQiBZURwWOVQZ4skAiLn/rqbcgJ9s+2aRdaeXM4oM
	 NzxGbf4KAfTWxON8fgB9nvCHhyBfmm/MQWFnv8TIXy19eypUi3DNNy++JXBsTvE4X/fcu
	 AibWBayE9Ia6uNwMIlX73E+Ubrl8OuJY2A427uIlqC4OuCQFYn8Qn6BZ0aSahkHUUqgrb
	 HlXie6vu7pzuo0T4dzJxqx13Wtz9VI90BcMCLxXp6gX7JwhT6N+P9cbDeft7a+114tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lcH5oTjo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AF0606A336;
	Fri, 20 Nov 2026 14:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lcH5oTjo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97161F00A00;
	Fri, 20 Nov 2026 14:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795186720;
	bh=ffzCtB1XDBdjH4GLa/H0NDzYUrlRWJv6NL3GPNbLVuk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lcH5oTjoE6ZZrSnyQq04PwTyKInBI7yU2CJHG9d1Fb+vsWOz8CEYeYxGejVHG+PJ3
	 e5KX1tjOi9vF6vJGOpIUAOSVd9Kxr3wLVpvlfSHMffY55PkSGLr4QP0dOJEcCCbNO6
	 wcZyiYQvCaBAQ2rqU0RXs6jhGetZweaai4XI+bhWBlhiYTYH57zieFo2zQfjKQH3vG
	 DNCQ6wEouN7cjkCWNSHsFwIkeB8WOcTQx4j1OmG6HxvWJGnFGzIDmCHqQn0xeFHO/d
	 o53nzMuwJTFeoYL9bc/Hm7AWYNMnr1Bm6OPAs7vlGw7kF6ddSzxcgAL77CJ3IqbxJS
	 eAqP0nwy/Aq+Q==
Message-ID: <929c8f04-182f-49a4-8190-f21fc2aae881@kernel.org>
Date: Fri, 20 Nov 2026 15:58:35 +0100
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
Subject: Re: [PATCH v3 net-next 3/7] tcp: Stop collapsing if not bloated.
Content-Language: fr
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org, mptcp@lists.linux.dev
References: <20261119071649.374106-1-kuniyu@google.com>
 <20261119071649.374106-4-kuniyu@google.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20261119071649.374106-4-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kuniyuki,

On 19/11/2026 08:15, Kuniyuki Iwashima wrote:
> Even when a skb is not bloated, tcp_collapse() starts collapsing
> if the next skb has overlapping data.
> 
> Also, tcp_collapse() does not stop until it reaches the tail or
> unmergable skb (SYN/FIN, unreadable frags).

(...)

> On the other hand, if an overlapping skb on the OOO rbtree cannot
> be collapsed, we skip the range instead of breaking out, as
> splitting the range could insert the tail nskb after that skb and
> break the same rbtree ordering.

Thank you for having added this ...

> Another notable thing is that tcp_skb_can_collapse_rx() now checks
> candidates against the first skb before mptcp_skb_ext_move(),
> not against each nskb.
> 
> When a skb with an MPTCP ext spans multiple nskbs, collapsing
> previously stopped at the next skb with the same ext because later
> nskbs lacked the ext.
> 
>    skb1 (ext A),                  skb2 (ext A)
>   nskb1 (ext A), nskb2 (no ext)             ^
>                         ^- not collapsible -'
> 
> Now such skbs are also collapsed with the redundant ext dropped,
> while the first nskb still carries the same mapping in sequence
> order.
> 
>    skb1 (ext A),                  skb2 (ext A)
>   nskb1 (ext A), nskb2 (no ext) <-' collapsed into nskb2

... and that!

Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

