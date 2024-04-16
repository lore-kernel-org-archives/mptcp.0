Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BCA84D3E
	for <mptcp@lists.linux.dev>; Tue, 16 Apr 2024 07:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713253548; cv=none; b=kS7IcDKbxdFgyo0431cS1AyrLT9/U8wqgRj4huVNaBeoHCFkBZhaRqGpLxFLrAlYikKtOyBB/4E1t3SPZMmVjohekykMYW36N9vpBKTqZAGmrBMsR/2ZBlWyYMI1I9+AAittDGmWlMHA1zsPiNuq+GQW/BtkS4mx3+/KOr6bJMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713253548; c=relaxed/simple;
	bh=8nRAuIrKSOl83qtuN7TRWMOC/wovzZJSi6qJeS7QCLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S2Qag0SBcBjxTObCQHiiiesvI6zd7py9LKXw2PRBpS/7rBDxs9FXP3NmVbDYmGWZHJVMliqqS4GPuEGeSnOmJgACkxIh8ORMKtoLDL4MOxEY96g390hbpnlbYxxbpxBG87SnKBZ+Kb+VGu3PSrurCE8gTFQ3vVmUEt5FO3zJWfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjbYBcLs; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjbYBcLs"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a519e1b0e2dso509818066b.2
        for <mptcp@lists.linux.dev>; Tue, 16 Apr 2024 00:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713253544; x=1713858344; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fcm+hGflW7P7c6S3jcRl3Quy0llUmt9VHpKg4MTgNSE=;
        b=IjbYBcLsDMBHGES/OrEi92PEvaFVdjrrC07YpAbZ6bvcARJtZQ1jSt7Jy+fM/HxbOL
         evzyTVZesILbKeJhd98HV/8upsuKhBOMm1oazS6gHlvpAP77KlXgSUA8zPnj7Bxm54xh
         /cUhWJn7aW9unvSUMHKyGXT3FFowbG9uhZlv7beNXokKPNx3aiA5ZDyPaPfEp0TCqGon
         vIfMcgiz5BbHKzTjX2pCXdv6DTEwsZo2Uv2zx8BmihGXvq4C2Ou4zuFmnjlikECqc7sN
         clmret2Fd5zr2BxLwT0ek3t8VRKjK69M3Eb9+mE5y5e6x2UFo+PDtV5LQubckzQdjYMW
         uPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713253544; x=1713858344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fcm+hGflW7P7c6S3jcRl3Quy0llUmt9VHpKg4MTgNSE=;
        b=OerlaiuIBNm8Ivo9jw2+4xiQn8P8EyAdwOEodd6nZ4SMZmcbhxSdLSUvA2htuWdt92
         d3jWm6ErZV2zcqrT3B25nYMvdt+3BZL9oI9Z8tYGFKk3WT4bg1xJPdHa9HNEBhBu11xR
         +Dx1NKdv7dZ0h5jWJF2UmilEjCum6nVy0fFBQ5HhlAfuX8EaSejU22ivZRsN6g9GJhiS
         YnUV0brcZWG/ze9+0Xt6ywV/xa35C/HmETJa6ZlPY0NBWkS4DpR1FDioXDU41GuoLUIu
         ldP3PHigjS037OPiBsX8SiBSQbosTucz/Yy4jgGTY64dqT7BuyjZY33S/hrP3WXYiEas
         8utQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7EFQRoZq2HdG9K28gaLBzNZNSYWBIZUF2NT2wOgJ9ZZHjuozkEU0l/GKJSwBaJsER7+hBWxMU+U9P8CATcQz6s3doJmo=
X-Gm-Message-State: AOJu0YzCApXCEcm7nJMwiIVsjgmH3efGEkafwfiLkhUzsKh9dtvflyA9
	GG7sc3jalLUGkI8ktVgv/UfAhdw3EclEGiuYz1rsDkKeEsD4/oBj/b3MbYa1lMn16aLT2+8X5EQ
	QyhM+FJ0roQz8wutwizInb9WjLq0=
X-Google-Smtp-Source: AGHT+IGaA+ZZ0vH/lYCVaf/SBD34nHVf9zgOXEElCTOIYt/mpiSObBH5PQ3ClsEbElAzf2j8H4R20zL7r08v1SerkjI=
X-Received: by 2002:a17:906:5959:b0:a54:e183:6248 with SMTP id
 g25-20020a170906595900b00a54e1836248mr2680885ejr.0.1713253544133; Tue, 16 Apr
 2024 00:45:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240411115630.38420-1-kerneljasonxing@gmail.com>
 <20240411115630.38420-5-kerneljasonxing@gmail.com> <CANn89iKbBuEqsjyJ-di3e-cF1zv000YY1HEeYq-Ah5x7nX5ppg@mail.gmail.com>
In-Reply-To: <CANn89iKbBuEqsjyJ-di3e-cF1zv000YY1HEeYq-Ah5x7nX5ppg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 16 Apr 2024 15:45:07 +0800
Message-ID: <CAL+tcoB=Hr8s+j7Sm8viF-=3aHwhEevZZcpn5ek0RYmNowAtoQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 4/6] tcp: support rstreason for passive reset
To: Eric Dumazet <edumazet@google.com>
Cc: dsahern@kernel.org, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	atenart@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 2:34=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Apr 11, 2024 at 1:57=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Reuse the dropreason logic to show the exact reason of tcp reset,
> > so we don't need to implement those duplicated reset reasons.
> > This patch replaces all the prior NOT_SPECIFIED reasons.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  net/ipv4/tcp_ipv4.c | 8 ++++----
> >  net/ipv6/tcp_ipv6.c | 8 ++++----
> >  2 files changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > index 441134aebc51..863397c2a47b 100644
> > --- a/net/ipv4/tcp_ipv4.c
> > +++ b/net/ipv4/tcp_ipv4.c
> > @@ -1935,7 +1935,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff=
 *skb)
> >         return 0;
> >
> >  reset:
> > -       tcp_v4_send_reset(rsk, skb, SK_RST_REASON_NOT_SPECIFIED);
> > +       tcp_v4_send_reset(rsk, skb, (u32)reason);
> >  discard:
> >         kfree_skb_reason(skb, reason);
> >         /* Be careful here. If this function gets more complicated and
> > @@ -2278,7 +2278,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
> >                 } else {
> >                         drop_reason =3D tcp_child_process(sk, nsk, skb)=
;
> >                         if (drop_reason) {
> > -                               tcp_v4_send_reset(nsk, skb, SK_RST_REAS=
ON_NOT_SPECIFIED);
> > +                               tcp_v4_send_reset(nsk, skb, (u32)drop_r=
eason);
>
> Are all these casts really needed ?

Not really. If without, the compiler wouldn't complain about it.

>
> enum sk_rst_reason is not the same as u32 anyway ?

I will remove the cast in the next version.

Thanks,
Jason

>
>
>
> >                                 goto discard_and_relse;
> >                         }
> >                         sock_put(sk);
> > @@ -2356,7 +2356,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
> >  bad_packet:
> >                 __TCP_INC_STATS(net, TCP_MIB_INERRS);
> >         } else {
> > -               tcp_v4_send_reset(NULL, skb, SK_RST_REASON_NOT_SPECIFIE=
D);
> > +               tcp_v4_send_reset(NULL, skb, (u32)drop_reason);
> >         }
> >
> >  discard_it:
> > @@ -2407,7 +2407,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
> >                 tcp_v4_timewait_ack(sk, skb);
> >                 break;
> >         case TCP_TW_RST:
> > -               tcp_v4_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED)=
;
> > +               tcp_v4_send_reset(sk, skb, (u32)drop_reason);
> >                 inet_twsk_deschedule_put(inet_twsk(sk));
> >                 goto discard_it;
> >         case TCP_TW_SUCCESS:;
> > diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> > index 6cad32430a12..ba9d9ceb7e89 100644
> > --- a/net/ipv6/tcp_ipv6.c
> > +++ b/net/ipv6/tcp_ipv6.c
> > @@ -1678,7 +1678,7 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff=
 *skb)
> >         return 0;
> >
> >  reset:
> > -       tcp_v6_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
> > +       tcp_v6_send_reset(sk, skb, (u32)reason);
> >  discard:
> >         if (opt_skb)
> >                 __kfree_skb(opt_skb);
> > @@ -1864,7 +1864,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_=
buff *skb)
> >                 } else {
> >                         drop_reason =3D tcp_child_process(sk, nsk, skb)=
;
> >                         if (drop_reason) {
> > -                               tcp_v6_send_reset(nsk, skb, SK_RST_REAS=
ON_NOT_SPECIFIED);
> > +                               tcp_v6_send_reset(nsk, skb, (u32)drop_r=
eason);
> >                                 goto discard_and_relse;
> >                         }
> >                         sock_put(sk);
> > @@ -1940,7 +1940,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_=
buff *skb)
> >  bad_packet:
> >                 __TCP_INC_STATS(net, TCP_MIB_INERRS);
> >         } else {
> > -               tcp_v6_send_reset(NULL, skb, SK_RST_REASON_NOT_SPECIFIE=
D);
> > +               tcp_v6_send_reset(NULL, skb, (u32)drop_reason);
> >         }
> >
> >  discard_it:
> > @@ -1995,7 +1995,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_=
buff *skb)
> >                 tcp_v6_timewait_ack(sk, skb);
> >                 break;
> >         case TCP_TW_RST:
> > -               tcp_v6_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED)=
;
> > +               tcp_v6_send_reset(sk, skb, (u32)drop_reason);
> >                 inet_twsk_deschedule_put(inet_twsk(sk));
> >                 goto discard_it;
> >         case TCP_TW_SUCCESS:
> > --
> > 2.37.3
> >
