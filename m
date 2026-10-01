Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8775F5335A4
	for <mptcp@lists.linux.dev>; Thu,  1 Oct 2026 21:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790889131; cv=none; b=eEt3uUm7myzHQncfV2FhIhdysGWWrGCiSqony1/8ArSSk61+AacTZPZG788/iTkyP5NAbFJ3y0kEh4lhhGB3IKT7AgpzH7xGO980SyUfusKnEwrCkqrJvBIcIVaymMMzywlOXG2X7fVRiYBMpXTALT9fMn4FTpQ9g1eYy4q+cOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790889131; c=relaxed/simple;
	bh=WZEOziP/qDruJxHA2m+KXcvxrrlwDwKRoz05ca7PBls=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uq0v+WDK3shN9ZEYirTSjbZznPsoQMIljEh30omgRPVitEGWkGH9vtdYeNu6i10OQwMlvA0zK5AO9uUHe62a/6nMYZbymYN8Ri/Fz26nnnyOqxU/S1DLcF7qlI7tK3lRttjQwVDn3GsaQL/wHNxBmvwP2vMCh789JpW/m3vyc1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9VoR27i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9VoR27i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE96C1F00893;
	Thu,  1 Oct 2026 21:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790889129;
	bh=kRXQJ+Cbc1TNG2ljCRb6V7Wa4z3oPg7Q/KmNtwr0mBw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=X9VoR27i1YHrkkHXEIF05JqI1LeKWLmXSSBvuUuIkps57oxaoQVJ+8IdZ6rAkxtpm
	 qpIPbD1Vvf3LlZyMVIhsyV95YuCg447zBZhrHy2EpFD6t14jXpQtCSk7/MoYAZiid/
	 tCYNcJZlciAi89E0DZVFrYj1Dv+6Nv1atP81I3z1V3MO+2vjZxXkoFRdz9gAKBpYdV
	 4Y2s4HYToiAKILtUSfLoVaBqo+cOnlqfinabY5ZGnuXE/gt518vJmn5Dg6lXtcGY8F
	 4EFi/uKUdL2n+O13ra0RZpMCjvGCMWwk53eyrbymh2T8EZfO2VjYWktFBhHA7QWcKd
	 EX9DV8SMft0oQ==
Subject: Re: [PATCH mptcp-next v14 03/11] mptcp: remove CB offset field
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc:
 mptcp@lists.linux.dev, pabeni@redhat.com, yangang@kylinos.cn, kuba@kernel.org
Date: Thu, 01 Oct 2026 21:12:08 +0000
Message-ID: <179088912855.3135.8778318093596413008@kernel.org>
In-Reply-To: =?utf-8?q?=3C204c34dd358a267a7cf38fdae211120e25895c9d=2E1790734?=
 =?utf-8?q?083=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3C204c34dd358a267a7cf38fdae211120e25895c9d=2E17907340?=
 =?utf-8?q?83=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 2 (1) · Medium: 0 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] mptcp_init_skb() now sets MPTCP_SKB_CB(skb)->map_seq =
  mptcp_subflow_get_mapped_dsn(subflow) - offset and end_seq = map_seq +…
- [High] This patch makes a lost clear of MPTCP_SYNC_SEQ harmful by doing
  a non-idempotent `msk->copied_seq += mptcp_iasn(msk)` each time the…
- [Low] mptcp_iasn() computes the IASN as ack_seq - bytes_received +
  tfo_skb_len.
- [Low] The commit message says "Prior to this patch, the TFO skb dummy
  mapping was always ignored".
- [Low] The new `else` branch in mptcp_propagate_state() is justified in
  the commit message as preventing an "offset calculation underflow in…
- [Low] In mptcp_propagate_state(), the comment on the `if (mp_opt)`
  branch reads "Options are available only in the non fallback cases…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it remains
  reachable in the fallback path this patch reworks.

--

mptcp: remove CB offset field

This patch removes the per-skb MPTCP_SKB_CB offset field. In its place,
a msk-level copied_seq tracks how many bytes user space has consumed,
similar to TCP. The TFO dummy mapping is resynced through a new
mptcp_iasn() helper, and a new fallback branch in mptcp_propagate_state()
zeroes the sequence space.

> Prior to this patch, the TFO skb dummy mapping was always ignored, now it
> affects the `copied_seq` initial update: be sure to extends the sign
> correctly of such mapping initialization time.

[Severity: Low]

Is this accurate? Before this patch,
mptcp_fastopen_subflow_synack_set_params() set:

	MPTCP_SKB_CB(skb)->map_seq = -skb->len;

This is a 32-bit negation zero-extended to u64 (2^32 - len), and
mptcp_inq_hint() used it:

	hint_val = msk->ack_seq - MPTCP_SKB_CB(skb)->map_seq;

On a passive TFO child before the MPC ACK (ack_seq still 0), this gives a
huge value, so SIOCINQ and TCP_CM_INQ returned INT_MAX.

This patch fixes that user-visible behaviour, through both the
-(u64)skb->len change and the new ack_seq - copied_seq hint. Should the
commit message say so, possibly with a Fixes: tag?

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 1d3f29240387e..845fcca361fa0 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -415,8 +414,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
>  	skb_set_owner_r(skb, sk);
>  }
>  
> -static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
> -			   int copy_len)
> +static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset)
>  {
>  	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
>  	bool has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
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

[Severity: High]

Can this give the wrong DSNs to the first offset bytes of the skb?

mptcp_subflow_get_mapped_dsn() returns the DSN for tp->copied_seq within
the current mapping. Subtracting offset gives DSNs to head bytes the
subflow has already consumed. That is only correct if those head bytes
belong to the same mapping as the rest of the skb.

Nothing seems to guarantee that. validate_mapping() checks only
tp->copied_seq against the mapping, never TCP_SKB_CB(skb)->seq. Also,
tcp_data_queue() queues partially overlapping segments
(seq < rcv_nxt < end_seq) without trimming them.

For example, take mapping M1 covering SSN 0..100 / DSN 1000..1100, already
consumed. A segment then arrives covering SSN 50..200 but carrying only
the DSS for M2 (SSN 100.., DSN 1300..1400). It would get:

    before: map_seq = 1300, end_seq = 1400, offset = 50
    after:  map_seq = 1250, end_seq = 1400

__mptcp_move_skb() then computes copy_len = skb->len = 150. What happens
next depends on msk->ack_seq:

- ack_seq == 1250: the skb is treated as in-sequence and coalesced into
  the tail, since the from->offset check in __mptcp_try_coalesce() is
  gone.
- ack_seq in (1250, 1300): the skb takes the partial path.
- ack_seq < 1250: the skb goes to the OFO queue, where
  mptcp_data_queue_ofo() can drop a genuine [1250, 1300) segment as
  "all bits present".

In each case, would the stale SSN 50..100 bytes (real DSN 1050..1100) reach
user space through __mptcp_recvmsg_mskq() as DSN 1250..1300? ack_seq would
also move past DSNs whose data was never received. That data would later
be dropped as DUPDATA, and since it is already acked, the peer would not
retransmit it.

Linux senders don't produce such segments, but a middlebox, another stack
or a crafted peer could. The pre-patch code handled this case through the
cb offset. The same calculation is still there at the end of the series
(map_seq64 = mapped_dsn - offset).

[Severity: High]

This isn't a bug introduced by this patch, but a related problem remains
in the fallback path this patch reworks.

The fallback dummy mapping built in subflow_check_data_avail() pairs:

    map_subflow_seq = SSN of tp->copied_seq
    map_seq         = DSN of TCP_SKB_CB(skb)->seq

So mptcp_subflow_get_mapped_dsn() returns the DSN of the skb start, not
the DSN of the first unread byte.

Take a partially overlapping skb on a fallback subflow, for example a
retransmission after ACK loss that GRO merged. Then
offset = copied_seq - skb->seq > 0, and mptcp_init_skb() subtracts offset
a second time:

    map_seq = DSN(start) - offset
    ack_seq = DSN(start) + offset

Would __mptcp_move_skb() then take the partial path with
copy_len = len - 2 * offset, losing bytes [offset, 2 * offset)? When
len <= 2 * offset, it would drop the skb as old data instead.

ack_seq would also end up offset bytes short of the real DSN. Every later
skb would then sit in the OFO queue forever, and TCP has already acked the
data, so nothing fills the gap and the fallback connection stalls.

The pre-patch code had the same effective result. However, the new
mapped_dsn - offset calculation relies on mapped_dsn referring to
copied_seq, which this fallback map doesn't provide. The new
mptcp_propagate_state() fallback branch doesn't address this either.

>  	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
>  
>  	__skb_unlink(skb, &ssk->sk_receive_queue);

[ ... ]

> @@ -470,6 +466,8 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
>  		smp_rmb();
>  
>  		mptcp_data_lock(sk);
> +		msk->copied_seq += mptcp_iasn(msk);

[Severity: High]

Is this addition safe if MPTCP_SYNC_SEQ is consumed twice?

__mptcp_move_skb() clears the flag before taking the data lock:

	if (test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
		smp_rmb();
		mptcp_data_lock(sk);

It is called from mptcp_move_skbs() and from the mptcp_release_cb() loop,
in both cases after the data lock has been dropped. Meanwhile, other CPUs
modify the same cb_flags word under the data lock with non-atomic
read-modify-write operations. Examples are __set_bit() in
__mptcp_check_push() and __mptcp_data_acked(), both reached from
ack_update_msk(), and cb_flags |= BIT(...) in
mptcp_check_and_set_pending().

CPU1 (softirq, data lock held)      CPU0 (msk owner)
ack_update_msk()
  __mptcp_check_push()
    load cb_flags (SYNC_SEQ set)
                                    __mptcp_move_skb()
                                      test_and_clear_bit(MPTCP_SYNC_SEQ)
                                      mptcp_data_lock() spins
    store old cb_flags | PUSH_PENDING
    (SYNC_SEQ set again)
    mptcp_data_unlock()
                                      copied_seq += mptcp_iasn(msk)

The next __mptcp_move_skb() call, or the final section of
mptcp_release_cb(), would then see the flag again and add the IASN to
copied_seq a second time. The rcvd_dummy_seq check protects only
__mptcp_sync_rcv_sequence(), not this addition.

Before this patch, a lost clear did no harm because the sync was
idempotent. With copied_seq off by a full IASN, __mptcp_recvmsg_mskq()
would compute offset >= skb->len for every skb and skip all of them.
Could that stall receives permanently? At the end of the series the
offset is truncated to u32, so it could instead land inside an skb and
copy from the wrong position.

[ ... ]

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index cfc86d00ab2f1..3b42c5e22acf2 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h

[ ... ]

> @@ -880,6 +881,11 @@ struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
>  int mptcp_sched_get_send(struct mptcp_sock *msk);
>  int mptcp_sched_get_retrans(struct mptcp_sock *msk);
>  
> +static inline u64 mptcp_iasn(const struct mptcp_sock *msk)
> +{
> +	return msk->ack_seq - msk->bytes_received + msk->tfo_skb_len;
> +}

[Severity: Low]

Does this still hold after a DATA_FIN has been accounted? mptcp_iasn()
assumes ack_seq and bytes_received always advance together. However,
mptcp_check_data_fin() does:

	WRITE_ONCE(msk->ack_seq, msk->ack_seq + 1);

and leaves bytes_received unchanged.

Consider a passive TFO msk where mptcp_worker() owns the socket:

- The MPC third ACK arrives, and subflow_set_remote_key() sets
  MPTCP_SYNC_SEQ because the msk is owned.
- A DATA_FIN at DSN == IASN arrives.
- The worker reaches mptcp_check_data_fin() and moves ack_seq to
  iasn + 1.

When the worker releases the lock, the deferred sync in mptcp_release_cb()
adds iasn + 1 to copied_seq, instead of the stored subflow->iasn.

Reads stay consistent, because __mptcp_sync_rcv_sequence() shifts the TFO
skb by the same amount. However, ack_seq - copied_seq ends up one short.

Would mptcp_inq_hint() then lose the FIN's +1? Later in the series,
mptcp_inq() and peek_len subtract 1 for SOCK_DONE, so could they report 0
while one TFO byte is still unread?

[ ... ]

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 807f6c5bbcf8d..a8247f5fe3e0a 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c

[ ... ]

> @@ -524,6 +526,14 @@ static void mptcp_propagate_state(struct sock *sk, struct sock *ssk,
>  		WRITE_ONCE(msk->snd_una, subflow->idsn + 1);
>  		WRITE_ONCE(msk->wnd_end, subflow->idsn + 1 + tcp_sk(ssk)->snd_wnd);
>  		subflow_set_remote_key(msk, subflow, mp_opt);
> +	} else {
> +		/* Fallback: initialize sequence space to 0 (no remote key) */
> +		subflow->map_seq = 0;
> +		/* ensure mptcp_subflow_get_map_offset() returns 0 */
> +		subflow->map_subflow_seq = tcp_sk(ssk)->copied_seq -
> +					   subflow->ssn_offset;
> +		WRITE_ONCE(msk->ack_seq, 0);
> +		msk->copied_seq = 0;
>  	}

[Severity: Low]

Is this branch needed? The commit message says it prevents an "offset
calculation underflow in fallback mode", but I couldn't find a case where
these writes change anything.

mptcp_propagate_state() is only called from subflow_finish_connect(), at
SYN-ACK time. At that point msk->ack_seq and msk->copied_seq are already
0. They are zeroed at allocation, and mptcp_disconnect() resets them
(this patch adds copied_seq to that reset). subflow->map_seq is also 0,
because subflow_set_remote_key() never ran.

In addition, the fallback branch of subflow_check_data_avail() recomputes
map_subflow_seq and map_seq for every skb before mptcp_init_skb() uses
them.

In which scenario does the underflow actually happen?

[Severity: Low]

This isn't a bug, but the comment right above, on the mp_opt branch,
says:

	/* Options are available only in the non fallback cases
	 * avoid updating rx path fields otherwise
	 */

The new else branch updates exactly those rx path fields:
subflow->map_seq, subflow->map_subflow_seq, msk->ack_seq and
msk->copied_seq.

It also writes msk->copied_seq without the sock_owned_by_user() deferral
that subflow_set_remote_key() uses. That doesn't match the commit message
statement that copied_seq "is always accessed under the msk socket lock".

Should the comment be updated, or the branch dropped?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1790734083.git.tanggeliang%40kylinos.cn
