Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702630;
	b=ARdGqMDFA2KC+DyRqDX92j3HloGw6/q9wV98cPcIM9r2E/jWp0R78W1WSAaqjs3yvnWh
	 urJDMlYTdV8vIGHocAGLmErUmprPEAVX2h1WtZ6nwzj5UwBmSypmedU25yNAgVQpWOwFr
	 io5IXEjsxeZfYdURhCsHX0Y0M971mdVFMCzAwKtkHJjguVCQiN81L0Z7t7EohAoflUb9r
	 xO+nxR/oZUU/MOszetdvHPQro0UXPoFiCHfPxrTLYmO8NubpJ68/gmp5sV16NhHrVjZIq
	 Fuy8SFPQ0w27qPgJ6YN5OREi/EpGXwqA1Vq7AOyLGJmWBiwDVbDha2MH7lx/VVC/PlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702630;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RnOEyUJfaS7jg8NvRx3VnZW93rQ2vvALyI01Dspuobc=;
	b=UmPPCOefAB7mord37iKhwOR/ZG/UI7h8Kv1XLft8hevICnAj2eHR8goEERcaVRZqinBY
	 HTGARu0IJpPlU8JIR0R0F/QYnV+UGBQccsdQ15pvvxpZW4k64TWvg8F0EAkHw6gYLnUwI
	 fFIpNPkbLTFkVFkMQgLS9kiPIlI07ZJxZKNE+gdyPIufdMuB0pXUh4ydd7BbtxmHmez17
	 DWZik1VXlCBDUrmvbd3PeO/SUE0VQPBaWAGkfoMv+GavzqUHLyOFdI78WDJN4ljBqvtxK
	 wicov0lxCrGI7FBT1mOm7FS4sOj8m72C0rmy76Bc/6RGzlgQWJDM1QMU9AMAJmCAx2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cd7qWEX5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593CC606F7F2
	for <mptcp@lists.linux.dev>; Tue,  3 Nov 2026 10:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cd7qWEX5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A16F1F000C1;
	Tue,  3 Nov 2026 10:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793702630;
	bh=RnOEyUJfaS7jg8NvRx3VnZW93rQ2vvALyI01Dspuobc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=cd7qWEX5FDBLoVgDfJII6rBzlLGLZQqm6pbBcfC0Do/T1l5kOZMFSNer92dDmJMf2
	 ZJj1keHylan92kI3Jew0XE+AJXxyTsUaeLcEdmXrncZt71cBawFHJJbMLnE8xD1nvk
	 z4t4TiXzOLqVzJxf0Yf4t/GLkpWm3Cg7MEtrpqNrcMiVZsRHM7+DPwxiFDTYcs0+hY
	 WcDglDY0/fo00iw+pVTtmozxFXXTY0R3AJlj7knL8wphfQ0UVKotu3ERseCrcFae93
	 QXzjhI+iHRviBea5mtaQc6YthBCiH2a0ANuMjhzqnRNZLDmF6vWeoMFZsqtajdosuM
	 bNVAVLgVYnqmw==
Message-ID: <sashiko-outbox-195063@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v20 5/6] mptcp: sync mptcp skb cb layout with
 tcp one
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <cf2994ec4440d24183bea5c407c1962270392c32.1793695518.git.tanggeliang@kylinos.cn>
References: <cover.1793695518.git.tanggeliang@kylinos.cn>
 <cf2994ec4440d24183bea5c407c1962270392c32.1793695518.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 10:43:49 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] mptcp: subtracting offset in mptcp_init_skb() corrupts out-of-=
order data
- [High] mptcp: 64-bit ack_seq minus 32-bit map_seq overflow in mptcp_inq_h=
int()
--

commit 0495d49fc9571bbbbcc61fc3640dabeb8f98b52b
Author: Paolo Abeni <pabeni@redhat.com>

mptcp: sync mptcp skb cb layout with tcp one

This commit aligns struct mptcp_skb_cb with struct tcp_skb_cb by narrowing
map_seq and end_seq to 32-bit sequence numbers and adding a 64-bit
map_seq64 field for receive window admission and coalescing checks.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 3bd7d38ce78c4..3e10b06b7772d 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -425,10 +434,14 @@ static void mptcp_init_skb(struct sock *ssk, struct=
 sk_buff *skb, int offset)
>  	 *
>  	 * This is correct even when offset > 0 and mapping is out-of-order,
>  	 * because consumed prefix bytes are part of the same logical DSN range.
> +	 *
> +	 * Note that end seq number is only available in 32bits format.
>  	 */
> -	MPTCP_SKB_CB(skb)->map_seq =3D mptcp_subflow_get_mapped_dsn(subflow) -
> -				     offset;
> +	MPTCP_SKB_CB(skb)->map_seq64 =3D mptcp_subflow_get_mapped_dsn(subflow) -
> +				       offset;
> +	MPTCP_SKB_CB(skb)->map_seq =3D (u32)MPTCP_SKB_CB(skb)->map_seq64;
>  	MPTCP_SKB_CB(skb)->end_seq =3D MPTCP_SKB_CB(skb)->map_seq + skb->len;
> +	MPTCP_SKB_CB(skb)->flags =3D 0;
>  	MPTCP_SKB_CB(skb)->has_rxtstamp =3D has_rxtstamp;

[Severity: Critical]
As reported by Sashiko on v19 [1], when offset > 0 in mptcp_init_skb() and
the active DSS mapping is out of order at the MPTCP level
(mptcp_subflow_get_mapped_dsn(subflow) > msk->ack_seq), can subtracting
offset from map_seq64 and map_seq without stripping the [0, offset) prefix
from skb corrupt the MPTCP receive stream?

On a subflow where data is multiplexed across multiple subflows,
consecutive DSS mappings do not have contiguous DSNs. If the leading
[0, offset) bytes of the head skb on ssk->sk_receive_queue belonged to a
previous DSS mapping (for example after mptcp_subflow_discard_data() in
subflow_check_data_avail() discards an already-received mapping and
advances to the next mapping in the same skb) or an overlapping TCP
retransmission, those prefix bytes are not part of the active mapping
starting at tp->copied_seq and are not covered by its DSS checksum in
validate_data_csum().

Setting map_seq64 =3D mapped_dsn - offset and end_seq =3D map_seq + skb->len
assigns the fabricated DSN range [mapped_dsn - offset, mapped_dsn) to the
unpulled [0, offset) prefix bytes:

- If mapped_dsn - offset <=3D msk->ack_seq < mapped_dsn, __mptcp_move_skb()
  treats the skb as covering msk->ack_seq, queues or coalesces it into
  sk->sk_receive_queue, and advances msk->ack_seq across the unreceived
  gap. __mptcp_recvmsg_mskq() and mptcp_recv_skb() then compute a read
  offset of (u32)msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq < offset and
  copy the stale [0, offset) subflow bytes to user space.

- If mapped_dsn - offset > msk->ack_seq, mptcp_data_queue_ofo() inserts the
  skb into msk->out_of_order_queue starting at mapped_dsn - offset, where
  __mptcp_try_coalesce() can coalesce the stale prefix into a preceding OFO
  skb, real segments arriving for [mapped_dsn - offset, mapped_dsn) are
  dropped as duplicate data, and __mptcp_ofo_queue() dequeues the skb once
  msk->ack_seq reaches mapped_dsn - offset.

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 7878e6ac6c0b6..fa54f70ab501d 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -129,9 +129,12 @@
>  #define MPTCP_SYNC_SEQ		8
> =20
>  struct mptcp_skb_cb {
> -	u64 map_seq;
> -	u64 end_seq;
> +	u32 map_seq;
> +	u32 end_seq;
> +	u32 unused;
> +	u16 flags;
>  	u8  has_rxtstamp;
> +	u64 map_seq64;
>  };

[Severity: High]
Now that MPTCP_SKB_CB(skb)->map_seq is a u32, does mptcp_inq_hint()
overflow when subtracting it from the 64-bit msk->ack_seq?

In net/mptcp/protocol.c:mptcp_inq_hint():

	skb =3D skb_peek(&sk->sk_receive_queue);
	if (skb) {
		u64 hint_val =3D READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;

		if (hint_val >=3D INT_MAX)
			return INT_MAX;

		return (unsigned int)hint_val;
	}

Because READ_ONCE(msk->ack_seq) is a u64 and MPTCP_SKB_CB(skb)->map_seq is
zero-extended from u32 to u64, the upper 32 bits of msk->ack_seq remain in
hint_val (or the subtraction underflows across a 32-bit wrap), causing
hint_val >=3D INT_MAX to evaluate to true whenever sk->sk_receive_queue is
non-empty and msk->ack_seq has non-zero upper 32 bits.

In addition to returning INT_MAX for SIOCINQ in mptcp_ioctl() and
TCP_CM_INQ in mptcp_recvmsg(), mptcp_rcv_space_adjust() does:

	copied =3D msk->rcvq_space.copied;
	copied -=3D mptcp_inq_hint(sk);
	if (copied <=3D msk->rcvq_space.space)
		goto new_measure;

When mptcp_inq_hint() returns INT_MAX, copied becomes negative and jumps to
new_measure, preventing mptcp_rcvbuf_grow() from auto-tuning the MPTCP and
subflow receive buffers. Should mptcp_inq_hint() use 32-bit sequence
arithmetic (or subtract msk->copied_seq from msk->ack_seq) instead?

[1] https://lore.kernel.org/r/1c928472a89719130041c92cadd7e0fb6dbf552a.1793=
361629.git.tanggeliang@kylinos.cn

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793695518.gi=
t.tanggeliang@kylinos.cn?part=3D5
