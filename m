Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8558C43CEE3
	for <mptcp@lists.linux.dev>; Mon, 14 Sep 2026 10:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789382368; cv=none; b=al85Zf+ZmRwm7r1Td9fgS5aEtjHwnUPF9Kxt70AgjgyJ+WYWctZv/wvtBVmTFuupZmYLbiEbx8LOh43Da4BDYH2iYg1C7QeQkpqn9UjzXkvH1bamS8uu8JpjmgovkTE0wE99LZKGfxs41eL1W+464QVpKbsVv2i39sW7/pTOecU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789382368; c=relaxed/simple;
	bh=ZhClB/cycxRts+sFkIPgrponnMuNSqoRa0deXnEtDz8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WYHcnb7OwiRwIoEu3g1RQvA8UiqEhAn/EY86EiuDdRjWgFilyY7wTtD1gcC37TA+cjErznKFmWL6YH2PWZA8laxHf2qxEc7pttPcmJntGeDQVU7QfhRmL3YQLvrTtw/uDdUGOSR2mTZl/vcXRlA3zX2D7FmYtdieypaxtXVgboU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWz64Pmy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWz64Pmy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74A01F000FF;
	Mon, 14 Sep 2026 10:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789382367;
	bh=Qcr321bGJVy74lfXW09wnU80PuFR0ZEyNLVyuanWd8k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kWz64Pmy93ZzjZudtHsPlCg/j50JP/0dbfehkk6EcFEq2l+WzR443kA0cYzxiQdOE
	 py4IOXWvTHOqqn+pZjITosDCSKs831MIhyx1TnWa+3KVyoPFENEGphBhMYH8m7LurV
	 7HQ/vzLhvE/siAnQtSvcoNxFjGR+LpNMM3kqycXRLoBZk+hQUcFmL7NSC+geqtWbbN
	 oXn/3GXDCXMv8lIxqMc88DFpapjI4HrD9Uobn64WOmSnKntG2HCCkn3LQFy7Jntogf
	 yQ5pJdhGH6iTs6WsxQ/vY8LNctkKVeb3e91qOIS8RNqJa0qFNcvQix1yNHdFLI8y73
	 k8gS/GK+m8gYw==
Message-ID: <54eaba70df36370435c627d688dfcf115913bb99.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v5 11/16] mptcp: add TCP_REPAIR sockopt
 support
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Mon, 14 Sep 2026 18:39:18 +0800
In-Reply-To: <c12f25fb-397d-4877-9d76-7ead6e1ed6b2@kernel.org>
References: <cover.1789294365.git.tanggeliang@kylinos.cn>
	 <15960ae7fff68167e041400db0480e55950ea1c1.1789294365.git.tanggeliang@kylinos.cn>
	 <c12f25fb-397d-4877-9d76-7ead6e1ed6b2@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Mon, 2026-09-14 at 12:33 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> (It looks like my email from yesterday didn't get sent)
> 
> On 13/09/2026 12:14, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > Add TCP_REPAIR socket option support for MPTCP, required for
> > sockmap CRIU
> > checkpoint/restore. When TCP_REPAIR is set on the first subflow,
> > skip the
> > normal connection handshake in mptcp_connect() and transition
> > directly to
> > TCP_ESTABLISHED. On close, skip the shutdown sequence and jump to
> > cleanup
> > when repair mode is active.
> Just a quick comment here: a lot more is required to support
> TCP_REPAIR,
> see:
> 
>   https://github.com/multipath-tcp/mptcp_net-next/issues/556

Thanks for the info - I'll take a look at that.

> 
> It is not clear to me why you need it to support sockmap. Probably
> better to drop this patch, no?

It's the sockmap_basic test that sets TCP_REPAIR; I can temporarily
disable that test case for MPTCP.

Thanks,
-Geliang

> 
> Cheers,
> Matt
