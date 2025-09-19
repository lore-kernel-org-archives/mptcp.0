Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9AC2E54B3
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 10:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758278238; cv=none; b=YFIILFXKs4DpShSslVJbbGkfcoq6b9VhBQG4BKFaAqGMy+DHDboyhO1wUOgG5Ha4EA4PlPOas2J5L3QOJ6vyiHKYtQaDZcpBxKcFzUW8pksf/4KVng0xfjTXp4S9S4pE1qW6aARyVcta4fIUPCseU2O2QuUngoAdnnePfNmKPio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758278238; c=relaxed/simple;
	bh=9pvGqYmsraem/E9rWFSoDrz7IZtveWEzc4d/JEQdl7A=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rPBAEf90OSahZ9qkYpbcEFeve4wQrLFpMmkx5mT5VjksWTvV6aRsx1KSTvA8jmT3CKbrpItu2qAqJ26GrkugfMOds/PsuiYL0a02h6A3v9udKuzPIgl/FZZ1Q8WVqawZoGD+JM0cHphr8XryCC7tZwuV53m7G46B6Nfxs38mhMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUk4SGnv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUk4SGnv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 946C8C4CEF0;
	Fri, 19 Sep 2025 10:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758278238;
	bh=9pvGqYmsraem/E9rWFSoDrz7IZtveWEzc4d/JEQdl7A=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=oUk4SGnvO5z7Al/lU+F+Z7EICVfH9QWsQ4TNBRo/PjtZn3v+3OKhM6d485SFo2u9n
	 hHXVweoZuzQ6G/jRl75D94CUDhvAA1OciWviaU1rktWtrqSitct3u261cmkmB6bZGL
	 zlUC9QASQ4Gi8p1+CIK/EPFWg+rtzzSxABYre0zVSUqOvDXWmGIBTeipx9TGVFOa9f
	 WnqV3Le1q46jj2S0UnsprtyNrsvjp9OJRVr0GgkTlQWjykiw0V0xqi2YGhaIQVFk0e
	 LAVHdAjXU/JBeUOevlMWGa6ngCZvEAvnT4a8/w/FWt25aVg2sRk2zXExbhBMDJBgfJ
	 Zc3kMR1/5zkyA==
Message-ID: <b18ae2272c133fc1d067e0903cbdb835b9f84b94.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 01/10] Squash to "mptcp: pm: in-kernel:
 usable client side with C-flag"
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, MPTCP Upstream
 <mptcp@lists.linux.dev>
Date: Fri, 19 Sep 2025 18:37:14 +0800
In-Reply-To: <af038759-e7cb-4cba-a23f-e7cb06a07dcb@kernel.org>
References: <20250919-pm-kern-endp-add_addr-v2-0-1f8f04f01914@kernel.org>
	 <20250919-pm-kern-endp-add_addr-v2-1-1f8f04f01914@kernel.org>
	 <c702e2fc35fdbea872ac01eb49c9f7f7be0262a9.camel@kernel.org>
	 <af038759-e7cb-4cba-a23f-e7cb06a07dcb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 2025-09-19 at 12:30 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 19/09/2025 12:11, Geliang Tang wrote:
> > Hi Matt,
> > 
> > Thanks for this set. It looks good to me overall. Only one comment
> > below.
> > 
> > On Fri, 2025-09-19 at 11:08 +0200, Matthieu Baerts (NGI0) wrote:
> > > The id_avail_bitmap is only used when either the 'subflow' or
> > > 'signal'
> > > flag is used, but not with 'fullmesh' only. Here, it is replacing
> > > the
> > > 'subflow' action, so check if this flag is set.
> > > 
> > > Also, add the check for the max subflows upfront, so we avoid
> > > scheduling
> > > the worker with MPTCP_PM_ADD_ADDR_RECEIVED if it is not needed.
> > > 
> > > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > > ---
> > > v2: modify protocol.h here too (Geliang)
> > > ---
> > >  net/mptcp/pm_kernel.c | 3 ++-
> > >  net/mptcp/protocol.h  | 3 ++-
> > >  2 files changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> > > index
> > > d7cd89fa6a11a1ea7703edbfbdf2bbe86a6a3054..277f81f38134d0791814333
> > > 1746
> > > a50bc316d81ca 100644
> > > --- a/net/mptcp/pm_kernel.c
> > > +++ b/net/mptcp/pm_kernel.c
> > > @@ -411,7 +411,8 @@ static unsigned int
> > > fill_local_addresses_vec(struct mptcp_sock *msk,
> > >  			locals[i].flags = entry->flags;
> > >  			locals[i].ifindex = entry->ifindex;
> > >  
> > > -			if (c_flag_case)
> > > +			if (c_flag_case &&
> > > +			    (entry->flags &
> > > MPTCP_PM_ADDR_FLAG_SUBFLOW))
> > >  				__clear_bit(locals[i].addr.id,
> > >  					    msk-
> > > > pm.id_avail_bitmap);
> > >  
> > > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > > index
> > > dd0662defd41c84474e44c559c571e3594b85d9e..0d6dae37c9daf4ec8990b9a
> > > 8703
> > > 6aa393add585c 100644
> > > --- a/net/mptcp/protocol.h
> > > +++ b/net/mptcp/protocol.h
> > > @@ -1200,7 +1200,8 @@ static inline bool
> > > mptcp_pm_add_addr_c_flag_case(struct mptcp_sock *msk)
> > >  {
> > >  	return READ_ONCE(msk->pm.remote_deny_join_id0) &&
> > >  	       msk->pm.local_addr_used == 0 &&
> > > -	       mptcp_pm_get_add_addr_accept_max(msk) == 0;
> > > +	       mptcp_pm_get_add_addr_accept_max(msk) == 0 &&
> > > +	       msk->pm.subflows <
> > > mptcp_pm_get_subflows_max(msk);
> > 
> > If this line is added here, no need to change it again in
> > fill_local_addresses_vec() in "mptcp: pm: in-kernel: usable client
> > side
> > with C-flag", right? I mean we can drop "msk->pm.subflows <
> > subflows_max" in this while statement:
> > 
> >   while (msk->pm.local_addr_used < local_addr_max &&
> >          msk->pm.subflows < subflows_max) {
> > 
> > No need to send a v3, please update it when merging it if you
> > agree.
> 
> No, we still need it here, because we might create more than one
> subflow.
> 
> We could move it to the end of the loop, but I would rather prefer
> not
> to do that in the patch for 'net'. Probably better to keep this patch
> simple, and similar to what is done in fill_local_addresses_vec() for
> the fullmesh case.
> 
> In the refactoring, we can apply the same modifications for both the
> fullmesh case and the one here: using a break at the end of the loop.
> WDYT?

Sure, let's keep it as is. I just replied my tag in the cover letter.

Thanks,
-Geliang

> 
> Cheers,
> Matt
