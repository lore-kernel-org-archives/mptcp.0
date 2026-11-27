Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795811963;
	b=z9ZggXKoJxFTahiBa0XbHe7uJ1x+QugF4jOD91argxgk8Uk4O3lhJ35VALLepqBly3nQ
	 BfwzaQnEd+XTve2KmvjQbRPkoDnPfrkbG4waIIlynyctjbRpWuGOf4fbJMb09dwyaRlkE
	 ILB4QxnPKY9WjTsrYmxrlkFkXcPjxa6vy/q7KNSiigy+jRhKtdTTGUf/LnVa85oFPuG+i
	 nFP1HQ3POdtaxAkByJ1LIOXKX2TK8Z3JIc+e/asfferSexgnCvBiLUq1c2EvvAV7qxJgZ
	 fHG/Mh+S0orEOu1sWZYcng5iRHXKWvLJou0NTUccTiZQxNr7cSCdb5yW9i46RDHUaiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795811963;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=37FaiEa+TNgU5bZpWXGXXR/BJ1kEljL7dDQkGL5QEKs=;
	b=Aa/P94IEv01da4L2a/9dwKrGPAFBbPnOa9UILAVo65uphS1v+YuBD2+KbpZ8sfGqHTJw
	 ZJ7YI2n38NiotRRsBhECpI1pR9lVpWIceP1QwBKfQkEmiq/h+UtXkhiZG5RgJfR6Q4nQ8
	 /S3x8ZOqzHrJawRE6Wib+nlFxMwAUavPL+dZD4uekS4nlKJz/bf5MREoinJHbGUwLPpZq
	 cXa7ZUOBOhkyKwsXNgeKAwRp9XA1Nz0D3gw19v0aACVlq8dLzMhwinaT5tmGfzY0ynNwl
	 E/pbTPJXH20COqOunfKR0rxh434kNv4/WhqjAKmQDZz8ukYqpbqbR2iSigG2J+RzC1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EzGaSR1p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8430A606A31C
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 20:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EzGaSR1p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9AC31F000C1;
	Fri, 27 Nov 2026 20:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795811962;
	bh=37FaiEa+TNgU5bZpWXGXXR/BJ1kEljL7dDQkGL5QEKs=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=EzGaSR1pClyN0Qx0cJ5lwt6J1up2VZakay0P0KMg7nGeK7uraq5PMRTVQmxl6TRNH
	 MVJHridISx1xN6CC4qj9eZNG6m+zimXpo6fgOBBegdPmzyfMk87OUSKrs4gY54+30f
	 nLPbdjx2CK4QQXWMiLS3jgNctnE/0c9psvftvMxfuHJqNJgeFhwQKo1gMaAvKHnWcq
	 HN0JFVzn7annnb3LveVeyGXLSbokAI5RvuoZd4rSSVSG6STeikUStHoDJ2kKL9F+tZ
	 S8Wct4EdGkeEslrT6ej2uXohv8iLddyPYVRWbrY1Iit8W9kj5B9zwNK78vCcss9eOr
	 fRW4ud2tOs04w==
Message-ID: <sashiko-outbox-238268@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next mptcp-net v4 17/20] mptcp: report errors as
 TCP does when closing
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>, "MPTCP
 Linux" <mptcp@lists.linux.dev>
In-Reply-To: <20261127-mptcp-cmason-fixes-v4-17-3f393ea8c48d@kernel.org>
References: <20261127-mptcp-cmason-fixes-v4-0-3f393ea8c48d@kernel.org>
 <20261127-mptcp-cmason-fixes-v4-17-3f393ea8c48d@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 20:39:22 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] mptcp: missing mptcp_check_rcv_close() in __mptcp_close_ssk()
  when ESTABLISHED
- [Medium] mptcp: dummy DATA_FIN on fallback reset causes EPIPE in
  __mptcp_close_ssk()
- [Medium] mptcp: premature TCP_CLOSE and wakeup before
  mptcp_close_err() on timeout
--

commit 6ce8d717af5ad3fbd6c9029fe140c704cbd41b8e
Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>

mptcp: report errors as TCP does when closing

This commit updates MPTCP socket closure on close timeouts and last-subflow
closure outside TCP_ESTABLISHED to set SHUTDOWN_MASK and report errors based
on the last subflow error and MPTCP socket state, matching TCP behavior.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/648

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 64fc04ea997c8..d8661fba643a9 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -2818,7 +2868,7 @@ static void __mptcp_close_ssk(struct sock *sk, stru=
ct sock *ssk,
>  {
>  	struct mptcp_sock *msk =3D mptcp_sk(sk);
>  	bool dispose_it, need_push =3D false;
> -	int fwd_remaining;
> +	int fwd_remaining, ssk_err;
> =20
>  	/* Do not pass RX data to the msk, even if the subflow socket is not
>  	 * going to be freed (i.e. even for the first subflow on graceful
> @@ -2826,6 +2876,8 @@ static void __mptcp_close_ssk(struct sock *sk, stru=
ct sock *ssk,
>  	 */
>  	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
>  	subflow->closing =3D 1;
> +	/* in case it is the last subflow: before its disconnect or dispose */
> +	ssk_err =3D READ_ONCE(ssk->sk_err);

[Severity: Medium]
On a fallback socket, if msk->first is closed by a TCP RST without a prior
FIN while mptcp_worker() holds lock_sock(sk), can this report EPIPE instead
of ECONNRESET and then report the error a second time on release_sock(sk)?

When the reset arrives in softirq while sk is owned, subflow_error_report()
defers MPTCP_ERROR_REPORT to mptcp_release_cb() (leaving ssk->sk_err set to
ECONNRESET), and subflow_sched_work_if_closed() emulates a dummy DATA_FIN
because ssk->sk_state is TCP_CLOSE.  Before __mptcp_close_ssk() runs,
mptcp_check_data_fin() processes that dummy rcv_data_fin and moves
sk->sk_state from TCP_ESTABLISHED to TCP_CLOSE_WAIT (or from TCP_FIN_WAIT2
to TCP_CLOSE) even when SOCK_DONE is not set on msk->first:

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

In __mptcp_close_ssk(), dispose_it is false for msk->first, so it jumps to
out: without calling __mptcp_subflow_error_report().  In TCP_CLOSE_WAIT,
mptcp_close_last_err(sk, ECONNRESET) then maps ECONNRESET through
mptcp_reset_err(sk) to EPIPE (or in TCP_FIN_WAIT2 finds sk->sk_state
already in TCP_CLOSE and wakes waiters with sk_err =3D=3D 0).  Because
ssk->sk_err was only read with READ_ONCE() and not consumed,
mptcp_release_cb() later runs __mptcp_error_report(sk), which consumes
ssk->sk_err, overwrites sk->sk_err with ECONNRESET, and calls
sk_error_report(sk) a second time.

[ ... ]

> @@ -2914,13 +2966,17 @@ static void __mptcp_close_ssk(struct sock *sk, st=
ruct sock *ssk,
>  			mptcp_set_close_tout(sk, tcp_jiffies32 -
>  					     (mptcp_close_timeout(sk) + 1));
>  			mptcp_schedule_work(sk);
> +		} else if (sk->sk_state =3D=3D TCP_CLOSE) {
> +			mptcp_close_wake_up(sk);
>  		} else if (sk->sk_state !=3D TCP_ESTABLISHED ||
>  			   msk->in_accept_queue) {
>  			mptcp_check_rcv_close(sk);
> -			mptcp_set_state(sk, TCP_CLOSE);
> -			WRITE_ONCE(sk->sk_shutdown,
> -				   sk->sk_shutdown | SEND_SHUTDOWN);
> -			mptcp_close_wake_up(sk);
> +			/* the ack of our DATA_FIN might not be processed yet */
> +			mptcp_check_data_fin_ack(sk);
> +			if (sk->sk_state =3D=3D TCP_CLOSE)
> +				mptcp_close_wake_up(sk);
> +			else
> +				mptcp_close_last_err(sk, ssk_err);
>  		} else {
>  			mptcp_start_tout_timer(sk);
>  		}

[Severity: Medium]
Does gating mptcp_check_rcv_close(sk) behind sk->sk_state !=3D TCP_ESTABLIS=
HED
miss a pending DATA_FIN or MP_FASTCLOSE when the last subflow of an
accepted, non-fallback socket closes?

If final data with DATA_FIN and a subflow close arrive in softirq while
mptcp_worker() holds lock_sock(sk), the data sits in msk->backlog_list, so
mptcp_check_data_fin() in mptcp_worker() cannot advance msk->ack_seq to
msk->rcv_data_fin_seq and sk->sk_state stays TCP_ESTABLISHED (the same
happens if DATA_FIN or MP_FASTCLOSE arrives after mptcp_worker() has
already run mptcp_check_fastclose() and mptcp_check_data_fin()).  Because
mptcp_close_ssk() only spools the backlog beforehand when
__mptcp_check_fallback(msk) is true, __mptcp_close_ssk() sees
sk->sk_state =3D=3D TCP_ESTABLISHED, skips mptcp_check_rcv_close(sk) and
mptcp_close_last_err(), and starts the close timeout timer instead.  When
release_sock(sk) subsequently drains msk->backlog_list via
mptcp_release_cb() -> __mptcp_move_skbs(), mptcp_check_data_fin() moves
sk->sk_state to TCP_CLOSE_WAIT after subflow->close_event_done is already
set, leaving the socket stranded in TCP_CLOSE_WAIT with no subflows until
the close timeout expires and reports ETIMEDOUT instead of EPIPE.

Calling mptcp_check_rcv_close(sk) before checking sk->sk_state in the
all-subflows-closed block would process the queued DATA_FIN or fastclose
first.

[ ... ]

> @@ -3450,8 +3496,7 @@ static void mptcp_worker(struct work_struct *work)
>  		mptcp_do_fastclose(sk);
>  		mptcp_for_each_subflow_safe(msk, subflow, tmp)
>  			__mptcp_close_ssk(sk, subflow->tcp_sock, subflow, 0);
> -		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | SEND_SHUTDOWN);
> -		mptcp_close_wake_up(sk);
> +		mptcp_close_err(sk, ETIMEDOUT);
>  	}

[Severity: Medium]
When the close timeout expires here, doesn't __mptcp_close_ssk() wake
pollers after mptcp_do_fastclose() sets TCP_CLOSE but before
mptcp_close_err() publishes ETIMEDOUT and SHUTDOWN_MASK?

kworker (mptcp_worker)            CPU1
----------------------            ----
mptcp_do_fastclose(sk)
  mptcp_set_state(sk, TCP_CLOSE)
__mptcp_close_ssk(...)
  if (sk->sk_state =3D=3D TCP_CLOSE)
    mptcp_close_wake_up(sk)
                                  mptcp_poll() / getsockopt(SO_ERROR)
                                    state =3D=3D TCP_CLOSE
                                    sk_shutdown =3D=3D 0
                                    sk_err =3D=3D 0  <-- misses ETIMEDOUT
mptcp_close_err(sk, ETIMEDOUT)
  WRITE_ONCE(sk->sk_err, ETIMEDOUT)
  smp_wmb()
  WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK)

Because mptcp_poll() and sk_getsockopt(SO_ERROR) run without locking sk,
a waiter woken by __mptcp_close_ssk() can see EPOLLHUP without EPOLLERR,
EPOLLIN or EPOLLOUT, and read SO_ERROR =3D=3D 0 instead of ETIMEDOUT.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-mptcp-cmas=
on-fixes-v4-0-3f393ea8c48d@kernel.org?part=3D17
