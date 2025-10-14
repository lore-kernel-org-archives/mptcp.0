Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF2C2ECD26
	for <mptcp@lists.linux.dev>; Tue, 14 Oct 2025 10:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760436848; cv=none; b=Cn2Z0+z51CpX9pZlrFMbrly+9GRIxGQdfOvbAVQomsNlO8N55IcnrFRSwdSVh8gNuM+TYog3HQ6piqPgt4aSY/zKQqbSSkLmwTgtANjYiEXu9OfRl5hMxYWmmKWkaS/EDOcnmb9EX8CclllVGIQcXTkvuRDZ5R5gNIbWloq7tUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760436848; c=relaxed/simple;
	bh=4rbEVuOf8WZQXaR5apXcxRgGTQqj8jNjKG4zHHPB6dI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JuBeHDBwVs3RU7lzSExiwQoQD4b1wjlhdsyzs/HlDjD/4nuIS+4AHttlnic+s5qNeOkBy+8HKWHvgGSSDR6IU3Ps+guSAKfUSalZxcdqmoeDwA/uIWoL3wMkwqdenOecGiPjdg+/Y+D/N2q1Sl3houvtrVRLmvqo7Ms5Xh1bIQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwECm3YF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwECm3YF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C6CC4CEE7;
	Tue, 14 Oct 2025 10:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760436844;
	bh=4rbEVuOf8WZQXaR5apXcxRgGTQqj8jNjKG4zHHPB6dI=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=cwECm3YF8fn7OIPZrR92bPYhAqcHd+76Pn2NGxmw/f6iaYx1ZFeckuK0qPOWA4TxQ
	 cwOBtL3uBOmmWUtOcHWGh3vqLL/mb2N5CD/A3ooakvhttRZrFuEIUOg449zJRFAfbT
	 RcfXq8dF0BQIZYnfMbK1dr/XMCv8lATgLP2evs4ycDOw2uLzPt5xkk8ARsVIXdrxb7
	 xreaU+jxyE4cmkUPGH3qomDUYXktHFK/TzIzOGSg2ciqzGkdrzDPOjXF8QF4B3CG6Z
	 QCFufQgldpomFciORrpsJPiyRDfWN6jxaxA7x00THCFHUNmZ414zaB/OGWnqvh6OIE
	 UepEJku0jt9BA==
Message-ID: <34cc51d29f93f7d22510303c5f30cfbc3147a2e7.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 2/2] selftests: mptcp: join: validate extra
 bind cases
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, MPTCP Upstream
 <mptcp@lists.linux.dev>
Date: Tue, 14 Oct 2025 18:14:01 +0800
In-Reply-To: <95e3acf3-9a56-47d8-8314-ed6133403283@kernel.org>
References: <20251009-bind-extra-listen-v1-0-5ad2077d77a9@kernel.org>
	 <20251009-bind-extra-listen-v1-2-5ad2077d77a9@kernel.org>
	 <6efea80680213decf83313995a7afd9e4ce4fafd.camel@kernel.org>
	 <95e3acf3-9a56-47d8-8314-ed6133403283@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Tue, 2025-10-14 at 11:57 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> Thank you for the review!
> 
> On 14/10/2025 08:46, Geliang Tang wrote:
> > It took me some time to understand this test.
> Is there something I should add in the commit message to make this
> clearer?
> 
> > On Thu, 2025-10-09 at 19:33 +0200, Matthieu Baerts (NGI0) wrote:
> > > By design, an MPTCP connection will not accept extra subflows
> > > where
> > > no
> > > MPTCP listening sockets can accept such requests.
> > > 
> > > In other words, it means that if the 'server' listens on a
> > > specific
> > > address / device, it cannot accept MP_JOIN sent to a different
> > > address /
> > > device. Except if there is another MPTCP listening socket
> > > accepting
> > > them.
> > > 
> > > This is what the new tests are validating:
> > > 
> > >  - Forcing a bind on the main v4/v6 address, and checking that
> > > MP_JOIN
> > >    to announced addresses are not accepted.
> > > 
> > >  - Also forcing a bind on the main v4/v6 address, but before,
> > > another
> > >    listening socket is created to accept additional subflows.
> > > Note
> > > that
> > >    'mptcpize run nc -l' -- or something else only doing:
> > > socket(MPTCP),
> > >    bind(<IP>), listen(0) -- would be enough, but here
> > > mptcp_connect
> > > is
> > >    reused not to depend on another tool just for that.
> > > 
> > >  - Same as the previous one, but using v6 link-local addresses:
> > > this
> > > is
> > >    a bit particular because it is required to specify the
> > > outgoing
> > >    network interface when connecting to a link-local address
> > > announced
> > >    by the other peer. When using the routing rules, this doesn't
> > > work
> > >    (the outgoing interface is not known) ; but it does work with
> > > a
> > >    'laminar' endpoint having a specified interface.
> > > 
> > > Note that extra small modifications are needed for these tests to
> > > work:
> > > 
> > >  - mptcp_connect's check_getpeername_connect() check should strip
> > > the
> > >    specified interface when comparing addresses.
> > > 
> > >  - With IPv6 link-local addresses, it is required to wait for
> > > them to
> > >    be ready (no longer in 'tentative' mode) before using them,
> > > otherwise
> > >    the bind() will not be allowed.
> > > 
> > > Link: https://github.com/multipath-tcp/mptcp_net-next/issues/591
> > > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > > ---
> > >  tools/testing/selftests/net/mptcp/mptcp_connect.c |  10 +-
> > >  tools/testing/selftests/net/mptcp/mptcp_join.sh   | 153
> > > +++++++++++++++++++++-
> > >  2 files changed, 161 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> > > b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> > > index b148cadb96d0..c030b08a7195 100644
> > > --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> > > +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> > > @@ -1064,6 +1064,8 @@ static void check_getpeername_connect(int
> > > fd)
> > >  	socklen_t salen = sizeof(ss);
> > >  	char a[INET6_ADDRSTRLEN];
> > >  	char b[INET6_ADDRSTRLEN];
> > > +	const char *iface;
> > > +	size_t len;
> > >  
> > >  	if (getpeername(fd, (struct sockaddr *)&ss, &salen) < 0)
> > > {
> > >  		perror("getpeername");
> > > @@ -1073,7 +1075,13 @@ static void check_getpeername_connect(int
> > > fd)
> > >  	xgetnameinfo((struct sockaddr *)&ss, salen,
> > >  		     a, sizeof(a), b, sizeof(b));
> > >  
> > > -	if (strcmp(cfg_host, a) || strcmp(cfg_port, b))
> > > +	iface = strchr(cfg_host, '%');
> > > +	if (iface)
> > > +		len = iface - cfg_host;
> > > +	else
> > > +		len = strlen(cfg_host) + 1;
> > 
> > Why do we need to add 1 here? I tested it and it works without
> > adding
> > 1.
> 
> If I don't add 1, I will not include '\0' in the comparison with "a".
> 
> In other words, if you have:
> 
>   cfg_host = "abc";
>   a = "abc123";
>   len = strlen(cfg_host); /* = 3 */
> 
> Then strncmp(cfg_host, a, len) will return 0 because the 3 first
> chars
> are "abc". With 4 chars, they are different: "abc\0" vs "abc1".
> 
> So it is important to take the delimiter into account, just in case
> one
> is the prefix of the other one.

Sure, thanks for your explanation. I have no other comments, let's
apply this set.

Thanks,
-Geliang

> 
> Cheers,
> Matt

