Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008511;
	b=auCTXODaBs4CCLkREZYUCzgznVcDoUb2zzR7y3Xv/KFz/kgXWaYI0kBGeERqL9ltXWrh
	 imsJGedb4IxKa3G4UWKUcCcVb6ba2h4kC6eSFQtm7VnXWR/es3p9Fh+jK55ZSYwiicJYI
	 zLQgRssm9ayqQ/Uxn5yCzzmhuFacNmfvF8Ywdz8uARILTklcABiYfpHkJRyG+Yx/X1X5v
	 9gWQoJFL0Ur7tCTYWQS0wJ/2bRmfGn8jpZhrpTZZPqwjhLaNF1fQn+pibhQBJpk6C7TGi
	 tF0LvS5rTinpUH+ZHPQ050ASOgZqgVVaJHITi4/FC/CPy5oNn+bnw4q4z7QUfL87mSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008511;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kQaUJhe0LSMQ0u5JjwPM4z6sQ5DPpVn5KG85jV5sXcQ=;
	b=QVh8m0xT3uCxu3/HCLQkcDYMaStcvKGMdnFHtmXoJxI0gZmTgOyHSVxnparBpCBJ6ZUx
	 BObd4TTOsHUFbfZ7nUaSD2/Sss0YLV2ITbQIe4CWaQ2avevoobMjBTkvd8axEr7cx/kBv
	 d99TkqQ+fSejjxAXpaF8MbxfdZYtj7Aw6DHzb6NNg0jAvdgyDm9s9/Q4fXL6zzqds/Lkw
	 uYPnWCi9ajkRYWVQmPQ1J7ACnx4GALvxShUDC1TnVfuCaNxEpm3p3nrEW/BDGn+ub7JiA
	 fFo42cw51rDBo/b/iFsPnkpRQl0CeNH+zUEoruURJ+1JZbtee394X1W5R5g4hzSchzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=auTKxyCo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A292606A31F
	for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 09:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=auTKxyCo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D0AF1F01825;
	Mon, 26 Oct 2026 09:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793008510;
	bh=kQaUJhe0LSMQ0u5JjwPM4z6sQ5DPpVn5KG85jV5sXcQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=auTKxyCoxqMieGqwgZYkwqJfnr9YAKaV2PIzMhZ/2zurCoUBxOv0+5CQSffsTC38m
	 asC7/0FF9cpc7mgzzuEWEy5P9iewuHg62fKGi7/tY45ebCiF+2ukn75NUJDsPe+PX+
	 nAc5YyoJWh6wgs3MJ2m9y9wa+mQfjFcgfRpwvJnf0BHja32fY5QyvE0s5eMSKxdlyd
	 fj4pZIxd2aU2b58+P94CUPiPdADIAmpxDu4m1+MYJ4lb2n1Km7jV5YmbzjB7Ior8/I
	 zKMINrq09b0NSqmazLC+bIcBND2kurN1DiauknQ1DwID12ksEwF7PQkVLF4cflBO/v
	 86mnUhSXXzjnA==
Message-ID: <sashiko-outbox-184851@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v10 4/6] mptcp: pm: in-kernel: retry subflows
 closed after an error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anil Kaushik" <anilkaushikwireless@gmail.com>, mptcp@lists.linux.dev
In-Reply-To: <20261026063657.2955783-5-anilkaushikwireless@gmail.com>
References: <20261026063657.2955783-1-anilkaushikwireless@gmail.com>
 <20261026063657.2955783-5-anilkaushikwireless@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 09:55:10 +0000
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
- [Critical] mptcp: use-after-free in mptcp_close_ssk() via mptcp_close_ret=
ry_subflows()
- [High] mptcp: unstopped close timer after retry connect aborts active con=
nections
- [Medium] mptcp: connecting retry subflows not closed when leaving TCP_EST=
ABLISHED
--

commit f1e9a463142ae1f128b140c9fd8fd0bb5928bda7
Author: Anil Kaushik <anilkaushikwireless@gmail.com>

mptcp: pm: in-kernel: retry subflows closed after an error

This commit teaches the in-kernel path manager to re-create established
client-initiated subflows that close after a path timeout error, using the
subflow-retries limit for SYN retries. It also adds helpers to manage the
close timeout and clean up connecting retry subflows when the MPTCP socket
closes or leaves the established state.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 02a4f479d9d8c..6d3232dc2b19d 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2697,8 +2697,11 @@ static void __mptcp_close_ssk(struct sock *sk, str=
uct sock *ssk,
[ ... ]
> @@ -2788,6 +2791,78 @@ static void __mptcp_close_ssk(struct sock *sk, str=
uct sock *ssk,
>  	}
>  }
> =20
> +/* Re-created subflows still connecting are useless once the msk is clos=
ed,
> + * or no longer established: they cannot join anymore, see
> + * mptcp_finish_join(), and would keep it around.
> + */
> +static void mptcp_close_retry_subflows(struct sock *sk)
> +{
> +	struct mptcp_subflow_context *subflow, *tmp;
> +	struct mptcp_sock *msk =3D mptcp_sk(sk);
> +
> +	mptcp_for_each_subflow_safe(msk, subflow, tmp) {
> +		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> +		int state;
> +
> +		if (!subflow->retry || READ_ONCE(subflow->fully_established))
> +			continue;
> +
> +		/* still connecting, or already disconnected by
> +		 * mptcp_subflow_shutdown(), e.g. after shutdown(SHUT_WR)
> +		 */
> +		state =3D inet_sk_state_load(ssk);
> +		if (state !=3D TCP_SYN_SENT && state !=3D TCP_CLOSE)
> +			continue;

[Severity: Medium]
Can connecting retry subflows be left behind on msk->conn_list when the
MPTCP socket leaves TCP_ESTABLISHED?

First, mptcp_close_retry_subflows() is only called from __mptcp_close() and
from mptcp_retry_check_tout() when another subflow closes (and only if
icsk_mtup.probe_timestamp is zero and no active subflows remain). When sk
transitions out of TCP_ESTABLISHED via mptcp_shutdown() or
mptcp_check_data_fin(), mptcp_close_retry_subflows() is not called.

For example, if all active subflows have already closed and a retry subflow
is in TCP_SYN_SENT with probe_timestamp set, calling shutdown(fd, SHUT_WR)
moves sk to TCP_FIN_WAIT1:
- If mptcp_send_head(sk) is non-NULL, mptcp_check_send_data_fin() returns
  early and leaves the retry subflow in TCP_SYN_SENT even though
  mptcp_finish_join() will reject it once sk is no longer TCP_ESTABLISHED.
- If mptcp_send_head(sk) is NULL, mptcp_subflow_shutdown() calls
  tcp_disconnect(), which sets ssk->sk_state to TCP_CLOSE and invokes
  sk_error_report() rather than sk_state_change(), so
  MPTCP_WORK_CLOSE_SUBFLOW is not scheduled and the disconnected retry
  subflow stays on msk->conn_list.

Second, mptcp_retry_check_tout() treats any retry subflow with
!READ_ONCE(subflow->fully_established) as connecting, whereas
mptcp_close_retry_subflows() skips states other than TCP_SYN_SENT and
TCP_CLOSE. If a retry subflow received its SYN-ACK before sk left
TCP_ESTABLISHED and is in TCP_ESTABLISHED waiting for the 4th ACK
(!subflow->fully_established) when the last active subflow closes,
__mptcp_close_ssk() will not start the close timer (since msk->conn_list is
not singular), and mptcp_retry_check_tout() -> mptcp_close_retry_subflows()
will skip the subflow because its state is TCP_ESTABLISHED, leaving msk
without an active subflow or a close timeout timer.

> +
> +		/* Checked without the ssk lock: it can have been established
> +		 * in between. __mptcp_close_ssk() cleans its data in the msk
> +		 * backlog, and the MPTCP retransmissions cover what it sent.
> +		 * No need to push the pending data again.
> +		 */
> +		mptcp_pm_subflow_check_next(msk, subflow);
> +		__mptcp_close_ssk(sk, ssk, subflow, 0);
> +	}
> +}
> +
> +static bool mptcp_has_active_subflow(struct mptcp_sock *msk)
> +{
> +	struct mptcp_subflow_context *subflow;
> +
> +	mptcp_for_each_subflow(msk, subflow) {
> +		if (__mptcp_subflow_active(subflow))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +/* With no subflow left to send data, a re-created subflow still connect=
ing
> + * must not keep the connection open longer than the close timeout, as w=
hen
> + * all the subflows are closed, see __mptcp_close_ssk(). mptcp_worker() =
keeps
> + * the connection if the subflow connected in the meantime.
> + */
> +static void mptcp_retry_check_tout(struct sock *sk)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct mptcp_sock *msk =3D mptcp_sk(sk);
> +	bool connecting =3D false;
> +
> +	if (inet_csk(sk)->icsk_mtup.probe_timestamp ||
> +	    mptcp_has_active_subflow(msk))
> +		return;
> +
> +	mptcp_for_each_subflow(msk, subflow)
> +		connecting |=3D subflow->retry &&
> +			      !READ_ONCE(subflow->fully_established);
> +	if (!connecting)
> +		return;
> +
> +	if (sk->sk_state =3D=3D TCP_ESTABLISHED)
> +		mptcp_start_tout_timer(sk);
> +	else
> +		mptcp_close_retry_subflows(sk);
> +}
> +
>  void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
>  		     struct mptcp_subflow_context *subflow)
>  {
> @@ -2806,6 +2881,7 @@ void mptcp_close_ssk(struct sock *sk, struct sock *=
ssk,
>  	mptcp_pm_subflow_check_next(mptcp_sk(sk), subflow);
> =20
>  	__mptcp_close_ssk(sk, ssk, subflow, MPTCP_CF_PUSH);
> +	mptcp_retry_check_tout(sk);
>  }

[Severity: Critical]
Does calling mptcp_retry_check_tout() inside mptcp_close_ssk() cause a
use-after-free when callers iterate over msk->conn_list with
mptcp_for_each_subflow_safe()?

Both __mptcp_close_subflow() and mptcp_pm_rm_addr_or_subflow() iterate over
msk->conn_list using mptcp_for_each_subflow_safe(msk, subflow, tmp) and call
mptcp_close_ssk(sk, ssk, subflow):

    __mptcp_close_subflow() / mptcp_pm_rm_addr_or_subflow()
      mptcp_for_each_subflow_safe(msk, subflow, tmp)
        mptcp_close_ssk(sk, ssk, subflow)
          __mptcp_close_ssk(sk, ssk, subflow, MPTCP_CF_PUSH)
          mptcp_retry_check_tout(sk)
            mptcp_close_retry_subflows(sk)
              __mptcp_close_ssk(sk, ssk_retry, subflow_retry, 0)
                list_del(&subflow_retry->node)

Consider what happens when an earlier subflow timed out and was re-created
(appended to msk->conn_list in TCP_SYN_SENT) while another established
subflow S1 was still active (so probe_timestamp is 0):

1. sk leaves TCP_ESTABLISHED (for example, moving to TCP_CLOSE_WAIT on
   incoming DATA_FIN or to TCP_FIN_WAIT1 on shutdown(SHUT_WR)).
2. S1 then closes via __mptcp_close_subflow() or
   mptcp_pm_rm_addr_or_subflow(). In the outer
   mptcp_for_each_subflow_safe(msk, subflow, tmp) loop, subflow is S1 and
   the cached next pointer tmp is the connecting retry subflow S_retry.
3. mptcp_close_ssk() closes S1 and calls mptcp_retry_check_tout(sk). Since
   no active subflow remains, S_retry is connecting, and
   sk->sk_state !=3D TCP_ESTABLISHED, it calls mptcp_close_retry_subflows(s=
k).
4. mptcp_close_retry_subflows(sk) calls __mptcp_close_ssk() on S_retry
   without setting S_retry->close_event_done =3D true. Because
   ssk_retry !=3D msk->first, __mptcp_close_ssk() unlinks S_retry from
   msk->conn_list via list_del(&S_retry->node) (poisoning S_retry->node.next
   with LIST_POISON1), frees S_retry via kfree_rcu(), and drops msk's
   reference to ssk_retry.
5. Control returns to the outer mptcp_for_each_subflow_safe() loop, which
   advances subflow to tmp (the unlinked and freed S_retry) and reads
   tmp->node.next (LIST_POISON1). In __mptcp_close_subflow(), because
   S_retry->close_event_done is still false and ssk_retry is now in
   TCP_CLOSE, it calls mptcp_close_ssk() a second time on S_retry before
   dereferencing LIST_POISON1 on the next iteration.

[ ... ]
> @@ -3188,10 +3272,19 @@ static void mptcp_worker(struct work_struct *work)
>  	if (mptcp_close_tout_expired(sk)) {
>  		struct mptcp_subflow_context *subflow, *tmp;
> =20
> -		mptcp_do_fastclose(sk);
> -		mptcp_for_each_subflow_safe(msk, subflow, tmp)
> -			__mptcp_close_ssk(sk, subflow->tcp_sock, subflow, 0);
> -		mptcp_close_wake_up(sk);
> +		/* a re-created subflow connected in the meantime, see
> +		 * mptcp_retry_check_tout()
> +		 */
> +		if (sk->sk_state =3D=3D TCP_ESTABLISHED &&
> +		    mptcp_has_active_subflow(msk)) {
> +			mptcp_stop_tout_timer(sk);
> +		} else {
> +			mptcp_do_fastclose(sk);
> +			mptcp_for_each_subflow_safe(msk, subflow, tmp)
> +				__mptcp_close_ssk(sk, subflow->tcp_sock,
> +						  subflow, 0);
> +			mptcp_close_wake_up(sk);
> +		}
>  	}

[Severity: High]
Can leaving the close timeout timer running after a retry subflow connects
abort a live connection or leave a stale probe_timestamp?

When the last active subflow times out and is retried,
mptcp_retry_check_tout() starts the close timeout timer via
mptcp_start_tout_timer(sk), setting icsk_mtup.probe_timestamp. If the
re-created subflow connects before the close timeout expires,
mptcp_finish_join() returns early for active joins
(!list_empty(&subflow->node)) without calling mptcp_stop_tout_timer(parent),
and check_fully_established() does not stop the timer either.

Because the timer and probe_timestamp remain active until the original
timeout expires:

1. If the reconnected MPTCP socket (with !sock_flag(sk, SOCK_DEAD)) moves to
   TCP_CLOSE_WAIT (on incoming DATA_FIN while still sending data) or
   TCP_FIN_WAIT1 / TCP_FIN_WAIT2 (after shutdown(SHUT_WR) while still
   receiving data) before the stale timer fires, mptcp_worker() sees
   sk->sk_state !=3D TCP_ESTABLISHED and enters the else branch, calling
   mptcp_do_fastclose(sk) and resetting the active connection.
2. Because icsk_mtup.probe_timestamp is still non-zero after the retry
   subflow becomes active, if another retry subflow is still connecting and
   the newly active subflow closes before the original timer expires,
   mptcp_retry_check_tout() sees inet_csk(sk)->icsk_mtup.probe_timestamp !=
=3D 0
   and returns early instead of restarting the close timeout from the new
   close time (or closing connecting retry subflows if sk is no longer
   TCP_ESTABLISHED).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026063657.2955=
783-1-anilkaushikwireless@gmail.com?part=3D4
