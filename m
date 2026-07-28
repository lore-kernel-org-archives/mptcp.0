Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204021A0B0E;
	Tue, 28 Jul 2026 00:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785200306; cv=none; b=BfWlCS7yepPywALT+pFmg+Gqzg4apt+BIoQXV07HeBHjK8jdHsU6SR5LxbDcLjN35ZBamftPduh6xL/S7mlgDX98vEedeQYjBVU2yUcQXLxj2PmGx6hEiy5/9YGfF34zKpwlLGc99BGmuhvi2H2UdNbe1cPUAYLYUkxaBC/gndo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785200306; c=relaxed/simple;
	bh=QlvgR6btvYMGCFBIT2E/9iJyObDLIDMg3zfBCqqyZ2I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hd+TjvxGH4xGgdghDO0JB+WiY7U3uWK1REBrcqgB2+KlAtEoY22RVM8YRxFRxHoSBxzij1LlJX0SSPlzMRh55sKcvPcCRURJSOxwSx0QfecH8QjAsnXBoglu0z2bRzJ7nLs+B+yWiV+T218j0nyrPQT0sbnjimsyQE6+cHMeckg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pouu+FlP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pouu+FlP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401871F000E9;
	Tue, 28 Jul 2026 00:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785200301;
	bh=LvQEGgTDD9zI2eow9G1FANAvHL4JRiS9eNFRAsxZZU0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Pouu+FlPLsHp4mTMb5WKPwLXGiOsG1wJBMe77E1OsIJxyts4heqdyPoPiK4/5YePy
	 j3sGX9t2ue4GDIeSsVfUKGcHssUNjDvN9jGTEyaVuqUNUDbfLjaaLpj+kYdRSfEefq
	 UbTuzLMVlIa3o2d3mTDKmXntsWABu9uh1ta+t2SoTvlX5YCJNtbwePNmkC0almHHbv
	 5a8uVz4CwSEEc+3TKmWy2VsJ7esiJzl4f83SBkJhIIqk0olVfCFYP2ngIGrrHUgLAe
	 z+w+9OSy+erfEeEKwuXlrXMTs75RugvDcHNXF7N4ugZvq5szZGfXVRqcxnY3rs4Cws
	 HORl6npyl73kg==
Date: Mon, 27 Jul 2026 17:58:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, Gang Yan <yangang@kylinos.cn>
Subject: Re: [PATCH net-next 0/5] mptcp: out-of-order queue pruning
Message-ID: <20260727175820.593c039e@kernel.org>
In-Reply-To: <20260724-net-next-mptcp-oooq-pruning-v1-0-5dd4dec63a54@kernel.org>
References: <20260724-net-next-mptcp-oooq-pruning-v1-0-5dd4dec63a54@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jul 2026 16:02:12 +0200 Matthieu Baerts (NGI0) wrote:
> Under memory pressure, a pruning of the MPTCP-level OoO queue might be
> required as last resort, to avoid too long recoveries, or even stalls.
> Geliang and Gang managed to reproduce this behaviour, and Paolo
> improved the situation thanks to the following patches:
> 
> - Patches 1-2: improve the MPTCP-level retransmission schema to make
>   recoveries from memory pressure/after MPTCP-level drop significantly
>   faster.
> 
> - Patches 2-3: make the admission check way stricter for incoming
>   packets exceeding the memory limits, with some exceptions for fallback
>   sockets.
> 
> - Patch 5: implement OoO queue pruning for MPTCP.

Clashiko complains about a typo and has some suggestions which are
marked as Low but potentially worth addressing (stats naming?)
Please LMK if you completely disagree
-- 
pw-bot: cr
