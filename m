Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936392D29C8
	for <mptcp@lists.linux.dev>; Fri, 16 Oct 2026 02:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792118822; cv=none; b=N4FOv962YJDmhluSsBOZIsQ2fykNLd1O5uEoaCLVnXCkN7zGQvhjBwoMkWFRfVLo0dKaosxOwzWUJ1ulXGMeMpQVIc3ey6cN2f7BzreNi1cxNHK/dtQWzHXrfxnsNgEVHbw/DwayuJD0x5IhRlze14VOkimkHGSRfvZKgE7GOmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792118822; c=relaxed/simple;
	bh=SlG5zikH02Dd6CiaOp3nlZTzzLT3VvoP3JxwZgsEwA8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u7VAW8MAj6bqoRVbOlza+8aOysaP+KHO0jBjR2/tjmwnqRD7U1em+YjOBuCDYKPcVztRueRoR1kTFFXP/8f9FwT9MLPxgLll6J6Qpeby4xLa0DIvUCTBuhVpzz3382BqsC9P/Tjwwj7BThGs7cbMt/uwoYcerSG7C2vT7Rj1I3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELeFc2Am; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELeFc2Am"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981C01F000C4;
	Fri, 16 Oct 2026 02:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792118821;
	bh=/qMapiheEd+ywLzqoBx0DJctFLnjK2lpJF8MJDhW4pc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ELeFc2AmFxAZTfGCBszH/JQgYmKnVDPSm/TwEs9GQxM+37VzT3LcIS53ZnQI1mU3m
	 X0gdAuT706coMoXSQ9FN1KT11OilqdnvO514h9jXo0rXWWlg14JTAQS0jzUPetTMIP
	 wlUYCY0q0OwM93wi7h8ua4YSPJBT1jSyHDB/ElDIzHZK8Ty7RhKCoK4NGP75Fm32cb
	 dDwfdMcH3ugoc4s0YYHrvQhxAlOCswAIhs+IaLMYti0ToKMyXt3GsMTO32WI2bsNup
	 /GZWT/fe4lhA6/fjVCImAIDQ1/fSudM58DbE1EyMEQPQw9eURhBJjSxdbKeSgk7jyA
	 a9TNPD3MrwuVg==
Subject:
 Re: [PATCH net-next v8] mptcp: normalize seq numbers reported in mptcp_info
From: netdev-bot+sashiko@kernel.org
To: kalpan.jani@mpiricsoftware.com
Cc: mptcp@lists.linux.dev, shardul.b@mpiricsoftware.com, janak@mpiric.us,
 kalpanjani009@gmail.com, kuba@kernel.org
Date: Fri, 16 Oct 2026 02:47:00 +0000
Message-ID: <179211882010.3135.7255804669274063290@kernel.org>
In-Reply-To: <20261014130809.1874184-1-kalpan.jani@mpiricsoftware.com>
References: <20261014130809.1874184-1-kalpan.jani@mpiricsoftware.com>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 1 · High: 1 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] Use-after-free read in mptcp_diag_fill_info()
  (net/mptcp/sockopt.c:1043-1049).
- [High] mptcp_diag_fill_info() (net/mptcp/sockopt.c) takes both sequence
  baselines from the initial subflow's context: local_idsn =…
- [Medium] The new early return in mptcp_diag_fill_info()
  (net/mptcp/sockopt.c:988-990) also triggers for TCP_CLOSE.
- [Medium] mptcp_diag_fill_info() reads the sequence baselines under
  locks that do not serialize with the writer that resets them, so it…

--

mptcp: normalize seq numbers reported in mptcp_info

This patch reports mptcpi_write_seq and mptcpi_snd_una relative to the
local IDSN, and mptcpi_rcv_nxt relative to the peer's IDSN. Both baselines
are read from the initial subflow's context. It also makes
mptcp_diag_fill_info() return early for TCP_CLOSE sockets, and moves the
remote_key_valid assignment in subflow_set_remote_key() to after iasn is
set up.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/445

> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index fcf6feb2a9eb..76bab204fc33 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c

[ ... ]

> @@ -982,7 +985,8 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
>  	info->mptcpi_add_addr_accepted = READ_ONCE(msk->pm.add_addr_accepted);
>  	info->mptcpi_local_addr_used = READ_ONCE(msk->pm.local_addr_used);
>  
> -	if (inet_sk_state_load(sk) == TCP_LISTEN)
> +	if (inet_sk_state_load(sk) == TCP_LISTEN ||
> +	    inet_sk_state_load(sk) == TCP_CLOSE)
>  		return;

[Severity: Medium]
Does this early return drop more than the sequence fields for closed
sockets?

Before this patch, only TCP_LISTEN returned here. Now a TCP_CLOSE msk also
skips these fields:

  - mptcpi_flags, including MPTCP_INFO_FLAG_FALLBACK
  - mptcpi_token and mptcpi_csum_enabled
  - mptcpi_retransmits and the bytes_* counters
  - mptcpi_subflows_total
  - the last_data_sent, last_data_recv and last_ack_recv timestamps

MPTCP has no msk-level TIME_WAIT. After a graceful shutdown, a socket the
application still holds is left in TCP_CLOSE, for example in
mptcp_check_data_fin():

	case TCP_FIN_WAIT2:
		mptcp_shutdown_subflows(msk);
		mptcp_set_state(sk, TCP_CLOSE);

Say an application calls shutdown(), reads EOF and then asks MPTCP_INFO
for final stats. It would get a mostly zeroed struct, and the call would
still succeed.

mptcp_getsockopt_full_info() would return this zeroed mptcp_info next to
populated subflow and tcp_info arrays. mptcp_diag_get_info() (ss -M) would
lose the counters and the fallback flag for closed sockets.

Would it be enough to skip only the sequence number normalization in this
state?

> @@ -1008,9 +1012,23 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
>  	info->mptcpi_flags = flags;
>  
>  	slow = lock_sock_fast(sk);
> +	/* Hold a reference to the first subflow while accessing its context. */
> +	rcu_read_lock();
> +	first = READ_ONCE(msk->first);
> +	if (first && !refcount_inc_not_zero(&first->sk_refcnt))
> +		first = NULL;
> +	rcu_read_unlock();
> +
> +	rcu_read_lock();
> +	subflow = first ?
> +		rcu_dereference(inet_csk(first)->icsk_ulp_data) : NULL;
> +	if (subflow)
> +		local_idsn = subflow->idsn;
> +	rcu_read_unlock();
> +
>  	info->mptcpi_csum_enabled = READ_ONCE(msk->csum_enabled);
>  	info->mptcpi_token = msk->token;
> -	info->mptcpi_write_seq = msk->write_seq;
> +	info->mptcpi_write_seq = msk->write_seq - local_idsn;

[Severity: High]
Can these baselines drop back to zero while the connection is still
running?

idsn, iasn and remote_key_valid all live in the reset struct_group of
mptcp_subflow_context. The initial subflow's context can be cleared while
the msk stays established.

Suppose the initial subflow gets a peer RST while MP_JOIN subflows keep the
msk in TCP_ESTABLISHED. The worker then runs:

mptcp_worker()
  __mptcp_close_subflow()
    mptcp_close_ssk()
      __mptcp_close_ssk()
        dispose_it = msk->free_first || ssk != msk->first;  /* false */
        __mptcp_subflow_disconnect()
          tcp_disconnect(ssk, 0);
          mptcp_subflow_ctx_reset(subflow);
            memset(&subflow->reset, 0, sizeof(subflow->reset));

msk->first still points at that socket and the msk is still
TCP_ESTABLISHED. The new TCP_CLOSE check looks at the msk state, not the
first subflow's state, so it doesn't catch this.

After that, local_idsn and remote_idsn are both 0. mptcpi_write_seq,
mptcpi_snd_una and mptcpi_rcv_nxt jump back to absolute values in the
middle of the connection. Anything that computes deltas between samples,
like the mptcp_sockopt selftest, would see a random 64-bit jump.

The "missing context" fallback mentioned in the commit message also
silently reports absolute values.

Could the baselines come from state that lives as long as the msk? For
example, derive them from msk->local_key and msk->remote_key with
mptcp_crypto_key_sha(), or cache them in the msk.

[ ... ]

> @@ -1023,17 +1041,26 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
>  	unlock_sock_fast(sk, slow);
>  
>  	mptcp_data_lock(sk);
> +	rcu_read_lock();
> +	subflow = first ?
> +		rcu_dereference(inet_csk(first)->icsk_ulp_data) : NULL;
> +	if (subflow && subflow->remote_key_valid)
> +		remote_idsn = subflow->iasn - 1;
> +	rcu_read_unlock();

[Severity: Critical]
Is the subflow context still alive when it is dereferenced here?

The msk socket lock has been dropped at this point. Only the msk data lock
and a new RCU read-side section are held. The reference on first keeps the
TCP socket alive, but not its MPTCP subflow context.

Neither release path clears icsk_ulp_data. subflow_ulp_release() does:

	mptcp_subflow_ops_undo_override(ssk);
	if (release)
		kfree_rcu(ctx, rcu);

tcp_cleanup_ulp() only sets icsk_ulp_ops to NULL. __mptcp_close_ssk()
calls kfree_rcu(subflow, rcu) directly when icsk_ulp_ops is already NULL.

Consider a sock_diag dump racing with close() on the same socket:

CPU1 (sock_diag)
mptcp_diag_get_info()
  mptcp_diag_fill_info()
    takes a ref on first, reads local_idsn
    unlock_sock_fast(sk, slow);
    <preempted>

CPU2 (close)
__mptcp_close()
  __mptcp_destroy_sock()
    mptcp_destroy()
      msk->free_first = 1;
      mptcp_destroy_common()
        __mptcp_close_ssk(first)
          dispose_it is true
          kfree_rcu() of the ctx, either directly or via
          __tcp_close()->tcp_cleanup_ulp()->subflow_ulp_release()
          WRITE_ONCE(msk->first, NULL);

CPU1
    mptcp_data_lock(sk);
    rcu_read_lock();
    rcu_dereference(inet_csk(first)->icsk_ulp_data)  /* stale, non-NULL */
    reads subflow->remote_key_valid and subflow->iasn

CPU2 owns the msk lock but doesn't hold the slock, so CPU1 can take
mptcp_data_lock() at the same time.

CPU1's rcu_read_lock() starts after kfree_rcu() was queued, so the grace
period doesn't cover it. The NULL check doesn't help either, because
icsk_ulp_data was never cleared.

Can this read freed slab memory and copy a value derived from it to
userspace through mptcpi_rcv_nxt? INET_DIAG_INFO for MPTCP doesn't require
CAP_NET_ADMIN.

Before this patch, mptcp_diag_fill_info() never touched the subflow
context outside the msk socket lock. Inside that lock, a non-NULL
msk->first means the context is still alive.

Would reading iasn and remote_key_valid inside the lock_sock_fast()
section avoid this? Deriving or caching the remote IDSN at the msk level
would also work.

>  	info->mptcpi_last_ack_recv = jiffies_to_msecs(now - msk->last_ack_recv);
> -	info->mptcpi_snd_una = msk->snd_una;
> -	info->mptcpi_rcv_nxt = msk->ack_seq;
> +	info->mptcpi_snd_una = msk->snd_una - local_idsn;
> +	info->mptcpi_rcv_nxt = msk->ack_seq - remote_idsn;

[Severity: Medium]
Leaving the lifetime question aside, do these reads give a consistent
snapshot?

local_idsn is read under the msk socket lock. remote_key_valid and iasn are
read later, under only mptcp_data_lock().

mptcp_subflow_ctx_reset() runs from
__mptcp_close_ssk()->__mptcp_subflow_disconnect(). That path holds msk
ownership and the ssk lock, but not the msk data lock. So nothing orders
the memset against this reader.

The TCP_CLOSE check at the top of mptcp_diag_fill_info() is a lockless
inet_sk_state_load() done before any lock is taken. It can't rule out a
concurrent disconnect, such as:

  - the worker closing the initial subflow
  - a fastclose
  - mptcp_disconnect() via connect(AF_UNSPEC) from another thread

What if the reader sees the old remote_key_valid == 1 together with the
cleared iasn == 0? Then remote_idsn becomes (u64)-1 and mptcpi_rcv_nxt is
reported as ack_seq + 1.

local_idsn and snd_una/ack_seq can also come from different critical
sections. After a disconnect and reconnect, they can even come from
different connections.

remote_key_valid also shares a bitfield word with flags like map_valid and
mpc_map, which the ssk receive path writes under the ssk lock. Would KCSAN
flag this plain read done under only the msk data lock?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261014130809.1874184-1-kalpan.jani%40mpiricsoftware.com
