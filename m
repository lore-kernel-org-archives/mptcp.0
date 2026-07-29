Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB47919CCF7
	for <mptcp@lists.linux.dev>; Wed, 29 Jul 2026 00:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785286763; cv=none; b=RXUUHnYITOV1Uqzbhs7RwTUfsBh58Q0kAcep7Kp+ihqdjoioPnx8yH0RyU8upk50TztgTV0C8HfGdybvawUA23ovpw2RxnRzAOo0NDkX6Emmb22yBbngaA1KdvghSD/NUQx0JSlMUF5YvHtgyq0k865dmEBGAAF4S1FfK/iPW7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785286763; c=relaxed/simple;
	bh=duxA9bFVaZLtGbkAvDgv+xiYLKuHD+hW1QwTwjn0/Mk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pg14euGKUp77JL+/AC5dsr+bRlLawcoS8AwjXs+b3EiGIp0+h1Phwl/8mPchNQqe9SzfYegdSFBt/XgtCvRIwgOHNLxHDJGpk1086yiL5wzqJ1ia5Lx8je5cpEIDuJsws4sVvC4KTuRWjSsZXb6MM6rLLeDbgwP5zWNslEVBwFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvAJIAjD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvAJIAjD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67E71F000E9;
	Wed, 29 Jul 2026 00:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785286761;
	bh=PcFsTk1oYSNI216D1366RVUBHC3n3O0Xj2rzbbQaf/0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JvAJIAjD3qZb9WL00L7uYHKdVgiZyfajlDQ9vzFYdkRWMfhBPLuBfQlu8PXLp3iAu
	 sSQDSJveKkoxzTL9HUXjU3e3SYNgHeexFBzkCBr81vYNXo3EffbDoe1iNV7/eO0uxy
	 hn6lFc1QOz6i7Hqq7AltNw6LJrltecLkXhoDdgWuMJkKvkqSP38ruUsvBRD2WzRPbF
	 7+fevNUVtyASQs3uf7ferlLu+f86afj9u+n5FOBRNwV4Ma+SBBjCSlVJF314uloZjM
	 DhKjKruWZuLFD4frIR+J65lsMqbaEX6GrKtnmuKXGwYWlIpwrurQlhoyn3WhInJzIh
	 aCkhCE3EoCUZA==
Message-ID: <0e52429885c42258fea0d81934f489c6d3f37acd.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v6 1/3] mptcp: pm: userspace: drop
 delete_local_addr helper
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Wed, 29 Jul 2026 08:59:16 +0800
In-Reply-To: <154f5323-fbe1-4283-8b7a-04ab778013de@kernel.org>
References: <cover.1782513313.git.tanggeliang@kylinos.cn>
	 <0d2025431ba1b2a34da3a1747880d7b23779cf76.1782513313.git.tanggeliang@kylinos.cn>
	 <4da53292-aa11-45be-ac7f-11afcfb278a1@kernel.org>
	 <154f5323-fbe1-4283-8b7a-04ab778013de@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Mon, 2026-07-27 at 19:24 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 24/07/2026 20:48, Matthieu Baerts wrote:
> > Hi Geliang,
> > 
> > On 27/06/2026 00:45, Geliang Tang wrote:
> > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > > 
> > > Address entries should not be removed from local_addr_list when a
> > > subflow
> > > is deleted by the userspace PM, should only be removed when
> > > sending a
> > > REMOVE_ADDR.
> > > 
> > > So mptcp_userspace_pm_delete_local_addr() helper shouldn't be
> > > called in
> > > mptcp_pm_nl_subflow_create_doit() and
> > > mptcp_pm_nl_subflow_destroy_doit().
> > > 
> > > Since this helper is open-coding in mptcp_pm_nl_remove_doit(), it
> > > can be
> > > dropped now.
> > > 
> > > Address entries are removed from local_addr_list when sending a
> > > REMOVE_ADDR
> > > by the userspace PM, the local_addr_used counter of PM should
> > > also be
> > > decremented accordingly.
> > 
> > I was re-reviewing this series after having read the comments from
> > Sashiko:
> > 
> > https://sashiko.dev/#/patchset/cover.1782513313.git.tanggeliang@kylinos.cn
> > 
> > I think the series is correct, but it feels like additional fixes
> > are
> > required:
> > 
> > - msk->pm.userspace_pm_local_addr_list doesn't contain an entry for
> > the
> > ID0 when initialised
> >   - That's probably fine, but then it means the ID0 case needs to
> > be
> > handled separately, like it is with the in-kernel PM.
> >   - Or maybe easier to add it when the userspace PM is used, to
> > avoid
> > all these exceptions?
> >     - If yes, then the remove_doit should no longer handle the ID0
> > differently as well.
> >     - same for announce_doit?
> >     - maybe better to do that to avoid all these exceptions?
> > 
> > - When creating a subflow with ID0, an entry can be added to the
> > list
> > (to be checked)
> >   - If the ID0 is not added at init time, then an exception should
> > be
> > added there
> >   - (also there is a check to avoid announcing ID0 → I think it is
> > valid
> > to re-announce the ID0 if this address is no longer used, an
> > exception
> > should be added there too, no?)
> > 
> > - each time the list is traversed, it doesn't take into account the
> > ID0
> > case:
> >   - If the ID0 is not added at init time, then an extra check
> > should be
> > added there
> > 
> > WDYT?
> > 
> > If yes, maybe this kind of patch can help? (not tested)
> > 
> >   https://github.com/matttbe/mptcp_net-next/commit/e03ee2728e98
> 
> I just sent this: WDYT?
> 
> https://lore.kernel.org/mptcp/20260727-mptcp-pm-userspace-id0-case-v1-0-9877f02a9bae@kernel.org/
> 
> Would it be compatible with your series?

Thank you for your patch. I will rebase my patch soon and review yours.

-Geliang

> 
> Cheers,
> Matt
