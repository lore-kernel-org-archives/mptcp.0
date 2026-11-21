Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795256742;
	b=z6XRJeIOSlZ/Gb8UdD7mgVAE+ZXD5pDpL6MAtO7xjpcKDJYKKovLhhbNakpj68zkLT6x
	 JwOOjyw+jRRdE6sZP085uiggFOthqatWCqZX66KBQtR4XQ8Rognw+fdq/fFyregw0TcMY
	 aRJfwgE0G67jRB+gAWvkhJ08yFRr7hQ5oKZ3OUkqnL6wNuoBxVt/svpbBGCG+tsTFujS8
	 4d1EEy5RssN9pdWtY0/X88HnSoyRbMHbMAqJzXpAPogqPoK9GwUd8aGoufZSgk/LVwLzh
	 DvR1IPPcD/Na0F5g/BPiThfXLJUwRUepckApiapjFQaKBQ2SXkyjIu4cww+UgCdWuqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795256742;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BRz8u6nG28WdcWlYMWcuwhTU79E7cBtJBo5Iu3Bf+gA=;
	b=sTnbjHKdEA8tYiSp3sRJTYAv+jKa6TmCfzOKXKWM9xqI/5tKpZuS0KtrC9bCoZu2YwF5
	 R3KvYfNkSkVU8Eqkx7503enjAYwVu1ujUoOw7N+a1asAkav5Cb9XIcIERIBtF5SAbsUbA
	 r3hh2WztglfqbM8IRE/zDmaR4RZtiy7wXe2T9OJ8FnNArUTVtd7JPDWSnznKKkBH/ySrS
	 1TzpH1jjKwApzH9qiASLp0aFPP6j6+MF6AaT3Nx4lbZYok1szOM93SgFHPC1KZRUQoJBu
	 8D2oBUwhJg2j/rClSy8cgXZl1SrJCf9HtxoBY1kuDN9Rh5gd6i39mZVLa5eR3eAdCRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fMiLoZJQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6B9606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 10:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fMiLoZJQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD361F000C0;
	Sat, 21 Nov 2026 10:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795256741;
	bh=BRz8u6nG28WdcWlYMWcuwhTU79E7cBtJBo5Iu3Bf+gA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=fMiLoZJQ5UhBsTV1IlH0Db/mrTHr/BSYARj7OlDKhjaAztRQgaVtYkYNu7EwF2a7z
	 sC3Q0ZOJiH6mb0YCsTkZ6e+dXSioBLJUnEbptybwlJr1bGcD0xXmwsHX0AUrcnSbLW
	 IlBprevnDdVVp/o0w6Sw5tiIy+Ki4C/nPh7GaK8nqRRJFLgZLea+keS1e6oG+cCeFE
	 eDAKwpUHstFaWPAAEep6UWAQQdhdxRm1aMLKfCm5QceOsKqgCjRPFkKWuAoPkPl1LT
	 nAvTOCbmdtyuEiS/HWZKO8QYLqFHejaVy/yMWDTb8abAwb/4exXD33UuhKUcieo6Db
	 uCATAXWMLz3PQ==
Message-ID: <sashiko-outbox-226939@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-net v2 15/62] mptcp: return EOF after a DATA_FIN,
 as TCP does
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>, "MPTCP
 Linux" <mptcp@lists.linux.dev>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-15-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
 <20261121-mptcp-cmason-fixes-v2-15-00327fd1de1f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 10:25:41 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] mptcp: mptcp_check_data_fin() misses SOCK_DONE after subflow
  disconnect
- [Medium] mptcp: early return in mptcp_check_fastclose() skips subflow
  close in FIN_WAIT2
--

commit b22772fa5573efd7e1960e51f06a318dfce6573b
Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>

mptcp: return EOF after a DATA_FIN, as TCP does

This commit sets SOCK_DONE on the MPTCP socket when a DATA_FIN (or a TCP FIN
after fallback) is processed and checks SOCK_DONE before sock_error() in
mptcp_recvmsg() so that a subsequent reset still returns EOF after the queu=
ed
data.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/647

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 9e297fa08bfed..91639ae0c8a02 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -714,6 +714,10 @@ static void mptcp_check_data_fin(struct sock *sk)
>  		WRITE_ONCE(msk->rcv_data_fin, 0);
> =20
>  		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | RCV_SHUTDOWN);
> +		/* on fallback, also emulated after a reset: check for a FIN */
> +		if (!__mptcp_check_fallback(msk) ||
> +		    (msk->first && sock_flag(msk->first, SOCK_DONE)))
> +			sock_set_flag(sk, SOCK_DONE);
>  		smp_mb__before_atomic(); /* SHUTDOWN must be visible first */
> =20
>  		switch (sk->sk_state) {
> @@ -972,6 +976,9 @@ static bool __mptcp_subflow_error_report(struct sock =
*sk, struct sock *ssk)
>  	 * destroy the msk as needed.
>  	 */
>  	ssk_state =3D inet_sk_state_load(ssk);
> +	/* a FIN received before still leads to EOF, as with TCP */
> +	if (sock_flag(ssk, SOCK_DONE) && mptcp_pending_data_fin(sk, NULL))
> +		sock_set_flag(sk, SOCK_DONE);
>  	if (ssk_state =3D=3D TCP_CLOSE && !sock_flag(sk, SOCK_DEAD))
>  		mptcp_set_state(sk, ssk_state);
>  	WRITE_ONCE(sk->sk_err, -err);

[Severity: Medium]
On a fallback connection, can __mptcp_close_ssk() clear SOCK_DONE on
msk->first via tcp_disconnect() before mptcp_check_data_fin() or
__mptcp_subflow_error_report() observes it?

mptcp_worker                      <softirq>
lock_sock(sk)
                                  tcp_fin(ssk)
                                    sock_set_flag(ssk, SOCK_DONE)
                                  mptcp_data_ready()
                                    __mptcp_move_skbs_from_subflow()
                                      /* queued to msk->backlog_list */
                                      subflow_sched_work_if_closed()
                                        msk->rcv_data_fin =3D 1
                                        set_bit(MPTCP_WORK_CLOSE_SUBFLOW)
                                  tcp_reset(ssk)
                                    subflow_error_report()
                                      __set_bit(MPTCP_ERROR_REPORT)
mptcp_check_data_fin(sk)
  /* backlog not spooled yet:
   * ack_seq < rcv_data_fin_seq
   */
__mptcp_close_subflow(sk)
  __mptcp_close_ssk()
    /* ssk =3D=3D msk->first: !dispose_it */
    __mptcp_subflow_disconnect()
      tcp_disconnect(ssk, 0)
        sock_reset_flag(ssk, SOCK_DONE)
    goto out;
release_sock(sk)
  mptcp_release_cb()
    __mptcp_move_skbs()
      mptcp_check_data_fin()
        sock_flag(msk->first, SOCK_DONE)  <-- false
    __mptcp_error_report()
      __mptcp_subflow_error_report()
        sock_flag(ssk, SOCK_DONE)         <-- false

Because msk->backlog_list is not spooled before mptcp_worker() runs
mptcp_check_data_fin() and __mptcp_close_subflow(), ssk->sk_receive_queue is
already empty while msk->ack_seq has not yet caught up to
msk->rcv_data_fin_seq.  __mptcp_close_ssk() then disconnects msk->first and
clears SOCK_DONE on ssk before mptcp_release_cb() processes the backlog and
MPTCP_ERROR_REPORT, leaving SOCK_DONE unset on sk so mptcp_recvmsg() returns
the reset error instead of EOF.

[ ... ]

> @@ -2938,6 +2948,11 @@ static void mptcp_check_fastclose(struct mptcp_soc=
k *msk)
>  	if (likely(!READ_ONCE(msk->rcv_fastclose)))
>  		return;
> =20
> +	/* a DATA_FIN received before still leads to EOF, as with TCP */
> +	if (READ_ONCE(msk->rcv_data_fin))
> +		mptcp_move_skbs(sk);
> +	mptcp_check_data_fin(sk);
> +
>  	mptcp_token_destroy(msk);
> =20
>  	mptcp_for_each_subflow_safe(msk, subflow, tmp) {

[Severity: Medium]
When sk is in TCP_FIN_WAIT2 and has both a pending DATA_FIN and an
MP_FASTCLOSE, does calling mptcp_check_data_fin(sk) here cause
mptcp_check_fastclose() to return early without setting
MPTCP_WORK_CLOSE_SUBFLOW?

In TCP_FIN_WAIT2, mptcp_check_data_fin(sk) calls mptcp_shutdown_subflows(ms=
k)
and mptcp_send_ack(msk) (queuing a TCP FIN and transmitting FIN/ACK segments
on subflows that are about to be reset) and transitions sk->sk_state to
TCP_CLOSE:

net/mptcp/protocol.c:mptcp_check_data_fin() {
    ...
		case TCP_FIN_WAIT2:
			mptcp_shutdown_subflows(msk);
			mptcp_set_state(sk, TCP_CLOSE);
			break;
    ...
}

After the subflow loop sends active resets and calls tcp_set_state(tcp_sk,
TCP_CLOSE), switch (sk->sk_state) in mptcp_check_fastclose() hits case
TCP_CLOSE and returns before setting MPTCP_WORK_CLOSE_SUBFLOW, leaving the
subflow sockets uncleaned on msk->conn_list until the parent MPTCP socket is
closed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121-mptcp-cmas=
on-fixes-v2-0-00327fd1de1f@kernel.org?part=3D15
