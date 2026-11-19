Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795074307;
	b=qXFOi/KUjJM3pFkUoQg79/W4d6mgOmNsK4Y2q3NbrmSwHXWdmry9kvmJxeWKi6oJ0AHl
	 5iWrM5tmg2M3fWC6JVTJ2r1xekbkHxIbD/axxCH1IlPMEOy0pVn9CKLWBe5X5ED+5dYP8
	 cTaldW+od71XlGeFHKhxyHJYu+I+4CV+ggPAaDJRjs/ufWzvxzMNo4yurgyYA6YvRH1Mh
	 xj69XxjxbVvam+7p7/K6hdzkjugdZoWkl5dWUw0Onf2uk68qe41TudFG8ssa3MZbscMKM
	 HpVjj7BaYRnxIxLugvXD7C6RXLSTvUpi2XkYutzp2gtMglUI+xqkx3T0Nf/sWTktykw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795074307;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=d1+ergkQMZDPtjbp7or2Wdfi9HoMSYSR/NYEudC0R5I=;
	b=nr7KPigE6Innvlw6xMPbRHEbtQUqC2xVMQiYzYkbrNyK8hWpoi1Ddidf5EE5+jA83Ct5
	 E2aQvejDv4gKDt/GBP7x55uUS76Alc/TWCwRLDqnNNiAlJstsLBdzBj7p6NGBVFyOvN5t
	 EVS4jmTPryP1AJs3mn+5YGZf0Ug9zZhsReJjiSUTmhhMb5TocRMNiZbxC8CURm8U98zER
	 B9gKoA2H60dYU/OXL8UOt3WewfYi5SBrTsuQcrPaotfSXoy42cisLrq87WemVM0S07vQQ
	 LNnNYlp9qxV07EBA2oDnD8+9sEfBQOHQuckBjOSpmyoV1vnCVMFMzTew+1RtErm49iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CVLqd8F9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BD0606A331
	for <mptcp@lists.linux.dev>; Thu, 19 Nov 2026 07:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CVLqd8F9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D47D1F000D1
	for <mptcp@lists.linux.dev>; Thu, 19 Nov 2026 07:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795074306;
	bh=d1+ergkQMZDPtjbp7or2Wdfi9HoMSYSR/NYEudC0R5I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CVLqd8F9URZM2NNWOGdHwBZLlNwhMdUqm06DulF4xLJrlTEfhFi38LHJpEDckyq/o
	 CZfkVJ/4arf4+RPaIH8A5sl+qoEKiCrZ7NO84f07ax3+PHoIPWNjg/FOaQnMQdo53A
	 RqtK19MJEqqFQAvrLkcbezbu4JSvEDumYItVi/rIZocKk0/SRodfmA8kVojJ/7zjpY
	 ReUbnV7nadwErHaXOttN40EgYn+0EOaf4prBnTH8SxO9QEfpwohcJDNIBD4RXW6kE9
	 BlInvkLMRvmF75pqbkSR8nefksnw0+SAA9eiTiXel/PCZxpn75lYXPwfhMYg6TE8e9
	 F2LGOJsizr2bQ==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-4a77761ff8aso1302111fac.2
        for <mptcp@lists.linux.dev>; Wed, 18 Nov 2026 23:45:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErH4u6ACxe8fQ6ziDQc4x7Spyny+b0vVb9fs/R4wQnOB+O2HI43HzU9cgZnXcdEjL6xQ6XAz0w==@lists.linux.dev
X-Gm-Message-State: APuU4Z8cNfdiUlJhvQBya9Othn/4GxexyDUKpJ1oKYLOw8qWA3+vxGlB
	SzeU0o1v9QaQ7cKn9DVlKwdUfE/Gjvq8pBWPzlukQJ5680YCXh65x16o+0FI5xndp7rol9mak4g
	PcS7uNphyd+6ZQqGeAKBTLo0C0K0XyQ4=
X-Received: by 2002:a05:6870:1429:b0:48f:e0e5:a202 with SMTP id
 586e51a60fabf-4b75fe11713mr5053314fac.54.1795074305588; Wed, 18 Nov 2026
 23:45:05 -0800 (PST)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261119071649.374106-1-kuniyu@google.com> <20261119071649.374106-6-kuniyu@google.com>
In-Reply-To: <20261119071649.374106-6-kuniyu@google.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Thu, 19 Nov 2026 08:44:54 +0100
X-Gmail-Original-Message-ID: <CAL4WiioNduj1AybypLPDs6HuW2F9Y9zw3B2ycLSogRMnfzBk9g@mail.gmail.com>
X-Gm-Features: AclHuK_R3C_eYGkkpq9fmYj3F1h9Oq6I8L_OOXLPiSpYJTlCKcskIw-XEfvh2KY
Message-ID: <CAL4WiioNduj1AybypLPDs6HuW2F9Y9zw3B2ycLSogRMnfzBk9g@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 5/7] tcp: Allocate all new skb before collapsing.
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
> At the final stage, tcp_collapse() iterates over collapsible
> candidate skbs and repacks them to new skbs.
>
> In each iteration, a new skb is allocated and inserted to the
> receive queue or a temporary list for RB tree.
>
> If alloc_skb() fails while splitting a large bloated skb across
> multiple new skbs, the partially-copied skb is not removed and
> new skbs remain in the queue as duplicates, consuming more memory.
>
> It is only when all candidates are properly collapsed that
> we can save memory.
>
> To avoid complicated rollback, let's preallocate skbs before
> collapsing.
>
> Now all skb in [start, sub_end) must be allocated in a batch,
> so the section size is capped at TCP_COLLAPSE_MAX_TOTAL_SIZE
> (16 skbs), except for the first single skb.
>
> Once the size exceeds the limit, the remaining skbs are
> re-evaluated from restart:.
>
> Legitimate overlaps (retransmits with a different segmentation)
> only involve a few skbs, so if an overlapping OOO chain reaches
> the limit, we simply skip it.
>
> Note that the next skb can be skipped if its density already meets
> tp->scaling_ratio, and each cut adds at most one remainder skb
> (~3.4% worst-case truesize overhead on 4 KiB pages), which is a
> small tradeoff to bound the temporary allocation.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
> v3: Make TCP_COLLAPSE_MAX_TOTAL_SIZE hard-limit for multiple skbs
> ---
>  net/ipv4/tcp_input.c | 41 ++++++++++++++++++++++++++++++++---------
>  1 file changed, 32 insertions(+), 9 deletions(-)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 27ed9ba11ec9..990e34896373 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -5822,6 +5822,11 @@ static struct sk_buff *tcp_skb_next(struct sk_buff=
 *skb, struct sk_buff_head *li
>  #define TCP_COLLAPSE_SCALING_RATIO                             \
>         ((TCP_COLLAPSE_MAX_SIZE << TCP_RMEM_TO_WIN_SCALE) /     \
>          (SKB_TRUESIZE(TCP_COLLAPSE_MAX_SIZE)))
> +/* Cap pool preallocation per sub-range to at most 16 skbs in seq
> + * space.  A single first skb exceeding this is still collapsed,
> + * whereas an exceeding overlapping ofo range is skipped.
> + */
> +#define TCP_COLLAPSE_MAX_TOTAL_SIZE (TCP_COLLAPSE_MAX_SIZE * 16)
>
>  static bool tcp_collapse_skb_bloated(const struct sk_buff *skb,
>                                      u32 start, u8 scaling_ratio)
> @@ -5862,8 +5867,9 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *=
list, struct rb_root *root,
>  {
>         unsigned int old_truesize, new_truesize;
>         struct sk_buff *skb =3D head, *n;
> -       struct sk_buff_head tmp;
> +       struct sk_buff_head tmp, pool;
>         int remainder, nskbs;
> +       struct sk_buff *nskb;
>         u8 scaling_ratio;
>         u32 sub_end;
>
> @@ -5871,6 +5877,7 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *=
list, struct rb_root *root,
>                             TCP_COLLAPSE_SCALING_RATIO);
>
>         __skb_queue_head_init(&tmp);
> +       __skb_queue_head_init(&pool);
>
>         /* First, check that queue is collapsible and find
>          * the point where collapsing can be useful.
> @@ -5926,8 +5933,9 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *=
list, struct rb_root *root,
>                 }
>
>                 if (!overlap &&
> -                   !tcp_collapse_skb_bloated(n, sub_end,
> -                                             TCP_COLLAPSE_SCALING_RATIO)=
)
> +                   (TCP_SKB_CB(n)->end_seq - start >=3D TCP_COLLAPSE_MAX=
_TOTAL_SIZE ||
> +                    !tcp_collapse_skb_bloated(n, sub_end,
> +                                              TCP_COLLAPSE_SCALING_RATIO=
)))
>                         break;
>
>                 sub_end =3D TCP_SKB_CB(n)->end_seq;
> @@ -5935,25 +5943,38 @@ tcp_collapse(struct sock *sk, struct sk_buff_head=
 *list, struct rb_root *root,
>                 n =3D tcp_skb_next(n, list);
>         }
>
> +       if (sub_end !=3D TCP_SKB_CB(skb)->end_seq &&
> +           sub_end - start >=3D TCP_COLLAPSE_MAX_TOTAL_SIZE)
> +               goto skip;

This is fine for now, but note that a single 64K GRO skb overlapping
a bloated skb is enough to reach the limit, and the bloated skb is
then never collapsed. The range is walked again at every
tcp_collapse_ofo_queue() call, for no gain.

A possible followup would be to cut the range instead of skipping it.

When @n overlaps and we do not want (or can not) merge it, we know
that @n already contains [TCP_SKB_CB(n)->seq, sub_end), because
skbs with end_seq <=3D sub_end were removed earlier in the loop.

So we could do :

        sub_end =3D TCP_SKB_CB(n)->seq;

and collapse [start, sub_end) only, as long as sub_end is after start.

All new skbs would then have a seq smaller than TCP_SKB_CB(n)->seq,
so the rbtree ordering is preserved, and we would not need to drag
@n into the range.

After the copy, the skbs of the range that were not fully consumed
would have to be freed, since the rest of their payload is in @n.

The same trick would also work for the unmergeable overlapping skb
case added in patch 3.

I have not tested this, and this can be done later.

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
