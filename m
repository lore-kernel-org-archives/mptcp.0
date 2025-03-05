Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A033E18C337
	for <mptcp@lists.linux.dev>; Wed,  5 Mar 2025 09:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741166973; cv=none; b=jPv2M/EEFZWrf+hDZzwi0vJTKUff/k6KvfsfiM6xQf05ONov9UjJe3aS9HaeLB6HjfGgPZreGluoTK7bIHGVA1Fhc38LgZOvxpIwnwGCzhhBVcowG59R5kMQysYYgeI3WazrAG0gD3mwWIll2PGUP/W5vquyVcIMVLuh7oaObp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741166973; c=relaxed/simple;
	bh=zTJYIbNoJb3w4oqHPkRsJvCyaj66Z1/j7f+MNxFcVUg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h8+yHsN9Hxha7khWDb6NXDajn/ulBJH5Gs/+sb/pKtos6SgKJnen0Jn/90n2umf4ydbRPF89Nopp0Vvq8XUm3PqmuaMNgOvdO07JGuCWzuCgjlRCwutxS0kBbVtDjCpZ85TlGC6mn7hE0fuOID12LL47Z130p/jrFOSq3YaFWoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KjO2jrQY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KjO2jrQY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05AD8C4CEE8;
	Wed,  5 Mar 2025 09:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741166973;
	bh=zTJYIbNoJb3w4oqHPkRsJvCyaj66Z1/j7f+MNxFcVUg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=KjO2jrQYorLFbucVoyz0Y7zxfwQ081GhlEpHABihu4CybEb3o8vRfLuXfP/C7ItIN
	 S0agMphry/R1QMUHgBivAEk7xuQn2J+AXMMy+TSd7FLp8VOWxHCLMjXr19YhgohfPT
	 PxyCINBD44j8743aj+a9x6nvIqqe4gb+HYGaXfpzOgAeZ7FytwfJiidV5kZplfCEmo
	 u8q4QKiC76Ilyply/hZWIqF66MJzKzk270EpOlocD8ijLmnmbpfoEAqGS9ccEAd2Z2
	 lo49fWgo2SZjDYQURILb+/dsg7EgjXtqIeuH4FG95fg/Zhv4puvgR8YT5iwcMidmvD
	 tqdWhpR0yPO3A==
Message-ID: <6e6092ca4c26e7b04ffe6addba8c5a3f1d70f43e.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v8 06/12] mptcp: pm: in-kernel: register
 mptcp_pm_kernel
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Wed, 05 Mar 2025 17:29:28 +0800
In-Reply-To: <8cc21a9a-b5fc-4fa0-a97d-d5e0ca65b732@kernel.org>
References: <cover.1741088339.git.tanggeliang@kylinos.cn>
	 <818c00e2242d2f76604c6d70176ab6fa94d7eaa5.1741088339.git.tanggeliang@kylinos.cn>
	 <e4ed726a27e8b7564ca33833dcbe735fc158f157.camel@kernel.org>
	 <08136d71-ae40-4044-a9de-6b00e78af258@kernel.org>
	 <3952f0ebd55c5aed3618ad5933100e18458599d5.camel@kernel.org>
	 <8cc21a9a-b5fc-4fa0-a97d-d5e0ca65b732@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2025-03-05 at 10:22 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 05/03/2025 10:14, Geliang Tang wrote:
> > On Wed, 2025-03-05 at 10:11 +0100, Matthieu Baerts wrote:
> > > Hi Geliang,
> > > 
> > > On 05/03/2025 02:35, Geliang Tang wrote:
> > > > Hi Matt,
> > > > 
> > > > On Tue, 2025-03-04 at 19:40 +0800, Geliang Tang wrote:
> > > > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > > > > 
> > > > > This patch defines the original in-kernel netlink path
> > > > > manager as
> > > > > a
> > > > > new struct mptcp_pm_ops named "mptcp_pm_kernel", and register
> > > > > it
> > > > > in
> > > > > mptcp_pm_kernel_register().
> > > > > 
> > > > > This mptcp_pm_ops will be skipped in mptcp_pm_unregister().
> > > > > 
> > > > > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > > > > ---
> > > > >  net/mptcp/pm.c        |  4 ++++
> > > > >  net/mptcp/pm_kernel.c | 26 ++++++++++++++++++++++++++
> > > > >  net/mptcp/protocol.h  |  3 +++
> > > > >  3 files changed, 33 insertions(+)
> > > > > 
> > > > > diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> > > > > index a2b210873b23..28ea8bdaa8b0 100644
> > > > > --- a/net/mptcp/pm.c
> > > > > +++ b/net/mptcp/pm.c
> > > > > @@ -1076,6 +1076,10 @@ int mptcp_pm_register(struct
> > > > > mptcp_pm_ops
> > > > > *pm)
> > > > >  
> > > > >  void mptcp_pm_unregister(struct mptcp_pm_ops *pm)
> > > > >  {
> > > > > +	/* skip unregistering the default path manager */
> > > > > +	if (pm == &mptcp_pm_kernel)
> > > > > +		return;
> > > > > +
> > > > >  	spin_lock(&mptcp_pm_list_lock);
> > > > >  	list_del_rcu(&pm->list);
> > > > >  	spin_unlock(&mptcp_pm_list_lock);
> > > > > diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> > > > > index 806a9b5b3c07..e6a1aef738a8 100644
> > > > > --- a/net/mptcp/pm_kernel.c
> > > > > +++ b/net/mptcp/pm_kernel.c
> > > > > @@ -1398,8 +1398,34 @@ static struct pernet_operations
> > > > > mptcp_pm_pernet_ops = {
> > > > >  	.size = sizeof(struct pm_nl_pernet),
> > > > >  };
> > > > >  
> > > > > +static void mptcp_pm_nl_initialize(struct mptcp_sock *msk)
> > > > > +{
> > > > > +	bool subflows_allowed =
> > > > > !!mptcp_pm_get_subflows_max(msk);
> > > > > +	struct mptcp_pm_data *pm = &msk->pm;
> > > > > +
> > > > > +	/* pm->work_pending must be only be set to 'true'
> > > > > when
> > > > > +	 * pm is the default path manager
> > > > > +	 */
> > > > > +	WRITE_ONCE(pm->work_pending,
> > > > > +		   (!!mptcp_pm_get_local_addr_max(msk) &&
> > > > > +		    subflows_allowed) ||
> > > > > +		   !!mptcp_pm_get_add_addr_signal_max(msk));
> > > > > +	WRITE_ONCE(pm->accept_addr,
> > > > > +		   !!mptcp_pm_get_add_addr_accept_max(msk)
> > > > > &&
> > > > > +		   subflows_allowed);
> > > > > +	WRITE_ONCE(pm->accept_subflow, subflows_allowed);
> > > > > +}
> > > > > +
> > > > > +struct mptcp_pm_ops mptcp_pm_kernel = {
> > > > > +	.init			= mptcp_pm_nl_initialize,
> > > > 
> > > > A better name would be mptcp_pm_nl_init, but this is already
> > > > used
> > > > in
> > > > pm_netlink.c. I would like to rename mptcp_pm_nl_init in
> > > > pm_netlink.c
> > > > to mptcp_pm_genl_init, do you think this is a good idea?
> > > > 
> > > > If so, is it better to squash this renaming into "mptcp: pm:
> > > > split
> > > > netlink and in-kernel init" or make it a separate patch?
> > > 
> > > What about calling the one here mptcp_pm_kernel_init()?
> > 
> > mptcp_pm_kernel_init is not good, because other functions start
> > with
> > mptcp_pm_nl_:
> > 
> > struct mptcp_pm_ops mptcp_pm_kernel = {
> >         .get_local_id           = mptcp_pm_nl_get_local_id,
> >         .get_priority           = mptcp_pm_nl_is_backup,
> >         .established            = mptcp_pm_nl_fully_established,
> >         .subflow_established    = mptcp_pm_nl_subflow_established,
> >         .add_addr_echo          = mptcp_pm_nl_add_addr_echo,
> >         .add_addr_received      = mptcp_pm_nl_add_addr_received,
> >         .rm_addr_received       = mptcp_pm_nl_rm_addr_received,
> >         .rm_subflow_received    = mptcp_pm_nl_rm_subflow_received,
> >         .add_addr               = mptcp_pm_nl_add_addr,
> >         .del_addr               = mptcp_pm_nl_del_addr,
> >         .flush_addrs            = mptcp_pm_nl_flush_addrs,
> >         .set_priority           = mptcp_pm_nl_set_priority,
> >         .init                   = mptcp_pm_nl_init,
> >         .name                   = "kernel",
> >         .owner                  = THIS_MODULE,
> > };
> 
> What about switching to the "mptcp_pm_kernel_" prefix when switching
> to
> the new ops? For some of them, I guess there will be modifications
> around the declaration of the function because 'static' will be
> added, no?
> 
> The "mptcp_pm_nl_" was making sense before because everything was in
> pm_netlink.c. But now with the split, it might be good to take this
> opportunity to rename the functions here to clearly mention it is
> from
> the kernel PM, no?

Sure, I can do that in v9.

Thanks for your suggestion.

-Geliang

> 
> Cheers,
> Matt

