Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793454955;
	b=1CbJM5njbospzXNb/DsKY0easNou7MzvXgsGoxUKBh5c9OTvbGOg+5SpMquJNf0odbD4
	 VNFgHv9wBKyyl8y4MP28H0mltvQOKHkogYnaun7tcMV3i3TdYbzK40TmbMjeprp5OHFYR
	 3expanS5a/ClxvWL8/y5tC+8GaH4CD2x3LjbXVJwDqK+FdM5MAUGkgaQAiyham9iI/mdL
	 PAMeB2jIm5v+px1wgVXPDfsZV05cvJpLIOOaPxc5KImGVvuXbNmtNTPbAm9WuYexjLjxw
	 IzxcQQFweN8VsSNbkfes3a224R1pn1YXzmHTTg7YEII/B38tol6xw88JupbNtJ06Bpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793454955;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=0kGzQJxs8zPjHkzVXZx1RaxejgWdHaSDHJkTmOJG1C8=;
	b=bY3nBkDfLz3lQmfJuVwlKvYXHOeLzbeI+6lQeR49Wk+Ql7MHUQy7S4G7ySnER1LwL/YG
	 HrI3ADEH9gQa8VLVhe+BsfUEimq1FXtxwskarZv8/vIYrcEY4JLtpRzbDF+qbNOPwmr6i
	 b4a2K3q5tgpfs+i9cw0Mox6Y/LJTGTg4tAYjsplxBnU02sP5H1JS+yEvpo4qNYf7UF2bq
	 NegpSQz1Kn3kgBhsCERoHoAdhHJonqDy6cTYhTrI992imdmgunpQiLpre+4oko3uTPvKv
	 g40bUprIdoqIPq/KWUJO9cdPYSlfBvbEplyqXG4gIsC50/6ymy7ckDdMJ3hyjIsg+Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IRI+C8m2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B693606A31D
	for <mptcp@lists.linux.dev>; Sat, 31 Oct 2026 13:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IRI+C8m2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8561F00A02;
	Sat, 31 Oct 2026 13:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793454954;
	bh=0kGzQJxs8zPjHkzVXZx1RaxejgWdHaSDHJkTmOJG1C8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IRI+C8m2rES/exkWNWHR/0KkxNMZYjcCGRKOlwtleAjHafpzJ2L2Odlbp+VRy90sq
	 0Ai1Q6lrUlnVR3rSD+VGN+7HM3pGFIaN39VGonzLJpr2hXGgdkDHBqMVvwIgc+ohHV
	 pPoMk2+4p1w34OTLfJvqHYCyRet0P92e91EO82UPRUO4kyfByjyYawXCQKJAlx5yWZ
	 VzM1pNSM5pg6UkBHPGmtZWQOgdSDKMn05/6zeoEZwf90Bp8QOE2AgQrRoytqaB48BB
	 +otMpnAymOTc6ND2CzNJwV9mKIhhJca5MPBAAtidM+8XlRsXvU0jIWaaJK3xLbUxVa
	 7K9vyjqK55uIQ==
Subject: Re: [PATCH mptcp-next v2 4/5] mptcp: pm: kernel: skip operating on
 closing connections
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, pabeni@redhat.com, chenguang.zhao@linux.dev,
 gang.yan@linux.dev, kuba@kernel.org
Date: Sat, 31 Oct 2026 13:55:53 +0000
Message-ID: <179345495390.3128.17275733038011770247@kernel.org>
In-Reply-To: <20261030-mptcp-reset-mpj-early-v2-4-90f119392263@kernel.org>
References: <20261030-mptcp-reset-mpj-early-v2-4-90f119392263@kernel.org>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In net/mptcp/pm_kernel.c,
  mptcp_nl_add_subflow_or_signal_addr() now skips every msk that is not…
- [Low] Commit message vs. code wording.
- [Low] mptcp_pm_nl_set_flags_all() (net/mptcp/pm_kernel.c:1509-1516) now
  skips msks whose initial subflow is TCP-established but where…
- [Low] Per-msk kernel-PM endpoint accounting can be taken before
  msk->fully_established is set, and the endpoint delete/flush paths now…
- [Low] The patch adds a lockless `READ_ONCE(msk->fully_established)`
  skip before lock_sock() in mptcp_nl_remove_subflow_and_signal_addr()…

--

mptcp: pm: kernel: skip operating on closing connections

This patch adds msk->fully_established checks to the kernel PM loops
that walk all MPTCP connections after an endpoint is removed, flushed,
or has its flags changed. The add path now uses
mptcp_is_fully_established(), which also requires the msk to be in
TCP_ESTABLISHED.

> mptcp: pm: kernel: skip operating on closing connections
>
> When iterating over each MPTCP connection after having manipulated MPTCP
> endpoints, there is no need to operate on closing (or not ready)
> connections.

[Severity: Low]
This isn't a bug, but do the subject and this paragraph still match what
the patch does?

Only mptcp_nl_add_subflow_or_signal_addr() checks the socket state,
through mptcp_is_fully_established(). The other four loops only test
READ_ONCE(msk->fully_established):

    mptcp_nl_remove_subflow_and_signal_addr()
    mptcp_nl_remove_id_zero_address()
    mptcp_nl_flush_addrs_list()
    mptcp_pm_nl_set_flags_all()

That flag is not cleared on close. Closing connections (FIN_WAIT*,
CLOSE_WAIT, LAST_ACK, CLOSING) are therefore still processed in those
loops, which the last paragraph of the commit message says is intended.

__mptcp_try_fallback() does clear the flag on fallback. So what those
four loops skip is connections that are not yet fully established or
have fallen back.

The subject and first paragraph look left over from v1. Could they be
reworded to describe what the remove, flush and set_flags hunks skip?

> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index d3014bf57bf3c..096ffea80f61f 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c
> @@ -969,7 +969,7 @@ static int mptcp_nl_add_subflow_or_signal_addr(struct net *net,
>  		struct sock *sk = (struct sock *)msk;
>  		struct mptcp_addr_info mpc_addr;
>  
> -		if (!READ_ONCE(msk->fully_established) ||
> +		if (!mptcp_is_fully_established(sk) ||
>  		    mptcp_pm_is_userspace(msk))
>  			goto next;
>  

[Severity: Medium]
Does this check now skip the mpc_endpoint_id update for half-closed
connections?

mptcp_pm_create_subflow_or_signal_addr() already returns early when the
msk is not in TCP_ESTABLISHED:

    mptcp_mpc_endpoint_setup(msk);
    if (!mptcp_is_fully_established(sk))
        return;

For CLOSE_WAIT, FIN_WAIT1/2, CLOSING or LAST_ACK connections, the only
thing this hunk changes is that the following no longer runs:

    if (mptcp_addresses_equal(addr, &mpc_addr, addr->port))
        msk->mpc_endpoint_id = addr->id;

The remove path still processes half-closed connections. It relies on
mpc_endpoint_id through mptcp_endp_get_local_id():

    return msk->mpc_endpoint_id == addr->id ? 0 : addr->id;

Take a connection whose initial address had no endpoint when it became
fully established. Deleting that endpoint, which resets mpc_endpoint_id
to 0, leads to the same state.

The peer sends a DATA_FIN and the msk moves to CLOSE_WAIT. An endpoint
with ID N is then added for that address, and this loop skips the msk.
MPTCP_PM_MPC_ENDPOINT_ACCOUNTED is already set, so
mptcp_mpc_endpoint_setup() will not fix this later.

When endpoint N is deleted, mptcp_nl_remove_subflow_and_signal_addr()
gets N from mptcp_endp_get_local_id() instead of 0. RM_ADDR is sent with
ID N, but the peer knows that address as ID 0.

mptcp_pm_rm_subflow() with ID N then skips the initial subflow, whose
local id is 0, in mptcp_pm_rm_addr_or_subflow():

    if (rm_type == MPTCP_MIB_RMSUBFLOW && id != rm_id)
        continue;

Before this patch, the same steps sent RM_ADDR with ID 0 and closed the
initial subflow.

mptcp_pm_create_subflow_or_signal_addr() already handles the closing
case. Would it be better to keep the READ_ONCE(msk->fully_established)
check here?

> @@ -1095,7 +1095,8 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
>  		struct sock *sk = (struct sock *)msk;
>  		bool remove_subflow;
>  
> -		if (mptcp_pm_is_userspace(msk))
> +		if (!READ_ONCE(msk->fully_established) ||
> +		    mptcp_pm_is_userspace(msk))
>  			goto next;
>  
>  		lock_sock(sk);

[Severity: Low]
Can a connection reserve endpoint IDs before msk->fully_established is
set, and then never release them because of this skip?

If an out-of-order segment arrives before the connection is fully
established, check_fully_established() returns subflow->mp_capable
without setting the flag. mptcp_incoming_options() then still processes
an ADD_ADDR.

mptcp_pm_add_addr_received() has no fully established check, so the PM
worker goes on to call:

    mptcp_pm_nl_add_addr_received()
      mptcp_mpc_endpoint_setup()

That call does three things:

- clears the MPC endpoint ID in pm.id_avail_bitmap
- sets msk->mpc_endpoint_id
- sets MPTCP_PM_MPC_ENDPOINT_ACCOUNTED

In the fullmesh or c-flag variants, fill_local_addresses_vec() can also
clear IDs and bump local_addr_used. This happens before
__mptcp_subflow_connect() fails the mptcp_is_fully_established() check.

Suppose the endpoint is deleted or flushed in that window. This loop,
mptcp_nl_remove_id_zero_address() and mptcp_nl_flush_addrs_list() now
all skip the msk. None of these cleanups runs for it:

- the __set_bit() and __mark_subflow_endp_available() release
- the mpc_endpoint_id = 0 reset
- the bitmap_fill() and local_addr_used = 0 reset

Once the connection becomes fully established, mptcp_mpc_endpoint_setup()
returns early:

    if (likely(msk->pm.status & BIT(MPTCP_PM_MPC_ENDPOINT_ACCOUNTED)) ||
        !msk->first)
        return;

For the rest of that connection, a new endpoint that reuses the deleted
ID is treated as unavailable. It can also be mapped to ID 0 through the
stale mpc_endpoint_id.

The window is about one RTT. Before this patch, the same deletion would
have torn down the initial subflow instead.

[Severity: Low]
Is there an ordering issue with doing this lockless check before
lock_sock()?

Before this patch, lock_sock() was always taken after the endp_list
update. The PM worker holds the same lock while reading endp_list. Now
mptcp_pm_nl_del_addr_doit() does:

    list_del_rcu(&entry->list);
    __clear_bit(entry->addr.id, pernet->id_bitmap);
    spin_unlock_bh(&pernet->lock);

    mptcp_nl_remove_subflow_and_signal_addr(sock_net(skb->sk), entry);
    synchronize_rcu();

Between the list store and the fully_established load there is only the
spin_unlock_bh() release, followed by rcu_read_lock() and
refcount_inc_not_zero() in mptcp_token_iter_next().
refcount_inc_not_zero() uses a relaxed cmpxchg.

At the same time, on another CPU:

    __mptcp_subflow_fully_established()
      WRITE_ONCE(msk->fully_established, true);
    ...
    PM worker reads endp_list under RCU

On weakly ordered CPUs such as arm64 or POWER, this loop could read
fully_established == false and skip the msk while the worker still sees
the deleted entry.

The worker could then set mpc_endpoint_id to the deleted ID, announce
it, or create a subflow from it. Nothing would clean that up later.
mptcp_pm_nl_set_flags_all() has the same pattern, where the worker could
read stale entry->flags.

RCU keeps this memory safe, and the add path already had the mirrored
lockless check before this patch.

Is a full barrier needed between the endp_list update and these
fully_established reads?

[ ... ]

> @@ -1502,7 +1506,9 @@ static void mptcp_pm_nl_set_flags_all(struct net *net,
>  	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
>  		struct sock *sk = (struct sock *)msk;
>  
> -		if (list_empty(&msk->conn_list) || mptcp_pm_is_userspace(msk))
> +		if (list_empty(&msk->conn_list) ||
> +		    !READ_ONCE(msk->fully_established) ||
> +		    mptcp_pm_is_userspace(msk))
>  			goto next;
>  
>  		lock_sock(sk);

[Severity: Low]
Could a BACKUP flag change be lost for connections that are not yet
fully established?

On the client there is a window of about one RTT, between the third ACK
and the first in-sequence DSS ack. During it, the initial subflow is
already on conn_list and active, but msk->fully_established is still
false.

Before this patch, a BACKUP change reached mptcp_pm_mp_prio_send_ack()
for such an msk, and MP_PRIO went out with the next ACK. Now the msk is
skipped and the change is not recorded anywhere.

The change is only picked up later if the PM worker runs
mptcp_mpc_endpoint_setup(). mptcp_pm_fully_established() only schedules
the worker when work_pending is set:

    if (READ_ONCE(pm->work_pending) &&
        !(pm->status & BIT(MPTCP_PM_ALREADY_ESTABLISHED)))
        mptcp_pm_schedule_work(msk, MPTCP_PM_ESTABLISHED);

mptcp_pm_kernel_init() leaves work_pending false when there are no
signal endpoints and no usable subflow endpoints. One example is when
the only endpoint marks the initial address as backup.

Sending the same SET_FLAGS request again does not help, because
mptcp_pm_nl_set_flags() then computes changed as 0:

    changed = (local->flags ^ entry->flags) & mask;

In that configuration, the MPC backup flag is not signalled for new
connections either, so this extends an existing limitation. Turning the
flag off and on again recovers it.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030-mptcp-reset-mpj-early-v2-0-90f119392263%40kernel.org
