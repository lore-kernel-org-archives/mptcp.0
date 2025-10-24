Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CBD3081A5
	for <mptcp@lists.linux.dev>; Fri, 24 Oct 2025 09:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761296605; cv=none; b=UZhQvVFqPEgmWfTOUoqFCR0ycfVszdcF9awggXomQuQVyPYFncZ9/HW0V9cFeLey/mTbzuRzXezYulKyZSFPvP+AJBsUa+717UGw8JeSnbE1Zeu/e4NwueLDbC+P8ttDr3LCA6uZQwSMkuDtnSz04POI7UZuqogwy/udrLXUCNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761296605; c=relaxed/simple;
	bh=6wbaKXaLP4F/KPtyRto7DL83MiM4t3h3zlbKHeyO34k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GzMtMVPdaCytGTf0s+c+5bJ2PD3viROLCFSiy8ZSxT+qoRz0+s0xobuiT4zHtca8WQnl78dBdr4490BRxQWn89HWb4MyDKoEZeiJVl1DetZmxjNEHBXVuzZzaccgc6yYMXM0mIswVomBk/h2gQUyHkXwxJY0NMiS4Yk4Zgelpd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqA8zbmI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqA8zbmI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC86C4CEF1;
	Fri, 24 Oct 2025 09:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761296604;
	bh=6wbaKXaLP4F/KPtyRto7DL83MiM4t3h3zlbKHeyO34k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=TqA8zbmIzYJy+5+MvImIS+x8w7xtwAeGLrXWE8ECCvPThYlmsacBHA41VvNvsr0W5
	 GlFUAcRQueSc2KA2FOmMJ3XNVoZWkweVTozzFcvULmc9hIRjHb5pDyt1xGJV49b0xW
	 2DonRgIkD5ztqF6DLVsGNF73XK/mcSTeBI9pAd9Iyh9+EP7dcUdppi7Sg/ERiN+Aiz
	 F8uq/I4EcO6ZYiOjJwI+0fTdKN5y9So6YMwXwJb/jhR5szQ5gAgIfDYFp3xaU5aHy/
	 1x0571VHeIZpiIPJzlVlqZITINg9om99g/MJ0MoGvekkB6bp+chZnhUHog8OQ2XrSq
	 KRtxmwiHUlqeQ==
Message-ID: <9028a30712a20176b4da97dbdc3a6aa2fd3c5674.camel@kernel.org>
Subject: Re: [PATCH v2 mptcp-net 0/2] mptcp: restore zero window probe
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>
Date: Fri, 24 Oct 2025 17:03:19 +0800
In-Reply-To: <2dc7ad69-e264-4733-a953-8368ee2a0b44@kernel.org>
References: <cover.1761118636.git.pabeni@redhat.com>
	 <5676a1d0af9ee91eee8f90be2574ed297bd70272.camel@kernel.org>
	 <f7e3bb32be02262fa77a5311640f2282e4acdfbc.camel@kernel.org>
	 <2dc7ad69-e264-4733-a953-8368ee2a0b44@kernel.org>
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

On Thu, 2025-10-23 at 17:54 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 23/10/2025 08:24, Geliang Tang wrote:
> > Hi Paolo,
> > 
> > On Wed, 2025-10-22 at 18:07 +0800, Geliang Tang wrote:
> > > Hi Paolo,
> > > 
> > > On Wed, 2025-10-22 at 09:39 +0200, Paolo Abeni wrote:
> > > > It turns out that the issue reported by Geliang on the pending
> > > > backlog
> > > > patches is actually on older one that the new code made more
> > > > easy
> > > > reproducible.
> > > > 
> > > > The first patch in the series addresses it[1], the 2nd one
> > > > introduce
> > > > new
> > > > mibs to hopefully catch this problem sooned.
> > > > 
> > > > I have a pktdrill to validate this scenario. I'll share that
> > > > soon.
> > > > 
> > > > @Geliang could you please validate the above in your testbed,
> > > > on
> > > > top
> > > > of
> > > > the backlog and splice patches?
> > > 
> > > Thanks very much. I've already started testing, and so far
> > > everything
> > > is running smoothly. I'll let it run loop tests overnight and
> > > will
> > > have
> > > the results by tomorrow morning. I'll provide you with feedback
> > > then.
> > 
> > Thank you so much! This fix really works. I've run hundreds of
> > splice
> > test loops with the following three patchsets applied, and no test
> > failures occurred:
> > 
> > 	mptcp: restore zero window probe, v2
> > 	mptcp: introduce backlog processing, v6
> > 	implement mptcp read_sock, v13
> > 
> > Please add my tag for this set:
> > 
> > 	Reported-and-tested-by: Geliang Tang <geliang@kernel.org>
> 
> Thank you for the test!
> 
> To avoid issues with checkpatch and to be consistent, I'm going to
> add
> this on the first patch:
> 
>   Reported-by: (...)
>   Closes:
> https://lore.kernel.org/d0a814c364e744ca6b836ccd5b6e9146882e8d42.camel@kernel.org
>   (...)
>   Tested-by: (...)
> 
> And only the Tested-by on the second one. I hope that's OK!
> 
> > > Thanks,
> > > -Geliang
> > > 
> > > > 
> > > > [1] at least here, at least with the packet drill reproducer ;)
> > > > ---
> > > > v1 -> v2:
> > > >   - drop unneeded delta in patch 1/2
> > 
> > This change in v1 is valid. Later I will send a dedicated cleanup
> > patch
> > for -next to use tcp_sk() in mptcp_sendmsg_frag() with your
> > "Suggested-
> > by" tag.
> 
> Please only add such patch when we modify code around in net-next.

Sure, I'll send it out together once I modify mptcp_sendmsg_frag in the
future.

Thanks,
-Geliang

> 
> Cheers,
> Matt

