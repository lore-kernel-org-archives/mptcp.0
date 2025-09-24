Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D46615624D
	for <mptcp@lists.linux.dev>; Wed, 24 Sep 2025 09:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758707830; cv=none; b=sfexHGOG5+puy4SgMzZ95yAsSVuXfyyd8AldgTZZ1axr9ZEzWmxGMP2w7gcV7aok4w5brsfuczKdbtwLhi11UCO+yMr4TPEq+AtG5awcqo+IMkvTD2pF3Bj22H1q0HQP7wwaKedFewwujAPEXeVK56iHgqqNPrAtRQGel4kpGHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758707830; c=relaxed/simple;
	bh=hhAX7TvCJO7Lue+PYgDLIRE76ISd7hv2S+WbVnpxYgM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mm7dyA12jhLPDBOw30HfgGkaCF7OP62Ty1CEDjLk4OzTaBTQ90WnURhM8OPqOzI15WAaKQfOmASX6h9LSN25Q1AMM8PW64e9b8/6R0OVSTztdkzLoQWT6eyOvJ8yXSVKzrdxC0RLi58tHz8eKJFnhEcVGPEoYi6gsOP8EVF2YJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNVGPXoJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNVGPXoJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E5E5C4CEE7;
	Wed, 24 Sep 2025 09:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758707829;
	bh=hhAX7TvCJO7Lue+PYgDLIRE76ISd7hv2S+WbVnpxYgM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=bNVGPXoJPf7mb867j9GEKU/66ckGcEIuUVi+2oyoLZVY4s6kFAxn9Q+Xb3kA/XhjO
	 OIoox3ZziqFHKaSiosFC/fWGeIAVYTL31SCbcxccbTPFib3PfUxMl0A9yXrEjO9lHO
	 yMjfopug+jwreTMV/P2DaMMC0l3R2jy7KgvlpA/XR8n23FpAVTZNDovTdJ4pB2tXZQ
	 5sUg/uRYFuAxoJFVCAX45JkOMvBlROp2OQm20rac+1+FDg6uwhI3aMPOz8WRZeomgU
	 G8jJHq4tHXnKTIm0o0b3JdFyrKc3fQX4b/WgvgU2t+8hDsm3XD2fhyk2b8HYr4s0Bp
	 Gg9Wvh1PuMX6w==
Message-ID: <78760bdffa868e1ce5ad8dee5518b5533f297e6e.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 0/6] mptcp: pm: in-kernel: add 'address'
 endpoints
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Date: Wed, 24 Sep 2025 17:57:06 +0800
In-Reply-To: <fc32a595-58b4-4a85-8006-917104aa5475@kernel.org>
References: 
	<20250923-pm-kern-endp-add_addr-new-v2-0-ee5369dad569@kernel.org>
	 <36b70ddb-cf0c-47d6-9f39-ab432d8e7529@kernel.org>
	 <eb157f05e27b66309c38c1f9f75a5c00ba4dd838.camel@kernel.org>
	 <fc32a595-58b4-4a85-8006-917104aa5475@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Wed, 2025-09-24 at 10:44 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 24/09/2025 10:31, Geliang Tang wrote:
> > Hi Matt,
> > 
> > On Wed, 2025-09-24 at 09:15 +0100, Matthieu Baerts wrote:
> > > Hi Geliang,
> > > 
> > > Do you mind looking at patch 5 of this series please?
> > > 
> > > A bit of context: With Mat, we would like to send this series to
> > > netdev
> > > ideally today, except if you see something blocking with the
> > > concept.
> > > For more details about this feature, please see:
> > > 
> > >   https://github.com/multipath-tcp/mptcp_net-next/issues/503
> > > 
> > > The idea is to have this feature in v6.18, the future LTS, and
> > > not
> > > delay
> > > that by one more year for client devices only using LTS versions.
> > 
> > Regarding this 'address' flag, I have a few thoughts:
> 
> Thank you for your reply!
> 
> Do you mind replying to the list as well please?

I didn't notice that this email was off-list. I cced our ML this time.

> 
> > - Among the names listed by Mat, I think "sspi" is better because
> > it
> > has already been used by mptcpd.
> 
> I would prefer avoiding 'sspi', because it doesn't prevent using the
> same interface more than once.
> 
> > - This flag, let's temporarily call it "sspi", needs to be a
> > subsidiary
> > indicator, similar to "fullmesh" and "backup". It cannot be used
> > alone
> > and must be used together with the main flags, namely "subflow" and
> > "signal". Based on the specific "sspi" flag, it seems that it can
> > only
> > be used with "subflow", like "subflow,sspi", and it should be
> > mutually
> > exclusive with "fullmesh".
> 
> It can be used alone without issues: see what is done in the tests in
> patch 6/6. In this setup, we do want the client not to create a
> subflow
> to the server's initial IP address (what "subflow" will do).
> 
> When 'fullmesh' is used in one of the endpoints, this mode will be
> used
> in priority. So it is not just having this new type + fullmesh used
> at
> the same time, it is global for all endpoints.
> 
> > - We need to add these restrictions in the code and comments.
> 
> I think it is better not to add restrictions on the kernel side if
> they
> are not required to prevent issues.

Thanks for the explanation. Clear now. No other comment from my side -
just the naming to focus on.

Thanks,
-Geliang

> 
> Cheers,
> Matt
