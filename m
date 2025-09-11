Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A082E36E9
	for <mptcp@lists.linux.dev>; Thu, 11 Sep 2025 09:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757584778; cv=none; b=NbZAh0MbrRnVuc33h3qyLxkywotnQnjCX0ps/wjXZVhFk8nxL6O1lkUfdF2vM6LYmVPKXBT1ZcecGVtP1vCcDvDbMD7qoyD2gwTE9GZLPTT3zENSL7QOy6b96gA+1q5Q5M8Jx3h/74jr9lCh+qqWoRHIiwbqn9FbzqnREAe7bIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757584778; c=relaxed/simple;
	bh=CinhBQ1lLsW8K8SKU0yobGuP3ikezeLj9QvSFLLDNKk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dpq2PqTH6LOsMMuYVSAETAeHHT40/TYMIXjH3btRNI2eE3l3zpbgaKGKOZoQKg4VJn7EtKJPZNmyqrH5n28FSGRTCfhKn8FAyY8LkRknArQJW86r1a2V6Fm29K7D2nuGzP/JSeT+eMW029w2MvVAUFuXFv5NNKsyG4yIF+9zOys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sXCN0RZ1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXCN0RZ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB13C4CEF0;
	Thu, 11 Sep 2025 09:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757584777;
	bh=CinhBQ1lLsW8K8SKU0yobGuP3ikezeLj9QvSFLLDNKk=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=sXCN0RZ1+6ogJxefgpIJdcHHnl8PCUDFroh9TflTtMR26YAxBEkXt+NPJIpxHND1x
	 TODPoeh48FZu7FHdS8d11JNPhr3PPx9oQz5A7NweLOzbXvP0zW6QVODpor0kh4w9FF
	 HsKRaBV1SohzfktR5ub9+iIOlzdoSr6gPV9q2cpABVExc493e5s1w9xCzR14hMINNp
	 g2AVAv9021DOrkpDknaepCmQhfM2NV4Sb2JEy1Fn4ZrSJsK/A8/f+wAG/QUfEUo4pC
	 AJlg/tPnjC5H58MMA8UqIBnXRWw2JcOs21sqBN4WiuP+9OsrVLVtK14CXbAw5/MO3c
	 54XdPqH4OpUUw==
Message-ID: <c70c2516d8e46992443c6fd35969735831d55889.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 1/4] mptcp: pm: netlink: only add server-side
 attr when true
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, MPTCP Upstream
 <mptcp@lists.linux.dev>
Date: Thu, 11 Sep 2025 17:59:33 +0800
In-Reply-To: <fee179f9-c47a-4cdc-b3f3-ad0c69ae0abc@kernel.org>
References: 
	<20250909-mptcp-pm-user-server-side-flag-v1-0-cb8e2b8d1c0c@kernel.org>
	 <20250909-mptcp-pm-user-server-side-flag-v1-1-cb8e2b8d1c0c@kernel.org>
	 <732d1d85e092148ff8d8d1c82f311929a5d53ff3.camel@kernel.org>
	 <81bfd469-fc1b-4dc5-a049-5ee470b55bda@kernel.org>
	 <2512ba8fc5ffc4af4d0b147859e20940bf70540f.camel@kernel.org>
	 <9cd0c8da-96a1-40a1-8b56-1689803a32e7@kernel.org>
	 <2e5d12513033a5df4310a97a089ff6856ad70178.camel@kernel.org>
	 <fee179f9-c47a-4cdc-b3f3-ad0c69ae0abc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2025-09-11 at 11:28 +0200, Matthieu Baerts wrote:
> On 11/09/2025 10:45, Geliang Tang wrote:
> > On Thu, 2025-09-11 at 10:37 +0200, Matthieu Baerts wrote:
> > > Hi Geliang,
> > > 
> > > On 11/09/2025 10:33, Geliang Tang wrote:
> > > > Hi Matt,
> > > > 
> > > > On Thu, 2025-09-11 at 10:20 +0200, Matthieu Baerts wrote:
> > > > > Hi Geliang,
> > > > > 
> > > > > Thank you for the review!
> > > > > 
> > > > > On 11/09/2025 10:15, Geliang Tang wrote:
> > > > > > Hi Matt,
> > > > > > 
> > > > > > On Tue, 2025-09-09 at 18:30 +0200, Matthieu Baerts (NGI0)
> > > > > > wrote:
> > > > > > > This attribute is a boolean. No need to add it to set it
> > > > > > > to
> > > > > > > 'false'.
> > > > > > > 
> > > > > > > Indeed, the default value when this attribute is not set
> > > > > > > is
> > > > > > > naturally
> > > > > > > 'false'. A few bytes can then be saved by not adding this
> > > > > > > attribute
> > > > > > > if
> > > > > > > the connection is not on the server side.
> > > > > > > 
> > > > > > > This prepares the future deprecation of its attribute, in
> > > > > > > favour
> > > > > > > of a
> > > > > > > new flag.
> > > > > > > 
> > > > > > > Signed-off-by: Matthieu Baerts (NGI0)
> > > > > > > <matttbe@kernel.org>
> > > > > > > ---
> > > > > > >  Documentation/netlink/specs/mptcp_pm.yaml         | 4
> > > > > > > ++--
> > > > > > >  include/uapi/linux/mptcp_pm.h                     | 4
> > > > > > > ++--
> > > > > > >  net/mptcp/pm_netlink.c                            | 4
> > > > > > > +++-
> > > > > > >  tools/testing/selftests/net/mptcp/userspace_pm.sh | 2 +-
> > > > > > >  4 files changed, 8 insertions(+), 6 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/Documentation/netlink/specs/mptcp_pm.yaml
> > > > > > > b/Documentation/netlink/specs/mptcp_pm.yaml
> > > > > > > index
> > > > > > > d1b4829b580ad09baf4afd73b67abd7b4ef6883a..fc47a2931014c03
> > > > > > > 04ef
> > > > > > > d321
> > > > > > > 5cc2
> > > > > > > 4485ea22e1ede 100644
> > > > > > > --- a/Documentation/netlink/specs/mptcp_pm.yaml
> > > > > > > +++ b/Documentation/netlink/specs/mptcp_pm.yaml
> > > > > > > @@ -28,13 +28,13 @@ definitions:
> > > > > > >            traffic-patterns it can take a long time until
> > > > > > > the
> > > > > > >            MPTCP_EVENT_ESTABLISHED is sent.
> > > > > > >            Attributes: token, family, saddr4 | saddr6,
> > > > > > > daddr4
> > > > > > > > 
> > > > > > > daddr6, sport,
> > > > > > > -          dport, server-side, [flags].
> > > > > > > +          dport, [server-side], [flags].
> > > > > > >        -
> > > > > > >          name: established
> > > > > > >          doc: >-
> > > > > > >            A MPTCP connection is established (can start
> > > > > > > new
> > > > > > > subflows).
> > > > > > >            Attributes: token, family, saddr4 | saddr6,
> > > > > > > daddr4
> > > > > > > > 
> > > > > > > daddr6, sport,
> > > > > > > -          dport, server-side, [flags].
> > > > > > > +          dport, [server-side], [flags].
> > > > > > >        -
> > > > > > >          name: closed
> > > > > > >          doc: >-
> > > > > > > diff --git a/include/uapi/linux/mptcp_pm.h
> > > > > > > b/include/uapi/linux/mptcp_pm.h
> > > > > > > index
> > > > > > > 7359d34da446b94be148b363079120db03ba8549..bf44a5cf5b5a1e6
> > > > > > > d789
> > > > > > > 6326
> > > > > > > 82a9
> > > > > > > bedbf8090feb9 100644
> > > > > > > --- a/include/uapi/linux/mptcp_pm.h
> > > > > > > +++ b/include/uapi/linux/mptcp_pm.h
> > > > > > > @@ -16,10 +16,10 @@
> > > > > > >   *   good time to allocate memory and send ADD_ADDR if
> > > > > > > needed.
> > > > > > > Depending on the
> > > > > > >   *   traffic-patterns it can take a long time until the
> > > > > > > MPTCP_EVENT_ESTABLISHED
> > > > > > >   *   is sent. Attributes: token, family, saddr4 |
> > > > > > > saddr6,
> > > > > > > daddr4
> > > > > > > > 
> > > > > > > daddr6,
> > > > > > > - *   sport, dport, server-side, [flags].
> > > > > > > + *   sport, dport, [server-side], [flags].
> > > > > > >   * @MPTCP_EVENT_ESTABLISHED: A MPTCP connection is
> > > > > > > established
> > > > > > > (can
> > > > > > > start new
> > > > > > >   *   subflows). Attributes: token, family, saddr4 |
> > > > > > > saddr6,
> > > > > > > daddr4 |
> > > > > > > daddr6,
> > > > > > > - *   sport, dport, server-side, [flags].
> > > > > > > + *   sport, dport, [server-side], [flags].
> > > > > > >   * @MPTCP_EVENT_CLOSED: A MPTCP connection has stopped.
> > > > > > > Attribute:
> > > > > > > token.
> > > > > > >   * @MPTCP_EVENT_ANNOUNCED: A new address has been
> > > > > > > announced
> > > > > > > by
> > > > > > > the
> > > > > > > peer.
> > > > > > >   *   Attributes: token, rem_id, family, daddr4 | daddr6
> > > > > > > [,
> > > > > > > dport].
> > > > > > > diff --git a/net/mptcp/pm_netlink.c
> > > > > > > b/net/mptcp/pm_netlink.c
> > > > > > > index
> > > > > > > 483ddbb9ec406a3e965376ee5a833ae295896a02..33a6bf536c020b5
> > > > > > > 9717
> > > > > > > 472a
> > > > > > > ca2d
> > > > > > > 38add26255419 100644
> > > > > > > --- a/net/mptcp/pm_netlink.c
> > > > > > > +++ b/net/mptcp/pm_netlink.c
> > > > > > > @@ -413,7 +413,9 @@ static int mptcp_event_created(struct
> > > > > > > sk_buff
> > > > > > > *skb,
> > > > > > >  	if (err)
> > > > > > >  		return err;
> > > > > > >  
> > > > > > > -	if (nla_put_u8(skb, MPTCP_ATTR_SERVER_SIDE,
> > > > > > > READ_ONCE(msk-
> > > > > > > > pm.server_side)))
> > > > > > > +	/* only set when it is the server side */
> > > > > > > +	if (READ_ONCE(msk->pm.server_side) &&
> > > > > > > +	    nla_put_u8(skb, MPTCP_ATTR_SERVER_SIDE, 1))
> > > > > > 
> > > > > > In patch 2, this will be modified to use two 'if':
> > > > > > 
> > > > > > 	if (READ_ONCE(msk->pm.server_side)) {
> > > > > > 		flags |= MPTCP_PM_EV_FLAG_SERVER_SIDE;
> > > > > > 
> > > > > > 		/* only set when it is the server side */
> > > > > > 		if (nla_put_u8(skb,
> > > > > > MPTCP_ATTR_SERVER_SIDE,
> > > > > > 1))
> > > > > > 			return -EMSGSIZE;
> > > > > > 	}
> > > > > > 
> > > > > > Why don't we just use two 'if' statements here, which will
> > > > > > make
> > > > > > patch 2
> > > > > > simpler:
> > > > > > 
> > > > > >        if (READ_ONCE(msk->pm.server_side)) {
> > > > > >                /* only set when it is the server side */
> > > > > >                if (nla_put_u8(skb, MPTCP_ATTR_SERVER_SIDE,
> > > > > > 1))
> > > > > >                        return -EMSGSIZE;
> > > > > >        }
> > > > > > 
> > > > > > WDYT?
> > > > > 
> > > > > I'm not convinced: that might make the patch 2 simpler, but
> > > > > then
> > > > > the
> > > > > patch 1 will raise questions from reviewers and developers
> > > > > looking at
> > > > > the patches in the order they have been sent: why using 2
> > > > > 'if'
> > > > > statements while there is no need to use 2.
> > > > > 
> > > > > If we want that, I would have to add something in the commit
> > > > > message.
> > > > > I
> > > > > don't think that's worth it.
> > > > 
> > > > Sure. Let's keep this patch as is. If so, could you please
> > > > update
> > > > the
> > > > position of the comments in patch 2 and patch 3? Something
> > > > like:
> > > > 
> > > >         /* only set when it is the server side */
> > > >         if (READ_ONCE(msk->pm.server_side)) {
> > > >                 flags |= MPTCP_PM_EV_FLAG_SERVER_SIDE;
> > > 
> > > Mmh, I'm not sure: for the flag, it makes sense to only set it
> > > when
> > > it
> > > is the server side, otherwise that's wrong. Keeping the comment
> > > above
> > > is
> > > then a bit confusing, no?
> > 
> > If this comment needs to be just above nla_put_u8(), it makes sense
> > to
> > use 2 'if' here. But up to you.
> 
> Sorry, I'm lost:
> 
> - the comment above is for nla_put_u8(): that's strange to have such
>   comment with a flag that is obviously only set for the server side
> 
> - we need 2 'if' because there are two different actions here: set
> flags
>   + return error if any, no?

Sorry for the confusion, let's keep them as is.

Thanks,
-Geliang

> 
> Cheers,
> Matt
