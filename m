Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793363382;
	b=MLVkXRWiluiv6bAEVakFKIpdA3bCgwKdAzv71NTmQ9AP5Wot3EKoqH5l0dpS4YgGR/iu
	 x0L009h1Pu/1urYaMn0XUx1Oo8POn0yNdE3nW7Ukm6FMhw8FRO/Ji6GmzTyQl7nSAtEjl
	 00QpJkFL01Y3qgNriMIorlFjbLFjJpfh2QRDysz9QaTOfuoYpou4thIgFcf0PuO1rzdwR
	 tv6zcLImejbUYMrc1a/eiyiUu5JqmdQ6NL4s49jO8CfA/blnLVvIrwRQLiodhSSiQUS48
	 0ZnK8sqsxho7E8kPVNucQ7b5GIK6AKn8MZaCUJseWKFvxIeQwxbRCofGmskhwQSfaag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793363382;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zIyyl73uS6V7IYj1cpqzNCXMBckqWu7G2gEIpsVq2Xo=;
	b=GTKjgYKCiarGOcxEmk7KtI88jlt9xneedGomvc9FDuOc5NJjja4WHvzOwMTTvhAa3LNa
	 8fUZbBL6qtSPNwEz1+Zjo4ucyOTh5TmNWdbZaurmRW/GRjp3NRj7OIs3hAAh/oDSvNCMk
	 J5mFZAipEr5TRSD/jI06UCEh+YOfKwO4y5GHOszARrZu+N7XMJExjRdDhufY1wo71G5iV
	 fMWlCqFmspEPyyZ6Btlu94gU4F6b10/UVXx7n1lwUnaIvHqZhqDBEwAU9ekImYGXqSRNy
	 3BjXUsVEpuTRWPt9HkhYhkLN9p1LDt01RKOiQgnAgvtbnj7nwYz9EgAp3iM9kC3ja/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kd08Z4i9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE67606A31C
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 12:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kd08Z4i9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8FD01F000C1;
	Fri, 30 Oct 2026 12:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793363382;
	bh=zIyyl73uS6V7IYj1cpqzNCXMBckqWu7G2gEIpsVq2Xo=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Kd08Z4i9qF7FtfknDNvEOp6Cg+Hr2HWKpcdtyHerG0U+/p1NyPyOhh0nwjqwpSWc/
	 poElW53HtTOZE5DYdjPXHq+O389ntAlQPOqn28p+PHydBvhEtW+MzBsJjgQzVeaS5s
	 cG2s9EEXtpEy4Nk3N8qZhY6ZN6plSHGxSuodFPssO+56g64NPd9pW0lx7u2QWazwx3
	 FuY4D86WBRvemGv+yWpUU2JS9syeCdEcxlqK9O/WdCEFBXg9uGfAs9fko5f3QV8vY0
	 jjLpW4tlx13PkPJmVyNXHQcKupnmxpDIe0LzkN7yKibzry95wzbnWwe8BEy6QVf5XP
	 3lIe0hwVkLD/Q==
Message-ID: <sashiko-outbox-191013@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v19 2/5] mptcp: drop the cant_coalesce CB
 field
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <0ad56f82094010d23ca6cb0fb8400e560ca2f454.1793361629.git.tanggeliang@kylinos.cn>
References: <cover.1793361629.git.tanggeliang@kylinos.cn>
 <0ad56f82094010d23ca6cb0fb8400e560ca2f454.1793361629.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 12:29:41 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] mptcp: unlocked MPTCP_SYNC_SEQ bitop on cb_flags in mptcp_move_s=
kbs()
- [Medium] mptcp: mptcp_inq_hint() seq mismatch when MPTCP_SYNC_SEQ is defe=
rred
- [Medium] mptcp: unreset tfo_iasn in mptcp_disconnect() corrupts passive T=
FO fallback
--

commit 6271a3eb665a4e03a0631758a5637752d3b353c9
Author: Paolo Abeni <pabeni@redhat.com>

mptcp: drop the cant_coalesce CB field

This commit removes the cant_coalesce skb control buffer field and instead
synchronizes the passive Fast Open skb sequence numbers with msk->tfo_iasn
via __mptcp_sync_rcv_sequence() when the 3rd ACK arrives or before the next
segment moves into the msk receive queue.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 528a72da646cc..e855aaa59da29 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -438,6 +436,24 @@ static void mptcp_init_skb(struct sock *ssk, struct =
sk_buff *skb, int offset,
>  	skb_dst_drop(skb);
>  }
> =20
> +void __mptcp_sync_rcv_sequence(struct sock *sk)
> +{
> +	struct mptcp_sock *msk =3D mptcp_sk(sk);
> +	struct sk_buff *skb;
> +
> +	if (likely(!msk->rcvd_dummy_seq))
> +		return;
> +
> +	/* User space can have already received the TFO skb. */
> +	msk->rcvd_dummy_seq =3D false;
> +	skb =3D skb_peek_tail(&sk->sk_receive_queue);
> +	if (!skb)
> +		return;
> +
> +	MPTCP_SKB_CB(skb)->map_seq =3D msk->tfo_iasn - skb->len;
> +	MPTCP_SKB_CB(skb)->end_seq =3D msk->tfo_iasn;
> +}

[ ... ]

> @@ -2374,6 +2396,9 @@ static bool mptcp_move_skbs(struct sock *sk)
>  	bool enqueued =3D false;
>  	u32 moved =3D 0;
> =20
> +	if (test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags))
> +		__mptcp_sync_rcv_sequence(sk);
> +
>  	mptcp_data_lock(sk);
>  	while (mptcp_can_spool_backlog(sk, &skbs)) {
>  		mptcp_data_unlock(sk);

[Severity: Medium]
As reported by Sashiko on v15 [1], can calling test_and_clear_bit() on
msk->cb_flags and __mptcp_sync_rcv_sequence() here in mptcp_move_skbs()
without holding mptcp_data_lock(sk) race with concurrent non-atomic updates
to msk->cb_flags in BH or timer contexts?

While user space holds lock_sock(sk) and runs mptcp_move_skbs() (from
mptcp_recvmsg(), mptcp_ioctl(), or mptcp_recv_skb()), the 3rd ACK can arrive
in softirq on another CPU:

  check_fully_established()
    mptcp_propagate_state()
      mptcp_data_lock(sk);
      subflow_set_remote_key()
        msk->tfo_iasn =3D subflow->iasn;
        set_bit(MPTCP_SYNC_SEQ, &msk->cb_flags);
      __set_bit(MPTCP_SYNC_STATE, &msk->cb_flags);
      mptcp_data_unlock(sk);

Other BH and timer paths (__mptcp_data_acked(), __mptcp_check_push(),
mptcp_retransmit_timer(), mptcp_finish_join(), and subflow_error_report())
also modify msk->cb_flags with non-atomic __set_bit() under
mptcp_data_lock(sk). If a BH handler loads msk->cb_flags while
MPTCP_SYNC_SEQ is set and mptcp_move_skbs() executes unlocked
test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags) before the BH CPU stores
the modified word back, the store can resurrect MPTCP_SYNC_SEQ. That causes
MPTCP_SYNC_SEQ to be processed a second time in mptcp_release_cb(), which in
the subsequent patch ("mptcp: remove CB offset field") adds msk->tfo_iasn to
msk->copied_seq twice.

In addition, because set_bit() is a relaxed atomic operation without release
semantics and mptcp_move_skbs() does not hold mptcp_data_lock(sk) here,
could __mptcp_sync_rcv_sequence() observe a stale msk->tfo_iasn on weakly
ordered architectures?

Finally, the commit message states that mptcp_move_skbs() checks
MPTCP_SYNC_SEQ at each iteration before spooling the backlog, but the check
is placed before mptcp_data_lock(sk) outside the while
(mptcp_can_spool_backlog(sk, &skbs)) loop. Should the MPTCP_SYNC_SEQ check
be moved inside the loop under mptcp_data_lock(sk) (using
__test_and_clear_bit() across all msk->cb_flags accessors)?

> @@ -3680,6 +3705,7 @@ static int mptcp_disconnect(struct sock *sk, int fl=
ags)
>  	msk->bytes_retrans =3D 0;
>  	msk->rcvspace_init =3D 0;
>  	msk->fastclosing =3D 0;
> +	msk->rcvd_dummy_seq =3D false;
>  	mptcp_init_rtt_est(msk);
> =20
>  	/* for fallback's sake */

[Severity: Medium]
Does mptcp_disconnect() also need to reset msk->tfo_iasn =3D 0 (or initiali=
ze
it in __mptcp_init_sock())?

If a client MPTCP socket connects and receives an MP_CAPABLE SYN-ACK,
subflow_set_remote_key() sets msk->tfo_iasn to subflow->iasn. If the socket
then disconnects via mptcp_disconnect() and is reused as a listener via
mptcp_listen(), child sockets created by mptcp_sk_clone_init() inherit the
non-zero msk->tfo_iasn via sk_clone_lock().

If a passive TFO connection on that listener receives a SYN with MP_CAPABLE
and data (setting msk->rcvd_dummy_seq =3D true in
mptcp_fastopen_subflow_synack_set_params()) and then falls back to TCP on
the 3rd ACK in check_fully_established() without calling
subflow_set_remote_key(), the next incoming segment in __mptcp_move_skb()
calls __mptcp_sync_rcv_sequence(sk). Because msk->tfo_iasn still holds the
previous connection's IASN instead of 0, __mptcp_sync_rcv_sequence() will
overwrite the queued TFO skb's map_seq and end_seq with the stale
msk->tfo_iasn, breaking skb coalescing and mptcp_inq_hint() (and causing
__mptcp_recvmsg_mskq() and mptcp_recv_skb() to skip the TFO payload after
the subsequent commit removing the CB offset field).

[ ... ]

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 78e886b202585..8a3ba490b5772 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -515,6 +515,8 @@ static void subflow_set_remote_key(struct mptcp_sock =
*msk,
>  				   struct mptcp_subflow_context *subflow,
>  				   const struct mptcp_options_received *mp_opt)
>  {
> +	struct sock *sk =3D (struct sock *)msk;
> +
>  	/* active MPC subflow will reach here multiple times:
>  	 * at subflow_finish_connect() time and at 4th ack time
>  	 */
> @@ -533,6 +535,12 @@ static void subflow_set_remote_key(struct mptcp_sock=
 *msk,
>  	WRITE_ONCE(msk->ack_seq, subflow->iasn);
>  	WRITE_ONCE(msk->can_ack, true);
>  	atomic64_set(&msk->rcv_wnd_sent, subflow->iasn);
> +	msk->tfo_iasn =3D subflow->iasn;
> +
> +	if (!sock_owned_by_user(sk))
> +		__mptcp_sync_rcv_sequence(sk);
> +	else
> +		set_bit(MPTCP_SYNC_SEQ, &msk->cb_flags);
>  }

[Severity: Medium]
As reported by Sashiko on v15 [2], when the 3rd ACK arrives in BH context
while user space holds lock_sock(sk), subflow_set_remote_key() updates
msk->ack_seq to subflow->iasn immediately while deferring
__mptcp_sync_rcv_sequence() via MPTCP_SYNC_SEQ. Can this cause
mptcp_inq_hint() to compute a bogus value before MPTCP_SYNC_SEQ is
processed?

In net/mptcp/protocol.c, mptcp_inq_hint() computes:

	skb =3D skb_peek(&sk->sk_receive_queue);
	if (skb) {
		u64 hint_val =3D READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;

		if (hint_val >=3D INT_MAX)
			return INT_MAX;

		return (unsigned int)hint_val;
	}

While MPTCP_SYNC_SEQ is still pending, MPTCP_SKB_CB(skb)->map_seq on the
queued TFO skb is still the dummy value (-skb->len), whereas msk->ack_seq
 has already been updated to subflow->iasn (and in the later commit
"mptcp: remove CB offset field", msk->copied_seq remains -(u64)skb->len
until MPTCP_SYNC_SEQ is processed).

This state is reachable under lock_sock(sk) in three places before
release_sock(sk) runs mptcp_release_cb():

1. mptcp_recvmsg() -> __mptcp_recvmsg_mskq() -> mptcp_rcv_space_adjust()
   calls mptcp_inq_hint(sk) before mptcp_move_skbs(sk), underflowing
   copied -=3D mptcp_inq_hint(sk).
2. In mptcp_recvmsg(), mptcp_move_skbs(sk) is only called when
   !list_empty(&msk->backlog_list); if the 3rd ACK carries no data payload,
   backlog_list is empty and the TCP_CM_INQ cmsg path calls
   mptcp_inq_hint(sk) with MPTCP_SYNC_SEQ still pending, reporting INT_MAX
   (or a corrupted value based on subflow->iasn) to user space.
3. In mptcp_ioctl(SIOCINQ), if the 3rd ACK arrives in BH after
   mptcp_move_skbs(sk) checks MPTCP_SYNC_SEQ and before mptcp_inq_hint(sk)
   reads msk->ack_seq, SIOCINQ likewise returns a bogus value.

[1] https://lore.kernel.org/r/25f42bae1af43649a5c89ca10cfe0d962941c6f7.1792=
718041.git.tanggeliang@kylinos.cn
[2] https://lore.kernel.org/r/25f42bae1af43649a5c89ca10cfe0d962941c6f7.1792=
718041.git.tanggeliang@kylinos.cn

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793361629.gi=
t.tanggeliang@kylinos.cn?part=3D2
