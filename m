Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AAA1519A9
	for <mptcp@lists.linux.dev>; Fri, 14 Feb 2025 03:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739505199; cv=none; b=NpAhIG6/OcAn5a+/qyElHaZlnwceitw2Ud7Lg2Xm3+1mVHM5WdHGD6rKs/k1xEoykhV9PvDK4vba5TpV0qMK/20aT6J//y9xm0MrA1bm2PlxhQFgVGYzGwRuED+6Jurqczn/jbb8Ew+0xijbyZiyYBKcLd5ozp5Mla1RSoct6S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739505199; c=relaxed/simple;
	bh=DaaZYMVpMr6rDFrHGFQDXW0cpI04Kg3t+WecM4wdj8I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=opwE7PMM1hZecpP0jqLuQA/wnU5DVbZKl8fFllOZFHCjdDQw/oHDwX7POSLotvQtUBGJIwlTy2LPpL9gvv5WrYKwrDpLUddCZ2iCi+XR+OkjFBY/AqY8rc+z7qMMobkONtseCaoGrX9fYGhREtmCJ3ehCfUFIPib8xH45Xysgic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TS7e7Sot; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TS7e7Sot"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EED8C4CED1;
	Fri, 14 Feb 2025 03:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739505198;
	bh=DaaZYMVpMr6rDFrHGFQDXW0cpI04Kg3t+WecM4wdj8I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=TS7e7Sot/4SDe+54PBc/Sl9HNSPq9N02c0XXP0iTrEc4cTaxBRI5vPJ952WQU9LOk
	 bEmEsjtm6eNM9/PQa7ZR64J5ofknv/zq4MBYMya39T/V1UXj1r0omaehl5FmvkXBhK
	 ciedrBPEddnBIjPUWgg46rxa3aP2G08nF+leWIqPEdKm8Wzv9rhhsynAkSDDEko2sW
	 2tQiIjNA8oKARnruhYYCVWqtsWvA4d8XNwK68gbW404kcY3SaE/Mcz9vpAY0aop/Uj
	 uwVTpGZKU7xleNK6QSPg5T/X7catS7IM4BJ0UUBPya7N0XmhLBn5TB6r9S0gW3zkPq
	 myPCcFWxTF0iQ==
Message-ID: <68b3708ed177857714db3b75d3c4a25fd5b226a0.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v3 0/3] BPF path manager, part 4
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Fri, 14 Feb 2025 11:53:13 +0800
In-Reply-To: <6f5e14aa3e457fdbecc174932b57ce1b04c50ce1.camel@kernel.org>
References: <cover.1737012662.git.tanggeliang@kylinos.cn>
	 <0a072aa0-df72-4c38-b31d-c7a3349377fa@kernel.org>
	 <6f5e14aa3e457fdbecc174932b57ce1b04c50ce1.camel@kernel.org>
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

On Fri, 2025-02-07 at 19:21 +0800, Geliang Tang wrote:
> Hi Matt,
> 
> Thanks for your review.
> 
> On Thu, 2025-01-23 at 13:43 +0100, Matthieu Baerts wrote:
> > Hi Geliang,
> > 
> > On 16/01/2025 08:38, Geliang Tang wrote:
> > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > > 
> > > v3:
> > >  - rename the 2nd parameter of get_local_id() from 'local' to
> > > 'skc'.
> > >  - keep the 'msk_sport' check in
> > > mptcp_userspace_pm_get_local_id().
> > >  - return 'err' instead of '0' in userspace_pm_subflow_create().
> > >  - drop 'ret' variable inmptcp_pm_data_reset().
> > >  - fix typos in commit log.
> > > 
> > > Depends on: "BPF path manager, part 3" v4
> > > Based-on: <cover.1737012165.git.tanggeliang@kylinos.cn>
> > > 
> > > v2:
> > >  - update get_local_id interface in patch 2.
> > > 
> > > get_addr() and dump_addr() interfaces of BPF userspace pm are
> > > dropped
> > > as Matt suggested.
> > > 
> > > In order to implement BPF userspace path manager, it is necessary
> > > to
> > > unify the interfaces of the path manager. This set contains some
> > > cleanups and refactoring to unify the interfaces in kernel space.
> > > Finally, define a struct mptcp_pm_ops for a userspace path
> > > manager
> > > like this:
> > 
> > Thank you for this series.
> > 
> > From what I see, when a BPF path-manager is loaded, it will replace
> > the
> > userspace one, right?
> > 
> > It looks a bit confusing to know when the (netlink) userspace PM is
> > used, and when the BPF one is. Why not defining a new type instead?
> > Similar to what we have with the packet scheduler?
> > net.mptcp.pm_type
> > could be extended to select a BPF one of a certain ID, no? (or a
> > new
> > type for BPF, then another sysctl to select the name?)
> > 
> > Why not, instead, and similar to the scheduler, have a proper
> > path-manager interface?
> > 
> > For the moment, when the core gets something that might interest
> > the
> > PM,
> > it will directly call a PM helper, then the right PM is picked
> > thanks
> > to
> > mptcp_pm_is_userspace() or mptcp_pm_is_kernel(). That starts to get
> > a
> > bit messy when we want to add more PMs. Instead, the core could
> > simply
> > use the new ops structure, using a pointer stored in the msk.
> > 
> > In other words, when the core needs to notify the PM, it will
> > simply
> > call (directly, or via the PM worker): msk->pm.ops-
> > > something_happened()
> > (or via helpers in pm.c that could check if the callback is set,
> > and
> > call mptcp_event() for example)
> > 
> > That way, we have a clear separation of all the different PMs, and
> > the
> > interface is clear to understand the interactions between the core
> > and
> > the PMs.
> > 
> > WDYT?
> > 
> > I hope this doesn't change all your plans. But I think having such
> > interface would help for the maintenance in general.
> 
> It would be best if struct mptcp_pm_ops could be used to represent
> both
> userspace pm and in-kernel pm, but it's not easy to represent in-
> kernel
> pm right now, and the code in pm_netlink.c needs to be adjusted. So I
> still use struct mptcp_pm_ops to implement
> MPTCP_PM_TYPE_BPF_USERSPACE
> first in the set, and use mptcp_pm_is_userspace() function to
> distinguish different PMs.

I have made some new progress recently. I adjusted the code in
pm_netlink.c and implemented get_local_id(), get_priority() and
set_priority() interfaces for in-kernel pm. It seems that we can indeed
use struct mptcp_pm_ops to represent both userspace pm and in-kernel
pm, and then remove the use of mptcp_pm_is_userspace(). I will update
the new version of this set in the near future.

Thanks,
-Geliang

> 
> In the future, if we feel it's necessary, we can add a
> MPTCP_PM_TYPE_BPF_KERENL pm type to implement BPF in-kernel pm, and
> then gradually remove the use of mptcp_pm_is_userspace() and
> mptcp_pm_is_kernel().
> 
> Thanks,
> -Geliang
> 
> > 
> > 
> > > struct mptcp_pm_ops {
> > >  int (*address_announce)(struct mptcp_sock *msk,
> > >  struct mptcp_pm_addr_entry *local);
> > >  int (*address_remove)(struct mptcp_sock *msk, u8 id);
> > >  int (*subflow_create)(struct mptcp_sock *msk,
> > >        struct mptcp_pm_addr_entry *local,
> > >        struct mptcp_addr_info *remote);
> > >  int (*subflow_destroy)(struct mptcp_sock *msk,
> > >         struct mptcp_pm_addr_entry *local,
> > >         struct mptcp_addr_info *remote);
> > 
> > Small detail: I would add a 'd' at the end to clearly understand it
> > is
> > linked to an event, not an action, e.g. a new address has just been
> > announced, here is a notification for the PM. So:
> > 
> >   address_announced
> >   address_removed
> >   subflow_created
> >   subflow_destroyed
> > 
> > >  int (*get_local_id)(struct mptcp_sock *msk,
> > >      struct mptcp_pm_addr_entry *skc);
> > >  u8 (*get_flags)(struct mptcp_sock *msk,
> > >  struct mptcp_addr_info *skc);
> > >  int (*set_flags)(struct mptcp_sock *msk,
> > >  struct mptcp_pm_addr_entry *local,
> > >  struct mptcp_addr_info *remote);
> > 
> > I think it should only be get_priority and set_priority (i.e.
> > backup):
> > the core doesn't need to know the other (internal) flags.
> > 
> > Also, when looking at mptcp_event_type, I think some events are
> > missing
> > here for a PM to handle the different cases:
> > 
> >   created: a new MPTCP has been created, to init some stuff
> >   established: fully established connection, the PM can trigger
> > actions
> >   closed: to free some stuff
> > 
> > And probably 'listerner_created' and 'listener_closed' too.
> > 
> > One last thing; I guess the current 'subflow_created' is more a
> > 'subflow_established', no?
> > And 'subflow_destroyed' could be 'subflow_closed' to keep the same
> > name,
> > (and also because I guess this will be called just before it is
> > going
> > to
> > be destroyed).
> > 
> > > 
> > >  u8 type;
> > 
> > Either a type (0 for in-kernel, 1 for userspace, >1 for BPF) or a
> > name.
> > 
> > >  struct module *owner;
> > >  struct list_head list;
> > > 
> > >  void (*init)(struct mptcp_sock *msk);
> > >  void (*release)(struct mptcp_sock *msk);
> > 
> > Is the init/release done only once, or for each MPTCP connection
> > handled
> > by this PM?
> > 
> > > } ____cacheline_aligned_in_smp;
> > > 
> > > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/74
> > 
> > Better to wait to have the full BPF interface and an example in the
> > selftests before closing this I think.
> > 
> > 
> > Two last thing:
> > 
> > - better keeping the 'mptcp_pm' prefixes for the new helpers, e.g.
> > mptcp_pm_register instead of mptcp_register_path_manager.
> > 
> > - for the commit title, maybe clearer to prefix them with 'mptcp:
> > pm:',
> > and even 'mptcp: pm: in-kernel:', 'mptcp: pm: userspace:' and
> > 'mptcp:
> > pm: bpf' when it makes sense.
> > 
> > Cheers,
> > Matt
> 
> 

