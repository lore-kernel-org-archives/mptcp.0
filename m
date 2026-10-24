Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792859170;
	b=coS/exg8Dz8n00UEWD8+DbaWrylhGmZwRRSuCQUcAxuC0I70Dbs3DZUPYFHst3pyS1VY
	 n18v9EqAYRZO/gzbktebCGYwsrJG4eHgEg/MYRH4xaJQLz6DTpD7Pg4SN0GJEBmyQ67uj
	 95/pi0GG80Tkf/vYhCHIFREokEUMjD8uwhzDPLZVw2oNxP/w3eDEKNwYGfw9eQpjGBGW8
	 oSeZZrn20I6zgQ2aNWUkDpMUtN9gm6qXYDlhfLFJ7JD2SqVa2gjvZ8VdzISqsKY1sSU6M
	 OjLg3dbrufyjzcaLwqxs4Y+GvGahJ3Xk2IJAB5jHRkGAYzgqfprzEtHPQv+WZ8ukzDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792859170;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=J4Qvt05EaUjBiXEAsbhyLaB72FXcj87K0itH3rgYHVQ=;
	b=dmRlPobC8PebkC8oO1ZjtJJa8R5H84svT0BcAOQeen9xbirwDziat/D3Kq3ktYEQY4LM
	 xvy6GYITOQBqbCP9KFdXP8Ivcgt9G+OWCxXbbeUQu6x9AuqQAS/LKsdobD5C0llgvcHlt
	 PYZXgQcLVZjemv4KUalvkZMYnW6eXktHy9pbMttt9QBvceY6LqPOcA6qAkVAI+QNgBoWu
	 8f5oQwjLWsbYqVicRKvfzzzxmfrjNbl1zfbC77OAU1wUyHkJSitcfcoyiuz34u+r2LLT+
	 plewTne/9sEbeTO+NI61J8+mkMQXOqdPmoz7fCBkcxpfM0FIYoxNoJz/UARrhaZNCaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KIq2EsCk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9F3606A31B
	for <mptcp@lists.linux.dev>; Sat, 24 Oct 2026 16:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KIq2EsCk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5462D1F031E7;
	Sat, 24 Oct 2026 16:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792859169;
	bh=J4Qvt05EaUjBiXEAsbhyLaB72FXcj87K0itH3rgYHVQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KIq2EsCk4UsCUUlQ5rg2ZEKzlr5bGkcawuifQxcOaxfeQ8QwSfJiw4yN3c1SY2vMM
	 1+b1tmldqvNhKokxL54FbajTT4BGc+/FlR6MNv0M3/EPQA0nwxFP5B1UletmAy3VRO
	 QGpRUrjsgzUhmVNulNlSkUm32yvLM1MGPXvtHAr/91SK7ekeOgDOsbHcjFRQGmQxi6
	 6czYPkfJ6Kw3YUgj068TWFzHM/xo0gAMI4PPfeK3Jj6wizdqNNQBALAzR7Gi3iTP5x
	 BKr1x7Rg60ElWxvzY/hMlETwrTWoOhoMRbB/VrbpeSl/YRc67rI6tzv2xEIx2xVhe2
	 rw0HUhsa1FMIg==
Subject: Re: [PATCH mptcp-next v15 03/11] mptcp: remove CB offset field
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, yangang@kylinos.cn, kuba@kernel.org
Date: Sat, 24 Oct 2026 16:26:08 +0000
Message-ID: <179285916888.3132.6939287124307215571@kernel.org>
In-Reply-To: =?utf-8?q?=3C8f0a05ab4c45b9ff763ac81eaf85b2eb8148d2cb=2E1792718?=
 =?utf-8?q?041=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3C8f0a05ab4c45b9ff763ac81eaf85b2eb8148d2cb=2E17927180?=
 =?utf-8?q?41=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
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

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 4 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] While MPTCP_SYNC_SEQ is pending, mptcp_inq_hint() returns `skb
  ?
- [Medium] mptcp_init_skb() now sets `map_seq =
  mptcp_subflow_get_mapped_dsn(subflow) - offset` and `end_seq = map_seq…
- [Medium] mptcp_inq_hint() tests MPTCP_SYNC_SEQ and then separately
  reads `READ_ONCE(msk->ack_seq) - msk->copied_seq`.
- [Medium] The patch adds a non-idempotent `msk->copied_seq +=
  mptcp_iasn(msk)` wherever MPTCP_SYNC_SEQ is consumed.
- [Low] The commit message describes a user-visible bug that this patch
  fixes.
- [Low] The new `else` (mp_opt == NULL, fallback) branch in
  mptcp_propagate_state() writes subflow->map_seq,…

--

mptcp: remove CB offset field

This patch replaces the per-skb MPTCP CB offset field with a new msk-level
copied_seq that tracks bytes already copied to user space, similar to TCP.
copied_seq is rebased to the IASN when the remote key arrives, or later in
the release callback via MPTCP_SYNC_SEQ when the msk is owned. The patch
also changes the TFO dummy mapping sign, rewrites mptcp_inq_hint() on top
of copied_seq, and initialises the sequence space in
mptcp_propagate_state() on fallback.

> diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
> index e18b31028e7e3..421a50a855476 100644
> --- a/net/mptcp/fastopen.c
> +++ b/net/mptcp/fastopen.c
> @@ -45,10 +45,11 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
>  	subflow->ssn_offset += skb->len;
>  	has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
>  
> -	/* Only the sequence delta is relevant */
> -	MPTCP_SKB_CB(skb)->map_seq = -skb->len;
> +	/* The TFO segment data sits before the IASN; before receiving
> +	 * the remote key, IASN is assumed being 0.
> +	 */
> +	MPTCP_SKB_CB(skb)->map_seq = -(u64)skb->len;

[Severity: Low]

The commit message says:

  Prior to this patch, the TFO skb dummy mapping (map_seq = -(u32)skb->len,
  zero-extended to u64) caused mptcp_inq_hint() to compute a wrapped
  ack_seq - map_seq, so SIOCINQ and TCP_CM_INQ returned INT_MAX before the
  MPC ACK.

That is a user-visible bug going back to commit 36b122baf6a8 ("mptcp: add
subflow_v(4,6)_send_synack()"), but there is no Fixes: tag.

The fix is also part of a refactor that depends on earlier patches in
this series ("mptcp: drop the mptcp_ooo_try_coalesce() helper" and "mptcp:
drop the cant_coalesce CB field").

With the old formula in mptcp_inq_hint(), wouldn't the one-line
-(u64)skb->len change be enough on its own? Could it be sent separately
with a Fixes: tag so stable trees pick it up?

>  	MPTCP_SKB_CB(skb)->end_seq = 0;

[ ... ]

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 96deaed109a2f..f2840c8d9c825 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -168,7 +168,6 @@ static bool __mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
>  	int limit = READ_ONCE(sk->sk_rcvbuf);
>  
>  	if (MPTCP_SKB_CB(from)->map_seq != MPTCP_SKB_CB(to)->end_seq ||
> -	    MPTCP_SKB_CB(from)->offset ||
>  	    ((to->len + from->len) > (limit >> 3)) ||
>  	    !skb_try_coalesce(to, from, fragstolen, delta))
>  		return false;

[ ... ]

> @@ -425,9 +423,9 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
>  	 * mptcp_subflow_get_mapped_dsn() is based on the current tp->copied_seq
>  	 * value
>  	 */
> -	MPTCP_SKB_CB(skb)->map_seq = mptcp_subflow_get_mapped_dsn(subflow);
> -	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + copy_len;
> -	MPTCP_SKB_CB(skb)->offset = offset;
> +	MPTCP_SKB_CB(skb)->map_seq = mptcp_subflow_get_mapped_dsn(subflow) -
> +				     offset;
> +	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + skb->len;

[Severity: Medium]

Is it safe to assume the offset head bytes belong to the current mapping?

The offset bytes are subflow data before tp->copied_seq, already consumed
at subflow level. With this change they get DSNs by running the current
mapping backwards, so they are labelled [D - offset, D), where D is
mptcp_subflow_get_mapped_dsn().

validate_mapping() accepts a new DSS mapping whose map_subflow_seq equals
copied_seq in the middle of an skb. One way to get there is
tcp_data_queue() queueing a partially overlapping segment unchanged
(seq < rcv_nxt) while the segment's DSS describes the later mapping. If
the head bytes came from an earlier mapping with a non-adjacent DSN, they
now get the wrong DSNs.

If msk->ack_seq equals D - offset, __mptcp_move_skb() takes the
in-sequence branch and delivers the stale head bytes as stream data. The
real [D - offset, D) data from another subflow is then dropped later as
old. In the OFO queue, mptcp_data_queue_ofo() can also replace or drop the
real skb because of the enlarged range.

Before this patch map_seq was D, and the head bytes were skipped through
the CB offset. The offset check removed from __mptcp_try_coalesce() above
also kept such skbs from being merged.

Linux senders don't seem to produce such segments. Hitting this would take
another MPTCP implementation, a resegmenting middlebox, or a crafted peer.

>  	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;

[ ... ]

> @@ -468,6 +464,7 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
>  	if (test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
>  		/* Ensure we see the updated ack_seq after seeing the flag */
>  		smp_rmb();
> +		msk->copied_seq += mptcp_iasn(msk);

[Severity: Medium]

This adjustment is not idempotent. What happens if MPTCP_SYNC_SEQ is
consumed twice?

Here the flag is cleared with test_and_clear_bit() outside the msk data
lock, because mptcp_move_skbs() and mptcp_release_cb() both drop the
spinlock before calling __mptcp_move_skbs(). Meanwhile, softirq writers do
non-atomic read-modify-writes of the same cb_flags word under the data
lock, for example:

mptcp_retransmit_timer()
    __set_bit(MPTCP_RETRANSMIT, &msk->cb_flags);

mptcp_propagate_state()
    __set_bit(MPTCP_SYNC_STATE, &msk->cb_flags);

Suppose one of these __set_bit() calls reads the word while SYNC_SEQ is
still set and writes it back after the atomic clear here. The flag then
comes back. The next consumer (another __mptcp_move_skb() or
mptcp_release_cb()) adds the IASN to copied_seq a second time.
rcvd_dummy_seq is already false, so the skb mapping is not rebased again.

Wouldn't copied_seq then be far from every skb's map_seq? Readers would
compute offset >= skb->len, skip all data, and the receive path would
stall.

The lockless test_and_clear_bit() came from "mptcp: drop the cant_coalesce
CB field", but this patch is what makes a second consumption harmful.

>  
>  		/* Be sure to sync the eventual fastopen dummy mapping before
>  		 * any other skb lands into the msk.

[ ... ]

> @@ -2426,22 +2403,20 @@ static unsigned int mptcp_inq_hint(const struct sock *sk)
>  	const struct sk_buff *skb;
>  	u64 hint_val;
>  
> -	skb = skb_peek(&sk->sk_receive_queue);
> -	if (skb) {
> -		if (test_bit(MPTCP_SYNC_SEQ, &msk->cb_flags))
> -			return skb->len - MPTCP_SKB_CB(skb)->offset;
> -
> -		hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
> -		if (hint_val >= INT_MAX)
> -			return INT_MAX;
> -
> -		return (unsigned int)hint_val;
> +	if (test_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
> +		skb = skb_peek(&sk->sk_receive_queue);
> +		return skb ? skb->len : 0;
>  	}

[Severity: Medium]

Does this over-report pending data when the TFO skb was partially read?

The old branch returned skb->len - MPTCP_SKB_CB(skb)->offset. Elsewhere,
the offset is now computed as msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq
(in __mptcp_recvmsg_mskq() and mptcp_recv_skb()). Nothing is subtracted
here.

Take a passive TFO socket where user space partially reads the TFO skb.
__mptcp_recvmsg_mskq() advances copied_seq, but the skb stays queued
because count < data_len. If the MPC third ACK arrives while the msk is
owned, subflow_set_remote_key() only sets MPTCP_SYNC_SEQ.

Until mptcp_release_cb() runs, copied_seq and the dummy map_seq are both
still in the pre-IASN space. So copied_seq - map_seq is still the amount
already consumed.

The TCP_CM_INQ cmsg in mptcp_recvmsg(), SIOCINQ in mptcp_ioctl(), and
mptcp_rcv_space_adjust() via:

	copied -= mptcp_inq_hint(sk);

would all count the bytes already read a second time. Should this return
skb->len - (msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq) instead?

>  
> -	if (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN))
> +	hint_val = READ_ONCE(msk->ack_seq) - msk->copied_seq;

[Severity: Medium]

Can this still return INT_MAX before the IASN sync?

The callers (mptcp_ioctl() for SIOCINQ, mptcp_recvmsg() for TCP_CM_INQ)
hold only lock_sock() ownership, not the msk data spinlock. Nothing
serialises this against subflow_set_remote_key() running in softirq on
another CPU:

CPU1 (owner)                          CPU2 (softirq, msk owned)
mptcp_inq_hint()
  test_bit(MPTCP_SYNC_SEQ) == 0
                                      subflow_set_remote_key()
                                        WRITE_ONCE(msk->ack_seq, iasn);
                                        smp_wmb();
                                        set_bit(MPTCP_SYNC_SEQ, ...);
  READ_ONCE(msk->ack_seq) == iasn
  hint_val = iasn - copied_seq

At that point copied_seq is still the pre-IASN value (-len plus the bytes
read). With a hash-derived iasn, hint_val is almost always >= INT_MAX,
which is the result the commit message says this patch fixes.

There is also no smp_rmb() between the flag test and the ack_seq load. The
smp_wmb() in subflow_set_remote_key() only orders the writer side.

The final patch of the series keeps the same check-then-read window, even
though the new mptcp_inq() adds an smp_rmb().

> +	if (hint_val >= INT_MAX)
> +		return INT_MAX;

[ ... ]

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index bf6ba235c268b..ebba77f05a42a 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c

[ ... ]

> @@ -559,6 +561,17 @@ static void mptcp_propagate_state(struct sock *sk, struct sock *ssk,
>  		WRITE_ONCE(msk->snd_una, subflow->idsn + 1);
>  		WRITE_ONCE(msk->wnd_end, subflow->idsn + 1 + tcp_sk(ssk)->snd_wnd);
>  		subflow_set_remote_key(msk, subflow, mp_opt);
> +	} else {
> +		/* Fallback (no MPTCP options at SYN-ACK): initialise the
> +		 * sequence space to 0 so that skb map_seq starts from 0
> +		 * to match msk->copied_seq.  Safe without deferral because
> +		 * mptcp_data_lock() is already held.
> +		 */
> +		subflow->map_seq = 0;
> +		subflow->map_subflow_seq = tcp_sk(ssk)->copied_seq -
> +					   subflow->ssn_offset;
> +		WRITE_ONCE(msk->ack_seq, 0);
> +		msk->copied_seq = 0;
>  	}

[Severity: Low]

Is the locking rationale here accurate? The commit message says:

  The writes are safe without sock_owned_by_user() deferral because
  mptcp_propagate_state() already holds mptcp_data_lock().

mptcp_data_lock() is spin_lock_bh(&sk->sk_lock.slock), and that does not
exclude a lock_sock() owner. The owner reads and writes copied_seq and
ack_seq without the spinlock in mptcp_recvmsg(), __mptcp_recvmsg_mskq(),
mptcp_inq_hint() and __mptcp_read_sock(). That is why
subflow_set_remote_key() just above defers the copied_seq update through
MPTCP_SYNC_SEQ when the msk is owned.

In practice the branch also looks like a no-op. The only caller with
mp_opt == NULL is the fallback path in subflow_finish_connect(). It runs
once per connection, on a freshly allocated or mptcp_disconnect()-reset
msk, where ack_seq, copied_seq and subflow->map_seq are already 0. Also,
subflow_check_data_avail() recomputes map_seq and map_subflow_seq for
every fallback skb.

The branch also goes against the existing "avoid updating rx path fields
otherwise" comment in the mp_opt branch. Could the branch be dropped, or
the comment and commit message corrected?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1792718041.git.tanggeliang%40kylinos.cn
