Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793351959;
	b=kknkA+EB01eV9C9spn8XSYqFq77zVV1uZW0S5QBGj9YyW04tpLX9u/ynOgpRr6celAG7
	 NnIXWn0gY+58iI9/+pa49Fay2opGbrHmkX/CUF8HETqd5jgS+wXijhT31Jjecx0L6K5HU
	 a7kx82kNZG1P+I0nJusU99x8zJjx2+e+Ysl38VJfEVGL11msaLwKLBxyy79j41+fQh7JL
	 x2sGoJs0WYz+CBMzxGLvcxa21mTvBZSReNfMFIfrZibnCH+FiKPLhtpsDDziiWF4moBQs
	 lqFNG2RWf4LNyuhmVMfX9CuwYyf8OiQL51W/z00QgGK/vYnotPgBi97rUGb0hrBGljQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793351959;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4ZWIZ8Ql70gf7rwN+uIRX6cTdsepA0wBegeTNqFuiuM=;
	b=D5g5XUQ+HbdiPx30RjIcautNICcTcf6YugcslOooz0/m3Bd62/sEitC42ZYkZs9Qt9lh
	 J2cqN4N+5dwFtv4Z7d094MZxlLXoLNFWiy6gMb0+TRZs14F30cRJF9C5zix/+/kB3yYMG
	 cruTsC4Td8sDNnifQsAoyFcPko4D/eZ81nGI6UGbgbgyYFOLldkyVrBCljoAG3m9HK1S5
	 7s+I4LTnidzhsSTG5Rr9zycoSZK8mfMy30hiSVqgsoWalGZr9zPE1f/uB1lP30cKdVqoY
	 sU6eL7c9sexXR99TbDgqTibeu3iGknvUIHq5ijSPpTd/IiClzdfk4JH8POYdfoZLJGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B3djHjof;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD98606A31C
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 09:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B3djHjof
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A081F000C1;
	Fri, 30 Oct 2026 09:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793351958;
	bh=4ZWIZ8Ql70gf7rwN+uIRX6cTdsepA0wBegeTNqFuiuM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=B3djHjofDUQPzUx+bIdzmddsGdB5gjZqsrDnVuojG4DVHIMPaG7iMmHZ3Zp+u/jx5
	 nQmRIFcqhS89g5mhaGYa4yXFoTJbbqC+xHMr633uaX8xKxEmm1JYhLUzvAnYF/lZ7A
	 Y5SjkKJbY3CrpS+Kf29jBtpzbW6E2nRtU2jl+IjdW8UrSP434OrcqGqQQoScM3Fo3o
	 cn03if5PLRvCyCH5/NLhZeryVOuskHp8ewUqukZSKEavDUkOkExdtE1mYeOuoeJsx7
	 B2Mhwfvl8APz7oncfP/YjMHQTpV3Jbu7J+z8uF+OK5UB7tVAV6wz18ETLhbhl5NuQV
	 XPCa+8U1gBF6g==
Message-ID: <sashiko-outbox-190753@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v18 4/5] mptcp: sync mptcp skb cb layout with
 tcp one
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <ad478dff911f705f9d49c66a1a0ef1794b59c989.1793349369.git.geliang@kernel.org>
References: <cover.1793349369.git.geliang@kernel.org>
 <ad478dff911f705f9d49c66a1a0ef1794b59c989.1793349369.git.geliang@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 09:19:17 +0000
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
- [Critical] mptcp: subtracting offset from map_seq64 in mptcp_init_skb() c=
orrupts OFO data
- [High] mptcp: copied_seq desync when mptcp_move_skbs() runs before MPTCP_=
SYNC_SEQ
- [High] mptcp: 64-bit window wrap-around in mptcp_data_queue_ofo() when ac=
k_seq > max_seq
--

commit 7989e41ea583368f6b9348be07447be36c4632d3
Author: Paolo Abeni <pabeni@redhat.com>

mptcp: sync mptcp skb cb layout with tcp one

This commit updates struct mptcp_skb_cb to store 32-bit map_seq and end_seq
fields alongside a 64-bit map_seq64 field so that the MPTCP control buffer
layout matches TCP's sequence number and flags offsets. It also converts the
out-of-order queue and receive queue helpers to use 32-bit sequence
arithmetic after window validation.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 792147b5279f9..7195da74d5c73 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -301,16 +303,21 @@ static void mptcp_data_queue_ofo(struct mptcp_sock =
*msk, struct sk_buff *skb)
>  {
>  	struct sock *sk =3D (struct sock *)msk;
>  	struct rb_node **p, *parent;
> -	u64 seq, end_seq, max_seq;
> +	u64 end_seq, max_seq;
>  	struct sk_buff *skb1;
> +	u32 seq;
> =20
>  	seq =3D MPTCP_SKB_CB(skb)->map_seq;
> -	end_seq =3D MPTCP_SKB_CB(skb)->end_seq;
> +	end_seq =3D MPTCP_SKB_CB(skb)->map_seq64 + skb->len;
>  	max_seq =3D atomic64_read(&msk->rcv_wnd_sent);
> =20
> -	pr_debug("msk=3D%p seq=3D%llx limit=3D%llx empty=3D%d\n", msk, seq, max=
_seq,
> +	pr_debug("msk=3D%p seq=3D%x limit=3D%llx empty=3D%d\n", msk, seq, max_s=
eq,
>  		 RB_EMPTY_ROOT(&msk->out_of_order_queue));
> -	if (after64(end_seq, max_seq)) {
> +	/* Use the full sequence space to perform the admission checks, to
> +	 * protect vs possible wrap-arounds.
> +	 */
> +	if (after64(MPTCP_SKB_CB(skb)->map_seq64, max_seq) ||
> +	    after64(end_seq, max_seq)) {

[Severity: High]
Can a 64-bit sequence number wrap-around bypass this admission check when
msk->ack_seq has advanced past max_seq (msk->rcv_wnd_sent), allowing
out-of-window data to be queued and then dequeued via 32-bit truncation in
__mptcp_ofo_queue()?

In subflow_set_remote_key(), both msk->ack_seq and msk->rcv_wnd_sent are
initialized to subflow->iasn:

net/mptcp/subflow.c:subflow_set_remote_key() {
	...
	WRITE_ONCE(msk->ack_seq, subflow->iasn);
	WRITE_ONCE(msk->can_ack, true);
	atomic64_set(&msk->rcv_wnd_sent, subflow->iasn);
}

On an active MPTCP connection before the first outgoing DSS ACK updates
msk->rcv_wnd_sent via mptcp_set_rwin(), if in-order data of length N arrives
and is accepted by __mptcp_move_skb(), msk->ack_seq advances to
subflow->iasn + N while max_seq remains at subflow->iasn.

When msk->ack_seq > max_seq, a segment carrying a 64-bit data_seq in the
range [max_seq + 2^63 + 1, msk->ack_seq + 2^63 - 1] (for example,
subflow->iasn + 0x8000000000000000ULL + k with 1 <=3D k < N and k + len > N)
satisfies after64(map_seq64, msk->ack_seq) in __mptcp_move_skb(), but in
mptcp_data_queue_ofo() both after64(map_seq64, max_seq) and
after64(end_seq, max_seq) evaluate to false because max_seq - map_seq64 is
positive in signed 64-bit arithmetic.

Once queued into msk->out_of_order_queue, MPTCP_SKB_CB(skb)->map_seq and
end_seq are truncated to 32 bits, dropping bit 63 so that map_seq becomes
(u32)subflow->iasn + k. When __mptcp_ofo_queue() runs, after(map_seq, ack_s=
eq)
is false and after(end_seq, ack_seq) is true, so the out-of-window SKB is
moved into sk->sk_receive_queue and advances msk->ack_seq.

Should mptcp_data_queue_ofo() clamp or validate max_seq against msk->ack_seq
(or check the distance from msk->ack_seq) before performing the window chec=
k?

[ ... ]

> @@ -421,11 +428,13 @@ static void mptcp_init_skb(struct sock *ssk, struct=
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
As reported by Sashiko on v17 [1], does subtracting offset from map_seq64 a=
nd
map_seq without trimming the prefix bytes from skb corrupt the MPTCP data
stream when an SKB with offset > 0 carries an out-of-order mapping?

In __mptcp_move_skbs_from_subflow(), offset =3D tp->copied_seq - TCP_SKB_CB=
(skb)->seq
is non-zero when the first offset bytes of the head SKB on
ssk->sk_receive_queue were already consumed or discarded (for instance, when
a single subflow SKB spans two DSS mappings and mptcp_subflow_discard_data()
advances tp->copied_seq past the first mapping). Only the bytes in
[offset, skb->len) belong to the active DSS mapping starting at
mapped_dsn =3D mptcp_subflow_get_mapped_dsn(subflow).

When mapped_dsn > msk->ack_seq (out-of-order MPTCP data) and offset > 0,
subtracting offset in mptcp_init_skb() shifts map_seq64 and map_seq backwar=
ds
into the unreceived MPTCP sequence range [mapped_dsn - offset, mapped_dsn):

1. If mapped_dsn - offset <=3D msk->ack_seq, __mptcp_move_skb() treats the =
SKB
   as in-sequence or partially overlapping msk->ack_seq, queues it directly
   to sk->sk_receive_queue (or coalesces it into the tail SKB via
   __mptcp_try_coalesce()), and advances msk->ack_seq across the unreceived
   gap [msk->ack_seq, mapped_dsn), delivering the stale subflow prefix bytes
   [0, offset) to user space.

2. If mapped_dsn - offset > msk->ack_seq, mptcp_data_queue_ofo() inserts the
   SKB into out_of_order_queue covering [mapped_dsn - offset, mapped_dsn + =
len).
   From there, __mptcp_try_coalesce() can merge the unpulled [0, offset)
   prefix into a preceding OFO SKB ending at mapped_dsn - offset, subsequent
   legitimate segments for [mapped_dsn - offset, mapped_dsn) are dropped as
   duplicate data, and __mptcp_ofo_queue() dequeues the SKB as soon as
   msk->ack_seq reaches mapped_dsn - offset rather than mapped_dsn.

> +	MPTCP_SKB_CB(skb)->flags =3D 0;
>  	MPTCP_SKB_CB(skb)->has_rxtstamp =3D has_rxtstamp;
> =20
>  	__skb_unlink(skb, &ssk->sk_receive_queue);
> @@ -448,13 +457,14 @@ void __mptcp_sync_rcv_sequence(struct sock *sk)
>  	if (!skb)
>  		return;
> =20
> -	MPTCP_SKB_CB(skb)->map_seq =3D mptcp_iasn(msk) - skb->len;
> +	MPTCP_SKB_CB(skb)->map_seq64 =3D mptcp_iasn(msk) - skb->len;
> +	MPTCP_SKB_CB(skb)->map_seq =3D (u32)MPTCP_SKB_CB(skb)->map_seq64;
>  	MPTCP_SKB_CB(skb)->end_seq =3D MPTCP_SKB_CB(skb)->map_seq + skb->len;
>  }

[ ... ]

> @@ -2207,7 +2215,7 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, st=
ruct msghdr *msg,
>  	int copied =3D 0;
> =20
>  	skb_queue_walk_safe(&sk->sk_receive_queue, skb, tmp) {
> -		u64 offset =3D *seq - MPTCP_SKB_CB(skb)->map_seq;
> +		u32 offset =3D (u32)(*seq) - MPTCP_SKB_CB(skb)->map_seq;
>  		u32 data_len =3D skb->len - offset;
>  		u32 count;
>  		int err;
> @@ -4618,7 +4626,7 @@ static struct sk_buff *mptcp_recv_skb(struct sock *=
sk, u32 *off)
>  		mptcp_move_skbs(sk);
> =20
>  	while ((skb =3D skb_peek(&sk->sk_receive_queue)) !=3D NULL) {
> -		offset =3D msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
> +		offset =3D (u32)msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
>  		if (offset < skb->len) {
>  			*off =3D offset;
>  			return skb;

[Severity: High]
What happens in mptcp_recvmsg() and mptcp_recv_skb() if mptcp_move_skbs()
spools the backlog while MPTCP_SYNC_SEQ is still pending on msk->cb_flags?

When subflow_set_remote_key() runs in softirq while the MPTCP socket is own=
ed
by user space (for example, on a passive TFO socket during mptcp_recvmsg() =
or
__mptcp_read_sock()), it sets msk->ack_seq to subflow->iasn immediately, but
defers updating msk->copied_seq by setting MPTCP_SYNC_SEQ in msk->cb_flags:

net/mptcp/subflow.c:subflow_set_remote_key() {
	...
	if (!sock_owned_by_user(sk)) {
		msk->copied_seq +=3D subflow->iasn;
		__mptcp_sync_rcv_sequence(sk);
	} else {
		set_bit(MPTCP_SYNC_SEQ, &msk->cb_flags);
	}
}

If data arrives in the 3rd ACK or immediately afterward while user space st=
ill
holds the socket lock, the incoming SKBs are queued to msk->backlog_list wi=
th
map_seq64 and map_seq in the subflow->iasn sequence space. Before
release_sock() runs mptcp_release_cb(), both mptcp_recvmsg() and
mptcp_recv_skb() call mptcp_move_skbs(sk):

1. Inside mptcp_move_skbs() -> __mptcp_move_skbs() -> __mptcp_move_skb(),
   __mptcp_sync_rcv_sequence(sk) updates any remaining TFO SKB in
   sk->sk_receive_queue to map_seq =3D (u32)(mptcp_iasn(msk) - skb->len) and
   clears msk->rcvd_dummy_seq =3D false, while queuing the spooled SKBs with
   IASN-based map_seq values into sk->sk_receive_queue. However,
   msk->copied_seq is still in the pre-IASN sequence space.

2. In mptcp_recv_skb(), offset =3D (u32)msk->copied_seq - MPTCP_SKB_CB(skb)=
->map_seq
   is then off by -(u32)iasn, so offset >=3D skb->len holds whenever
   (u32)(-iasn) >=3D skb->len and the loop eats and drops every queued SKB =
via
   mptcp_eat_recv_skb(). Follow-up commit 68366c7579c4 ("mptcp: defer
   read_sock cleanup to mptcp_worker") later removes the mptcp_move_skbs()
   call from mptcp_recv_skb(), but does not address mptcp_recvmsg() or
   mptcp_release_cb().

3. In mptcp_recvmsg(), after mptcp_move_skbs(sk) returns true, the loop
   continues into __mptcp_recvmsg_mskq() with *seq still unsynchronized,
   causing u32 offset =3D (u32)(*seq) - MPTCP_SKB_CB(skb)->map_seq to skip
   unread SKBs or copy from a corrupted offset.

4. Even when release_sock() runs mptcp_release_cb(), __mptcp_move_skbs() ru=
ns
   before the test for MPTCP_SYNC_SEQ:

net/mptcp/protocol.c:mptcp_release_cb() {
	for (;;) {
		...
		if (__mptcp_move_skbs(sk, &join_list, &moved))
			...
		if (__test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
			msk->copied_seq +=3D mptcp_iasn(msk);
			__mptcp_sync_rcv_sequence(sk);
		}
	}
}

   If the spooled backlog carries a DATA_FIN, __mptcp_move_skbs() calls
   mptcp_check_data_fin(), which increments msk->ack_seq by 1 without
   incrementing msk->bytes_received. When MPTCP_SYNC_SEQ then adds
   mptcp_iasn(msk) (which is msk->ack_seq - msk->bytes_received +
   msk->tfo_skb_len), msk->copied_seq is advanced by iasn + 1, skipping 1
   byte of unread payload.

Should MPTCP_SYNC_SEQ be synchronized inside __mptcp_sync_rcv_sequence() (or
before spooling backlog SKBs in mptcp_move_skbs() and mptcp_release_cb()) so
that msk->copied_seq and the receive queue SKBs never end up in different
sequence spaces?

[1] https://lore.kernel.org/r/fe11356d3e5637de94fbe89540271d5f4ee381b4.1793=
326853.git.tanggeliang@kylinos.cn

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793349369.gi=
t.geliang@kernel.org?part=3D4
