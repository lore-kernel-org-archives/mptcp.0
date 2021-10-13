Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066DA2C80
	for <mptcp@lists.linux.dev>; Wed, 13 Oct 2021 15:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1634140081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tVXwbD3rCMUiK4UawgaAdjGvbeWAov+GmFEON88NgG0=;
	b=Y/C3w1zRiBHZDfYZwp0Xw8dZEgHIt3BEy7LsVZqV59lJ7rrIZX9n61+ZELGOOF7dFakat2
	enyXZ4qskQBMUT4AO9eXLLEvd373YsbbwsLHE80IXLxKl7StzrgF9VwsFf3DDP6DIktDyd
	G/Z4pCjdw8PWVTIvXWpWgAX8JB2h1zE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-tQYLFsIxP0eJ3Jd2ak6cEw-1; Wed, 13 Oct 2021 11:47:58 -0400
X-MC-Unique: tQYLFsIxP0eJ3Jd2ak6cEw-1
Received: by mail-wr1-f69.google.com with SMTP id 75-20020adf82d1000000b00160cbb0f800so2299941wrc.22
        for <mptcp@lists.linux.dev>; Wed, 13 Oct 2021 08:47:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=tVXwbD3rCMUiK4UawgaAdjGvbeWAov+GmFEON88NgG0=;
        b=QkxOr/E5ohm2maEUgJqmASDAvXThvOWqNjnUEz+T/O/UmLq+8EjElaYVkRbQMZ2Pl8
         5Gc2qBqF1dTN0B6xvGFgajMXeroz/BWp05gWeHfAONCgyL42b6fepvFAFubJ64fppIYY
         8Df7OvSBpBrHbM9Aao+vwDEJg3CEFMx0Ug0j/sqa8URA7O47hcoo6Fmed4XXUt6JvBYp
         bypJBxrL3fsKxKs2YB9TSJPDz5yI5rKcat+x2/WkXaoR9AB7iFetRNpOYgqOOVeVMpmd
         wYL6mn5kYlwrTjxdRBIBnSgYL4TWiUJs8YbirZUHCWc+soszHbckoY0atQEbcxALHCc1
         jxXA==
X-Gm-Message-State: AOAM5302Cw32z9OEyZn0jL6MQ1DdJqrfX+/wD5N4Wkul19rj2HYtq6Iy
	wWW61h31CwS7uuAQ0wmW4tLk6YUBcpHoumsIiykaYwAB5lQJ0b1+ZpL3WolDllXklWEbApzH/IO
	LzK4VFZLhUfVWyvc=
X-Received: by 2002:a1c:9892:: with SMTP id a140mr81608wme.187.1634140077140;
        Wed, 13 Oct 2021 08:47:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxDDLY1VYLpQzhjJ2OL3+ZaI8MAsF/5FF2Hq5Kbtf3BIbzey/jG1CNNOXUI5LjbF0DdqNkMg==
X-Received: by 2002:a1c:9892:: with SMTP id a140mr81585wme.187.1634140076893;
        Wed, 13 Oct 2021 08:47:56 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-231-16.dyn.eolo.it. [146.241.231.16])
        by smtp.gmail.com with ESMTPSA id 3sm5711494wms.5.2021.10.13.08.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 08:47:56 -0700 (PDT)
Message-ID: <d4be3022ec8e5087a1a336e9c487aa4d3b045dfb.camel@redhat.com>
Subject: Re: [PATCH mptcp-next] mptcp: increase default max additional
 subflows to 2
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Date: Wed, 13 Oct 2021 17:47:55 +0200
In-Reply-To: <3292a94b-666b-6130-f3b8-48086bddd6d7@tessares.net>
References: <b7e5c73d59113afe32eec831b620997c86b56460.1633712415.git.pabeni@redhat.com>
	 <ed428aeb-8d9f-90c8-60cf-5c714b3460e5@tessares.net>
	 <f9860e6de0d54d4644a4a7eb94748ee2a1cb0fab.camel@redhat.com>
	 <3292a94b-666b-6130-f3b8-48086bddd6d7@tessares.net>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2021-10-13 at 17:29 +0200, Matthieu Baerts wrote:
> On 13/10/2021 16:54, Paolo Abeni wrote:
> > On Mon, 2021-10-11 at 18:09 +0200, Matthieu Baerts wrote:
> > > Hi Paolo,
> > > 
> > > On 08/10/2021 19:27, Paolo Abeni wrote:
> > > > The current default does not allowing additional subflows, mostly
> > > > as a safety restriction to avoid uncontrolled resource consumption
> > > > on busy servers.
> > > > 
> > > > Still the system admin and/or the application have to opt-in to
> > > > MPTCP explicitly. After that, they need to change (increase) the
> > > > default maximum number of additional subflows.
> > > > 
> > > > Let set that to reasonable default, and make end-users life easier.
> > > > 
> > > > Additionally we need to update some self-tests accordingly.
> > > > 
> > > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > > > ---
> > > >  net/mptcp/pm_netlink.c                          | 3 +++
> > > >  tools/testing/selftests/net/mptcp/mptcp_join.sh | 5 ++++-
> > > >  tools/testing/selftests/net/mptcp/pm_netlink.sh | 6 +++---
> > > >  3 files changed, 10 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > > > index 050eea231528..f7d33a9abd57 100644
> > > > --- a/net/mptcp/pm_netlink.c
> > > > +++ b/net/mptcp/pm_netlink.c
> > > > @@ -2052,6 +2052,9 @@ static int __net_init pm_nl_init_net(struct net *net)
> > > >  	struct pm_nl_pernet *pernet = net_generic(net, pm_nl_pernet_id);
> > > >  
> > > >  	INIT_LIST_HEAD_RCU(&pernet->local_addr_list);
> > > > +
> > > > +	/* Cit. 2 subflows ought to be enough for anybody. */
> > > > +	pernet->subflows_max = 2;
> > > 
> > > Sorry for the late reply, I just thought about something when looking at
> > > applying this: let say that in a typical setup we would have 2 subflows
> > > per connections because the client has 2 interfaces and connect to a
> > > server not announcing other addresses. With this setup, could we arrive
> > > in situations where we would (internally) have 3 subflows?
> > > 
> > > I mean, could we arrive in a situation where 1 (or 0) subflow is OK, 1
> > > is being deleted (network reconnection?) and the PM is already trying to
> > > create a new one? In this case and because of the limit, the PM might
> > > not try to create this 3rd subflow and might not retry when the dying
> > > subflow is actually being deleted? Or maybe the PM already wait for the
> > > full deletion before re-trying to establish a new subflow?
> > 
> > If I understand correctly, your fear is that we can end-up with 2
> > additional subflows even if there are only 2 different local IP
> > addresses/interface, is that correct?
> 
> Correct: typically in a "mobility use-case" where we move from one
> network to another. Or we simply get a new IP, etc.
> 
> > Anyhow the above scenario is not possible with the in-kernel path
> > manager: it will create new subflows only for local addresses not
> > already used by the mptcp connection.
> > 
> > Unless the 'fullmash' flag is set, but in that case user really wants
> > multiple subflows per local address.
> 
> Yes sorry, I was thinking about the 'fullmesh' case. But if the client
> has 2 interfaces -- each of them with one IP -- and the server only has
> one IP, we are in a "typical" UC I think. The behaviour with and without
> the "fullmesh" flag is the same.
> 
> > Please let me know if the above solves your doubts.
> 
> I guess here, it is userspace's responsibility to first remove the
> "broken" local address and then add the new one. If the opposite is
> done, we will have 3 local addresses, we will not create a new subflow
> but we will not create a new one when the 2nd subflow dies even if there
> is another available local address. But again, that would be userspace's
> fault, no? :)
> 
> > Side note: the in-kernel path manager takes no additional action when a
> > subflow is closed.
> 
> Should I create a ticket to check if another local address is not
> available after a subflow is closed and if we are still under the limit?
> Maybe the PM could also re-establish the subflow using the same 5-tuple
> depending on the err, e.g. if the subflow got disconnected after a NAT
> timeout, etc.

I guess that will cover also the scenario you mentioned in the previous
point. +1 to create a new ticket ;)

/P

