Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D6E286D56
	for <mptcp@lists.linux.dev>; Thu, 23 Oct 2025 06:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761200661; cv=none; b=c/z2b8bcGxOH29zKRCiLYrzGpoImfitBeNZN2qL09c1HzdpcwthQSIWCObZ+H12NdKq9wejbchH4NCGjgO6S/mlkCA8awYOeN/OUHpLk2yUvukx1kKAABjnSEVgJU1+/nbCEmSKaJfRIXY9B4ORHjZFnv3+YrWBo02ig9xTFGzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761200661; c=relaxed/simple;
	bh=cUxS1MdYremUN4cNYfibifJ6G+LRGPsvQymSGLdsGmA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FgrA1RLbx/PVMP8nS3cBVx24WlTH6Mo4elqY5EOvXQ/J1q0ncWPdPqzbI7sieNvac99lbp4/BZDSOZC6upyBQNNpwbJUiEVZVcCmvHx28Goi3NSJZapyQukh+jrvssgzfUGTK+jlhtE8hEm61PE9FHiC5DkyBl4RF7kXUZ9A5+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMehJhPT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMehJhPT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DF14C4CEE7;
	Thu, 23 Oct 2025 06:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761200660;
	bh=cUxS1MdYremUN4cNYfibifJ6G+LRGPsvQymSGLdsGmA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=NMehJhPTQhyK/Dgvi7wnxn2PlooGIDEUYiJqCIKSzvKS5AaaLxKijyfc7854TnF0p
	 vpaHny/A71dca/fd2W1Eo7PJg3DgRj6FinoknhKYEoJ9oHpDQVNQF5+88gqDBiEUYt
	 gudPnhP0lFvxSHPfOSY7im5BQXUhZIJb0DXCQgBKYUUUrI98w/I8mSUkQxaO44ZHUR
	 waYffwN0e56o8kf0lkXOw8nZFlpbB3DIGBOVZjxtax3BJQvB9W0YAPP4Szem8djwJR
	 5U5p4vfVevo0hLVQmO7fwKfMauZ3NBGh1REhFuuPq0tKn6wr1+4Py6RMS/9ro0tPEP
	 IRn6zsl7M6g6Q==
Message-ID: <f7e3bb32be02262fa77a5311640f2282e4acdfbc.camel@kernel.org>
Subject: Re: [PATCH v2 mptcp-net 0/2] mptcp: restore zero window probe
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>
Date: Thu, 23 Oct 2025 14:24:14 +0800
In-Reply-To: <5676a1d0af9ee91eee8f90be2574ed297bd70272.camel@kernel.org>
References: <cover.1761118636.git.pabeni@redhat.com>
	 <5676a1d0af9ee91eee8f90be2574ed297bd70272.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Paolo,

On Wed, 2025-10-22 at 18:07 +0800, Geliang Tang wrote:
> Hi Paolo,
> 
> On Wed, 2025-10-22 at 09:39 +0200, Paolo Abeni wrote:
> > It turns out that the issue reported by Geliang on the pending
> > backlog
> > patches is actually on older one that the new code made more easy
> > reproducible.
> > 
> > The first patch in the series addresses it[1], the 2nd one
> > introduce
> > new
> > mibs to hopefully catch this problem sooned.
> > 
> > I have a pktdrill to validate this scenario. I'll share that soon.
> > 
> > @Geliang could you please validate the above in your testbed, on
> > top
> > of
> > the backlog and splice patches?
> 
> Thanks very much. I've already started testing, and so far everything
> is running smoothly. I'll let it run loop tests overnight and will
> have
> the results by tomorrow morning. I'll provide you with feedback then.

Thank you so much! This fix really works. I've run hundreds of splice
test loops with the following three patchsets applied, and no test
failures occurred:

	mptcp: restore zero window probe, v2
	mptcp: introduce backlog processing, v6
	implement mptcp read_sock, v13

Please add my tag for this set:

	Reported-and-tested-by: Geliang Tang <geliang@kernel.org>

> 
> Thanks,
> -Geliang
> 
> > 
> > [1] at least here, at least with the packet drill reproducer ;)
> > ---
> > v1 -> v2:
> >   - drop unneeded delta in patch 1/2

This change in v1 is valid. Later I will send a dedicated cleanup patch
for -next to use tcp_sk() in mptcp_sendmsg_frag() with your "Suggested-
by" tag.

Thanks,
-Geliang

> > 
> > Paolo Abeni (2):
> >   mptcp: restore window probe
> >   mptcp: zero window probe mib
> > 
> >  net/mptcp/mib.c      | 1 +
> >  net/mptcp/mib.h      | 1 +
> >  net/mptcp/protocol.c | 8 +++++++-
> >  3 files changed, 9 insertions(+), 1 deletion(-)
> > 
> 
> 

