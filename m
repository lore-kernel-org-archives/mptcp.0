Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795811057;
	b=bJFcZIhVAGf7oa5mcLjd9BRQ+GQTnVlrxWGZH9jnPalgdeS71ppPpKlxOSWT/uESgh9I
	 UAGmqc8oVNkT+/RLj7xcWVs3MXWuOTUvi6rGsWYeMPvQed8qmOkmWH5BG3BvpmSADIL+y
	 2jBE8YCEeK6sh3QQsbp1XVAtXane+DrqAM0TqHwXVFIX3izd7NXsG8b0o5eCxVoODaxaG
	 XVuxvKuvR6UKe1J3v7C3Pu4DEb01opv2nDrirRGqZdPHCKFM6+jJ35yhH7N2Y1zsqJDQP
	 GpcXO3Osv392AOrXdvOXB2iCrMEbStpKmjopgC48vqLsrf0X9Yoj3en/yoFWlubpkLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795811057;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TawOcPTyEUo6+wR4odaqfANVjTEj1LyIQLovFWvI6So=;
	b=a0DXW82nLpgnZulcuNNdSoHYxlWNA6/LTMSe9kRLTVtjMieabWlEeqGMtcjFii8ylcwq
	 JIm4m48FSt/xsFmpDbvzkZnbmOWSMgyxxrO90k/5tlltUobo2eb/RoP7LCGrM33s/WQtk
	 6c3dL15SUrM8BnUymPDBFMorUJv4pMM6B22uXhCP3Z/1jhdy11nl5S1B3L7axSsGsG0tD
	 eHvG7FP6G7HZzXAeqUqavcgfqP+zSTM4gnroT7PNJGh/VhX83SdFuX8ElyazDo1y61vrt
	 iNu7A1tR3tpNvjWkVGjVyejBOtqekNo35sxr222PtIF7RNUAx78WLPgbtRBeluaRiVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KEMEj0xC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AB9606A31C
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 20:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KEMEj0xC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4EA1F00898;
	Fri, 27 Nov 2026 20:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795811056;
	bh=TawOcPTyEUo6+wR4odaqfANVjTEj1LyIQLovFWvI6So=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=KEMEj0xCoFdRDqDpdmyQk9DIxWh3mLES7IJUtKJyUc0y8nZPv8/kgjBckFt+EvS2i
	 g4RFk8auk26SAhmoAjnKoYdbTuHgbqrmohhdg61fVTnnOOM3CFRyFV2pjNo56xnAP4
	 osMGqkQSPtRvKjv4mkVaEjKkEpgU/Otz1O/VkfG9DYtpkeTb/TyOw1EAudA+QaldR+
	 Pec0oDsC4zQmwQHxYneZFe2zuNAb/AioN9LXiqVaezo206VXDgDljyHU0rLcMQjztx
	 WgOuQB8kwWSqAVcmSkm/dy9dTO8oH4HIad9Rk/68SLF9IJjclWHZHgb1UVh/c/CSNX
	 lHOE30VQjOaag==
Message-ID: <sashiko-outbox-238235@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next mptcp-net v4 19/20] mptcp: set ECONNRESET on
 disconnect, as TCP does
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>, "MPTCP
 Linux" <mptcp@lists.linux.dev>
In-Reply-To: <20261127-mptcp-cmason-fixes-v4-19-3f393ea8c48d@kernel.org>
References: <20261127-mptcp-cmason-fixes-v4-0-3f393ea8c48d@kernel.org>
 <20261127-mptcp-cmason-fixes-v4-19-3f393ea8c48d@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 20:24:16 +0000
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
- [Medium] mptcp: sk_err set after TCP_CLOSE and wakeup in
  mptcp_disconnect()
--

commit b176961a8f073aaa73d94f5077f010ae3ab9c003
Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>

mptcp: set ECONNRESET on disconnect, as TCP does

This commit sets sk->sk_err to ECONNRESET in mptcp_disconnect() when an
active or partially closed MPTCP connection is aborted, matching
tcp_disconnect().

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index d8661fba643a9..fd6a72d375aac 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3957,6 +3957,7 @@ static int mptcp_disconnect(struct sock *sk, int fl=
ags)
>  {
>  	struct inet_connection_sock *icsk =3D inet_csk(sk);
>  	struct mptcp_sock *msk =3D mptcp_sk(sk);
> +	bool aborted;
> =20
>  	/* We are on the fastopen error path. We can't call straight into the
>  	 * subflows cleanup code due to lock nesting (we are already under
> @@ -3965,6 +3966,13 @@ static int mptcp_disconnect(struct sock *sk, int f=
lags)
>  	if (msk->fastopening)
>  		return -EBUSY;
> =20
> +	/* as tcp_disconnect() */
> +	aborted =3D ((1 << sk->sk_state) &
> +		   (TCPF_SYN_SENT | TCPF_ESTABLISHED | TCPF_CLOSE_WAIT |
> +		    TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2)) ||
> +		  (((1 << sk->sk_state) & (TCPF_CLOSING | TCPF_LAST_ACK)) &&
> +		   msk->snd_nxt !=3D msk->write_seq);
> +
>  	mptcp_check_listen_stop(sk);
>  	mptcp_set_state(sk, TCP_CLOSE);
>  	inet_clear_bit(DEFER_CONNECT, sk);
> @@ -4020,6 +4028,8 @@ static int mptcp_disconnect(struct sock *sk, int fl=
ags)
> =20
>  	WRITE_ONCE(sk->sk_shutdown, 0);
>  	sock_reset_flag(sk, SOCK_DONE);
> +	if (aborted)
> +		WRITE_ONCE(sk->sk_err, ECONNRESET);
>  	sk_error_report(sk);
>  	return 0;
>  }

[Severity: Medium]
Can setting sk->sk_err at the end of mptcp_disconnect() cause concurrent
pollers to miss EPOLLERR?

mptcp_poll() runs locklessly: it loads sk->sk_state (setting EPOLLHUP on
TCP_CLOSE), executes smp_rmb(), and then reads sk->sk_err to set EPOLLERR.
Because mptcp_disconnect() sets TCP_CLOSE first and then calls
mptcp_destroy_common() -> __mptcp_close_ssk(), closing the last subflow
sees sk->sk_state =3D=3D TCP_CLOSE and calls mptcp_close_wake_up(sk) before
sk->sk_err is written:

CPU0                                  CPU1
mptcp_disconnect(sk)
  mptcp_set_state(sk, TCP_CLOSE)
  ...
  mptcp_destroy_common(msk)
    __mptcp_close_ssk(...)
      if (sk->sk_state =3D=3D TCP_CLOSE)
        mptcp_close_wake_up(sk)
          sk->sk_state_change(sk)
                                      /* woken in poll() / epoll_wait() */
                                      mptcp_poll()
                                        state =3D inet_sk_state_load(sk)
                                        /* state =3D=3D TCP_CLOSE -> EPOLLH=
UP */
                                        smp_rmb()
                                        READ_ONCE(sk->sk_err) =3D=3D 0
                                        /* returns without EPOLLERR */
  ...
  WRITE_ONCE(sk->sk_err, ECONNRESET)
  sk_error_report(sk)

A thread sleeping in poll(), select(), or epoll_wait() can wake up on
mptcp_close_wake_up(), observe TCP_CLOSE with sk->sk_err =3D=3D 0, and retu=
rn
EPOLLHUP without EPOLLERR.  Should WRITE_ONCE(sk->sk_err, ECONNRESET) (with
smp_wmb(), as in mptcp_close_err() and __mptcp_subflow_error_report())
happen before mptcp_set_state(sk, TCP_CLOSE)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-mptcp-cmas=
on-fixes-v4-0-3f393ea8c48d@kernel.org?part=3D19
