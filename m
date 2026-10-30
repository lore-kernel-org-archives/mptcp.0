Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793328582;
	b=aPZeWLYHmqQsD+Hm2q4aFppEegO4jeBIbjIS2y8l1+asTJm9hSXB3FZTNUMZdu80/XWM
	 8wO0qLSvavM76zEbAsCII6SE6Km17BzzhJ52KaMxiCnY9M3mLdhbiySMK2ea25o7G8CBB
	 SsM3q/uQF5xEV/kOQzZeqkj19+bAa20ZdhEhJCYy2GSQdn2gWBVmcJvGzfucTCchdtKsQ
	 5KsmUskwjAnfmDozRq4sJwT8JFjVEF8lPMtGNZH2TDlEXocqwVmqRBu/ogw9c/P5kt9y9
	 DAXaYGB39kjyBZwSXGdfahM3UA8FzXfSbKJtgCVr1BwycGQ08+mtvxtRha5HIFJsPNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793328582;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=swjIFht0u/4NMKB2PelWpuiWM56PKVPgt9Ya2opU/8g=;
	b=3x5mJo6U1JpX6M3jkdo9rhcJqNlujerIUlc8kI7WU+MyG+BA6CGGbJGFRpl2kFsrgFXn
	 tOBmwWEBkrwxNR97x4gdSXBvDPCo01IrXNJIfK6B16MsAwSoBjZkEb7tQEZw0XZKK8VUY
	 ryXlJ01JiuByW7w+08lYfjKr/3hvS0242qJsNFWkWN1brQYYqKQJvRza1jPU7EC1jgKrZ
	 gkQ542Nqum/zdeeJmVmXZTO2e3QXaOLv2fVap9rofGsZ+cXSUGY+siLmazfXd3G4mkDej
	 rvpGByX6qKdRsfvtoW5gRrfcdEUrX0Ar14xBO/u1OKClXdnSarDmiUKnm24w/us2xsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SnC1HPXL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0E5606A31A
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 02:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SnC1HPXL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87651F000C1;
	Fri, 30 Oct 2026 02:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793328582;
	bh=swjIFht0u/4NMKB2PelWpuiWM56PKVPgt9Ya2opU/8g=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=SnC1HPXL5WUlccoe9f0poHA9WIdOlAmDZTIEXORIJn0cTffz5Uk95YWjRPMnYlLa2
	 QG8GshExwiejW6Lv8JY+NJBfVo3I4NNOb1IIRaLeYcvqA7MWHmBESz/AZLH8uzihny
	 dgmBd7tE7YBdmNEB0Hs/vZTmWCeXJ7gTeG/xN8oAPA/Y8zLNsrHVFuJPgGq3qLwPsm
	 vKPwWPngv6QRmX8rCtcS+WN/b+SM28cJw4ff2g/awAqqXA+oaenEyiXT4g/+TSQkRF
	 9Wpq/dZcDxZa4PNMJNeUqjN3xfv4Zv3lkWf3K8ZckZFOz7Fiz6il5M/pJ+Q5jf1v/1
	 DqozgBt011IvQ==
Message-ID: <sashiko-outbox-190183@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v17 3/4] mptcp: sync mptcp skb cb layout with
 tcp one
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <fe11356d3e5637de94fbe89540271d5f4ee381b4.1793326853.git.tanggeliang@kylinos.cn>
References: <cover.1793326853.git.tanggeliang@kylinos.cn>
 <fe11356d3e5637de94fbe89540271d5f4ee381b4.1793326853.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 02:49:41 +0000
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
- [Critical] mptcp: TFO skb UAF race and un-rebased copied_seq in subflow_s=
et_remote_key()
- [Critical] mptcp: subtracting offset from map_seq64 in mptcp_init_skb() c=
orrupts OFO data
- [High] mptcp: 64-bit vs 32-bit seq check in __mptcp_recvmsg_mskq() breaks=
 MSG_PEEK
--

commit 62db3c701d55a6fd52b9c1e97a8f06064e99fb14
Author: Paolo Abeni <pabeni@redhat.com>

mptcp: sync mptcp skb cb layout with tcp one

This commit aligns the MPTCP SKB control buffer layout with TCP by narrowing
MPTCP_SKB_CB(skb)->map_seq and end_seq to 32-bit fields while keeping the
full 64-bit sequence number in map_seq64. It updates the receive and
out-of-order queue paths to use 32-bit sequence comparisons after validating
incoming packets against the receive window.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index f3b1b6b282a2e..8447efa9dee6e 100644
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
Can subtracting offset from map_seq64 in mptcp_init_skb() corrupt stream da=
ta
when the subflow SKB has a non-zero offset and carries an out-of-order MPTCP
Data Sequence Mapping?

In __mptcp_move_skbs_from_subflow(), offset =3D tp->copied_seq -
TCP_SKB_CB(skb)->seq represents already-consumed or discarded subflow bytes=
 at
the front of skb, while mptcp_subflow_get_mapped_dsn(subflow) is the DSN for
the byte starting at offset.

When the mapping is in sequence (mapped_dsn =3D=3D msk->ack_seq =3D=3D
msk->copied_seq), subtracting offset from map_seq64 works because
__mptcp_recvmsg_mskq() later computes offset =3D (u32)msk->copied_seq -
MPTCP_SKB_CB(skb)->map_seq and skips the first offset bytes.

However, if offset > 0 and mapped_dsn > msk->ack_seq (out-of-order MPTCP
data), subtracting offset shifts map_seq64 and map_seq backwards into the
unreceived sequence range [mapped_dsn - offset, mapped_dsn):

1. In __mptcp_move_skb(), if mapped_dsn - offset <=3D msk->ack_seq < mapped=
_dsn,
   the packet takes the in-sequence or partial-packet branch instead of
   mptcp_data_queue_ofo(), advancing msk->ack_seq and exposing the stale
   subflow prefix [0, offset) to user-space.

2. If mapped_dsn - offset > msk->ack_seq, mptcp_data_queue_ofo() inserts skb
   into out_of_order_queue claiming coverage of [mapped_dsn - offset,
   mapped_dsn + skb->len - offset), which causes legitimate segments for
   [mapped_dsn - offset, mapped_dsn) to be dropped as duplicate data and
   causes __mptcp_ofo_queue() to dequeue skb as soon as msk->ack_seq reaches
   mapped_dsn - offset.

[ ... ]

> @@ -2192,7 +2199,7 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, st=
ruct msghdr *msg,
>  		int err;
> =20
>  		if (msk->copied_seq >=3D MPTCP_SKB_CB(skb)->map_seq)
> -			offset =3D msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
> +			offset =3D (u32)msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
> =20
>  		/* Skip skbs that are entirely before copied_seq */
>  		if (offset >=3D skb->len) {

[Severity: High]
Does comparing the 64-bit msk->copied_seq against the 32-bit
MPTCP_SKB_CB(skb)->map_seq in __mptcp_recvmsg_mskq() break MSG_PEEK across
multiple SKBs and across 32-bit sequence wrap-around?

With struct mptcp_skb_cb narrowing map_seq to u32 while msk->copied_seq
remains u64, the condition:

	if (msk->copied_seq >=3D MPTCP_SKB_CB(skb)->map_seq)
		offset =3D (u32)msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;

zero-extends MPTCP_SKB_CB(skb)->map_seq to u64. Whenever the upper 32 bits =
of
msk->copied_seq are non-zero (which is typical since subflow->iasn is deriv=
ed
from a 64-bit SHA-256 hash, or during TFO when msk->copied_seq is initializ=
ed
to -(u64)skb->len), msk->copied_seq >=3D MPTCP_SKB_CB(skb)->map_seq is
unconditionally true.

When recvmsg() is called with MSG_PEEK and sk->sk_receive_queue contains two
or more SKBs, msk->copied_seq is not updated after peeking the first SKB. On
the second SKB (where map_seq64 > msk->copied_seq), the condition still
evaluates to true, so offset =3D (u32)msk->copied_seq -
MPTCP_SKB_CB(skb)->map_seq underflows in 32-bit unsigned arithmetic to a hu=
ge
value (>=3D 2^31 > skb->len). That hits:

	if (offset >=3D skb->len) {
		*last =3D skb;
		continue;
	}

skipping all subsequent SKBs in sk->sk_receive_queue (and hanging in
sk_wait_data() when MSG_PEEK | MSG_WAITALL or SO_RCVLOWAT spans multiple
SKBs).

Conversely, if the upper 32 bits of msk->copied_seq are zero and an SKB
straddles a 32-bit wrap boundary (for example, map_seq =3D 0xfffffff0 and
copied_seq wraps to 0x10 after a partial read), 0x10ULL >=3D 0xfffffff0ULL
evaluates to false, leaving offset =3D 0 and re-reading already-consumed by=
tes.
Should this check compare against MPTCP_SKB_CB(skb)->map_seq64 (or use
!before((u32)msk->copied_seq, MPTCP_SKB_CB(skb)->map_seq))?

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 6a66841ca24ae..5a8d837e55d04 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -542,7 +542,8 @@ static void subflow_set_remote_key(struct mptcp_sock =
*msk,
>  		if (skb) {
>  			u64 tfo_map_seq =3D subflow->iasn - skb->len;
> =20
> -			WRITE_ONCE(MPTCP_SKB_CB(skb)->map_seq, tfo_map_seq);
> +			WRITE_ONCE(MPTCP_SKB_CB(skb)->map_seq, (u32)tfo_map_seq);
> +			WRITE_ONCE(MPTCP_SKB_CB(skb)->map_seq64, tfo_map_seq);
>  			WRITE_ONCE(MPTCP_SKB_CB(skb)->end_seq, subflow->iasn);
> =20
>  			if (READ_ONCE(msk->copied_seq) !=3D -(u64)skb->len)

[Severity: Critical]
What happens in subflow_set_remote_key() on a passive TFO socket if user-sp=
ace
partially or concurrently reads the TFO SKB before the 3rd ACK arrives?

In mptcp_fastopen_subflow_synack_set_params(), the TFO SKB is queued onto
sk->sk_receive_queue with map_seq64 =3D -(u64)skb->len and msk->copied_seq =
=3D
-(u64)skb->len. There appear to be two issues when the 3rd ACK arrives in
check_fully_established() -> __mptcp_subflow_fully_established() ->
subflow_set_remote_key():

1. If user-space accepts the socket and partially reads N bytes (0 < N <
   skb->len) before the 3rd ACK arrives, msk->copied_seq advances to
   -(u64)skb->len + N while the SKB remains at the head of
   sk->sk_receive_queue. When subflow_set_remote_key() runs:

	if (READ_ONCE(msk->copied_seq) !=3D -(u64)skb->len)
		return;

   it updates the SKB's map_seq, map_seq64, and end_seq to the subflow->iasn
   sequence space, but returns early without rebasing msk->copied_seq by
   +subflow->iasn (to tfo_map_seq + N). That leaves msk->copied_seq in the
   initial 0-based sequence space while map_seq and msk->ack_seq are in the
   subflow->iasn space, corrupting offset =3D (u32)msk->copied_seq -
   MPTCP_SKB_CB(skb)->map_seq on subsequent reads.

2. In BH context, check_fully_established() only acquires
   mptcp_data_lock(msk):

	mptcp_data_lock((struct sock *)msk);
	__mptcp_subflow_fully_established(msk, subflow, mp_opt);
	mptcp_data_unlock((struct sock *)msk);

   Meanwhile, a concurrent reader in __mptcp_recvmsg_mskq() or
   mptcp_recv_skb() holds lock_sock(sk) (with sk_lock.slock released) and
   calls mptcp_eat_recv_skb(), which unlinks and frees the SKB from
   sk->sk_receive_queue without holding mptcp_data_lock(sk):

	__skb_unlink(skb, &sk->sk_receive_queue);
	skb_attempt_defer_free(skb);

   Can subflow_set_remote_key() race with mptcp_eat_recv_skb() and trigger a
   use-after-free when peeking sk->sk_receive_queue and writing to
   MPTCP_SKB_CB(skb)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793326853.gi=
t.tanggeliang@kylinos.cn?part=3D3
