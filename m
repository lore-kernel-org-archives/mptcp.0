Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793258362;
	b=yn13dGIpajkGUmdNpe90JUefRTR60R7gt1Zk3xB1v8VrZ1qoexYU9RNGY7qdiqUh2Yya
	 fOuOlPhGHkmvkGvwIKY8pTIrlhn9ANDUbomXhbWszly1RNui6ftKpLMi2itJt+L9M639R
	 R6gTmzlBuL6hbVssEoiQKjc7XhY8Qs8onxQ+rDAZ8yutf9NkLcCnTlmA67Jf4/fpbsDnF
	 k94OXYMOdMLJxevXk/h3lZmPLTX/W/B6PMTeff/WQlYxeTCnAoGgGzL2w7x/oiEsxEvUs
	 EP6j1E6N2fY5WSCQrLl44L3RD/n2bclQ/8ahw4uDFtREIu7+eTepWDH1SvaLyemCwXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793258362;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dpm6cxFrVbeqejMNGRUAJZNuHjdfXtrGSV30gRR5150=;
	b=AIcPXYfmr3/T4Y5Hwo3VViWZwZfXOzBWcezbo061FcHCsutz1MUNvON+L/AI1zQdnuE7
	 fr/qx2y9QK1j2oi/UIhqV8Fpklcsu8aO9+W9Ipn3Y9OqGG/F6xbXd9P7/BTaPUWBzCr3b
	 Ar0UyYnLgic1N5QrSps5JDpCLhVUUQjOHDp61zz8lNhbPvT86wzz0wd9R0y0qqtXnobm2
	 DiLDkNDu2BNT5Y5e/FmTG4C2lxUk8dvVfkF9kpDfxC3OpTd6L/vdiK+HhmPl6hE92Xnam
	 85SiHxf0TVyv+lbPV/cv6jokAbG4YnCudWG5CRjNJYVloR1gM9l1zamBpgs0SsWVUOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iKQtFLhG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88262606A31C
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 07:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iKQtFLhG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62441F01825;
	Thu, 29 Oct 2026 07:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793258362;
	bh=dpm6cxFrVbeqejMNGRUAJZNuHjdfXtrGSV30gRR5150=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=iKQtFLhGEevcbycMKmS72AKgzJcON5jiXJ/jMDF70cCuHkMT0+fVmU3TIBPYbJvja
	 0AcT5j7ybBLsfdIPTDczq/YoXEqNtuhwPYHkQXoJGqXhIisc92GuVWf+StL+c0RVay
	 d+fQvft3EFGxoh/UfSqKEwO2iMCOSnsIoXEY4IsUtCPduYxpsX2gX2qwVdpa4odGno
	 A2tvyO0smTSzAe6HYPUdSf9rTg6hQnQIvwt+l2pfshFtiooC6TijMLdasJc5mLC8vZ
	 bwKCJBQJgOA1pbK+TlTCug9rUIB9iYRNHyka58Hw8oosgFzztRY4r8KMZz3yV1ePi0
	 6OIzHEFI6+57w==
Message-ID: <sashiko-outbox-188852@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v16 3/4] mptcp: sync mptcp skb cb layout with
 tcp one
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <147b74d32860b750a1b281ae5b25951067d499d7.1793255126.git.tanggeliang@kylinos.cn>
References: <cover.1793255126.git.tanggeliang@kylinos.cn>
 <147b74d32860b750a1b281ae5b25951067d499d7.1793255126.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 07:19:21 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] mptcp: race and copied_seq reset in subflow_set_remote_key() o=
n TFO
- [Critical] mptcp: mptcp_init_skb() subtracts offset from map_seq64 corrup=
ting data
- [High] mptcp: __mptcp_recvmsg_mskq() offset underflow on MSG_PEEK and skb=
 leak
- [Medium] mptcp: mptcp_inq_hint() uses map_seq64 instead of msk->copied_seq
--

commit 67fabb0bf5f4c5ce5c4d525d8c3f0296f5ef7122
Author: Paolo Abeni <pabeni@redhat.com>

mptcp: sync mptcp skb cb layout with tcp one

This commit aligns the MPTCP SKB control buffer layout with the TCP SKB
control buffer by converting map_seq and end_seq to 32-bit fields while
retaining a 64-bit map_seq64 field for sequence validation.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index f89ed94b668d9..bbce1bafa40ee 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
[ ... ]
> @@ -422,11 +429,13 @@ static void mptcp_init_skb(struct sock *ssk, struct=
 sk_buff *skb, int offset)
> =20
>  	/* the skb map_seq accounts for the skb offset:
>  	 * mptcp_subflow_get_mapped_dsn() is based on the current tp->copied_seq
> -	 * value
> +	 * value; note that end seq number is only available in 32bits format.
>  	 */
> -	MPTCP_SKB_CB(skb)->map_seq =3D mptcp_subflow_get_mapped_dsn(subflow) -
> -				     offset;
> +	MPTCP_SKB_CB(skb)->map_seq64 =3D mptcp_subflow_get_mapped_dsn(subflow) -
> +				       offset;
> +	MPTCP_SKB_CB(skb)->map_seq =3D (u32)MPTCP_SKB_CB(skb)->map_seq64;
>  	MPTCP_SKB_CB(skb)->end_seq =3D MPTCP_SKB_CB(skb)->map_seq + skb->len;

[Severity: Critical]
Can subtracting offset from mptcp_subflow_get_mapped_dsn(subflow) in
mptcp_init_skb() corrupt the MPTCP data stream when an out-of-order DSS
mapping starts at a non-zero offset within a subflow SKB?

In __mptcp_move_skbs_from_subflow(), offset =3D seq - TCP_SKB_CB(skb)->seq
(where seq is tp->copied_seq) is non-zero when the leading [0, offset)
bytes of the subflow SKB were already consumed on the subflow. For example,
when an SKB spans the end of a previous DSS mapping that was already
acknowledged, subflow_check_data_avail() -> mptcp_subflow_discard_data()
advances tp->copied_seq without eating the SKB and clears
subflow->map_valid, after which get_mapping_status() installs the next
mapping on the remaining [offset, skb->len) bytes:

net/mptcp/subflow.c:subflow_check_data_avail()
	if (unlikely(before64(ack_seq, old_ack))) {
		mptcp_subflow_discard_data(ssk, skb, old_ack - ack_seq);
		continue;
	}

net/mptcp/subflow.c:mptcp_subflow_discard_data()
	if (!before(tcp_sk(ssk)->copied_seq, TCP_SKB_CB(skb)->end_seq))
		sk_eat_skb(ssk, skb);
	if (mptcp_subflow_get_map_offset(subflow) >=3D subflow->map_data_len)
		subflow->map_valid =3D 0;

The active DSS mapping only covers skb[offset .. skb->len - 1] starting at
mapped_dsn =3D mptcp_subflow_get_mapped_dsn(subflow). However,
mptcp_init_skb() sets map_seq64 =3D mapped_dsn - offset, assigning the MPTCP
sequence range [mapped_dsn - offset, mapped_dsn) to the discarded prefix
bytes skb[0 .. offset - 1].

When mapped_dsn is out of order at the MPTCP level (after64(mapped_dsn,
msk->ack_seq), because the intermediate DSNs were sent on another subflow),
__mptcp_move_skb(), mptcp_data_queue_ofo(), __mptcp_ofo_queue(), and
__mptcp_try_coalesce() treat skb[0 .. offset - 1] as valid payload for
[mapped_dsn - offset, mapped_dsn). Doesn't this advance msk->ack_seq across
that range, deliver the stale subflow prefix bytes to user space, and drop
the actual segment for [mapped_dsn - offset, mapped_dsn) as duplicate data?

> +	MPTCP_SKB_CB(skb)->flags =3D 0;
>  	MPTCP_SKB_CB(skb)->has_rxtstamp =3D has_rxtstamp;
>  	MPTCP_SKB_CB(skb)->cant_coalesce =3D 0;
> =20
> @@ -438,13 +447,13 @@ static void mptcp_init_skb(struct sock *ssk, struct=
 sk_buff *skb, int offset)
> =20
>  static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
>  {
> -	u64 copy_len =3D MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_se=
q;
> +	u32 copy_len =3D MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_se=
q;
>  	struct mptcp_sock *msk =3D mptcp_sk(sk);
>  	struct sk_buff *tail;
> =20
>  	mptcp_borrow_fwdmem(sk, skb);
> =20
> -	if (MPTCP_SKB_CB(skb)->map_seq =3D=3D msk->ack_seq) {
> +	if (MPTCP_SKB_CB(skb)->map_seq64 =3D=3D msk->ack_seq) {
>  		/* in sequence */
>  insert:
>  		if (!mptcp_try_rmem_schedule(sk, skb)) {
> @@ -462,14 +471,14 @@ static bool __mptcp_move_skb(struct sock *sk, struc=
t sk_buff *skb)
>  		skb_set_owner_r(skb, sk);
>  		__skb_queue_tail(&sk->sk_receive_queue, skb);
>  		return true;
> -	} else if (after64(MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq)) {
> +	} else if (after64(MPTCP_SKB_CB(skb)->map_seq64, msk->ack_seq)) {
>  		mptcp_data_queue_ofo(msk, skb);
>  		return false;
>  	}
> =20
>  	/* Partial packet */
> -	if (after64(MPTCP_SKB_CB(skb)->end_seq, msk->ack_seq)) {
> -		copy_len =3D MPTCP_SKB_CB(skb)->end_seq - msk->ack_seq;
> +	if (after64(MPTCP_SKB_CB(skb)->map_seq64 + skb->len, msk->ack_seq)) {
> +		copy_len =3D MPTCP_SKB_CB(skb)->end_seq - (u32)msk->ack_seq;
>  		goto insert;
>  	}

[Severity: High]
With MPTCP_SKB_CB(skb)->map_seq now a 32-bit value and msk->copied_seq
tracking read progress, does __mptcp_recvmsg_mskq() underflow offset during
MSG_PEEK and leak fully skipped SKBs on non-peek reads?

In net/mptcp/protocol.c:__mptcp_recvmsg_mskq():

	skb_queue_walk_safe(&sk->sk_receive_queue, skb, tmp) {
		u32 delta, offset =3D (u32)msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
		u32 data_len =3D skb->len - offset;
		u32 count;
		int err;

		/* Skip skbs that are entirely before copied_seq */
		if (offset >=3D skb->len) {
			*last =3D skb;
			continue;
		}

When flags & MSG_PEEK is set, msk->copied_seq is not advanced after copying
from the first SKB in sk->sk_receive_queue. On the second SKB,
MPTCP_SKB_CB(skb)->map_seq is after (u32)msk->copied_seq, so the unsigned
32-bit subtraction (u32)msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq wraps
around to a value >=3D 0x80000000U (>=3D skb->len). This hits the
offset >=3D skb->len check and skips every SKB after the first, preventing
MSG_PEEK from ever reading past the first SKB (and causing MSG_PEEK |
MSG_WAITALL to block in sk_wait_data() even when enough data is queued).

Additionally, when !(flags & MSG_PEEK) and an SKB in sk->sk_receive_queue
is genuinely before msk->copied_seq (offset >=3D skb->len),
__mptcp_recvmsg_mskq() executes *last =3D skb; continue; without calling
mptcp_eat_recv_skb(sk, skb) (unlike mptcp_recv_skb()). Doesn't that leave
the consumed SKB leaked on sk->sk_receive_queue and charged to
sk->sk_rmem_alloc until the socket is closed?

[ ... ]
> @@ -2392,7 +2399,8 @@ static unsigned int mptcp_inq_hint(const struct soc=
k *sk)
> =20
>  	skb =3D skb_peek(&sk->sk_receive_queue);
>  	if (skb) {
> -		u64 hint_val =3D READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
> +		u64 hint_val =3D READ_ONCE(msk->ack_seq) -
> +			       MPTCP_SKB_CB(skb)->map_seq64;
> =20
>  		if (hint_val >=3D INT_MAX)
>  			return INT_MAX;

[Severity: Medium]
Should mptcp_inq_hint() subtract msk->copied_seq instead of
MPTCP_SKB_CB(skb)->map_seq64?

When user space partially reads the head SKB in sk->sk_receive_queue via
__mptcp_recvmsg_mskq() or __mptcp_read_sock() (or when a partially
overlapping SKB is queued in __mptcp_move_skb() or __mptcp_ofo_queue()),
msk->copied_seq advances while MPTCP_SKB_CB(skb)->map_seq64 on the head SKB
remains unchanged at its initial sequence number:

net/mptcp/protocol.c:__mptcp_recvmsg_mskq()
		if (!(flags & MSG_PEEK)) {
			msk->bytes_consumed +=3D count;
			msk->copied_seq +=3D count;
			if (count < data_len)
				break;

Computing READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq64 counts the
already-consumed or skipped prefix bytes on the head SKB (including when
subsequent segments coalesce into that head SKB via mptcp_try_coalesce())
as unread.

Beyond reporting inflated unread byte counts for SIOCINQ in mptcp_ioctl()
and TCP_CM_INQ in mptcp_recvmsg(), mptcp_rcv_space_adjust() subtracts
mptcp_inq_hint(sk) from msk->rcvq_space.copied:

net/mptcp/protocol.c:mptcp_rcv_space_adjust()
	copied =3D msk->rcvq_space.copied;
	copied -=3D mptcp_inq_hint(sk);
	if (copied <=3D msk->rcvq_space.space)
		goto new_measure;

Won't subtracting the inflated hint_val cause copied to be under-counted
and prevent mptcp_rcvbuf_grow() from auto-tuning the receive buffer?

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 5e553adb9397e..d144eb2373ef6 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -542,6 +542,7 @@ static void subflow_set_remote_key(struct mptcp_sock =
*msk,
>  		skb =3D skb_peek(&sk->sk_receive_queue);
>  		if (skb) {
>  			MPTCP_SKB_CB(skb)->map_seq =3D subflow->iasn - skb->len;
> +			MPTCP_SKB_CB(skb)->map_seq64 =3D subflow->iasn - skb->len;
>  			MPTCP_SKB_CB(skb)->end_seq =3D subflow->iasn;
>  			msk->copied_seq -=3D skb->len;
>  		}

[Severity: Critical]
What happens on passive MPTCP Fast Open if user space accepts the socket
and reads from sk->sk_receive_queue before or while the client's 3rd ACK
triggers subflow_set_remote_key()?

In mptcp_fastopen_subflow_synack_set_params(), the TFO data SKB is queued
onto sk->sk_receive_queue with map_seq64 =3D -(u64)skb->len and
msk->copied_seq =3D -(u64)skb->len before the 3rd ACK arrives. Once the chi=
ld
socket is accepted, user space can call mptcp_recvmsg() ->
__mptcp_recvmsg_mskq() (or __mptcp_read_sock() -> mptcp_recv_skb()) under
lock_sock(sk) without holding mptcp_data_lock(sk), while the 3rd ACK
arrives in softirq via check_fully_established() ->
__mptcp_subflow_fully_established() -> subflow_set_remote_key() (or
mptcp_propagate_state() -> subflow_set_remote_key()) under
mptcp_data_lock(sk) without checking sock_owned_by_user(sk):

net/mptcp/subflow.c:subflow_set_remote_key()
	msk->copied_seq =3D subflow->iasn;

	if (subflow->is_mptfo) {
		struct sock *sk =3D (struct sock *)msk;
		struct sk_buff *skb;

		skb =3D skb_peek(&sk->sk_receive_queue);
		if (skb) {
			MPTCP_SKB_CB(skb)->map_seq =3D subflow->iasn - skb->len;
			MPTCP_SKB_CB(skb)->map_seq64 =3D subflow->iasn - skb->len;
			MPTCP_SKB_CB(skb)->end_seq =3D subflow->iasn;
			msk->copied_seq -=3D skb->len;
		}
	}

This appears to cause three regressions:

1. If user space partially reads count bytes (0 < count < skb->len) from
the TFO SKB before the 3rd ACK arrives, __mptcp_recvmsg_mskq() advances
msk->copied_seq to -(u64)skb->len + count while leaving the SKB (with
skb->len unchanged) at the head of sk->sk_receive_queue. When
subflow_set_remote_key() runs, it sets msk->copied_seq to
subflow->iasn - skb->len, discarding the partial read progress so the next
recvmsg() re-delivers the first count bytes.

2. In __mptcp_recvmsg_mskq() and mptcp_recv_skb(), mptcp_eat_recv_skb()
unlinks the TFO SKB from sk->sk_receive_queue and frees it via
skb_attempt_defer_free(skb) under lock_sock(sk) without mptcp_data_lock(sk).
If mptcp_eat_recv_skb() unlinks and frees skb right after
subflow_set_remote_key() peeks it with skb_peek(&sk->sk_receive_queue),
can't subflow_set_remote_key() perform a use-after-free write to
MPTCP_SKB_CB(skb)?

3. In __mptcp_recvmsg_mskq(), msk->copied_seq +=3D count runs before
mptcp_eat_recv_skb(sk, skb). If subflow_set_remote_key() executes between
those two lines when the TFO SKB is completely read, skb_peek() still sees
the SKB and sets msk->copied_seq =3D subflow->iasn - skb->len before
mptcp_eat_recv_skb() unlinks it, leaving msk->copied_seq permanently behind
msk->ack_seq by skb->len and causing subsequent SKBs to underflow offset
and be skipped.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793255126.gi=
t.tanggeliang@kylinos.cn?part=3D3
