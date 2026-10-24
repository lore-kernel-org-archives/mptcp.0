Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792859169;
	b=x5REeIWIIzX/rylYhXZVLp3Rd/3etNRLvTRfu6B3B2zmDqDFdwPTDDR/UK0K4ykZUOz7
	 ysiWwITRCnp4R1lREHaOyYLnerY5FT+13E9mp4iB76+WTKjFwY3JMVlQk7fObpNoZpL1h
	 z//nblvNCJxRcx8OGuOkLx+3CNdlH0CuL4aeOZSvsPlgi9M0L912eU6JZ4oRpy8TY59yo
	 tW3EjGoH5TxHp+RXd1WlhAn+nRbuRrXAn5LCZBdNo6lszYTGOhiP4ZS6FEH9K3GELZZLT
	 LxV5pQnuHXBF0U2NoICoXODLKyZLO3KC5j36Zrqp5isF5Bv3uxsDzDqiYFwMJYBctaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792859169;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=CGvq6IQuKOA+RweYWPDR6T+M7ECKnIF7WlfneZkeaZk=;
	b=izS/+pYMNVVLfTJN+xQ+H8wvtxPo03RhzdKcwyBiLPW/PgjavQx3xaSOoA/WmrhxNBSt
	 KuGY3PCkB2AiUEX4vvNUBJjv2yl5MJNOFJe7KY32AWqkSXZA6QlELZouBJ1Xpt29P+QeC
	 YApQWk9CSuIeCd4Dpw0vDR7OB7pukB6zwmi2RXk/93ATlyUfpw1J2dNYzR5hms/nD+Pwr
	 spNDOE7wUzQdJv/UxkKuI5Pk1trEJd7BSHKlcQMDo/9/+bThEz6KOD7mBFVUNENPrNigy
	 zv7g9ccf9y03UcDcKJ6++tStiD7/T43YFU2bZm5JZOcPjAVVinUKm8HyH52ZLULgt3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AeKfaWTo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD10606A328
	for <mptcp@lists.linux.dev>; Sat, 24 Oct 2026 16:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AeKfaWTo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80AA61F031E0;
	Sat, 24 Oct 2026 16:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792859168;
	bh=CGvq6IQuKOA+RweYWPDR6T+M7ECKnIF7WlfneZkeaZk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AeKfaWTod6dXhZgKnGeAXtPCw2WGxLN8C12RTpsdqikhDzRKk6BMNMbsufm1Uy/D2
	 J2GvrwO3/JZZTJiO94z8iK7chFuxKxfG7X+thrHiVcRqQIrely6Uiv1DH8C6fCK/jw
	 eM9kadrLfgJF/Kpo/L5i/T8LzlY5/JgHTQLBS0wAG/+fyhS9stCVab/2VMqtZ6dHuZ
	 w3Sn3C2FlhZAkApTQ/6o1a7br5Drbxc2sSeyFIOGv3AsCWVtre3y8uJDtPWLHAtKd7
	 i5LzrYjP6CJBMw/WUiNy0pU0OAJ6qhe1FsYFBcJjnT4NNU4Q+HArMwrn/8LFXjQs9u
	 j+CzEj8mh/0Vw==
Subject:
 Re: [PATCH mptcp-next v15 02/11] mptcp: drop the cant_coalesce CB field
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, yangang@kylinos.cn, kuba@kernel.org
Date: Sat, 24 Oct 2026 16:26:08 +0000
Message-ID: <179285916805.3132.9421264349916344261@kernel.org>
In-Reply-To: =?utf-8?q?=3C25f42bae1af43649a5c89ca10cfe0d962941c6f7=2E1792718?=
 =?utf-8?q?041=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3C25f42bae1af43649a5c89ca10cfe0d962941c6f7=2E17927180?=
 =?utf-8?q?41=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 1 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] __mptcp_move_skb() (net/mptcp/protocol.c:468) runs
  `test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)` in process…
- [Medium] In this commit, the passive TFO dummy mapping is still wrong
  when user space reads before the IASN is known.
- [Low] The commit message says the patch trades the cant_coalesce check
  in __mptcp_try_coalesce() for 'a similar one in __mptcp_move_skb()'.
- [Low] The concern is that the commit message does not disclose the
  user-visible change to mptcp_inq_hint() (TCP_INQ cmsg / SIOCINQ) for…
- [Low] The new per-connection flag msk->rcvd_dummy_seq is set only in
  mptcp_fastopen_subflow_synack_set_params() (fastopen.c:58).
- [Low] __mptcp_sync_rcv_sequence() is documented with '/* Caller must
  hold the msk data lock */' (protocol.c:439), but __mptcp_move_skb()…

--

mptcp: drop the cant_coalesce CB field

This patch removes the cant_coalesce skb CB field, which kept the passive
TFO skb from being coalesced. Instead, the TFO skb sequence numbers are
rewritten once the IASN is known at 3rd ack time. If the msk is owned by
the user at that point, the sync is deferred through a new MPTCP_SYNC_SEQ
cb_flags bit that __mptcp_move_skb() and mptcp_release_cb() consume.

> diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
> index f717750906ffa..e18b31028e7e3 100644
> --- a/net/mptcp/fastopen.c
> +++ b/net/mptcp/fastopen.c

[ ... ]

> @@ -49,15 +50,16 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
>  	MPTCP_SKB_CB(skb)->end_seq = 0;
>  	MPTCP_SKB_CB(skb)->offset = 0;
>  	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
> -	MPTCP_SKB_CB(skb)->cant_coalesce = 1;
>  
>  	mptcp_data_lock(sk);
>  	DEBUG_NET_WARN_ON_ONCE(sock_owned_by_user_nocheck(sk));
>  
> +	msk = mptcp_sk(sk);
> +	msk->rcvd_dummy_seq = true;

[Severity: Low]
This is the only place rcvd_dummy_seq is set. The only place it is cleared
is __mptcp_sync_rcv_sequence(), and that needs subflow_set_remote_key() to
run first. Suppose the passive TFO connection falls back at the 3rd ack
in check_fully_established():

	if (!(mp_opt->suboptions & OPTIONS_MPTCP_MPC)) {
		...
		subflow->mp_capable = 0;
		if (!mptcp_try_fallback(ssk, MPTCP_MIB_MPCAPABLEDATAFALLBACK)) {
			...
		}
		return false;
	}

The remote key never arrives, so the flag stays true.

Should mptcp_disconnect() also reset rcvd_dummy_seq? It resets cb_flags,
can_ack, fully_established, bytes_received, ack_seq and other
per-connection state, but not the new field.

__mptcp_init_sock() and mptcp_sk_clone_init() don't reset it either. So
after connect(AF_UNSPEC) and then listen(), sk_clone_lock() copies the
stale value into every child.

Today this looks harmless: on non-TFO connections the receive queue is
empty at every sync point, so the helper only clears the flag. Still,
__mptcp_sync_rcv_sequence() takes the flag to mean the queue tail is the
TFO skb.

At the end of the series, mptcp_disconnect() resets tfo_skb_len and
copied_seq, but rcvd_dummy_seq is still not reset.

>  	mptcp_borrow_fwdmem(sk, skb);

[ ... ]

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 528a72da646cc..96deaed109a2f 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -438,6 +436,27 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
>  	skb_dst_drop(skb);
>  }
>  
> +/* Caller must hold the msk data lock */
> +void __mptcp_sync_rcv_sequence(struct sock *sk)

[Severity: Low]
Is this comment accurate? __mptcp_move_skb() calls this helper from paths
where the data lock has already been dropped:

mptcp_move_skbs()
    mptcp_data_unlock(sk);
    __mptcp_move_skbs()
        __mptcp_move_skb()
            __mptcp_sync_rcv_sequence()

It does the same from the mptcp_release_cb() loop, after
spin_unlock_bh(&sk->sk_lock.slock).

On those paths the helper reads and writes msk->rcvd_dummy_seq and
rewrites the CB of the receive queue tail while holding only socket
ownership. That seems safe in practice, because BH writers don't touch
the receive queue while the msk is owned. The comment still doesn't
match the callers.

Would "caller must hold the msk data lock or own the msk socket" be more
accurate? The same comment and caller layout are still present at the
end of the series.

[ ... ]

> @@ -446,6 +465,17 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
>  
>  	mptcp_borrow_fwdmem(sk, skb);
>  
> +	if (test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {

[Severity: High]
Can this lockless atomic clear race with the non-atomic cb_flags writers?

Here __mptcp_move_skb() runs in process context without the msk data
lock. It is reached from mptcp_move_skbs() after mptcp_data_unlock(),
and from the mptcp_release_cb() loop after spin_unlock_bh().

The other cb_flags writers use non-atomic RMWs under the data lock while
the msk is owned, for example:

mptcp_propagate_state()
    __set_bit(MPTCP_SYNC_STATE, &msk->cb_flags);

__mptcp_data_acked()
    __set_bit(MPTCP_CLEAN_UNA, &mptcp_sk(sk)->cb_flags);

The MPTCP_ERROR_REPORT, MPTCP_PUSH_PENDING, MPTCP_RETRANSMIT and
MPTCP_FLUSH_JOIN_LIST writers work the same way.

Before this patch, every cb_flags change except the owner-side reset in
mptcp_disconnect() happened under the data lock. So the __ ops had the
word to themselves.

One possible interleaving:

CPU1 (BH, data lock held)          CPU2 (owner, no data lock)
__set_bit(X): load cb_flags
  (MPTCP_SYNC_SEQ set)
                                   test_and_clear_bit(MPTCP_SYNC_SEQ)
store old | X
  (MPTCP_SYNC_SEQ set again)

Once the bit is back, mptcp_inq_hint() takes the new early return and
reports only the head skb length for TCP_INQ and SIOCINQ.

Some architectures (parisc, sparc32) implement atomic bitops with hashed
spinlocks. There the BH bit could be lost instead, which would drop a
deferred push, error report, state sync or clean_una.

At the end of the series, both places that consume MPTCP_SYNC_SEQ, in
__mptcp_move_skb() and mptcp_release_cb(), do:

	msk->copied_seq += mptcp_iasn(msk);

A resurrected bit then adds the IASN twice. mptcp_recv_skb() would
compute an offset past skb->len and could discard queued skbs.
__mptcp_recvmsg_mskq() would compute a bogus offset and data_len.

Could MPTCP_SYNC_SEQ be consumed under the data lock instead, for example
in mptcp_can_spool_backlog() or before the lock is dropped? Another
option would be to keep this state outside the shared cb_flags word.

> +		/* Ensure we see the updated ack_seq after seeing the flag */
> +		smp_rmb();
> +
> +		/* Be sure to sync the eventual fastopen dummy mapping before
> +		 * any other skb lands into the msk.
> +		 */
> +		if (unlikely(msk->rcvd_dummy_seq))
> +			__mptcp_sync_rcv_sequence(sk);
> +	}

[Severity: Low]
The commit message says:

  Performance wise this trades a conditional in the fast path - in
  __mptcp_try_coalesce() - with a similar one in __mptcp_move_skb()

Is the new check really similar? The test_and_clear_bit() above is an
unconditional, fully ordered atomic RMW on the shared cb_flags word. It
runs for every skb moved into the msk, on both the
__mptcp_move_skbs_from_subflow() path and the backlog __mptcp_move_skbs()
path. The old check was a plain read of a byte in the cache-hot skb->cb.

subflow_set_remote_key() also sets the bit whenever the msk is owned by
the user, even when rcvd_dummy_seq is false:

	} else {
		/* Ensure ack_seq is visible before setting the flag */
		smp_wmb();
		set_bit(MPTCP_SYNC_SEQ, &msk->cb_flags);
	}

So non-TFO connections take this path too.

Would doing a test_bit() before the test_and_clear_bit(), or checking
rcvd_dummy_seq first, match the description better? The atomic RMW is
still there at the end of the series.

[ ... ]

> @@ -2394,11 +2424,14 @@ static unsigned int mptcp_inq_hint(const struct sock *sk)
>  {
>  	const struct mptcp_sock *msk = mptcp_sk(sk);
>  	const struct sk_buff *skb;
> +	u64 hint_val;
>  
>  	skb = skb_peek(&sk->sk_receive_queue);
>  	if (skb) {
> -		u64 hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
> +		if (test_bit(MPTCP_SYNC_SEQ, &msk->cb_flags))
> +			return skb->len - MPTCP_SKB_CB(skb)->offset;

[Severity: Low]
This isn't a bug, but this changes what user space sees through the
TCP_INQ cmsg and SIOCINQ on passive TFO sockets. The commit message only
covers it indirectly ("the user-space will always observe consistent
sequence numbers in the receive queue"), and there is no Fixes: tag.

Would it be worth describing the mptcp_inq_hint() change in the commit
message? The later commit "mptcp: remove CB offset field" in this series
does document the inq_hint behaviour explicitly. Since this is net-next
refactoring, leaving out the Fixes: tag may be intentional.

>  
> +		hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
>  		if (hint_val >= INT_MAX)
>  			return INT_MAX;

[Severity: Medium]
Can a passive TFO skb still reach this INT_MAX return before the 3rd
ack?

mptcp_fastopen_subflow_synack_set_params() still does:

	MPTCP_SKB_CB(skb)->map_seq = -skb->len;

skb->len is an unsigned int, so this negates in 32 bits and then
zero-extends into the u64 map_seq. The result is 2^32 - len, not
-(u64)len.

Until the 3rd ack, msk->ack_seq is 0. MPTCP_SYNC_SEQ is only set by
subflow_set_remote_key(), so the early return above is not taken. The
code then computes 0 - (2^32 - len) and returns INT_MAX. That value
reaches TCP_CM_INQ, SIOCINQ through mptcp_ioctl(), and
mptcp_rcv_space_adjust().

A second case is a 3rd ack without MPC, which makes the connection fall
back in check_fully_established(). subflow_set_remote_key() never runs,
so rcvd_dummy_seq is never cleared.

Fallback data maps to map_seq 0, which equals ack_seq. With the
cant_coalesce check gone, __mptcp_try_coalesce() merges that data into
the TFO skb, whose end_seq is 0:

	if (MPTCP_SKB_CB(from)->map_seq != MPTCP_SKB_CB(to)->end_seq ||
	    MPTCP_SKB_CB(from)->offset ||

The bogus map_seq then covers more data, so the INT_MAX result applies
to more data.

The INT_MAX value before the 3rd ack already existed before this patch.
The extra coverage after fallback is new here. Both cases seem to
conflict with the commit message:

  After this change the user-space will always observe consistent
  sequence numbers in the receive queue, even in the TFO dummy mapping
  case.

The later commit "mptcp: remove CB offset field" in this series seems to
fix both cases. It sets map_seq64 to -(u64)skb->len and computes the hint
as ack_seq - copied_seq.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1792718041.git.tanggeliang%40kylinos.cn
