Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793967133;
	b=HABCVwfDdEEwcnkNz9lTNoGd+BG5vlyloysNi8KgfxripUaDIDB00/iEN/nhvbP5A/wP
	 i7yadlVJEfV5mJizb/o96P+EFa36RHWppijzIvJ0bDibFxgnuINiYvlVHdJAj5ukt8luH
	 qdFVv/tUYdb5Zzd/f4iru/9lfSPShg26+daYtxAuLp8nyQDI/rXs/73B8pJhKos4qOBAt
	 j5NLiYg4+VJE0zpr8W8HNTW8vIFU7Rv6l6oKx1IUZ2GxUEiDEkGraV7qGUPaEOb/wBWes
	 F+7R/owlf17o/GuP5kuKyJhuqqFZ5ZJf9FEtw63ZiBfFjfh0uV8eQ7g62cKUshBtBRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793967133;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yQB2QKbzG6ps3fgKb4IUAFEmsNCXi+LQs7+Q/69RZuA=;
	b=B12ek3DIBDJLSpgZGCHcbB44zEsvbK1VYhHr5LBSOPCwgXKh7K6k6TqOWLvEptSgc8OP
	 9MlQ3OZNwZEzAZSqoMrG8g7jo6VNaJpiS4t1kVXvyntwQ/hGzlwcfwUDh2wonAkGaH210
	 CXcFXKanLMfuOit7zFP9f6JORiTjbVz1OX/NTqWHuJELb0XyIgEraLd57RHz3M+Ck8mqi
	 UYvK5Ry4Ud391IC9xJHJ+xGwuRbkchZsgI/7+Rb1FY+fY2R47eFse/wXQ2zY//IF8/wtn
	 6hxClVBodOrEezqmw47eWdgi3fs/1bgi7K/0k0cB3H8h3kGxgxxvbJSBXUT7xupOs3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=STPe7xLe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8AD606A330
	for <mptcp@lists.linux.dev>; Fri,  6 Nov 2026 12:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=STPe7xLe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE2CE1F008A2;
	Fri,  6 Nov 2026 12:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793967132;
	bh=yQB2QKbzG6ps3fgKb4IUAFEmsNCXi+LQs7+Q/69RZuA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=STPe7xLeMQdfELcJQGGaSzAAejb10gAYToVrKV7BNnCXBcsOEWhGZtm1yDc9rUsxL
	 6lM96/R4nagCUDHekBvWnGjk/5u0V1dW+0qI/AS67zzYvq/ss3iyey9h40eVo2vITI
	 e7qlowXPFGLnPRA6MkdIybSZRannvRcnWdSN6qKwBA7ohbDUAvL33tG+rRPzwX9B+Q
	 z8fyaFjFis2Oz8Ye2JZ9lbNVYZhYuQYeBb0+FkyjzqwHi0MJXkoUoCJgrIR+3MHf4z
	 jlk63zQ8a0n4rHMUJjBlI6+GAhUwU6dmI0nMoQkr9BKA12odG3zZCZU1UNmRD6+qt3
	 9S2EyPg0BbGnw==
Message-ID: <sashiko-outbox-201391@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v22 6/8] mptcp: remove CB offset field
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <7c1d46fbe47ef7510fa106d0920580d64baa7187.1793964796.git.tanggeliang@kylinos.cn>
References: <cover.1793964796.git.tanggeliang@kylinos.cn>
 <7c1d46fbe47ef7510fa106d0920580d64baa7187.1793964796.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 12:12:12 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] mptcp: broken skb pull and error path in mptcp_init_skb() and
  caller
--

commit 37ab52009b6bb1043a1c621a00f409a14fa73507
Author: Paolo Abeni <pabeni@redhat.com>

mptcp: remove CB offset field

This commit replaces the per-skb MPTCP control buffer offset field with an
msk-level copied_seq counter and pulls already-consumed prefix bytes when an
skb spans a DSS mapping boundary in mptcp_init_skb().

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 74a94264111dc..cedc91accc6b4 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
[ ... ]
> @@ -415,25 +414,38 @@ static void mptcp_data_queue_ofo(struct mptcp_sock =
*msk, struct sk_buff *skb)
>  	skb_set_owner_r(skb, sk);
>  }
> =20
> -static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int of=
fset,
> -			   int copy_len)
> +static bool mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int of=
fset)
>  {
>  	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
>  	bool has_rxtstamp =3D TCP_SKB_CB(skb)->has_rxtstamp;
> =20
> +	/* Detect mapping boundary: skb spans multiple mappings */
> +	if (unlikely(offset > 0 &&
> +		     before(TCP_SKB_CB(skb)->seq - subflow->ssn_offset,
> +			    subflow->map_subflow_seq))) {
> +		if (offset >=3D skb->len || !pskb_pull(skb, offset)) {
> +			WARN_ON_ONCE(1);
> +			sk_eat_skb(ssk, skb);
> +			return false;
> +		}
> +		offset =3D 0;
> +	}
> +
>  	/* the skb map_seq accounts for the skb offset:
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
> =20
>  	skb_ext_reset(skb);
>  	skb_dst_drop(skb);
> +
> +	return true;
>  }
[ ... ]
> @@ -855,7 +863,8 @@ static bool __mptcp_move_skbs_from_subflow(struct mpt=
cp_sock *msk,
>  		if (offset < skb->len) {
>  			size_t len =3D skb->len - offset;
> =20
> -			mptcp_init_skb(ssk, skb, offset, len);
> +			if (!mptcp_init_skb(ssk, skb, offset))
> +				continue;
> =20
>  			if (own_msk) {
>  				mptcp_subflow_lend_fwdmem(subflow, skb);

[Severity: High]
Does jumping via continue when mptcp_init_skb() returns false evaluate an
uninitialized more_data_avail variable and corrupt tp->copied_seq?

In __mptcp_move_skbs_from_subflow(), more_data_avail is declared without an
initializer and is only assigned at the end of the do-while body:

net/mptcp/protocol.c:__mptcp_move_skbs_from_subflow() {
	...
	bool more_data_avail;
	...
	do {
		...
		if (offset < skb->len) {
			size_t len =3D skb->len - offset;

			if (!mptcp_init_skb(ssk, skb, offset))
				continue;
			...
			seq +=3D len;
			...
		}
		...
		WRITE_ONCE(tp->copied_seq, seq);
		more_data_avail =3D mptcp_subflow_data_available(ssk);

	} while (more_data_avail);
}

When pskb_pull() fails in mptcp_init_skb() (for example, when
__pskb_pull_tail() -> pskb_expand_head(..., GFP_ATOMIC) fails under memory
pressure on a nonlinear or cloned skb), mptcp_init_skb() triggers a
WARN_ON_ONCE(1), calls sk_eat_skb(ssk, skb), and returns false.  On the fir=
st
loop iteration, continue jumps straight to while (more_data_avail) and reads
more_data_avail uninitialized.  Because sk_eat_skb() already removed the skb
while continue skips updating tp->copied_seq and calling
mptcp_subflow_data_available(ssk), a subsequent iteration will compute a
wrapped offset =3D seq - TCP_SKB_CB(skb)->seq >=3D skb->len on the next skb,
eat it, and trigger a false mptcp_dss_corruption() reset.

In addition, when pskb_pull(skb, offset) succeeds on a nonlinear skb by
expanding its head via pskb_expand_head() and pulling all skb_headlen(skb)
bytes, skb_end_offset(skb) grows without updating skb->truesize while skb->=
sk
is still ssk.  If that skb is later coalesced as the from skb in
mptcp_try_coalesce() -> skb_try_coalesce(), delta =3D from->truesize -
SKB_TRUESIZE(skb_end_offset(from)) can become smaller than from->len (or
negative), firing WARN_ON_ONCE(delta < len) and corrupting to->truesize and
sk->sk_rmem_alloc.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793964796.gi=
t.tanggeliang@kylinos.cn?part=3D6
