Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794666558;
	b=HiKRIf/Z17n1Xx0RePJQoS/8NqTX+gZmyNXDWzs89wi77EYINMTm6BfHcivL++itnEk2
	 9V4VsgnIN19gT+w7FTj/cucT6+Vb+f+03v5T5RSz3K299rNkzH5bQBmaARXE0vrrulOKR
	 exx4HkAlQ6S4npXrtz7h3gndEOPnGA9mT0PwoUFEbdXILbR2l0wJniRo6dgJJQ8mxV+LW
	 qL/DtTL41Enk2c/U1aQSakPSfHoXGHArcu2WrJv9/cDihbNs8Q+WteyADKntrjHgUkQ3Q
	 vKHtyv//ckzTR1M5Mlf0kn9HiJEGmC449+5JxiYgE28tLfveWDSz4BPvalu44MJnDxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794666558;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3yZW2xv3gsDMkAHbS/ELVCLarCv8n/iwRaqUJAij6mw=;
	b=NU3F8oGsD0YSa5kV+6bNoH0zjQZyEXBdMvTDRwF6HCRspnWD3SI9Ci+MCUh0Yvl7zu+l
	 X5eKstDy6E1rkFt2eCguE/accI7QXOdLQ2CvtRfM1NHdTFugaO/70g2QO2Vt+mJfG2cDw
	 9lgUFGuOFHWXnLsnynuhv2zs2Dnfo93o097EqtuSR6t1E780RMLsylf3BvvfXxzozw85P
	 Eze7C4NHXcEPfaVDeOo+lwZQiYOs36uF9LFhmjUvb1bdLboj0mfgiwuVYeasnMQRuIOy3
	 xw9RenHIYW9CnD618vTIJ+Ck8iE+Z6ops8Ae55G6bzawrR1P+xaS4hsOUA8UrzC4X3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EE+IFeIL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F24A606A323
	for <mptcp@lists.linux.dev>; Sat, 14 Nov 2026 14:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EE+IFeIL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65231F000C4;
	Sat, 14 Nov 2026 14:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794666557;
	bh=3yZW2xv3gsDMkAHbS/ELVCLarCv8n/iwRaqUJAij6mw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=EE+IFeIL++UOReXr4UJxhYHRT5v81gbArvEQCw/xJVI0e1WK7ptWPTm12iY6c8eSV
	 Q0/GQM4wPja7S5hdhASwd9zR3w7azJRdId26I1s+SRmzI+vaKvEDOjFcv1ksjQajIf
	 bc29GopEOsFYbIh0W5SBTfNDZRTvm3fF5jDdWrYVmYqgdstta8BBckROkMse8ImHOj
	 HfUhOzRLnlCzUSABOw4zPIPcB2mnzo/4A4Kh2mA8OeVgENQYvYiTkn/FMAw2sEOKAM
	 2MFbn+0oFJsYpKVvig7RoQvu3HWicUsGjOsr4ylBSDLVqwfmZ5LIDTSPQUfd5kEkQz
	 BhhL9uLsvK0Lg==
Message-ID: <sashiko-outbox-214634@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v27 6/8] mptcp: remove CB offset field
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <879f04c4a89da0b3e8bcc7fd484744be5851f17e.1794663678.git.tanggeliang@kylinos.cn>
References: <cover.1794663678.git.tanggeliang@kylinos.cn>
 <879f04c4a89da0b3e8bcc7fd484744be5851f17e.1794663678.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 14:29:17 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] mptcp: raw map_seq used instead of mptcp_dsn() in
  mptcp_data_queue_ofo()
- [Medium] mptcp: raw map_seq and end_seq used in
  mptcp_prune_ofo_queue() and tracepoint
--

commit 9093e378164791c8e9a9ecffc602703ba0b1790e
Author: Paolo Abeni <pabeni@redhat.com>

mptcp: remove CB offset field

This commit removes the offset field from struct mptcp_skb_cb, tracking
consumed bytes via msk->copied_seq and encoding any subflow skb offset into
MPTCP_SKB_CB(skb)->map_seq alongside the mptcp_dsn() and mptcp_end_dsn()
helpers.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 41fc2429d2fed..f4ab3bdd368f2 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -362,8 +363,8 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *m=
sk, struct sk_buff *skb)
>  			p =3D &parent->rb_left;
>  			continue;
>  		}
> -		if (before64(seq, MPTCP_SKB_CB(skb1)->end_seq)) {
> -			if (!after64(end_seq, MPTCP_SKB_CB(skb1)->end_seq)) {
> +		if (before64(seq, mptcp_end_dsn(skb1))) {
> +			if (!after64(end_seq, mptcp_end_dsn(skb1))) {
>  				/* All the bits are present. Drop. */
>  				mptcp_drop(sk, skb);
>  				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);

[Severity: High]
Should the RB-tree traversal in mptcp_data_queue_ofo() compare seq against
mptcp_dsn(skb1) instead of MPTCP_SKB_CB(skb1)->map_seq?

net/mptcp/protocol.c:mptcp_data_queue_ofo() {
    ...
	while (*p) {
		parent =3D *p;
		skb1 =3D rb_to_skb(parent);
		if (before64(seq, MPTCP_SKB_CB(skb1)->map_seq)) {
			p =3D &parent->rb_left;
			continue;
		}
		if (before64(seq, mptcp_end_dsn(skb1))) {
			if (!after64(end_seq, mptcp_end_dsn(skb1))) {
				/* All the bits are present. Drop. */
				mptcp_drop(sk, skb);
				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
				return;
			}
			if (after64(seq, MPTCP_SKB_CB(skb1)->map_seq)) {
    ...
}

When mptcp_init_skb() initializes an skb with a non-zero subflow offset,
MPTCP_SKB_CB(skb1)->map_seq is set to mptcp_dsn(skb1) - offset.  If that skb
is queued in msk->out_of_order_queue and a subsequent out-of-order segment
arrives with seq in [mptcp_dsn(skb1) - offset, mptcp_dsn(skb1)), the
before64(seq, MPTCP_SKB_CB(skb1)->map_seq) check is false instead of moving=
 to
rb_left.  Any segment in that range with end_seq <=3D mptcp_end_dsn(skb1) (=
such
as the segment immediately preceding skb1) is then dropped as duplicate dat=
a,
or if end_seq > mptcp_end_dsn(skb1) it is inserted into the right subtree of
skb1 despite having a smaller DSN, stalling the receive queue when
__mptcp_ofo_queue() later stops at mptcp_dsn(skb1) > msk->ack_seq.

[ ... ]

> @@ -425,9 +426,10 @@ static void mptcp_init_skb(struct sock *ssk, struct =
sk_buff *skb, int offset,
>  	 * mptcp_subflow_get_mapped_dsn() is based on the current tp->copied_seq
>  	 * value
>  	 */
> -	MPTCP_SKB_CB(skb)->map_seq =3D mptcp_subflow_get_mapped_dsn(subflow);
> +	MPTCP_SKB_CB(skb)->map_seq =3D mptcp_subflow_get_mapped_dsn(subflow) -
> +				     offset;
>  	MPTCP_SKB_CB(skb)->end_seq =3D MPTCP_SKB_CB(skb)->map_seq + copy_len;
> -	MPTCP_SKB_CB(skb)->offset =3D offset;
> +	MPTCP_SKB_CB(skb)->flags =3D offset ? MPTCP_SKB_CB_F_OFFSET : 0;
>  	MPTCP_SKB_CB(skb)->has_rxtstamp =3D has_rxtstamp;

[Severity: Medium]
Now that map_seq and end_seq are shifted down by offset, should
mptcp_prune_ofo_queue() and trace_mptcp_rcvbuf_grow() also use mptcp_dsn() =
and
mptcp_end_dsn()?

net/mptcp/protocol.c:mptcp_prune_ofo_queue() {
    ...
		/* Stop pruning if the incoming skb would land in OoO tail. */
		if (after64(MPTCP_SKB_CB(in_skb)->map_seq,
			    MPTCP_SKB_CB(skb)->map_seq))
			break;
    ...
}

When either in_skb or the tail skb in msk->out_of_order_queue has a non-zero
offset, comparing raw map_seq values can stop pruning early (causing
__mptcp_move_skb() or mptcp_data_queue_ofo() to drop an earlier segment und=
er
memory pressure) or prune out-of-order segments whose actual DSN precedes
in_skb.  Similarly, the mptcp_rcvbuf_grow tracepoint in
include/trace/events/mptcp.h still computes ooo_space from
MPTCP_SKB_CB(msk->ooo_last_skb)->end_seq - msk->ack_seq instead of
mptcp_end_dsn(msk->ooo_last_skb) - msk->ack_seq.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794663678.gi=
t.tanggeliang@kylinos.cn?part=3D6
