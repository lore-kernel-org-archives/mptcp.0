Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684181;
	b=Uw1hOHZ7ZIZQio9xqnKeXovTYbFAifESBUv7fnn4a49lc9U/y0slJ8sJ6W45/+xrRe9E
	 pyp3h2Xyco4nqPUr5MPvitjAtFHmSJ/HFpMLWt2cF1v/H5rQgINHT26NSHspigjurpFn/
	 S749zYM2MboWBW/cSiy6ZfGx9TIlMSz80fsG5iSlcDmIa44xP6UuT5Yd/5NMLqGjnNRWO
	 4Ja3MLyZ9k2J5XnqSV/D5Cpec6SMjN5/0iYgvG6KjDKdpHYXZLXsRJwa/256r+A7Wuycf
	 d5Mz8FFOJ5gw4bMnWdWo2G76jWiNdl5r+H6yNQLUxXwuEOo5SXINqtS3CAT+JImwcbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684181;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SjIreWJeDKQ8VGy7A/i93Byt+W2J011866PDvZl9oc8=;
	b=5gnTAZM+XY0hq2sXAIrddwcw1awfTZx6pClpWSu5IZh9UY9OPkrVhcBq0pACRLAm2ajj
	 l5fUpuSI5IXmwRiZw075hOJSlZNccSptzFTOs7ysUWEMs30+918tkDmpwaymT3pVBCMRI
	 ymPNIjo4HQtzdNlTZdoOQ9cT1b0Sw4ZdsaiB/drheFF1qwasY/vomY2JYoyztxh7Le80z
	 zMFTqLnUX/aD0GH/QdOI0Nizmn13ZmRhJG8/fTaWYv8MYFXItYoCckgKnDLmhL5WJ59v4
	 YfSuPSwWHoQ/Zs03WBjkZbO3u9KiKbTHb/xM0k2M40dOSuoiD5cLlnyaEHaE7K8llAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Za9rXPHS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43540606A31A
	for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 15:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Za9rXPHS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC6C1F01825;
	Thu, 22 Oct 2026 15:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792684180;
	bh=SjIreWJeDKQ8VGy7A/i93Byt+W2J011866PDvZl9oc8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Za9rXPHS0la13UvBRd3+FForKFHiwB0X4wqQI1EoeHSvvhWpNVtNkh4a12gU+ubIG
	 U9Q/Yxa3LmTRg6ygz7bCgirh/umJtipbJ3KmmYpxuQ61r6mpz6rBMFWgGGid+nTUxv
	 oMTzOv1cJ2/dKbO4Znf7A9LMZ6cqFGzyWjqGySSB1zEsFQjixCMv2wahAbI0CdmQTD
	 X1yNROlpfZ3lJQ/KwXIS0A2ntDCw5gXslA0nZaC12a9SbVicZtYX0UOA9d4XAzaHG1
	 Nwe5/HXP7SsHxhi41r9Myw30MZRUkoczxS0JjXECisAWeDOToRIvJfhRfi1hKc5+Oz
	 2MfFfyteaUU5w==
Message-ID: <sashiko-outbox-181728@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v8 4/6] mptcp: pm: in-kernel: retry subflows
 closed after an error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anil Kaushik" <anilkaushikwireless@gmail.com>, mptcp@lists.linux.dev
In-Reply-To: <20261022151130.2285198-5-anilkaushikwireless@gmail.com>
References: <20261022151130.2285198-1-anilkaushikwireless@gmail.com>
 <20261022151130.2285198-5-anilkaushikwireless@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 15:49:40 +0000
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
- [High] mptcp: race in mptcp_close_retry_subflows() due to unlocked ssk st=
ate check
--

commit c03fc05db7095624e90e910918ec9a00af7081a3
Author: Anil Kaushik <anilkaushikwireless@gmail.com>

mptcp: pm: in-kernel: retry subflows closed after an error

This commit teaches the in-kernel path manager to re-create established
client-initiated or joined subflows that were closed by TCP after a path
timeout error. It also closes any re-created subflows that are still
connecting when the parent MPTCP socket is closed.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 02a4f479d9d8c..f941533a1eb48 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -3501,6 +3506,34 @@ static void mptcp_check_listen_stop(struct sock *s=
k)
>  	release_sock(ssk);
>  }
> =20
> +/* Re-created subflows still connecting are useless once the msk is clos=
ed,
> + * and their SYN retransmissions could keep them around for a long time.
> + */
> +static void mptcp_close_retry_subflows(struct sock *sk)
> +{
> +	struct mptcp_subflow_context *subflow, *tmp;
> +	struct mptcp_sock *msk =3D mptcp_sk(sk);
> +
> +	mptcp_for_each_subflow_safe(msk, subflow, tmp) {
> +		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> +		int state;
> +
> +		if (!subflow->retry || READ_ONCE(subflow->fully_established))
> +			continue;
> +
> +		/* still connecting, or already disconnected by
> +		 * mptcp_subflow_shutdown(), e.g. after shutdown(SHUT_WR)
> +		 */
> +		state =3D inet_sk_state_load(ssk);
> +		if (state !=3D TCP_SYN_SENT && state !=3D TCP_CLOSE)
> +			continue;
> +
> +		/* it never carried data: nothing to push or re-inject */
> +		mptcp_pm_subflow_check_next(msk, subflow);
> +		__mptcp_close_ssk(sk, ssk, subflow, 0);
> +	}
> +}

[Severity: High]
Can mptcp_close_retry_subflows() in net/mptcp/protocol.c race with softirq
packet processing on ssk because subflow->fully_established and
inet_sk_state_load(ssk) are checked before ssk is locked in
__mptcp_close_ssk()?

When __mptcp_close() calls mptcp_close_retry_subflows(sk), the msk socket
lock is held, sk->sk_state is still TCP_ESTABLISHED, and msk->allow_subflows
is true, while ssk is not locked until __mptcp_close_ssk() runs:

net/mptcp/protocol.c:__mptcp_close_ssk() {
    lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
    subflow->closing =3D 1;

    if (flags & MPTCP_CF_PUSH)
        mptcp_cleanup_ssk_backlog(sk, ssk);
    ...
}

Between the lockless checks in mptcp_close_retry_subflows() and
lock_sock_nested(ssk) in __mptcp_close_ssk(), TCP softirq on another CPU can
process incoming packets under bh_lock_sock_nested(ssk):

1. If ssk is observed in TCP_SYN_SENT, an incoming MP_JOIN handshake can
transition ssk to TCP_ESTABLISHED via:

  tcp_rcv_synsent_state_process()
    -> subflow_finish_connect()
      -> mptcp_finish_join()

which succeeds without acquiring the msk socket lock because subflow->node
is on msk->conn_list and msk->allow_subflows is true. A subsequent packet
carrying the 4th ACK and DSS data can then set subflow->fully_established =
=3D
true in check_fully_established() and queue skbs onto msk->backlog_list via:

  subflow_data_ready()
    -> mptcp_data_ready()
      -> __mptcp_move_skbs_from_subflow(msk, ssk, false)
        -> __mptcp_add_backlog()

which sets skb->destructor =3D NULL and skb->sk =3D ssk while leaving
skb->truesize charged to ssk->sk_rmem_alloc.

2. Similarly, if ssk already completed the 3-way handshake
(TCP_ESTABLISHED, subflow->fully_established =3D=3D false) when
READ_ONCE(subflow->fully_established) is checked, softirq can process the
4th ACK with DSS data (queuing skbs onto msk->backlog_list) and then a
subsequent FIN or RST transitioning ssk to TCP_CLOSE before
inet_sk_state_load(ssk) is read.

When __mptcp_close_ssk(sk, ssk, subflow, 0) then runs without MPTCP_CF_PUSH,
it skips mptcp_cleanup_ssk_backlog(sk, ssk) and destroys ssk while skbs on
msk->backlog_list still hold skb->sk =3D ssk:

net/mptcp/protocol.h:mptcp_borrow_fwdmem() {
    struct sock *ssk =3D skb->sk;
    ...
    if (!ssk)
        return;

    atomic_sub(skb->truesize, &ssk->sk_rmem_alloc);
    skb->sk =3D NULL;
}

Wouldn't this trigger the sk->sk_rmem_alloc warning in inet_sock_destruct()
and a use-after-free atomic_sub() on ssk->sk_rmem_alloc in
mptcp_borrow_fwdmem() when msk->backlog_list is later drained or purged?

=E4=B8=8D=E6=96=AD=E5=9C=B0

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022151130.2285=
198-1-anilkaushikwireless@gmail.com?part=3D4
