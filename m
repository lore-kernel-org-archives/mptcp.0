Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795118581;
	b=TAEVNVNZdQJ6XR6uAEFRO7gNkeTWldGVxzaiiQ+I/z9wb7Yj3x0S2ZJMZj5gcxnjjggD
	 9M95dn164quoY0toadKYzqxC6sBR/G+VTUSaOsRDH8n1Qsx9rueKVQ0N88QoqAG5VHf78
	 hUEBOVQ8PhCRx4noBrbqmBQWkGTfyiPz3bas1x1/RCrWBCPMPRx8YSbzjCvOCQnPha4wW
	 6RL9sC9yr+/SXGsficCT8/Pchy8iHLI//Qs/U816B99MQQjauWqJgcc5Im7w7NavmtZbY
	 y2WbWAL1JkOvLSj0i2Q+yZIldrSm51linClYsTt5aWV37+qU9WzxsDduEzvrExZXn4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795118581;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=Rr0Z5WvcKf5NSVmC1WPGt7a3UvHYdwGXeBU+EHjgpEE=;
	b=ZKKvIDyC5LQmOC2zgDwv1ZOthJVEcWMXWOUBv5HcmMvNIOkfCaI9tq219dqOHA7MhNav
	 cNoWsNmAMsRMH0gikLrZX2gHLUKtcmqL7xKdWl44trhZky7FZMpmYbFCAqg1a0yb3d7uE
	 V5p5tC5AaoKWcVbJFgtPzd593c9NI2LORDTVnfAJYS/BV45D4OxO1LqmV0NfiTrxTt+FO
	 Vp7k8ZdoFx4r5ghaFeB9VNNj9cNtxaIVg9OOJXe+OZLj/nMorLzf+3Epm3KEmYS3toy18
	 lKmocP0iFmr/gSmPs9+GWwAHyktzoQ0PlrREnl1bZm5acuZnosQlQMayFLjL1yEbQhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=P2hvhlnq;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBDD606A326
	for <mptcp@lists.linux.dev>; Thu, 19 Nov 2026 20:03:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EBDD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=P2hvhlnq
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e94f72fb9fso1016265ad.1
        for <mptcp@lists.linux.dev>; Thu, 19 Nov 2026 12:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795118580; x=1795723380; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Rr0Z5WvcKf5NSVmC1WPGt7a3UvHYdwGXeBU+EHjgpEE=;
        b=P2hvhlnqO1+mTy0toKtVku83w3ufz5Tism+HirpH+w6ESMZLsaoL2gzUDQ2XCmPeNM
         i5Jxop3MG2gJh8YkOhglHs6wp+g8iPX1mCFVwMN/SiH7EcutojjYc6z6BojFkcTFo8LY
         t+Q+QH7DXP82aGB3dBXGri90yTPR6JMSR0vLx1MZYPHR5GDi9lJ6eoHL59V3sCFnEjae
         oFXP3RIuA7LStxyzvBiCuyzlPiPMIVv7mhtSjrQ6b/Dy9VX3kss8Yhhq58Qshz4sn3Yi
         RiOvVFYzsfOTluNzpUVeqYbyEjb4Y6/he0fWjEb0Te5QT/AHyjBlddeeU7kDNg3FQ3IA
         Ltew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795118580; x=1795723380;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rr0Z5WvcKf5NSVmC1WPGt7a3UvHYdwGXeBU+EHjgpEE=;
        b=Epmnfn6XfalRY52dNNugKkODkg0eUhMQyZS+H8Dw8CkZp3kWZurP/yDY+Ura/QWZON
         sUqsCmMfJEMmwY6Mx/vhPGi9+TVLCmeyQM0XGlFnpJxNR/70fbfEByu693vx+/CxNfPV
         G1MwHqZN4zKPC7ZkImy8bIAWjL4rgLpFi9r1vgoFtKXBEy+aAQa/IAxFfPSrS99ux6jz
         awfGy9BU6MpqeyofipOKocCzbIJMwZoF3bQEdzwRqXOFWiJl2pag9Z+Q/dvwoWVVivMB
         /Vj3t1IswMsAjNy7hHlOhmpxaznojorfI2WQhkQ2BxcaJGkplCQsLxs7B8Sln/SHVp4P
         swKg==
X-Forwarded-Encrypted: i=1; AL+hErGWq/8ugA8pYASpe3lGn2PGYQa/BWeuGO0js/5v/86M2iPT7EcoaRFLP7wo8bNpwPfcAMCHWA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/h2LPoGnhBh+lxm/5VfItRK4ng6lSOU2YBhckiC/Iruu6nyuD7
	3TNSiQ8tgm3H7siPVx95O4Cz8TodHEdzyCDREup9dYgcdmqhJLXiKqKMGADr3xqUdMNRk8MZ4Op
	lz4GyVg==
X-Received: from plbja3.prod.google.com ([2002:a17:902:efc3:b0:2e1:326b:da73])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:b4b:b0:2ef:f51c:7b09
 with SMTP id d9443c01a7336-2f03f19075bmr8876235ad.28.1795118579760; Thu, 19
 Nov 2026 12:02:59 -0800 (PST)
Date: Thu, 19 Nov 2026 20:02:59 +0000
In-Reply-To: <CAL4WiioNduj1AybypLPDs6HuW2F9Y9zw3B2ycLSogRMnfzBk9g@mail.gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261119071649.374106-1-kuniyu@google.com> <20261119071649.374106-6-kuniyu@google.com>
 <CAL4WiioNduj1AybypLPDs6HuW2F9Y9zw3B2ycLSogRMnfzBk9g@mail.gmail.com>
Message-ID: <av9U9w4wGpO7HmDY@google.com>
Subject: Re: [PATCH v3 net-next 5/7] tcp: Allocate all new skb before collapsing.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: Neal Cardwell <ncardwell@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Nov 2026 08:44:54 +0100, Eric Dumazet wrote:
> Le jeu. 19 nov. 2026 =C3=A0 08:17, Kuniyuki Iwashima <kuniyu@google.com> =
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
> > so the section size is capped at TCP_COLLAPSE_MAX_TOTAL_SIZE
> > (16 skbs), except for the first single skb.
> >
> > Once the size exceeds the limit, the remaining skbs are
> > re-evaluated from restart:.
> >
> > Legitimate overlaps (retransmits with a different segmentation)
> > only involve a few skbs, so if an overlapping OOO chain reaches
> > the limit, we simply skip it.
> >
> > Note that the next skb can be skipped if its density already meets
> > tp->scaling_ratio, and each cut adds at most one remainder skb
> > (~3.4% worst-case truesize overhead on 4 KiB pages), which is a
> > small tradeoff to bound the temporary allocation.
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> > v3: Make TCP_COLLAPSE_MAX_TOTAL_SIZE hard-limit for multiple skbs
> > ---
> >  net/ipv4/tcp_input.c | 41 ++++++++++++++++++++++++++++++++---------
> >  1 file changed, 32 insertions(+), 9 deletions(-)
> >
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index 27ed9ba11ec9..990e34896373 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -5822,6 +5822,11 @@ static struct sk_buff *tcp_skb_next(struct sk_bu=
ff *skb, struct sk_buff_head *li
> >  #define TCP_COLLAPSE_SCALING_RATIO                             \
> >         ((TCP_COLLAPSE_MAX_SIZE << TCP_RMEM_TO_WIN_SCALE) /     \
> >          (SKB_TRUESIZE(TCP_COLLAPSE_MAX_SIZE)))
> > +/* Cap pool preallocation per sub-range to at most 16 skbs in seq
> > + * space.  A single first skb exceeding this is still collapsed,
> > + * whereas an exceeding overlapping ofo range is skipped.
> > + */
> > +#define TCP_COLLAPSE_MAX_TOTAL_SIZE (TCP_COLLAPSE_MAX_SIZE * 16)
> >
> >  static bool tcp_collapse_skb_bloated(const struct sk_buff *skb,
> >                                      u32 start, u8 scaling_ratio)
> > @@ -5862,8 +5867,9 @@ tcp_collapse(struct sock *sk, struct sk_buff_head=
 *list, struct rb_root *root,
> >  {
> >         unsigned int old_truesize, new_truesize;
> >         struct sk_buff *skb =3D head, *n;
> > -       struct sk_buff_head tmp;
> > +       struct sk_buff_head tmp, pool;
> >         int remainder, nskbs;
> > +       struct sk_buff *nskb;
> >         u8 scaling_ratio;
> >         u32 sub_end;
> >
> > @@ -5871,6 +5877,7 @@ tcp_collapse(struct sock *sk, struct sk_buff_head=
 *list, struct rb_root *root,
> >                             TCP_COLLAPSE_SCALING_RATIO);
> >
> >         __skb_queue_head_init(&tmp);
> > +       __skb_queue_head_init(&pool);
> >
> >         /* First, check that queue is collapsible and find
> >          * the point where collapsing can be useful.
> > @@ -5926,8 +5933,9 @@ tcp_collapse(struct sock *sk, struct sk_buff_head=
 *list, struct rb_root *root,
> >                 }
> >
> >                 if (!overlap &&
> > -                   !tcp_collapse_skb_bloated(n, sub_end,
> > -                                             TCP_COLLAPSE_SCALING_RATI=
O))
> > +                   (TCP_SKB_CB(n)->end_seq - start >=3D TCP_COLLAPSE_M=
AX_TOTAL_SIZE ||
> > +                    !tcp_collapse_skb_bloated(n, sub_end,
> > +                                              TCP_COLLAPSE_SCALING_RAT=
IO)))
> >                         break;
> >
> >                 sub_end =3D TCP_SKB_CB(n)->end_seq;
> > @@ -5935,25 +5943,38 @@ tcp_collapse(struct sock *sk, struct sk_buff_he=
ad *list, struct rb_root *root,
> >                 n =3D tcp_skb_next(n, list);
> >         }
> >
> > +       if (sub_end !=3D TCP_SKB_CB(skb)->end_seq &&
> > +           sub_end - start >=3D TCP_COLLAPSE_MAX_TOTAL_SIZE)
> > +               goto skip;
>=20
> This is fine for now, but note that a single 64K GRO skb overlapping
> a bloated skb is enough to reach the limit, and the bloated skb is
> then never collapsed. The range is walked again at every
> tcp_collapse_ofo_queue() call, for no gain.
>=20
> A possible followup would be to cut the range instead of skipping it.
>=20
> When @n overlaps and we do not want (or can not) merge it, we know
> that @n already contains [TCP_SKB_CB(n)->seq, sub_end), because
> skbs with end_seq <=3D sub_end were removed earlier in the loop.
>=20
> So we could do :
>=20
>         sub_end =3D TCP_SKB_CB(n)->seq;
>=20
> and collapse [start, sub_end) only, as long as sub_end is after start.
>=20
> All new skbs would then have a seq smaller than TCP_SKB_CB(n)->seq,
> so the rbtree ordering is preserved, and we would not need to drag
> @n into the range.
>=20
> After the copy, the skbs of the range that were not fully consumed
> would have to be freed, since the rest of their payload is in @n.
>=20
> The same trick would also work for the unmergeable overlapping skb
> case added in patch 3.
>=20
> I have not tested this, and this can be done later.

Ah, this sounds good too, I'll follow up after your frag series.

Thank you !
