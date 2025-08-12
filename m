Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7752E370F
	for <mptcp@lists.linux.dev>; Tue, 12 Aug 2025 08:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987613; cv=none; b=RTC7vLkS+ZKwREnk89+Otd8DrdsVc9eSP/4EUaSdn9rH2Wsd4NwQt+IqgBfNv9KirOzpIp4gJnf7T4z8AZQiEK2ea8qxlWqhM7yo4UCVf5SIV7gMpiAUv8EFcg5Wi48NvmPoe1XnLyrM45vtgBzzOjuKHv2RfGUbdIaBmcStX3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987613; c=relaxed/simple;
	bh=9IK612mdGgH8ZpLd86PAhTWpM/3gNTCICVIecpA1mu8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SN9IY80b9NX6F9d9o5KTx6aFBZImgEZrkJmE9HbYS17d5DAMbsSX9fE2xTnHOR7GMA3/Dk9M95neI+uId8hduQM10oOy/1FY84zSw+07KDvNAbsDaXmpg9MncmF8cF288xituTvNeyStcA8wxA0qXMEQIhQCjWwTRPBTU/ALPOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRnew/5f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRnew/5f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7D5C4CEF0;
	Tue, 12 Aug 2025 08:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754987612;
	bh=9IK612mdGgH8ZpLd86PAhTWpM/3gNTCICVIecpA1mu8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=QRnew/5fAzT4nNICQ35lrFm38Z8V+MwKsxTSyDNMEgRuH6l1SIUJGnXAPGlapv6qm
	 vCnR9CLSl9XOGRzz0YqxhWu/ALR1JZMF3Sf/rZ0yEv3QdqdrA30nt0YbKYl+VBc038
	 AyWoCIzI4CLSC5wPZD6hXzz+8MpALeEm3AiTYxN2rYkH39xrc6dbvcjKevhMjIWxmK
	 clh85QZaMvDYppMzeyF6D5vmfvwOIJ/MuGzypLObDm17Jv/AgJhx+iAws9RxmM+rEp
	 wXipI/0tErhX+lJUyzexplxo3i8flNbwbvu+8xBybkm1O/OEvMDEgNmDinYQNiP5tA
	 9IJQ/2Jg5rv5A==
Message-ID: <14bc329545215660bd23f5384f196c2fdba7b206.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v3 2/3] mptcp: make ADD_ADDR retransmission
 timeout adaptive
From: Geliang Tang <geliang@kernel.org>
To: Christoph Paasch <cpaasch@openai.com>, Matthieu Baerts
 <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Date: Tue, 12 Aug 2025 16:33:26 +0800
In-Reply-To: <CADg4-L8iLwmp6GCscWCq9vwPTyavgi54i5KSjLPneULQHvwB9Q@mail.gmail.com>
References: <cover.1754449947.git.tanggeliang@kylinos.cn>
	 <c559f29eea1e019b6d25a35f05bbeb85fdd578e1.1754449947.git.tanggeliang@kylinos.cn>
	 <eb6c0e4d-938c-4712-83b2-ee12bd70aa12@kernel.org>
	 <f42defcb7fe7db02283fed5def29623cbc6a24d7.camel@kernel.org>
	 <b0a4ebe8-0dfd-4c15-89bf-98c4f7cfebc0@kernel.org>
	 <78799855faff1bb19cdec5210ca5edf302d39974.camel@kernel.org>
	 <5d4dfa60-7604-4b45-becf-8df8bd0667ed@kernel.org>
	 <CADg4-L8iLwmp6GCscWCq9vwPTyavgi54i5KSjLPneULQHvwB9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Christoph, Matt,

On Mon, 2025-08-11 at 08:34 -0700, Christoph Paasch wrote:
> On Mon, Aug 11, 2025 at 7:51 AM Matthieu Baerts <matttbe@kernel.org>
> wrote:
> > 
> > Hi Geliang,
> > 
> > On 10/08/2025 03:13, Geliang Tang wrote:
> > > Hi Matt,
> > > 
> > > On Thu, 2025-08-07 at 13:56 +0200, Matthieu Baerts wrote:
> > > > Hi Geliang,
> > > > 
> > > > On 07/08/2025 05:25, Geliang Tang wrote:
> > > > > Hi Matt,
> > > > > 
> > > > > On Wed, 2025-08-06 at 17:34 +0200, Matthieu Baerts wrote:
> > > > > > Hi Geliang,
> > > > > > 
> > > > > > On 06/08/2025 05:17, Geliang Tang wrote:
> > > > > > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > > > > > > 
> > > > > > > Replace the fixed ADD_ADDR retransmission timeout with an
> > > > > > > adaptive
> > > > > > > mechanism that uses the maximum RTO among existing
> > > > > > > subflows.
> > > > > > > This
> > > > > > > improves responsiveness when establishing new subflows
> > > > > > > while
> > > > > > > maintaining
> > > > > > > an upper bound through the configured add_addr_timeout
> > > > > > > value.
> > > > > > > 
> > > > > > > Key changes:
> > > > > > > 1. Compute timeout as min(max_subflow_RTO,
> > > > > > > configured_max_timeout)
> > > > > > > 2. Apply exponential backoff based on retransmission
> > > > > > > count
> > > > > > > 3. Maintain fallback to configured max timeout when no
> > > > > > > subflows
> > > > > > > exist
> > > > > > > 4. Update documentation to clarify add_addr_timeout is
> > > > > > > now the
> > > > > > > maximum
> > > > > > > value
> > > > > > > 
> > > > > > > Closes:
> > > > > > > https://github.com/multipath-tcp/mptcp_net-next/issues/576
> > > > > > > Reviewed-by: Christoph Paasch <cpaasch@openai.com>
> > > > > > > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > > > > > > ---
> > > > > > >  Documentation/networking/mptcp-sysctl.rst |  4 +--
> > > > > > >  net/mptcp/pm.c                            | 30
> > > > > > > ++++++++++++++++++++---
> > > > > > >  2 files changed, 29 insertions(+), 5 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/Documentation/networking/mptcp-sysctl.rst
> > > > > > > b/Documentation/networking/mptcp-sysctl.rst
> > > > > > > index 1683c139821e..2b8e8fb99ee2 100644
> > > > > > > --- a/Documentation/networking/mptcp-sysctl.rst
> > > > > > > +++ b/Documentation/networking/mptcp-sysctl.rst
> > > > > > > @@ -8,8 +8,8 @@ MPTCP Sysfs variables
> > > > > > >  ===============================
> > > > > > > 
> > > > > > >  add_addr_timeout - INTEGER (seconds)
> > > > > > > - Set the timeout after which an ADD_ADDR control
> > > > > > > message
> > > > > > > will be
> > > > > > > - resent to an MPTCP peer that has not acknowledged a
> > > > > > > previous
> > > > > > > + Set the maximum value of timeout after which an
> > > > > > > ADD_ADDR
> > > > > > > control message
> > > > > > > + will be resent to an MPTCP peer that has not
> > > > > > > acknowledged
> > > > > > > a previous
> > > > > > >   ADD_ADDR message.
> > > > > > > 
> > > > > > >   Do not retransmit if set to 0.
> > > > > > > diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> > > > > > > index 1330af6a2154..34cc4f45bc7d 100644
> > > > > > > --- a/net/mptcp/pm.c
> > > > > > > +++ b/net/mptcp/pm.c
> > > > > > > @@ -268,6 +268,30 @@ int mptcp_pm_mp_prio_send_ack(struct
> > > > > > > mptcp_sock *msk,
> > > > > > >   return -EINVAL;
> > > > > > >  }
> > > > > > > 
> > > > > > > +static unsigned int mptcp_adjust_add_addr_timeout(struct
> > > > > > > mptcp_sock *msk)
> > > > > > > +{
> > > > > > > + struct mptcp_subflow_context *subflow;
> > > > > > > + struct sock *sk = (struct sock *)msk;
> > > > > > > + unsigned int max_rto = 0;
> > > > > > > + unsigned int timeout;
> > > > > > > +
> > > > > > > + timeout = mptcp_get_add_addr_timeout(sock_net(sk));
> > > > > > > +
> > > > > > > + mptcp_for_each_subflow(msk, subflow) {
> > > > > > > +         struct sock *ssk =
> > > > > > > mptcp_subflow_tcp_sock(subflow);
> > > > > > > +         unsigned int subflow_rto;
> > > > > > > +
> > > > > > > +         subflow_rto = __tcp_set_rto(tcp_sk(ssk)) * 2;
> > > > > > 
> > > > > > Why "* 2"? Is it what TCP is doing?
> > > > > > 
> > > > > > (Probably best to add a comment here above, and in the
> > > > > > commit
> > > > > > message.)
> > > > > > 
> > > > > > (Also, I guess the compiler will do the optimisation, but
> > > > > > you
> > > > > > could
> > > > > > write: ">> 1" instead of "* 2".
> > > > > 
> > > > > Yes, "<< 1" is much better. I added a comment here:
> > > > > 
> > > > > +               /*
> > > > > +                * icsk->icsk_rto is not used directly since
> > > > > +                * it's not updated frequently enough.
> > > > > +                *
> > > > > +                * subflow_rto is twice of rto, and allow
> > > > > +                * some tolerance for add_addr echo.
> > > > > +                */
> > > > > +               subflow_rto = __tcp_set_rto(tcp_sk(ssk)) <<
> > > > > 1;
> > > > > 
> > > > > Is this okay?
> > > > 
> > > > No :)
> > > > 
> > > > I don't think the comment explain why it is twice the default
> > > > TCP
> > > > RTO.
> > > > Why having an exception here for the ADD_ADDR? I mean: I'm OK
> > > > with
> > > > the
> > > > idea of doubling the RTO, but only if there is a reason behind
> > > > that
> > > > :)
> > > 
> > > How about this one (answered by DeepSeek, an AI from China):
> > > 
> > >         /*
> > >          * icsk->icsk_rto is not used directly since it's not
> > >          * updated frequently enough.
> > 
> > What about: (...) since it might not have been updated recently.
> > 
> > >          * Setting subflow_rto to twice of RTO provides a safety
> > >          * buffer for RTT estimation variance, kernel RTO update
> > >          * delays, and a full transmission retry cycle while
> > >          * minimizing false failures.
> > 
> > A bit long and not clear (typical AI, making commit messages too
> > verbose, it almost force me to use one to give me the summary :) )
> > 
> > What about:
> > 
> >   Setting this RTO to twice of TCP one, not to be too agressive for
> > this
> >   notification that might take longer to process than "simple"
> > data.
> > 
> > Still, is icsk_rto not already "long" enough by default? I mean:
> > when I
> > see your description in the related packetdrill PR [1] where the
> > delay
> > is supposed to be 0.01 sec, but "subflow_rto" (or was it isck_rto?)
> > is
> > 0.65 sec, that's quite different, and half of it would be more than
> > enough :)
> > 
> > But maybe that's different when it happens later during the
> > connection?
> 
> Why wouldn't icsk_rto not be good enough ? We just need a reasonable
> number here. And, I must say that 2 x __tcp_set_rto() seems a bit
> arbitrary. Let's just use icsk_rto. Does it really matter that it is
> not updated very frequently ?

Sure, I'll update this in v4, just using icsk->icsk_rto.

Thanks,
-Geliang

> 
> 
> Christoph
> 
> > 
> > [1] https://github.com/multipath-tcp/packetdrill/pull/166
> > 
> > Cheers,
> > Matt
> > --
> > Sponsored by the NGI0 Core fund.
> > 
