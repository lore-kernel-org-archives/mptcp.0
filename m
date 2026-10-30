Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793351908;
	b=G9gJiBp2SsPWvW6U/dBL8rzKF3gsIDcLlb58k7jAaLN4sS1UGO7s6Lheya/ipDWUYAhp
	 68Q1N1hvKqfrPpqFyQWaOuPwFHoBihKiX2Rkr/9X7tz+/MbKxArBqsdZbM+bOzxWu7IrP
	 FA4jcpKoMskTA08YHtgps0/SnV9QwW7gt38XbqLysySHbaykCAtKPupWIauCJSiSWFrIt
	 MyZ4AGGCI36qY28GLGA5N1zRPTAx0gmRaUy8oQ1Qz8sR1oziK7C9BTfoqgCPo2FzipKxy
	 54NXquSaxC4Cd45VIWX87sFiYPEJIHPpjWsDvWZF72UEUhOX+kSutVo/iGXqmUayYVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793351908;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aZ3fH/fjTxmv7Xrr5NMUQ50S/7Z4XaJSPut6WkooWWc=;
	b=JXHd4j8J9BaQ/D24NCY5qTQj+0KATeAn4vu8x/GMyW3ZuyYvO9QX/v6nAD7kMBPcDmHp
	 FLFV53Jw9+dtxh8qm5R/kBch88/dhcY9EGZnkrejy/g5uGffvg9eDVyZW3K4iBFMMp9zi
	 qtKWtOuNVtYuNN8mnlXmsd5mJf7nDMabZhfxuKuIQhOLnbYeZRoJC4kh2PkiULUxSyb6z
	 FTgzXN+MCFFydWu2t0vuhoRvnZ4oY78pDyYgtMv5n1hsdCn354GEDc5n+9nOJtM3iSRFT
	 5d7/PNGpdNHcIyNEox1mBAa8MlOGnUT2FWLdqWMuesMHsfuyceAVrWApg7+DgPTDPWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O6fr+MuU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26718606A31D
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 09:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O6fr+MuU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E151F000C1;
	Fri, 30 Oct 2026 09:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793351907;
	bh=aZ3fH/fjTxmv7Xrr5NMUQ50S/7Z4XaJSPut6WkooWWc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=O6fr+MuUoCi1MZoJqWVNT4TSV9+K0i3V8V8KSA+VFqm8utn+Ok3WzIlxuduT0oI4/
	 h9OK9KgEZE9RiuUw25ewsee+TbeI0ZiXOrl09/jyjNcdbF/ls6UC2zd1YEkDmPNgCS
	 BfRsW/NljbtLCYL10eD4ErYCATtyDyP+4T4Z2Pf8CKiv/+RsANudlM30rqGoTTpWMu
	 PBCwllnwt7VHfoyj2F7DHOAEv1TPKfrRhGv2AgPUjE+qbVwRTu0Ipwul674/cPIe58
	 Zvc5lQ8pFlUQEEELDXjewcezL0j1CKClWZ3KjMEjxvTrhRVv6jAGDQLNvL8aOgp/wA
	 PbTGvCVLFrCKQ==
Message-ID: <sashiko-outbox-190751@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v18 3/5] mptcp: remove CB offset field
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <3cc892c20ed48f8f31f40e7a9ff7363d4b7b0806.1793349369.git.geliang@kernel.org>
References: <cover.1793349369.git.geliang@kernel.org>
 <3cc892c20ed48f8f31f40e7a9ff7363d4b7b0806.1793349369.git.geliang@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 09:18:26 +0000
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
- [High] mptcp: unsynchronized copied_seq when MPTCP_SYNC_SEQ is deferred
- [High] mptcp: off-by-one in mptcp_iasn() when DATA_FIN precedes MPTCP_SYN=
C_SEQ
- [High] mptcp: stream corruption in mptcp_init_skb() on non-zero skb offset
--

commit 1889ab1df71af9d2613dfc80ed132ac8e6d02071
Author: Paolo Abeni <pabeni@redhat.com>

mptcp: remove CB offset field

This commit replaces the per-skb MPTCP_SKB_CB(skb)->offset field with an
msk-level copied_seq counter to track consumed bytes in the MPTCP receive
queue. It also adds deferred sequence synchronization via MPTCP_SYNC_SEQ and
mptcp_iasn() for passive FastOpen sockets when the remote key arrives while
the socket is owned by user space.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index fe154b1816834..792147b5279f9 100644
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
> @@ -425,9 +423,9 @@ static void mptcp_init_skb(struct sock *ssk, struct s=
k_buff *skb, int offset,
>  	 * mptcp_subflow_get_mapped_dsn() is based on the current tp->copied_seq
>  	 * value
>  	 */
> -	MPTCP_SKB_CB(skb)->map_seq =3D mptcp_subflow_get_mapped_dsn(subflow);
> -	MPTCP_SKB_CB(skb)->end_seq =3D MPTCP_SKB_CB(skb)->map_seq + copy_len;
> -	MPTCP_SKB_CB(skb)->offset =3D offset;
> +	MPTCP_SKB_CB(skb)->map_seq =3D mptcp_subflow_get_mapped_dsn(subflow) -
> +				     offset;
> +	MPTCP_SKB_CB(skb)->end_seq =3D MPTCP_SKB_CB(skb)->map_seq + skb->len;
>  	MPTCP_SKB_CB(skb)->has_rxtstamp =3D has_rxtstamp;
> =20
>  	__skb_unlink(skb, &ssk->sk_receive_queue);

[Severity: High]
As reported by Sashiko on v17 [1], can subtracting offset from
mptcp_subflow_get_mapped_dsn(subflow) in mptcp_init_skb() and dropping the
offset check in __mptcp_try_coalesce() corrupt the MPTCP data stream when an
skb has a non-zero subflow offset?

An skb at the head of ssk->sk_receive_queue can reach
__mptcp_move_skbs_from_subflow() with offset =3D tp->copied_seq -
TCP_SKB_CB(skb)->seq > 0 while carrying a new DSS mapping M2 starting at
tp->copied_seq (skb->data[offset..skb->len)) with mapped_dsn =3D
mptcp_subflow_get_mapped_dsn(subflow):

1. In subflow_check_data_avail() -> get_mapping_status(), a single skb can
   span the tail of a previous DSS mapping M1 in skb->data[0..offset) and t=
he
   start of a new DSS mapping M2 in skb->data[offset..skb->len):

   net/mptcp/subflow.c:get_mapping_status() {
       ...
       if (!skb_is_fully_mapped(ssk, skb)) {
           /* will validate the next map after consuming the current one */
           goto validate_csum;
       }
   }

   If M1 was already received on another subflow (ack_seq < msk->ack_seq),
   mptcp_subflow_discard_data() advances tp->copied_seq by offset without
   eating the skb and resets subflow->map_valid =3D 0. On the next iteratio=
n,
   get_mapping_status() installs M2 starting offset bytes into the skb.

2. Similarly, tcp_data_queue() or tcp_ofo_queue() can queue a partially
   overlapping TCP segment with TCP_SKB_CB(skb)->seq < tp->copied_seq <
   TCP_SKB_CB(skb)->end_seq at a DSS mapping boundary.

Because MPTCP stripes mappings across subflows, M1 and M2 on the same subfl=
ow
have contiguous SSNs but non-contiguous MPTCP DSNs, so skb->data[0..offset)
does not belong to the DSN range [mapped_dsn - offset, mapped_dsn). Setting
MPTCP_SKB_CB(skb)->map_seq =3D mapped_dsn - offset (and map_seq64 =3D mappe=
d_dsn -
offset in the follow-up commit syncing the skb cb layout with tcp) causes
several problems when M2 is out of order (mapped_dsn > msk->ack_seq) or
queued to msk->backlog_list:

- If mapped_dsn - offset <=3D msk->ack_seq < mapped_dsn, __mptcp_move_skb()
  treats the out-of-order skb as in-sequence or partially overlapping,
  advances msk->ack_seq and msk->bytes_received across the unreceived gap
  [msk->ack_seq, mapped_dsn), coalesces skb->data[0..skb->len) onto the
  receive queue tail via mptcp_try_coalesce() if mapped_dsn - offset =3D=3D
  MPTCP_SKB_CB(tail)->end_seq, delivers the stale M1 bytes in
  skb->data[0..offset) to user space, and causes the genuine data for
  [msk->ack_seq, mapped_dsn) to be dropped later as MPTCP_MIB_DUPDATA.

- If mapped_dsn - offset > msk->ack_seq, mptcp_data_queue_ofo() inserts or
  coalesces the skb in msk->out_of_order_queue under the fabricated range
  [mapped_dsn - offset, end_seq), dropping or replacing legitimate
  out-of-order segments covering [mapped_dsn - offset, mapped_dsn) and
  delivering skb->data[0..offset) to user space when __mptcp_ofo_queue()
  dequeues it.

- In __mptcp_add_backlog(), if mapped_dsn - offset =3D=3D
  MPTCP_SKB_CB(tail)->end_seq for a prior backlog skb, __mptcp_try_coalesce=
()
  coalesces skb->data[0..skb->len) including the stale prefix
  skb->data[0..offset) into tail.

> @@ -440,7 +438,6 @@ void __mptcp_sync_rcv_sequence(struct sock *sk)
>  {
>  	struct mptcp_sock *msk =3D mptcp_sk(sk);
>  	struct sk_buff *skb;
> -	u32 offset;
> =20
>  	if (likely(!msk->rcvd_dummy_seq))
>  		return;
> @@ -451,9 +448,8 @@ void __mptcp_sync_rcv_sequence(struct sock *sk)
>  	if (!skb)
>  		return;
> =20
> -	offset =3D MPTCP_SKB_CB(skb)->offset;
> -	MPTCP_SKB_CB(skb)->map_seq =3D msk->ack_seq - skb->len + offset;
> -	MPTCP_SKB_CB(skb)->end_seq =3D msk->ack_seq;
> +	MPTCP_SKB_CB(skb)->map_seq =3D mptcp_iasn(msk) - skb->len;
> +	MPTCP_SKB_CB(skb)->end_seq =3D MPTCP_SKB_CB(skb)->map_seq + skb->len;
>  }

[ ... ]

> @@ -2209,33 +2198,24 @@ static void mptcp_eat_recv_skb(struct sock *sk, s=
truct sk_buff *skb)
>  }
> =20
>  static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
> -				size_t len, int flags, int copied_total,
> +				size_t len, int flags, u64 *seq,
>  				struct scm_timestamping_internal *tss,
>  				int *cmsg_flags, struct sk_buff **last)
>  {
>  	struct mptcp_sock *msk =3D mptcp_sk(sk);
>  	struct sk_buff *skb, *tmp;
> -	int total_data_len =3D 0;
>  	int copied =3D 0;
> =20
>  	skb_queue_walk_safe(&sk->sk_receive_queue, skb, tmp) {
> -		u32 delta, offset =3D MPTCP_SKB_CB(skb)->offset;
> +		u64 offset =3D *seq - MPTCP_SKB_CB(skb)->map_seq;
>  		u32 data_len =3D skb->len - offset;
>  		u32 count;
>  		int err;
> =20
> -		if (flags & MSG_PEEK) {
> -			/* skip already peeked skbs */
> -			if (total_data_len + data_len <=3D copied_total) {
> -				total_data_len +=3D data_len;
> -				*last =3D skb;
> -				continue;
> -			}
> -
> -			/* skip the already peeked data in the current skb */
> -			delta =3D copied_total - total_data_len;
> -			offset +=3D delta;
> -			data_len -=3D delta;
> +		/* Skip the already peeked data. */
> +		if (offset >=3D skb->len) {
> +			*last =3D skb;
> +			continue;
>  		}

[ ... ]

> @@ -2417,22 +2395,17 @@ static bool mptcp_move_skbs(struct sock *sk)
>  static unsigned int mptcp_inq_hint(const struct sock *sk)
>  {
>  	const struct mptcp_sock *msk =3D mptcp_sk(sk);
> -	const struct sk_buff *skb;
> -
> -	skb =3D skb_peek(&sk->sk_receive_queue);
> -	if (skb) {
> -		u64 hint_val =3D READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
> +	u64 hint_val;
> =20
> -		if (hint_val >=3D INT_MAX)
> -			return INT_MAX;
> +	hint_val =3D READ_ONCE(msk->ack_seq) - READ_ONCE(msk->copied_seq);
> +	if (hint_val >=3D INT_MAX)
> +		return INT_MAX;
> =20
> -		return (unsigned int)hint_val;
> -	}
> -
> -	if (sk->sk_state =3D=3D TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN))
> +	if (!hint_val &&
> +	    (sk->sk_state =3D=3D TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN)))
>  		return 1;
> =20
> -	return 0;
> +	return (unsigned int)hint_val;
>  }

[ ... ]

> @@ -2478,8 +2457,11 @@ static int mptcp_recvmsg(struct sock *sk, struct m=
sghdr *msg, size_t len,
> =20
>  		copied +=3D bytes_read;
> =20
> -		if (!list_empty(&msk->backlog_list) && mptcp_move_skbs(sk))
> +		if (!list_empty(&msk->backlog_list) && mptcp_move_skbs(sk)) {
> +			if (flags & MSG_PEEK)
> +				peek_seq =3D msk->copied_seq + copied;
>  			continue;
> +		}

[ ... ]

> @@ -3955,8 +3943,10 @@ static void mptcp_release_cb(struct sock *sk)
>  			__mptcp_error_report(sk);
>  		if (__test_and_clear_bit(MPTCP_SYNC_SNDBUF, &msk->cb_flags))
>  			__mptcp_sync_sndbuf(sk);
> -		if (__test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags))
> +		if (__test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
> +			msk->copied_seq +=3D mptcp_iasn(msk);
>  			__mptcp_sync_rcv_sequence(sk);
> +		}
>  	}
>  }
> =20
> @@ -4628,7 +4618,7 @@ static struct sk_buff *mptcp_recv_skb(struct sock *=
sk, u32 *off)
>  		mptcp_move_skbs(sk);
> =20
>  	while ((skb =3D skb_peek(&sk->sk_receive_queue)) !=3D NULL) {
> -		offset =3D MPTCP_SKB_CB(skb)->offset;
> +		offset =3D msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
>  		if (offset < skb->len) {
>  			*off =3D offset;
>  			return skb;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index c317d8b59fffb..985ef15275eb0 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h

[ ... ]

> @@ -884,6 +885,11 @@ struct sock *mptcp_subflow_get_retrans(struct mptcp_=
sock *msk);
>  int mptcp_sched_get_send(struct mptcp_sock *msk);
>  int mptcp_sched_get_retrans(struct mptcp_sock *msk);
> =20
> +static inline u64 mptcp_iasn(const struct mptcp_sock *msk)
> +{
> +	return msk->ack_seq - msk->bytes_received + msk->tfo_skb_len;
> +}
> +
>  static inline u64 mptcp_data_avail(const struct mptcp_sock *msk)
>  {
>  	return READ_ONCE(msk->bytes_received) - READ_ONCE(msk->bytes_consumed);

[Severity: High]
As reported by Sashiko on v15 [2], won't mptcp_iasn() be off by one if a
DATA_FIN is processed before the deferred MPTCP_SYNC_SEQ runs in
mptcp_release_cb()?

The commit message notes that mptcp_check_data_fin() incrementing ack_seq
before MPTCP_SYNC_SEQ runs would require a DATA_FIN to arrive before the MPC
third ACK on a passive TFO socket. However, subflow_set_remote_key() sets
MPTCP_SYNC_SEQ at the moment the MPC third ACK (or SYN-ACK on an active
socket) arrives while sock_owned_by_user(sk) is true, which also establishes
the connection and sets msk->ack_seq =3D subflow->iasn.

If the peer sends a payload with DATA_FIN (or a subflow closes immediately)
together with or right after the MPC third ACK while lock_sock(sk) is still
held:

1. When data + DATA_FIN is queued to msk->backlog_list while lock_sock(sk) =
is
   held, release_sock(sk) invokes mptcp_release_cb(sk), which spools the
   backlog via __mptcp_move_skbs() in its loop before checking MPTCP_SYNC_S=
EQ
   at the end of the function:

   net/mptcp/protocol.c:__mptcp_move_skbs() {
       ...
       __mptcp_ofo_queue(msk);
       if (moved)
           mptcp_check_data_fin((struct sock *)msk);
       return moved;
   }

   Inside __mptcp_move_skbs(), __mptcp_move_skb() syncs any TFO skb using
   mptcp_iasn(msk) =3D=3D subflow->iasn and queues the new skb at map_seq =
=3D
   subflow->iasn, and then mptcp_check_data_fin() increments msk->ack_seq b=
y 1
   without incrementing msk->bytes_received. When mptcp_release_cb() then
   processes MPTCP_SYNC_SEQ, msk->copied_seq +=3D mptcp_iasn(msk) adds
   subflow->iasn + 1, advancing msk->copied_seq one byte past the queued sk=
b's
   map_seq and skipping the first byte of unread payload.

2. Similarly, if a 0-payload DATA_FIN arrives after the third ACK while
   mptcp_worker() holds lock_sock(sk), mptcp_worker() calls
   mptcp_check_data_fin(sk) and increments msk->ack_seq to subflow->iasn + 1
   before release_sock(sk) runs mptcp_release_cb(sk).

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 49a000b8dcb8e..899ffaba0b2b6 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -536,10 +536,12 @@ static void subflow_set_remote_key(struct mptcp_soc=
k *msk,
>  	WRITE_ONCE(msk->can_ack, true);
>  	atomic64_set(&msk->rcv_wnd_sent, subflow->iasn);
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
As reported by Sashiko on v15 [2], when subflow_set_remote_key() runs in BH
context while sock_owned_by_user(sk) is true, it immediately updates
msk->ack_seq to subflow->iasn and sets msk->can_ack =3D true, but defers
updating msk->copied_seq via MPTCP_SYNC_SEQ until mptcp_release_cb(). What
happens if the user context holding lock_sock(sk) accesses msk->copied_seq =
or
spools the backlog before release_sock(sk) runs?

Specifically, if the peer's MP_CAPABLE third ACK (on a passive TFO socket) =
or
SYN-ACK (on an active client socket) arrives with or followed by data while
user space holds lock_sock(sk):

1. In mptcp_recvmsg(), mptcp_recv_skb(), and mptcp_ioctl(SIOCINQ),
   mptcp_move_skbs(sk) is called while holding lock_sock(sk). Inside
   mptcp_move_skbs() -> __mptcp_move_skbs() -> __mptcp_move_skb(),
   __mptcp_sync_rcv_sequence(sk) rebases any queued TFO skb's map_seq from
   -(u64)skb->len to mptcp_iasn(msk) - skb->len and clears
   msk->rcvd_dummy_seq =3D false, and __mptcp_move_skb() moves the IASN-map=
ped
   backlog skbs into sk->sk_receive_queue. However, MPTCP_SYNC_SEQ is still
   pending, so msk->copied_seq (and peek_seq =3D msk->copied_seq + copied in
   mptcp_recvmsg()) remains in the pre-IASN sequence space.

2. In mptcp_recv_skb(), the loop then computes:

   offset =3D msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
   if (offset < skb->len) {
       *off =3D offset;
       return skb;
   }
   mptcp_eat_recv_skb(sk, skb);

   Because msk->copied_seq has not been rebased by subflow->iasn, offset
   underflows to a value >=3D skb->len, and mptcp_eat_recv_skb() frees and =
drops
   every unread skb in sk->sk_receive_queue without advancing msk->copied_s=
eq
   or msk->bytes_consumed. Even after the later commit in this series ("mpt=
cp:
   defer read_sock cleanup to mptcp_worker") removes mptcp_move_skbs() from
   mptcp_recv_skb(), mptcp_release_cb() still runs __mptcp_move_skbs() and
   calls sk->sk_data_ready(sk) in its loop before processing MPTCP_SYNC_SEQ,
   so kTLS RX synchronously invokes __mptcp_read_sock() -> mptcp_recv_skb()
   with an unsynchronized msk->copied_seq and drops the queued skbs.

3. In mptcp_recvmsg(), the next iteration of __mptcp_recvmsg_mskq() computes
   offset =3D *seq - MPTCP_SKB_CB(skb)->map_seq, which similarly underflows=
 by
   subflow->iasn; when offset >=3D skb->len, it treats all unread skbs in
   sk->sk_receive_queue as already-peeked data, sets *last =3D skb, and blo=
cks
   in sk_wait_data() (or copies from a corrupted mid-skb offset if a 32-bit
   offset wraps below skb->len in the follow-up commit).

4. In mptcp_inq_hint() (called under lock_sock(sk) by mptcp_ioctl(SIOCINQ),
   TCP_CM_INQ, and mptcp_rcv_space_adjust()), READ_ONCE(msk->ack_seq) -
   READ_ONCE(msk->copied_seq) subtracts the pre-IASN msk->copied_seq from t=
he
   post-IASN msk->ack_seq, returning INT_MAX and corrupting receive buffer
   autotuning.

[1] https://lore.kernel.org/r/9a98772b14e535454de5bafbf113aa72a3ee6f44.1793=
326853.git.tanggeliang@kylinos.cn
[2] https://lore.kernel.org/r/25f42bae1af43649a5c89ca10cfe0d962941c6f7.1792=
718041.git.tanggeliang@kylinos.cn

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793349369.gi=
t.geliang@kernel.org?part=3D3
