Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795255998;
	b=TCUAD8ZXjL2qidbymoNdPENLieLh8LM9sb2wp1FRra5PEYAEaLWFtphqgE7UhTBV4CBf
	 YScqSJoQ4bqrC4bG7kJqgNwIpdlIuwLw1/Nd2cnHBuFwiPoLsIqocjKfIytchkkY7EzMW
	 cfXukhHGVolI6m9izayYGnzd934inKItNNgbvBh1Lm40QLtrnlIjNCZT179yJJKW177PF
	 uvLJOFi00//BquQ7MrkycCy80mEiXu1+qyer4aSaQYYbLzkRHlScSQaZKaDTiL/zRhFz/
	 +v4G1BxSKDVsZ2Q6EB36xNxooRC/YKDD2JKlXa4OSLHn1mPKk2yJEq2gAazLFmNLKKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795255998;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+qzkAI8aInlODdRNS14ozfZFN7NqQfaVSk2r9LUfifQ=;
	b=rgdjrRHPAZgzAlyBiejEQHzIM5XHgq3K+01oqsCNo3DdL8TboGBuaoEgtD0W2+L5yFzw
	 aRFoB8cO4X41yJCK3ObnZOe2Tt0eEwZ5XNwqd8UdSNCCyQfnk7Zapf1sYAlrdS0/6iMhx
	 54WGPBgg7TJiupXIKBvQQ1YxLGFjoWPrGoxsgH4nXsV6KXyK6vpdoKVufCh1wKBpPd5lP
	 pmzgsY4nVlZjCjeLvsvg1zSNlUgd663AHh6YNcQukNT2C0vFa7Acg1WsMChf4CI9aKRFs
	 8In+JKvoAI0rXeKd2Q63GA1RjyFPOtZvusHEhqHxPT1LoHVCtWPXsARBdSIP2odYhbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mp9d/joH";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B626606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 10:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mp9d/joH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D941F000C0;
	Sat, 21 Nov 2026 10:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795255998;
	bh=+qzkAI8aInlODdRNS14ozfZFN7NqQfaVSk2r9LUfifQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=mp9d/joHqvJnt1mWSQHuH4xkEBv6oXt61TfpM52XQLC/myUnrDEJkQpKmXDhQgFe0
	 Nxvs2XtwBK9X77Hw+CMnKO6u52bKWx436s1PWe/v+CHmmvCEev1w/uXswLEnH4NNu0
	 qs9FPQQ8kNEvY1BaHgzY94vW5RLnYrb+goMw+HAa74E83LhoQD6DwWOcsGy+4Pr9l/
	 AXq0r+d14C0Ddj6Qcuwx2H3R0OJ5NPAtzhHq8NDvFixRNNu6B8sySif2JhX5DXRize
	 zUjBeSD6rtY337axIME5BorujdTrt2qS9bAB9OgXzuMfUITg8BCr40gwpeh45MDo6p
	 NBgLogJDrMSrA==
Message-ID: <sashiko-outbox-226923@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-net v2 24/62] mptcp: process pending close events
 at accept()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>, "MPTCP
 Linux" <mptcp@lists.linux.dev>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-24-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
 <20261121-mptcp-cmason-fixes-v2-24-00327fd1de1f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 10:13:17 +0000
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
- [Medium] mptcp: dummy fallback DATA_FIN processed on reset in
  mptcp_stream_accept()
--

commit 41ac450ef8d0029d02acbe4bb5044a609c4a37c5
Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>

mptcp: process pending close events at accept()

This commit calls mptcp_check_rcv_close() in mptcp_stream_accept() before
transitioning an accepted MPTCP socket whose only subflow is already
closed to TCP_CLOSE.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index a4dbe6d3a466f..7700265a13ce8 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -4679,8 +4679,10 @@ static int mptcp_stream_accept(struct socket *sock=
, struct socket *newsock,
>  		 * deal with bad peers not doing a complete shutdown.
>  		 */
>  		if (unlikely(inet_sk_state_load(msk->first) =3D=3D TCP_CLOSE)) {
> -			if (unlikely(list_is_singular(&msk->conn_list)))
> +			if (unlikely(list_is_singular(&msk->conn_list))) {
> +				mptcp_check_rcv_close(newsk);
>  				mptcp_set_state(newsk, TCP_CLOSE);
> +			}
>  			mptcp_close_ssk(newsk, msk->first,
>  					mptcp_subflow_ctx(msk->first));
>  		}

[Severity: Medium]
Can calling mptcp_check_rcv_close(newsk) here process a dummy fallback
DATA_FIN when a passive socket falls back to TCP and is reset by the peer
before accept()?

When a socket in the accept queue falls back to TCP (for example, on
receiving data without a DSS option) and then receives a peer TCP RST
without a FIN, subflow_error_report() skips propagating ssk->sk_err while
sk->sk_socket is NULL, and subflow_sched_work_if_closed() emulates
msk->rcv_data_fin =3D 1 even though SOCK_DONE is not set on msk->first.

Calling mptcp_check_rcv_close(newsk) here runs mptcp_check_data_fin():

net/mptcp/protocol.c:mptcp_check_data_fin() {
    ...
		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | RCV_SHUTDOWN);
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

Because __mptcp_close_ssk() takes the !dispose_it path for msk->first and
skips __mptcp_subflow_error_report(), newsk is left with RCV_SHUTDOWN set
and sk_err =3D=3D 0, so a subsequent recv() returns 0 (EOF) instead of
-ECONNRESET.  Even with the follow-up commit "mptcp: report errors as TCP
does when closing", mptcp_check_data_fin() has already moved newsk to
TCP_CLOSE_WAIT without setting SOCK_DONE, causing mptcp_close_last_err()
-> mptcp_reset_err() to overwrite ECONNRESET with EPIPE.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121-mptcp-cmas=
on-fixes-v2-0-00327fd1de1f@kernel.org?part=3D24
