Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795022930;
	b=c7O1Uxc7LF+zfKIThcEjAdFMfPP8pSRRlgKQ7oHK9JzurSLVLsbD59zxAydCJPU1/2xO
	 nzHkexNLRcnhFPuQEqkNySKYhn/XUyy/KKWJunJpnNx457WCLXBaSHqFDgzPOToePFf/Z
	 +SH10cuYleJNx0SaQtMFZkWqKJRfqCTnZ6qXPb9k9AoVm3qlRlNAGZkXiROBiCeYRONeK
	 8N0qiPHXi00pghfz8orFCcogi7OhibDz93YED2Q/POgtBEdbHuGMoML8UU6KQT2BJGy5g
	 SPxHSGU7FPPDBJa86oluhMhcDHB81jNaD0Z6WrwJGIk2L5Um5MLAIK/uqveV1qv3I/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795022930;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=2Y+IvdPWp8PJk6wSKvWKsu+RJKvBF/peDdPX+yZVPfo=;
	b=TfdFdxj25CMpO6EybD1LTFINwC9+s7G/eBtMoyjpdcMUsX8BaXJwbq02fqIQLlIPyWox
	 BwRb9qoH9hFn1l5vjFIcYX3XXKD9itlZ+0iZl+9my1qUjwQicVmHafjUyoXXNmq8Vgdi6
	 1fHl9dS419j8gXs12KqVUgk/efDXgb8REWr9pyqBH5z4FITPFyj9pRvm0CxHwoAbspiN+
	 Y5A6euH8BOAqKf/Q1Du8nf/GTeja2lScqZfZ+hh69l0KSY1rj4NHv9VKidKSNsNI0z0Js
	 NnABBuRTAg/a0lX5zQ78EqKGYwCOQNjAHu9zB7hMxYC+hb46dHs72pDI4zBzsE55Yxg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="Dfj/y5t5";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5097C606A754
	for <mptcp@lists.linux.dev>; Wed, 18 Nov 2026 17:28:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5097C606A754
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Dfj/y5t5
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1a2761c69fbso1178665c88.0
        for <mptcp@lists.linux.dev>; Wed, 18 Nov 2026 09:28:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795022929; cv=none;
        d=google.com; s=arc-20260327;
        b=XO6PS28F05M14/9BW3jEGCNC+qVoBeEQ9NOmMNIGIp5vHj6cd75iaBeFpU9B21L+aU
         IPUlbORFeOrxy219WZ+Z+jOWx3OKDKe5yAGwgGyoODmWJQ26SxSIx8FkSykBIadrSVA3
         y6Sf9zxDmmsTzV33Y83XpK9lpGLGH3tjv4NNgRX2TXqOZ+TJlpSGkTbkj4Z7P4yXQfT6
         exwGc1Lg6bwfMeAu4Z4R2cMxBKTEXAGzp42TsxfR5UbPSybVGv9hZrwEFdxlD3bqjba5
         uECMvPbn5oc/nuh/78NuMe5G5a0I256Co5jX6A3xkYSHwfJ1VzcKXEannTDtkZ7lcUAY
         DKaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2Y+IvdPWp8PJk6wSKvWKsu+RJKvBF/peDdPX+yZVPfo=;
        fh=Ya33gdCcER4dbuirFu3thqGEcmARrPQd7DFA1tecWcg=;
        b=ND2n/k/bRs5VoXOkZEWoUl5FmRNPHcATEumwTYvjpKOe4LaZQhaChfhP9O7wG7ozko
         eRhYWyjwuYsuuN4pbHy9/7aT+uBx0e3sixsEeCxPxxTahiAS6z007mIiez413/bPeq4K
         P4LfFF6poD1Xq9SFNqV18c0YGabINeQpuVh69ggGholX0yShVZmGZqG4CY9tQiJZeGQF
         zmaHgmJSEyHfVXspyNMt61k/w4BeplxV83xyA9xXQOs5+AEa43Z7FW2+ihKlLLx+c1/8
         GyMNkLLtPaYyZleyQNC0OscuZrdEk+F/gW4XnvvLgnDmyR6RzCTh3r4VMyywUdi8n+pl
         QFIw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795022929; x=1795627729; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2Y+IvdPWp8PJk6wSKvWKsu+RJKvBF/peDdPX+yZVPfo=;
        b=Dfj/y5t5vUKAVzmsAGQxcv2wv0qHdENI7vsh3cfyFX7/Rznu2SPwH7LqEVFjAwOFZU
         xwOEe2cFXwaLfNNwlEvQ00NOJyYLy076HQ5fWcuJCtz0oVs57YuA5eklFnAKyqRUriMk
         Z/Q3yIjRndmuMHweegYxXBnD1OvOTTPod+zeZ3Mz5AZo3SZ9w8MD51fqktOHrIht0ekx
         Yk5fsWRFjDh4likGPB1RM9oNNJbczQDf57DjaLRBVjkGmrnUiRduWjds38rEQr0DCTV4
         mbqNA56bPzC79OZLdujL0sMbQiCNepRFok9nJM/yOCUbXA4LE4Tz5cEE0Zb4PMy/J8em
         Z47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795022929; x=1795627729;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2Y+IvdPWp8PJk6wSKvWKsu+RJKvBF/peDdPX+yZVPfo=;
        b=meVSHAWbJi89VDQL/8T21ycdayFGR+rKUxkZSfV8U7o5x9apYIqEOGRBlqMoGw1NjM
         KQt1upSbwozBFtof3x20K8nyCWtU5d9pfwaT4AB7UrYmlTOErUdm0To+iDR+J0RhANs5
         crOoF2eynaQMmwc5DhwQAl0FpVBajYRhsddH/pKCUAvtrAn7tyOg+uWA/Bz4+PsUgWLS
         oR4rpB7DnpCd9qQjyvzA6RmOtytSqMrguTZhfsy0jYnvK7f9nH9NCxVnxe7X0JBwo6zv
         7iNHqUn02PzvTwAflQldGc1PiBqp6qarOa7r3OFNPHrujTl5cBY47ADn8NxQ81cmLdEg
         YNcg==
X-Forwarded-Encrypted: i=1; AL+hErH4gqG8jghcw5cSeZmtZ+g4c6LrgV3BAAOwppYl6SqVmS6Fjc7BFjGSI2OGFKC5TBOxOeDzIg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+6bkRhd7buysTFWIgHrzwJ+gF4bQ85t9N0SXTg17V0qasCXBLr
	QDwDZ2ZIfHKjDewdQdpCpPkNEYn9OEfR6ea9s06UaI0lGNCk8kwFx2FmtPLhx0p+8js8Bc2YVij
	az0iXXGjRiqIulgmUVEAjetiiisbX130BE158oJF/
X-Gm-Gg: AYBFou0Ajl4KKFzSqSM193Aw2iwg3b1PR/Nr8t2iHEeRO+W4hTNkbk05gkdWwAgJ7Rb
	o1ke+OYNGNpYxFGfDfA0go0GEgRtKqo5KWgzLMaOZdZHz1s/i6HcPRdIOgXW5iJSZN5DVFGZNOb
	ceMwGEnHA0aFcPecZPYPFzfU7gT59VM04P2BeMCPzH17PrMSKZbOS091TY60XbKglHIlAWK/MFR
	WtR635IpAl5vlXo+YdS7IZGBoJKu1U78maDsqjWROP2UHxU3a7nMtiFo7/yo6edliOtDSaJHqAC
	Xr9ySg5/aI08RcDV+ttNOz4EivpxP8iTkZTwXfOjCjSY2MP6svX0lfEA2ll+PNkU20Au0vrDXbQ
	Af0m4flxOazN0MlnRialmpt3WHeREJQ36U2Nhq7WImovc/OoRXmrSXCCuHI81ZIUVF1YZiyyhXh
	8iQFr5k5IBqFVHAalyd6cO+f1cZRQKh74Hhh/ObcOL8TWXkupse00LLLEwYoL51Sk8h26DLGBud
	Fan4Q==
X-Received: by 2002:a05:701b:424d:20b0:199:7dff:f9cc with SMTP id
 a92af1059eb24-1b543c4406fmr3054304c88.42.1795022928342; Wed, 18 Nov 2026
 09:28:48 -0800 (PST)
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
 <CAL4WiipeiomdeRaSOpRn6Unu4-ohwrdkWCZ9mRn1ELfrW24+XQ@mail.gmail.com>
In-Reply-To: <CAL4WiipeiomdeRaSOpRn6Unu4-ohwrdkWCZ9mRn1ELfrW24+XQ@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 18 Nov 2026 09:28:37 -0800
X-Gm-Features: AclHuK9beCyfcAr2Tf5zPkHNPrvLNehHhhlsSBc8vMCDOU9Fs4eD5YF_D8xMZGw
Message-ID: <CAAVpQUA_yFd6b=z1zuts1HDzFs1C-++vovTLo7iZTQOr6wzjQw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 5/7] tcp: Allocate all new skb before collapsing.
To: Eric Dumazet <edumazet@kernel.org>
Cc: Neal Cardwell <ncardwell@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 2:28=E2=80=AFAM Eric Dumazet <edumazet@kernel.org> =
wrote:
>
> Le mar. 17 nov. 2026 =C3=A0 00:06, Kuniyuki Iwashima <kuniyu@google.com> =
a =C3=A9crit :
> >
> > At the final stage, tcp_collapse() iterates over collapsible
> > candidate skbs and repacks them to new skbs.
> >
> > In each iteration, a new skb is allocated and inserted to the
> > receive queue or a temporary list for RB tree.
> >
> > If alloc_skb() fails while splitting a large bloated skb across
> > multiple new skbs, the partially-copied skb is not removed and
> > new skbs remain in the queue as duplicates, consuming more memory.
> >
> > It is only when all candidates are properly collapsed that
> > we can save memory.
> >
> > To avoid complicated rollback, let's preallocate skbs before
> > collapsing.
> >
> > Now all skb in [start, sub_end) must be allocated in a batch,
> > so the section size is normally capped at TCP_COLLAPSE_MAX_TOTAL_SIZE
> > (16 skbs), except when a single bloated skb or overlapping OOO skbs
> > must be collapsed together to free the original skb or keep the
> > rbtree monotonic.
> >
> > Once the size exceeds the limit, the remaining skbs are re-evaluated
> > from restart:.
> >
> > Note that the next skb can be skipped if its density already meets
> > tp->scaling_ratio, and each cut adds at most one remainder skb
> > (~3.4% worst-case truesize overhead on 4 KiB pages), which is a
> > small tradeoff to bound the temporary allocation.
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > Reviewed-by: Eric Dumazet <edumazet@kernel.org>
> > ---
> >  net/ipv4/tcp_input.c | 29 +++++++++++++++++++++--------
> >  1 file changed, 21 insertions(+), 8 deletions(-)
> >
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index 0815e1891fba..ca4cdb93373d 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -5812,6 +5812,7 @@ static struct sk_buff *tcp_skb_next(struct sk_buf=
f *skb, struct sk_buff_head *li
> >  #define TCP_COLLAPSE_SCALING_RATIO                             \
> >         ((TCP_COLLAPSE_MAX_SIZE << TCP_RMEM_TO_WIN_SCALE) /     \
> >          (SKB_TRUESIZE(TCP_COLLAPSE_MAX_SIZE)))
> > +#define TCP_COLLAPSE_MAX_TOTAL_SIZE (TCP_COLLAPSE_MAX_SIZE * 16)
> >
> >  static bool tcp_collapse_skb_bloated(const struct sk_buff *skb,
> >                                      u32 start, u8 scaling_ratio)
> > @@ -5852,8 +5853,9 @@ tcp_collapse(struct sock *sk, struct sk_buff_head=
 *list, struct rb_root *root,
> >  {
> >         int old_truesize, new_truesize;
> >         struct sk_buff *skb =3D head, *n;
> > -       struct sk_buff_head tmp;
> > +       struct sk_buff_head tmp, pool;
> >         int remainder, nskbs;
> > +       struct sk_buff *nskb;
> >         u8 scaling_ratio;
> >         u32 sub_end;
> >
> > @@ -5861,6 +5863,7 @@ tcp_collapse(struct sock *sk, struct sk_buff_head=
 *list, struct rb_root *root,
> >                             TCP_COLLAPSE_SCALING_RATIO);
> >
> >         __skb_queue_head_init(&tmp);
> > +       __skb_queue_head_init(&pool);
> >
> >         /* First, check that queue is collapsible and find
> >          * the point where collapsing can be useful.
> > @@ -5908,8 +5911,9 @@ tcp_collapse(struct sock *sk, struct sk_buff_head=
 *list, struct rb_root *root,
> >
> >                 /* seq and end_seq must increase monotonically for rbtr=
ee. */
> >                 if ((list || !before(TCP_SKB_CB(n)->seq, sub_end)) &&
> > -                   !tcp_collapse_skb_bloated(n, sub_end,
> > -                                             TCP_COLLAPSE_SCALING_RATI=
O))
> > +                   (TCP_SKB_CB(n)->end_seq - start >=3D TCP_COLLAPSE_M=
AX_TOTAL_SIZE ||
> > +                    !tcp_collapse_skb_bloated(n, sub_end,
> > +                                              TCP_COLLAPSE_SCALING_RAT=
IO)))
> >                         break;
>
> Sashiko has a point about the "overlapping OOO skbs" exception [1]:
> it is fully under control of the peer.
>
> For the ofo queue, as long as n->seq is before sub_end, neither the
> cap nor the density test is evaluated. tcp_data_queue_ofo() keeps
> partially overlapping segments, so a peer sending small segments,
> each of them overlapping the previous one by one byte, builds a chain
> that tcp_collapse() sees as a single section covering the whole
> ofo queue.

Exactly...


>
> >
> >                 sub_end =3D TCP_SKB_CB(n)->end_seq;
> > @@ -5924,6 +5928,8 @@ tcp_collapse(struct sock *sk, struct sk_buff_head=
 *list, struct rb_root *root,
> >         if (remainder) {
> >                 nskbs++;
> >                 new_truesize +=3D compute_skb_truesize(remainder, GFP_A=
TOMIC);
> > +       } else {
> > +               remainder =3D TCP_COLLAPSE_MAX_SIZE;
> >         }
> >
> >         if (old_truesize <=3D new_truesize) {
> > @@ -5932,14 +5938,19 @@ tcp_collapse(struct sock *sk, struct sk_buff_he=
ad *list, struct rb_root *root,
> >                 goto restart;
> >         }
> >
> > -       while (before(start, sub_end)) {
> > -               int copy =3D min_t(int, TCP_COLLAPSE_MAX_SIZE, sub_end =
- start);
> > -               struct sk_buff *nskb;
> > -
> > -               nskb =3D alloc_skb(copy, GFP_ATOMIC);
> > +       while (nskbs--) {
> > +               nskb =3D alloc_skb(nskbs ? TCP_COLLAPSE_MAX_SIZE : rema=
inder,
> > +                                GFP_ATOMIC);
> >                 if (!nskb)
> >                         goto end;
> >
> > +               __skb_queue_tail(&pool, nskb);
> > +       }
>
> Then this loop is only bounded by sk_rcvbuf.
>
> With a big tcp_rmem[2], this can be megabytes of GFP_ATOMIC memory
> allocated at once, not charged to the socket, while all the
> original skbs are still in the queue. Before this patch the
> overshoot was about one skb, because originals were freed while
> being copied.
>
> Also, a single alloc_skb() failure now discards the whole batch,
> so such a queue might never be collapsed, precisely when we are
> under memory pressure.
>
> I think TCP_COLLAPSE_MAX_TOTAL_SIZE must be a hard limit for anything
> but the single (first) skb case.
>
> Legitimate overlaps (retransmits with a different segmentation) only
> involve a few skbs. A long chain of overlapping skbs is not something
> we need to optimize for, so my preference would be to simply not
> collapse it:
>
> Keep walking the chain in the second loop so that sub_end is
> correct, remember that the cap has been exceeded, then skip the
> section the same way patch 4 does:
>
>         start =3D sub_end;
>         skb =3D n;
>         goto restart;
>
> tcp_prune_ofo_queue() will take care of these skbs if we are still
> over the limit.

Sounds good, I'll apply the strategy in v3.


>
> The alternative would be to cut the chain at the cap, but then the
> next section starts with an skb whose seq is before @start, and this
> skb would have to be collapsed unconditionally (even if not bloated,
> even if patch 4 says the result is not smaller) to keep the rbtree
> ordered. This also means @released could be negative in patch 6.
> This looks more fragile to me.
>
> Related to this: in patch 4, when the second loop breaks on
> !tcp_skb_can_collapse_rx() (or SYN/FIN, unreadable frags) with an
> overlapping @n in the rbtree, @n can stay in the tree and the last
> nskb of the previous section is inserted after it, with a smaller
> end_seq. To be fair, the current code has the same issue (goto end
> in the copy loop), but since you are making the ordering explicit
> in patch 3, it would be nice to cover it: the same "skip the
> section" logic could be used when the loop stops on an overlapping
> skb that can not be collapsed.
>
> Whatever option you choose, please add a comment next to
> TCP_COLLAPSE_MAX_TOTAL_SIZE describing what it bounds and its
> exceptions.

Will fix that and add a comment as it's a hard limit for
multiple skbs.

Thank you !

---
pw-bot: cr
