Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E0835979
	for <mptcp@lists.linux.dev>; Thu,  8 May 2025 07:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746688870; cv=none; b=kuTa7bu2ljGix8HnVxB23UVCmFhz1rmXCCx1/nuVKAAOw+qdRpgfPdEOy0d9IXHNTEP416v1chKjI7Tz9ovZR3+KDtZ2N3wEdeZNm+5yDe1m3wYBt/IzcQkkbYW0nyGjsPWgJg+wNy0MKPJEgrtxGmW5w9U7/tKjcNKK2//n4PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746688870; c=relaxed/simple;
	bh=loY/LwZ/QUAhwwhSY2kpnXBadOcQ2LLHpJjXwaccsJQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cIaAt6Hld6fL8DRfx1M6NNWYuagzwkOJwek142YimMx1r//iq9K9wEdb4Yjhd1CJETA8ZiSbpm1xIXaUvkxIAZdF3p8+3XMcNROynxE1zTuYVpB8+MycwIvYUHcJadGgss/BNFzdrrjH+Vrud9DnmSSR6cTIoPyKE4iEmuA32P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FbcZpz2T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FbcZpz2T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD08C4CEEB;
	Thu,  8 May 2025 07:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746688869;
	bh=loY/LwZ/QUAhwwhSY2kpnXBadOcQ2LLHpJjXwaccsJQ=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=FbcZpz2T3il2+z8uzqjMr1i5U5GLWjRJ/2icTfDi19NWpgG9Pjt+B0GUnaAK7ggBg
	 vjcEUsmvfECKu7CSJ+G8Y6zsoEjJsLaMmrJwbDO6vj9Unu5iwH4ralPhXLQH+b40/J
	 EYSmGEkt82RFJyD29iHEYEU0CH1ccdCKAK2Z3+5WSkIvFBFuTGfa91MvMClrTo/XYS
	 cvDpm900D0TWC+AcjOyS/kukEEYpCdZMDlhDPuztUQwjplet0viqRqBlkHGcoEb6J9
	 wYR1k9nccbGltc0IQpmjKZvJZ9ebTZQc57GYfoPyeY6hRJe94cdgTHHoA4/i4EKXbA
	 IdE3UQmNOj5BA==
Message-ID: <dd08686eee5b757ba526e3da3c062894655f56f3.camel@kernel.org>
Subject: Re: [PATCH mptcp-next] mptcp: validate maxseg sockopt
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Thu, 08 May 2025 15:21:04 +0800
In-Reply-To: <f5a3b547-d6d8-4448-a679-c638d918c9d6@kernel.org>
References: <cover.1745991978.git.geliang@kernel.org>
	 <b10aabf6c4529977b61e7662cf1f09db4752edaa.1745991826.git.geliang@kernel.org>
	 <f5a3b547-d6d8-4448-a679-c638d918c9d6@kernel.org>
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

Thanks for the review.

On Wed, 2025-04-30 at 11:42 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 30/04/2025 07:49, Geliang Tang wrote:
> > This patch validates the newly added TCP_MAXSEG sockopt.
> 
> If you don't mind and have access, do you mind creating a PR on
> GitHub
> instead please?

Here's the PR:

https://github.com/multipath-tcp/packetdrill/pull/161

> 
>   https://github.com/multipath-tcp/packetdrill
> 
> When you send them here, the CI might think it is a kernel patch and
> try
> to apply it (which can work with new files).
> 
> > Signed-off-by: Geliang Tang <geliang@kernel.org>
> > ---
> >  gtests/net/mptcp/sockopts/sockopt_maxseg.pkt | 20
> > ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >  create mode 100644 gtests/net/mptcp/sockopts/sockopt_maxseg.pkt
> > 
> > diff --git a/gtests/net/mptcp/sockopts/sockopt_maxseg.pkt
> > b/gtests/net/mptcp/sockopts/sockopt_maxseg.pkt
> > new file mode 100644
> > index 0000000..62492db
> > --- /dev/null
> > +++ b/gtests/net/mptcp/sockopts/sockopt_maxseg.pkt
> > @@ -0,0 +1,20 @@
> > +--tolerance_usecs=100000
> > +`../common/defaults.sh`
> > +
> > +0.0  socket(..., SOCK_STREAM, IPPROTO_MPTCP) = 3
> > +
> > ++0   bind(3, ..., ...) = 0
> > ++0   listen(3, 1) = 0
> > +
> 
> Here, similar to other sockopt tests, can you check the default value
> please? It should be the same as the one for "plain" TCP, 536 I
> suppose
> (min mss).
> 
> > ++0   setsockopt(3, SOL_TCP, TCP_MAXSEG, [1000], 4) = 0
> > ++0   getsockopt(3, SOL_TCP, TCP_MAXSEG, [1000], [4]) = 0
> 
> Can you move this block before the bind()/listen()? It seems to make
> more sense to set that before the listen(), no?
> 
> > ++0     <  S   0:0(0)         win 8000  <mss 1000, sackOK, nop,
> > nop, nop, wscale 0, mpcapable v1 flags[flag_h] nokey>
> 
> Just to avoid confusions, in the inject packet here, please set
> something else, e.g. 1460.
> 
> > ++0     >  S.  0:0(0)  ack 1            <mss 1000, nop, nop,
> > sackOK, nop, wscale 8, mpcapable v1 flags[flag_h] key[skey]>
> > ++0.01  <   .  1:1(0)  ack 1  win
> > 8000                                             <mpcapable v1
> > flags[flag_h] key[ckey=2, skey]>
> > ++0   accept(3, ..., ...) = 4
> 
> Can you do a getsockopt(4, ..., TCP_MAXSEG) here to check the value?
> It
> should be similar to what you would get with "plain" TCP (is it 988?
> or
> -20B reserved for MPTCP options?).
> 
> It might be better to introduce a new test doing the same thing with
> "plain" TCP to compare if you don't mind.
> 
> > ++0   write(4, ..., 100) = 100
> 
> Here, please write more than the MSS you set, e.g. 1250B to see how
> the
> stack will split that in two packets
> 
> > +
> > ++0     >  P.  1:101(100)  ack 1             <dss dack4=1   dsn8=1
> > ssn=1 dll=100 nocs, nop, nop>
> > ++0.01  <   .  1:1(0)      ack 101  win 256  <dss dack4=101 nocs>
> Here, can you change TCP_MAXSEG on the accepted socket (fd = 4)?
> 
> e.g. set it to 800, then do a getsockopt(), then write(4, ..., 1250)
> and
> see if you have 2 packets of the expected size.
> 

In this PR, I almost addressed all your comments above ...

> Then, if you don't mind, please also create a new subflow by
> injecting
> an MP_JOIN with a MSS of 1460, and check that the SYN+ACK+MP_JOIN
> generated by the kernel has a MSS of 1000 as expected. For an
> example,
> check mptcp/mp_join/mp_join_server.pkt.

But I still have some problems when creating a new subflow, which will
be added later.

Thanks,
-Geliang

> 
> Cheers,
> Matt

