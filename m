Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794997739;
	b=h7T0PwzAv5JqzYpQI+vXR/64/b7Iuq/Iek2mqvZ2lTsR2PJ2yQdWmtx3yWvU7qtIgOS0
	 975OglF5s13eUDe6Nm7Gza4M55xEIQxjzprTTESj8tclYuvwGvdXLnrTCfcN3+K15ZZBc
	 QToGJixv/aqUci8KoW8F1HXbwLuJ8AX+/Xtoe0Y3fzZywGmKop3JXlpbyq5ijVKB7AIRG
	 mTgmsRmtsghw1r+K4o1gvwvNe6Es3ay3M9O9FFq54kxZdBp3QYYRu6TNJHZXvtnGbkIQw
	 2N10f1ahYcqjC6DEsQ/qyzreL8SP3abkKIJejunFyg03xBKjlz7SpFOZS7sWpsezxXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794997739;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=hyYrCKddYun6Ci2oVE4KqeDabN1R54MsEm3bclQ1m+Y=;
	b=U72NlwnI+9Xtxw4HlaVp8f/Nv4qRo90c7zWEZrPWw17+391zyTvv5rGk58GtE7RuWw9b
	 hygWhByJdmUGlVyhq6TPGYrxAsGBHndVEYLsOQijBoT1DlOMigHuJiR0VVZOkiLSEmlN8
	 M0i3Y9EX9njFMlvsCQsVqBRj9cNW2eSkwSHsgp/zNL7TO7hhEKI7ZSR7ymYmhJN3mRkd5
	 iwH5KiAbd9TJRYkC5i56jZoaHcuFwLrAXCuO1pQkrF2VCgw1EaH/8KRj55eCN9d/38M7K
	 Bs9NVg18rWS0t+Iv2VDZLhDr+ozSxvTlKFCROh51eKR/ZKy9/Ho75OHWhwuuaa2hphA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hqk+8mEJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6124606A32A
	for <mptcp@lists.linux.dev>; Wed, 18 Nov 2026 10:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hqk+8mEJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8419F1F000CB
	for <mptcp@lists.linux.dev>; Wed, 18 Nov 2026 10:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794997738;
	bh=hyYrCKddYun6Ci2oVE4KqeDabN1R54MsEm3bclQ1m+Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Hqk+8mEJ7vtA7W/h5nUCLhMl0lGcipzVhs33vxhvi3a0NnuG6PbosFnmWHshDD7hA
	 P5z3cktyEIzrNXNBEHc80Td5YNge9iBCtRB4h/qtbGhSCrLuB5rfU/Hc595FQminIn
	 ycxMu/z5Reo3vH1bL/lVCp4C6Q4Wgq9PEpFjfkykCaTkMvnnwIsKYOFYWLdS3047Du
	 +ciOYqk1bx5B0/Qy7wGqo4aVI8e767y8lQ3YXV6ORWeWeh9lrViIyMJJEgBvJjVsA7
	 j2LvQVSL6SbZ7l2AkC4mQoqzfjMoZ7R1vMS+NKaB1luiH+AfrcM6YR5u8aS21vciBT
	 tvvCeANkwjlRQ==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6b1afdf5196so294945eaf.2
        for <mptcp@lists.linux.dev>; Wed, 18 Nov 2026 02:28:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEMqiuKaRpH2XfEmcFEVZFPJFisqoONoUPFmV0uLvZn7DhRrpSm86syiYTPb6VB984N3Ll1ew==@lists.linux.dev
X-Gm-Message-State: APuU4Z/61rjd0FY2tYiZsUbC4qP1TshBdRIwTA1ghjQrm+UmTPHW5sqS
	HCt+rVG1yqh28PRXIlpIyEiFwdECVS3Xg+UKq+7QfpiJV/kxPu7yBJPUpVqBzY18z7180NoSp/B
	jZ8aseYIEMIQpRNwpU6V5PbmMmMesuDE=
X-Received: by 2002:a05:6820:1c84:b0:6d7:a13d:fd7b with SMTP id
 006d021491bc7-71b18483801mr1460952eaf.28.1794997737802; Wed, 18 Nov 2026
 02:28:57 -0800 (PST)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261116230555.2305867-1-kuniyu@google.com> <20261116230555.2305867-6-kuniyu@google.com>
In-Reply-To: <20261116230555.2305867-6-kuniyu@google.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Wed, 18 Nov 2026 11:28:44 +0100
X-Gmail-Original-Message-ID: <CAL4WiipeiomdeRaSOpRn6Unu4-ohwrdkWCZ9mRn1ELfrW24+XQ@mail.gmail.com>
X-Gm-Features: AclHuK-sNpS4rMULS10qwTKTJag47_6QqpDqDc6vL03tNxIhG20bc3PJelJq6jE
Message-ID: <CAL4WiipeiomdeRaSOpRn6Unu4-ohwrdkWCZ9mRn1ELfrW24+XQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 5/7] tcp: Allocate all new skb before collapsing.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Neal Cardwell <ncardwell@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 17 nov. 2026 =C3=A0 00:06, Kuniyuki Iwashima <kuniyu@google.com> a =
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
> so the section size is normally capped at TCP_COLLAPSE_MAX_TOTAL_SIZE
> (16 skbs), except when a single bloated skb or overlapping OOO skbs
> must be collapsed together to free the original skb or keep the
> rbtree monotonic.
>
> Once the size exceeds the limit, the remaining skbs are re-evaluated
> from restart:.
>
> Note that the next skb can be skipped if its density already meets
> tp->scaling_ratio, and each cut adds at most one remainder skb
> (~3.4% worst-case truesize overhead on 4 KiB pages), which is a
> small tradeoff to bound the temporary allocation.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> Reviewed-by: Eric Dumazet <edumazet@kernel.org>
> ---
>  net/ipv4/tcp_input.c | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 0815e1891fba..ca4cdb93373d 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -5812,6 +5812,7 @@ static struct sk_buff *tcp_skb_next(struct sk_buff =
*skb, struct sk_buff_head *li
>  #define TCP_COLLAPSE_SCALING_RATIO                             \
>         ((TCP_COLLAPSE_MAX_SIZE << TCP_RMEM_TO_WIN_SCALE) /     \
>          (SKB_TRUESIZE(TCP_COLLAPSE_MAX_SIZE)))
> +#define TCP_COLLAPSE_MAX_TOTAL_SIZE (TCP_COLLAPSE_MAX_SIZE * 16)
>
>  static bool tcp_collapse_skb_bloated(const struct sk_buff *skb,
>                                      u32 start, u8 scaling_ratio)
> @@ -5852,8 +5853,9 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *=
list, struct rb_root *root,
>  {
>         int old_truesize, new_truesize;
>         struct sk_buff *skb =3D head, *n;
> -       struct sk_buff_head tmp;
> +       struct sk_buff_head tmp, pool;
>         int remainder, nskbs;
> +       struct sk_buff *nskb;
>         u8 scaling_ratio;
>         u32 sub_end;
>
> @@ -5861,6 +5863,7 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *=
list, struct rb_root *root,
>                             TCP_COLLAPSE_SCALING_RATIO);
>
>         __skb_queue_head_init(&tmp);
> +       __skb_queue_head_init(&pool);
>
>         /* First, check that queue is collapsible and find
>          * the point where collapsing can be useful.
> @@ -5908,8 +5911,9 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *=
list, struct rb_root *root,
>
>                 /* seq and end_seq must increase monotonically for rbtree=
. */
>                 if ((list || !before(TCP_SKB_CB(n)->seq, sub_end)) &&
> -                   !tcp_collapse_skb_bloated(n, sub_end,
> -                                             TCP_COLLAPSE_SCALING_RATIO)=
)
> +                   (TCP_SKB_CB(n)->end_seq - start >=3D TCP_COLLAPSE_MAX=
_TOTAL_SIZE ||
> +                    !tcp_collapse_skb_bloated(n, sub_end,
> +                                              TCP_COLLAPSE_SCALING_RATIO=
)))
>                         break;

Sashiko has a point about the "overlapping OOO skbs" exception [1]:
it is fully under control of the peer.

For the ofo queue, as long as n->seq is before sub_end, neither the
cap nor the density test is evaluated. tcp_data_queue_ofo() keeps
partially overlapping segments, so a peer sending small segments,
each of them overlapping the previous one by one byte, builds a chain
that tcp_collapse() sees as a single section covering the whole
ofo queue.

>
>                 sub_end =3D TCP_SKB_CB(n)->end_seq;
> @@ -5924,6 +5928,8 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *=
list, struct rb_root *root,
>         if (remainder) {
>                 nskbs++;
>                 new_truesize +=3D compute_skb_truesize(remainder, GFP_ATO=
MIC);
> +       } else {
> +               remainder =3D TCP_COLLAPSE_MAX_SIZE;
>         }
>
>         if (old_truesize <=3D new_truesize) {
> @@ -5932,14 +5938,19 @@ tcp_collapse(struct sock *sk, struct sk_buff_head=
 *list, struct rb_root *root,
>                 goto restart;
>         }
>
> -       while (before(start, sub_end)) {
> -               int copy =3D min_t(int, TCP_COLLAPSE_MAX_SIZE, sub_end - =
start);
> -               struct sk_buff *nskb;
> -
> -               nskb =3D alloc_skb(copy, GFP_ATOMIC);
> +       while (nskbs--) {
> +               nskb =3D alloc_skb(nskbs ? TCP_COLLAPSE_MAX_SIZE : remain=
der,
> +                                GFP_ATOMIC);
>                 if (!nskb)
>                         goto end;
>
> +               __skb_queue_tail(&pool, nskb);
> +       }

Then this loop is only bounded by sk_rcvbuf.

With a big tcp_rmem[2], this can be megabytes of GFP_ATOMIC memory
allocated at once, not charged to the socket, while all the
original skbs are still in the queue. Before this patch the
overshoot was about one skb, because originals were freed while
being copied.

Also, a single alloc_skb() failure now discards the whole batch,
so such a queue might never be collapsed, precisely when we are
under memory pressure.

I think TCP_COLLAPSE_MAX_TOTAL_SIZE must be a hard limit for anything
but the single (first) skb case.

Legitimate overlaps (retransmits with a different segmentation) only
involve a few skbs. A long chain of overlapping skbs is not something
we need to optimize for, so my preference would be to simply not
collapse it:

Keep walking the chain in the second loop so that sub_end is
correct, remember that the cap has been exceeded, then skip the
section the same way patch 4 does:

        start =3D sub_end;
        skb =3D n;
        goto restart;

tcp_prune_ofo_queue() will take care of these skbs if we are still
over the limit.

The alternative would be to cut the chain at the cap, but then the
next section starts with an skb whose seq is before @start, and this
skb would have to be collapsed unconditionally (even if not bloated,
even if patch 4 says the result is not smaller) to keep the rbtree
ordered. This also means @released could be negative in patch 6.
This looks more fragile to me.

Related to this: in patch 4, when the second loop breaks on
!tcp_skb_can_collapse_rx() (or SYN/FIN, unreadable frags) with an
overlapping @n in the rbtree, @n can stay in the tree and the last
nskb of the previous section is inserted after it, with a smaller
end_seq. To be fair, the current code has the same issue (goto end
in the copy loop), but since you are making the ordering explicit
in patch 3, it would be nice to cover it: the same "skip the
section" logic could be used when the loop stops on an overlapping
skb that can not be collapsed.

Whatever option you choose, please add a comment next to
TCP_COLLAPSE_MAX_TOTAL_SIZE describing what it bounds and its
exceptions.

[1] https://lore.kernel.org/netdev/179495722211.3136.15241045445062201797@k=
ernel.org/
