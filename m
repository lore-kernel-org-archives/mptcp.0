Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793562145;
	b=LMeewKbDaUaHCBvHZ5zoKuylSmooUeHljE89S44fqQuiZV/r5DUXycimct9tEKG6yCku
	 ehumhm3Zvx5QisTnh1OjMr5li8XpbW1mFnFVuy8AYcI6weaUhbqRi9kxMfMoLrLk4kp8D
	 ZXv2Axzqf7qhh8iHHAXz7eIYA7H/G0RcPCT4xNhGpOjccY/GMshDvpDTdKpBOfen7hs7Z
	 IWHJT/AlxzYQxz6A6xedly5RDbw5jXid2wufwfp6ZcjKmk1E9YRJKWI/rzGiusJ5iBRdD
	 oATzR0rIUSGLjHTnnW6isPL5wJZ/2MGR/lvji/qzG05zINEEuuE5iDm0qRUQJx9ygxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793562145;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ou2CWqyOX19zXhgRxQT3aRF18Pi5mS4L54mPCi0Zwf4=;
	b=b9U/vxMG9xt18AS81xcLJGb0MTPOVzhVqdQatMXNgbNZh0IndKi8BKjBqxfBegj2s7rC
	 BIGSK1IM/Up4vFJra0/hj5rajhKlzuPxPSqnu7kbXvSLJIiWpKriFzyHsHYfX6HZfm8/+
	 Ae+Qa3uEEVtBoHZUIEYjjXM6qonLaNVKbfhr70KWcPz1T6KJ4ztVvLBtrZ5uGtkIPztNo
	 Ns5v4tad0SrHKZPrnEVoLIlgDgblfThJLYnYF89abMG2kaYsHdKILtkwdbwcfOURlxgWt
	 cxzuYziAGn6LxAhpIr7Hj3OKrxMlMoYaDUHIn78p5eobksiLYviB9ar5CFvmikwZAew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ND9EpqCd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695E8606A324;
	Sun,  1 Nov 2026 19:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ND9EpqCd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C45F91F000C1;
	Sun,  1 Nov 2026 19:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793562145;
	bh=Ou2CWqyOX19zXhgRxQT3aRF18Pi5mS4L54mPCi0Zwf4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ND9EpqCdXEVZIBhApfIC7uK4IlDDcgtEQg7JxiK8Sf/Qu8i8w6ARn+5AQnJBAwoqI
	 zO585jQVAfgj6izGpDjReHiq6qZ8/GRv0myzboGNGy8kVC9lEbiRXLwTRv5KuUC9mQ
	 tCeX6qfhtwPYkjcO845+Do2WXFKv8Ru/ON/DzURYHkSwjT46vsardJQoslQcJ3EOsx
	 ovErVZL1rniJeaGlcX0nn4HNlc0ywk0Ai34SyYWih8eIeK76oPJ72AJcH300JHyNkt
	 fdkFdafCuYe3TMtkM/1TZahNvsp3+FUyeA1GCzbKXqYrDzeDVzGOBt1LPgA5Rj7d8a
	 9Ttingd64EAzA==
Message-ID: <sashiko-outbox-192629@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 03/15] bpf, sockmap: Don't let an SK_PASS verdict
 cover the next message
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: mptcp@lists.linux.dev
In-Reply-To: <20261101192057.2296489-4-alexei.starovoitov@gmail.com>
References: <20261101192057.2296489-1-alexei.starovoitov@gmail.com>
 <20261101192057.2296489-4-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 19:42:24 +0000
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
- [High] bpf: corrupt verdict state after tcp_bpf_push() in tcp_bpf_send_ve=
rdict()
--

commit cb1b40f55f45104a6d23bf64e86e3c0a379b2459
Author: Alexei Starovoitov <ast@kernel.org>

bpf, sockmap: Don't let an SK_PASS verdict cover the next message

This commit resets psock->eval before calling tcp_bpf_push() when
psock->apply_bytes is 0, and subtracts any sent bytes from
psock->apply_bytes if tcp_bpf_push() fails.

> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index d90bcc911b36b..072ffd8347a6f 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -457,8 +457,14 @@ static int tcp_bpf_send_verdict(struct sock *sk, str=
uct sk_psock *psock,
> =20
>  	switch (psock->eval) {
>  	case __SK_PASS:
> +		/* The push may sleep without the socket lock, and it may fail */
> +		if (!psock->apply_bytes)
> +			psock->eval =3D __SK_NONE;
> +		origsize =3D msg->sg.size;
>  		ret =3D tcp_bpf_push(sk, msg, tosend, flags, true);
>  		if (unlikely(ret)) {
> +			/* A part of it may have gone out */
> +			sk_msg_apply_bytes(psock, origsize - msg->sg.size);
>  			*copied -=3D sk_msg_free(sk, msg);
>  			break;
>  		}

[Severity: High]
Can this corrupt a concurrent sender's verdict state or leave psock->eval
set when psock->apply_bytes reaches 0?

In tcp_bpf_send_verdict() under case __SK_PASS, if Thread A enters with
psock->apply_bytes =3D=3D 0, it resets psock->eval =3D __SK_NONE before cal=
ling
tcp_bpf_push(). If tcp_bpf_push() -> tcp_sendmsg_locked() releases the
socket lock in sk_stream_wait_memory(), a concurrent Thread B in
tcp_bpf_sendmsg() -> tcp_bpf_send_verdict() can see psock->eval =3D=3D __SK=
_NONE,
run sk_psock_msg_verdict(), and install a new psock->eval (including
__SK_REDIRECT with psock->sk_redir) and psock->apply_bytes.

When Thread A returns from tcp_bpf_push(), it still calls
sk_msg_apply_bytes() on both the error and success paths, and on success ru=
ns
the post-switch cleanup:

net/ipv4/tcp_bpf.c:tcp_bpf_send_verdict() {
	...
	case __SK_PASS:
		/* The push may sleep without the socket lock, and it may fail */
		if (!psock->apply_bytes)
			psock->eval =3D __SK_NONE;
		origsize =3D msg->sg.size;
		ret =3D tcp_bpf_push(sk, msg, tosend, flags, true);
		if (unlikely(ret)) {
			/* A part of it may have gone out */
			sk_msg_apply_bytes(psock, origsize - msg->sg.size);
			*copied -=3D sk_msg_free(sk, msg);
			break;
		}
		sk_msg_apply_bytes(psock, tosend);
		break;
	...
	if (likely(!ret)) {
		if (!psock->apply_bytes) {
			psock->eval =3D  __SK_NONE;
			if (psock->sk_redir) {
				sock_put(psock->sk_redir);
				psock->sk_redir =3D NULL;
			}
		}
}

Wouldn't Thread A subtract its own sent bytes from Thread B's
psock->apply_bytes, and if psock->apply_bytes is 0 when ret =3D=3D 0, reset
Thread B's psock->eval to __SK_NONE and drop Thread B's psock->sk_redir?

Also, on the error path (unlikely(ret)), if sk_msg_apply_bytes(psock,
origsize - msg->sg.size) reduces a non-zero psock->apply_bytes to 0 (for
instance if another sender consumed part of psock->apply_bytes while
tcp_bpf_push() slept), the post-switch block is skipped because ret !=3D 0.
Wouldn't that leave psock->eval as __SK_PASS with psock->apply_bytes =3D=3D=
 0,
causing the next message to bypass the sk_msg program?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101192057.2296=
489-1-alexei.starovoitov@gmail.com?part=3D3
