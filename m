Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792722547;
	b=J/Qy+LDdnIoePEZvumJhqum0T4LYg5J44zpFCvKAKJorlRTbf/lQeo71nxrVoFt6qx6q
	 22BCuZHKXY+MtlGVaT6ffJ194osCHrgsVW0JpSYeM0gTqSKsyzhHvXrs5ca17T4RRY33p
	 S2JgF8yZXIIo5Ag3K54ZSmsTcidZYRXxKYGsOfdPH2PWJFPMbGPVgacufua6mp8hBrYiF
	 q83njPS00DZ/fDGVQDBHai0ORuXM1DGV/BlI/BTX7CZxZJmY4pA/aHg5cewgt04qUWsp4
	 vZBGRol/LbfdImgH/6xSWDyw3fTKX9w6BAEYse1QCZ5vymakiAj0vwUqrmKiOXZ8M7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792722547;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wNHAPhcOp3a6x95lFk4OsC6/pf6HTSlYr8EbD5M0BvY=;
	b=pVUfDzAdDU34etwG6j/2JZlG2yfA+jdZERpbRHJ6SeqE3h1EYMScfgTcoEhLQOvVyO73
	 Ic+2r2bIbTyz3xHXaRkWSuaxg9hmGSMFolHbDWqlySfhzNldmJI0xCjVlpD6Ie1tp5KwF
	 wVWApXfM2XJGfDZcmCS+GKclkZoEayXzppoT1qEOm1QTX2l1LZ4txNwcuCmY9KJn0ktLP
	 lHRq7DWr0KLVCnyh9rd8fWe2raXGDSf6B7ea3yZf18bMFyqHDzbJxiWYk6GpMZR5TxKb5
	 bK7g75iuB/iSvJMkwG84Vv/JFnyK4IAK4/k6r+aPFMUWrwvQbTIjWY2gDRJHsbV8hWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TtyzrOXK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85D3606A31A
	for <mptcp@lists.linux.dev>; Fri, 23 Oct 2026 02:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TtyzrOXK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 543311F01828;
	Fri, 23 Oct 2026 02:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792722546;
	bh=wNHAPhcOp3a6x95lFk4OsC6/pf6HTSlYr8EbD5M0BvY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=TtyzrOXKoUa/YiHd4L1aOlBdwCeUuBOE5WoOq6/upcgRBmJnifJigVeBfB1YsUD6A
	 856LjUgGpymGpBZTF/nfcCo4EYUKFWFhUTJ4MzTTPMj4CTb8ExB3fxd3a3Xn+K1iyI
	 RBHD6NeR4DN37U3UUz5SBvyUwuOo5bDpC5f89ckCM12/LmH5H8Ea1ShfuTGSgBLPw1
	 7CflNeernWjgvzcuUslXbiXDO+o8eRCPiWJ4/mMPh3I3KCkeDomMCGxgHG1LXOkLfb
	 CS3+lXxrm9gYsMr6kwezaij8oICAvDsMlPQdQu9rJUbrDRs0JhXYB2sPOm7VDNG95W
	 NpnpNNK+Uziaw==
Message-ID: <sashiko-outbox-182232@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v15 06/11] mptcp: align FIN handling with TCP
 via SOCK_DONE
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <920d36c7943127f886900b7cdd7404e9b2acab85.1792718041.git.tanggeliang@kylinos.cn>
References: <cover.1792718041.git.tanggeliang@kylinos.cn>
 <920d36c7943127f886900b7cdd7404e9b2acab85.1792718041.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 02:29:01 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mptcp: SOCK_DONE set on fallback TCP RST via subflow_is_done() mas=
ks sk_err
--

commit d076bfa67e731d6a4dc57a834f527b4e82a636fb
Author: Geliang Tang <geliang@kernel.org>

mptcp: align FIN handling with TCP via SOCK_DONE

This commit aligns MPTCP FIN reception handling with TCP by setting SOCK_DO=
NE
in mptcp_check_data_fin(), checking it in mptcp_inq_hint() and mptcp_recvms=
g()
before sock_error(), and resetting it in mptcp_disconnect().

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 3c3ad8991799a..7b0005d47bead 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -740,6 +740,7 @@ static void mptcp_check_data_fin(struct sock *sk)
> =20
>  		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | RCV_SHUTDOWN);
>  		smp_mb__before_atomic(); /* SHUTDOWN must be visible first */
> +		sock_set_flag(sk, SOCK_DONE);
> =20
>  		switch (sk->sk_state) {
>  		case TCP_ESTABLISHED:
> @@ -2423,7 +2424,7 @@ static unsigned int mptcp_inq_hint(const struct soc=
k *sk)
>  		return INT_MAX;
> =20
>  	if (!hint_val &&
> -	    (sk->sk_state =3D=3D TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN)))
> +	    sock_flag(sk, SOCK_DONE))
>  		return 1;
> =20
>  	return (unsigned int)hint_val;
> @@ -2495,6 +2496,9 @@ static int mptcp_recvmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len,
>  			    !timeo)
>  				break;
>  		} else {
> +			if (sock_flag(sk, SOCK_DONE))
> +				break;
> +
>  			copied =3D sock_error(sk);
>  			if (copied)
>  				break;

[Severity: High]
Can checking sock_flag(sk, SOCK_DONE) before sock_error(sk) in
mptcp_recvmsg() mask a connection reset error on a fallback MPTCP connection
when the peer aborts with a TCP reset?

When a peer sends a TCP reset on a fallback subflow (msk->first),
tcp_reset() -> tcp_done_with_error() -> tcp_done() sets sk_err, sk_state,
and sk_shutdown on the subflow socket without setting SOCK_DONE, and invokes
subflow_state_change():

net/mptcp/subflow.c:subflow_state_change() {
	...
	if (mptcp_subflow_data_available(sk))
		mptcp_data_ready(parent, sk);
	subflow_sched_work_if_closed(mptcp_sk(parent), sk);
	...
}

In subflow_sched_work_if_closed(), subflow_is_done() checks:

net/mptcp/subflow.c:subflow_is_done() {
	return sk->sk_shutdown & RCV_SHUTDOWN || sk->sk_state =3D=3D TCP_CLOSE;
}

Because subflow_is_done(ssk) returns true on a TCP reset,
subflow_sched_work_if_closed() generates a synthetic data fin:

net/mptcp/subflow.c:subflow_sched_work_if_closed() {
	...
	if (__mptcp_check_fallback(msk) && subflow_is_done(ssk) &&
	    msk->first =3D=3D ssk &&
	    mptcp_update_rcv_data_fin(msk, subflow->map_seq +
				      subflow->map_data_len, true))
		mptcp_schedule_work(sk);
	...
}

If the parent msk is owned by user context when subflow_error_report(ssk)
subsequently runs (or if mptcp_worker acquires the msk socket lock before
subflow_error_report() acquires mptcp_data_lock), error and state propagati=
on
to the parent msk is deferred via MPTCP_ERROR_REPORT in msk->cb_flags,
leaving sk->sk_state in TCP_ESTABLISHED.

Before MPTCP_ERROR_REPORT is processed at the end of mptcp_release_cb(),
mptcp_check_data_fin() can run while sk->sk_state is still TCP_ESTABLISHED
(for example via __mptcp_move_skbs() at the start of mptcp_release_cb(),
mptcp_move_skbs() in mptcp_recvmsg() or mptcp_ioctl(), or in mptcp_worker()=
):

net/mptcp/protocol.c:mptcp_release_cb() {
	for (;;) {
		...
		if (spool_bl && __mptcp_move_skbs(sk, &skbs, &moved)) {
			/* notify ack seq update */
			mptcp_cleanup_rbuf(msk, 0);
			sk->sk_data_ready(sk);
		}
		...
	}
	if (flags) {
		...
		if (__test_and_clear_bit(MPTCP_ERROR_REPORT, &msk->cb_flags))
			__mptcp_error_report(sk);
	}
	...
}

When mptcp_check_data_fin() runs in that window, it increments msk->ack_seq
and sets SOCK_DONE on the parent msk. Once __mptcp_error_report() then
propagates sk->sk_err, wouldn't mptcp_recvmsg() hit the new
sock_flag(sk, SOCK_DONE) check before sock_error(sk) and return 0 instead of
the connection reset error, while mptcp_inq_hint() returns 1 instead of 0?

Should subflow_is_done() also check sock_flag(sk, SOCK_DONE) (or check for
the absence of sk->sk_err) so that an abortive reset on a fallback subflow
does not synthesize a clean data fin?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792718041.gi=
t.tanggeliang@kylinos.cn?part=3D6
