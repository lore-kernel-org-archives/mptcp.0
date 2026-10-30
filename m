Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793328983;
	b=I/0tu7AdflZCiKfs2HDtDXHWWveJnmd9oNAPZAkvGuriJAJP0crsUB5cErIWx4ZHDtOr
	 DHytFqL5GEdHU88+ku/O4kPWrKrHPqFnzq9wS77+0S9d1dcGgwOpw1BJn0WQm43WgXu7/
	 qTZ2AiPlUOtiDAII5rtx6blt1annpKPdMDgvq33JVqA99GTFFiGoVA2ZqsMXD/5DIb9QA
	 T32bmPej2ypWqrO6M3j135VKIZnq3SkL048U5P9uOPKoEVzkClsaa5uaBEfNLRl3OxSXU
	 ZQq1lmmLQOPPkgEzNSqQKww8CnIMLYL+BC69JQSvpvJo1h/o310kZwg1RvDO5Jt37Lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793328983;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rw+fHIYCpE4HuyYEiSF2H8Gjlhu4ddXKkwRkX5XTmzE=;
	b=QxJ8NxZkV5FtF6QgXCpq7BhkQSH2EWPLW6F2DAxAuL2+rOu8cTs6Vo1lS+yuKI1GAYxX
	 QV0qeNNZp9h3YUQEPXU3KBNz42H7KUj4lYBaNyEgyp9zHBagB763EDTXpZ4QTm/3LHYCQ
	 pTZeQyGvQ+YkzibP5C2buv0BJhXJZPnW8uNYO2w65til1wThuGSFWs7szN4kXJpKUWQ+T
	 diuc01TCLKdLAQ1ecB5vPOCK/5O9q/Uou68d7mnNgaJ37uch2hKySmEzxhfcrI97MaubA
	 1u0wfqDwz0HVD0/Ao1G5A9NwxU3MdToGUMixZeH+abtaK1vmVMdzCSyf9ZPCdlioW1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mguSX/Ks";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC95B606A31C
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 02:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mguSX/Ks
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770FC1F000C1;
	Fri, 30 Oct 2026 02:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793328982;
	bh=rw+fHIYCpE4HuyYEiSF2H8Gjlhu4ddXKkwRkX5XTmzE=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=mguSX/Ks5gvEiXEqPdIC//taCm1IjTSCTs1WzgolqBcrCzKhGmZB3ygf2gd82JsfX
	 5Jir4937hiIOppcKJDdCmjB2LESIbXU2H4enMeWWQ84ZtpxaNbdPseXPSOK0R2qssm
	 u5aKbqq4LYPgST8/W9W8s3lSU82OCbfoAv3kfkIOPhrQA3znTRtsOwR04ctiFs2PsC
	 OX8fdDyL32pd2wk+djzPA5WPNNUJRjLhYuksF55R0A/uq/WrGU+NnqTH5UUQi2qMo0
	 4i7w0lQq226Rz7cZM1lTNXGHOa3D1OZy+1tSy3XzM3MzHv9Erz8lyYzSFR5VeoOCVU
	 hfmBl7p8fL5Cw==
Message-ID: <sashiko-outbox-190185@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v17 2/4] mptcp: remove CB offset field
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <9a98772b14e535454de5bafbf113aa72a3ee6f44.1793326853.git.tanggeliang@kylinos.cn>
References: <cover.1793326853.git.tanggeliang@kylinos.cn>
 <9a98772b14e535454de5bafbf113aa72a3ee6f44.1793326853.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 02:56:21 +0000
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
- [Critical] mptcp: race and UAF in subflow_set_remote_key() with concurren=
t readers
- [High] mptcp: fix partial TFO read sequence tracking in subflow_set_remot=
e_key()
- [High] mptcp: fix MSG_PEEK overlap and wraparound in __mptcp_recvmsg_mskq=
()
- [High] mptcp: mptcp_init_skb() corrupts stream when skb has positive subf=
low offset
--

commit a818e739b6c749d445de127d77fbde3c037d69af
Author: Paolo Abeni <pabeni@redhat.com>

mptcp: remove CB offset field

This patch replaces the per-skb offset field in mptcp_skb_cb with a
socket-level copied_seq field in struct mptcp_sock to track consumed bytes =
in
the MPTCP receive queue. It updates TFO sequence initialization, skb mapping
setup, receive queue consumption, and SIOCINQ hint calculation to compute
offsets relative to msk->copied_seq.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 528a72da646cc..f3b1b6b282a2e 100644
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

[Severity: High]
Can subtracting offset from mptcp_subflow_get_mapped_dsn(subflow) in
mptcp_init_skb(), combined with removing the MPTCP_SKB_CB(from)->offset che=
ck
in __mptcp_try_coalesce(), corrupt the receive stream when an skb on
ssk->sk_receive_queue has a positive subflow offset?

An skb in __mptcp_move_skbs_from_subflow() has offset =3D tp->copied_seq -
TCP_SKB_CB(skb)->seq > 0 when its leading bytes were already consumed or
discarded (for example, via subflow_check_data_avail() ->
mptcp_subflow_discard_data() when an skb spans two DSS mappings and the fir=
st
mapping was already received on another subflow, or when a partially
overlapping TCP segment crosses a DSS boundary). In that situation, only
skb->data[offset..skb->len) belongs to the current mapping starting at
mapped_dsn =3D mptcp_subflow_get_mapped_dsn(subflow), while skb->data[0..of=
fset)
does not belong to [mapped_dsn - offset, mapped_dsn).

By setting MPTCP_SKB_CB(skb)->map_seq =3D mapped_dsn - offset, when the new
mapping is out of order (mapped_dsn > msk->ack_seq):

1. If mapped_dsn - offset <=3D msk->ack_seq < mapped_dsn, __mptcp_move_skb()
treats the out-of-order skb as in-sequence or partially overlapping
msk->ack_seq, advances msk->ack_seq across the unreceived hole
[msk->ack_seq, mapped_dsn), and if mapped_dsn - offset =3D=3D tail->end_seq,
__mptcp_try_coalesce() -> skb_try_coalesce() appends skb->data starting at
byte 0 onto the receive queue tail. The discarded prefix bytes in
skb->data[0..offset) are then delivered to user-space in place of the missi=
ng
DSN range, and the genuine data for [msk->ack_seq, mapped_dsn) is later
dropped as MPTCP_MIB_DUPDATA.

2. If mapped_dsn - offset > msk->ack_seq, mptcp_data_queue_ofo() inserts or
coalesces the skb in msk->out_of_order_queue under the fabricated range
[mapped_dsn - offset, end_seq), where it can overwrite or cause drops of
legitimate segments covering [mapped_dsn - offset, mapped_dsn) and later
deliver skb->data[0..offset) to user-space once msk->ack_seq reaches
mapped_dsn - offset.

[ ... ]

> @@ -472,10 +470,6 @@ static bool __mptcp_move_skb(struct sock *sk, struct=
 sk_buff *skb)
>  	/* Partial packet */
>  	if (after64(MPTCP_SKB_CB(skb)->end_seq, msk->ack_seq)) {
>  		copy_len =3D MPTCP_SKB_CB(skb)->end_seq - msk->ack_seq;
> -		MPTCP_SKB_CB(skb)->offset +=3D msk->ack_seq -
> -					     MPTCP_SKB_CB(skb)->map_seq;
> -		MPTCP_SKB_CB(skb)->map_seq +=3D msk->ack_seq -
> -					      MPTCP_SKB_CB(skb)->map_seq;
>  		goto insert;
>  	}

[ ... ]

> @@ -896,12 +890,9 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
>  		if (!tail || !mptcp_try_coalesce(sk, tail, skb)) {
>  			int delta =3D msk->ack_seq - MPTCP_SKB_CB(skb)->map_seq;
> =20
> -			/* skip overlapping data, if any */
>  			pr_debug("uncoalesced seq=3D%llx ack seq=3D%llx delta=3D%d\n",
>  				 MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq,
>  				 delta);
> -			MPTCP_SKB_CB(skb)->offset +=3D delta;
> -			MPTCP_SKB_CB(skb)->map_seq +=3D delta;
>  			__skb_queue_tail(&sk->sk_receive_queue, skb);
>  		}
>  		msk->bytes_received +=3D end_seq - msk->ack_seq;
> @@ -2195,11 +2186,22 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, =
struct msghdr *msg,
>  	int copied =3D 0;
> =20
>  	skb_queue_walk_safe(&sk->sk_receive_queue, skb, tmp) {
> -		u32 delta, offset =3D MPTCP_SKB_CB(skb)->offset;
> -		u32 data_len =3D skb->len - offset;
> +		u32 delta, offset =3D 0;
> +		u32 data_len;
>  		u32 count;
>  		int err;
> =20
> +		if (msk->copied_seq >=3D MPTCP_SKB_CB(skb)->map_seq)
> +			offset =3D msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
> +
> +		/* Skip skbs that are entirely before copied_seq */
> +		if (offset >=3D skb->len) {
> +			*last =3D skb;
> +			continue;
> +		}
> +
> +		data_len =3D skb->len - offset;

[Severity: High]
Does __mptcp_recvmsg_mskq() return duplicate or skipped data during MSG_PEEK
when sk->sk_receive_queue contains partially overlapping skbs or when seque=
nce
numbers wrap across zero?

Because __mptcp_move_skb() and __mptcp_ofo_queue() no longer advance
MPTCP_SKB_CB(skb)->map_seq to msk->ack_seq when queuing a partially
overlapping skb (and mptcp_init_skb() subtracts the subflow offset from
map_seq), a second skb (skb2) in sk->sk_receive_queue can have
MPTCP_SKB_CB(skb2)->map_seq < MPTCP_SKB_CB(skb1)->end_seq.

During a normal read, consuming skb1 advances msk->copied_seq to
MPTCP_SKB_CB(skb1)->end_seq, so the next iteration computes offset =3D
msk->copied_seq - MPTCP_SKB_CB(skb2)->map_seq and skips the overlapping pre=
fix
of skb2. Under MSG_PEEK, however, msk->copied_seq is not advanced as skb1 is
peeked. When the loop moves to skb2, it still compares against the unadvanc=
ed
msk->copied_seq rather than the sequence position reached after skb1, leavi=
ng
offset at 0 (or smaller than skb1->end_seq - skb2->map_seq) and copying the
overlapping prefix of skb2 into the user buffer a second time.

In addition, comparing msk->copied_seq >=3D MPTCP_SKB_CB(skb)->map_seq with=
 raw
unsigned u64 arithmetic instead of !before64(msk->copied_seq,
MPTCP_SKB_CB(skb)->map_seq) breaks when sequence numbers cross 0 (for examp=
le,
on a passive TFO socket that falls back before the MPC ACK, where the TFO s=
kb
has map_seq =3D -(u64)skb1->len and msk->copied_seq =3D -(u64)skb1->len whi=
le the
next fallback skb has map_seq =3D 0, causing msk->copied_seq >=3D map_seq to
evaluate true and skip skb2 with a wrapped offset).

[ ... ]

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 78e886b202585..6a66841ca24ae 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -533,6 +533,26 @@ static void subflow_set_remote_key(struct mptcp_sock=
 *msk,
>  	WRITE_ONCE(msk->ack_seq, subflow->iasn);
>  	WRITE_ONCE(msk->can_ack, true);
>  	atomic64_set(&msk->rcv_wnd_sent, subflow->iasn);
> +
> +	if (subflow->is_mptfo) {
> +		struct sock *sk =3D (struct sock *)msk;
> +		struct sk_buff *skb;
> +
> +		skb =3D skb_peek(&sk->sk_receive_queue);
> +		if (skb) {
> +			u64 tfo_map_seq =3D subflow->iasn - skb->len;
> +
> +			WRITE_ONCE(MPTCP_SKB_CB(skb)->map_seq, tfo_map_seq);
> +			WRITE_ONCE(MPTCP_SKB_CB(skb)->end_seq, subflow->iasn);
> +
> +			if (READ_ONCE(msk->copied_seq) !=3D -(u64)skb->len)
> +				return;
> +
> +			WRITE_ONCE(msk->copied_seq, tfo_map_seq);
> +			return;
> +		}
> +	}
> +	WRITE_ONCE(msk->copied_seq, subflow->iasn);
>  }

[Severity: High]
What happens in subflow_set_remote_key() if user-space partially reads the =
TFO
skb before the 3rd ACK arrives?

In mptcp_fastopen_subflow_synack_set_params(), both MPTCP_SKB_CB(skb)->map_=
seq
and msk->copied_seq are initialized to -(u64)skb->len. If user-space accepts
the passive TFO socket and reads count bytes (0 < count < skb->len) via
__mptcp_recvmsg_mskq() or __mptcp_read_sock() before the peer's MP_CAPABLE =
ACK
is processed, msk->copied_seq is advanced to -(u64)skb->len + count while t=
he
partially consumed skb remains at the head of sk->sk_receive_queue.

When the 3rd ACK arrives, subflow_set_remote_key() updates
MPTCP_SKB_CB(skb)->map_seq to tfo_map_seq (subflow->iasn - skb->len) and
MPTCP_SKB_CB(skb)->end_seq to subflow->iasn, but then sees
READ_ONCE(msk->copied_seq) !=3D -(u64)skb->len and returns early without
shifting msk->copied_seq by subflow->iasn (to tfo_map_seq + count).

Doesn't leaving msk->copied_seq at -(u64)skb->len + count while map_seq and
msk->ack_seq are in the subflow->iasn sequence space corrupt subsequent off=
set
calculations in __mptcp_recvmsg_mskq(), cause mptcp_recv_skb() to eat and d=
rop
unread skbs via mptcp_eat_recv_skb(), and cause mptcp_inq_hint() to return
INT_MAX?

[Severity: Critical]
Additionally, can subflow_set_remote_key() race with concurrent user-space
readers in __mptcp_recvmsg_mskq() and __mptcp_read_sock() -> mptcp_recv_skb=
()
and trigger a use-after-free on skb or clobber msk->copied_seq?

When the 3rd ACK arrives in BH context, check_fully_established() calls
__mptcp_subflow_fully_established() -> subflow_set_remote_key() while holdi=
ng
only mptcp_data_lock(sk) (sk->sk_lock.slock), without checking
sock_owned_by_user(sk):

net/mptcp/options.c:check_fully_established() {
    ...
    mptcp_data_lock((struct sock *)msk);
    __mptcp_subflow_fully_established(msk, subflow, mp_opt);
    mptcp_data_unlock((struct sock *)msk);
}

Meanwhile, __mptcp_recvmsg_mskq() and mptcp_recv_skb() / __mptcp_read_sock()
run under lock_sock(sk) without holding mptcp_data_lock(sk) while peeking
sk->sk_receive_queue, reading MPTCP_SKB_CB(skb)->map_seq and msk->copied_se=
q,
updating msk->copied_seq +=3D count, and unlinking and freeing the skb in
mptcp_eat_recv_skb(sk, skb):

1. If mptcp_eat_recv_skb() unlinks and frees the TFO skb right after
subflow_set_remote_key() executes skb =3D skb_peek(&sk->sk_receive_queue),
subflow_set_remote_key() will read skb->len and write
MPTCP_SKB_CB(skb)->map_seq and MPTCP_SKB_CB(skb)->end_seq on a freed sk_buf=
f.

2. Both __mptcp_recvmsg_mskq() and __mptcp_read_sock() update
msk->copied_seq +=3D count before calling mptcp_eat_recv_skb(sk, skb). If a=
 full
read of the TFO skb advances msk->copied_seq to 0 and subflow_set_remote_ke=
y()
runs before mptcp_eat_recv_skb() unlinks skb, skb_peek(&sk->sk_receive_queu=
e)
still returns skb, and READ_ONCE(msk->copied_seq) !=3D -(u64)skb->len sees =
0 and
returns early without setting msk->copied_seq =3D subflow->iasn.

3. Because subflow_set_remote_key() writes MPTCP_SKB_CB(skb)->map_seq before
updating msk->copied_seq, a concurrent reader in __mptcp_recvmsg_mskq() or
mptcp_recv_skb() can observe the updated map_seq (subflow->iasn - skb->len)
together with the old msk->copied_seq (-(u64)skb->len), or race its non-ato=
mic
msk->copied_seq +=3D count update against WRITE_ONCE(msk->copied_seq, ...).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793326853.gi=
t.tanggeliang@kylinos.cn?part=3D2
