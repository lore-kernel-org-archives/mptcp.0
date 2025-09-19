Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B1F2D239D
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 10:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758276850; cv=none; b=LtGyTpeopwcJ3+WafaQw3VRk+ow46T1oqaCFsF1uTPzQVhleCMfuVNSzf/mw5LGG8HDmuI937+A2pMF4vZWuN+rcJcWvVE6BjRR4Q0H0cGXLXUiabUdmmM8yuY5Ypm+WmTgMKWS7yBsU4mXLZh2msXNE7AFQOqi5pUms6EpZ2zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758276850; c=relaxed/simple;
	bh=LIJG5Bv17I3pRefHhPwp58ppu4OyXqbcprwiFme+Dts=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gXI8SISNIRENjH3Do/z/O6q1iTIA4leRO+dkOCK3Zclhs7vE/86pZYrKkz28pOFxixZXWARHqwqqgBq8HWA93+I9BeyAu2zXI8x/MGfkJ33bp5oFwITun8NBlNgPBhb1VKpRoqI0fZjPzk0/iRkf2cM/9v4yZ0bgMVv2pU5ukKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCSWB8wV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCSWB8wV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43AD8C4CEF0;
	Fri, 19 Sep 2025 10:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758276850;
	bh=LIJG5Bv17I3pRefHhPwp58ppu4OyXqbcprwiFme+Dts=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=MCSWB8wVCYZBbOEdlghyFk7NNWGVTHENMQ6KcSwg9Zysc3gkKvQEaqFxtAxpC36+B
	 FKJZfY0w8qtzSdBOF/db4oymByKXOY6sg5qu3cXevnBxzoHJG7mCfsyQVz27iu0cF0
	 VJnVGg3h9wgWBpnas8mPFG0fX9vXYDKsta/xXRFo//7MK/RdtmcDQ9+ZdCt54NwzeG
	 mAakjIrSC1KO90k7u1GOVhHqKgL4Lz5/AxoG9b82x7RJ9/0jkpGLgn37Fde+1n/1oU
	 sxiTXk/Wdv7/OUXE+3xrBoMYYKWeyRvg2ltYYnDo7bdwjZHYP8h8XsQIFeo+3ERKn/
	 5+F+4s02p5zUQ==
Message-ID: <520a3e64d55d6ef73fffe8f5f66e6e442779df12.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v2 1/2] mptcp: pm: in-kernel: usable client
 side with C-flag
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, MPTCP Upstream
 <mptcp@lists.linux.dev>
Date: Fri, 19 Sep 2025 18:14:07 +0800
In-Reply-To: <77711101-541d-4d12-b377-74faf088c40f@kernel.org>
References: <20250916-pm-c-flag-client-default-v2-0-3be2c5bc4d6a@kernel.org>
	 <20250916-pm-c-flag-client-default-v2-1-3be2c5bc4d6a@kernel.org>
	 <b31466fa93dfaf3eb7a5b71712275d309c63fc21.camel@kernel.org>
	 <77711101-541d-4d12-b377-74faf088c40f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 2025-09-19 at 10:17 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 19/09/2025 05:01, Geliang Tang wrote:
> > Hi Matt,
> > 
> > Thanks for this v2.
> > 
> > On Tue, 2025-09-16 at 13:01 +0200, Matthieu Baerts (NGI0) wrote:
> > > When servers set the C-flag in their MP_CAPABLE to tell clients
> > > not
> > > to
> > > create subflows to the initial address and port, clients will
> > > likely
> > > not
> > > use their other endpoints. That's because the in-kernel path-
> > > manager
> > > uses the 'subflow' endpoints to create subflows only to the
> > > initial
> > > address and port.
> > > 
> > > If the limits have not been modified to accept ADD_ADDR, the
> > > client
> > > doesn't try to establish new subflows. If the limits accept
> > > ADD_ADDR,
> > > the routing routes will be used to select the source IP.
> > > 
> > > The C-flag is typically set when the server is operating behind a
> > > legacy
> > > Layer 4 load balancer, or using anycast IP address. Clients
> > > having
> > > their
> > > different 'subflow' endpoints setup, don't end up creating
> > > multiple
> > > subflows as expected, and causing some deployment issues.
> > > 
> > > A special case is then added here: when servers set the C-flag in
> > > the
> > > MPC and directly sends an ADD_ADDR, this single ADD_ADDR is
> > > accepted.
> > > The 'subflows' endpoints will then be used with this new remote
> > > IP
> > > and
> > > port. This exception is only allowed when the ADD_ADDR is sent
> > > immediately after the 3WHS, and makes the client switching to the
> > > 'fully
> > > established' mode. After that, 'select_local_address()' will not
> > > be
> > > able
> > > to find any subflows, because 'id_avail_bitmap' will be filled in
> > > mptcp_pm_create_subflow_or_signal_addr(), when switching to
> > > 'fully
> > > established' mode.
> > > 
> > > Fixes: df377be38725 ("mptcp: add deny_join_id0 in
> > > mptcp_options_received")
> > > Closes:
> > > https://github.com/multipath-tcp/mptcp_net-next/issues/536
> > > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > > ---
> > > Notes:
> > > - I tried to find a simple solution that can hopefully be
> > > backported
> > > to
> > >   cover the 'CDN' use-case.
> > > - I tried to find a solution respecting the 'accepted add addr'
> > > limit,
> > >   but I don't see how to... That's why here I limit the exception
> > > a
> > >   maximum: when this limit is 0 (default case), only the first
> > > ADD_ADDR,
> > >   etc. Feel free to share what you think about that.
> > > - I have some additional code doing some cleanup, and I started
> > > to
> > > look
> > >   at #503, which is a bit linked to that.
> > > - v2: move conditions to new helper (Geliang) + rename var,
> > > squash
> > > comm.
> > > ---
> > >  net/mptcp/pm.c        |  7 +++++--
> > >  net/mptcp/pm_kernel.c | 37 +++++++++++++++++++++++++++++++++++++
> > >  net/mptcp/protocol.h  |  7 +++++++
> > >  3 files changed, 49 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> > > index
> > > 02dfb379417e2843301f121039ec0d370b040ef7..edaf93fe6f86b32aee8e9bb
> > > 8831
> > > 8b1dc2a7fcb5e 100644
> > > --- a/net/mptcp/pm.c
> > > +++ b/net/mptcp/pm.c
> > > @@ -637,9 +637,12 @@ void mptcp_pm_add_addr_received(const struct
> > > sock *ssk,
> > >  		} else {
> > >  			__MPTCP_INC_STATS(sock_net((struct sock
> > > *)msk), MPTCP_MIB_ADDADDRDROP);
> > >  		}
> > > -	/* id0 should not have a different address */
> > > +	/* - id0 should not have a different address
> > > +	 * - special case for C-flag: linked to
> > > fill_local_addresses_vec()
> > > +	 */
> > >  	} else if ((addr->id == 0 &&
> > > !mptcp_pm_is_init_remote_addr(msk, addr)) ||
> > > -		   (addr->id > 0 && !READ_ONCE(pm-
> > > >accept_addr))) {
> > > +		   (addr->id > 0 && !READ_ONCE(pm->accept_addr)
> > > &&
> > > +		    !mptcp_pm_add_addr_c_flag_case(msk))) {
> > >  		mptcp_pm_announce_addr(msk, addr, true);
> > >  		mptcp_pm_add_addr_send_ack(msk);
> > >  	} else if (mptcp_pm_schedule_work(msk,
> > > MPTCP_PM_ADD_ADDR_RECEIVED)) {
> > > diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> > > index
> > > f30df8e884a0b3de9fb092e5774cafe08f6350ce..d7cd89fa6a11a1ea7703edb
> > > fbdf
> > > 2bbe86a6a3054 100644
> > > --- a/net/mptcp/pm_kernel.c
> > > +++ b/net/mptcp/pm_kernel.c
> > > @@ -389,10 +389,12 @@ static unsigned int
> > > fill_local_addresses_vec(struct mptcp_sock *msk,
> > >  	struct mptcp_addr_info mpc_addr;
> > >  	struct pm_nl_pernet *pernet;
> > >  	unsigned int subflows_max;
> > > +	bool c_flag_case;
> > >  	int i = 0;
> > >  
> > >  	pernet = pm_nl_get_pernet_from_msk(msk);
> > >  	subflows_max = mptcp_pm_get_subflows_max(msk);
> > > +	c_flag_case = remote->id &&
> > > mptcp_pm_add_addr_c_flag_case(msk);
> > >  
> > >  	mptcp_local_address((struct sock_common *)msk,
> > > &mpc_addr);
> > >  
> > > @@ -409,6 +411,10 @@ static unsigned int
> > > fill_local_addresses_vec(struct mptcp_sock *msk,
> > >  			locals[i].flags = entry->flags;
> > >  			locals[i].ifindex = entry->ifindex;
> > >  
> > > +			if (c_flag_case)
> > > +				__clear_bit(locals[i].addr.id,
> > > +					    msk-
> > > > pm.id_avail_bitmap);
> > > +
> > >  			/* Special case for ID0: set the correct
> > > ID
> > > */
> > >  			if
> > > (mptcp_addresses_equal(&locals[i].addr,
> > > &mpc_addr, locals[i].addr.port))
> > >  				locals[i].addr.id = 0;
> > > @@ -419,6 +425,37 @@ static unsigned int
> > > fill_local_addresses_vec(struct mptcp_sock *msk,
> > >  	}
> > >  	rcu_read_unlock();
> > >  
> > > +	/* Special case: peer sets the C flag, accept one
> > > ADD_ADDR
> > > if default
> > > +	 * limits are used -- accepting no ADD_ADDR -- and use
> > > subflow endpoints
> > > +	 */
> > > +	if (!i && c_flag_case) {
> > > +		unsigned int local_addr_max =
> > > mptcp_pm_get_local_addr_max(msk);
> > > +
> > > +		while (msk->pm.local_addr_used < local_addr_max
> > > &&
> > > +		       msk->pm.subflows < subflows_max) {
> > > +			struct mptcp_pm_local *local =
> > > &locals[i];
> > > +
> > > +			if (!select_local_address(pernet, msk,
> > > local))
> > > +				break;
> > > +
> > > +			__clear_bit(local->addr.id, msk-
> > > > pm.id_avail_bitmap);
> > > +
> > > +			if (!mptcp_pm_addr_families_match(sk,
> > > &local->addr,
> > > +							 
> > > remote))
> > > +				continue;
> > > +
> > > +			if (mptcp_addresses_equal(&local->addr,
> > > &mpc_addr,
> > > +						  local-
> > > >addr.port))
> > > +				continue;
> > > +
> > > +			msk->pm.local_addr_used++;
> > > +			msk->pm.subflows++;
> > > +			i++;
> > > +		}
> > > +
> > > +		return i;
> > > +	}
> > 
> > In the subsequent patches, this was refactored into a separate
> > helper.
> > I think that change is well-implemented and could be directly
> > squashed
> > into this patch. We can define this fill_local_addresses_vec_c_flag
> > here directly within this patch. WDYT?
> 
> I think it would be better not to add this new helper in this patch,
> and
> keep it as it is: it will be easier to backport that, and probably
> easier to review.

Sure, let's keep it as is.

> 
> Cheers,
> Matt
