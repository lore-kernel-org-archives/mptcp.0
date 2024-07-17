Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE101524F
	for <mptcp@lists.linux.dev>; Wed, 17 Jul 2024 04:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721189143; cv=none; b=krvt5nVcs0RHyYpDt32Qm7YZiEdGbY+1J+Lx+bRQ/jJ3tUUqUKrG81AfK4/4eUPmWVyShQPeP8cAug17h/DsxIsAsBvqrEMRw6yP7r9aWBPrhO/Fw+/k8kOWiB4c6+XXKd8WtFw9szeJC0QtDWR4EXMV9SpWdymCjASLud0/ojc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721189143; c=relaxed/simple;
	bh=kmKmPpYBNJ8FqtkRJ+8DfJjvp/zgtBzCBTdMh++48SA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X+7BjXBdXJzrlbkTpB/y8NrVvKg7vi961/FnEzWjzsIDhRarIbgypHmV+RCeAGI7M3q3CYXtupu41tDjwgcZ96xyUfpaz0s2NJTz/oyWFblokIFz+pXojn6DnAInb1kyo63d3FsIwlPXT3juTRAUGzfmCdXlKwghWORBD+CQ/Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcGGIGfD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcGGIGfD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F184FC32782;
	Wed, 17 Jul 2024 04:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721189143;
	bh=kmKmPpYBNJ8FqtkRJ+8DfJjvp/zgtBzCBTdMh++48SA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=IcGGIGfD4D0SSgHBfSyYA/cPrTwMtUA3wwlLw/ICbsCI1kx4b9nTZjPW9qr+XnNg0
	 ENZkM9QEKIjdGEXpuIPIMaYpOPtri9VyGbvv0YwiX9L5wir7gagOhaxE7db+iUpOLB
	 Frk6/dZ1UJjeEzKaR7gyLOSktGABybaAmrfur9FqZcUkElybgMpW0wO7btwsiVsR1o
	 UPqOLhrLUBLWwnwms9W664lx1s8sTRA+YWQQnDORWr/zNMAo6rt7jv85ENC1SlcJdf
	 XH5PcnwxXHJhpXA95s2PjF8t12u9tvSYhJ1zOtCS1O/gWrx8GcF58I83tM1lPoWrHw
	 QylxH+D5FmiVA==
Message-ID: <13dbb609541f4f873d90cd5bd238f2f83c997962.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v2 14/17] mptcp: pm: remove
 mptcp_pm_remove_subflow()
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>
Date: Wed, 17 Jul 2024 12:05:37 +0800
In-Reply-To: <0e32e0e4-e7ef-490d-8107-5e1a03a6d1f6@kernel.org>
References: <20240715-mptcp-pm-avail-v2-0-fc5153bd1f6e@kernel.org>
	 <20240715-mptcp-pm-avail-v2-14-fc5153bd1f6e@kernel.org>
	 <04f90c53bf7842c80b501e5e60e2f04872ddc88e.camel@kernel.org>
	 <0e32e0e4-e7ef-490d-8107-5e1a03a6d1f6@kernel.org>
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

On Tue, 2024-07-16 at 10:35 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> Thank you for the review!
> 
> On 16/07/2024 05:40, Geliang Tang wrote:
> > On Mon, 2024-07-15 at 12:09 +0200, Matthieu Baerts (NGI0) wrote:
> > > This helper is confusing. It is in pm.c, but it is specific to
> > > the
> > > in-kernel PM and it cannot be used by the userspace one. Also, it
> > > simply
> > > calls one in-kernel specific function with the PM lock, while the
> > > similar mptcp_pm_remove_addr() helper requires the PM lock.
> > > 
> > > What's left is the pr_debug(), which is not that useful, because
> > > a
> > > similar one is present in the only function called by this
> > > helper:
> > > 
> > >   mptcp_pm_nl_rm_subflow_received()
> > > 
> > > After these modifications, this helper can now be marked as
> > > 'static'.
> > > 
> > > Note that it is not really a bug, but it will help backporting
> > > the
> > > following commits.
> 
> (...)
> 
> > > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > > index 44092246259c..96336a87973f 100644
> > > --- a/net/mptcp/pm_netlink.c
> > > +++ b/net/mptcp/pm_netlink.c
> > > @@ -1454,8 +1454,11 @@ static int
> > > mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
> > >  		remove_subflow = lookup_subflow_by_saddr(&msk-
> > > > conn_list, addr);
> > >  		mptcp_pm_remove_anno_addr(msk, addr,
> > > remove_subflow
> > > &&
> > >  					  !(entry->flags &
> > > MPTCP_PM_ADDR_FLAG_IMPLICIT));
> > > +
> > 
> > I think no need to add a new line here.
> 
> The block below started to be a bit big, and was doing a different
> action that the one above (removing ADD_ADDR). Maybe I should have
> added
> it in patch 10/17?

Yes, it's better in 10/17.

> 
> > >  		if (remove_subflow) {
> > > -			mptcp_pm_remove_subflow(msk, &list);
> > > +			spin_lock_bh(&msk->pm.lock);
> > > +			mptcp_pm_nl_rm_subflow_received(msk,
> > > &list);
> > > +			spin_unlock_bh(&msk->pm.lock);
> > 
> > The subsequent code holds msk->pm.lock too, both of them can be
> > placed
> > in the same block holding msk->pm.lock once.
> 
> Yes indeed, but there are cases where it is not needed to lock the
> PM:
> if we are removing a 'signal' endpoint. In this case, I thought it
> would
> be better to lock only if needed, and surround the helper requiring
> the
> lock. No?

Yes, I agree.

> 
> > >  		} else if (entry->flags &
> > > MPTCP_PM_ADDR_FLAG_SUBFLOW) {
> > >  			/* If the subflow has been used, but now
> > > closed */
> > >  			spin_lock_bh(&msk->pm.lock);
> > > @@ -1608,8 +1611,11 @@ static void
> > > mptcp_pm_flush_addrs_and_subflows(struct mptcp_sock *msk,
> > >  		spin_unlock_bh(&msk->pm.lock);
> > >  	}
> > >  
> > > -	if (slist.nr)
> > > -		mptcp_pm_remove_subflow(msk, &slist);
> > > +	if (slist.nr) {
> > > +		spin_lock_bh(&msk->pm.lock);
> > > +		mptcp_pm_nl_rm_subflow_received(msk, &slist);
> > > +		spin_unlock_bh(&msk->pm.lock);
> > > +	}
> > 
> > The same here. Holding msk->pm.lock once.
> 
> Yes, indeed, here we can probably lock once before "if (alist.nr)".
> If
> there is only this change needed, I can probably do the modification
> when applying the patches. (I already did the modifications locally).
> 
> Cheers,
> Matt

