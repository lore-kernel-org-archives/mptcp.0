Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1420123A995
	for <mptcp@lists.linux.dev>; Tue, 28 Oct 2025 01:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761615263; cv=none; b=DEgw6yqcP2/TP9fG4xi2xuXjJUV6nAEKKGFOh+MyO2mMM2CqJErbapgGT7R4Zozv+LFWWk5FXy540OADcL+9R666RcFx/v2ouRuxSrXFqPC6zSbSwN6BcUi6TXQeDDIwkpE16cJEWEmFmXlhgHnv23GsYTaEI/sy3q7JT0cDvt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761615263; c=relaxed/simple;
	bh=Ce4YAeQg+ljw02miIWCFaKrowc/H6Xu2cVTg0A0vrmk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e581+dQQw5C8N+eYX54VdpzySonvGgODvIaD0/kR+MqjrEIwzTUzA10hYHzpaj8wx0aFwEEFKLpAy0LjTGKw0wFLFQP37o223YeLD65z4TDBIrIuN4Q3CNIc0vPRGyN+vems8TSCUP8lcOq4OdLtwtcZDLXzNCNomltDDBrIBDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cofof9Yw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cofof9Yw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B45CC4CEFB;
	Tue, 28 Oct 2025 01:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761615262;
	bh=Ce4YAeQg+ljw02miIWCFaKrowc/H6Xu2cVTg0A0vrmk=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=cofof9YwhVD+cMvF8jwaUijo4S2JarzuNKpFR+uyFKUubwLOMuclfDjTwPtIr/7KH
	 oYUoBZHb0h9m/vT5DsmvH7dBtTMIaVDNfwIVl6BLblHjCH5Tsz8Zr+6vVyESLnuRBH
	 e0HrpBTOgxjVMA3vUBY6AkanqYrNLHWOS5D4XFi0QRvR0ddxdty/YK/lT36cRWiMTh
	 UIXf45pGmU60IxdkWwPz3HY/4XgflxZfH+EQhvj1tQXit73Rn8O14XbAvdPqEmR/cG
	 Bm8sQG33f4f5jQtI8kIerd6RHk0wIBE5vlZL+8DMThMIXHiUvzsCDW6bkJGDMuWO9I
	 9b8gY5iStzTVw==
Message-ID: <074a8c2a99f102b2452570814c9700ef0225b145.camel@kernel.org>
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: join: validate
 extra bind cases"
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, MPTCP Upstream
 <mptcp@lists.linux.dev>
Date: Tue, 28 Oct 2025 09:34:16 +0800
In-Reply-To: <17404b24-dbed-4f16-9ff6-5822bffc3c1b@kernel.org>
References: <20251024-sft-fix-bind-timeout-v1-1-cb81a67b222c@kernel.org>
	 <95fdc88fbeba58db5976f97f117b1579a873c051.camel@kernel.org>
	 <17404b24-dbed-4f16-9ff6-5822bffc3c1b@kernel.org>
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

On Mon, 2025-10-27 at 13:21 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 24/10/2025 14:56, Geliang Tang wrote:
> > Hi Matt,
> > 
> > Thanks for this fix.
> > 
> > On Fri, 2025-10-24 at 12:02 +0200, Matthieu Baerts (NGI0) wrote:
> > > I was going to send the related commit upstream, but then I
> > > realised
> > > in
> > > a slow environment (e.g. public CI), with a debug kernel, the
> > > default
> > > 10 seconds timeout can be too short:
> > > 
> > >   086 multiple bind to allow joins v4
> > >         join Rx                             [ OK ]
> > >         join Tx                             [ OK ]
> > >   main_loop_s: timed out
> > >         add addr rx                         [ OK ]
> > >         add addr echo rx                    [ OK ]
> > >   ./mptcp_join.sh: line 3305: kill: (2032) - No such process
> > > 
> > > This doesn't affect the results, because it happens after the
> > > test,
> > > when
> > > checking the counters. Still, better to fix that by using an
> > > infinite
> > > timeout: the process will be killed at the end.
> > > 
> > > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > > ---
> > >  tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > index 05faacefb719..e0cdb9c662aa 100755
> > > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > @@ -3293,7 +3293,7 @@ bind_tests()
> > >  
> > >  		# Launching another app listening on a different
> > > address
> > >  		# Note: it could be a totally different app,
> > > e.g.
> > > nc, socat, ...
> > > -		ip netns exec ${ns1} ./mptcp_connect -l -p
> > > "$(get_port)" \
> > > +		ip netns exec ${ns1} ./mptcp_connect -l -t -1 -p
> > > "$(get_port)" \
> > 
> > A timeout of -1 means block indefinitely, right? Do you think using
> > the
> > default 30 seconds (-t ${timeout_poll}) is sufficient?
> 
> No need to use the same default timeout: this process is executed in
> the
> background, and we explicitly kill it at the end. Worst case, the
> other
> process timeout after 30 seconds, and we will still kill this one.
> 
> So it looks easier/better to use -1, no?

If that's the case, could we set a value that is, for example, twice or
ten times the value of ${timeout_poll}? But it's up to you.

Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> 
> Cheers,
> Matt

