Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792938067;
	b=zICvdl0dbFNN5k/zW/zLcXZbksmbqAwZ6toLWvs9BYZACZleeA+hsuq7qYRKwCfbvF3t
	 5gEmG9r/Xr92v0CRwQfb9yaNg+JUYqFMA0vG81XaP2I++/M1+d2AAE8mf37muGlI82zlY
	 LZxMCT1SCgF4PQoPJNx6aXS5M4hnOSwoguhzy9cLIxCbckMmXyJdAeZrYnOALt72G+R6a
	 vf3UBcoxCL0US7PgaEvU7YW2JNic7Z8CTdXjo68Ho2p8w/z6b/3ONTG3F1xRgX8nFTL/X
	 aadSyABEqGn8Nh20o4Taurm/d7ZcxOOYH+4vijJUKsY+zwWvOVWVdBEdGOaiKiDhPTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792938067;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pmf1od8G+sJepafyOW0AAig4MdyGkDFQum2y2eeomew=;
	b=fVYqj9CryCQxRoUf1F/+tNkVRv66258S4Bhtw81jUIxmyZhRk8jUFsswFOfJwmFnKHMP
	 KDxtWepU8jSLw71l2r9P8Q6Ug6H1KjhqyKvVt0ipIh//BEfpv0Yqh0Hx1g+YzokXBVORB
	 yUFrusq0CQKfgj7qpAd/OgIzadl6Z2onwlDoDTpQSX37+vwETfwqQEewLLFD89DBZk6Z2
	 u7fXwCYRd7bkEn2oP4zkwBRx5mRo3ODci+Ck1ywzxNNYqCZI62TrXOBtNcAZA0Hte1eCp
	 eJx4T5149ce5EGr3U1ySBpSdanBIAvTVThuGFPnGgNIkKUu4s6k5lnJRmbOoB1a9+Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e7agvhqj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C8B606A31A
	for <mptcp@lists.linux.dev>; Sun, 25 Oct 2026 14:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e7agvhqj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD0921F01825;
	Sun, 25 Oct 2026 14:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792938067;
	bh=pmf1od8G+sJepafyOW0AAig4MdyGkDFQum2y2eeomew=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=e7agvhqjZHM7Y7nuC+x1ncEmJpkiF974WGrrM7rQd7XBp75E6qIxgVuwZ9SSemPnR
	 /6KBnUnea/zGWvqrxtE9GopzDxmFWP6er1H+K/ZXvnSCPKA7qE4jwTyU/9YpmAAjej
	 ccF8Htuf1YXHnc/Sv/3ip5mVscZGgYMBKSxNGa4gZVWgP6WyciB3rZooVckpIRvlHR
	 JzcM01hA0Ov9SyrS1cVRMsD9lCKJmq6n2z+e7nHGQr54ChRH9jHzttaE6/PuN/YmEd
	 fJZgkBBAi+9dOBGlNjQJkuZOkjq1zCpOQwV+i8hRuJfOB0byKmySrAi72Nw5bbgJsI
	 l1c8jZQGwG4Lg==
Message-ID: <sashiko-outbox-184246@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v9 4/6] mptcp: pm: in-kernel: retry subflows
 closed after an error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anil Kaushik" <anilkaushikwireless@gmail.com>, mptcp@lists.linux.dev
In-Reply-To: <20261025134909.2794368-5-anilkaushikwireless@gmail.com>
References: <20261025134909.2794368-1-anilkaushikwireless@gmail.com>
 <20261025134909.2794368-5-anilkaushikwireless@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 14:21:06 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] mptcp: close timeout from mptcp_retry_check_tout() not stopped on =
retry join
- [Medium] mptcp: pm: retry subflows keep half-closed sockets open when all=
 subflows close
--

commit 92b3e7c79536b83b9f6407cb01792ce3da0243f5
Author: Anil Kaushik <anilkaushikwireless@gmail.com>

mptcp: pm: in-kernel: retry subflows closed after an error

This commit updates the in-kernel path manager to re-create established
subflows initiated by the local host when TCP closes them after a
retransmission or keepalive timeout, using the subflow-retries limit for SYN
retransmissions. It also cleans up connecting retry subflows on socket close
and starts the close timeout timer if no active subflows remain while a ret=
ry
subflow is connecting.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 02a4f479d9d8c..25fd0628686c3 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -2788,6 +2791,32 @@ static void __mptcp_close_ssk(struct sock *sk, str=
uct sock *ssk,
>  	}
>  }
> =20
> +/* With no subflow left to send data, a re-created subflow still connect=
ing
> + * must not keep the connection open longer than the close timeout, as w=
hen
> + * all the subflows are closed, see __mptcp_close_ssk(). A join stops it.
> + */
> +static void mptcp_retry_check_tout(struct sock *sk)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct mptcp_sock *msk =3D mptcp_sk(sk);
> +	bool connecting =3D false;
> +
> +	if (sk->sk_state !=3D TCP_ESTABLISHED ||
> +	    inet_csk(sk)->icsk_mtup.probe_timestamp)
> +		return;

[Severity: Medium]
What happens if sk transitions out of TCP_ESTABLISHED while a re-created
subflow is still connecting in TCP_SYN_SENT, and the remaining active
subflows subsequently close before close() is called?

For example, if subflow 1 times out while sk->sk_state is TCP_ESTABLISHED,
__mptcp_close_subflow() -> mptcp_pm_subflow_retry() creates a retry subflow
in TCP_SYN_SENT while subflow 2 is still active.

If the peer then sends DATA_FIN on subflow 2 (moving sk->sk_state to
TCP_CLOSE_WAIT in mptcp_check_data_fin()), or the application calls
shutdown(fd, SHUT_WR) with unsent data still queued (moving sk->sk_state to
TCP_FIN_WAIT1 in mptcp_shutdown() while mptcp_check_send_data_fin() returns
before calling mptcp_subflow_shutdown()), mptcp_close_retry_subflows() is n=
ot
called because it only runs from __mptcp_close(). At that point,
mptcp_is_fully_established(sk) is false, so mptcp_finish_join() will reject
the connecting retry subflow even if the path recovers.

If subflow 2 later closes via mptcp_close_ssk(), __mptcp_close_ssk() checks
list_is_singular(&msk->conn_list), which is false because the connecting
retry subflow is still in msk->conn_list alongside msk->first:

net/mptcp/protocol.c:__mptcp_close_ssk() {
	...
	if (list_is_singular(&msk->conn_list) && msk->first &&
	    inet_sk_state_load(msk->first) =3D=3D TCP_CLOSE) {
		if (sk->sk_state !=3D TCP_ESTABLISHED ||
		    msk->in_accept_queue || sock_flag(sk, SOCK_DEAD)) {
			mptcp_set_state(sk, TCP_CLOSE);
			mptcp_close_wake_up(sk);
		} else {
			mptcp_start_tout_timer(sk);
		}
	}
}

Then mptcp_retry_check_tout() returns early because sk->sk_state is no long=
er
TCP_ESTABLISHED. Doesn't this leave the half-closed MPTCP socket open witho=
ut
a close timeout timer until all 127 SYN retries on the retry subflow expire?

> +
> +	mptcp_for_each_subflow(msk, subflow) {
> +		if (__mptcp_subflow_active(subflow))
> +			return;
> +
> +		connecting |=3D subflow->retry &&
> +			      !READ_ONCE(subflow->fully_established);
> +	}
> +
> +	if (connecting)
> +		mptcp_start_tout_timer(sk);
> +}
> =20
>  void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
>  		     struct mptcp_subflow_context *subflow)
> @@ -2806,6 +2835,7 @@ void mptcp_close_ssk(struct sock *sk, struct sock *=
ssk,
>  	mptcp_pm_subflow_check_next(mptcp_sk(sk), subflow);
> =20
>  	__mptcp_close_ssk(sk, ssk, subflow, MPTCP_CF_PUSH);
> +	mptcp_retry_check_tout(sk);
>  }
> =20
>  static unsigned int mptcp_sync_mss(struct sock *sk, u32 pmtu)
> @@ -2823,6 +2853,8 @@ static void __mptcp_close_subflow(struct sock *sk)
>  	mptcp_for_each_subflow_safe(msk, subflow, tmp) {
>  		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
>  		int ssk_state =3D inet_sk_state_load(ssk);
> +		struct mptcp_pm_retry retry;
> +		bool do_retry;
> =20
>  		if (ssk_state !=3D TCP_CLOSE &&
>  		    (ssk_state !=3D TCP_CLOSE_WAIT ||
> @@ -2834,7 +2866,13 @@ static void __mptcp_close_subflow(struct sock *sk)
>  		if (!skb_queue_empty_lockless(&ssk->sk_receive_queue))
>  			continue;
> =20
> +		do_retry =3D mptcp_pm_subflow_retry_check(msk, subflow, &retry);
>  		mptcp_close_ssk(sk, ssk, subflow);
> +		if (do_retry) {
> +			mptcp_pm_subflow_retry(msk, &retry);
> +			/* creating a subflow stopped the close timeout */
> +			mptcp_retry_check_tout(sk);
> +		}

[Severity: High]
Where is the close timeout timer stopped once the re-created subflow finish=
es
connecting and joins the connection?

When the last active subflow closes and is retried here in
__mptcp_close_subflow(), mptcp_pm_subflow_retry() -> mptcp_pm_kernel_retry()
calls __mptcp_subflow_connect(), which adds subflow->node to msk->conn_list,
starts the non-blocking connect, and calls mptcp_stop_tout_timer(sk).

Immediately after mptcp_pm_subflow_retry() returns (or in mptcp_close_ssk()
when another last active subflow closes while a retry subflow is connecting=
),
mptcp_retry_check_tout(sk) sees no active subflows and calls
mptcp_start_tout_timer(sk), setting inet_csk(sk)->icsk_mtup.probe_timestamp
and arming the close timeout timer.

The comment in mptcp_retry_check_tout() notes "A join stops it", but when t=
he
outgoing retry subflow receives SYN+ACK and subflow_finish_connect() calls
mptcp_finish_join(ssk), subflow->node is already in msk->conn_list, so
mptcp_finish_join() takes the early return path without calling
__mptcp_finish_join() or mptcp_stop_tout_timer(sk):

net/mptcp/protocol.c:mptcp_finish_join() {
	...
	if (!list_empty(&subflow->node)) {
		spin_lock_bh(&msk->fallback_lock);
		if (!msk->allow_subflows) {
			spin_unlock_bh(&msk->fallback_lock);
			return false;
		}
		mptcp_subflow_joined(msk, ssk);
		spin_unlock_bh(&msk->fallback_lock);
		mptcp_propagate_sndbuf(parent, ssk);
		return true;
	}
}

Later, when the 4th ACK arrives in check_fully_established() ->
__mptcp_subflow_fully_established(), mptcp_stop_tout_timer(sk) is not called
there either.

Because inet_csk(sk)->icsk_mtup.probe_timestamp remains non-zero, won't
mptcp_worker() see mptcp_close_tout_expired(sk) as true once close_timeout
elapses and abort the recovered connection with mptcp_do_fastclose(sk) and
__mptcp_close_ssk() (also leaving msk->pm.extra_subflows incremented)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025134909.2794=
368-1-anilkaushikwireless@gmail.com?part=3D4
