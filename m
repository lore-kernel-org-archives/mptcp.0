Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A7D20459F
	for <mptcp@lists.linux.dev>; Tue, 18 Mar 2025 10:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294155; cv=none; b=dSEZSjgPDcReal5iXP2nrZUtUyAMeUOzFWqNZd9kScldnf38XShinkvGRE93CAVDn0N1ldMWfKqdTjApc8+uJDk+biEAyLJYNxqqACGzkUzs6xKN+PIDPU0ECYjV0iLxqVxDDByYA2F0arth96C7OzgFuo5W5w8f8LP/4q2Qc40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294155; c=relaxed/simple;
	bh=mGY0b7MvwjLDJks/o98tHULTTy6ZmIfRP4367tUBd6A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lJg8b2Rc+Imuwy5cAB2WhsqLf83P4h9r0tg7Flm3D/8qIfXhNKz+qVue15s11ruYgOZDXqR25UsblgGOtuku01XjsHWtkwxiFc8fyjXtUKqk4iS4KjWZc8/SqVoQEltOI0er9wB9m+43nbnUjanJdLdI9H/e/L+7j/HNgtC1c4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQRyJmEg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQRyJmEg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A5B7C4CEDD;
	Tue, 18 Mar 2025 10:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742294155;
	bh=mGY0b7MvwjLDJks/o98tHULTTy6ZmIfRP4367tUBd6A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=mQRyJmEgTIZiqplOKhehPCHQ8fusZnJXGC7dCVfgyF0/NX/UZJLmLD5bvam4mDm9p
	 Hs+9dPwaLllimbjAE/skBp7WYkHJxc5ZVRZpuvL73j5F1erSAAN4i2/hrcWdwxY6ek
	 8w20yDsmVL6c1PHWMOUy4n6Ffrd5OfDcZQ5jXbAFaohYH/2hnlhl4GRkE+Jym+uQP/
	 hJxCL6gPixeb53VnqZoJcgXMZ/I/PXdcwNOkaS6QXej02UOX71bhut80IgeEQJwLg8
	 2h9ptXkhxV4inANaEysPY69eoZAVrX59Usjae3BpVJWzDvG8UmOBDV+D0MQmI1GKNC
	 8UtyRR6toDfKg==
Message-ID: <05be0df71bcac1bf0f24a7637ba1652aebb8a312.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v3 1/2] mptcp: add bpf_iter_task for
 mptcp_sock
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, mptcp@lists.linux.dev
Date: Tue, 18 Mar 2025 18:35:51 +0800
In-Reply-To: <459fd93c-d99d-4733-9194-3f62467854c6@kernel.org>
References: <cover.1741577149.git.tanggeliang@kylinos.cn>
	 <e04cc2fa5f500097ac7d95afb94f68d0d8dc0057.1741577149.git.tanggeliang@kylinos.cn>
	 <c151a68a659659a2bc8632b63cb04cb59275ec83.camel@kernel.org>
	 <a92d50cf-2eb3-4c56-91cd-0dfa3eb43f7f@kernel.org>
	 <2b680d20eb5873f14f35d9d23aa78b2f5a9d5bfd.camel@kernel.org>
	 <459fd93c-d99d-4733-9194-3f62467854c6@kernel.org>
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

On Mon, 2025-03-17 at 14:57 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 17/03/2025 11:59, Geliang Tang wrote:
> > Hi Matt,
> > 
> > On Mon, 2025-03-17 at 11:29 +0100, Matthieu Baerts wrote:
> > > Hi Geliang, Mat,
> > > 
> > > On 17/03/2025 10:41, Geliang Tang wrote:
> > > > On Mon, 2025-03-10 at 11:30 +0800, Geliang Tang wrote:
> > > > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > > > > 
> > > > > To make sure the mptcp_subflow bpf_iter is running in the
> > > > > MPTCP context. This patch adds a simplified version of
> > > > > tracking
> > > > > for it:
> > > > > 
> > > > > 1. Add a 'struct task_struct *bpf_iter_task' field to struct
> > > > > mptcp_sock.
> > > > > 
> > > > > 2. Do a WRITE_ONCE(msk->bpf_iter_task, current) before
> > > > > calling
> > > > > a MPTCP BPF hook, and WRITE_ONCE(msk->bpf_iter_task, NULL)
> > > > > after
> > > > > the hook returns.
> > > > > 
> > > > > 3. In bpf_iter_mptcp_subflow_new(), check
> > > > > 
> > > > > 	"READ_ONCE(msk->bpf_scheduler_task) == current"
> > > > > 
> > > > > to confirm the correct task, return -EINVAL if it doesn't
> > > > > match.
> > > > > 
> > > > > Also creates helpers for setting, clearing and checking that
> > > > > value.
> 
> (...)
> 
> > > > > +static inline bool mptcp_check_bpf_iter_task(struct
> > > > > mptcp_sock
> > > > > *msk)
> > > > > +{
> > > > > +	struct task_struct *task = READ_ONCE(msk-
> > > > > > bpf_iter_task);
> > > > > +
> > > > > +	if (task && task == current)
> > > > > +		return true;
> > > > > +	return false;
> > > > > +}
> > > > 
> > > > This v3 has a bug. When I was testing MPTCP BPF selftests in a
> > > > loop, I
> > > > found that the test would break in some cases. After debugging,
> > > > I
> > > > found
> > > > that "task" and "current" were not equal:
> > > > 
> > > > [  520.209749][T11984] MPTCP: bpf_iter_mptcp_subflow_new
> > > > msk=00000000fc8f7370 in_interrupt=0 task=00000000ef28139f
> > > > current=0000000024db2987
> > > > 
> > > > I will try to fix it, but haven't found a solution yet.
> > > 
> > > (sorry for the delay, I need a bit of time to catch up)
> > > 
> > > I talked a bit to Alexei Starovoitov last week. He told me that
> > > with
> > > the
> > > BPF struct_ops, it is possible to tell the verifier that some
> > > locks
> > > are
> > > taken either by some struct_ops types, or even per callbacks of
> > > some
> > > specific struct_ops (WIP on sched_ext side). It is also possible
> > > to
> > > get
> > > some locks automatically (polymorphism), and there are examples
> > > on
> > > VFS side.
> > 
> > Thanks for your reminder, I will look at these BPF codes. Our goal
> > is
> > to make mptcp_subflow bpf_iter only used by struct_ops defined by
> > MPTCP
> > BPF (bpf_mptcp_sched_ops and bpf_mptcp_pm_ops), right? Other
> > struct_ops
> > are not allowed to use mptcp_subflow bpf_iter.

I checked and found that other struct_ops **cannot** use mptcp_subflow
bpf_iter. Although we registered this bpf_iter for use with
BPF_PROG_TYPE_STRUCT_OPS type, we checked in bpf_iter_mptcp_subflow_new
that sk->sk_protocol must be IPPROTO_MPTCP. Does this mean that other
struct_ops cannot use mptcp_subflow bpf_iter successfully? I don't know
if this check is sufficient.

> 
> Yes, that's correct. I didn't check, but **maybe** some
> mptcp_sched_ops
> and mptcp_pm_ops callback might not be allowed to use bpf_iter. In
> this
> case, it might be needed to allow only some of them to use bpf_iter.

I guess it's not easy to allow only some callbacks of a struct_ops to
access certain functions, because The BPF verifier verifies the
struct_ops as a whole. But I will continue to look for a solution.

> 
> Note that it sounds like all mptcp_{pm,sched}_ops callbacks should be
> done while holding the msk lock, e.g. being called from the worker
> and
> not from a subflow event, etc. but maybe there are some exceptions
> needed.

I checked the following 19 callbacks of mptcp_{pm,sched}_ops that have
been implemented in my code tree. Except for the three exceptions
(get_local_id, get_priority and add_addr_received), the other 17
callbacks are all be done while holding the msk lock:

struct mptcp_sched_ops {
        int (*get_send)(struct mptcp_sock *msk);
        int (*get_retrans)(struct mptcp_sock *msk);
}

struct mptcp_pm_ops {
        /* required */
        int (*get_local_id)(struct mptcp_sock *msk,
                            struct mptcp_pm_addr_entry *skc);
        bool (*get_priority)(struct mptcp_sock *msk,
                             struct mptcp_addr_info *skc);

        /* optional */
        void (*established)(struct mptcp_sock *msk);
        void (*subflow_established)(struct mptcp_sock *msk);

        /* required */
        bool (*allow_new_subflow)(struct mptcp_sock *msk);
        bool (*accept_new_subflow)(const struct mptcp_sock *msk);
        bool (*add_addr_echo)(struct mptcp_sock *msk,
                              const struct mptcp_addr_info *addr);

        /* optional */
        int (*add_addr_received)(struct mptcp_sock *msk,
                                 const struct mptcp_addr_info *addr);
        void (*rm_addr_received)(struct mptcp_sock *msk);

        /* optional */
        int (*add_addr)(struct mptcp_sock *msk,
                        struct mptcp_pm_addr_entry *entry);
        int (*del_addr)(struct mptcp_sock *msk,
                        const struct mptcp_pm_addr_entry *entry);
        int (*flush_addrs)(struct mptcp_sock *msk,
                           struct list_head *rm_list);

        /* optional */
        int (*address_announce)(struct mptcp_sock *msk,
                                struct mptcp_pm_addr_entry *local);
        int (*address_remove)(struct mptcp_sock *msk,
                              struct mptcp_pm_addr_entry *local);
        int (*subflow_create)(struct mptcp_sock *msk,
                              struct mptcp_pm_addr_entry *local,
                              struct mptcp_addr_info *remote);
        int (*subflow_destroy)(struct mptcp_sock *msk,
                               struct mptcp_pm_addr_entry *local,
                               struct mptcp_addr_info *remote);

        /* required */
        int (*set_priority)(struct mptcp_sock *msk,
                            struct mptcp_pm_addr_entry *local,
                            struct mptcp_pm_addr_entry *remote);
};

For these three exceptions, add_addr_received is invoked in
mptcp_pm_add_addr_received, here the socket lock of ssk is already
holding.

Similarly, in subflow_chk_local_id, get_local_id and get_priority are
called, where the socket lock of ssk is already holding too.

In addition, get_local_id and get_priority are also called in
subflow_token_join_request, which is in atomic and can hold msk lock
through bh_lock_sock. If locking is required here, I can send a patch
to do this.

In this way, all callbacks of mptcp_{pm,sched}_ops can be done while
holding the msk lock or the ssk lock.

Thanks,
-Geliang

> 
> > > In other words, it means we don't need to add this
> > > "bpf_iter_task",
> > > there are other techniques, but I don't have more details, and I
> > > didn't
> > > check in the code. If it is not clear for you and you don't find 
> > > other
> > > examples elsewhere (sched_ext? check WIP patches maybe?), then
> > > Alexei
> > > said we should not hesitate to ask questions on the BPF mailing
> > > list.
> > 
> > We can send "Add mptcp_subflow bpf_iter support" v3 to the BPF
> > mailing
> > list and ask questions during the reviewing process.
> 
> Indeed. I hope to be able to find a bit of time this week to send the
> v3.
> 
> Cheers,
> Matt

