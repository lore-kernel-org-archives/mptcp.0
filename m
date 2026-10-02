Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5079A1D435F
	for <mptcp@lists.linux.dev>; Fri,  2 Oct 2026 01:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790904515; cv=none; b=ncVhjxpnKE3tBiILWMtPGwcA0E3r29kRSgidGnQ7vpPek310EeeIJGkzFxFGWyTgDo2Gt8BtV5vqWHZOlTRP+iVubRQi/mwlgb1iqWaLY7+jEI1fqcdJ6bJmS9NtFVUWtoik8Jx7ltexE2OJVdwzhtziw9UR7RHwLGWWo0xd+N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790904515; c=relaxed/simple;
	bh=n621Q2NWFpdF7Bb4YVC2R7WRfVMCNVPJMVQAsYWaUTw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P3Qr+ppu+Jfy0vB2SUOnAFoFvdS9NAvEzbJRDmmrLJCPDiu/rQ/InSNHi+kZJHZF2Ypxyaln4ZJGeSYMqvlrIuc7yTzbWl68eOrCQP5JjXqeg5cfkhCESj+w9zcSGYJ50sYIDqAsTJU8hpQJlnB8unPI00FRNk5l9pS2pA8DN/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQphoGQj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQphoGQj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EACC81F000FF;
	Fri,  2 Oct 2026 01:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790904512;
	bh=1fzBzI5s2N8Yy3XeQHTJlJQKkm2m2d9Bm3O58DWpt2w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DQphoGQjAZND1NhHdriiD0T/vNubm/K6WZD8R9VTTrI+VVdc5j5U6wKVZ7yGD1MzC
	 1IGnwZ900Xk96kMaQL5Bb4fh0pfoou3Tapo+DFhRmwlpLfhNtMc3UYRsvDZTrbVQ8B
	 IU3JGWVd0Wq8fHjPGdCSg7yXnsrktH9e0khvglFa9SsjqeqkyyZUe0VRsKZCuw6MMI
	 +FHrssteaQkGbuPFpmkaNsc9O6wkCzqNGbKFUTGGh5/0NoahebtVsL0VgrG0qBI0FN
	 TmX3Sre89PR0PJfABuc1RvJOG8UMB1J7xbSTayuwuY71aaLH3XMlvaTiTD3lcM9HpL
	 BXWnUoKrehjxw==
Subject:
 Re: [PATCH net-next v7] mptcp: normalize seq numbers reported in mptcp_info
From: netdev-bot+sashiko@kernel.org
To: kalpan.jani@mpiricsoftware.com
Cc: mptcp@lists.linux.dev, shardul.b@mpiricsoftware.com, janak@mpiric.us,
 kalpanjani009@gmail.com, kuba@kernel.org
Date: Fri, 02 Oct 2026 01:28:31 +0000
Message-ID: <179090451143.3135.10344109428965286911@kernel.org>
In-Reply-To: <20260930102804.2796208-1-kalpan.jani@mpiricsoftware.com>
References: <20260930102804.2796208-1-kalpan.jani@mpiricsoftware.com>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 1 · High: 1 · Medium: 2 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] Use-after-free / NULL pointer dereference in
  mptcp_diag_fill_info().
- [High] mptcp_diag_fill_info() (net/mptcp/sockopt.c:1033-1072) reads
  local_idsn, remote_key_valid and iasn from msk->first's subflow…
- [Medium] The patch changes the meaning of three existing uAPI fields in
  struct mptcp_info (mptcpi_write_seq, mptcpi_snd_una, mptcpi_rcv_nxt;…
- [Medium] The commit claims that remote_idsn is read 'under the same
  lock the writer uses' and that local_idsn and remote_idsn 'stay…
- [Low] The per-version changelog ("Changes since v6" down to "Changes
  since v1", plus the v1-v6 lore links) is in the commit message body…
- [Low] After this patch, data-sequence-space values exported by MPTCP
  diag interfaces use different reference points.
- [Low] tools/testing/selftests/net/mptcp/mptcp_sockopt.c
  do_getsockopt_mptcp_info() uses `s->mi.mptcpi_write_seq == 0` as a 'no…

--

mptcp: normalize seq numbers reported in mptcp_info

This patch normalizes mptcpi_write_seq, mptcpi_snd_una and mptcpi_rcv_nxt
in mptcp_diag_fill_info(). It subtracts the local IDSN and the remote IASN,
both read from the subflow context of msk->first, and holds a reference on
msk->first for the whole function. It also moves the remote_key_valid
assignment in subflow_set_remote_key() so it happens after iasn is set.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/445

> Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
>
> Changes since v6:

[Severity: Low]
This isn't a bug, but the per-version changelog is in the commit message
body, after the Signed-off-by trailer. That covers "Changes since v6" down
to "Changes since v1", plus the v1-v6 lore links.

Should all of that go below the --- separator so it stays out of the git
log?

> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index fcf6feb2a9eb5..918ec873fcb05 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c

[ ... ]

> @@ -1008,9 +1010,37 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
>  	info->mptcpi_flags = flags;
>  
>  	slow = lock_sock_fast(sk);
> +	/* msk->first is only ever NULL once the whole msk is already in
> +	 * TCP_CLOSE (see __mptcp_close_ssk()); mptcp_close() holds the same
> +	 * sk lock this function acquires via lock_sock_fast(), so no caller
> +	 * can observe that transition mid-flight. If it does happen, write_seq
> +	 * and snd_una below are just left unnormalized, which is harmless
> +	 * since the socket is already gone.
> +	 *
> +	 * first is snapshotted once here, rather than re-read later, so
> +	 * local_idsn and remote_idsn below both come from the same subflow
> +	 * and stay consistent with each other even if msk->first changes
> +	 * between the two normalizations. __mptcp_close_ssk() can drop the
> +	 * last reference on this subflow (sock_put()) before it clears
> +	 * msk->first, so refcount_inc_not_zero() is used instead of
> +	 * sock_hold(): if the count has already reached zero, first is
> +	 * treated the same as NULL instead of resurrecting a dying socket.
> +	 * On success, the extra reference keeps the subflow context alive
> +	 * for the rest of this function; it is released with sock_put() at
> +	 * the end.
> +	 */
> +	rcu_read_lock();
> +	first = READ_ONCE(msk->first);
> +	if (first && !refcount_inc_not_zero(&first->sk_refcnt))
> +		first = NULL;
> +	rcu_read_unlock();
> +
> +	if (first)
> +		local_idsn = mptcp_subflow_ctx(first)->idsn;

[Severity: High]
Can this baseline be wiped while the connection is still established?

Suppose the peer resets the initial MPC subflow, or it times out, while
other subflows keep the msk in TCP_ESTABLISHED. The worker then runs
__mptcp_close_subflow()->mptcp_close_ssk()->__mptcp_close_ssk().

free_first is only set in mptcp_destroy(), so for the first subflow of a
live msk:

net/mptcp/protocol.c:__mptcp_close_ssk() {
    ...
	dispose_it = msk->free_first || ssk != msk->first;
    ...
	if (!dispose_it) {
		__mptcp_subflow_disconnect(ssk, subflow, msk->fastclosing);
		release_sock(ssk);

		goto out;
	}
    ...
}

On a TCP_CLOSE ssk, __mptcp_subflow_disconnect() calls
mptcp_subflow_ctx_reset():

	memset(&subflow->reset, 0, sizeof(subflow->reset));

The reset struct_group covers idsn, the iasn union and remote_key_valid.
msk->first is not cleared on this path.

>From then on, every getsockopt(MPTCP_INFO) or inet_diag query would get
local_idsn == 0 and remote_idsn == 0. mptcpi_write_seq, mptcpi_snd_una and
mptcpi_rcv_nxt would then jump in the middle of the connection, from small
normalized values back to the raw DSNs.

That would make two statements inaccurate. The commit message says
"subflow->idsn is set once at handshake time and never modified
afterwards". The comment above says "which is harmless since the socket is
already gone".

The testing described in the commit message watched for msk->first
becoming NULL. It would not catch this case, because the pointer stays set
and only the context is zeroed.

Does the baseline need to live somewhere that survives a subflow ctx
reset, for example cached on the msk as in v2?

>  	info->mptcpi_csum_enabled = READ_ONCE(msk->csum_enabled);
>  	info->mptcpi_token = msk->token;
> -	info->mptcpi_write_seq = msk->write_seq;
> +	info->mptcpi_write_seq = msk->write_seq - local_idsn;

[Severity: Medium]
This changes the meaning of three existing uAPI fields in struct
mptcp_info, with no new field or flag.

The inet_diag path also uses mptcp_diag_fill_info():

mptcp_diag_get_info()->mptcp_diag_fill_info()

So "ss -M -i" and other INET_DIAG_INFO consumers get the new semantics too.
The commit message only discusses getsockopt(MPTCP_INFO) and the selftest.

After this change no unprivileged interface exposes the raw values, and
mptcp_info does not export the keys needed to recompute the offset.

The commit message also seems to contradict itself. It says the raw values
"are not useful to userspace as absolute values". It then says tools that
correlate against captured DSS sequence numbers "will need to account for
the offset".

How would those tools recover the offset? Should the commit message at
least mention the inet_diag consumers?

[Severity: Low]
This isn't a bug, but do_getsockopt_mptcp_info() in
tools/testing/selftests/net/mptcp/mptcp_sockopt.c treats a zero write_seq
as "no baseline sample yet", and it only checks deltas:

	if (s->mi.mptcpi_write_seq == 0)
		s->mi = i;

	assert(s->mi.mptcpi_write_seq + w == i.mptcpi_write_seq);

With the new semantics, 0 is a valid normalized value before the handshake
completes, because mptcp_connect() sets msk->write_seq to subflow->idsn.
The test only samples after connect()/accept(), so it does not fail today.

Because only differences are checked, the test passes whether or not the
normalization is applied. Could the selftest also check the absolute
normalized values?

> @@ -1023,11 +1053,28 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
>  	unlock_sock_fast(sk, slow);
>  
>  	mptcp_data_lock(sk);
> +	if (first) {
> +		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(first);
> +
> +		/* subflow->iasn is incremented once in subflow_set_remote_key(),
> +		 * which runs under this same mptcp_data_lock() (see
> +		 * mptcp_propagate_state()); compute remote_idsn here, under the
> +		 * same lock as the writer, and atomically with ack_seq below.
> +		 * first is the same held reference from earlier in this
> +		 * function, so it is guaranteed to still be valid here and to
> +		 * be the same subflow local_idsn was computed from above.
> +		 */
> +		remote_idsn = subflow->remote_key_valid ? subflow->iasn - 1 : 0;

[Severity: Critical]
Does the reference on first->sk_refcnt really keep the subflow context
alive here? The ctx is a separate allocation reached through
icsk_ulp_data. It can be freed or detached no matter what sk_refcnt is.

At this point unlock_sock_fast() has dropped the msk socket lock and no
rcu_read_lock() is held. mptcp_data_lock() is only
spin_lock_bh(&sk->sk_lock.slock), and it does not exclude a task that owns
the msk through lock_sock().

The first path is close() on the msk:

__mptcp_close()->__mptcp_destroy_sock()->mptcp_destroy()
  msk->free_first = 1;
  mptcp_destroy_common()->__mptcp_close_ssk(first)

On that dispose path the ctx is either freed directly:

	if (!inet_csk(ssk)->icsk_ulp_ops) {
		WARN_ON_ONCE(!sock_flag(ssk, SOCK_DEAD));
		kfree_rcu(subflow, rcu);
	} else {
		/* otherwise tcp will dispose of the ssk and subflow ctx */
		__tcp_close(ssk, 0);

or TCP destroy reaches subflow_ulp_release(). That function does
kfree_rcu(ctx, rcu) without clearing icsk_ulp_data, which leaves a
dangling pointer.

The second path is closing a listener that still has unaccepted children:

mptcp_subflow_queue_clean()
  lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
  __mptcp_unaccepted_force_close(sk)
    ...->__mptcp_close_ssk()
      mptcp_subflow_drop_ctx(ssk)
        subflow_ulp_fallback()
          rcu_assign_pointer(icsk->icsk_ulp_data, NULL);
        kfree_rcu(ctx, rcu);

Here the second mptcp_subflow_ctx(first) call returns NULL, so reading
subflow->remote_key_valid dereferences a NULL pointer.

An inet_diag dump reaches mptcp_diag_fill_info() through
mptcp_diag_dump()->...->inet_sk_diag_fill()->mptcp_diag_get_info(). It
holds only an msk reference, and INET_DIAG_INFO needs no capability, so a
dump can race with either path.

In the kfree_rcu() case, the freed memory ends up in mptcpi_rcv_nxt and is
returned to userspace.

The earlier local_idsn read runs under the msk socket lock, so only this
second read seems affected. The comments saying the reference "keeps the
subflow context alive" and that first "is guaranteed to still be valid
here" also look inaccurate.

Could remote_key_valid and iasn be sampled inside the lock_sock_fast()
section instead? Another option is rcu_read_lock() plus
rcu_dereference(inet_csk(first)->icsk_ulp_data) with a NULL check, as
subflow_get_info() in net/mptcp/diag.c does.

[Severity: Medium]
Apart from the lifetime question, is mptcp_data_lock() really the lock
that serializes every writer of these fields?

subflow_set_remote_key() is not the only writer. mptcp_subflow_ctx_reset()
also writes idsn, iasn and remote_key_valid through its memset of the reset
group. It runs from __mptcp_subflow_disconnect() under lock_sock(msk) and
lock_sock_nested(ssk), not under mptcp_data_lock():

mptcp_worker()
  __mptcp_close_subflow()->mptcp_close_ssk()->__mptcp_close_ssk()
    __mptcp_subflow_disconnect()
      mptcp_subflow_ctx_reset()
        memset(&subflow->reset, 0, sizeof(subflow->reset));

This function reads local_idsn under lock_sock_fast(), drops the msk lock,
and then reads remote_key_valid and iasn under mptcp_data_lock(). In that
gap the worker can take lock_sock(msk) and reset the ctx of a TCP_CLOSE
first subflow, while msk->first stays the same.

That gives a plain read racing with the memset. It can also give a single
reply where write_seq and snd_una use the original IDSN, but rcv_nxt is
either raw (remote_idsn == 0) or uses a different baseline.

Doesn't that contradict the commit message, which says remote_idsn is read
"under the same lock the writer uses" and that both values "stay
consistent with each other"?

> +	}
> +
>  	info->mptcpi_last_ack_recv = jiffies_to_msecs(now - msk->last_ack_recv);
> -	info->mptcpi_snd_una = msk->snd_una;
> -	info->mptcpi_rcv_nxt = msk->ack_seq;
> +	info->mptcpi_snd_una = msk->snd_una - local_idsn;
> +	info->mptcpi_rcv_nxt = msk->ack_seq - remote_idsn;

[Severity: Low]
After this change the msk-level fields are relative to IDSN/IASN. The
per-subflow ULP diag info still exports a raw DSN from the same sequence
space. subflow_get_info() in net/mptcp/diag.c does:

	     nla_put_u64_64bit(skb, MPTCP_SUBFLOW_ATTR_MAP_SEQ, sf->map_seq,
			       MPTCP_SUBFLOW_ATTR_PAD) ||

and map_seq starts from subflow->iasn.

Tools that compare the msk rcv_nxt with subflow mappings, such as ss
showing both MPTCP and TCP ULP info, would now see the two differ by a
random 64-bit offset.

Should MPTCP_SUBFLOW_ATTR_MAP_SEQ be normalized the same way, or should the
difference at least be documented?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930102804.2796208-1-kalpan.jani%40mpiricsoftware.com
