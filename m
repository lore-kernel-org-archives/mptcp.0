Received: from mta0.migadu.com (out-245.mta0.migadu.com [91.218.175.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBE9408626
	for <mptcp@lists.linux.dev>; Mon,  7 Sep 2026 06:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788764387; cv=none; b=jFVDV+elc4ih35M7tce59VPGtyF2wCLfifFIcnhh5R99x4ZyBrG5wClOUwzg0RCdArpC275Hp78au3Wivokj2Y+CQG0L0u0IidYDopNPANyPL/HGPUIbwAjtB9himxMhKBHWZPv3tZH3L+R/0FwZSu78d+/cCBpKEDtF+19PX2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788764387; c=relaxed/simple;
	bh=wEOApb+WQsZIuYtBu6ufXgK3IbUL3RbsuuVY/ioyY4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hnz+viXD67Y95vmgHDk1RekmP6vZjNDP8C2jn5Fak+3iT52CiHz2Z5xfeyNkAscHrHHK239NQP2stSSdynUv+mzbNNa1gSFhxcMNTufrrnN/InXgBezZ+M9GJRDdYaGW+8MUbyF6seKGt8CVzl7fkq4PX14C06h6eH3yDUQrAe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vWDNurek; arc=none smtp.client-ip=91.218.175.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vWDNurek"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=wEOApb+WQsZIuYtBu6ufXgK3IbUL3RbsuuVY/ioyY4I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788764383; v=1; x=1789369183;
 b=vWDNurekBe18xhmbuSwYZ/b6dZ4yJzLxthriusmSxb/jLgZhMvx9MEV1HLapL0hEyuo5XaJc
 00WVOftbIkWy6v52A4PuQFY1Hd/Tfq6fwn0jjJ+KMVdxD4tM8oLRJ0wIF0fFZaKHKL6ZLO0IbYM
 GiOsfvqEHfqAinWkRz6lHnbo=
X-Envelope-To: mptcp@lists.linux.dev
Received: by mta11.migadu.com with ESMTPS id cf2a094ddc96a431;
	Mon, 07 Sep 2026 06:59:43 +0000
X-Mizu-Trace-ID: cf2a094ddc96a431
X-Migadu-Flow: FLOW_OUT
Date: Mon, 7 Sep 2026 14:59:38 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-next 2/2] selftests: mptcp: convert iptables to
 nftables for mptcp_join.sh
Message-ID: <ap5gzozOFWNTJPDc@fedora>
References: <20260902-mptcp_nft-v1-0-559caa16f410@kylinos.cn>
 <20260902-mptcp_nft-v1-2-559caa16f410@kylinos.cn>
 <513e6559-a06a-45d8-a8b7-72b3a1a77e71@kernel.org>
 <apjU-uM8dvxnVcaP@fedora>
 <6c9dd599-e9d2-470f-bc7f-2af2e9d003b6@kernel.org>
 <app68h1_rYkPBpvn@fedora>
 <aa5678f7-7089-4049-9120-6604372667ac@kernel.org>
 <ap4NEvXYLC1U8hqO@fedora>
 <afad1474-88ac-413c-b81c-1ff1de2c6738@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afad1474-88ac-413c-b81c-1ff1de2c6738@kernel.org>

On Mon, Sep 07, 2026 at 07:50:04AM +0200, Matthieu Baerts wrote:
> >> If a global nft_handle var is used, that doesn't seem clear, and I think
> >> it would be clearer/easier to:
> >>
> >> - either delete a specific rule (but I don't think that's supported)
> >>
> >> - get the handle from the test and use it to delete the rule
> >>
> >> - or flush the table.
> >>
> >> So up to you, but probably best to avoid using nft_handle as global var.
> > 
> > Thanks, endpoint_tests is the only test that could delete iptables rules.
> > I use the nft_handle mainly because the iptables also delete rules with
> > specific match (iptables -D OUTPUT -s .. -p tcp -j REJECT) other than flush
> > the table directly.
> > 
> > endpoint_tests
> >   - reset_with_tcp_filter
> >     - iptables -D
> >     - iptables -I
> >     - iptables -D
> >   - reset_with_events
> >     - iptables -I
> >     - iptables -D
> >   - reset_with_tcp_filter
> >     - iptables -D
> > 
> > While from the logic it should be safe to flush the tables. I can avoid the
> > nft_handle in v4 (after v3 review).
> 
> Just to be sure it is clear: nft_handle can be used, just better to
> avoid using it globally I think. An alternative could be to pass a local
> nft_handle to reset_with_tcp_filter and set it there, but in bash,
> that's not very clear either.

reset_with_tcp_filter is also used by subflows_error_tests(). It's not easy
to just passing nft_handle to reset_with_tcp_filter for endpoint_tests and
leave subflows_error_tests() not affect. If there is a new version,
I'd prefer to just flush the table if you have no objections.

> >> You need to use `|git rebase --onto` instead, e.g.
> >>
> >>   git fetch origin  # adapt here and below if needed
> > 
> > For export branch, I think git fetch is not enough? I have to reset
> > to latest net/net-next merge commit and pull on that.
> 
> I'm not sure to understand. 'git fetch' with the right remote should get
> the latest <remote>/export branch ...

I get what you mean now. I checked out the export branch, which is not needed.

> 
> >>   git rebase --onto origin/export "$(b4 prep --show-info base-commit)"
> 
> ... then this command will use this new ref. Why do you need to reset
> net/net-next merge commit?
> 
> > Yes, it works! New git usage learned :)
> > 
> >>
> >> Can you check if it works for you, please? (so I can update the wiki
> >> page if needed)
> >>
> >> The alternative is to use `for-review`, with a continuous history, see:
> >>
> >>   https://github.com/multipath-tcp/mptcp_net-next/wiki/Git-Branches
> > 
> > I will try this tree next time
> 
> Up to you, but "export" is good as well, and required when using "git
> blame".

Got it.

Thanks
Hangbin
