Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701307;
	b=VQhWjqLfom1MmFNDpvqn2faYHO9PFep2ck3iweHjXLDnwKttgHcR04XdnDWzB1YIhhXU
	 Q+EBJ0XijzckVXonvO3dBm3e3wtqjYfFkXOrO37I8I4npudOatOA8uooydaAcZlQSttrp
	 Ia4Gn5Ja0mkIZTVfskItciIbveMLkkGh1lL4R41FLLfQUKgjttKpf8tgRklUjC0PqUHbv
	 C4Hl1JCDP4jngSQfv8Pp8uoy/hxBsOmvWzhHNWeIGO6arOE3xG77Mol9Ys+MY9p5KhR5H
	 V2cnPZz9ptHySj0+2u8pwFiYtNLPQCkMYiqrfvuH/ZSmhMBE7/UL5ckvxycof7wMEwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701307;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9SDMxHFxUL+ogmtys/7ONVduqGB0/dkY/RtmKhUklo4=;
	b=Covioizpx2eD2B2NsiZ1JqR2Dl70wDy+UcQKXfTFxaB3NclS+e5MDlGuDKw0MJc7lNxV
	 6MhzczSIDkcb2OOvhImV9HBYzxHD5WiQMmvj2Fmkmg6NyFFUJ/zKYbAamirwApLpNMezP
	 eSQDiNUQb0Sv94ijxKSKHo2KhsYJ2CIhCsXnHJ6LGc+td8j6RyDMhZCcJSXINc/y+HKz0
	 aGC10kZhRkKMYvyDIn0hiKe9sd/if6Co5VjuN517udUSZMF5yHJm5ljxGGywAiP8AzhJ5
	 35pxfatqiHrrwPiGhZsbK+yct4vrmyEodZsG0lmLe3W4PAouPOjEaZckjnHrrbDzFng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DoBV4QMl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80B3606D801
	for <mptcp@lists.linux.dev>; Tue,  3 Nov 2026 10:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DoBV4QMl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECE31F000C1;
	Tue,  3 Nov 2026 10:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793701306;
	bh=9SDMxHFxUL+ogmtys/7ONVduqGB0/dkY/RtmKhUklo4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=DoBV4QMlcn9bURv9YK0V9cewWrxm+HeSueDk59KuyOFK6JwZVVORWOF2xX6r7UrzV
	 KCiGvWyEReoFIvF8J21dm8KHdrKeMYPwB+ETpv0LZ2qeUjTfDiHnDPhSHZzUELN8e6
	 s/O42pgfTWVyWPOml9kjOTWBMYxiwlnMTz8lZjSewcN9ExeEi30jITg4PACd3sRPnF
	 C8itTQu1H0WXZvKsPd8I57iShzxy7RGwY6qo0khN82L1COgZH58JW131l2UY/QtS83
	 YlBud+bWuJp1J+o3l7WGOOz7/4BY5G/xFMZiYZPm4e7a+nLA8dyEniadQzzbOm3rTG
	 mtb5wDKaTUQzw==
Message-ID: <sashiko-outbox-195035@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v20 4/6] mptcp: remove CB offset field
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <866f86ad2ea894fc21af7546ed0cf6f8b9d816de.1793695518.git.tanggeliang@kylinos.cn>
References: <cover.1793695518.git.tanggeliang@kylinos.cn>
 <866f86ad2ea894fc21af7546ed0cf6f8b9d816de.1793695518.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 10:21:46 +0000
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
- [High] mptcp: stale map_seq subtraction in mptcp_inq_hint() after removin=
g CB offset
- [High] mptcp: stream corruption in mptcp_init_skb() on non-zero subflow o=
ffset
--

commit 698eb6e054556fc8ba45c463c10e26a894f29975
Author: Paolo Abeni <pabeni@redhat.com>

mptcp: remove CB offset field

This commit removes the offset field from struct mptcp_skb_cb and introduces
copied_seq in struct mptcp_sock to track consumed bytes across receive skbs.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index f3b07b303f555..3bd7d38ce78c4 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -168,7 +168,6 @@ static bool __mptcp_try_coalesce(struct sock *sk, str=
uct sk_buff *to,
>  	int limit =3D READ_ONCE(sk->sk_rcvbuf);
> =20
>  	if (MPTCP_SKB_CB(from)->map_seq !=3D MPTCP_SKB_CB(to)->end_seq ||
> -	    MPTCP_SKB_CB(from)->offset ||
>  	    ((to->len + from->len) > (limit >> 3)) ||
>  	    !skb_try_coalesce(to, from, fragstolen, delta))
>  		return false;
> @@ -415,8 +414,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *m=
sk, struct sk_buff *skb)
>  	skb_set_owner_r(skb, sk);
>  }
> =20
> -static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int of=
fset,
> -			   int copy_len)
> +static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int of=
fset)
>  {
>  	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
>  	bool has_rxtstamp =3D TCP_SKB_CB(skb)->has_rxtstamp;
> @@ -424,10 +422,13 @@ static void mptcp_init_skb(struct sock *ssk, struct=
 sk_buff *skb, int offset,
>  	/* the skb map_seq accounts for the skb offset:
>  	 * mptcp_subflow_get_mapped_dsn() is based on the current tp->copied_seq
>  	 * value
> +	 *
> +	 * This is correct even when offset > 0 and mapping is out-of-order,
> +	 * because consumed prefix bytes are part of the same logical DSN range.
>  	 */
> -	MPTCP_SKB_CB(skb)->map_seq =3D mptcp_subflow_get_mapped_dsn(subflow);
> -	MPTCP_SKB_CB(skb)->end_seq =3D MPTCP_SKB_CB(skb)->map_seq + copy_len;
> -	MPTCP_SKB_CB(skb)->offset =3D offset;
> +	MPTCP_SKB_CB(skb)->map_seq =3D mptcp_subflow_get_mapped_dsn(subflow) -
> +				     offset;
> +	MPTCP_SKB_CB(skb)->end_seq =3D MPTCP_SKB_CB(skb)->map_seq + skb->len;

[Severity: High]
As reported by Sashiko on v19 [1], can subtracting offset from
mptcp_subflow_get_mapped_dsn(subflow) in mptcp_init_skb() corrupt the recei=
ve
stream when a subflow skb has a non-zero offset at the start of a new DSS
mapping?

In __mptcp_move_skbs_from_subflow(), the head skb on ssk->sk_receive_queue =
can
have offset =3D tp->copied_seq - TCP_SKB_CB(skb)->seq > 0 while starting a =
new
DSS mapping M2 at tp->copied_seq.

For example, in subflow_check_data_avail() -> get_mapping_status(), a single
TCP skb can carry the tail of an earlier mapping M1 in skb->data[0..offset-=
1]
and a new mapping M2 in its SKB_EXT_MPTCP extension starting at offset:

net/mptcp/subflow.c:get_mapping_status() {
	...
		if (skb_is_fully_mapped(ssk, skb)) {
			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSNOMATCH);
			return MAPPING_INVALID;
		}

		/* will validate the next map after consuming the current one */
		goto validate_csum;
	...
}

When the remaining bytes of M1 have already been acknowledged at the MPTCP
level, mptcp_subflow_discard_data() advances tp->copied_seq by offset witho=
ut
eating the skb and resets subflow->map_valid =3D 0. On the next loop iterat=
ion
in subflow_check_data_avail(), get_mapping_status() installs M2 starting at
tp->copied_seq (offset bytes into the skb). The same situation also occurs
when tcp_data_queue() or tcp_ofo_queue() queues a partially overlapping TCP
segment whose first offset bytes overlap the end of M1 and whose remaining
bytes start M2 at tp->copied_seq.

Because MPTCP stripes data across multiple subflows, M1 and M2 are contiguo=
us
only in subflow sequence space, not in data sequence space when intervening
DSNs [mapped_dsn - offset, mapped_dsn) were sent on another subflow. Setting
MPTCP_SKB_CB(skb)->map_seq =3D mapped_dsn - offset assigns the DSN range
[mapped_dsn - offset, mapped_dsn) to the stale M1 prefix bytes in
skb->data[0..offset-1]:

1. When M2 is out-of-order at the MPTCP level (mapped_dsn > msk->ack_seq)
   because [msk->ack_seq, mapped_dsn) is in flight on another subflow, and
   mapped_dsn - offset <=3D msk->ack_seq < mapped_dsn, __mptcp_move_skb() s=
ees
   MPTCP_SKB_CB(skb)->map_seq <=3D msk->ack_seq. It treats the skb as
   in-sequence (or partial in-sequence), advances msk->ack_seq across the
   unreceived gap [msk->ack_seq, mapped_dsn), delivers the stale M1 prefix
   bytes from skb->data[0..offset-1] to user space via __mptcp_recvmsg_mskq=
()
   and mptcp_recv_skb(), and drops the genuine data arriving on the other
   subflow as MPTCP_MIB_DUPDATA.

2. Because __mptcp_try_coalesce() no longer checks MPTCP_SKB_CB(from)->offs=
et,
   whenever mapped_dsn - offset equals MPTCP_SKB_CB(to)->end_seq in
   __mptcp_add_backlog(), __mptcp_move_skb(), mptcp_data_queue_ofo(), or
   __mptcp_ofo_queue(), skb_try_coalesce() appends all from->len bytes
   starting at byte 0 (including the stale M1 prefix in from->data[0..offse=
t-1])
   onto to.

3. When mapped_dsn - offset > msk->ack_seq, mptcp_data_queue_ofo() inserts =
the
   skb into msk->out_of_order_queue under the falsified start DSN
   mapped_dsn - offset, where it can coalesce with or replace legitimate
   out-of-order segments covering [mapped_dsn - offset, mapped_dsn) and be
   dequeued prematurely by __mptcp_ofo_queue().

[ ... ]

> @@ -2252,14 +2237,12 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, =
struct msghdr *msg,
>  		}
> =20
>  		copied +=3D count;
> +		*seq +=3D count;
> =20
>  		if (!(flags & MSG_PEEK)) {
>  			msk->bytes_consumed +=3D count;
> -			if (count < data_len) {
> -				MPTCP_SKB_CB(skb)->offset +=3D count;
> -				MPTCP_SKB_CB(skb)->map_seq +=3D count;
> +			if (count < data_len)
>  				break;
> -			}
> =20
>  			mptcp_eat_recv_skb(sk, skb);
>  		} else {

[ ... ]

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 8a3ba490b5772..71c3b148cf04a 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -537,10 +537,12 @@ static void subflow_set_remote_key(struct mptcp_soc=
k *msk,
>  	atomic64_set(&msk->rcv_wnd_sent, subflow->iasn);
>  	msk->tfo_iasn =3D subflow->iasn;
> =20
> -	if (!sock_owned_by_user(sk))
> +	if (!sock_owned_by_user(sk)) {
> +		msk->copied_seq +=3D subflow->iasn;
>  		__mptcp_sync_rcv_sequence(sk);
> -	else
> +	} else {
>  		set_bit(MPTCP_SYNC_SEQ, &msk->cb_flags);
> +	}
>  }

[Severity: High]
As reported by Sashiko on v15 [2], does mptcp_inq_hint() still compute the
unread byte count using MPTCP_SKB_CB(skb)->map_seq instead of msk->copied_s=
eq?

The commit message notes that this change fixes and simplifies
mptcp_inq_hint() via the new ack_seq - copied_seq hint, but mptcp_inq_hint()
in net/mptcp/protocol.c still reads:

net/mptcp/protocol.c:mptcp_inq_hint() {
	const struct mptcp_sock *msk =3D mptcp_sk(sk);
	const struct sk_buff *skb;

	skb =3D skb_peek(&sk->sk_receive_queue);
	if (skb) {
		u64 hint_val =3D READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;

		if (hint_val >=3D INT_MAX)
			return INT_MAX;

		return (unsigned int)hint_val;
	}
	...
}

Because __mptcp_recvmsg_mskq(), __mptcp_read_sock(), __mptcp_move_skb(), and
__mptcp_ofo_queue() no longer advance MPTCP_SKB_CB(skb)->map_seq as bytes a=
re
consumed or overlapped, and mptcp_init_skb() subtracts offset from map_seq,
MPTCP_SKB_CB(skb)->map_seq stays at the start of the head skb while
msk->copied_seq advances. Whenever the head skb in sk->sk_receive_queue is
partially read (count < data_len) or has a non-zero offset, mptcp_inq_hint()
over-counts unread bytes by msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq for
SIOCINQ in mptcp_ioctl(), TCP_CM_INQ in mptcp_recvmsg(), and receive buffer
auto-tuning in mptcp_rcv_space_adjust().

In addition, on a passive TFO socket when the peer's 3rd ACK arrives while
sock_owned_by_user(sk) is true, subflow_set_remote_key() updates msk->ack_s=
eq
to subflow->iasn immediately while deferring msk->copied_seq +=3D msk->tfo_=
iasn
and __mptcp_sync_rcv_sequence(sk) via MPTCP_SYNC_SEQ. If mptcp_inq_hint() r=
uns
before MPTCP_SYNC_SEQ is processed (for example in __mptcp_recvmsg_mskq() ->
mptcp_rcv_space_adjust(), at out_err in mptcp_recvmsg() when msk->backlog_l=
ist
is empty, in __mptcp_read_sock() -> mptcp_rcv_space_adjust(), or in
mptcp_ioctl() if the 3rd ACK arrives after mptcp_move_skbs()), it subtracts
the pre-IASN sequence from the post-IASN msk->ack_seq and returns INT_MAX.

Furthermore, a later patch in this series (commit 0495d49fc957, "mptcp: sync
mptcp skb cb layout with tcp one") narrows MPTCP_SKB_CB(skb)->map_seq from =
u64
to u32, which will cause READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_s=
eq
to return INT_MAX whenever the upper 32 bits of msk->ack_seq are non-zero.

Should mptcp_inq_hint() use msk->copied_seq (while accounting for any pendi=
ng
MPTCP_SYNC_SEQ adjustment) instead of MPTCP_SKB_CB(skb)->map_seq?

[1] https://lore.kernel.org/r/1dac839fffd26114e35382b256fdee9923c0949b.1793=
361629.git.tanggeliang@kylinos.cn
[2] https://lore.kernel.org/r/25f42bae1af43649a5c89ca10cfe0d962941c6f7.1792=
718041.git.tanggeliang@kylinos.cn

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793695518.gi=
t.tanggeliang@kylinos.cn?part=3D4
