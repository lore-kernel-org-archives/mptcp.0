Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CE32E2DEF
	for <mptcp@lists.linux.dev>; Thu, 11 Sep 2025 08:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757579593; cv=none; b=IDQO0zHC1HfLEcZbO6CZFMoC8XGurkxe2fLP16MqN2eInRJMHx9X8lCom1yZ1nIGweyUdXZthKdsXTunDy4qKV3xAYO92aRe7qjQhbeRfyjYUHrdqNa/fOxD4qmLh77axKOCd8FlfnHhy3w/H9VwM97gbmCUYg+7hZBeJBs2r20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757579593; c=relaxed/simple;
	bh=T95PzhbtyRybhv07dy+erPhzu/F2WArabGTk9lAqdzY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Oan+U84NGgZdNqCiaaBislYzzgqFelCv4NBRNRgi3vim2Tv2ZEJnqYbRvubXW3NK6xrRcX3aTmJFbZBQt5voKnM/O6ozuEsC4j+dwnLo8ocwkaTSFBbABSAV51uMspvtUBxiMuB7Wl5mHoEjR0miTQumVhCLGFC9RBHCXXMc7TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ne4xJj/I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ne4xJj/I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F36A4C4CEF1;
	Thu, 11 Sep 2025 08:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757579592;
	bh=T95PzhbtyRybhv07dy+erPhzu/F2WArabGTk9lAqdzY=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=Ne4xJj/IVRN6REeXO3+L017G6/RSH+VIfxbC1nrkUpM/UF7GYVdOxamfaucX3pxkC
	 vyNBJpZ5UHXwPqSR5edFpruatIUfmh0PK9DIJ8pi2oN4RfPF7B5w9g69LZUhpyDkIO
	 D+ukEZbX/0ZqVwh618aZLjcacOQhA1b3XayvXvv2PoMrWi9n1jTIuYJ0Hus4TFP66I
	 Ur/89Ld18LstBEl0sewIeu7Nm0r6e4s4AMnZP/3sV1GfC2fXAMJE7FY68JH59mPI2W
	 sq0roKgDYFH+vDyBJIdu5h1FwAYlRQw9SB7eAU1ywpEBDU61bFLujesID8eWIGwv95
	 nFhXD024lTBsw==
Message-ID: <2512ba8fc5ffc4af4d0b147859e20940bf70540f.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 1/4] mptcp: pm: netlink: only add server-side
 attr when true
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, MPTCP Upstream
 <mptcp@lists.linux.dev>
Date: Thu, 11 Sep 2025 16:33:08 +0800
In-Reply-To: <81bfd469-fc1b-4dc5-a049-5ee470b55bda@kernel.org>
References: 
	<20250909-mptcp-pm-user-server-side-flag-v1-0-cb8e2b8d1c0c@kernel.org>
	 <20250909-mptcp-pm-user-server-side-flag-v1-1-cb8e2b8d1c0c@kernel.org>
	 <732d1d85e092148ff8d8d1c82f311929a5d53ff3.camel@kernel.org>
	 <81bfd469-fc1b-4dc5-a049-5ee470b55bda@kernel.org>
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

On Thu, 2025-09-11 at 10:20 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> Thank you for the review!
> 
> On 11/09/2025 10:15, Geliang Tang wrote:
> > Hi Matt,
> > 
> > On Tue, 2025-09-09 at 18:30 +0200, Matthieu Baerts (NGI0) wrote:
> > > This attribute is a boolean. No need to add it to set it to
> > > 'false'.
> > > 
> > > Indeed, the default value when this attribute is not set is
> > > naturally
> > > 'false'. A few bytes can then be saved by not adding this
> > > attribute
> > > if
> > > the connection is not on the server side.
> > > 
> > > This prepares the future deprecation of its attribute, in favour
> > > of a
> > > new flag.
> > > 
> > > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > > ---
> > >  Documentation/netlink/specs/mptcp_pm.yaml         | 4 ++--
> > >  include/uapi/linux/mptcp_pm.h                     | 4 ++--
> > >  net/mptcp/pm_netlink.c                            | 4 +++-
> > >  tools/testing/selftests/net/mptcp/userspace_pm.sh | 2 +-
> > >  4 files changed, 8 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/Documentation/netlink/specs/mptcp_pm.yaml
> > > b/Documentation/netlink/specs/mptcp_pm.yaml
> > > index
> > > d1b4829b580ad09baf4afd73b67abd7b4ef6883a..fc47a2931014c0304efd321
> > > 5cc2
> > > 4485ea22e1ede 100644
> > > --- a/Documentation/netlink/specs/mptcp_pm.yaml
> > > +++ b/Documentation/netlink/specs/mptcp_pm.yaml
> > > @@ -28,13 +28,13 @@ definitions:
> > >            traffic-patterns it can take a long time until the
> > >            MPTCP_EVENT_ESTABLISHED is sent.
> > >            Attributes: token, family, saddr4 | saddr6, daddr4 |
> > > daddr6, sport,
> > > -          dport, server-side, [flags].
> > > +          dport, [server-side], [flags].
> > >        -
> > >          name: established
> > >          doc: >-
> > >            A MPTCP connection is established (can start new
> > > subflows).
> > >            Attributes: token, family, saddr4 | saddr6, daddr4 |
> > > daddr6, sport,
> > > -          dport, server-side, [flags].
> > > +          dport, [server-side], [flags].
> > >        -
> > >          name: closed
> > >          doc: >-
> > > diff --git a/include/uapi/linux/mptcp_pm.h
> > > b/include/uapi/linux/mptcp_pm.h
> > > index
> > > 7359d34da446b94be148b363079120db03ba8549..bf44a5cf5b5a1e6d7896326
> > > 82a9
> > > bedbf8090feb9 100644
> > > --- a/include/uapi/linux/mptcp_pm.h
> > > +++ b/include/uapi/linux/mptcp_pm.h
> > > @@ -16,10 +16,10 @@
> > >   *   good time to allocate memory and send ADD_ADDR if needed.
> > > Depending on the
> > >   *   traffic-patterns it can take a long time until the
> > > MPTCP_EVENT_ESTABLISHED
> > >   *   is sent. Attributes: token, family, saddr4 | saddr6, daddr4
> > > |
> > > daddr6,
> > > - *   sport, dport, server-side, [flags].
> > > + *   sport, dport, [server-side], [flags].
> > >   * @MPTCP_EVENT_ESTABLISHED: A MPTCP connection is established
> > > (can
> > > start new
> > >   *   subflows). Attributes: token, family, saddr4 | saddr6,
> > > daddr4 |
> > > daddr6,
> > > - *   sport, dport, server-side, [flags].
> > > + *   sport, dport, [server-side], [flags].
> > >   * @MPTCP_EVENT_CLOSED: A MPTCP connection has stopped.
> > > Attribute:
> > > token.
> > >   * @MPTCP_EVENT_ANNOUNCED: A new address has been announced by
> > > the
> > > peer.
> > >   *   Attributes: token, rem_id, family, daddr4 | daddr6 [,
> > > dport].
> > > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > > index
> > > 483ddbb9ec406a3e965376ee5a833ae295896a02..33a6bf536c020b59717472a
> > > ca2d
> > > 38add26255419 100644
> > > --- a/net/mptcp/pm_netlink.c
> > > +++ b/net/mptcp/pm_netlink.c
> > > @@ -413,7 +413,9 @@ static int mptcp_event_created(struct sk_buff
> > > *skb,
> > >  	if (err)
> > >  		return err;
> > >  
> > > -	if (nla_put_u8(skb, MPTCP_ATTR_SERVER_SIDE,
> > > READ_ONCE(msk-
> > > > pm.server_side)))
> > > +	/* only set when it is the server side */
> > > +	if (READ_ONCE(msk->pm.server_side) &&
> > > +	    nla_put_u8(skb, MPTCP_ATTR_SERVER_SIDE, 1))
> > 
> > In patch 2, this will be modified to use two 'if':
> > 
> > 	if (READ_ONCE(msk->pm.server_side)) {
> > 		flags |= MPTCP_PM_EV_FLAG_SERVER_SIDE;
> > 
> > 		/* only set when it is the server side */
> > 		if (nla_put_u8(skb, MPTCP_ATTR_SERVER_SIDE, 1))
> > 			return -EMSGSIZE;
> > 	}
> > 
> > Why don't we just use two 'if' statements here, which will make
> > patch 2
> > simpler:
> > 
> >        if (READ_ONCE(msk->pm.server_side)) {
> >                /* only set when it is the server side */
> >                if (nla_put_u8(skb, MPTCP_ATTR_SERVER_SIDE, 1))
> >                        return -EMSGSIZE;
> >        }
> > 
> > WDYT?
> 
> I'm not convinced: that might make the patch 2 simpler, but then the
> patch 1 will raise questions from reviewers and developers looking at
> the patches in the order they have been sent: why using 2 'if'
> statements while there is no need to use 2.
> 
> If we want that, I would have to add something in the commit message.
> I
> don't think that's worth it.

Sure. Let's keep this patch as is. If so, could you please update the
position of the comments in patch 2 and patch 3? Something like:

        /* only set when it is the server side */
        if (READ_ONCE(msk->pm.server_side)) {
                flags |= MPTCP_PM_EV_FLAG_SERVER_SIDE;

                /* Deprecated */
                if (nla_put_u8(skb, MPTCP_ATTR_SERVER_SIDE, 1)) 
                        return -EMSGSIZE;
        }

Thanks,
-Geliang

> 
> Cheers,
> Matt
