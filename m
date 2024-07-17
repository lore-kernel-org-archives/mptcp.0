Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923DE6FB6
	for <mptcp@lists.linux.dev>; Wed, 17 Jul 2024 03:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721188440; cv=none; b=OP5/pCaozOQEf5dzw/KYv5smrfEx6pB28d9ni2DweMAniOYt/j4mjWSM+u6fEuLcw/fUCqT12yM2tcHq3eFAwkCQHNcSMC5HkqswxNLmnFVq9kikp60ayE5Zv2ysXNdvY7QxMETaNIxMNJt+8Kub23Ss4ZbM1Pj+hE/QjUzeAME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721188440; c=relaxed/simple;
	bh=8XAw0apYjm61bQpe0WRhE399vZX4llYVrMBVqqroLg0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e60qQCM8miQ/P9kvpy9wII+7GjQgRg8I0yd9u0EdmqFd02PoIY40Aqh0Jwtj3QH//Zt9GtxwpF9LCl3tVF3TzUiDmvGBUOML85cr6GkeTFKy+clXiAG6TjLFFyipdiSZy0isiYOlmIfQOi4xZmS509XmdfeG5vIw9xDkndpgg8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nxpd97/K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nxpd97/K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F803C32782;
	Wed, 17 Jul 2024 03:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721188440;
	bh=8XAw0apYjm61bQpe0WRhE399vZX4llYVrMBVqqroLg0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Nxpd97/KH/FBwLfE6PUd2A4PWl6NLhq0WRI1lBDs1xvqtZagfA1AybCGXXWQkb///
	 W+NyT50YSZTlhxaSsUXSK1WAH+mvGsJZKO/ClIXgAaq3Pt2uKETVZ+yfF7LNbzPfwW
	 XXQ9W84KO19RmurT6CMIDZgMQscjXjD+lhYpTuXaMytSJEVcv0vrPd60HXtBll3lXZ
	 c8vgEDCajMbW5Q3bAB41dZ1sMlreFezQGbqZGwa0kSzz/u/zvK4475qn6soSfit42B
	 0ShIbjkmSWWFqmQr/lBb18G/n2m7guw7vjWxtFw/wCg/3Eu5xMoKAfyLD3XphhRRnk
	 WQ6jZOATqSZYQ==
Message-ID: <17e90e599ab42cf21d31951af3737595416737b8.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v2 06/17] selftests: mptcp: join: ability to
 invert ADD_ADDR check
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>
Date: Wed, 17 Jul 2024 11:53:54 +0800
In-Reply-To: <9b98925b-addc-4be9-ab27-d9054ebc51fe@kernel.org>
References: <20240715-mptcp-pm-avail-v2-0-fc5153bd1f6e@kernel.org>
	 <20240715-mptcp-pm-avail-v2-6-fc5153bd1f6e@kernel.org>
	 <f62e151f743c4e6358f8745f2ba9bfbc746f6bab.camel@kernel.org>
	 <9b98925b-addc-4be9-ab27-d9054ebc51fe@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 TO0tfEdfAX7IENcV87h2yAFBZkaA==
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.0-1build2 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2024-07-16 at 10:12 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> Thank you for this review!
> 
> On 16/07/2024 05:20, Geliang Tang wrote:
> > Hi Matt,
> > 
> > On Mon, 2024-07-15 at 12:09 +0200, Matthieu Baerts (NGI0) wrote:
> > > In the following commit, the client will initiate the ADD_ADDR,
> > > instead
> > > of the server. We need to way to verify the ADD_ADDR have been
> > > correctly
> > > sent.
> > > 
> > > Note: the default expected counters for when the port number is
> > > given
> > > are never changed by the caller, no need to accept them as
> > > parameter
> > > then.
> > > 
> > > The 'Fixes' tag here below is the same as the one from the
> > > previous
> > > commit: this patch here is not fixing anything wrong in the
> > > selftests,
> > > but it validates the previous fix for an issue introduced by this
> > > commit
> > > ID.
> > > 
> > > Fixes: 86e39e04482b ("mptcp: keep track of local endpoint still
> > > available for each msk")
> > > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > > ---
> > >  tools/testing/selftests/net/mptcp/mptcp_join.sh | 40
> > > ++++++++++++++++---------
> > >  1 file changed, 26 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > index 55d84a1bde15..55ccc4fdf18a 100755
> > > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > @@ -1415,18 +1415,28 @@ chk_add_nr()
> > >  	local add_nr=$1
> > >  	local echo_nr=$2
> > >  	local port_nr=${3:-0}
> > > -	local syn_nr=${4:-$port_nr}
> > > -	local syn_ack_nr=${5:-$port_nr}
> > > -	local ack_nr=${6:-$port_nr}
> > > -	local mis_syn_nr=${7:-0}
> > > -	local mis_ack_nr=${8:-0}
> > 
> > nit: How about moving the code that reduces arguments into a
> > separate
> > patch?
> 
> I prefer not to in this case. If the patch was for net-next, that
> would
> have been a good idea. Here, it is for -net, and backporting shell
> scripts is a pain: there might not be any conflicts, but the script

How about this, send all these selftests patches in this set to net-
next, and the rest to -net. After all, these selftests patches are not
fixes, and selftests in -net can run normally without them, right?

But up to you.

Thanks,
-Geliang

> execution can be easily broken, and the stable team will not notice
> it
> because they don't execute them. Here, I want everything or nothing
> to
> be backported, not half of it. I even wonder if it would not be
> easier
> to squash patch 6 and 7 together. But maybe not for the moment to
> ease
> the reviews. WDYT?
> 
> Cheers,
> Matt

