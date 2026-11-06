Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793966674;
	b=gsmd0FujAUHNcE/Mze+y6WxfL4Qz9+TWENLpnzz62cCbH0Rvc4IhCpfQ1Z9ao+gZcTh8
	 mj44ZqngM/+lImRnZgLS6JxWUSdnoevrovi4TwF4PlBbm7T+faDvNZi+iBUhdMsTg3SFh
	 COs7dYpAeJWOGCME/LFYfeijLwH7EB43pKr8aQUE9WgJSrEhATmf8oZ/T46sBZD/+1v3g
	 ZUnAzS7Zf2D6ABnRCbD7q7Gld/7g2D31S/PtrhM4keHph2zhfBfmQJSou8J9KokYQc5L1
	 F+/dMvBoZ4VjC6qdIm0iz7J+j5RPkPHNcJgYOTllQcOrEE4OwaY5/tQ+8hCddm2I7qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793966674;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YAAik/xSIO5xjqlshiQc1RncV5d2tdZQfW9c7Hs3kwI=;
	b=URh4gMXEbwxWim0WEst54y2mp5LE02vAh5APxThSehwAlVIR04mLB3Ea2ttNsR26VnG8
	 c02R8tCyr0igfjgv+j0J19IdrU2OphvQ9g0La8UatB9rSLHQiJZkHx+aVNJmzLwkUzSwI
	 N3YuvvlIRiBgxKMB2e/q9tqVzs6+LvMnDyoPkDKNt90eHcDv3UYuwa9W0c3irtiOEi/KK
	 aR1/C51dAbQCqVPdCkima4GFen36X2jL+QtNgti/VHIvUsEvuA/0TKt3ZMBiFePTpXEos
	 xYCWKTYS1peASi+5uWEIzeBC871I6DRO6xnAmHxxVpH9iWmTQonKwDADBCwWwKjwKXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=REwvpqmu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84248606A32E
	for <mptcp@lists.linux.dev>; Fri,  6 Nov 2026 12:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=REwvpqmu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15941F008A1;
	Fri,  6 Nov 2026 12:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793966674;
	bh=YAAik/xSIO5xjqlshiQc1RncV5d2tdZQfW9c7Hs3kwI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=REwvpqmuBzsyD6rOLiNZyKc/gGftdbE9Qo59xC3KrLTqXdLFRPnmEETNux4iQY97/
	 UOOTbKoofdcomEQ1/E0ZwkI+lg4lplePgoxg5qwSjf0tsJTl3NeEKM7a/MFZDLgBYk
	 HrihMokFTRAVuTe1bCnUqxyAPaqRYOu3/vW63I4+IDo/wzqJZvAUoCcbBG4E8R2kVd
	 Tg3Ua0GSt3VLFGKF4eTrTMCQiIo1RnsfYh25QaGWDFU6Ya9DM+0O2/pKeli9fj7Vtq
	 dxtyRsTCUzGYyWhFhFzne0hEpsqDIAG4cA4X72huW0E2pIGpd4gfSfUBZp51IXNK9u
	 llo1K889Csg0Q==
Message-ID: <sashiko-outbox-201375@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v22 7/8] mptcp: sync mptcp skb cb layout with
 tcp one
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <20676e77a7ed0b1715bd1b539c21fb396d109a23.1793964796.git.tanggeliang@kylinos.cn>
References: <cover.1793964796.git.tanggeliang@kylinos.cn>
 <20676e77a7ed0b1715bd1b539c21fb396d109a23.1793964796.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 12:04:33 +0000
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
- [Medium] mptcp: uninitialized more_data_avail and stale seq if
  mptcp_init_skb() fails
--

commit 36fc62d77781e7da07f0272cbd92459df3b0613b
Author: Paolo Abeni <pabeni@redhat.com>

mptcp: sync mptcp skb cb layout with tcp one

This commit updates struct mptcp_skb_cb to use 32-bit sequence numbers for
map_seq and end_seq alongside a 64-bit map_seq64 field so that the shared CB
fields match the TCP control buffer layout.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index cedc91accc6b4..ced34e8cd25c8 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
[ ... ]
> @@ -433,11 +442,13 @@ static bool mptcp_init_skb(struct sock *ssk, struct=
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
> +	MPTCP_SKB_CB(skb)->flags =3D 0;
>  	MPTCP_SKB_CB(skb)->has_rxtstamp =3D has_rxtstamp;

[Severity: Medium]
In commit "mptcp: remove CB offset field" earlier in this series, can a
failure in mptcp_init_skb() cause __mptcp_move_skbs_from_subflow() to
evaluate more_data_avail uninitialized and leave tp->copied_seq stale?

net/mptcp/protocol.c:mptcp_init_skb() {
	...
	if (unlikely(offset > 0 &&
		     before(TCP_SKB_CB(skb)->seq - subflow->ssn_offset,
			    subflow->map_subflow_seq))) {
		if (offset >=3D skb->len || !pskb_pull(skb, offset)) {
			WARN_ON_ONCE(1);
			sk_eat_skb(ssk, skb);
			return false;
		}
		offset =3D 0;
	}
	...
}

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

When pskb_pull() fails under memory pressure, mptcp_init_skb() consumes
skb via sk_eat_skb() and returns false.  Taking continue in
__mptcp_move_skbs_from_subflow() jumps straight to while (more_data_avail),
reading more_data_avail uninitialized on the first iteration and skipping
both the tp->copied_seq update and mptcp_subflow_data_available().  Because
skb was already removed from ssk->sk_receive_queue while tp->copied_seq was
not advanced, the next skb on the queue computes an underflowed offset
(>=3D skb->len), dropping it and triggering mptcp_dss_corruption().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793964796.gi=
t.tanggeliang@kylinos.cn?part=3D7
