Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795256271;
	b=AaxJhETWqP1ekvFaQ5HmIyd+mxQLyj50T3/WTdEIll+zPbR+O1IYpQfHcCSmsuBcuXWd
	 ScWE+oX/mDlsMBoD1Q/wqz8hWMmZKvzbXmMXXqEsLyi3w6zD8zuYuBY4a23C0oguHmb8J
	 JbCTecNfRT8xxffQBbhKwINVQl97L5bJOeAaHaH5ZH2O2D7q9EwR51KGaCZOY0DBFX6og
	 dBlf0e9dlacp7tkpKwZnTXMop84FqRaujN+1AWsLoRikK6zwO9VH+vFliO7NKdHrUZ/M8
	 cqP3OrIsj/4lby5EUBi9ctirYulaE8kFkUiRuz/ODICIyGQYBC9/fYlL/MYzYm3VIxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795256271;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vND0rJ7sYnMRhVfQV4NJz+5bnGl8TGZnMumV5R6bo+Y=;
	b=f7Zwdey6JrwWHYd8lm+CAqkGaLXD7aoPWnUNE5HptTXrvx6PBzuK99j0z9Zb3rYHu2Uh
	 20i1GYtRBVSmq0kAouv98aRiivGhpXtojAQYWoLoc6Z67NN7l8ifCM2POySl/YPx+3UqG
	 c3NY77+l9zfsoKKZc6Mvv91VThM/ty/4PIYPv3KW5eol4LPb1N0qg8OKsMWfqZidLvo3X
	 byWP1/QxZt+qdonzpRvfXhi+1J/eefl8Vt5FGFfcPwwjCxgiffBvz1mwCdm6YUBzyxncb
	 ER7tx44FWNd/OblGn1zQ5NcFuw0r8//nDLpqOrYjqX1khon30pWBMfJf0RG+2yOXvQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UqJaYr+U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0933C606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 10:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UqJaYr+U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8855A1F000C0;
	Sat, 21 Nov 2026 10:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795256270;
	bh=vND0rJ7sYnMRhVfQV4NJz+5bnGl8TGZnMumV5R6bo+Y=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=UqJaYr+UCyBMg0CPafNCcwE9LdUOwRQ+DLzJaW/90B07oJzSJUOcY8WtCS/YgShun
	 Hq/9KhSS8b4s+fcNmxKRmk7QJxYn4YCmSKTYElgobD9DaP0kndCj3MAxQ3WDvu53nj
	 WC8eKRdKdYV1hVJrUlvnHNGixA/L0Wykk+TG+kzFYFP7O90F0O04JqEABCAPsqhGj/
	 grSN9Z7xB5MuIT//y/XIva/5+bKVdbiz4wh9lQgC3lWLjzv9oRBb0XW63HJkPOJXrv
	 0J8npqezrNMQl/b8/AQvkZgKUee0p2i9G5A22e5e4tnE+UyF3XTGIorVJq+C2HNedK
	 DvBuG5jnsEbjQ==
Message-ID: <sashiko-outbox-226929@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-net v2 23/62] mptcp: no sf left: process pending
 DATA_FIN
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>, "MPTCP
 Linux" <mptcp@lists.linux.dev>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-23-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
 <20261121-mptcp-cmason-fixes-v2-23-00327fd1de1f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 10:17:50 +0000
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
- [Medium] mptcp: tcp_disconnect() clears SOCK_DONE before
  mptcp_check_rcv_close()
- [Medium] mptcp: pending DATA_FIN skipped for TCP_ESTABLISHED in
  __mptcp_close_ssk()
--

commit 95271396d761d6456e08d69c39becd026df9d3ed
Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>

mptcp: no sf left: process pending DATA_FIN

This commit introduces mptcp_check_rcv_close() to spool the backlog and
process a pending DATA_FIN or MP_FASTCLOSE before __mptcp_close_ssk()
transitions the MPTCP socket to TCP_CLOSE.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 518321aedd1e4..a4dbe6d3a466f 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2707,6 +2707,18 @@ static void mptcp_cleanup_ssk_backlog(struct sock =
*sk, struct sock *ssk)
> =20
>  static void mptcp_check_fastclose(struct mptcp_sock *msk);
> =20
> +/* After the close, a pending DATA_FIN or MP_FASTCLOSE would be ignored =
*/
> +static void mptcp_check_rcv_close(struct sock *sk)
> +{
> +	/* process the DATA_FIN after the data still in the backlog */
> +	if (READ_ONCE(mptcp_sk(sk)->rcv_data_fin)) {
> +		mptcp_move_skbs(sk);
> +		mptcp_check_data_fin(sk);
> +	}
> +
> +	mptcp_check_fastclose(mptcp_sk(sk));
> +}
> +
>  /* subflow sockets can be either outgoing (connect) or incoming
>   * (accept).
>   *
> @@ -2818,9 +2830,7 @@ static void __mptcp_close_ssk(struct sock *sk, stru=
ct sock *ssk,
>  			mptcp_schedule_work(sk);
>  		} else if (sk->sk_state !=3D TCP_ESTABLISHED ||
>  			   msk->in_accept_queue) {
> -			/* After the close, an MP_FASTCLOSE would be ignored */
> -			mptcp_check_fastclose(msk);
> -
> +			mptcp_check_rcv_close(sk);

[Severity: Medium]
On a fallback connection, does calling mptcp_check_rcv_close(sk) here fail
to propagate SOCK_DONE to sk?

When __mptcp_close_ssk() closes msk->first without disposing it, it calls
__mptcp_subflow_disconnect() -> tcp_disconnect(ssk, 0) before reaching
out:, which clears SOCK_DONE on msk->first.  When mptcp_check_rcv_close()
then calls mptcp_check_data_fin(), the fallback check cannot set SOCK_DONE:

net/mptcp/protocol.c:mptcp_check_data_fin() {
    ...
		/* on fallback, also emulated after a reset: check for a FIN */
		if (!__mptcp_check_fallback(msk) ||
		    (msk->first && sock_flag(msk->first, SOCK_DONE)))
			sock_set_flag(sk, SOCK_DONE);
    ...
}

If sk->sk_err is set (for example, if a RST follows the peer's FIN),
mptcp_recvmsg() and mptcp_splice_read() will return the error instead of
EOF after draining the spooled data.

[Severity: Medium]
Can gating mptcp_check_rcv_close(sk) behind sk->sk_state !=3D TCP_ESTABLISH=
ED
skip a pending DATA_FIN when the peer's final data is still in
msk->backlog_list?

When final data and a DATA_FIN arrive on an established, accepted socket
while mptcp_worker() holds the socket lock, the data sits in
msk->backlog_list.  In mptcp_worker(), mptcp_check_data_fin() sees
msk->ack_seq < msk->rcv_data_fin_seq and leaves sk in TCP_ESTABLISHED
before __mptcp_close_subflow() runs.  Because sk->sk_state is still
TCP_ESTABLISHED here, __mptcp_close_ssk() skips mptcp_check_rcv_close()
and starts the close timeout timer instead.  When release_sock() later
spools the backlog, mptcp_check_data_fin() moves sk to TCP_CLOSE_WAIT
after msk->first is already closed, leaving sk in TCP_CLOSE_WAIT without
SEND_SHUTDOWN until the close timeout expires.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121-mptcp-cmas=
on-fixes-v2-0-00327fd1de1f@kernel.org?part=3D23
