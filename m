Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795560746;
	b=Ot2qpBYp6aRyTRf6h35Xy75DzIQEL5iNrvAwUgFofog9nh8AC2kaBGPoCVPcYBDzPPYT
	 I5pWsQ3qG/AGoLhyO6woxRWeEAOW7YksbwLdjlW8i2Y7fvHPr/FDJobJo0vnXNIvrcuf5
	 t/uCj4AquVOErLE5EeamN0M/P2RTy6Sb6yvns3jqzBGlchPPL1+FIX47RblXzuPpkcEFg
	 FuPbAeZmGdknFLK7bAimwfzfiV2LsYU/qzjF7AsoA2OWCEc7xogEq8Ti5xXfGhI4HOWqo
	 TEiQW/l/HfDKpFynOT0AaNDGztFfd7VOaisOJIWqtldp3c7Y43p0MPxyvgrK1YwLqfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795560746;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LETH7OgAmG+334Ij7eNqcfK+sy6+4c8Y8aoko3Z9OGg=;
	b=pY+nE3tNCs4c4aFOK21vRKPMDxvK+e1D9rUhj8A10bWyU4CoSNzeFJfDJIWzLKts9fZS
	 /zEkbSLVIY9pXtNHKYye7itW04DsEU1wt0OdC61+uUq81pofHhtFVQhVObQgWnzK2FmF+
	 9RHQdaPJLr5k1uMx9csa2SWWP522utsSb1MtdIizi/lBlUbt4re3Kw5rZP2uRO3iEPT5c
	 +vy4rWqrwd31owMo4+cjqnSXMkUEL/ejEPO8LIEqz5Q8OHH2Wz0oVY0TUIilhpTydFbi5
	 kso3754Ru5zbBX9AXQ2W/Hn551cMQaPQEfrtIbgZWOJ21V8Q1ZYaW7tBABlMeQymtvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YcHj1m5U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2F4606A321
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YcHj1m5U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD8B1F000C4;
	Tue, 24 Nov 2026 22:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795560746;
	bh=LETH7OgAmG+334Ij7eNqcfK+sy6+4c8Y8aoko3Z9OGg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=YcHj1m5UlM2kphhB/qAqUFmX0BBaXKMtUtghIUZbJvI9gSDlSY5l4jdzj3Tu+BEip
	 KOcbiSDvto7mEAqdeoQvaJc8fWTGSBzJFbo3w1ACNMzLOlpE6oLR75d1S9jr2T3+j7
	 s1pNfoscdQFYUSQg6UMGkD6jqU4WQJ3ioO0v/i9tIn4TpQtUZWJqqGmL2dI0WrknBf
	 Q1wpu2EiLQ1OeCtMfS2pT9bx3W6z50IMaP9NqvC42FsEHpWhwHEj32jYtIm+/mckyr
	 XzLZlTFq3dJ60HWIjpnZ5MsRRvy57n5js9aqgBm0S+SLRQOE0b/Ut64lfzXgTRBQfG
	 vnOFwH1zjROSg==
Message-ID: <sashiko-outbox-232164@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next mptcp-net v3 48/50] mptcp: report errors as
 TCP does when closing
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>, "MPTCP
 Linux" <mptcp@lists.linux.dev>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-48-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
 <20261124-mptcp-cmason-fixes-v3-48-416c0920c73f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 22:52:25 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [Medium] mptcp: premature TCP_CLOSE and wakeup before
  mptcp_close_err() on timeout
- [Medium] mptcp: emulated fallback DATA_FIN on reset causes EPIPE in
  mptcp_close_last_err()
- [Medium] mptcp: missing mptcp_check_data_fin_ack() call in
  mptcp_check_rcv_close()
- [Medium] mptcp: skipped mptcp_check_rcv_close() in __mptcp_close_ssk()
  when ESTABLISHED
--

commit c9c65f9a90b8849493c3af38e75cc7959566f4e9
Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>

mptcp: report errors as TCP does when closing

This commit updates MPTCP socket closing paths to set SHUTDOWN_MASK and
propagate subflow or state-dependent socket errors when the last subflow
closes or the close timeout expires, matching tcp_done_with_error().

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/648

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 016b16b3cc925..0a7600aea181e 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -518,6 +518,56 @@ static void mptcp_close_wake_up(struct sock *sk)
>  		sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_IN);
>  }
> =20
> +/* Mirror the tcp_reset() error propagation */
> +static int mptcp_reset_err(const struct sock *sk)
> +{
> +	int err;
> +
> +	switch (sk->sk_state) {
> +	case TCP_SYN_SENT:
> +		err =3D ECONNREFUSED;
> +		break;
> +	case TCP_CLOSE_WAIT:
> +		err =3D EPIPE;
> +		break;
> +	default:
> +		err =3D ECONNRESET;
> +	}
> +
> +	return err;
> +}
> +
> +/* No more data can be exchanged: report it, as tcp_done_with_error() do=
es */
> +static void mptcp_close_err(struct sock *sk, int err)
> +{
> +	WRITE_ONCE(sk->sk_err, err);
> +	/* This barrier is coupled with smp_rmb() in mptcp_poll() */
> +	smp_wmb();
> +	WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
> +	mptcp_set_state(sk, TCP_CLOSE);
> +	if (sock_flag(sk, SOCK_DEAD))
> +		return;
> +
> +	mptcp_close_wake_up(sk);
> +	sk_error_report(sk);
> +}
> +
> +/* As TCP: the error of the last subflow, e.g. ETIMEDOUT, but after a re=
set
> + * (EBADMSG: by MPTCP) or without error, it depends on the msk state
> + */
> +static void mptcp_close_last_err(struct sock *sk, int err)
> +{
> +	switch (err) {
> +	case 0:
> +	case ECONNREFUSED:
> +	case ECONNRESET:
> +	case EPIPE:
> +	case EBADMSG:
> +		err =3D mptcp_reset_err(sk);
> +	}
> +	mptcp_close_err(sk, err);
> +}

[Severity: Medium]
Can mptcp_close_last_err() report EPIPE instead of ECONNRESET when a
fallen-back subflow is reset while mptcp_worker() holds the msk socket
lock?

When msk->first receives a TCP RST in TCP_ESTABLISHED while mptcp_worker()
holds lock_sock(sk), subflow_error_report() defers __mptcp_error_report()
via MPTCP_ERROR_REPORT, and subflow_sched_work_if_closed() sets
msk->rcv_data_fin =3D 1 and MPTCP_WORK_CLOSE_SUBFLOW because
subflow_is_done(ssk) is true on TCP_CLOSE:

net/mptcp/protocol.c:mptcp_check_data_fin() {
    ...
		/* on fallback, also emulated after a reset: check for a FIN */
		if (!__mptcp_check_fallback(msk) ||
		    (msk->first && sock_flag(msk->first, SOCK_DONE)))
			sock_set_flag(sk, SOCK_DONE);
		smp_mb__before_atomic(); /* SHUTDOWN must be visible first */

		switch (sk->sk_state) {
		case TCP_ESTABLISHED:
			mptcp_set_state(sk, TCP_CLOSE_WAIT);
			break;
    ...
}

Although mptcp_check_data_fin() avoids setting SOCK_DONE when the fallback
subflow was reset without a FIN, it still advances sk->sk_state from
TCP_ESTABLISHED to TCP_CLOSE_WAIT (or from TCP_FIN_WAIT2 to TCP_CLOSE)
before __mptcp_close_ssk() runs.  In __mptcp_close_ssk(), msk->first is
disconnected rather than disposed, so __mptcp_subflow_error_report() is
skipped and mptcp_close_last_err(sk, ECONNRESET) overwrites ECONNRESET
with mptcp_reset_err(sk) (EPIPE in TCP_CLOSE_WAIT) and wakes waiters
before release_sock(sk) runs __mptcp_error_report().  If sk was in
TCP_FIN_WAIT2, mptcp_check_data_fin() moves sk to TCP_CLOSE and wakes
waiters while sk->sk_err is still 0, and __mptcp_close_ssk() then skips
mptcp_close_last_err().

[ ... ]

> @@ -2905,13 +2957,15 @@ static void __mptcp_close_ssk(struct sock *sk, st=
ruct sock *ssk,
>  			mptcp_set_close_tout(sk, tcp_jiffies32 -
>  					     (mptcp_close_timeout(sk) + 1));
>  			mptcp_schedule_work(sk);
> +		} else if (sk->sk_state =3D=3D TCP_CLOSE) {
> +			mptcp_close_wake_up(sk);
>  		} else if (sk->sk_state !=3D TCP_ESTABLISHED ||
>  			   msk->in_accept_queue) {

[Severity: Medium]
Does gating mptcp_check_rcv_close(sk) on sk->sk_state !=3D TCP_ESTABLISHED
miss a pending DATA_FIN in msk->backlog_list (or a pending MP_FASTCLOSE)
when the last subflow closes on an accepted socket?

If the peer sends final data with DATA_FIN and closes or resets the only
subflow while mptcp_worker() holds lock_sock(sk), the incoming data sits
in msk->backlog_list while msk->rcv_data_fin is set, so
mptcp_check_data_fin() in mptcp_worker() cannot advance msk->ack_seq to
msk->rcv_data_fin_seq and leaves sk->sk_state in TCP_ESTABLISHED.  When
__mptcp_close_subflow() -> __mptcp_close_ssk() then runs on a non-fallback
socket, it skips this branch and starts the close timeout timer instead of
calling mptcp_check_rcv_close(sk) to spool the backlog, move sk to
TCP_CLOSE_WAIT, and close immediately via mptcp_close_last_err();
mptcp_release_cb() then transitions sk to TCP_CLOSE_WAIT with no subflows
left, leaving the socket to wait for the close timeout and fail with
ETIMEDOUT.

>  			mptcp_check_rcv_close(sk);
> -			mptcp_set_state(sk, TCP_CLOSE);
> -			WRITE_ONCE(sk->sk_shutdown,
> -				   sk->sk_shutdown | SEND_SHUTDOWN);
> -			mptcp_close_wake_up(sk);
> +			if (sk->sk_state =3D=3D TCP_CLOSE)
> +				mptcp_close_wake_up(sk);
> +			else
> +				mptcp_close_last_err(sk, ssk_err);
>  		} else {
>  			mptcp_start_tout_timer(sk);
>  		}

[Severity: Medium]
Should mptcp_check_rcv_close(sk) also call mptcp_check_data_fin_ack(sk)
before __mptcp_close_ssk() checks whether sk->sk_state reached TCP_CLOSE?

When an incoming DATA_ACK acknowledges our outgoing DATA_FIN in softirq,
ack_update_msk() updates msk->snd_una and schedules mptcp_worker(), which
is the only caller of mptcp_check_data_fin_ack(sk).  If __mptcp_close_ssk()
runs on the last subflow while mptcp_pending_data_fin_ack(sk) is true in
TCP_LAST_ACK, TCP_CLOSING, or TCP_FIN_WAIT1 (for example, during
mptcp_pm_worker() or when the DATA_ACK and subflow close arrive after
mptcp_check_data_fin_ack() in mptcp_worker()), mptcp_check_rcv_close(sk)
only checks rcv_data_fin and rcv_fastclose, leaving sk->sk_state !=3D
TCP_CLOSE so mptcp_close_last_err() sets ECONNRESET on a cleanly closed
connection.

[ ... ]

> @@ -3441,8 +3485,7 @@ static void mptcp_worker(struct work_struct *work)
>  		mptcp_do_fastclose(sk);
>  		mptcp_for_each_subflow_safe(msk, subflow, tmp)
>  			__mptcp_close_ssk(sk, subflow->tcp_sock, subflow, 0);
> -		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | SEND_SHUTDOWN);
> -		mptcp_close_wake_up(sk);
> +		mptcp_close_err(sk, ETIMEDOUT);
>  	}

[Severity: Medium]
Does calling mptcp_do_fastclose(sk) and __mptcp_close_ssk() before
mptcp_close_err(sk, ETIMEDOUT) wake lockless pollers and SO_ERROR readers
with sk->sk_state =3D=3D TCP_CLOSE before sk->sk_err and SHUTDOWN_MASK are =
set?

mptcp_do_fastclose(sk) sets sk->sk_state to TCP_CLOSE while sk->sk_err is
still 0 and sk->sk_shutdown does not have SHUTDOWN_MASK, and
__mptcp_close_ssk() then hits the new sk->sk_state =3D=3D TCP_CLOSE branch =
and
calls mptcp_close_wake_up(sk):

kworker                           CPU1
mptcp_worker()
  mptcp_do_fastclose(sk)
    mptcp_set_state(sk, TCP_CLOSE)
  __mptcp_close_ssk(sk, ...)
    mptcp_close_wake_up(sk)
                                  mptcp_poll() / getsockopt(SO_ERROR)
                                    state =3D=3D TCP_CLOSE
                                    sk_shutdown =3D=3D 0
                                    sk_err =3D=3D 0  <-- misses ETIMEDOUT
  mptcp_close_err(sk, ETIMEDOUT)

A thread woken from poll() or calling getsockopt(SO_ERROR) before
mptcp_close_err() runs can observe TCP_CLOSE with sk_err =3D=3D 0 and
sk_shutdown =3D=3D 0, reporting EPOLLHUP without EPOLLERR, EPOLLIN, or
EPOLLOUT and returning 0 from SO_ERROR instead of ETIMEDOUT.
mptcp_check_fastclose() similarly calls mptcp_set_state(sk, TCP_CLOSE)
before WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK) and without the
smp_wmb() after writing sk->sk_err that mptcp_close_err() uses.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-mptcp-cmas=
on-fixes-v3-0-416c0920c73f@kernel.org?part=3D48
