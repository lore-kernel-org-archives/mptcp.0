Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793498530;
	b=fXtyKAJhbgqUNzQfdJw63CCUm+dIaTsLMQhjx1YGw5ziQZwaMupj6ciiCHQgcWCAJTJF
	 rdpZEK/HSc3bdk6DVgkeh18A057PvRdc/PZ1qiO6kpbrF3eHJms9SQEIA9vQTqFKwk3FH
	 dGG99UnrvUtITJO4FuyoqbuSCmyoGJ/1XAtS41j1BeU/wC8/vtPs1+Q5Gkyri/Ow7AAGs
	 Em2zPgp42ziqaXIHRf8rhaXegQXctWG3D4m9fiaLUOdkKImEYHxJYKohoQ0WrUW9hurxt
	 fvkvz6Oh3r2QyDrCG/u+X8aU2gKVPctyy+JXbQUYceVs9QeHEDvrvPu3ls74c/Q3sxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793498530;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=UkdD2WsPf6Anxv2EFJ8JHrB81dhlKTd5C2ciC+pmiq0=;
	b=qLi1hXQ3SJf8jnJyxF0DhB2XXzs7abPen6Yjh2Zh5crhhwdzB8tu1AP8F2zyWlCe1oHs
	 l1Xe3INIlyjUiGYOffgqLiM96n2R1nRnb0P5V0mO3yOo8m1boks3qp3e5tVfEv1j/M/o6
	 yPihtSUisXgRMUWrsY15oIdwo+dMWW9SDoq0MzP2bhBpUA/pyYd1PpCfhrxcDHDfPPMVy
	 OMZGKmSlEN4kDpmhhdK1WUv/KcqdK88FnI5oRJL0+MDWdj1cshCZnWAtWD49iu6I2RxQa
	 GxPt1oCHWWi3uY4N+7U0kZynXmEFtvOT5eMgXGvrTEru8/2L8og7OveZJNmO/L1UJGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hqq5NIyf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9165606A324
	for <mptcp@lists.linux.dev>; Sun,  1 Nov 2026 02:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hqq5NIyf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40EB41F00919;
	Sun,  1 Nov 2026 02:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793498529;
	bh=UkdD2WsPf6Anxv2EFJ8JHrB81dhlKTd5C2ciC+pmiq0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hqq5NIyf1R9y0MeVm8Hr20CeOXGK6132pQ62fDN2SmwpRQh1dfngxnEWog+5Rf5Ck
	 Q0vUU89AiT8SsIRIbbwk/sDZXU9Hmf1DijrIJ0qmmnedNUbPNq33W1GQg+dPnq3AS+
	 n3KT0xgiO7WvvGRueIRu7PE7yEW+gbD0EJgQlvljCKLPpHHKFP0sRX3oLclu2B04/w
	 qURvNOwp7MAYHQtSlL/du0Kf79l8Lnug6pWp6m5Zpd1wyLImCXncpaNrFv5g3zDujH
	 qkbrilaXMheEXO6dUgvBBUtR4pyzKTUAP9fss0nkurp2sVMJ0HX1kkXCjTp0ADBaJ+
	 j2xxbc9BFkJ8Q==
Subject: Re: [PATCH mptcp-next v19 3/5] mptcp: remove CB offset field
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, pabeni@redhat.com,
 kuba@kernel.org
Date: Sun, 01 Nov 2026 02:02:08 +0000
Message-ID: <179349852881.3128.15180409820938701147@kernel.org>
In-Reply-To: =?utf-8?q?=3C1dac839fffd26114e35382b256fdee9923c0949b=2E1793361?=
 =?utf-8?q?629=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3C1dac839fffd26114e35382b256fdee9923c0949b=2E17933616?=
 =?utf-8?q?29=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
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

Thank you for your contribution! Sashiko AI review found 9 potential
issue(s) to consider.

Critical: 0 · High: 3 · Medium: 2 (1) · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] mptcp_init_skb() now sets map_seq =
  mptcp_subflow_get_mapped_dsn(subflow) - offset.
- [High] mptcp_move_skbs() runs `test_and_clear_bit(MPTCP_SYNC_SEQ,
  &msk->cb_flags)` and the new non-idempotent `msk->copied_seq +=…
- [High] The commit message says the patch fixes SIOCINQ/TCP_CM_INQ
  returning INT_MAX for TFO sockets, but the ack_seq/copied_seq pair can…
- [Medium] After this patch, recvmsg delivery depends on msk->copied_seq
  agreeing with the TFO skb's map_seq.
- [Medium] The commit message does not describe the change that actually
  makes fallback work, and credits the fix to a hunk that does nothing…
- [Low] The commit message says it fixes a user-visible bug: before the
  MPC ACK, SIOCINQ/TCP_CM_INQ return INT_MAX on passive TFO sockets…
- [Low] The commit message says the new `copied_seq` field 'is always
  accessed under the msk socket lock'.
- [Low] In mptcp_propagate_state() the comment on the mp_opt branch
  (subflow.c:557-559) still says "Options are available only in the non…
- [Low] The new fallback branch of mptcp_propagate_state() writes
  msk->ack_seq and msk->copied_seq (copied_seq as a plain u64 store)…

Pre-existing issues:
- [Medium] MPTCP SIOCINQ returns mptcp_inq_hint() directly.

--

mptcp: remove CB offset field

This patch drops the offset field from the MPTCP skb control block. It adds
msk->copied_seq to track how much of each skb has been consumed, similar to
TCP, so that map_seq now covers the subflow-level offset and the inq hint
becomes ack_seq - copied_seq. It also changes the fallback dummy mapping in
subflow_check_data_avail() and sets the rx sequence space to 0 in the
mptcp_propagate_state() fallback branch.

> diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
> index e18b31028e7e3..78481c100e2ab 100644
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
The commit message says this fixes a user-visible bug. On passive TFO
sockets, SIOCINQ and TCP_CM_INQ return INT_MAX before the MPC ACK because
of the zero-extended u32 negation added in commit 36b122baf6a8. Should
this have a Fixes: tag?

Right now the fix is folded into a refactor that depends on the new
msk->copied_seq field and on the previous patch in the series ("mptcp:
drop the cant_coalesce CB field"). Stable trees can't take it on its own.
Would a small standalone fix work better?

[ ... ]

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index e855aaa59da29..3f967c4dc825f 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

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

[Severity: High]
Can this give the wrong DSNs to bytes that belong to an earlier DSS
mapping?

The new map_seq assumes the first offset bytes of the skb, which the
subflow has already consumed, belong to the current mapping. However,
get_mapping_status() deliberately accepts an skb that spans two mappings:

net/mptcp/subflow.c:get_mapping_status() {
    ...
	/* will validate the next map after consuming the current one */
	goto validate_csum;
    ...
}

Suppose the tail of mapping M0 inside the skb is a duplicate. Then:

subflow_check_data_avail()
  mptcp_subflow_discard_data()
    tp->copied_seq moves to the end of M0, map_valid = 0
  M1 (from the skb ext, which was never deleted) is installed
__mptcp_move_skbs_from_subflow()
  mptcp_init_skb(ssk, skb, k)    /* k > 0 */

The skb now covers [M1.dsn - k, M1.dsn - k + len). If the M0 and M1 DSNs
are not contiguous (for example, M0 is a reinjection of old data), the k
stale M0 bytes show up as stream data [M1.dsn - k, M1.dsn).

For example, take ack_seq = A, M1.dsn = A + 10 and k = 30. The partial
packet path in __mptcp_move_skb() is taken (map_seq = A - 20). It inserts
the skb in sequence and moves ack_seq to A + 80. The reader starts at
copied_seq - map_seq = 20 and returns ten M0 bytes as DSN [A, A + 10).
The real [A, A + 10) data is then dropped as completely old data.

If M1.dsn - k > ack_seq instead, mptcp_data_queue_ofo() gets the wrong
range. It can then drop the real data for [M1.dsn - k, M1.dsn) as
MPTCP_MIB_DUPDATA and deliver the stale bytes later.

The old code kept map_seq = mapped_dsn plus a separate CB offset, so the
discarded prefix was never part of the skb DSN range. The last patch in
the series ("mptcp: sync mptcp skb cb layout with tcp one") keeps the
same mapped_dsn - offset scheme, so this doesn't look fixed later on.

>  	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
>  
>  	__skb_unlink(skb, &ssk->sk_receive_queue);
> @@ -451,7 +449,7 @@ void __mptcp_sync_rcv_sequence(struct sock *sk)
>  		return;
>  
>  	MPTCP_SKB_CB(skb)->map_seq = msk->tfo_iasn - skb->len;
> -	MPTCP_SKB_CB(skb)->end_seq = msk->tfo_iasn;
> +	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + skb->len;
>  }

[Severity: Medium]
What happens here when msk->tfo_iasn holds a stale value?

Three callers of __mptcp_sync_rcv_sequence() now pair it with
copied_seq += tfo_iasn. The call in __mptcp_move_skb() does not:

	if (unlikely(msk->rcvd_dummy_seq))
		__mptcp_sync_rcv_sequence(sk);

That is only correct when tfo_iasn is 0. tfo_iasn is written only in
subflow_set_remote_key() and is never reset. That includes
mptcp_disconnect() (which this patch changes to reset copied_seq),
__mptcp_init_sock() and mptcp_sk_clone_init(). As a result,
sk_clone_lock() copies the listener's value into every child.

One possible sequence:

- a socket completes an MPC connection (tfo_iasn = X), is disconnected
  with connect(AF_UNSPEC), and then calls listen() with TFO enabled
- a child receives SYN + data with a valid cookie, so copied_seq =
  map_seq = -(u64)len and rcvd_dummy_seq = true
- the peer's third ACK carries no MPC option, so the child falls back
  and subflow_set_remote_key() never runs
- the next data skb goes through __mptcp_move_skb(), which moves the TFO
  skb's map_seq to X - len while copied_seq stays at -len

In __mptcp_recvmsg_mskq() the TFO skb's offset is now -X and the next
skb's offset is -len. Both are >= skb->len, so every skb is skipped as
already peeked and receiving stalls for good. On the read_sock path,
mptcp_recv_skb() eats the skbs and the data is lost.

Before this patch, delivery used the CB offset, so a stale map_seq did
not block reads. This is still present at the end of the series.

[ ... ]

> @@ -2396,8 +2376,10 @@ static bool mptcp_move_skbs(struct sock *sk)
>  	bool enqueued = false;
>  	u32 moved = 0;
>  
> -	if (test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags))
> +	if (test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
> +		msk->copied_seq += msk->tfo_iasn;
>  		__mptcp_sync_rcv_sequence(sk);
> +	}
>  
>  	mptcp_data_lock(sk);

[Severity: High]
Can MPTCP_SYNC_SEQ be set again after this clear, so that tfo_iasn gets
added twice?

test_and_clear_bit() runs here before mptcp_data_lock() is taken. Softirq
code updates the same cb_flags word with the non-atomic __set_bit(),
holding only the data lock, when it sees the msk owned:

__mptcp_data_acked()
	__set_bit(MPTCP_CLEAN_UNA, &mptcp_sk(sk)->cb_flags);

__mptcp_check_push()
	__set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->cb_flags);

mptcp_propagate_state()
	__set_bit(MPTCP_SYNC_STATE, &msk->cb_flags);

A possible interleaving:

CPU1 (softirq, ACK)               CPU2 (msk owner)
load cb_flags (SYNC_SEQ set)
                                  test_and_clear_bit(MPTCP_SYNC_SEQ)
                                  msk->copied_seq += msk->tfo_iasn;
store old | CLEAN_UNA
  (SYNC_SEQ set again)
                                  release_sock()
                                    mptcp_release_cb()
                                      msk->copied_seq += msk->tfo_iasn;

By then __mptcp_sync_rcv_sequence() does nothing because rcvd_dummy_seq
is already false, so copied_seq stays off by a random 64-bit IASN. After
that:

- __mptcp_recvmsg_mskq() sees offset >= skb->len for every skb and
  receiving stalls
- mptcp_recv_skb() eats the skbs and their data is lost
- mptcp_inq_hint() returns garbage

Before this patch a repeated sync did no harm, but the new += is not
idempotent. subflow_set_remote_key() sets MPTCP_SYNC_SEQ for any MPC
connection whose key arrives while the msk is owned, not only for TFO.

There is also no ordering between the plain store to msk->tfo_iasn and
set_bit() in subflow_set_remote_key(), and the owner reads tfo_iasn here
outside the data lock. This is still present at the end of the series.

[ ... ]

> @@ -2418,22 +2400,17 @@ static bool mptcp_move_skbs(struct sock *sk)
>  static unsigned int mptcp_inq_hint(const struct sock *sk)
>  {
>  	const struct mptcp_sock *msk = mptcp_sk(sk);
> -	const struct sk_buff *skb;
> -
> -	skb = skb_peek(&sk->sk_receive_queue);
> -	if (skb) {
> -		u64 hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
> +	u64 hint_val;
>  
> -		if (hint_val >= INT_MAX)
> -			return INT_MAX;
> +	hint_val = READ_ONCE(msk->ack_seq) - READ_ONCE(msk->copied_seq);
> +	if (hint_val >= INT_MAX)
> +		return INT_MAX;

[Severity: High]
Can ack_seq and copied_seq be in different sequence spaces when this
subtraction runs?

When the msk is owned, subflow_set_remote_key() publishes ack_seq
immediately but defers the copied_seq rebase:

	WRITE_ONCE(msk->ack_seq, subflow->iasn);
	...
	} else {
		set_bit(MPTCP_SYNC_SEQ, &msk->cb_flags);
	}

Take a passive TFO socket with TCP_INQ enabled, sitting in
mptcp_recvmsg(). The MPC ACK carries no payload, so backlog_list stays
empty, and it arrives while __mptcp_recvmsg_mskq() is copying the TFO
data. recvmsg skips mptcp_move_skbs() because the backlog is empty and
breaks on copied >= target. At out_err the hint is then:

    iasn - (-len + copied)

That is roughly the random 64-bit IASN, so INT_MAX goes into the
TCP_CM_INQ cmsg. mptcp_rcv_space_adjust() subtracts the same bogus hint.

mptcp_ioctl(SIOCINQ) has a similar window. The key can arrive in softirq
after mptcp_move_skbs() returns and before mptcp_inq_hint() runs. Active
non-TFO connections whose SYN-ACK is processed while the msk is owned
can hit it too.

The commit message says:

  This patch fixes that behaviour through both the -(u64)skb->len
  sign fix and the new ack_seq - copied_seq hint.

Should the ack_seq update be deferred together with copied_seq, or
should the hint read both values consistently? Later patches in the
series don't change this.

>  
> -		return (unsigned int)hint_val;
> -	}
> -
> -	if (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN))
> +	if (!hint_val &&
> +	    (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN)))
>  		return 1;

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch, but
mptcp_ioctl(SIOCINQ) returns mptcp_inq_hint() directly. That keeps the
TCP_CM_INQ style EOF behaviour: ack_seq includes the DATA_FIN byte, and a
drained socket that is closed or has RCV_SHUTDOWN reports 1.

So a drained, closed MPTCP socket reports one readable byte via SIOCINQ.
tcp_ioctl(SIOCINQ) uses tcp_inq(), which subtracts the FIN. The old
queue-based helper behaved the same way.

Should SIOCINQ use a helper that matches tcp_inq() here?

>  
> -	return 0;
> +	return (unsigned int)hint_val;
>  }

[ ... ]

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 8a3ba490b5772..71c3b148cf04a 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c

[ ... ]

> @@ -557,6 +559,13 @@ static void mptcp_propagate_state(struct sock *sk, struct sock *ssk,
>  		WRITE_ONCE(msk->snd_una, subflow->idsn + 1);
>  		WRITE_ONCE(msk->wnd_end, subflow->idsn + 1 + tcp_sk(ssk)->snd_wnd);
>  		subflow_set_remote_key(msk, subflow, mp_opt);
> +	} else {
> +		/* Fallback (no MPTCP options at SYN-ACK) */
> +		subflow->map_seq = 0;
> +		subflow->map_subflow_seq = tcp_sk(ssk)->copied_seq -
> +					   subflow->ssn_offset;
> +		WRITE_ONCE(msk->ack_seq, 0);
> +		msk->copied_seq = 0;
>  	}

[Severity: Low]
Does the safety argument in the commit message hold for these writes?

  The writes are safe
  without sock_owned_by_user() deferral because mptcp_propagate_state()
  already holds mptcp_data_lock().

mptcp_data_lock() is sk_lock.slock, and the owner does not hold it while
it owns the socket. This branch runs in softirq from the fallback label
in subflow_finish_connect(). An owner in recvmsg() with TCP_INQ, or in
SIOCINQ on a connecting socket, could read copied_seq while this plain
u64 store happens.

Today the store is always 0 over 0, so nothing goes wrong. If copied_seq
could be nonzero here, this would be an unsynchronized lost update, or a
torn store on 32-bit.

[Severity: Low]
Along the same lines, the commit message says the newly introduced
copied_seq field "is always accessed under the msk socket lock". This
write holds only mptcp_data_lock() and has no owner check.

The actual rule seems to be that either the owner holds lock_sock(), or
softirq holds the slock after checking !sock_owned_by_user(), as
subflow_set_remote_key() does. Could the commit message say that
instead?

[Severity: Low]
This isn't a bug, but the comment at the top of the mp_opt branch still
says:

		/* Options are available only in the non fallback cases
		 * avoid updating rx path fields otherwise
		 */

The new else branch updates exactly those rx path fields in the fallback
case (subflow->map_seq, subflow->map_subflow_seq, msk->ack_seq and
msk->copied_seq). Should the comment be updated?

[ ... ]

> @@ -1493,7 +1502,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
>  	skb = skb_peek(&ssk->sk_receive_queue);
>  	subflow->map_valid = 1;
>  	subflow->map_data_len = skb->len;
> -	subflow->map_subflow_seq = tcp_sk(ssk)->copied_seq - subflow->ssn_offset;
> +	subflow->map_subflow_seq = TCP_SKB_CB(skb)->seq - subflow->ssn_offset;

[Severity: Medium]
The commit message doesn't mention this change, but it looks like the one
that makes fallback work with the new mptcp_init_skb() arithmetic.
map_subflow_seq is now anchored at TCP_SKB_CB(skb)->seq, which matches
subflow->map_seq (also computed from skb->seq). The mapped_dsn - offset
formula in mptcp_init_skb() depends on that pairing.

It also seems to fix an older fallback bug. With the old pairing, a
partially overlapping skb (seq < rcv_nxt < end_seq, not trimmed by TCP)
got the DSN of skb->seq while the CB offset already skipped offset bytes.
The partial packet path in __mptcp_move_skb() then skipped the same
amount again, which lost data or dropped the skb as old.

The commit message credits the mptcp_propagate_state() hunk instead:

  Initialize MPTCP sequence space to 0 in mptcp_propagate_state() when mp_opt
  is NULL, ensuring SKB's map_seq starts from 0 to match msk->copied_seq and
  prevent offset calculation underflow in fallback mode.

The only caller that passes a NULL mp_opt is the fallback label in
subflow_finish_connect(). It runs on the active side before any data is
received. At that point msk->ack_seq, msk->copied_seq and
subflow->map_seq are already 0. The map_subflow_seq written there is
overwritten by the next MAPPING_DUMMY pass in
subflow_check_data_avail().

Could the commit message describe this subflow_check_data_avail() change
instead? Should the older fallback fix also get its own Fixes: tag?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793361629.git.tanggeliang%40kylinos.cn
