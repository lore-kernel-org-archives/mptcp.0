Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA721DFF0
	for <mptcp@lists.linux.dev>; Tue, 16 Apr 2024 12:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713270312; cv=none; b=VP5SjaWjOF+rCh0/t/Y/GO7qsEq1GGxRO9PNN1j+dqgKA7jtZE6IvyQe/XkEanI+YgVdRIFqQw5sPjn+8MGCZL2IU3w14F3dksqodmgolKip5Gp3KZc+2ESV9iOpDjAT73VL5eJxwm541yW0a87zON6/pzqEk1DSxkQgXxZ2FR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713270312; c=relaxed/simple;
	bh=A3I3UnEi4Jj6XEGZVoebUIPjEFSfASUBccQUwXzsHM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A98tvYGAj+OXQCvrJEnACbVnnTGgEEwbZYysii4i8nWWGpQFn/ismgzsINLxIgf6buqeao6UvI+xO7SPUin5tOzQZkEsvFzmKOpGHtEaVm7FyAMI4L10jsbLeApKbKV96wBW/Z7FHxLidjkXxdL1PIgI8zs5Cyv/olcD/6oGlUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EA7vzYQP; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EA7vzYQP"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a54176639ecso216418666b.0
        for <mptcp@lists.linux.dev>; Tue, 16 Apr 2024 05:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713270309; x=1713875109; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Iqz3uYB03cZmo9aNBvR/ZOxNMywrtwP/4mJcGIIpN4=;
        b=EA7vzYQP1F2RyvY02cPWD3hGsT3MPQbG/nvCBCKZqJ+OOVuHGtKengAYC2KZhvNH9C
         /whQNA8hhuEhuS7qrC4QTkBVRAzZuTRkg0IeHGZzI2jFDofZQ3GpW0x73A6V+jEfecao
         Qd1+ZSuWjYGVUhudGMwooY/CPUy4MCmIVpXcBuHntBFWWSYQrQ3eWo0PjRr0qtrzNUew
         lJ0PPnEr5H6Zpb8A5pCCwdN1K2mXc0DKdVEvSwEpluQ98AVvvoQH+gg5jJArFJ/y1wVV
         v9Mr2cMvfedPLHJRH18ttxZVm3u6/lf5Fu7Mok5nyLkejTht89osnF0VcK4L0tCrp2rS
         t0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713270309; x=1713875109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Iqz3uYB03cZmo9aNBvR/ZOxNMywrtwP/4mJcGIIpN4=;
        b=cZD2M04sIl+xTCx5hV9A+ANkSz6l/KETXIVYImGR11KEeBuLHpF/8OdPXY3t/qcdla
         xZjh2JRHA4j1cd0gx3s/K7TTzyxeC5PQ3qJGL/YwDv+iiqOC0hQafSLfBIYttuKXH/FC
         DHr7MP1KlDSzrQzrqOL3DV6wp+v5ERYaO59IUSi6vuM3ZU6u5I5oOPvqU5NC2QgkuXgx
         Z5GV/P5WEwa1rB28slTqH6PhkzrOCHQR5JwwC7U7Qpsg9TCGQXvMVNL1+ZbxKzTUgJ1S
         HVOr6fBomc1mNoF4rc5XG7wF2IhcgUyE6jXXjzK6mWSpoFMqfz+Jo/pY+uPRSh4UmlaG
         1iBQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5PRBZY3dUJZXR5ZgvESZkE7CfbBnTev2Fb9o15pOcmzLnIbxNFreJX7j8oMfh/GneqYPuvjoRx0okD3irnbGD2mDmJkg=
X-Gm-Message-State: AOJu0YzCCJ+TjQF/Q1WjlDwhgWoSx3pP0hbWMrKnQdpvFYXllyZd3UgO
	/UHEE7tZgCEKXV039QKWV9y3t4Lip0GhmYAE7Ko9QNhuFl89RKE/IVmNpYqhUl1UBnFjjtvSr45
	n0BIKiX/wIlvY2cQ27eR3pfbYyCY=
X-Google-Smtp-Source: AGHT+IFAlHbB8sWqNMPSyWvDGwR8gagW+jfhM7hArqhN/K9UaYFyybAhAdOI1y0UHIcKye+RvecL9GUppbL71gD+27k=
X-Received: by 2002:a17:907:9717:b0:a51:c88e:e95a with SMTP id
 jg23-20020a170907971700b00a51c88ee95amr9550001ejc.23.1713270308559; Tue, 16
 Apr 2024 05:25:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240411115630.38420-1-kerneljasonxing@gmail.com>
 <20240411115630.38420-5-kerneljasonxing@gmail.com> <CANn89iKbBuEqsjyJ-di3e-cF1zv000YY1HEeYq-Ah5x7nX5ppg@mail.gmail.com>
 <CAL+tcoB=Hr8s+j7Sm8viF-=3aHwhEevZZcpn5ek0RYmNowAtoQ@mail.gmail.com>
In-Reply-To: <CAL+tcoB=Hr8s+j7Sm8viF-=3aHwhEevZZcpn5ek0RYmNowAtoQ@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 16 Apr 2024 20:24:31 +0800
Message-ID: <CAL+tcoDVFtvg6+Kio9frU5W=2e2n7qrCJkitXUxNjsouAG+iGg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 4/6] tcp: support rstreason for passive reset
To: Eric Dumazet <edumazet@google.com>
Cc: dsahern@kernel.org, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	atenart@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 3:45=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Tue, Apr 16, 2024 at 2:34=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Thu, Apr 11, 2024 at 1:57=E2=80=AFPM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > Reuse the dropreason logic to show the exact reason of tcp reset,
> > > so we don't need to implement those duplicated reset reasons.
> > > This patch replaces all the prior NOT_SPECIFIED reasons.
> > >
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > >  net/ipv4/tcp_ipv4.c | 8 ++++----
> > >  net/ipv6/tcp_ipv6.c | 8 ++++----
> > >  2 files changed, 8 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > > index 441134aebc51..863397c2a47b 100644
> > > --- a/net/ipv4/tcp_ipv4.c
> > > +++ b/net/ipv4/tcp_ipv4.c
> > > @@ -1935,7 +1935,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_bu=
ff *skb)
> > >         return 0;
> > >
> > >  reset:
> > > -       tcp_v4_send_reset(rsk, skb, SK_RST_REASON_NOT_SPECIFIED);
> > > +       tcp_v4_send_reset(rsk, skb, (u32)reason);
> > >  discard:
> > >         kfree_skb_reason(skb, reason);
> > >         /* Be careful here. If this function gets more complicated an=
d
> > > @@ -2278,7 +2278,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
> > >                 } else {
> > >                         drop_reason =3D tcp_child_process(sk, nsk, sk=
b);
> > >                         if (drop_reason) {
> > > -                               tcp_v4_send_reset(nsk, skb, SK_RST_RE=
ASON_NOT_SPECIFIED);
> > > +                               tcp_v4_send_reset(nsk, skb, (u32)drop=
_reason);
> >
> > Are all these casts really needed ?
>
> Not really. If without, the compiler wouldn't complain about it.

The truth is mptcp CI treats it as an error (see link[1]) when I
submitted the V5 patchset but my machine works well. I wonder whether
I should not remove all the casts or ignore the warnings?

[1]: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/870508471=
7/job/23874718134
net/ipv6/tcp_ipv6.c: In function 'tcp_v6_do_rcv':
4148 net/ipv6/tcp_ipv6.c:1683:36: error: implicit conversion from
'enum skb_drop_reason' to 'enum sk_rst_reason'
[-Werror=3Denum-conversion]
4149 1683 | tcp_v6_send_reset(sk, skb, reason);
4150 | ^~~~~~
4151 net/ipv6/tcp_ipv6.c: In function 'tcp_v6_rcv':
4152 net/ipv6/tcp_ipv6.c:1868:61: error: implicit conversion from
'enum skb_drop_reason' to 'enum sk_rst_reason'
[-Werror=3Denum-conversion]
4153 1868 | tcp_v6_send_reset(nsk, skb, drop_reason);
4154 | ^~~~~~~~~~~
4155 net/ipv6/tcp_ipv6.c:1945:46: error: implicit conversion from
'enum skb_drop_reason' to 'enum sk_rst_reason'
[-Werror=3Denum-conversion]
4156 1945 | tcp_v6_send_reset(NULL, skb, drop_reason);
4157 | ^~~~~~~~~~~
4158 net/ipv6/tcp_ipv6.c:2001:44: error: implicit conversion from
'enum skb_drop_reason' to 'enum sk_rst_reason'
[-Werror=3Denum-conversion]
4159 2001 | tcp_v6_send_reset(sk, skb, drop_reason);

Thanks,
Jason

>
> >
> > enum sk_rst_reason is not the same as u32 anyway ?
>
> I will remove the cast in the next version.
>
> Thanks,
> Jason
>
> >
> >
> >
> > >                                 goto discard_and_relse;
> > >                         }
> > >                         sock_put(sk);
> > > @@ -2356,7 +2356,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
> > >  bad_packet:
> > >                 __TCP_INC_STATS(net, TCP_MIB_INERRS);
> > >         } else {
> > > -               tcp_v4_send_reset(NULL, skb, SK_RST_REASON_NOT_SPECIF=
IED);
> > > +               tcp_v4_send_reset(NULL, skb, (u32)drop_reason);
> > >         }
> > >
> > >  discard_it:
> > > @@ -2407,7 +2407,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
> > >                 tcp_v4_timewait_ack(sk, skb);
> > >                 break;
> > >         case TCP_TW_RST:
> > > -               tcp_v4_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIE=
D);
> > > +               tcp_v4_send_reset(sk, skb, (u32)drop_reason);
> > >                 inet_twsk_deschedule_put(inet_twsk(sk));
> > >                 goto discard_it;
> > >         case TCP_TW_SUCCESS:;
> > > diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> > > index 6cad32430a12..ba9d9ceb7e89 100644
> > > --- a/net/ipv6/tcp_ipv6.c
> > > +++ b/net/ipv6/tcp_ipv6.c
> > > @@ -1678,7 +1678,7 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_bu=
ff *skb)
> > >         return 0;
> > >
> > >  reset:
> > > -       tcp_v6_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
> > > +       tcp_v6_send_reset(sk, skb, (u32)reason);
> > >  discard:
> > >         if (opt_skb)
> > >                 __kfree_skb(opt_skb);
> > > @@ -1864,7 +1864,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct s=
k_buff *skb)
> > >                 } else {
> > >                         drop_reason =3D tcp_child_process(sk, nsk, sk=
b);
> > >                         if (drop_reason) {
> > > -                               tcp_v6_send_reset(nsk, skb, SK_RST_RE=
ASON_NOT_SPECIFIED);
> > > +                               tcp_v6_send_reset(nsk, skb, (u32)drop=
_reason);
> > >                                 goto discard_and_relse;
> > >                         }
> > >                         sock_put(sk);
> > > @@ -1940,7 +1940,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct s=
k_buff *skb)
> > >  bad_packet:
> > >                 __TCP_INC_STATS(net, TCP_MIB_INERRS);
> > >         } else {
> > > -               tcp_v6_send_reset(NULL, skb, SK_RST_REASON_NOT_SPECIF=
IED);
> > > +               tcp_v6_send_reset(NULL, skb, (u32)drop_reason);
> > >         }
> > >
> > >  discard_it:
> > > @@ -1995,7 +1995,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct s=
k_buff *skb)
> > >                 tcp_v6_timewait_ack(sk, skb);
> > >                 break;
> > >         case TCP_TW_RST:
> > > -               tcp_v6_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIE=
D);
> > > +               tcp_v6_send_reset(sk, skb, (u32)drop_reason);
> > >                 inet_twsk_deschedule_put(inet_twsk(sk));
> > >                 goto discard_it;
> > >         case TCP_TW_SUCCESS:
> > > --
> > > 2.37.3
> > >
