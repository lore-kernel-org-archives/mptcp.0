Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795074903;
	b=FkbE5NxsYPQrymsBT8naBqXYQDiHps2aHjWrAaq+hNArsK1JzcS1iQvBIiB1AVymqtoM
	 uSMiapFkxGmSjJb7G+pR19/i/WNG+DwyIgPIlhr/CJWpolikNnxoCS9jnqj3X+YRQDGIN
	 5ocyAxLeh0AJbPgP3I9vxGpg3aTH0YYQpRs0GFBjwLXC86hV75nJAzpFen25LygSBdddR
	 gTtJHFTqTbBqumXcFJhwDHUGnBXsYHtVsF4BP1b2vyRGASJc8YDqgX9h50Hz3usaEaIq9
	 HEbswrKDZG6zr00fAuUFOymwFmDI/bhnMeh9PTTg1MRt/i1ISs+1pZ/PZoAb3CjJYrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795074903;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=M8c+z1XsQpgYNDmysoOmH/bkqUoGEgupjm1E7L/BBVo=;
	b=kvH3Xl0yi4G/4iuVE4jSfrnNHOa0aG6fEF2/gq8VAluF1ISlYfbJ84DzUH1aewHu1u42
	 WgI3l5H8iOqEdvmLUQigO/2rwxmhfpWulaxxWWaGb84Qh6SgGjOlYJy8FZ+ZngRLjCFqP
	 1eChrlmNagZiRkoaO7HLaZFPb8ddIQNk21gyk/aKn5iGoNRrwnXxzmekkys2VSRXG+n1I
	 3Vu9EylqqoD6L5kEHwmlL8kcbhn+4xNKybwWYWOyaBB6krErkSzkmDf/YF3q3YVhmcRS5
	 kR0tW98XqcXUmI5MmONje8KNHsaGKFhjiC5/pJbcUAQrthPWkfgCNkVtopLNkUNk83A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kylA4ge5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A4D606A324
	for <mptcp@lists.linux.dev>; Thu, 19 Nov 2026 07:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kylA4ge5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86B91F000C9
	for <mptcp@lists.linux.dev>; Thu, 19 Nov 2026 07:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795074902;
	bh=M8c+z1XsQpgYNDmysoOmH/bkqUoGEgupjm1E7L/BBVo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kylA4ge5AjV52wLpGlftYD2LELLfNbjIeIs4K7qP5ZeiBzjzZhgcjlD6gKnz+Oa8V
	 SDc2/D9zZxKN7SWJd3GElHpFKfUF2Vj3xbww7SQwwf7TPGlLVTmymjHo9B0puoHr/d
	 hr93BlhwGVVABBkHDy9icRUVe6FmFxFQmmpMd/v8YRql3ut4QL2AXkDs98ZCnN1TWX
	 cgSrtHrpTuwFllzZ5mOrelyqqovYwXLcBj1r391l6dFNySWAKwrlIzzuSe/myFXgeW
	 ePzQkK9QwWm/ks2gp9w/zX/ralJ8jrW/a0YRIeUmOsEj+xspNtRll27zqixVLC6Ba2
	 QmrhFDChfW/AA==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-862b090e3c3so1003027a34.2
        for <mptcp@lists.linux.dev>; Wed, 18 Nov 2026 23:55:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHQBTSFdNgtm1gbIlDk3SlLKfTkFaBfe/Yn8sro8Wcar7TYeWVHIBOE1qyVP2nCqCLaivK4EQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+xi/6iT9SRjKb8HllHF3fTGQrVR/PbZGsi2wZD4AnI4yt6PUmQ
	uEWrb3AuWRHNau6x//Yi/0dBrkb8NW+y9klSrC0MDtXmPA/IYbfMBcxhT6tn0NI9IWpBpsSmeOj
	hTG3G6VlG59gfhWYTDaN8G0c3+WQPHAA=
X-Received: by 2002:a05:6820:c44b:10b0:71a:ec65:1cbf with SMTP id
 006d021491bc7-71b18455b87mr2932062eaf.24.1795074901989; Wed, 18 Nov 2026
 23:55:01 -0800 (PST)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261117052200.1507847-1-llleigoing@outlook.com> <20261117052200.1507847-2-llleigoing@outlook.com>
In-Reply-To: <20261117052200.1507847-2-llleigoing@outlook.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Thu, 19 Nov 2026 08:54:50 +0100
X-Gmail-Original-Message-ID: <CAL4WiioB7cqHO8wVV=Gig+rc4Xbwz1uBbFYJPmkg3LeLYE-dvw@mail.gmail.com>
X-Gm-Features: AclHuK_kb7OmeX6GF9wvJZRqWvfnChLCkRRDY2D8g87PU1ioWj4UVhm49KP9r08
Message-ID: <CAL4WiioB7cqHO8wVV=Gig+rc4Xbwz1uBbFYJPmkg3LeLYE-dvw@mail.gmail.com>
Subject: Re: [PATCH net 1/3] tcp: saturate window-to-memory conversions at INT_MAX
To: lei lei <llleigoing@outlook.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mptcp@lists.linux.dev" <mptcp@lists.linux.dev>, 
	"ncardwell@google.com" <ncardwell@google.com>, "kuniyu@google.com" <kuniyu@google.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>, 
	"matttbe@kernel.org" <matttbe@kernel.org>, "martineau@kernel.org" <martineau@kernel.org>, 
	"geliang@kernel.org" <geliang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 17 nov. 2026 =C3=A0 06:22, lei lei <llleigoing@outlook.com> a =C3=
=A9crit :
>
> __tcp_space_from_win() computes a receive-memory requirement in u64 but
> returns int. A result above INT_MAX can therefore become negative or
> wrap to a smaller positive value before the caller compares or limits it.
>
> TCP and MPTCP SO_RCVLOWAT handling compare this result with sk_rcvbuf.
> They can accept a large low watermark without increasing the receive
> budget because the truncated requirement appears smaller than the
> existing buffer. Receive autotuning uses the same conversion helper.
>
> Saturate the u64 result at INT_MAX before returning it. This matches the
> int type of sk_rcvbuf and preserves the value and rounding of every
> representable result.
>
> TCP and MPTCP loopback tests with tcp_rmem[2]=3DINT_MAX and
> SO_RCVLOWAT=3DINT_MAX/2 reproduce the missed update after learning a
> scaling ratio below 128. With this change, both budgets reach INT_MAX.


I do not think this is a fix, and I do not think it belongs to net tree.

The conversion overflows only if

    val * 256 / scaling_ratio > INT_MAX

which is the same thing as saying that @val is bigger than the window
an INT_MAX sk_rcvbuf can offer at this scaling_ratio.

sk_rcvbuf being an int, the requested SO_RCVLOWAT can not be honored
in this case, with or without your patch. With scaling_ratio =3D=3D 64,
the biggest possible window is ~512MB, a 1GB lowat is never reached.

So the changelog saying the budget is now "correct" is misleading:
sk_rcvbuf is set to INT_MAX and the application is still woken up
before sk_rcvlowat bytes are queued, from tcp_epollin_ready(),
when the receive window is about to close.

Note that scaling_ratio is not a constant, it is updated in
tcp_measure_rcv_mss() for the lifetime of the flow. A sk_rcvbuf sized
at setsockopt() time is too small as soon as the ratio decreases,
far below the overflow point. Huge SO_RCVLOWAT values are best effort.

To hit this, the admin has to set tcp_rmem[2] above 2GB, and the
application has to call setsockopt(SO_RCVLOWAT) with a ~1GB value
after a low scaling_ratio was learned. (Before any data is received,
the ratio is 128 and @val is capped to tcp_rmem[2]/2, no overflow
is possible.)

Also, with your patch, sk_rcvbuf can be set to INT_MAX while
tcp_rmem[2] is smaller than that (say 3GB/2, scaling_ratio 64),
because __tcp_set_rcvlowat() and mptcp_set_rcvlowat() do not clamp
@space to tcp_rmem[2]. This is not new, but saturating makes
it more visible.

Your cover letter mentions that this started with sk_rcvbuf failing
to grow "during normal use". What was the workload, and what were the
tcp_rmem values ? I would prefer we look at the real problem.

If you still want the saturation as a cleanup, please send it to
net-next, without a Fixes: tag, and with a changelog describing
what is really changed for the user.

>
> Fixes: dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
> Signed-off-by: lllei <llleigoing@outlook.com>

Sashiko already pointed this: your From: is "lei lei", this
Signed-off-by: is "lllei". Please use your real name in both,
see Documentation/process/submitting-patches.rst.

Thanks.

pw-bot: cr
