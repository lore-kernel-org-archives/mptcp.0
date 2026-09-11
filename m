Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6804F10F1
	for <mptcp@lists.linux.dev>; Fri, 11 Sep 2026 23:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789168038; cv=none; b=L6ffvbIB8QuCOl/q9oBUDOdwqhyH8pog1DJf4NXaDIfP4Elm51oyRLx6Jdgjrq222lS1Z72ptgC0Ce+9Ro3OorRQUmFAIFEvwofEFBOL2FvFUFwOSBDzmGy1YUX7MkYe4X35zaFTBalQv+66qC4cyCEhKg6rgdjsaqp82hamLwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789168038; c=relaxed/simple;
	bh=M/uBdh3qBgHDMQB9xhFrWzoHWv6ER/155yoJD7FDdio=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uAziyYMKyfDXjuFzpwlLPUs/pSbUFrBo7RdwWyw7xFed4TJSmK3Wm9CrMkFuJVuVTwnEJezRrm6jZelrHgivfkGqIXNov6mDmVRdbqGDOAL4jUvaqVhdbKwnabBid7x8et7hbS8an3mB29d49oPZnS1LFGbiN3s7401s6Yu8gJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzjVVeOM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzjVVeOM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86321F000FF;
	Fri, 11 Sep 2026 23:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789168037;
	bh=m95KcVrj1UuT/UI0i061r8pIPrgPcivFHs6Cyw1URYc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KzjVVeOMEAFFM789AefvDlKDEbSux4YQXNXQE7bsRXaqZn9zqbikwAUtJMdNgn69t
	 Y5IZOp6zx1nuMObWOBD13mFCGNWhfdEO94NFgNTJD8n4UM4D08OyeD7yRlQZ+uFv7f
	 pH3Sizj0+OnNJZILJOqe4Cp8SNK/j9paXsKrvOrZ/z0aKsPRoywPrEA7W5HyJI7h0M
	 4v4+d4a1eACZWvZjDUov5kXCoQbBBk0EpofdU0RmXVJm/sFEiehJXu1m8jrkDvePeg
	 9NSeykJKQcitnm9jhzyirIknJL6AkPMvD2Fvo8t0uJmemjRmYEr9nKbgGpL4hhLoDq
	 lOSJ9PQeor0eg==
Message-ID: <678908417d5f8b872228daa6620b7934b7093222.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v3] mptcp: fix skb_ext leak in fallback mode
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Sat, 12 Sep 2026 07:07:13 +0800
In-Reply-To: <19934016-686b-45f1-91de-8ff29e5a7a06@kernel.org>
References: 
	<6e4266b0dc3eb7e68f0064e16fa9921f46b85319.1788338252.git.tanggeliang@kylinos.cn>
	 <19934016-686b-45f1-91de-8ff29e5a7a06@kernel.org>
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

Thanks for the review.

On Wed, 2026-09-02 at 12:20 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 02/09/2026 10:39, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > In fallback mode, MPTCP sockets behave as plain TCP and should not
> > allocate
> > SKB_EXT_MPTCP for transmitted skbs. The current code
> > unconditionally
> > allocates the extension, causing memory leaks when skbs are freed
> > without
> > releasing it.
> 
> I'm surprised by this. Do you have kmemleak reports?
> 
> Or is it linked to this issue?
> 
>   https://github.com/multipath-tcp/mptcp_net-next/issues/583
> 
> I'm asking because I would think that such issues would have been
> caught
> by kmemleak, plus the fix is quite invasive.

This is another kmemleak, which only occurred when I ran the fallback
TLS test after enabling the TLS settings on the fallback socket.

> 
> > Fix by short-circuiting __mptcp_add_ext() in fallback mode and
> > skipping all
> > DSS bookkeeping in mptcp_sendmsg_frag(). Also allow TCP coalescing
> > when
> > mpext is NULL in fallback mode.
> > 
> > This latent bug will be exposed once TLS ULP support is added to
> > fallback
> > MPTCP sockets, as each sendmsg via the TLS path would leak one
> > skb_ext
> > object.
> 
> Do you mean this bug is only visible with the new feature? If yes,
> then
> no need to threat it as a fix.

In v4, I removed the "Fixes" tag and changed it to for "mptcp-next".

> 
> Then, I'm also wondering if this patch shouldn't be specific to this
> case: maybe less code should be modified to deal with fallback

Yes, it's a version with less code in v4, and it fixes the root cause
of this issue.

Thanks,
-Geliang

> sockets
> once this happens? (I'm probably missing context to really help here)
> 
> Cheers,
> Matt
