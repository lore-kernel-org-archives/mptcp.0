Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8569204698
	for <mptcp@lists.linux.dev>; Thu,  6 Mar 2025 11:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741259353; cv=none; b=BtPHUYujqsCixDWiViSR4I9gpYdJhxFK8pUw5yZlCMOVlmGkDduYj8LGF21cKrXyT4jqKm6XujnADu93tNpEo5jBcmnHewscMmn0Ffxei3QxG0sLlC+B91xYPU1tMVg4ZwUrjhJk5CCvWGEWyfUfWG/l4FtRFC5yF2obJArm/+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741259353; c=relaxed/simple;
	bh=HJu1dXf9RCkh0t1Eh1uceQ01whlw1MQvkxWZ66YNGXQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aVHJJq9s4kyir7HS6Vz4p535cU3ITHNYpn42JUE31S3CqG9X9Y7mhIyGFk1BsSZKsYqHkkrs1FRVz7spZ3/ix4lK6yVpnXbeypPPL67UL7/Tty0rJFfZyPVVrDk18iUpAgCokRxjaBIA/pQkrVtVAxXmLUKiCvbqQk41XEziGGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tSsWIG2c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tSsWIG2c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E60C4CEE0;
	Thu,  6 Mar 2025 11:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741259353;
	bh=HJu1dXf9RCkh0t1Eh1uceQ01whlw1MQvkxWZ66YNGXQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=tSsWIG2cHbng1Gt5/A2Evkk8PVlLI32J3VJ+DIl/tMDVusrgitbGyc60M18f+HGJ1
	 h3JuQUs302wmdN6GkfamCKV1/x/0Ik6S0p/7IETEoWmLcg1K32frB3fqj9nFtzGbEJ
	 afCbBUB6HGpjURh/RW0LQKoWbJ5u49mVwG42m/AViZGBKmPk6B79fQ2hQvWM3Cmhno
	 nqKFH78LbcD75F9IB8/wgohCna7AhuP0bC3oTm7F3WdI+KTyOugg0cUOVCi4prL7gF
	 JaphqMPaRkZf4OBpbMVn33yXH1UFIjw+vrEOOvOhwtcMQMBLjRMVABNyfwYCHtYhRg
	 ktT2pCg+7czvQ==
Message-ID: <ffbd74d2b796ea8f17d7f432cb6dc092ab7e9b27.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v8 06/12] mptcp: pm: in-kernel: register
 mptcp_pm_kernel
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Thu, 06 Mar 2025 19:09:08 +0800
In-Reply-To: <02398941-0bb7-4156-a286-536db728c411@kernel.org>
References: <cover.1741088339.git.tanggeliang@kylinos.cn>
	 <818c00e2242d2f76604c6d70176ab6fa94d7eaa5.1741088339.git.tanggeliang@kylinos.cn>
	 <02398941-0bb7-4156-a286-536db728c411@kernel.org>
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

Thanks for the review.

On Wed, 2025-03-05 at 12:51 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 04/03/2025 12:40, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > This patch defines the original in-kernel netlink path manager as a
> > new struct mptcp_pm_ops named "mptcp_pm_kernel", and register it in
> > mptcp_pm_kernel_register().
> > 
> > This mptcp_pm_ops will be skipped in mptcp_pm_unregister().
> > 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  net/mptcp/pm.c        |  4 ++++
> >  net/mptcp/pm_kernel.c | 26 ++++++++++++++++++++++++++
> >  net/mptcp/protocol.h  |  3 +++
> >  3 files changed, 33 insertions(+)
> > 
> > diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> > index a2b210873b23..28ea8bdaa8b0 100644
> > --- a/net/mptcp/pm.c
> > +++ b/net/mptcp/pm.c
> > @@ -1076,6 +1076,10 @@ int mptcp_pm_register(struct mptcp_pm_ops
> > *pm)
> >  
> >  void mptcp_pm_unregister(struct mptcp_pm_ops *pm)
> >  {
> > +	/* skip unregistering the default path manager */
> 
> Please see my questions from v7: why this skip?

mptcp_pm_kernel is the default pm, skip it to ensure that there's
always a valid path manager available.

> 
> When looking at this, I can understand that we don't want to
> unregister
> built-in modules and the default one, but:
> 
> - When are we going to that? mptcp_pm_unregister() is still unused in
> this series.

mptcp_pm_unregister is not used in this set, but will be invoked
in .unreg of struct bpf_struct_ops.

> 
> - Why would we want to unregister the userspace PM as well?

The default one is mptcp_pm_kernel, not mptcp_pm_userspace, we set it
in mptcp_pm_ops_init when the input pm_ops is invalid.

> 
> It makes sense to have an exception for the default one, but it feels
> like we should simply not try to unregister the in-kernel ones. In
> other
> words, there is probably no need to have such exceptions because
> mptcp_pm_unregister() should never be called with the built-in PMs.
> In
> this case, maybe we could add a WARN_ON_ONCE()?
> 
>   if (WARN_ON_ONCE(pm == &mptcp_pm_kernel))
>        return;

Added this in v10.

> 
> (or something else if we need to catch the userspace PM as well, e.g.
> pm->built_in, but that should not be needed)
> 
> 
> > +	if (pm == &mptcp_pm_kernel)
> > +		return;
> > +
> >  	spin_lock(&mptcp_pm_list_lock);
> >  	list_del_rcu(&pm->list);
> >  	spin_unlock(&mptcp_pm_list_lock);
> > diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> > index 806a9b5b3c07..e6a1aef738a8 100644
> > --- a/net/mptcp/pm_kernel.c
> > +++ b/net/mptcp/pm_kernel.c
> > @@ -1398,8 +1398,34 @@ static struct pernet_operations
> > mptcp_pm_pernet_ops = {
> >  	.size = sizeof(struct pm_nl_pernet),
> >  };
> >  
> > +static void mptcp_pm_nl_initialize(struct mptcp_sock *msk)
> > +{
> > +	bool subflows_allowed = !!mptcp_pm_get_subflows_max(msk);
> > +	struct mptcp_pm_data *pm = &msk->pm;
> > +
> > +	/* pm->work_pending must be only be set to 'true' when
> > +	 * pm is the default path manager
> > +	 */
> > +	WRITE_ONCE(pm->work_pending,
> > +		   (!!mptcp_pm_get_local_addr_max(msk) &&
> > +		    subflows_allowed) ||
> > +		   !!mptcp_pm_get_add_addr_signal_max(msk));
> > +	WRITE_ONCE(pm->accept_addr,
> > +		   !!mptcp_pm_get_add_addr_accept_max(msk) &&
> > +		   subflows_allowed);
> > +	WRITE_ONCE(pm->accept_subflow, subflows_allowed);
> 
> It might feel clearer to add this helper in patch 8 ("mptcp: pm:
> initialize and release mptcp_pm_ops"), to understand you are moving
> existing code here.
> 
> If you do that, then maybe better to squash the existing patches 6
> ("mptcp: pm: in-kernel: register mptcp_pm_kernel") and 7 ("mptcp: pm:
> userspace: register mptcp_pm_userspace"), no?
> 
>   mptcp: pm: register in-kernel and userspace PM

Done.

> 
> 
> > +}
> > +
> > +struct mptcp_pm_ops mptcp_pm_kernel = {
> > +	.init			= mptcp_pm_nl_initialize,
> > +	.name			= "kernel",
> > +	.owner			= THIS_MODULE,
> > +};
> > +
> >  void __init mptcp_pm_kernel_register(void)
> >  {
> >  	if (register_pernet_subsys(&mptcp_pm_pernet_ops) < 0)
> >  		panic("Failed to register MPTCP PM pernet
> > subsystem.\n");
> > +
> > +	mptcp_pm_register(&mptcp_pm_kernel);
> >  }
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index 246b44db9775..f700cb55bf49 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -1050,6 +1050,9 @@ int mptcp_pm_remove_addr(struct mptcp_sock
> > *msk, const struct mptcp_rm_list *rm_
> >  void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
> >  				struct mptcp_pm_addr_entry
> > *entry);
> >  
> > +/* the default path manager, used in mptcp_pm_unregister */
> (to be adapted if it is no longer used there. Or:
> mptcp_pm_initialize)
> 
> Or maybe better: it could be exported in patch 8 ("mptcp: pm:
> initialize
> and release mptcp_pm_ops").

Done.

Thanks,
-Geliang

> 
> > +extern struct mptcp_pm_ops mptcp_pm_kernel;
> > +
> >  struct mptcp_pm_ops *mptcp_pm_find(const char *name);
> >  int mptcp_pm_validate(struct mptcp_pm_ops *pm);
> >  int mptcp_pm_register(struct mptcp_pm_ops *pm);
> 
> Cheers,
> Matt

