Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795257013;
	b=CAUSVRdxF8i24j/M944BceH6ByLrhe17s4JT7qYHfhHfkIs+Ar1DlzOj/+8SLidD17H3
	 Sh6JvhKNj4sw3/tboZtuAFnTJWA30P2XDXeDm2Q0DU526uHFqhw7QA+sO3qMqmXqD5Itu
	 ycuzyBJUEqlwlYD4Kz+ML4MpjMb/lfx91B+Ie6LmSE6V4yd7AGBSCYdZWXWo9uvpMQcKL
	 FRhhJUvy8euLJO3spRnMqBN5LuahsvmK4r55e30E2e73KgBHenOShLLAkTdLvyrZ9tka7
	 c4eJ7BSH7lw5dKhMF2zWn8aFVg+R04+CKL6pSIyuBGUdEbmamykWlrkt/Ckt8JWEWGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795257013;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CFR2Aut3TXiSUhYNK88t1NJ+2VCpD97wmLJMRNaNfQc=;
	b=bUZTTvZGTimqszMgS4lya/bjd2ThtkzpfZOlTW5wqKaX4i1K/64Hl2YUdJLHJvmMPAuO
	 HFVWpSYLOiii+iMf35FE6i2WNi3LvpxGkTlI0JKKdVRax3HZ/TQr5420TcA30LDdb4zGb
	 Vike8UNNLCR+0kOTISieem8Uq+K8ChOAFE4gSs1LB19N8iAuQWYLwo6SROuGj/FFTiz6N
	 wrHpAp2d8DjhJnNz35PfngylHt0PYe2bNkabXPqYypuSXjRKJqdqSk5eNFisyaANFQgdq
	 tgFfhJhldA/1g66ZEWA3DH73OSi94B6DYSdBUGVofKm45AV25YscniFhBwwUT2OyQVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oYfl6wtq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C458606A325
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 10:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oYfl6wtq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F3D1F000C0;
	Sat, 21 Nov 2026 10:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795257013;
	bh=CFR2Aut3TXiSUhYNK88t1NJ+2VCpD97wmLJMRNaNfQc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=oYfl6wtqmJEf4K6DsknQTpcoMoiVWquYCBfKdNqKNkhuUSKSSvPNrVttullluf2tS
	 LYgB86VessLQj3fQ0XiCqv5A7Oy3QKSFIeRZpyxOdfhlZYOcCytXVvt/FUW5hBOF0Z
	 ME+igtxFB9sKRAOhtFGjMgDrpaCsC2xSYHDaGUPj/Ou17X5d59X5RbnD7IqfuUVyVl
	 x/mLDaHJhO+Y7f9vWUduKbqYW5raetQAWUx0FoE/6K/X6dSYC7+z2AKoC80gD4DaB0
	 tivcLR+yWqavdLqEW8LdYMPwVBLXgb3KVx8HMM6b5h9o5B3aMBL6EU47LBxaUbi1s8
	 WkPnnKmwIOaRA==
Message-ID: <sashiko-outbox-226941@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next mptcp-net v2 61/62] mptcp: report errors as
 TCP does when closing
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>, "MPTCP
 Linux" <mptcp@lists.linux.dev>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-61-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
 <20261121-mptcp-cmason-fixes-v2-61-00327fd1de1f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 10:30:12 +0000
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
- [Medium] mptcp: tcp_disconnect() clears SOCK_DONE before
  mptcp_check_rcv_close()
- [Medium] mptcp: dummy fallback DATA_FIN changes state before
  mptcp_close_last_err()
- [Medium] mptcp: missing mptcp_check_data_fin_ack() before
  mptcp_close_last_err()
--

commit 0c5fc2bb3f82340912e87636cc6d5fef891b87cb
Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>

mptcp: report errors as TCP does when closing

This commit updates MPTCP socket closure on close timeouts and last-subflow
closure to set SHUTDOWN_MASK and populate sk_err based on the subflow error
or MPTCP socket state, matching tcp_done_with_error().

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/648

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 1088caa788f60..5733ab548d12d 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

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
Can a fallback socket closed by a clean FIN report EPIPE or ECONNRESET
from recv() instead of EOF here?

When ssk is msk->first and dispose_it is false, earlier in
__mptcp_close_ssk() the call to __mptcp_subflow_disconnect() ->
tcp_disconnect() clears SOCK_DONE on msk->first.  When
mptcp_check_rcv_close() then drains the backlog and calls
mptcp_check_data_fin(), sock_flag(msk->first, SOCK_DONE) is already false:

net/mptcp/protocol.c:mptcp_check_data_fin() {
    ...
		/* on fallback, also emulated after a reset: check for a FIN */
		if (!__mptcp_check_fallback(msk) ||
		    (msk->first && sock_flag(msk->first, SOCK_DONE)))
			sock_set_flag(sk, SOCK_DONE);
    ...
}

Because SOCK_DONE is not copied to sk, and mptcp_close_last_err() then sets
sk->sk_err to EPIPE or ECONNRESET (when sk transitions to TCP_CLOSE_WAIT or
TCP_CLOSING), mptcp_recvmsg() sees !sock_flag(sk, SOCK_DONE) and returns
the error instead of 0.

[Severity: Medium]
Does calling mptcp_check_rcv_close() without also checking
mptcp_check_data_fin_ack() cause a cleanly closed connection to report
ECONNRESET?

If sk is in TCP_LAST_ACK, TCP_CLOSING, or TCP_FIN_WAIT1 and the peer's
DATA_ACK acknowledging our DATA_FIN has already updated msk->snd_una in
softirq before __mptcp_close_ssk() runs, mptcp_check_rcv_close() only
checks rcv_data_fin and rcv_fastclose.  Without mptcp_check_data_fin_ack()
advancing sk->sk_state to TCP_CLOSE (or to TCP_FIN_WAIT2 before
mptcp_check_data_fin() moves it to TCP_CLOSE), sk->sk_state !=3D TCP_CLOSE
remains true and mptcp_close_last_err() sets sk->sk_err to ECONNRESET even
though the DATA_FIN handshake completed cleanly.

Also, because this branch is skipped when sk->sk_state =3D=3D TCP_ESTABLISH=
ED,
an accepted socket in TCP_ESTABLISHED that receives final data, DATA_FIN
(or MP_FASTCLOSE), and subflow close in its backlog while locked by
mptcp_worker() will skip mptcp_check_rcv_close() and start the close
timeout timer instead of processing the backlog and closing immediately.

> @@ -3085,20 +3139,10 @@ static void mptcp_check_fastclose(struct mptcp_so=
ck *msk)
>  		unlock_sock_fast(tcp_sk, slow);
>  	}
> =20
> -	/* Mirror the tcp_reset() error propagation */
> -	switch (sk->sk_state) {
> -	case TCP_SYN_SENT:
> -		WRITE_ONCE(sk->sk_err, ECONNREFUSED);
> -		break;
> -	case TCP_CLOSE_WAIT:
> -		WRITE_ONCE(sk->sk_err, EPIPE);
> -		break;
> -	case TCP_CLOSE:
> +	if (sk->sk_state =3D=3D TCP_CLOSE)
>  		return;
> -	default:
> -		WRITE_ONCE(sk->sk_err, ECONNRESET);
> -	}
> =20
> +	WRITE_ONCE(sk->sk_err, mptcp_reset_err(sk));
>  	mptcp_set_state(sk, TCP_CLOSE);
>  	WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
>  	smp_mb__before_atomic(); /* SHUTDOWN must be visible first */
> @@ -3416,8 +3460,7 @@ static void mptcp_worker(struct work_struct *work)
>  		mptcp_do_fastclose(sk);
>  		mptcp_for_each_subflow_safe(msk, subflow, tmp)
>  			__mptcp_close_ssk(sk, subflow->tcp_sock, subflow, 0);
> -		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | SEND_SHUTDOWN);
> -		mptcp_close_wake_up(sk);
> +		mptcp_close_err(sk, ETIMEDOUT);
>  	}

[Severity: Medium]
Can a thread in mptcp_poll() or getsockopt(SO_ERROR) be woken on close
timeout before mptcp_close_err() publishes ETIMEDOUT and SHUTDOWN_MASK?

kworker                               CPU1
mptcp_worker()
  mptcp_do_fastclose(sk)
    mptcp_set_state(sk, TCP_CLOSE)
  __mptcp_close_ssk(sk, ...)
    if (sk->sk_state =3D=3D TCP_CLOSE)
      mptcp_close_wake_up(sk)
                                      mptcp_poll()
                                        state =3D=3D TCP_CLOSE
                                        sk_shutdown =3D=3D 0, sk_err =3D=3D=
 0
                                        <-- misses EPOLLERR/EPOLLIN/EPOLLOUT
  mptcp_close_err(sk, ETIMEDOUT)

mptcp_close_err() writes sk_err and SHUTDOWN_MASK before setting TCP_CLOSE
and waking waiters so lockless pollers see a consistent state.  However, on
close timeout, mptcp_do_fastclose() already sets TCP_CLOSE, and
__mptcp_close_ssk() then hits the new sk->sk_state =3D=3D TCP_CLOSE branch =
and
calls mptcp_close_wake_up() while sk_err and sk_shutdown are still 0.  In
mptcp_check_fastclose() above, mptcp_set_state(sk, TCP_CLOSE) is likewise
called before WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK).

> @@ -4768,8 +4811,11 @@ static int mptcp_stream_accept(struct socket *sock=
, struct socket *newsock,
>  		 */
>  		if (unlikely(inet_sk_state_load(msk->first) =3D=3D TCP_CLOSE)) {
>  			if (unlikely(list_is_singular(&msk->conn_list))) {
> +				int err =3D READ_ONCE(msk->first->sk_err);
> +
>  				mptcp_check_rcv_close(newsk);
> -				mptcp_set_state(newsk, TCP_CLOSE);
> +				if (newsk->sk_state !=3D TCP_CLOSE)
> +					mptcp_close_last_err(newsk, err);
>  			}
>  			mptcp_close_ssk(newsk, msk->first,
>  					mptcp_subflow_ctx(msk->first));

[Severity: Medium]
On a fallback socket closed by a TCP reset or timeout without a FIN, does
mptcp_check_rcv_close() corrupt the state before mptcp_close_last_err()
maps the error?

When a fallback subflow reaches TCP_CLOSE, subflow_sched_work_if_closed()
emulates a dummy rcv_data_fin =3D 1 even if no FIN was received:

net/mptcp/subflow.c:subflow_sched_work_if_closed() {
    ...
	if (__mptcp_check_fallback(msk) && subflow_is_done(ssk) &&
	    msk->first =3D=3D ssk &&
	    mptcp_update_rcv_data_fin(msk, subflow->map_seq +
				      subflow->map_data_len, true))
		mptcp_schedule_work(sk);
    ...
}

When mptcp_check_data_fin() processes that dummy rcv_data_fin (here in
mptcp_stream_accept(), in __mptcp_close_ssk(), or earlier in
mptcp_worker()), it leaves SOCK_DONE unset on sk because msk->first lacks
SOCK_DONE, yet it still advances sk->sk_state from TCP_ESTABLISHED to
TCP_CLOSE_WAIT, or from TCP_FIN_WAIT2 to TCP_CLOSE.  As a result, a TCP RST
in TCP_ESTABLISHED sees TCP_CLOSE_WAIT in mptcp_close_last_err() and
reports EPIPE instead of ECONNRESET, and a reset or timeout in
TCP_FIN_WAIT2 sees sk->sk_state =3D=3D TCP_CLOSE and skips
mptcp_close_last_err() completely.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121-mptcp-cmas=
on-fixes-v2-0-00327fd1de1f@kernel.org?part=3D61
