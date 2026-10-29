Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793257839;
	b=5ko48E/0OKt3kSQzhQcWY+kKfjJcbxcQ0VqoqnXavlRvHEa1W9UTAIbmrDUzynGATALh
	 uvwe+XEDz/kw1WwLvjgg9vEy+LCcO5S0b9R34EFWS8S4DyyXO+AzkiLJ80ShS0CZ3vrGa
	 Uucf7GS3PUGqjhWfMMJz5WesmhWnTc8cXsj0y8P1lL00AGGlWL1ouwgIl99ACnD3LOw/b
	 pe+F5sEwxyffEQNznD8RiiwT0LkVJ4/wxwl4Czd+q19IjSdo1D1zSlwcWSMqN1ypBESx1
	 hMM4mD9yUpMnX6zobBFCuJGGQERQ+DNw0D0M9YCHs2MMmyHiihRofrEGnA8qLi+z5dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793257839;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hJUICLT8dEGz1aBU8ux3nTsU6SpBnBbCgdFmrx40tac=;
	b=LRPY2ACXQeBMQy6biyhOlzyNqLCX03891ybr98A+7pGMnQ0UrT7HPH2l24gP4Cd2Wjsf
	 Zhmdo9WBIWKwx1ZZR7lrO6fn7qthB9lV+sj8MvL1+F75cCH6+lVIsCS9LiwyD1GDdeOdz
	 flXlDBsi5RvkQD1RTmckUNJvSAmOPNmXkuPEG1pUlD5Smr0hoXqoSZNsXA43uu483jueW
	 9Oy5YdbMlzD7O2PtG93UNVa2zNY6eNcCOtadFiuygShkPDgzvG+NDaVuI+t4Knj0FXeRK
	 sw52aU2qc8wreCUUR7+D7bfDrQI8lKhDLEEtF6xUzTa5is9eDI8EDYUTXCo1zS/Up/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X+TN1aba;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EC9606A31D
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 07:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X+TN1aba
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5011F01825;
	Thu, 29 Oct 2026 07:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793257838;
	bh=hJUICLT8dEGz1aBU8ux3nTsU6SpBnBbCgdFmrx40tac=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=X+TN1abas6NV8v+o8NpAjMSw1QjjOZMgRgo+ov/yUdcbBCDIruVkbneuZ7Py0MRpP
	 s2eW3KLvRYgnG4hmZ+tMeb4o3z4PAWK9u2mmyBpSEzO+YZH5aT06dpFSkD7H8x9RvD
	 nJCeZij6hfzW6UCrx5Ha2AusTuzSoSlOItsvkD9oPFcGpVxmhrUMq0W7Gu4RASpFOO
	 PjS/nGNbSsRvYoDttMQ1LIV4OZXassf9oWnHNR/3Vnysx2mDks6pe19a8PtwnGzm5B
	 roYx+d48q4xVTvSFISO8Bu/d5IqLF/RIAj2w6QCKvpBBmBN200fSgX/35aIyhtlWaF
	 /qYEQetTrpLvw==
Message-ID: <sashiko-outbox-188838@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v16 2/4] mptcp: remove CB offset field
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <f046ebeaec309bdefe1046f7df18ce40b2496efd.1793255126.git.tanggeliang@kylinos.cn>
References: <cover.1793255126.git.tanggeliang@kylinos.cn>
 <f046ebeaec309bdefe1046f7df18ce40b2496efd.1793255126.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 07:10:38 +0000
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
- [Critical] mptcp: race and TFO progress loss in subflow_set_remote_key()
- [Critical] mptcp: stream corruption from offset subtraction in mptcp_init=
_skb()
- [High] mptcp: MSG_PEEK offset underflow across skbs in __mptcp_recvmsg_ms=
kq()
- [Medium] mptcp: stale map_seq used instead of copied_seq in mptcp_inq_hin=
t()
--

commit 285d6e793ca5e906015b250b9d8ba67747179bc7
Author: Paolo Abeni <pabeni@redhat.com>

mptcp: remove CB offset field

This commit replaces MPTCP_SKB_CB(skb)->offset with an msk-level copied_seq
field to track the sequence number of bytes already consumed by user-space
from the MPTCP receive queue.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 528a72da646cc..f89ed94b668d9 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -169,7 +169,6 @@ static bool __mptcp_try_coalesce(struct sock *sk, str=
uct sk_buff *to,
> =20
>  	if (MPTCP_SKB_CB(from)->map_seq !=3D MPTCP_SKB_CB(to)->end_seq ||
>  	    unlikely(MPTCP_SKB_CB(to)->cant_coalesce) ||
> -	    MPTCP_SKB_CB(from)->offset ||
>  	    ((to->len + from->len) > (limit >> 3)) ||
>  	    !skb_try_coalesce(to, from, fragstolen, delta))
>  		return false;
> @@ -416,8 +415,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *m=
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
> @@ -426,9 +424,9 @@ static void mptcp_init_skb(struct sock *ssk, struct s=
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

[Severity: Critical]
Can subtracting offset from MPTCP_SKB_CB(skb)->map_seq here introduce a
regression that corrupts the MPTCP receive byte stream when an skb has a
non-zero subflow offset (offset =3D tp->copied_seq - TCP_SKB_CB(skb)->seq >=
 0
in __mptcp_move_skbs_from_subflow())?

For example, when an skb spans two DSS mappings and the first mapping's byt=
es
were discarded by mptcp_subflow_discard_data(), or when TCP queues a
partially overlapping segment with TCP_SKB_CB(skb)->seq < tp->copied_seq, t=
he
first offset bytes of skb are discarded subflow data and the valid mapped
data starts at D =3D mptcp_subflow_get_mapped_dsn(subflow).

Subtracting offset assigns the DSN range [D - offset, D) to the unpulled
0..offset - 1 prefix of skb:

1. Because __mptcp_try_coalesce() no longer checks MPTCP_SKB_CB(from)->offs=
et
   and skb_try_coalesce() copies or appends the from skb starting at byte 0,
   any preceding skb in msk->backlog_list, sk->sk_receive_queue, or
   msk->out_of_order_queue whose end_seq equals D - offset will coalesce
   with this skb and append the discarded 0..offset - 1 prefix into the
   received data stream.

2. When the mapping D is out-of-order (after64(D, msk->ack_seq)),
   __mptcp_move_skb() and mptcp_data_queue_ofo() use map_seq =3D D - offset:

   - If D - offset > msk->ack_seq, mptcp_data_queue_ofo() inserts the skb at
     D - offset, drops genuine incoming segments for [D - offset, D) as
     duplicate data, and later delivers the stale 0..offset - 1 bytes to
     user-space when msk->ack_seq reaches D - offset.

   - If D - offset <=3D msk->ack_seq < D, __mptcp_move_skb() treats the
     out-of-order skb as a partial in-sequence packet, queues it immediately
     to sk->sk_receive_queue, and advances msk->ack_seq across the unreceiv=
ed
     gap [msk->ack_seq, D).

[ ... ]

> @@ -2195,11 +2186,17 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, =
struct msghdr *msg,
>  	int copied =3D 0;
> =20
>  	skb_queue_walk_safe(&sk->sk_receive_queue, skb, tmp) {
> -		u32 delta, offset =3D MPTCP_SKB_CB(skb)->offset;
> +		u32 delta, offset =3D (u32)msk->copied_seq - MPTCP_SKB_CB(skb)->map_se=
q;
>  		u32 data_len =3D skb->len - offset;
>  		u32 count;
>  		int err;
> =20
> +		/* Skip skbs that are entirely before copied_seq */
> +		if (offset >=3D skb->len) {
> +			*last =3D skb;
> +			continue;
> +		}

[Severity: High]
Does this offset calculation break recvmsg() with MSG_PEEK when peeking
across multiple skbs in sk->sk_receive_queue?

When flags & MSG_PEEK is set, msk->copied_seq is not advanced after copying
data from the first skb (skb1). When the loop moves to the second skb (skb2)
where MPTCP_SKB_CB(skb2)->map_seq >=3D MPTCP_SKB_CB(skb1)->end_seq >
msk->copied_seq, the unsigned subtraction:

    offset =3D (u32)msk->copied_seq - MPTCP_SKB_CB(skb2)->map_seq;

underflows to a large u32 value, so offset >=3D skb->len evaluates to true =
and
causes __mptcp_recvmsg_mskq() to skip skb2 and all subsequent skbs in
sk->sk_receive_queue. If MSG_WAITALL or SO_RCVLOWAT requests more bytes than
skb1 contains, mptcp_recvmsg() can then hang in sk_wait_data() even though
enough unread data is already queued.

Conversely, if skb2 had a partially overlapping map_seq <=3D msk->copied_seq
(since __mptcp_move_skb() and __mptcp_ofo_queue() no longer advance map_seq
to msk->ack_seq), offset on skb2 will not underflow and will start copying
at msk->copied_seq instead of skb1->end_seq, duplicating the overlapping
range [msk->copied_seq, skb1->end_seq).

> +
>  		if (flags & MSG_PEEK) {
>  			/* skip already peeked skbs */
>  			if (total_data_len + data_len <=3D copied_total) {
> @@ -2233,11 +2230,9 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, s=
truct msghdr *msg,
> =20
>  		if (!(flags & MSG_PEEK)) {
>  			msk->bytes_consumed +=3D count;
> -			if (count < data_len) {
> -				MPTCP_SKB_CB(skb)->offset +=3D count;
> -				MPTCP_SKB_CB(skb)->map_seq +=3D count;
> +			msk->copied_seq +=3D count;
> +			if (count < data_len)
>  				break;
> -			}

[Severity: Medium]
Now that partial reads here and in __mptcp_read_sock() advance
msk->copied_seq instead of MPTCP_SKB_CB(skb)->map_seq (and overlapping skbs
no longer advance map_seq), doesn't mptcp_inq_hint() also need to be update=
d?

In net/mptcp/protocol.c:mptcp_inq_hint():

    skb =3D skb_peek(&sk->sk_receive_queue);
    if (skb) {
        u64 hint_val =3D READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_s=
eq;

Because MPTCP_SKB_CB(skb)->map_seq remains at the initial sequence number of
the head skb after a partial read or overlap, mptcp_inq_hint() will include
the already-consumed bytes (msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq)
when reporting unread bytes for SIOCINQ, TCP_CM_INQ, and
mptcp_rcv_space_adjust(). The commit message mentions using an
ack_seq - copied_seq hint, but mptcp_inq_hint() still subtracts
MPTCP_SKB_CB(skb)->map_seq.

[ ... ]

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 78e886b202585..5e553adb9397e 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -533,6 +533,19 @@ static void subflow_set_remote_key(struct mptcp_sock=
 *msk,
>  	WRITE_ONCE(msk->ack_seq, subflow->iasn);
>  	WRITE_ONCE(msk->can_ack, true);
>  	atomic64_set(&msk->rcv_wnd_sent, subflow->iasn);
> +	msk->copied_seq =3D subflow->iasn;
> +
> +	if (subflow->is_mptfo) {
> +		struct sock *sk =3D (struct sock *)msk;
> +		struct sk_buff *skb;
> +
> +		skb =3D skb_peek(&sk->sk_receive_queue);
> +		if (skb) {
> +			MPTCP_SKB_CB(skb)->map_seq =3D subflow->iasn - skb->len;
> +			MPTCP_SKB_CB(skb)->end_seq =3D subflow->iasn;
> +			msk->copied_seq -=3D skb->len;
> +		}
> +	}
>  }

[Severity: Critical]
Can this TFO synchronization in subflow_set_remote_key() race with a
concurrent reader on the msk socket and also lose partial read progress?

On a passive TFO connection, mptcp_fastopen_subflow_synack_set_params()
queues the TFO skb onto sk->sk_receive_queue with map_seq =3D -(u64)skb->len
and msk->copied_seq =3D -(u64)skb->len before the peer's 3rd ACK arrives.
When the 3rd ACK arrives in BH context, both callers of
subflow_set_remote_key():

    check_fully_established()
        mptcp_data_lock((struct sock *)msk);
        __mptcp_subflow_fully_established(msk, subflow, mp_opt);
            subflow_set_remote_key(msk, subflow, mp_opt);
        mptcp_data_unlock((struct sock *)msk);

and:

    mptcp_propagate_state()
        mptcp_data_lock(sk);
        if (mp_opt) {
            ...
            subflow_set_remote_key(msk, subflow, mp_opt);
        }

only hold mptcp_data_lock(sk) without checking sock_owned_by_user(sk).

1. Meanwhile, user-space can accept() the socket and call mptcp_recvmsg() ->
   __mptcp_recvmsg_mskq() or mptcp_read_sock() -> __mptcp_read_sock() ->
   mptcp_recv_skb() under lock_sock(sk) without holding mptcp_data_lock(sk).
   If mptcp_eat_recv_skb() unlinks and frees the TFO skb from
   sk->sk_receive_queue concurrently while subflow_set_remote_key() peeks
   sk->sk_receive_queue and writes to MPTCP_SKB_CB(skb)->map_seq and end_se=
q,
   can subflow_set_remote_key() trigger a use-after-free write on the freed
   skb, or overwrite msk->copied_seq with subflow->iasn - skb->len right
   before the consumed skb is unlinked?

2. Even without a concurrent race, if user-space partially reads count bytes
   (0 < count < skb->len) from the TFO skb and releases lock_sock(sk) before
   the 3rd ACK arrives, msk->copied_seq is advanced to
   -(u64)skb->len + count, while the TFO skb remains at the head of
   sk->sk_receive_queue with skb->len unchanged. When the 3rd ACK arrives,
   subflow_set_remote_key() sets msk->copied_seq =3D subflow->iasn - skb->l=
en,
   discarding the count bytes of progress so the next read re-copies the
   first count bytes to user-space and advances msk->bytes_consumed past
   msk->bytes_received.

The commit message notes that IASN synchronization is delegated to
mptcp_release_cb() and __mptcp_move_skb() to preserve partial TFO progress,
but that logic does not appear to be present in the patch.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793255126.gi=
t.tanggeliang@kylinos.cn?part=3D2
