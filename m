Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794979340;
	b=2fSuc5apQ5lqMpatMkhnAhQ0bzzZYNyOVRvR8IWOgQtp5pGIspJFEv+34jSS/xUW1kAl
	 6qP0bCAC47JX6SeaEnfAAXRL6Yqd0IwR5hItl+l01BEfnIHdBCSl10X+Wqj0CAxUD1Yu1
	 dVdqgAi3Am5CHarJMN5FGNeyCoXFUQrLYSMFX8XaR6mFqWXhZj8JJKK6SV8eW2gdKxdSd
	 0Frxldm3rN6dZcGjdI2vwlEcLSWqGmt1XKydoMDc1fxftMAiP0pc8UX9rwYdXizxui4Xq
	 DBUsB9vk7ir9w6JGgRNzD3z38UDy2LUpJ45o0FqOLrh7lLQzkkITXJ2sj2USx4Tfelw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794979340;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fI0Swja7TMb4zqgre4l+aNURCetZ95Th1Wqk+b1agNM=;
	b=4NUGkY/v8ck3CKBds6RaVGonZep1KrDB2jU1Oz8qN6rKR6zjrMDEO1yY2lwxRR0T8lhA
	 vfZLaAbNsjizCWn82T3jR7Gd5/Riy32piVgP3jm7wSIsBjOzufFSOBW8ldmezaSuXDsHx
	 RlsG6j3e75z/r4YPwyEkeOE8VEv9Aq7MoxbqAi7bUT4vWu38M2mBzHVDbYIBThLVQm1Vi
	 pPp1fsBnCELAatFNggbIP2x07WidpRdR9j41XYIcn2E6uLZNiRdHf9IHLxRxpCpf0NxLA
	 MnVnAAE1pRtpAscxkFEZc5LAdfHKmrRT3m0TbsdT08b4mKIc9e+jP6orxiZgPaCF8mQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ggnYN5lJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9999D606A31C
	for <mptcp@lists.linux.dev>; Wed, 18 Nov 2026 05:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ggnYN5lJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE9C1F000C4;
	Wed, 18 Nov 2026 05:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794979340;
	bh=fI0Swja7TMb4zqgre4l+aNURCetZ95Th1Wqk+b1agNM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ggnYN5lJmhqz3wiDiVo6XuHsND79hI1PfdwltMuVdw9WF9bvQyUqVt01Avb3d1OWR
	 pbEx7GQbHDCuo4qHeMAkypWW+ccSQU5Biea6UtGxZlRTNnNlADCKw0wbdFfSDhSk5a
	 q9aWOUzzsAgWNqeixFn2eCGB3wbhLdnhyQcK3F502+wsq4sMY0u4FMwGyDQgeUUteh
	 pP/qRb9H4Ol9SKfVkw4NxfHtFlIMr8mj775xqbpR5yn0sfSgV5whR1dSqGEERB9tbM
	 FE2+YhiZICDsqBtgvZUgKoeiXgTbyhlmTNPxzgye2NnAn5AaXULd9ag661JhjoNPBK
	 PX89PcLxwqr6g==
Message-ID: <sashiko-outbox-220154@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 1/3] tcp: saturate window-to-memory conversions at
 INT_MAX
Reply-To: sashiko-reviews@lists.linux.dev
To: "lei lei" <llleigoing@outlook.com>
Cc: =?utf-8?b?bXB0Y3BAbGlzdHMubGludXguZGV2?= <mptcp@lists.linux.dev>
In-Reply-To: <20261117052200.1507847-2-llleigoing@outlook.com>
References: <20261117052200.1507847-1-llleigoing@outlook.com>
 <20261117052200.1507847-2-llleigoing@outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 05:22:19 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] tcp: invalid Signed-off-by trailer using handle instead of real
  name
--

commit 7ae76d33251cff52d3abaf1bc0db22dbfc70f04d
Author: lei lei <llleigoing@outlook.com>

> tcp: saturate window-to-memory conversions at INT_MAX
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
>
> Fixes: dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
> Signed-off-by: lllei <llleigoing@outlook.com>

[Severity: High]
The Signed-off-by trailer uses the single-word handle "lllei" instead of a
real human name matching the Author header, which violates Developer's
Certificate of Origin requirements in
Documentation/process/submitting-patches.rst.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117052200.1507=
847-1-llleigoing@outlook.com?part=3D1
