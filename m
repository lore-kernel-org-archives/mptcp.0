Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795811393;
	b=D22Az0ZVRirXpDiJAXK8aF5tPAUX5+gOJufu+94ONLg49+vOqvLifBEFDJYRiM/wJRRK
	 3J1w3vbD4JLF+3kqRs+J7eU8eM/QI9Y4i2TpnkHQ4zNAkxYrzu+leMaduWYLcymgMdsiR
	 8wBDwCGvsegH1ID8DK7+eXyM6ophNvIkPlWcxrGZQoM0F7LVNFZqMbJyTCZFpXt9kR5rn
	 NMQ5JlqpGfiYC4kf+cj7AHVj3T+y9bYfgPdm4NkDi+XCYlA0CHZIVsO7yMqXyBXA8HvWz
	 wMsLp3Tt03eZefBTHY4nCD53CWIzJyd6KcCpMYLOyM45kcEFc7mD0+og7Y3yRvxKxUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795811393;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QVFEsHKxikHGq4FGuxGWRRsPbZjka+4Rf58oxSKSR64=;
	b=SoZ2+SvFt5kCFxXh2uWZAoJVjmcRyBUwtTyewPrdv5bzHwK9h0PIHAqM6z7T0a+Ku+ik
	 Nqgly7hb7qoVT1n7Xfwsbb0isQZJl5URG+iRxIi+Gs2ZCRMa0ie/GBBEGlMNEgJC1X0LO
	 iglMKHXgIKAa/oMTo7pSZE9J69aqX9I8hXAwtMZcOIzwmHByyZfgaNn2Duj5tWXnwgus7
	 rHpwzQINKQClnyJI549Z/QsHlwDqT/IXymVUfI6cuB7G9bSFBQwu7UcnacBNV3MEQgNEK
	 /iCkdOtcw9GkowYEIoy4qFDcojZpVAP0dB6Y6TAUlj1BAyWRf/lMlU/OxVxidYANZbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="U/qJ89xV";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99061606A31C
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 20:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U/qJ89xV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25AD81F000C1;
	Fri, 27 Nov 2026 20:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795811393;
	bh=QVFEsHKxikHGq4FGuxGWRRsPbZjka+4Rf58oxSKSR64=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=U/qJ89xVhDDGsbFO2nP1nJQMGZmSjniDrJC3pLyqlkt5rJ+/N6qy+XJWscuVYc+d6
	 P7E6TMpiSfui7JIbbD9kaRnUj4pOI6+WRhYdJf6/R1D7GZDC+GzubhD9qZ3F0wxRKu
	 COPcZGpZ3zpeu7tv5ZgmXjhAESUUrs/wGQBCJ5DVSA0GwyPYAW4WW1KsKICR/9rUK/
	 idt9vj9zQ6ttkIj7xYY8D11UlVs3CNRfd+ZY/4kdSD8YtWc+pqNsuIhjQRZFkbj/qN
	 KIYJLNBDNzAfMPrg0eCJ7RsUfxjHZskiFiv5XO9AUzBUMh/R36DOzTg6112SS27acs
	 JY73pnBP4BILg==
Message-ID: <sashiko-outbox-238242@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next mptcp-net v4 16/20] mptcp: push pending data
 after a fallback on reception
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>, "MPTCP
 Linux" <mptcp@lists.linux.dev>
In-Reply-To: <20261127-mptcp-cmason-fixes-v4-16-3f393ea8c48d@kernel.org>
References: <20261127-mptcp-cmason-fixes-v4-0-3f393ea8c48d@kernel.org>
 <20261127-mptcp-cmason-fixes-v4-16-3f393ea8c48d@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 20:29:52 +0000
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
- [Medium] mptcp: missing snd_una update and rtx_queue cleanup in
  mptcp_data_ready()
--

commit 7e3a760d0b9eb64d294440dba08a325c185e5bb7
Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>

mptcp: push pending data after a fallback on reception

This commit pushes pending send data from mptcp_data_ready() when an
incoming data packet triggers a fallback to plain TCP after
mptcp_incoming_options() has already run.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 178792ebcc787..64fc04ea997c8 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1077,6 +1077,10 @@ void mptcp_data_ready(struct sock *sk, struct sock=
 *ssk)
>  	} else {
>  		__mptcp_move_skbs_from_subflow(msk, ssk, false);
>  	}
> +
> +	/* mptcp_incoming_options() can't push if this data caused a fallback */
> +	if (__mptcp_check_fallback(msk) && sk_stream_memory_free(ssk))
> +		__mptcp_check_push(sk, ssk);
>  	mptcp_data_unlock(sk);
>  }

[Severity: Medium]
Should this fallback path also advance msk->snd_una to msk->snd_nxt and
call __mptcp_data_acked(sk), like the fallback block in
mptcp_incoming_options() does?

net/mptcp/options.c:mptcp_incoming_options() {
	if (__mptcp_check_fallback(msk)) {
		...
		if (sk_stream_memory_free(sk))
			__mptcp_check_push(subflow->conn, sk);

		/* on fallback we just need to ignore the msk-level snd_una, as
		 * this is really plain TCP
		 */
		__mptcp_snd_una_update(msk, READ_ONCE(msk->snd_nxt));

		__mptcp_data_acked(subflow->conn);
		mptcp_data_unlock(subflow->conn);
		return true;
	}

When an incoming data packet triggers a fallback after
mptcp_incoming_options() has already run, omitting those calls leaves
dfrags up to msk->snd_nxt on msk->rtx_queue and charged to
sk->sk_wmem_queued until the peer sends another packet.  If the local
sender filled sk->sk_sndbuf and the peer waits for more data before
sending again, mptcp_write_space() sees sk->sk_wmem_queued still full and
never wakes the blocked writer.  It also leaves
sk->mptcp_retransmit_timer armed, causes mptcp_ioctl_outq() to overreport
SIOCOUTQ, and skips the mptcp_pending_data_fin_ack() check in
__mptcp_clean_una().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-mptcp-cmas=
on-fixes-v4-0-3f393ea8c48d@kernel.org?part=3D16
