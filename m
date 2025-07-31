Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1C71EDA2F
	for <mptcp@lists.linux.dev>; Thu, 31 Jul 2025 07:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753948520; cv=none; b=jTczecD+bAFHOc1D/nSGK1k9x5BJXK6ceU1uPNqwoLE/0WvFiaFoLy7qaXaie7A0LzaXG4mSq/MfNCkS+Q9fNrO/Amw8Nn3uA0kFjoF0brSwTklQK470iGJofpKk6bP8tcpgoAa4z/haLNtASZTseAZ1vF5nLwo02j+kY+yWfUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753948520; c=relaxed/simple;
	bh=yduhzFtHDw5ODigxjYefzd5e2AQ6V6t7N0ba2RiWCio=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NbSEQUPpSzfD5sDxOa8NWhNTpBMBFMCqGSCmDJ/BKVaZbMiLBUVBx66t6afHF5pzakpCw3nWW4jl0iiHY7cUQmNzZPWZMSWQpysTncZeWnRogXvqSwrnjiPdZNm36gYky9DPbrD6w+HYinRP1ltUW3bLpIZkhCk+Ht1I2kpq5mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5fr3rQu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5fr3rQu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87888C4CEEF;
	Thu, 31 Jul 2025 07:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753948519;
	bh=yduhzFtHDw5ODigxjYefzd5e2AQ6V6t7N0ba2RiWCio=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=p5fr3rQutbWfh+9Rd2D1wk1sWW2WE1or3XlzHsfZ8CBCCN41oEpB/7QPBOPYV3NF5
	 ect/+qYW0hiQWK18WsoN65kE/XgB0FEyMznwBg90bsoXKghWK5IcRKP3hY/+F9iK3G
	 wurzJfrfBuhtJfYGt8lIgZJhAXYbVC/i7IKj/0hmFCfCjXnDqmzHqmL+fRaf2DtkL9
	 bB+ztlEfvS464rVjvdpqOAZuSNaB8Evp9iictgkpil4zrozM0q6Jsi9xshwdtrlHz6
	 6QmRR4G7UQGQJjfj2maUYQb2M4pvXhtjx15oOFHCRDvaUqUXSWQ99/7a9U7pdnekjH
	 a+y4CcgEJHqAQ==
Message-ID: <1b68185d7d699e285917bb5abca34780557e6df0.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 2/3] mptcp: setsockopt support for TCP_MD5SIG
From: Geliang Tang <geliang@kernel.org>
To: Christoph Paasch <cpaasch@openai.com>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Date: Thu, 31 Jul 2025 15:55:16 +0800
In-Reply-To: <CADg4-L9m2=4d56kEpy48YYAaEhAe66m6fuG8qN_MdGi9W_GURg@mail.gmail.com>
References: <cover.1753859907.git.tanggeliang@kylinos.cn>
	 <7f2aaa80eef99f64ff6d7a48ce0a6bf06d1cacab.1753859907.git.tanggeliang@kylinos.cn>
	 <CADg4-L9m2=4d56kEpy48YYAaEhAe66m6fuG8qN_MdGi9W_GURg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Christoph,

On Wed, 2025-07-30 at 15:19 -0700, Christoph Paasch wrote:
> Hello!
> 
> On Wed, Jul 30, 2025 at 12:22 AM Geliang Tang <geliang@kernel.org>
> wrote:
> > 
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > This adds setsockopt support for TCP_MD5SIG and TCP_MD5SIG_EXT
> > options.
> > The implementation:
> > - Allows setting these options (getsockopt remains unsupported)
> > - Applies them only to the first subflow
> > - Maintains MD5 compatibility limitations with MPTCP
> > 
> > Note that TCP_MD5SIG and TCP_MD5SIG_EXT are unsupported for TCP
> > too.
> 
> Is there even enough option-space to have co-existence of MPTCP with
> TCP_MD5 ? I don't think so, right ?
> 
> The only way they can co-exist is if a bunch of other options are
> disabled. And in that case, do we really want to use non-MD5 on
> subsequent subflows ? I doubt that, because the goal of TCP-MD5 is to
> "improve" security.
> 
> So, shouldn't we rather disable MPTCP always when an app sets
> TCP_MD5SIG ?

I just updated this in v2 as you suggested.

Thanks,
-Geliang

> 
> 
> Christoph
> 
> > 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  net/mptcp/sockopt.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> > index b264185b810d..5b3e54f7d803 100644
> > --- a/net/mptcp/sockopt.c
> > +++ b/net/mptcp/sockopt.c
> > @@ -567,10 +567,12 @@ static bool mptcp_supported_sockopt(int
> > level, int optname)
> >                 case TCP_FASTOPEN_CONNECT:
> >                 case TCP_FASTOPEN_KEY:
> >                 case TCP_FASTOPEN_NO_COOKIE:
> > +               case TCP_MD5SIG:
> > +               case TCP_MD5SIG_EXT:
> >                         return true;
> >                 }
> > 
> > -               /* TCP_MD5SIG, TCP_MD5SIG_EXT are not supported,
> > MD5 is not compatible with MPTCP */
> > +               /* MD5 is not compatible with MPTCP */
> > 
> >                 /* TCP_REPAIR, TCP_REPAIR_QUEUE, TCP_QUEUE_SEQ,
> > TCP_REPAIR_OPTIONS,
> >                  * TCP_REPAIR_WINDOW are not supported, better
> > avoid this mess
> > @@ -834,6 +836,8 @@ static int mptcp_setsockopt_sol_tcp(struct
> > mptcp_sock *msk, int optname,
> >         case TCP_FASTOPEN_CONNECT:
> >         case TCP_FASTOPEN_KEY:
> >         case TCP_FASTOPEN_NO_COOKIE:
> > +       case TCP_MD5SIG:
> > +       case TCP_MD5SIG_EXT:
> >                 return mptcp_setsockopt_first_sf_only(msk, SOL_TCP,
> > optname,
> >                                                       optval,
> > optlen);
> >         }
> > --
> > 2.48.1
> > 
> > 
