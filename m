Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795073965;
	b=SZjoNi+n2bVFAKnK7d0yTDOabRaSOvTO+T9SMbm3dFxk47a5jFp4MOqkF+zx4VzkhLjP
	 cjEMASGVUX1R4dX+rTRsfdQRFnx4TWlfmdIc+0KP+iGd8jndAsI3iC36kOwCht0yRac0P
	 lLeFAbx90D14u6GvRaJt25j4H50wGMC2nKM0WnuLT3lc76iEQF/EUuMH4vYOPWVXEj/F+
	 HAfsFBT9lpFHjNZkfSw3O3CAt+ICa65fJo2L3UGLyJuUwqEZkzkHWLj/22HtUfbutJ2cX
	 dkGhGZUjhr6uTrXK4mJPqyZ2VYujDnjQAvumXTpfDISKbsLEfQBRbzdCyGhPQ9L8AiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795073965;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=YMaKFwaJhUFrr0faIOVHt7QsIIOoVYw4Jbw8z2YfCNs=;
	b=gLTnNvQVjLDCHMcMwi1Qfp0KGEv+cVH7R8qhppGfw2M6d5FKP1yn8q6nQCG2Pvgh+Bsl
	 bOcC8uciMHN76+SGVzmqJPqX0OxK0eDLXtGTrQ4uPh30we0RMzvLwZACjAxHphpPZwpa0
	 gekTms0+OEbZ/eZf6E5LzJA8U2WbtbyWN7YCpaH+B14SDwRp528ILg4b4c7WgLJYutAQS
	 Shc4dVzeUFWan4dnI9conqefjsOospDwhzIEUkmHip56kA2a88Rx7cPB15jIs/7G8Yh0U
	 2DdOZo7zAXcnIzHMifxe8ON9ljLdm0M/RblbZGKjdtIHY0Jq3JzaUQ1uhK4ILR/TwGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IxrkVGJG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A14606A324
	for <mptcp@lists.linux.dev>; Thu, 19 Nov 2026 07:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IxrkVGJG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2BC11F000C5
	for <mptcp@lists.linux.dev>; Thu, 19 Nov 2026 07:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795073964;
	bh=YMaKFwaJhUFrr0faIOVHt7QsIIOoVYw4Jbw8z2YfCNs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=IxrkVGJG595wwtsxELW0RZKnS0NEq6E+MNbFyTJ7MyE32xFuNxYyLoRrEf4hM028k
	 xOKGeFUSKkXyFuVRSzgB0apR2IdOGNY6MjJLYsZN7ClJk9zz6hnV4OMBYnTyXlPhkW
	 JFnqg4lgxGVn9THVOfY0pixsSLyDBLseLdihqU7Tfpsl9LTFFcFLPZObasX/lBB3Jh
	 fQUXNCOxKG1wvk8CUXCIw84LsGB4QCSu7j0+9m3u6LJi9PvvO3US73DoT2JMifrfwr
	 cxBLngX5oJBNY3lCfZ/vrf+Ux2aTERo1iiP8sF4nZBaFO/2Kwn0Q5ggYNVjz1938+Z
	 hnknJdolDDYrQ==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-4ad60ec5eaaso635554fac.0
        for <mptcp@lists.linux.dev>; Wed, 18 Nov 2026 23:39:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEj36Sm14z3qyr3IkxgnA3IZTguyGAOHRNUP9xzhTeznEjRrgCh2HrDq/YICFb3rDgHHo3ubA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8XS9/Kh91PYLv5u8R0Bm2i37geu8c+ZMYkB6k8qNRnHzbpnZ24
	LsIiZRtKM6E1NI7k/8kBp/YTOvAXuz/+TkImtzeMn2MyLKKmrzWla8RXavUZpKOoPqKR2zmbPxp
	Qx48SfudBseXSQYiLaNrdjAX44+lLJmc=
X-Received: by 2002:a05:6870:b85:b0:4a7:2ba8:8e66 with SMTP id
 586e51a60fabf-4bb3bb73e47mr159329fac.37.1795073964027; Wed, 18 Nov 2026
 23:39:24 -0800 (PST)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261119071649.374106-1-kuniyu@google.com> <20261119071649.374106-4-kuniyu@google.com>
In-Reply-To: <20261119071649.374106-4-kuniyu@google.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Thu, 19 Nov 2026 08:39:13 +0100
X-Gmail-Original-Message-ID: <CAL4WiirMitCnhd1jNY0ypkFRzVisoFsQeHpdQ_PPDSkkk3Z+UA@mail.gmail.com>
X-Gm-Features: Aa3M54o6koo1i_5zG1eWmHFCplZJ88N6b7c2l3F2IAterkzT9kZPLwCE9Q8i9kM
Message-ID: <CAL4WiirMitCnhd1jNY0ypkFRzVisoFsQeHpdQ_PPDSkkk3Z+UA@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 3/7] tcp: Stop collapsing if not bloated.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Neal Cardwell <ncardwell@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 19 nov. 2026 =C3=A0 08:17, Kuniyuki Iwashima <kuniyu@google.com> a =
=C3=A9crit :
>
> Even when a skb is not bloated, tcp_collapse() starts collapsing
> if the next skb has overlapping data.
>
> Also, tcp_collapse() does not stop until it reaches the tail or
> unmergable skb (SYN/FIN, unreadable frags).
>
> Assume we detect a low-density skb followed by fully-packed 4K-MSS
> GRO skbs:
>
>              skb->len  truesize  scaling_ratio
>   skb    #1      1448      2944      125 (49%)
>   skb    #2     65536     66432      252 (98%)
>   skb    #3     65536     66432      252 (98%)
>   ...
>   skb    #9     65536     66432      252 (98%)
>   --------------------------------------------
>   total                  534400
>
> Then, even the high-density skbs are repacked into lower-density
> skbs, and we end up consuming much more memory.
>
>              skb->len  truesize  scaling_ratio
>   nskb   #1      3776      4352      222 (86%)
>   nskb   #2      3776      4352      222 (86%)
>   ...
>   nskb #139      3776      4352      222 (86%)
>   nskb #140       872      2304       96 (37%)
>   --------------------------------------------
>   total                  607232 (+72832!)
>
> Even if we find a collapsible skb, we should not collapse
> subsequent skbs with scaling_ratio >=3D TCP_COLLAPSE_SCALING_RATIO.
>
> Conversely, even if tp->scaling_ratio is smaller than
> TCP_COLLAPSE_SCALING_RATIO, we should repack skbs once we
> start collapsing, which results in higher-density skb.
>
> Let's remove the next skb condition in the first loop,
> search for collapsible bloated skb range, and repeat
> collapsing for each range.
>
> Note that even when the next skb is not bloated, we must
> collapse it for OOO rbtree if it has overlapping data.
>
>         overlap =3D !list && before(TCP_SKB_CB(n)->seq, sub_end);
>         ...
>         if (!overlap &&
>             !tcp_collapse_skb_bloated(n, sub_end,
>                                       TCP_COLLAPSE_SCALING_RATIO))
>                 break;
>
> For example, bloated skb_1 and non-bloated skb_2 have overlapping
> data and only skb_1 is collapsed to nskb_1 and nskb_2.
>
>    skb_1 =3D [1000, 5000]
>    skb_2 =3D [2000, 66000]
>
> Then, nskb_2 will be inserted after skb_2 in rbtree, wrongly
> setting tp->ooo_last_skb to 5000.
>
>   nskb_1 =3D [1000, 4776]
>    skb_2 =3D [2000, 66000]
>   nskb_2 =3D [4776, 5000]
>
> This case is still inefficient, but a later patch handles this.
>
> On the other hand, if an overlapping skb on the OOO rbtree cannot
> be collapsed, we skip the range instead of breaking out, as
> splitting the range could insert the tail nskb after that skb and
> break the same rbtree ordering.
>
> Another notable thing is that tcp_skb_can_collapse_rx() now checks
> candidates against the first skb before mptcp_skb_ext_move(),
> not against each nskb.
>
> When a skb with an MPTCP ext spans multiple nskbs, collapsing
> previously stopped at the next skb with the same ext because later
> nskbs lacked the ext.
>
>    skb1 (ext A),                  skb2 (ext A)
>   nskb1 (ext A), nskb2 (no ext)             ^
>                         ^- not collapsible -'
>
> Now such skbs are also collapsed with the redundant ext dropped,
> while the first nskb still carries the same mapping in sequence
> order.
>
>    skb1 (ext A),                  skb2 (ext A)
>   nskb1 (ext A), nskb2 (no ext) <-' collapsed into nskb2
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
