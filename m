Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EB6136E3B
	for <mptcp@lists.linux.dev>; Thu, 23 Jan 2025 12:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737636220; cv=none; b=jRgliqX6wt4BAYmZs3w2fef0/s1n6kLdeYJZinE8CuAyCkGNdmF4dN3N3180d4evsW0BGwkzjch8OMtbZpqF92fQEpHpBgA/fFUpYzxkkdDdd1Tp1bjXZ3odxvap2WOTzASchpIxdQ2A4/25cQZSOAdchhSGhxMvpo5/PxWmMjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737636220; c=relaxed/simple;
	bh=YbCd99wijjzcteh5QC8QuPd1qlOJ4LTHOAdeHTDA8QM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eWt4bkSQZu/39VTVgIEIYQ3/1pGTQ0JqVlGw8Xbl1DUJS+qEuaGIpFD2vGw9k39ewHzZpKPaTz9IGiQgnrT1hdWTU657r7V7IkxePLLfsSqcpRISglqlWiEZkd5AFvTg6nnFc/qoTw3hDxI+B8tmEX0mdIPuoWOXtt39C6Vip/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BB8GQCq9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BB8GQCq9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5AA6C4CEE1;
	Thu, 23 Jan 2025 12:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737636219;
	bh=YbCd99wijjzcteh5QC8QuPd1qlOJ4LTHOAdeHTDA8QM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BB8GQCq9+l/98bgCU4PhqYZWfxK8WARk0ybJvpaoscfxWYEVOMKnEhqAxcqFsoo6u
	 JTwnCrBbFTUYJYTsNBZn+wgePCah3NsT+H4Zu2sCLDfj9teThGPNGJe0+yt8ynmik7
	 ZcC3ZVtsxSOCCDq1IbBSHO4bWE5jzAhqZArs6ceREfgTF4eH40rfYYWzZ+trIPxnrH
	 qpdBhUy2cv9tIyKEjXiHW4MjEEAMNMa2rTRJSpZTgCiEapLUssLJvdrjUjstiDtajA
	 YyjHrSCINFrvUSEfty99UiTjOuVywp1/PYc7rEttnXt4enKJrXLk6NSP/VPhKJuZt7
	 ac8OBJ5yRYCzw==
Message-ID: <0a072aa0-df72-4c38-b31d-c7a3349377fa@kernel.org>
Date: Thu, 23 Jan 2025 13:43:27 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3 0/3] BPF path manager, part 4
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1737012662.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <cover.1737012662.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 16/01/2025 08:38, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> v3:
>  - rename the 2nd parameter of get_local_id() from 'local' to 'skc'.
>  - keep the 'msk_sport' check in mptcp_userspace_pm_get_local_id().
>  - return 'err' instead of '0' in userspace_pm_subflow_create().
>  - drop 'ret' variable inmptcp_pm_data_reset().
>  - fix typos in commit log.
> 
> Depends on: "BPF path manager, part 3" v4
> Based-on: <cover.1737012165.git.tanggeliang@kylinos.cn>
> 
> v2:
>  - update get_local_id interface in patch 2.
> 
> get_addr() and dump_addr() interfaces of BPF userspace pm are dropped
> as Matt suggested.
> 
> In order to implement BPF userspace path manager, it is necessary to
> unify the interfaces of the path manager. This set contains some
> cleanups and refactoring to unify the interfaces in kernel space.
> Finally, define a struct mptcp_pm_ops for a userspace path manager
> like this:

Thank you for this series.

From what I see, when a BPF path-manager is loaded, it will replace the
userspace one, right?

It looks a bit confusing to know when the (netlink) userspace PM is
used, and when the BPF one is. Why not defining a new type instead?
Similar to what we have with the packet scheduler? net.mptcp.pm_type
could be extended to select a BPF one of a certain ID, no? (or a new
type for BPF, then another sysctl to select the name?)

Why not, instead, and similar to the scheduler, have a proper
path-manager interface?

For the moment, when the core gets something that might interest the PM,
it will directly call a PM helper, then the right PM is picked thanks to
mptcp_pm_is_userspace() or mptcp_pm_is_kernel(). That starts to get a
bit messy when we want to add more PMs. Instead, the core could simply
use the new ops structure, using a pointer stored in the msk.

In other words, when the core needs to notify the PM, it will simply
call (directly, or via the PM worker): msk->pm.ops->something_happened()
(or via helpers in pm.c that could check if the callback is set, and
call mptcp_event() for example)

That way, we have a clear separation of all the different PMs, and the
interface is clear to understand the interactions between the core and
the PMs.

WDYT?

I hope this doesn't change all your plans. But I think having such
interface would help for the maintenance in general.


> struct mptcp_pm_ops {
> 	int (*address_announce)(struct mptcp_sock *msk,
> 				struct mptcp_pm_addr_entry *local);
> 	int (*address_remove)(struct mptcp_sock *msk, u8 id);
> 	int (*subflow_create)(struct mptcp_sock *msk,
> 			      struct mptcp_pm_addr_entry *local,
> 			      struct mptcp_addr_info *remote);
> 	int (*subflow_destroy)(struct mptcp_sock *msk,
> 			       struct mptcp_pm_addr_entry *local,
> 			       struct mptcp_addr_info *remote);

Small detail: I would add a 'd' at the end to clearly understand it is
linked to an event, not an action, e.g. a new address has just been
announced, here is a notification for the PM. So:

  address_announced
  address_removed
  subflow_created
  subflow_destroyed

> 	int (*get_local_id)(struct mptcp_sock *msk,
> 			    struct mptcp_pm_addr_entry *skc);
> 	u8 (*get_flags)(struct mptcp_sock *msk,
> 			struct mptcp_addr_info *skc);
> 	int (*set_flags)(struct mptcp_sock *msk,
> 			 struct mptcp_pm_addr_entry *local,
> 			 struct mptcp_addr_info *remote);

I think it should only be get_priority and set_priority (i.e. backup):
the core doesn't need to know the other (internal) flags.

Also, when looking at mptcp_event_type, I think some events are missing
here for a PM to handle the different cases:

  created: a new MPTCP has been created, to init some stuff
  established: fully established connection, the PM can trigger actions
  closed: to free some stuff

And probably 'listerner_created' and 'listener_closed' too.

One last thing; I guess the current 'subflow_created' is more a
'subflow_established', no?
And 'subflow_destroyed' could be 'subflow_closed' to keep the same name,
(and also because I guess this will be called just before it is going to
be destroyed).

> 
> 	u8			type;

Either a type (0 for in-kernel, 1 for userspace, >1 for BPF) or a name.

> 	struct module		*owner;
> 	struct list_head	list;
> 
> 	void (*init)(struct mptcp_sock *msk);
> 	void (*release)(struct mptcp_sock *msk);

Is the init/release done only once, or for each MPTCP connection handled
by this PM?

> } ____cacheline_aligned_in_smp;
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/74

Better to wait to have the full BPF interface and an example in the
selftests before closing this I think.


Two last thing:

- better keeping the 'mptcp_pm' prefixes for the new helpers, e.g.
mptcp_pm_register instead of mptcp_register_path_manager.

- for the commit title, maybe clearer to prefix them with 'mptcp: pm:',
and even 'mptcp: pm: in-kernel:', 'mptcp: pm: userspace:' and 'mptcp:
pm: bpf' when it makes sense.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

