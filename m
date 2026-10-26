Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793009234;
	b=0tZXSIZYiejBhLy5Gld8t3qz8XW6TX/yyuFX6iAkrNkD5WN8hj3B+jSfR3mYCA+1u/oY
	 aogUGfkGHF0LzgMJfxHEKn4TVsiEo9N+VvcfIyklqNfKNs2r0wSzWjquuXI47Y5Ox4R3W
	 /L9hC/OuG+d4FEq4UpZ/x6VZkTLs9/ZihcA9iQrTF1qW8NCz2s1llg+4hSvJHKaeyXtUJ
	 rl9s9Kc0N7sC7rQUmcc14NIAgBhWGD5DrKVArRf6WDSFoomzGQ8Pj5e0d1ko2xu/Xms3n
	 rE2h0FqGyF+Bmdp7hTCusp0lIvhKHH4ccyMaEDbufetfLagFfBdys1dQvac/hTInZmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793009234;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SZb3w2r7MezB61xij6PN26HfMVzMGBrapjWhH+ZL1Is=;
	b=fHWP/gT7HLddIzdlPulnvlqGZb7eVnKAcTVvavr5qKovRn2KiOZmB/Npe2/UvS5EhDhj
	 MUOzONPc+dTvsV0HiTkb4YkaAf0ZrSB4oJ3VpN0/hzMoMsY5aZ3/23ImcgLOlRqI9iiQR
	 WWYt/9YOXXEcqNchPofj1R2DDPRKK2H9RMUS8KdywcdR12DJsf7HYWcoJdy+E4qGtyUbU
	 ce3FNjNQ4wd0LBA8TuoknLPMWszznWikyJ827KjMtJfOK4KvSKzlDvHG1N0CpQp5u0HRi
	 eIyeLEqpoOsCk5VhTiunwIKFjivXPt0XPDpeUxhmcqt97DeatVUP2LGM+hvz2UlNU0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aiCXpLUM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B31606A31A
	for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 10:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aiCXpLUM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194EF1F01282;
	Mon, 26 Oct 2026 10:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793009234;
	bh=SZb3w2r7MezB61xij6PN26HfMVzMGBrapjWhH+ZL1Is=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=aiCXpLUM0IWxbgssTgXDfpDQJxUiUHpmwV9MgO2mrfU3U298cjSeYjCcDIrAH2a1c
	 EkhYQSqcxgsPIMYeSgSd1TA6X3m8jPG9gtFsi6PqRwfTM33H+EL1MY9noTmtfefV/b
	 EKyzJLA9tnUMdOpClVh1kyprid4pbH3xUA/iXe+e0dQb5jWg3T8nP9ii99bBY9P5fq
	 WFjplTXyaZkXfMLvjqQBP3L6tuEnVL8htmDX2iZdXLHtjZeqQGwma0u0TK1kRSZFDx
	 Ncal+oP64i9CHYAcFO7klWnZVVwGzq4mY2EhmeY9R4xZpYSYqYCGNn4cWT5ZqSqyGy
	 k/AwislwsW8dQ==
Message-ID: <sashiko-outbox-184878@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next 3/6] mptcp: implement peek_len for proto_ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <22bc848942a31334be17f49a2488c51e2f307eb5.1792999988.git.tanggeliang@kylinos.cn>
References: <cover.1792999988.git.tanggeliang@kylinos.cn>
 <22bc848942a31334be17f49a2488c51e2f307eb5.1792999988.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 10:07:13 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] mptcp: mptcp_inq() under-reports readable bytes by 1 without DAT=
A_FIN
- [Medium] mptcp: mptcp_inq() returns bogus byte count for TFO data after 3=
rd ACK
- [Medium] mptcp: mptcp_inq() and mptcp_ioctl() mismatch commit message
--

commit 2cfec08fb299c62052c815a2a207f3aacada8176
Author: Geliang Tang <geliang@kernel.org>

mptcp: implement peek_len for proto_ops

This commit adds mptcp_inq() and mptcp_peek_len() to report readable bytes =
on
an MPTCP socket, wires .peek_len into mptcp_stream_ops and
mptcp_v6_stream_ops, and switches SIOCINQ in mptcp_ioctl() to use mptcp_inq=
().

>     mptcp: implement peek_len for proto_ops
>    =20
>     Add mptcp_inq() to compute the number of readable bytes at the MPTCP
>     level. It derives the count from ack_seq - copied_seq, returns 0 while
>     the connection is still handshaking (TCP_SYN_SENT/TCP_SYN_RECV), retu=
rns
>     0 when the connection is closed (TCP_CLOSE or RCV_SHUTDOWN), and
>     subtracts 1 once a FIN has been received, mirroring tcp_inq().
>    =20
>     READ_ONCE() is used instead of mptcp_data_lock() for the u64 reads of
>     ack_seq and copied_seq because mptcp_inq() will be called from TLS
>     contexts with the socket lock held - taking the spinlock would deadlo=
ck.
>    =20
>     On 32-bit systems a torn read can produce a wrapped subtraction (clos=
e to
>     2^64). When hint_val >=3D INT_MAX, we return 0 instead of INT_MAX to =
avoid
>     reporting 2GB of readable data when there may be none. This is likely
>     caused by a torn read rather than a legitimate large receive window, =
as
>     normal receive queues should not exceed INT_MAX bytes.
>    =20
>     Wire mptcp_inq() into mptcp_peek_len() and assign .peek_len in both
>     mptcp_stream_ops and mptcp_v6_stream_ops. This is preparatory work for
>     an upcoming kTLS-over-MPTCP series.
>    =20
>     Note: mptcp_inq() intentionally differs from mptcp_inq_hint() when the
>     calculated value is 0. mptcp_inq_hint() returns 1 to signal EOF to
>     ioctl/cmsg users (mirroring tcp_inq_hint()), while mptcp_inq() returns
>     0 because peek_len should report the actual readable byte count
>     (mirroring tcp_inq()).
>    =20
>     Co-developed-by: Zqiang <qiang.zhang@linux.dev>
>     Signed-off-by: Zqiang <qiang.zhang@linux.dev>
>     Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
>=20
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 0caa31525b907..71a0a28b0d3c9 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -4188,7 +4189,7 @@ static int mptcp_ioctl(struct sock *sk, int cmd, in=
t *karg)
>  		lock_sock(sk);
>  		if (mptcp_move_skbs(sk))
>  			mptcp_cleanup_rbuf(msk, 0);
> -		*karg =3D mptcp_inq_hint(sk);
> +		*karg =3D mptcp_inq(sk);
>  		release_sock(sk);
>  		break;
>  	case SIOCOUTQ:

[Severity: Medium]
Does this change in mptcp_ioctl() contradict the commit message?

The commit message notes that mptcp_inq_hint() returns 1 to signal EOF to
ioctl/cmsg users, while mptcp_inq() returns 0 for peek_len. However, switch=
ing
SIOCINQ in mptcp_ioctl() from mptcp_inq_hint(sk) to mptcp_inq(sk) causes
ioctl(SIOCINQ) to return 0 instead of 1 at EOF when sk->sk_receive_queue is
empty and TCP_CLOSE or RCV_SHUTDOWN is set.

In addition, the commit message describes mptcp_inq() as reading a scalar
copied_seq with READ_ONCE(), returning 0 when TCP_CLOSE or RCV_SHUTDOWN is
set, and avoiding mptcp_data_lock() because taking it under the socket lock
would deadlock. In the implementation below, struct mptcp_sock has no
copied_seq field; mptcp_inq() instead peeks sk->sk_receive_queue and reads
MPTCP_SKB_CB(skb)->map_seq without READ_ONCE(), decrements answ rather than
returning 0 on TCP_CLOSE or RCV_SHUTDOWN when an skb is queued, and
mptcp_move_skbs() right above takes mptcp_data_lock() while holding
lock_sock(sk).

Should SIOCINQ in mptcp_ioctl() keep calling mptcp_inq_hint(sk), and could =
the
commit message be updated to match the implementation?

> @@ -4797,6 +4798,39 @@ static ssize_t mptcp_splice_read(struct socket *so=
ck, loff_t *ppos,
>  	return ret;
>  }
> =20
> +static int mptcp_inq(struct sock *sk)
> +{
> +	const struct mptcp_sock *msk =3D mptcp_sk(sk);
> +	const struct sk_buff *skb;
> +	u64 hint_val;
> +	int answ;
> +
> +	if ((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV))
> +		return 0;
> +
> +	skb =3D skb_peek(&sk->sk_receive_queue);
> +	if (!skb)
> +		return 0;
> +
> +	hint_val =3D READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
> +	if (hint_val >=3D INT_MAX)
> +		return 0;

[Severity: Medium]
Can this sequence subtraction return 0 (or a bogus byte count) when unread =
TCP
Fast Open data is still at the head of sk->sk_receive_queue after the 3rd A=
CK
arrives?

On a passive MPTCP Fast Open connection,
mptcp_fastopen_subflow_synack_set_params() in net/mptcp/fastopen.c queues t=
he
SYN data skb onto sk->sk_receive_queue while msk->ack_seq is 0:

    /* Only the sequence delta is relevant */
    MPTCP_SKB_CB(skb)->map_seq =3D -skb->len;
    MPTCP_SKB_CB(skb)->end_seq =3D 0;
    MPTCP_SKB_CB(skb)->offset =3D 0;

Commit f03afb3aeb9d ("mptcp: drop __mptcp_fastopen_gen_msk_ackseq()") remov=
ed
the helper that rebased the queued TFO skb's map_seq when the 3rd ACK arriv=
es.
When the 3rd ACK carrying MP_CAPABLE is processed, subflow_set_remote_key()=
 in
net/mptcp/subflow.c sets msk->ack_seq to the 64-bit initial data sequence
number:

    WRITE_ONCE(msk->remote_key, subflow->remote_key);
    WRITE_ONCE(msk->ack_seq, subflow->iasn);

If the TFO skb at the head of sk->sk_receive_queue has not yet been fully
consumed when mptcp_inq() runs, READ_ONCE(msk->ack_seq) -
MPTCP_SKB_CB(skb)->map_seq evaluates to subflow->iasn + remaining_tfo_len
(plus any subsequent data). Because subflow->iasn is a 64-bit hash of the
remote key, hint_val will almost always be >=3D INT_MAX and cause mptcp_inq=
() to
return 0 (or a bogus value if it wraps below INT_MAX) even though unread TFO
data is queued.

Would using mptcp_data_avail(msk), i.e. READ_ONCE(msk->bytes_received) -
READ_ONCE(msk->bytes_consumed), avoid this issue?

> +
> +	answ =3D (unsigned int)hint_val;
> +
> +	/* Subtract 1, if FIN was received. Mirror tcp_inq() */
> +	if (answ &&
> +	    (sk->sk_state =3D=3D TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN)))
> +		answ--;
> +
> +	return answ;
> +}

[Severity: Medium]
Won't subtracting 1 whenever sk->sk_state =3D=3D TCP_CLOSE or RCV_SHUTDOWN =
is set
under-report the readable byte count by 1 whenever the socket enters those
states without processing an in-sequence DATA_FIN?

In TCP, tcp_inq() decrements answ only when sock_flag(sk, SOCK_DONE) is set,
which happens in tcp_fin() when an in-sequence FIN has been received and
tp->rcv_nxt has been incremented by 1.

In MPTCP, payload skbs queued onto sk->sk_receive_queue advance msk->ack_seq
by the exact payload length, and the only place that increments msk->ack_seq
by an extra 1 for DATA_FIN is mptcp_check_data_fin() in net/mptcp/protocol.=
c:

    if (mptcp_pending_data_fin(sk, &rcv_data_fin_seq)) {
        WRITE_ONCE(msk->ack_seq, msk->ack_seq + 1);
        WRITE_ONCE(msk->rcv_data_fin, 0);

        WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | RCV_SHUTDOWN);

However, sk->sk_state =3D=3D TCP_CLOSE or (sk->sk_shutdown & RCV_SHUTDOWN) =
can be
set while unread data remains in sk->sk_receive_queue without
mptcp_check_data_fin() ever incrementing msk->ack_seq:

1. A local user calls shutdown(fd, SHUT_RD) or shutdown(fd, SHUT_RDWR), whe=
re
   inet_shutdown() in net/ipv4/af_inet.c sets RCV_SHUTDOWN on sk->sk_shutdo=
wn
   without modifying msk->ack_seq or purging sk->sk_receive_queue:

    default:
        WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | how);
        if (sk->sk_prot->shutdown)
            sk->sk_prot->shutdown(sk, how);
        break;

2. The peer aborts the connection with MP_FASTCLOSE, where
   mptcp_check_fastclose() in net/mptcp/protocol.c sets TCP_CLOSE and
   SHUTDOWN_MASK without incrementing msk->ack_seq:

    mptcp_set_state(sk, TCP_CLOSE);
    WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);

3. A fallback subflow receives a TCP RST after data, where
   __mptcp_subflow_error_report() in net/mptcp/protocol.c transitions the
   MPTCP socket to TCP_CLOSE without incrementing msk->ack_seq (and commit
   f3589041bbf5, "mptcp: prevent dummy DATA_FIN on RST in fallback mode",
   explicitly avoided synthesizing a dummy DATA_FIN on RST):

    ssk_state =3D inet_sk_state_load(ssk);
    if (ssk_state =3D=3D TCP_CLOSE && !sock_flag(sk, SOCK_DEAD))
        mptcp_set_state(sk, ssk_state);

4. All subflows close without DATA_FIN or time out in __mptcp_close_ssk() /
   mptcp_do_fastclose(), setting sk->sk_state to TCP_CLOSE without
   incrementing msk->ack_seq.

In all of these cases, READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq=
 is
the exact number of unread payload bytes N in sk->sk_receive_queue, so
decrementing answ causes mptcp_inq(), mptcp_peek_len(), and
mptcp_ioctl(SIOCINQ) to return N - 1 (and 0 when 1 byte of unread data
remains), which can also stall strp_data_ready() when waiting for
strp_peek_len() >=3D strp->need_bytes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792999988.gi=
t.tanggeliang@kylinos.cn?part=3D3
