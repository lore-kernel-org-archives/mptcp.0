Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAFD7260F
	for <mptcp@lists.linux.dev>; Wed,  5 Nov 2025 05:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762322257; cv=none; b=k02H9ZR51bZS8s8OB1G5TdM7MDByt5hggUVlL+a4ybZ8i63wHYhEn4/55ZnjTW2Gf55FYL4jZxaa+VxZEyb2QvABgD2hbywBN8QMnI+deC+aMbX4thjOhFUxKkPSE7dYAwClWRewGXgJQ9WdDQr2oBgq/HQ7vzbLdK6EifH9zvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762322257; c=relaxed/simple;
	bh=Y/HQm++6lsurtBUItbjlJEDH0jkORpLyH47wA+X9Irs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k2NR8cPg3DFkeqhhVbKSQqZOdJQGHZqHjTq91Q8wBmNjrzrtptpW35dg6P0q1Por9w2hhNktPsbiIwVOgdidOpv4+Llu0fv3yHekiZmCkAP/IBzQUrFtlvB+ZGHNG8mQGqtXshZkYS5aWuRdyIhE8KLkHFpYAxSH3XL8CG7qP+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/KgOSFo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/KgOSFo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94036C4CEFB;
	Wed,  5 Nov 2025 05:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762322256;
	bh=Y/HQm++6lsurtBUItbjlJEDH0jkORpLyH47wA+X9Irs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=g/KgOSFon4ilDzc1u3khfAjFu9o3bFDEteiNOpp+Xsp6SL8YsOfqV2FG4DAYtaUPK
	 WpG/90/7/umFDCigpaG/JYYCxkJwh0vimMjSzkmUm9TGlxX2yXK9Zmhfeh513QMBLs
	 RWtoYRaZQql3yJB+guRv1sjW55C8bzxWUkBs/h0lFEG8tR2x+aRgneZKeDaO5uyBIe
	 zm0t1cHqes6LWPiJSIGvoEqs69QeP2SJgO0fMoipBIoYEoqDtbzDmU8Oxvb+VVc5oX
	 c3KfNEODpdVLEL4fw9cNcuqeUwczHFpjoj2/xxwCFxEDWHOE7Eg6tbAgOt5lk1d2GR
	 hqtbR/5gXONww==
Message-ID: <cc7e81692dbcdf2f16b2320ab93431ca0f22b2d6.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v2 0/6] selftests: mptcp: join: fix flaky tests
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
Date: Wed, 05 Nov 2025 13:57:31 +0800
In-Reply-To: <c2cd46563de5a4e90a95f98913d42cd198757167.camel@kernel.org>
References: <20251102-slft-join-inst-v2-0-b4f3ba15a7c4@kernel.org>
	 <b8762565-35cb-482a-8988-e15fbbb01093@kernel.org>
	 <c2cd46563de5a4e90a95f98913d42cd198757167.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2025-11-05 at 10:00 +0800, Geliang Tang wrote:
> Hi Matt,
> 
> On Tue, 2025-11-04 at 13:10 +0100, Matthieu Baerts wrote:
> > Hi Geliang,
> > 
> > On 02/11/2025 12:30, Matthieu Baerts (NGI0) wrote:
> > > When looking at the recent CI results on NIPA and MPTCP CIs, a
> > > few
> > > MPTCP
> > > Join tests are marked as unstable. Here are some fixes for that.
> > > 
> > > - Patch 1: a small fix for mptcp_connect.sh, printing a note as
> > >   initially intended. For >=v5.13.
> > > 
> > > - Patch 2: avoid unexpected reset when closing subflows. For >=
> > > 5.13.
> > > 
> > > - Patches 3-4: longer transfer when not waiting for the end. For
> > > > =5.18.
> > > 
> > > - Patch 5: drop noisy plain RST packets when looking for
> > > MP_FASTCLOSE.
> > >   For >= 5.18.
> > > 
> > > - Patch 6: read all received data when expecting a reset. For >=
> > > v6.1.
> > > 
> > > When reviewing patches 2-6, please double check that I'm not
> > > hiding
> > > real
> > > issues by tweaking the tests suite.
> > 
> > (More eyes are welcome, especially on patch 5/6!)
> 
> I tested patch 5/6 again and found that only dropping the plain RST
> from ns1 is sufficient to make it work. There is no need to

Oops, the test of only dropping ns1's plain RST failed after dozens of
loops.

> simultaneously drop the plain RST from ns2. What do you think?

So we do need to drop both ns1's and ns2's plain RST simultaneously, as
done in patch 5/6.

Thanks,
-Geliang

> 
> If you agree, I can send a squash-to patch to fix it.
> 
> Thanks,
> -Geliang
> 
> > 
> > Thank you for the review! Now in our tree:
> > 
> > New patches for t/upstream-net and t/upstream:
> > - a9a49f5a022a: selftests: mptcp: connect: fix fallback note due to
> > OoO
> > - 818251a0fc51: selftests: mptcp: join: rm: set backup flag
> > - f0864a03b80b: selftests: mptcp: join: endpoints: longer transfer
> > - a68bf9260dab: selftests: mptcp: join: userspace: longer transfer
> > - 69569761c0f6: selftests: mptcp: join: fastclose: drop plain RST
> > - e99b7db5862e: selftests: mptcp: connect: trunc: read all recv
> > data
> > - Results: 3cf18f92ab22..09c25f9f5ca3 (export-net)
> > - Results: b35f4b01c8d3..625ded86ead5 (export)
> > 
> > Tests are now in progress:
> > 
> > - export-net:
> > https://github.com/multipath-tcp/mptcp_net-next/commit/c8f9b6716c62042010e0e231a789467236c55625/checks
> > - export:
> > https://github.com/multipath-tcp/mptcp_net-next/commit/31b5d615cdeb4fd6ea58fcd577b48543dd3b0617/checks
> > 
> > Cheers,
> > Matt
> 
> 

