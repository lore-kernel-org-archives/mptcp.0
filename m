Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793260375;
	b=esK27vn0f6A0jSsLcbgUWyUbwEuVlkZ51yx3N/IBF0t7E+KLrLXC73+aR6fkUg0lwoYg
	 gjpycfvG58m5E9tzJe4coyjeTLAa+SGGOsynt365yflKseUczzyn7pPAswQ4dffVQ7oE/
	 1OqHTI3Fjm3WTYKYFzMMk6BpOPyZ/qf2u1QSPvKK3ecX7Nun7wWuRKqR6AyO8rY+u6/ve
	 LtPmryv17IYLQHgcyDzhITPr2oX9TyDZ7VdiR66CARYlDtP1tPSPrNaR2IdRSln7SoarD
	 zB1UBn2Ftwm7nFNOZkW3r4N/wUVTUnhFaRjpUgUk88shn3/VQjNdty/u0jRm1rs56fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793260375;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QVCQxNmzLO9/EkqoNUpUM9p8HNnQ/Y0aWj6dm2YXMq4=;
	b=gEKZDt4mutjK0LQwG+aU7z7GugeUcwMS8louzbgf/QKH8Z6FzdWOHj67KwUDqXk2r/I8
	 UhUZlwf51hyrZnli4CBHd3cvvWrhV7sfDWxohiZU9E6qULEC3V1Xg4qeDNeF2Bxl0JTPW
	 zwZ6oMNaL1JXYRofF4VE1+E5GJr7oKIfwLJUnunLwSORT5HZXAjL7ZKQmInYlr4p2fwXH
	 +qREngHqCgUpxtUFkHHmS7EkSFnymTMzmwcwlW78Abpq1UHtzWgVdBsQUdMeQ/KEbP0TD
	 MlhBpBFFsCdVmLRfDRppM83IyPILRJKEHpj1EvbkUjeLmB66o6YJ+kjCT9NbDy4VEXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SDCyv1oe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C74A606A31A
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 07:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SDCyv1oe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221CD1F01825;
	Thu, 29 Oct 2026 07:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793260375;
	bh=QVCQxNmzLO9/EkqoNUpUM9p8HNnQ/Y0aWj6dm2YXMq4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=SDCyv1oeCFHzvfJ9o6Go4vNNGSLwqaayM91RGvIGokFAygWMkQnpffKyv3Mk7oX35
	 u6RoWFoPCBytgUu327RGzJqWBtioOD6lJv5iF8PGwBduLrYPdmNGPZc7I42lB0+3rB
	 PLfgdSVuXed7pGLx2oFUu+fN2o/PXYZAFCN3sDu2Vu8SsWourbzww1uKp0BSfvuA+t
	 5gdyoVEpN1hLmZ9sR+/WdZCZ82gll3A4GAcOxGXP+ZEFfl54sG+D2J5RIwFE1b+IWh
	 Zj1tx/ZfkflWjwJ34B/wR2usMNYely+2ESOV5CrrqoRaaoU84GmLhZB/D9/aEtDAIv
	 CkZZpopW5mPMQ==
Message-ID: <sashiko-outbox-188915@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v2 2/5] mptcp: implement peek_len for
 proto_ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <5a0397c9d6a1bdbb1ddeb7b2c900a8c1184dee59.1793258749.git.tanggeliang@kylinos.cn>
References: <cover.1793258749.git.tanggeliang@kylinos.cn>
 <5a0397c9d6a1bdbb1ddeb7b2c900a8c1184dee59.1793258749.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 07:52:54 +0000
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
- [High] mptcp: off-by-one undercount in mptcp_inq() when rcv_data_fin is s=
et
--

commit 9982b9cd38095d8d40ec92ab4d0f1aec03009b6d
Author: Geliang Tang <geliang@kernel.org>

mptcp: implement peek_len for proto_ops

This commit adds mptcp_inq() and wires it into mptcp_peek_len() to implement
the .peek_len callback for both IPv4 and IPv6 MPTCP stream proto_ops. It
computes available bytes using mptcp_data_avail() and subtracts 1 when
msk->rcv_data_fin is set.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 0caa31525b907..6f34e3459e8ac 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -4797,6 +4797,33 @@ static ssize_t mptcp_splice_read(struct socket *so=
ck, loff_t *ppos,
>  	return ret;
>  }
> =20
> +static int mptcp_inq(struct sock *sk)
> +{
> +	const struct mptcp_sock *msk =3D mptcp_sk(sk);
> +	u64 avail;
> +	int answ;
> +
> +	if ((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV))
> +		return 0;
> +
> +	avail =3D mptcp_data_avail(msk);
> +	if (avail >=3D INT_MAX)
> +		return 0;
> +
> +	answ =3D (unsigned int)avail;
> +
> +	/* Subtract 1, if DATA_FIN was received. Mirror tcp_inq() */
> +	if (answ && READ_ONCE(msk->rcv_data_fin))
> +		answ--;

[Severity: High]
Does subtracting 1 when msk->rcv_data_fin is set cause mptcp_inq() to
under-report the readable payload by 1 byte?

In tcp_inq(), 1 is subtracted from tp->rcv_nxt - tp->copied_seq when a fin =
is
received because tp->rcv_nxt advances by 1 for the fin sequence number. Her=
e,
however, mptcp_inq() starts from mptcp_data_avail(msk):

net/mptcp/protocol.h:mptcp_data_avail() {
	return READ_ONCE(msk->bytes_received) - READ_ONCE(msk->bytes_consumed);
}

When a subflow receives a mapping with data_fin set, get_mapping_status() in
net/mptcp/subflow.c strips the 1 byte of sequence space before the payload =
is
queued:

net/mptcp/subflow.c:get_mapping_status() {
	...
		mptcp_update_rcv_data_fin(msk, data_fin_seq, mpext->dsn64);
		pr_debug("DATA_FIN with mapping seq=3D%llu dsn64=3D%d\n",
			 data_fin_seq, mpext->dsn64);

		/* Adjust for DATA_FIN using 1 byte of sequence space */
		data_len--;
	...
}

And when mptcp_check_data_fin() in net/mptcp/protocol.c later processes the
pending fin, it only advances msk->ack_seq while clearing msk->rcv_data_fin:

net/mptcp/protocol.c:mptcp_check_data_fin() {
	...
	if (mptcp_pending_data_fin(sk, &rcv_data_fin_seq)) {
		WRITE_ONCE(msk->ack_seq, msk->ack_seq + 1);
		WRITE_ONCE(msk->rcv_data_fin, 0);
	...
}

Since msk->bytes_received only ever counts actual payload bytes queued into
sk->sk_receive_queue, mptcp_data_avail(msk) never includes the extra sequen=
ce
byte.

When a peer sends the final bytes of a message together with data_fin (or
when data_fin arrives out of order while unread payload is queued),
mptcp_data_ready() -> move_skbs_to_msk() in net/mptcp/protocol.c moves the
payload to sk->sk_receive_queue, defers mptcp_check_data_fin() to
mptcp_worker:

net/mptcp/protocol.c:move_skbs_to_msk() {
	...
	if (mptcp_pending_data_fin(sk, NULL))
		mptcp_schedule_work(sk);
	return moved;
}

and immediately invokes sk->sk_data_ready(sk) while msk->rcv_data_fin is
still 1.

When strparser (used by ktls rx, kcm, and sockmap) handles that callback via
strp_data_ready() -> strp_recv() in net/strparser/strparser.c:

net/strparser/strparser.c:strp_recv() {
	...
			if (stm->strp.full_len - stm->accum_len >
			    strp_peek_len(strp)) {
				/* Don't have whole message in the socket
				 * buffer. Set timer to wait for the rest
				 * of the message.
				 */
	...
}

strp_peek_len() -> mptcp_peek_len() -> mptcp_inq() will return 1 byte less
than the actual unread payload, causing strp_recv() to stop reading and sta=
ll
until the message timeout expires?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793258749.gi=
t.tanggeliang@kylinos.cn?part=3D2
