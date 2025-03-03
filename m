Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AE71F37C3
	for <mptcp@lists.linux.dev>; Mon,  3 Mar 2025 10:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999343; cv=none; b=msBaJ8GJ5L5fk7YDcBI5CNiR6KuDq1ft0O5Ecl2sna4C5EUyACUCzrgspGxShsC0YkEyRKUSO4AAFOpqu6/0LXKxSRVkIlka8cSVfkVn73lEthA7JQswbn7/ERGN72MeAhaDlxe/L+dvJD9+dtOfcOd+wzd22K9lUOPn8mjQMK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999343; c=relaxed/simple;
	bh=BWE8wloDBfmEYEDSA3B6qzmhPJjwopH0D+qrYKcqvO0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HUdmq6IbggSRxhx51F0hjNH8pnRogJjNIFkMv+w84qRcKlsY8epj2hQSDg0imfsCR8uddMwadeNe7iFi0JFGbPF3npyA2kV3cEmy25pOweE0oOiHUBOy6KyTCz5WIM+MWH/acaKsk6mNl63EvF9XmPh9qXV/j9lAbyo5xWbiaIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ry+AaMGP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ry+AaMGP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82610C4CED6;
	Mon,  3 Mar 2025 10:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740999343;
	bh=BWE8wloDBfmEYEDSA3B6qzmhPJjwopH0D+qrYKcqvO0=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=Ry+AaMGP/yctJBgye71i3dP/+vgw3grPyAPqGDtYac+qMSVnWBuWGLEcoVmTnTVOt
	 oOn5MyGnbAehD9J/YlmUpRBUZ9vUITJvXFhngXB0fBY+cqgWfpR/swCWlJfdKBbaCL
	 NI64sG5swZ8DYX5G/9j0wcn3Nq9cRqgCWx/ymqL84oRV9hjMnQaz3Ga36TS56xkQNd
	 Q16V1bVE11wSFzyW0y/AJjw7hJk18skmPi6NMHuKbQhDbcz1kkocu0VNRmxjCc7Jln
	 mm/nKTvWRnNdLCN+4aEMrmcr+aNbAKL3rdIVTtao4mw5KOOwrgjET15YShtnRBzEEY
	 5IWJPsp2kGTbQ==
Message-ID: <d92038d729b02be236e736bc598dc17bd6f71b23.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 00/14] mptcp: pm: code reorganisation
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Mon, 03 Mar 2025 18:55:39 +0800
In-Reply-To: <8e6a57b2-8d45-4c7d-a0d1-ca120eb0114a@kernel.org>
References: <20250228-mptcp-pm-reorg-code-v2-0-fa8b2542b7a5@kernel.org>
	 <6dd5447d53d519a848f8b21104d90478802a0372.camel@kernel.org>
	 <8e6a57b2-8d45-4c7d-a0d1-ca120eb0114a@kernel.org>
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

On Sat, 2025-03-01 at 12:10 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 01/03/2025 01:21, Geliang Tang wrote:
> > Hi Matt,
> > 
> > On Fri, 2025-02-28 at 14:31 +0100, Matthieu Baerts (NGI0) wrote:
> > > I have been thinking about that during the past couple of months,
> > > but
> > > now, with the recent modifications done by Geliang, and the
> > > associated
> > > reviews, I really think it is time to reorganise the code around
> > > the
> > > path-managers to avoid confusions, and a mix of code used in
> > > different
> > > conditions.
> > > 
> > > I hope this will not cause too many issues with the in-progress
> > > patches.
> > > I tried only to move the code around, and minimise the functions
> > > renaming. Then, to switch to the new code, it might be easier to
> > > simply
> > > copy your modified code from the old place to the new one. In
> > > other
> > > words, duplicate the net/mptcp directory, then do a rebase,
> > > resolve
> > > the
> > > conflicts with 'git restore --ours', then reapply the
> > > modifications
> > > by
> > > copying your old code to the new place. If it is too difficult,
> > > please
> > > let me know.
> > > 
> > > Before this series, the PM code was dispersed in different
> > > places:
> > > 
> > > - pm.c had common code for all PMs
> > > 
> > > - pm_netlink.c was supposed to be about the in-kernel PM, but
> > > also
> > > had
> > >   exported common helpers, callbacks used by the different PMs,
> > > NL
> > >   events for PM userspace daemon, etc. quite confusing.
> > > 
> > > - pm_userspace.c had userspace PM only code, but using specific
> > >   in-kernel PM helpers
> > > 
> > > To clarify the code, a reorganisation is suggested here, only by
> > > moving
> > > code around, and small helper renaming to avoid confusions:
> > > 
> > > - pm_netlink.c now only contains common PM Netlink code:
> > >   - PM events: this code was already there
> > >   - shared helpers around Netlink code that were already there as
> > > well
> > >   - shared Netlink commands code from pm.c
> > > 
> > > - pm_kernel.c now contains only code that is specific to the in-
> > > kernel
> > >   PM. Now all functions are either called from:
> > >   - pm.c: events coming from the core, when this PM is being used
> > >   - pm_netlink.c: for shared Netlink commands
> > >   - mptcp_pm_gen.c: for Netlink commands specific to the in-
> > > kernel PM
> > >   - sockopt.c: for the exported counters per netns
> > > 
> > > - pm.c got many code from pm_netlink.c:
> > >   - helpers used from both PMs and not linked to Netlink
> > >   - callbacks used by different PMs, e.g. ADD_ADDR management
> > >   - some helpers have been renamed to remove the '_nl' prefix,
> > > and
> > > they
> > >     have been marked as 'static'.
> > > 
> > > - protocol.h has been updated accordingly:
> > >   - some helpers no longer need to be exported
> > >   - new ones needed to be exported: they have been prefixed if
> > > needed.
> > > 
> > > The code around the PM is now less confusing, which should help
> > > for
> > > the
> > > maintenance in the long term.
> > > 
> > > This will certainly impact future backports, but because other
> > > cleanups
> > > have already done recently, and more are coming to ease the
> > > addition
> > > of
> > > a new path-manager controlled with BPF (struct_ops), doing that
> > > now
> > > seems to be a good time. Also, many issues around the PM have
> > > been
> > > fixed
> > > a few months ago while increasing the code coverage in the
> > > selftests,
> > > so
> > > such big reorganisation can be done with more confidence now.
> > > 
> > > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > > ---
> > > Changes in v2:
> > > - Addressing Geliang's comments
> > > - The renaming of common helpers have been done in dedicated
> > > patches
> > > - Some helpers have been kept where they were in pm.c, except one
> > > now
> > > in
> > >   a dedicated patch.
> > > - The last patch has been split in smaller chunks, only moving
> > > code
> > > from
> > >   one file to another to help with the reviews.
> > 
> > Thanks for this v2, I have some comments for it:
> 
> Thank you for having looked at the v2.
> 
> > Patches 1, 2, 5 can be merged into one.
> > Patch 3 can be merged into patch 9.
> 
> We could, but how can this help? If these patches are OK for the
> moment
> and reviewable, maybe no need to spend more time on that and merging
> stuff that might make it harder to follow, and might cause new
> conflicts?
> 
> > Patch 4, change mptcp_pm_rm_addr_recv() as non-static here, instead
> > of
> > changing it in patch 9. How about renaming it as
> > __mptcp_pm_nl_rm_addr_received?
> 
> Would it not be confusing with the previous functions? Especially in
> case of backports.
> 
> > Patch 7, how about renaming mptcp_pm_nl_set_flags_all as
> > __mptcp_pm_nl_set_flags too?
> 
> No, the '__' prefix is usually used to mark that this function is
> going
> to be used in a "critical" section, e.g. when a lock is held.
> 
> > Patch 11, how about dropping this patch, keep
> > mptcp_pm_addr_families_match() unmoved, but add a new section like
> > "/*
> > generic PM helpers */" to import the helpers there?
> 
> I did that at the beginning, but:
> - that's strange not to put the generic helpers at the beginning
> - also strange to have to go down to see how a helper is implemented
> 
> > Patch 12
> >  - in mptcp_remove_anno_list_by_saddr() behavioural is changed, a
> > separate patch is needed.
> 
> It is not, it is just a fix for a checkpatch warning mentioned in the
> commit message. The netdev FAQ seems to suggest avoiding such fixes,
> except if it is part of other changes. I don't think it is worth
> splitting, the behaviour is not really modified.
> 
> >  - mptcp_lookup_subflow_by_saddr should be after
> > mptcp_remote_address
> 
> Why? I moved mptcp_pm_is_init_remote_addr() there because it was in
> the
> middle of pm_netlink.c and it is very closed to remote_address.
> 
> >  - mptcp_pm_sport_in_anno_list should be after
> > mptcp_lookup_anno_list_by_saddr and befor mptcp_pm_add_timer.
> 
> Why?
> 
> >  - split "move all struct mptcp_pm_add_entry related code into
> > pm.c"
> > from patch 12 as a separate one.
> 
> Why?
> 
> >  - split "move all send_ack related code into pm.c" from patch 12
> > as a
> > separate one.
> 
> Why?
> 
> >  - make mptcp_pm_is_init_remote_addr() static shoud be merged into
> > patch 6.
> 
> We cannot do that: it is called from pm.c, and we need
> remote_address(),
> at that time only declared in pm_netlink.c.
> 
> > Split "move all pm_nl_pernet related code into pm_kernel.c" from
> > patch
> > 13 as a separate one.
> 
> Why?
> 
> > Can the action of deleting three headers in patch 14 be advanced to
> > the
> > previous patch?
> 
> For the two first ones, maybe but is it important? For
> mptcp_pm_gen.h, no.
> 
> Thank you for the suggestions, but I don't think it is worth spending
> more time on that, except if you think it would help for the
> maintenance
> and the backports. Merging patches probably will not help, and
> splitting
> code being moved around is still too big for the backports. But maybe
> I
> missed something.
> 
> I think it would be better to apply these patches ASAP, not to block
> further developments, or having to rebase this kind of series. WDYT?

Patches that move code to another location are not very friendly to
backporting, especially large patches like this set, which almost
always conflict. When conflicts occur, we need to deal with them
manually.

All my suggestions are to reduce the workload of manually dealing with
conflicts when they occur.

If the code is moved in one piece, we can handle it easily. If the
function location changes during the code move, we need to move each
function one by one, which increases the workload. If the function name
changes, we need to compile and verify it at the same time, which
further increases the workload. If the code logic also changes, the
situation will be worse.

It is possible that this patch does not need to be backported, but the
subsequent PM code is modified based on the new code location, and the
subsequent new features are developed based on it, so there is still a
possibility that this patch needs to be backported.

Since all my comments do not involve any code modifications, and the
code itself in this set looks good to me, I am also willing to add my
reviewed-by tag:

Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> 
> Cheers,
> Matt

