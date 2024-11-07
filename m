Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0866414293
	for <mptcp@lists.linux.dev>; Thu,  7 Nov 2024 07:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730964960; cv=none; b=N9CtRS8OUJuNXcmVFY9g4PDEfjWSFDw6YPwgBa7HbvZppAiwMtzAqEkXc1XP+X3yFgZrWURSuy0AKA0RT4bN16O/FQew+P6ceMoW5805ZCtEgOM8yyuHIu6cZsBBn4DFtJpSzrSKpadwdmg1LUu+Ve9ga+n0zmfD37d0ewi0tvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730964960; c=relaxed/simple;
	bh=3vWXhNwtbgum8egc6HzSFbbkU4DkU/lPU4UBCtw3kRM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MTh4I7Zbd70/ITwgxEJh9v+feGqErdJL7PrwHnOGuZNb5OfHjuXv/JrKtUd969nojpZqPL62eu2muavFAZLj1DTgqKdVhxjJL4hHk2NaL5kAUz+xbXlkC+HHC/vmFwPIt0qUQnldtpy8gNJxAKXkgQRwI/CVv+ThNR2yrQV2nc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIu7tt29; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIu7tt29"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F10BC4CECC;
	Thu,  7 Nov 2024 07:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730964959;
	bh=3vWXhNwtbgum8egc6HzSFbbkU4DkU/lPU4UBCtw3kRM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=UIu7tt29QucxkDEGRt34YtGUZdsT35G4mccDhLAzO4SMGGWtGSMAToR5rd9e16cX9
	 zOprM7GbwZv3NfxkzpsDUj/L1IK5uAnxxVAw+SuSfeD2uGnUXAXkAe5/zN7921waKr
	 t2Haepl7A0BB/Wett+p6LogzriQYIiVDbYNbl4TEOGPKWKQOShJ+GsEsEm5ghPqkpM
	 TWClijqKjxfLV0ZNe6jQpYBVia1m+MIZh1NJKxPvEjraUxxOQFR9/Yde0s5GFYn/QM
	 1lMov9FAuCeL8Asy/+xdSZzp2RArLhFSXp4xYGkcCFxBaYTyK6l3Qr/32/jgAWRRGb
	 wuHHw7eur/kvw==
Message-ID: <9142b79f7de9cbffe5ee861864d176c24584f59f.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 21/36] mptcp: update address type of
 get_local_id
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Thu, 07 Nov 2024 15:35:55 +0800
In-Reply-To: <8c422b14-719a-447d-a24e-61ef40dbd72e@kernel.org>
References: <cover.1729588019.git.tanggeliang@kylinos.cn>
	 <697ad8ffc8987b12a232b3855e6960b49c186d4b.1729588019.git.tanggeliang@kylinos.cn>
	 <8c422b14-719a-447d-a24e-61ef40dbd72e@kernel.org>
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

On Mon, 2024-11-04 at 19:48 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 22/10/2024 11:14, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > The following code in mptcp_userspace_pm_get_local_id() that
> > assigns "skc"
> > to "new_entry" is not allowed in BPF if we use the same code to
> > implement
> > the get_local_id() interface of a BFP path manager:
> 
> Can you give more details about the fact it is not allowed please?
> 
> Do you mean you cannot do the following code in BPF? Why?

Same as in patch 23, passing "new_entry" to
mptcp_userspace_pm_append_new_local_addr() will get an error:

"pointer type STRUCT mptcp_pm_addr_entry must point to scalar, or
struct with scalar".

And assigning an address to an address like this is not allowed in
BPF:

	new_entry.addr = *skc;

> 
> > 	memset(&new_entry, 0, sizeof(struct mptcp_pm_addr_entry));
> > 	new_entry.addr = *skc;
> > 	new_entry.addr.id = 0;
> > 	new_entry.flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
> > 
> > To solve the issue, this patch moves this assignment to "new_entry"
> > forward
> > to mptcp_pm_get_local_id(), and then passing "new_entry" as a
> > parameter to
> > both mptcp_pm_nl_get_local_id() and
> > mptcp_userspace_pm_get_local_id().
> > 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  net/mptcp/pm.c           | 10 ++++++++--
> >  net/mptcp/pm_netlink.c   | 11 +++--------
> >  net/mptcp/pm_userspace.c | 17 ++++++-----------
> >  net/mptcp/protocol.h     |  4 ++--
> >  4 files changed, 19 insertions(+), 23 deletions(-)
> > 
> > diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> > index b6e6859903ef..d28e844eba2d 100644
> > --- a/net/mptcp/pm.c
> > +++ b/net/mptcp/pm.c
> > @@ -404,6 +404,7 @@ int mptcp_pm_get_local_id(struct mptcp_sock
> > *msk, struct sock_common *skc)
> >  {
> >  	struct mptcp_addr_info skc_local;
> >  	struct mptcp_addr_info msk_local;
> > +	struct mptcp_pm_addr_entry local;
> >  
> >  	if (WARN_ON_ONCE(!msk))
> >  		return -1;
> > @@ -416,9 +417,14 @@ int mptcp_pm_get_local_id(struct mptcp_sock
> > *msk, struct sock_common *skc)
> >  	if (mptcp_addresses_equal(&msk_local, &skc_local, false))
> >  		return 0;
> >  
> > +	memset(&local, 0, sizeof(struct mptcp_pm_addr_entry));
> 
> Out of curiosity: do you need to call memset() here? Can you not init
> "local" when you declare it?
> 
>   struct mptcp_pm_addr_entry local = { 0 };

Updated in v3.

> 
> (Or maybe that's not working with C99 with inner structures? I
> thought
> it was, but not sure).
> 
> > +	local.addr = skc_local;
> 
> Do you still need skc_local? Can you not use 'local.addr' directly
> instead above?
> 
> > +	local.addr.id = 0;
> 
> In pm_netlink.c, 'addr.port' is also reset. Should you not do that
> here
> too? I guess that's fine for the userspace pm, no?

Updated in v3.

Thanks,
-Geliang

> 
> > +	local.flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
> > +
> >  	if (mptcp_pm_is_userspace(msk))
> > -		return mptcp_userspace_pm_get_local_id(msk,
> > &skc_local);
> > -	return mptcp_pm_nl_get_local_id(msk, &skc_local);
> > +		return mptcp_userspace_pm_get_local_id(msk,
> > &local);
> > +	return mptcp_pm_nl_get_local_id(msk, &local);
> >  }
> >  
> >  bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common
> > *skc)
> (...)
> 
> Cheers,
> Matt

