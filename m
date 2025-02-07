Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3160D63D
	for <mptcp@lists.linux.dev>; Fri,  7 Feb 2025 11:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738927313; cv=none; b=saTzU9hvlvcQyAEl4MlPhC0RcWRW6IGWa1/9hu4WXE9gB0GeSvoDWS0v8wjsRh7h3rPjlyilD7WCbEdpvPAmZ5WTv63PCqFCpXENrUS+AHVxB+uUP5xUnui05yFbjykm1Bb7IMpQTI9g+KHPz5kO2OjqfHXGLtNSPxcqwscOoN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738927313; c=relaxed/simple;
	bh=sJcjLptiRa+dDid7v/+1czllc7/0GslEKJbmxummXBY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ddHguBQXTlCCUWMx5VYUNCPVT6qvWbs8KHpvpKUmPX3IMm6wh/0iKieGtMiAxdeFCn2idIPYKPOShC9z9/LtskZIIBWk03V8ZakKYnqiEwMdFxE3bHqbUxCTEOe5kSunp9CjE2OUroQknXPDCalFBeLZQv/HeYIVQjscR3SQcsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d00xNNl6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d00xNNl6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC6CC4CED1;
	Fri,  7 Feb 2025 11:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738927312;
	bh=sJcjLptiRa+dDid7v/+1czllc7/0GslEKJbmxummXBY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=d00xNNl6JOhAmEnfaHnlPGUlV6xn/DzC2s31vxexRlDqjfBzaPhx4xkuQVnM1DWs/
	 rrqdkOJAimgc253psIt4KRs7xAqjUTGDxRU7/XLsvsllQcXOO09CH8/JwoOKU8e29v
	 EF1okwQuxtZv7BuDJztTTxHfaa0S4Qw2Mjz2CDnvOtjGB/gpSb7dViCRPqs9MlZadC
	 rV6NKWxWEZjxb80LvQtar4T/yPYCnIJyZunkYzeqEe+/sxicKOaUtfcYXIM69mOOdx
	 emw0JctJd+ErDEePzmdJkFQnBMgY9RWPXoysWeylbUyef7PA0tSwikqoEq50x5VpHq
	 BKg/dtlhs0lMA==
Message-ID: <6f5e14aa3e457fdbecc174932b57ce1b04c50ce1.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v3 0/3] BPF path manager, part 4
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Fri, 07 Feb 2025 19:21:48 +0800
In-Reply-To: <0a072aa0-df72-4c38-b31d-c7a3349377fa@kernel.org>
References: <cover.1737012662.git.tanggeliang@kylinos.cn>
	 <0a072aa0-df72-4c38-b31d-c7a3349377fa@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
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

Thanks for your review.

On Thu, 2025-01-23 at 13:43 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 16/01/2025 08:38, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > v3:
> >  - rename the 2nd parameter of get_local_id() from 'local' to
> > 'skc'.
> >  - keep the 'msk_sport' check in mptcp_userspace_pm_get_local_id().
> >  - return 'err' instead of '0' in userspace_pm_subflow_create().
> >  - drop 'ret' variable inmptcp_pm_data_reset().
> >  - fix typos in commit log.
> > 
> > Depends on: "BPF path manager, part 3" v4
> > Based-on: <cover.1737012165.git.tanggeliang@kylinos.cn>
> > 
> > v2:
> >  - update get_local_id interface in patch 2.
> > 
> > get_addr() and dump_addr() interfaces of BPF userspace pm are
> > dropped
> > as Matt suggested.
> > 
> > In order to implement BPF userspace path manager, it is necessary
> > to
> > unify the interfaces of the path manager. This set contains some
> > cleanups and refactoring to unify the interfaces in kernel space.
> > Finally, define a struct mptcp_pm_ops for a userspace path manager
> > like this:
> 
> Thank you for this series.
> 
> From what I see, when a BPF path-manager is loaded, it will replace
> the
> userspace one, right?
> 
> It looks a bit confusing to know when the (netlink) userspace PM is
> used, and when the BPF one is. Why not defining a new type instead?
> Similar to what we have with the packet scheduler? net.mptcp.pm_type
> could be extended to select a BPF one of a certain ID, no? (or a new
> type for BPF, then another sysctl to select the name?)
> 
> Why not, instead, and similar to the scheduler, have a proper
> path-manager interface?
> 
> For the moment, when the core gets something that might interest the
> PM,
> it will directly call a PM helper, then the right PM is picked thanks
> to
> mptcp_pm_is_userspace() or mptcp_pm_is_kernel(). That starts to get a
> bit messy when we want to add more PMs. Instead, the core could
> simply
> use the new ops structure, using a pointer stored in the msk.
> 
> In other words, when the core needs to notify the PM, it will simply
> call (directly, or via the PM worker): msk->pm.ops-
> >something_happened()
> (or via helpers in pm.c that could check if the callback is set, and
> call mptcp_event() for example)
> 
> That way, we have a clear separation of all the different PMs, and
> the
> interface is clear to understand the interactions between the core
> and
> the PMs.
> 
> WDYT?
> 
> I hope this doesn't change all your plans. But I think having such
> interface would help for the maintenance in general.

It would be best if struct mptcp_pm_ops could be used to represent both
userspace pm and in-kernel pm, but it's not easy to represent in-kernel
pm right now, and the code in pm_netlink.c needs to be adjusted. So I
still use struct mptcp_pm_ops to implement MPTCP_PM_TYPE_BPF_USERSPACE
first in the set, and use mptcp_pm_is_userspace() function to
distinguish different PMs.

In the future, if we feel it's necessary, we can add a
MPTCP_PM_TYPE_BPF_KERENL pm type to implement BPF in-kernel pm, and
then gradually remove the use of mptcp_pm_is_userspace() and
mptcp_pm_is_kernel().

Thanks,
-Geliang

> 
> 
> > struct mptcp_pm_ops {
> >  int (*address_announce)(struct mptcp_sock *msk,
> >  struct mptcp_pm_addr_entry *local);
> >  int (*address_remove)(struct mptcp_sock *msk, u8 id);
> >  int (*subflow_create)(struct mptcp_sock *msk,
> >        struct mptcp_pm_addr_entry *local,
> >        struct mptcp_addr_info *remote);
> >  int (*subflow_destroy)(struct mptcp_sock *msk,
> >         struct mptcp_pm_addr_entry *local,
> >         struct mptcp_addr_info *remote);
> 
> Small detail: I would add a 'd' at the end to clearly understand it
> is
> linked to an event, not an action, e.g. a new address has just been
> announced, here is a notification for the PM. So:
> 
>   address_announced
>   address_removed
>   subflow_created
>   subflow_destroyed
> 
> >  int (*get_local_id)(struct mptcp_sock *msk,
> >      struct mptcp_pm_addr_entry *skc);
> >  u8 (*get_flags)(struct mptcp_sock *msk,
> >  struct mptcp_addr_info *skc);
> >  int (*set_flags)(struct mptcp_sock *msk,
> >  struct mptcp_pm_addr_entry *local,
> >  struct mptcp_addr_info *remote);
> 
> I think it should only be get_priority and set_priority (i.e.
> backup):
> the core doesn't need to know the other (internal) flags.
> 
> Also, when looking at mptcp_event_type, I think some events are
> missing
> here for a PM to handle the different cases:
> 
>   created: a new MPTCP has been created, to init some stuff
>   established: fully established connection, the PM can trigger
> actions
>   closed: to free some stuff
> 
> And probably 'listerner_created' and 'listener_closed' too.
> 
> One last thing; I guess the current 'subflow_created' is more a
> 'subflow_established', no?
> And 'subflow_destroyed' could be 'subflow_closed' to keep the same
> name,
> (and also because I guess this will be called just before it is going
> to
> be destroyed).
> 
> > 
> >  u8 type;
> 
> Either a type (0 for in-kernel, 1 for userspace, >1 for BPF) or a
> name.
> 
> >  struct module *owner;
> >  struct list_head list;
> > 
> >  void (*init)(struct mptcp_sock *msk);
> >  void (*release)(struct mptcp_sock *msk);
> 
> Is the init/release done only once, or for each MPTCP connection
> handled
> by this PM?
> 
> > } ____cacheline_aligned_in_smp;
> > 
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/74
> 
> Better to wait to have the full BPF interface and an example in the
> selftests before closing this I think.
> 
> 
> Two last thing:
> 
> - better keeping the 'mptcp_pm' prefixes for the new helpers, e.g.
> mptcp_pm_register instead of mptcp_register_path_manager.
> 
> - for the commit title, maybe clearer to prefix them with 'mptcp:
> pm:',
> and even 'mptcp: pm: in-kernel:', 'mptcp: pm: userspace:' and 'mptcp:
> pm: bpf' when it makes sense.
> 
> Cheers,
> Matt

