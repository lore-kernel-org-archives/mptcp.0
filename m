Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795559590;
	b=kODuQqSE+mzE4wZ8gnAJ4pqKbwwSZ2Ax3s1N652Md53Gi4Ib5BxKKFj6roPb27Hw7P32
	 KyaLiisZVrvLXq+CFubmncmUHpA6zIiTgSQP36L6zjfEI2uKTTAsgn7Zfzi4lxpu9eZpU
	 Eucu1lirhJWKEghTdFMv6c+AdYUJg9P/717Z07e4p22VrZTCouenKdwcZTUPwZBw8HSAI
	 uadTPxSTnAo4kKH8wdoxPByuaH2aVznkKSfQxTfSGdh+jf++9Ek7OcAqiwaTCXokS/T14
	 kzOlJsAlfnLSc1yCkGUiM24CS64gZc62mQnbxEo8esh0Sa3BaU2JEZ90uruI0dJNq+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795559590;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wjh0ir+QjjlzgN26B3GdBsgIycOcR9aisFRq1SCz+zg=;
	b=N3Ac0DjEweCvnsyr2eMRi1UKDMVqEMdmGo29J1NAJJW8oFKRfdpqMuZ/yuTc5U8pPnfx
	 uWyjQBdMtJmJU9N3Ktn9gXDklHC6Oo/Y1MigjhWTDV8IZvoMS27Rh4TasKqU/5jFRkhxR
	 AksChH+6YRR47pNLBQYioMWtv/yFksDJKFd/rUwWx/nKZEUTmBx9MmA7bjm/rdCzinCR1
	 k+XJJCybPaZtPCabUuk+5YRdXKZIku+P8+rbNd0hkj55QgXMennmGgwZ9AQsrx2AIN/rn
	 Ltg/51CTncORk0xL/qdTPLNeJS87R7iwXwY3nnKGZ5zPUwA4wbWVplvsTrmm9WASGhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X9CVIO+E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FE2606A31E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X9CVIO+E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685841F000C0;
	Tue, 24 Nov 2026 22:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795559589;
	bh=wjh0ir+QjjlzgN26B3GdBsgIycOcR9aisFRq1SCz+zg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=X9CVIO+EqKTWnR9jM0R5JD+LlzNvp7DZ0FNDTK7pnVWksw54C8J40dQMkmzjxT5iE
	 ND7Ql0Ie8uqVD5hIOt8jI/zOB7tBpidTyZttumtKmG9NulFfXtNZUuO4AWJgu7jZFi
	 4BDg5iovKW2T7qo1rG1PYIBbK6aExiSvh5rraHACl+QyN0PvpbrioKSIN/R/tHmVg3
	 L+oW8yjC7Q3guZPu12g/Txbh2YKpESyG44zKMgazwaWsx1lWkeJIhn8s/wZiqbu2z9
	 tGFNJPx0jpXtUnSUHQSUFCHtL096d35uZ3VAzVz2rfbvqwHPXvWdg1oUrITTSV1JrX
	 zjBkx6yVs9Cnw==
Message-ID: <sashiko-outbox-232136@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-net v3 12/50] mptcp: no sf left: process pending
 DATA_FIN
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>, "MPTCP
 Linux" <mptcp@lists.linux.dev>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-12-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
 <20261124-mptcp-cmason-fixes-v3-12-416c0920c73f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 22:33:08 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] mptcp: pending DATA_FIN skipped for TCP_ESTABLISHED in
  __mptcp_close_ssk()
--

commit 31bc56e76b249e9f9785ca53d63505bc1884f890
Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>

mptcp: no sf left: process pending DATA_FIN

This commit introduces mptcp_check_rcv_close() to spool the backlog and
process a pending DATA_FIN or MP_FASTCLOSE before closing the MPTCP socket
when the last subflow closes.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index bcdad00d35732..b57d0f82b416e 100644
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
> @@ -2819,9 +2831,7 @@ static void __mptcp_close_ssk(struct sock *sk, stru=
ct sock *ssk,
>  			mptcp_schedule_work(sk);
>  		} else if (sk->sk_state !=3D TCP_ESTABLISHED ||
>  			   msk->in_accept_queue) {
> -			/* After the close, an MP_FASTCLOSE would be ignored */
> -			mptcp_check_fastclose(msk);
> -
> +			mptcp_check_rcv_close(sk);
>  			mptcp_set_state(sk, TCP_CLOSE);
>  			WRITE_ONCE(sk->sk_shutdown,
>  				   sk->sk_shutdown | SEND_SHUTDOWN);

[Severity: Medium]
Should mptcp_check_rcv_close(sk) run before the
sk->sk_state !=3D TCP_ESTABLISHED check?

On an accepted non-fallback socket in TCP_ESTABLISHED, if the peer sends
the final data with DATA_FIN and closes the last subflow while
mptcp_worker() holds the socket lock, the data sits in msk->backlog_list.
Because mptcp_worker() runs mptcp_check_data_fin() and
__mptcp_close_subflow() before release_sock() spools the backlog, and
mptcp_close_ssk() only spools the backlog before __mptcp_close_ssk() on
fallback sockets:

net/mptcp/protocol.c:mptcp_close_ssk() {
	...
	if (ssk =3D=3D msk->first && __mptcp_check_fallback(msk) &&
	    READ_ONCE(msk->rcv_data_fin) && !sock_flag(sk, SOCK_DEAD)) {
		mptcp_move_skbs(sk);
		mptcp_check_data_fin(sk);
	}

	__mptcp_close_ssk(sk, ssk, subflow, flags);
}

sk->sk_state is still TCP_ESTABLISHED here.  __mptcp_close_ssk() skips
mptcp_check_rcv_close() and starts the close timeout timer instead, and
when release_sock() later spools the backlog and processes the DATA_FIN,
the socket transitions to TCP_CLOSE_WAIT after msk->first has already been
closed, leaving the socket stuck in TCP_CLOSE_WAIT with no subflows until
the close timeout expires.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-mptcp-cmas=
on-fixes-v3-0-416c0920c73f@kernel.org?part=3D12
