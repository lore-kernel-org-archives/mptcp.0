Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752FA2C11C4
	for <mptcp@lists.linux.dev>; Fri, 28 Aug 2026 04:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787890214; cv=none; b=q/x4NoGdhtfFEA2HG7LZ+4TB2/23uCne0FNQoXgsXO8T7I3lah5UgV9wwuykmmo895jQap1/DGt6TpWF5WQd6vN4ktp07V71EkkFlLSsGUptD5c1O/umqUtWiYd9Vwf+NipCLGSzNmpEjG/23LEhkgywdRuEgO4ILO/0anh1oa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787890214; c=relaxed/simple;
	bh=hi3uOR4r4E1KRouqEP3vtFyA1T3+LO4oVZijPJq2UCg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rl0rhalkLIF8V/X1LZwOnfavSv6hA3cpTzDka7VAYUoMi/s8RpRry0Fh0/XlMvGzzkkdFW8nS8tER1+YtNP99P4/gLIbtIIBgQsduOzBBKTbv0mbCqie3mQjWaTlFXqedldwYDnnX0yJ8wuw4K6MEvuX/EFZ5r34xwTzls7Mj8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7x7zrch; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7x7zrch"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C714C1F000E9;
	Fri, 28 Aug 2026 04:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787890213;
	bh=IcfaYMx/87oUPtzxYubFTGEVFb05dnPzDBnZgmwVnMY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V7x7zrchAQQAl6ZtVUhm1RBEWzlDyC5p8uR1ulsdGotvMSjqZve5OD/Uzrp+4N1lE
	 M1c3YtU+AAvBltCQTfLXY53skW7gupj9XkFxi8+08wvTURoSx3P5pTrkjwx/bJfsUw
	 uxihRq/ZlVZVt+hosAYgNpkGmsX5lwvBk9l8hy/dPYvjuWMOdKI9HzLq6bauJFMSR9
	 4ug7W7w5Z1z5FxZDHKQr9BEYV0OOwALrrXCnXisH0AcjpPd0DQ90lw72LAP51Mr12O
	 aI/9Tn6zzM8tmPGKO/MQT+l7wCompGdyV5N1TUyhF7F02LnoUG1SDn4gv3lSlAvNeE
	 mB2EQg9EmrDFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v10 6/9] mptcp: implement peek_len for
 proto_ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <7b1fabcac57f36b0723d6ec1cac7b20dab1bbf86.1787888115.git.tanggeliang@kylinos.cn>
References: <cover.1787888115.git.tanggeliang@kylinos.cn>
 <7b1fabcac57f36b0723d6ec1cac7b20dab1bbf86.1787888115.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 04:10:12 +0000
Message-Id: <20260828041012.C714C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mptcp_inq() erroneously subtracts 1 from the available data count =
when the socket is locally shut down (SHUT_RD) or closed (TCP_CLOSE) withou=
t receiving a remote DATA_FIN.
--

commit ca4f6417172a744b76ad119fab38d5b6d5931a48
Author: Geliang Tang <geliang@kernel.org>

mptcp: implement peek_len for proto_ops

This commit adds mptcp_inq() to compute readable bytes at the MPTCP level
by calculating the difference between ack_seq and copied_seq. It also
wires this calculation into the .peek_len stream operations so upper layers
can accurately query the in-queue byte count.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index fce85967b90ee..639122b7845a6 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
[ ... ]
> @@ -4797,6 +4797,39 @@ static ssize_t mptcp_splice_read(struct socket *so=
ck, loff_t *ppos,
>  	return ret;
>  }
> =20
> +static int mptcp_inq(struct sock *sk)
> +{
> +	const struct mptcp_sock *msk =3D mptcp_sk(sk);
> +	int answ;
> +
> +	if ((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV)) {
> +		answ =3D 0;
> +	} else if (test_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
> +		answ =3D 0;
> +	} else {
> +		u64 hint_val;
> +
> +		hint_val =3D READ_ONCE(msk->ack_seq) - READ_ONCE(msk->copied_seq);
> +		if (hint_val >=3D INT_MAX)
> +			hint_val =3D INT_MAX;
> +
> +		answ =3D (unsigned int)hint_val;
> +
> +		/* Subtract 1, if FIN was received. Mirror tcp_inq() */
> +		if (answ &&
> +		    (sk->sk_state =3D=3D TCP_CLOSE ||
> +		     (sk->sk_shutdown & RCV_SHUTDOWN)))
> +			answ--;

[Severity: High]
Does this logic correctly handle local shutdowns or connections reset via R=
ST?

If an MPTCP socket has 1 byte of unread data and a local application calls
shutdown(fd, SHUT_RD), it sets RCV_SHUTDOWN without incrementing ack_seq
because no remote DATA_FIN was received.

Since this subtracts 1 from the answer, it would return 0. Could this cause
kernel consumers of .peek_len() (like KTLS/BPF strparser) to falsely assume
no data is available and hang indefinitely waiting for data that will never
arrive on the shut down socket?

> +	}
> +
> +	return answ;
> +}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787888115.gi=
t.tanggeliang@kylinos.cn?part=3D6
