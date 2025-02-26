Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D90F4C96
	for <mptcp@lists.linux.dev>; Wed, 26 Feb 2025 01:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740531928; cv=none; b=Pm5Inp/LfXKBbLzYr9MC+T1XEvrO3pz5khUfcKDxnOdKlDpwRFbmf6Cwhz6omW0mlXpZ4ZOZALEacUdzFW//2/ZY9dxlxYf4FE3PUMx5KYbNTzUsQUej1N0PJfMaDXZmafF7S2rWpq32sJnbMR+jrrQfAAw7GUj+gm+yXZhJgxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740531928; c=relaxed/simple;
	bh=R265vxc8EPZbUGfTzySy+jIeOJvCcy+uyZ/UR7P19Ys=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=If2cAhd1Z55mU8SPtY+1mcfGpQ9QQq1MX6vF2GMdl0J5Pyr+pxPzfpzL0zHyTKLOx4VkAeGpf3WJRmShTH4AMk1xl7KIOPkX2f8VtjrOterEU76SzaYULo/2SHJWh+91cONhj40JT9qrMRDXYCg8vcZTBIPSw6TWZP7jxxLZLf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4pUmLOA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4pUmLOA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1573FC4CEDD;
	Wed, 26 Feb 2025 01:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740531927;
	bh=R265vxc8EPZbUGfTzySy+jIeOJvCcy+uyZ/UR7P19Ys=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=R4pUmLOAjwOy08yW5Blicb/916C8QgZsHUEKqeri+W8PL2bV5zeu4xMdaIAqbA9lp
	 pmsG+f1VhPHgpAAtI7rhKJU29Wr9D51MpDGyM899T4tDNywtfSEkh6PuQcQt6gLaXm
	 HeBzWfo3K4oCGEv/06BCpjpGHLTrgE1b+XEVEF/COgukw9x71zpiRsETAFcchJMo6n
	 3IoTkBMqDGTvqZOgPOsaOR9og2QZhNicNDw9UvMTtDy8IC6L1L1VW8XBzpxVwvB3NY
	 tjr3zUSwpPLQ/oMUqbVhtxlXD6ZcCieVVwhsq2eq2j/X4G56JngY0OyG4QhoT/Q4qg
	 AjeWf2ihD4qrQ==
Message-ID: <93b8333063dbe7887987128d84a3985d48981148.camel@kernel.org>
Subject: Re: [PATCH mptcp-next] mptcp: pm: userspace: avoid scheduling
 in-kernel PM worker
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Wed, 26 Feb 2025 09:05:23 +0800
In-Reply-To: <cf5fdbbe-856e-419c-812e-44f61fc89778@kernel.org>
References: 
	<20250224-mptcp-userspace-avoid-worker-v1-1-127325d3e9a4@kernel.org>
	 <8ccd5c340bb75c8e325c8b8a1207671785cf911d.camel@kernel.org>
	 <0b1c7e47-78d1-4dbb-b78b-e071f9c08dac@kernel.org>
	 <cf5fdbbe-856e-419c-812e-44f61fc89778@kernel.org>
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

On Tue, 2025-02-25 at 19:15 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 25/02/2025 10:25, Matthieu Baerts wrote:
> > Hi Geliang,
> > 
> > Thank you for your review!
> > 
> > On 25/02/2025 05:21, Geliang Tang wrote:
> > > Hi Matt,
> > > 
> > > On Mon, 2025-02-24 at 20:01 +0100, Matthieu Baerts (NGI0) wrote:
> > > > When the userspace PM is used, there is no need to schedule the
> > > > PM
> > > > worker for in-kernel specific tasks, e.g. creating new
> > > > subflows, or
> > > > sending more ADD_ADDR.
> > > > 
> > > > Now, these tasks will be done only if the in-kernel PM is being
> > > > used.
> > > > 
> > > > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > > > ---
> > > > Notes:
> > > >  - I don't know if this should be seen as a fix. Maybe yes
> > > > because it
> > > >    was not supposed to do that from the beginning, and it feels
> > > > less
> > > >    risky not to schedule the worker when it is not needed. I'm
> > > > open
> > > > to
> > > >    suggestions here.
> > > >  - I'm mainly sharing this patch now because Geliang is going
> > > > to
> > > > modify
> > > >    these helpers to separate PM specific code.
> > > >    @Geliang: please rebase your series on top of this one (or
> > > > include
> > > >    this patch if it is easier).
> > > > Cc: Geliang Tang <tanggeliang@kylinos.cn>
> > > > ---
> > > >  net/mptcp/pm.c | 10 ++++++++--
> > > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> > > > index
> > > > 16cacce6c10fe86467aa7ef8e588f9f535b586fb..4eabb8332890567675976
> > > > 8fb44c
> > > > 859f5682721e3 100644
> > > > --- a/net/mptcp/pm.c
> > > > +++ b/net/mptcp/pm.c
> > > > @@ -138,7 +138,7 @@ void mptcp_pm_fully_established(struct
> > > > mptcp_sock
> > > > *msk, const struct sock *ssk)
> > > >  	 * racing paths - accept() and
> > > > check_fully_established()
> > > >  	 * be sure to serve this event only once.
> > > >  	 */
> > > > -	if (READ_ONCE(pm->work_pending) &&
> > > > +	if (mptcp_pm_is_kernel(msk) && READ_ONCE(pm-
> > > > >work_pending)
> > > > &&
> > > 
> > > I think there's no need to modify this. work_pending is set to 0
> > > by 
> > > userspace pm, for all cases where work_pending is 1, the path
> > > manager
> > > must be an in-kernel pm.
> > 
> > Good point, I missed that!
> > 
> > 'pm->work_pending' doesn't look like a good name for what it does.
> > Hopefully, this will be clearer when pm->ops will be used, which
> > will
> > clearly separate what is done by the different PMs.
> > 
> > Also, is it possible we never set 'pm->work_pending' back to 'true'
> > once
> > it has been set to 'false'? Does it mean when we reach the limits,
> > and
> > something happens (e.g. a removed subflow, limits are changed,
> > etc.),
> > the worker is no longer used to establish new subflows or react
> > when an
> > ADD_ADDR is received?
> 
> I didn't check, but it feels like we should add something like that:

Yes, it is. We only set 'work_pending' to 'false' in
mptcp_pm_nl_check_work_pending() but never set it back.

I'll try to fix this later. Please add an issue for it on github.

> 
> > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > index d4328443d844..dee3e3c14ec3 100644
> > --- a/net/mptcp/pm_netlink.c
> > +++ b/net/mptcp/pm_netlink.c
> > @@ -248,6 +248,8 @@ bool mptcp_pm_nl_check_work_pending(struct
> > mptcp_sock *msk)
> >                 WRITE_ONCE(msk->pm.work_pending, false);
> >                 return false;
> >         }
> > +
> > +       WRITE_ONCE(msk->pm.work_pending, true);
> >         return true;
> >  }
> >  
> > @@ -911,6 +913,9 @@ static void
> > mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
> >                                 WRITE_ONCE(msk->pm.accept_addr,
> > true);
> >                 }
> >         }
> > +
> > +       if (mptcp_pm_is_kernel(msk))
> > +               mptcp_pm_nl_check_work_pending(msk);
> >  }
> >  
> >  static void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk)
> 
> 
> So to re-enable msk->pm.work_pending when limits have been reached,
> and
> it is no longer the case. WDYT?
> 
> We would need a new subtest to confirm this patch is needed, and to
> avoid regressions later.

And add a selftest for this too.

> 
> (...)
> 
> > > > @@ -278,6 +281,9 @@ void mptcp_pm_rm_addr_received(struct
> > > > mptcp_sock
> > > > *msk,
> > > >  	for (i = 0; i < rm_list->nr; i++)
> > > >  		mptcp_event_addr_removed(msk, rm_list-
> > > > >ids[i]);
> > > >  
> > > > +	if (!mptcp_pm_is_kernel(msk))
> > > > +		return;
> > > 
> > > This mptcp_pm_is_kernel() is indeed needed.
> > 
> > Yes it is. And 'pm->work_pending' cannot be used, because it will
> > be set
> > to false when the limits are reached, but a RM_ADDR will
> > potentially
> > decrement counters.
> 
> In fact, it is not needed: from what I see, the corresponding
> subflows
> are removed on the kernel side, the userspace daemon doesn't need to
> send a request to remove them. See the modification from 4d25247d3ae4
> ("mptcp: bypass in-kernel PM restrictions for non-kernel PMs") in
> mptcp_pm_nl_rm_addr_or_subflow().
> 
> > I will send a v2 with only this change.
> I will send a v2 with only an early exit in
> mptcp_pm_add_addr_echoed()
> if there is no need to schedule the worker.

Sure. I agree.

Thanks,
-Geliang

> 
> Cheers,
> Matt

