Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795319667;
	b=V2IPqB4eKnxhFJE7V1nsp8vVbEwcyhFRau9ZQ4aI2350DinybDqRteUoEPhWrSe+poU2
	 fkDQmW0eTkKL/X97VyICbkGz0HVHlHkC7Z+448C/A5FXFW5qToBY6rUh/dMXZYGa+tI2A
	 vqS6fF2iLMxH2POj2IpEAnJh9XBxiSn/kge+rkPrs+gYPHJaQp192pbNGeRrnxdlvHejF
	 /Bud5MYLn22WOxrHC6CNshWngV4yzSRQePfN9YSj3nuMnmx1nP/TFheNTC36M4uXdY5qW
	 1otIz4NfJl9q7jjmnOvsbSvM2kJrL6pyuFd+VmCc0ovUt9XJ51T6CuPDFO7d+nCJUHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795319667;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tM05bi7xaa7/hE2x3WNZSccp1cNpAeivAeAuEsP/b3M=;
	b=M7siG9CMC2fy672FaQFpdLplXM6By3rn5VVh7MqNstmczO2YSwD5BkCS1jx6jtP41IXD
	 AQTAGIBKbjt1YBwAunOwMvz7IOIACvhG+iMSvPSJQv1xcNFDao7J8sZLoUHaaPCHiKOQ3
	 5sIfPoQBuEtJud5uBoh45zRovEw8afs/J94X9gmvaAAvVZoXx758UO09QhEJglJVmo7mt
	 1xtp14WFeg/xeKZic+vbVrKf50haI8TSnn01P50kg6iJolQ4LFHhWGuzue5WWcEDt6Ked
	 I1wPr3I210SA9GHmK4XDHL42vvNOrKvEzQaHq74FzMag2USvpkOePRPKaNOsB9c7ISg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HgrfODdl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA8F606A32A
	for <mptcp@lists.linux.dev>; Sun, 22 Nov 2026 03:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HgrfODdl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B26E1F000C0;
	Sun, 22 Nov 2026 03:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795319667;
	bh=tM05bi7xaa7/hE2x3WNZSccp1cNpAeivAeAuEsP/b3M=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=HgrfODdlDMFwEc5W2OaoF72f6OhkEhwTBeh0hy//v6ktFcuMTDKAxSCIUBYJ209mY
	 EmOsYplIAspGo2rwwXq8daj5W+vi5JMfhWXB+VUPaZ9YHpmiFmE30o7wUZwTzQD8V3
	 Un3w49jTOTYqhBhVwOTVw+zIoa1ZrdoFbnzpB/QZasBunveG8G2rMVZSzvIVibUT53
	 4v0yZ6st6bgOluI1UJSJJytssTYrxL8dZF/cBqVESOVJ81xB3pY/HMqLG3P8qpwcip
	 eikTiUj6XgmlINMAA+quqRRiS56Hu151HEJw0yPTHL3s3AXeg0el/kVHK0y27nsJaZ
	 1JtLFIkL3fESw==
Message-ID: <sashiko-outbox-227687@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-net 3/4] mptcp: fix TFO SIOCINQ overflow in
 mptcp_inq_hint
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <05dcaa680dcd6cdf91aa1204a20c2c754aa28cc5.1795318567.git.tanggeliang@kylinos.cn>
References: <cover.1795318567.git.tanggeliang@kylinos.cn>
 <05dcaa680dcd6cdf91aa1204a20c2c754aa28cc5.1795318567.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 03:54:26 +0000
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
- [Medium] mptcp: premature FIN byte accounting in mptcp_data_fin_seq()
- [Medium] mptcp: zero rcv_data_fin_seq missed in mptcp_inq_hint() on
  TCP fallback
--

commit 7f3583a035d8da6607d3d80aed0de39c52b747e0
Author: Geliang Tang <geliang@kernel.org>

mptcp: fix TFO SIOCINQ overflow in mptcp_inq_hint

This commit updates mptcp_inq_hint() to compute available bytes via
mptcp_data_avail() and adds mptcp_data_fin_seq() to account for the
received DATA_FIN byte.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 259a16068afad..0ac762fc6210c 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2154,6 +2154,18 @@ static void mptcp_eat_recv_skb(struct sock *sk, st=
ruct sk_buff *skb)
>  	skb_attempt_defer_free(skb);
>  }
> =20
> +static u64 mptcp_data_fin_seq(const struct sock *sk)
> +{
> +	const struct mptcp_sock *msk =3D mptcp_sk(sk);
> +
> +	if (!(READ_ONCE(msk->rcv_data_fin) ||
> +	      sk->sk_state =3D=3D TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN)=
))
> +		return 0;
> +
> +	smp_rmb(); /* pair with smp_wmb() in mptcp_update_rcv_data_fin() */
> +	return READ_ONCE(msk->rcv_data_fin_seq);
> +}

[Severity: Medium]
Does mptcp_data_fin_seq() report the FIN before all preceding data has
arrived in order?

get_mapping_status() calls mptcp_update_rcv_data_fin() as soon as a
subflow skb carrying DATA_FIN reaches the head of ssk->sk_receive_queue,
even if that mapping arrived out of order while earlier DSN data is still
in flight on another subflow (or on the first segment of a multi-segment
DSS mapping carrying DATA_FIN).  Unlike mptcp_pending_data_fin(),
mptcp_data_fin_seq() does not check !before64(READ_ONCE(msk->ack_seq),
rcv_data_fin_seq).

While msk->ack_seq is still behind msk->rcv_data_fin_seq, mptcp_inq_hint()
adds 1 for the FIN before RCV_SHUTDOWN is set, so SIOCINQ and TCP_CM_INQ
report N + 1 when only N in-order bytes are readable before the gap (or 1
when a non-blocking recvmsg() will return -EAGAIN).

> @@ -2364,22 +2376,15 @@ static bool mptcp_move_skbs(struct sock *sk)
>  static unsigned int mptcp_inq_hint(const struct sock *sk)
>  {
>  	const struct mptcp_sock *msk =3D mptcp_sk(sk);
> -	const struct sk_buff *skb;
> -
> -	skb =3D skb_peek(&sk->sk_receive_queue);
> -	if (skb) {
> -		u64 hint_val =3D READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
> +	u64 hint_val =3D mptcp_data_avail(msk);
> =20
> -		if (hint_val >=3D INT_MAX)
> -			return INT_MAX;
> +	if (hint_val >=3D INT_MAX)
> +		return INT_MAX;
> =20
> -		return (unsigned int)hint_val;
> -	}
> +	if (mptcp_data_fin_seq(sk))
> +		hint_val +=3D 1;
> =20
> -	if (sk->sk_state =3D=3D TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN))
> -		return 1;
> -
> -	return 0;
> +	return (unsigned int)hint_val;
>  }

[Severity: Medium]
Can mptcp_inq_hint() miss the FIN byte when msk->rcv_data_fin_seq is 0 on
a TCP fallback connection?

When an active connection falls back to plain TCP in
subflow_finish_connect(), subflow_set_remote_key() is not called, leaving
subflow->iasn, subflow->map_seq and msk->ack_seq at 0.  If the peer closes
the connection without sending any payload, subflow_sched_work_if_closed()
records the dummy DATA_FIN with sequence 0:

net/mptcp/subflow.c:subflow_sched_work_if_closed() {
	...
	if (__mptcp_check_fallback(msk) && subflow_is_done(ssk) &&
	    msk->first =3D=3D ssk &&
	    mptcp_update_rcv_data_fin(msk, subflow->map_seq +
				      subflow->map_data_len, true))
		mptcp_schedule_work(sk);
}

Because msk->rcv_data_fin_seq is 0, mptcp_data_fin_seq(sk) returns 0 and
mptcp_inq_hint() returns 0 instead of 1 after the peer's FIN.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795318567.gi=
t.tanggeliang@kylinos.cn?part=3D3
