Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA79747781
	for <mptcp@lists.linux.dev>; Fri, 19 Apr 2024 07:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713512669; cv=none; b=ljR1P9tCzoDxVKXw/Fjrgr49KTIgOM/YiUVzBfsz+1abjMQaecXgOfv7fdqVlhvk2up/3WofYHv4GSb5M65vSej8PBBOQ3hhOSYTwrlVKUzgrR18dHazlxzjWmigqlvemrlGHSzBPpTHs3o5Oex98wZZ8HBqgEq9y4w3IaR7ZXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713512669; c=relaxed/simple;
	bh=e/DvZWvOjb0JOnalFfM70R734OGAUWjKB9RnZANnd3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hLLuANsc+6WFEfoZf281q9sC+soVXw60mCZabQwKm5OeHtGKaFYHblxZeAWAsSSN4bNMHUfvu42IWAm1RkFKJda8ow1OmxERNWzcXH5TEfA5gX+QIHCn2mMIievv1qscHZwB1UBtk0/zf1BtBo7NzlnVjra7eLWRcHH2k+vj8jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lx1gJoi2; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lx1gJoi2"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-418820e6effso36445e9.0
        for <mptcp@lists.linux.dev>; Fri, 19 Apr 2024 00:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713512665; x=1714117465; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASrRKKlJfjvhALvh+lswlaFCRhW8Q2YKgf0CCEi8m40=;
        b=Lx1gJoi2E75sKnK5WFCHeoh7+ncxQLdrUgsmKqt70ILvmZvo6XgmwPyAmmrmQPKveP
         6jj3WjsIjmI/X7eRjdQqMBN1tA3Yh6xFFUzDHyPo2AOj8aEX6LiIjEhVO1N2LNNikcX1
         STc1hMK7DAq1uiRfXKaIa3invxo2wDeoatLEO01iakwsygh1EYF7ZrPPeG1FnUCKtSUI
         2GJ/+wP6PWEKVYoj+T+sbyhde106VlcykGhjKe/ULc/9uF/hRdbZ5gK2k4yrrjJY+5Zj
         dbWHdOkaVU4KOJ4xujGWbhsbYD4niWMBMJ1eqZ7x2rICl4ctGMHWwOBU9LYdLfOXVrtl
         /aUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713512665; x=1714117465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ASrRKKlJfjvhALvh+lswlaFCRhW8Q2YKgf0CCEi8m40=;
        b=nbIz5/yv5G+x0VKexDwFuorAHTQD8BvbvRw+ik5Dcnahe3UI2E6VjS3DCOD5puZeQC
         IogluH1HetWiNvLYIgHrQS8vHj0GwbxkTrOCpZecQqdrY7lKxCkQb4Xsvn3tUiswo3Rd
         dMxTfYSjaf+yB8tzxqHOg9n8OriL40EX3KYFGYH9My79UoDCCCQhSjNV6CvtMj04a3y9
         02MrrojsibO1rHbg8S4FqEokTTON5whUZZDKkSqce+WEogbNTN/f9yX2SKjGscKrv2sS
         rL33zkUic9WY+o5FSMX5vsOuP2Sp7h/rezVWnIp7GUr63uPCvtjsfUE/3+3oVv16dWGH
         l/uA==
X-Forwarded-Encrypted: i=1; AJvYcCUzGJr3SpaNe8NARcj/rsZsm405woEFrqo7gz4+1FB4cpDqT1xf9Ut8sD2DIpSrovytHsLPzjiWddV4H+RXhBn8coZfE2w=
X-Gm-Message-State: AOJu0Yyhwb6o3RU3lAmQVuo8WfVMwkDQlMVj+XAltqU4V4gSeTjLGc+w
	D5+IHEW82xsmcE2VOvyxEhErauuPydep7c6vdJZBe7wkp/ZkIkvSTSd0yLDv+OY0rdv4KSzdzUC
	L2xTH2xW02DUVWBcNtYWB7H5bWA75Z8RZkOpT
X-Google-Smtp-Source: AGHT+IHHazdTlBrY4//nCbRr1Okkrz7QudXZ58oKgYKMNTpOAzqru6/aok2jfl8sNpR3NG/RLlGTWppMTDqpyh1IpXQ=
X-Received: by 2002:a05:600c:1c09:b0:418:97c6:188d with SMTP id
 j9-20020a05600c1c0900b0041897c6188dmr95526wms.7.1713512664820; Fri, 19 Apr
 2024 00:44:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240417085143.69578-1-kerneljasonxing@gmail.com>
 <CAL+tcoDJZe9pxjmVfgnq8z_sp6Zqe-jhWqoRnyuNwKXuPLGzVQ@mail.gmail.com>
 <20240418084646.68713c42@kernel.org> <CAL+tcoD4hyfBz4LrOOh6q6OO=6G7zpdXBQgR2k4rH3FwXsY3XA@mail.gmail.com>
 <CANn89iJ4pW7OFQ59RRHMimdYdN9PZ=D+vEq0je877s0ijH=xeg@mail.gmail.com>
 <CAL+tcoBV77KmL8_d1PTk8muA6Gg3hPYb99BpAXD9W1RcFsg7Bw@mail.gmail.com>
 <CAL+tcoAEN-OQeqn3m3zLGUiPZEaoTjz0WHaNL-xm702aot_m-g@mail.gmail.com>
 <CANn89iL9OzD5+Y56F_8Jqyxwa5eDQPaPjhX9Y-Y_b9+bcQE08Q@mail.gmail.com> <CAL+tcoBn8RHm8AbwMBJ6FM6PMLLotCwTxSgPS1ABd-_D7uBSxw@mail.gmail.com>
In-Reply-To: <CAL+tcoBn8RHm8AbwMBJ6FM6PMLLotCwTxSgPS1ABd-_D7uBSxw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 19 Apr 2024 09:44:13 +0200
Message-ID: <CANn89iJ4a5VE-_AV-wVrh9Zpu0yS=jtwJaR_s2cBX7pP_QGQXQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 0/7] Implement reset reason mechanism to detect
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, dsahern@kernel.org, matttbe@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, atenart@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 9:29=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Fri, Apr 19, 2024 at 3:02=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Fri, Apr 19, 2024 at 4:31=E2=80=AFAM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > On Fri, Apr 19, 2024 at 7:26=E2=80=AFAM Jason Xing <kerneljasonxing@g=
mail.com> wrote:
> > > >
> > > > > When I said "If you feel the need to put them in a special group,=
 this
> > > > > is fine by me.",
> > > > > this was really about partitioning the existing enum into groups,=
 if
> > > > > you prefer having a group of 'RES reasons'
> > > >
> > > > Are you suggesting copying what we need from enum skb_drop_reason{}=
 to
> > > > enum sk_rst_reason{}? Why not reusing them directly. I have no idea
> > > > what the side effect of cast conversion itself is?
> > >
> > > Sorry that I'm writing this email. I'm worried my statement is not
> > > that clear, so I write one simple snippet which can help me explain
> > > well :)
> > >
> > > Allow me give NO_SOCKET as an example:
> > > diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> > > index e63a3bf99617..2c9f7364de45 100644
> > > --- a/net/ipv4/icmp.c
> > > +++ b/net/ipv4/icmp.c
> > > @@ -767,6 +767,7 @@ void __icmp_send(struct sk_buff *skb_in, int type=
,
> > > int code, __be32 info,
> > >         if (!fl4.saddr)
> > >                 fl4.saddr =3D htonl(INADDR_DUMMY);
> > >
> > > +       trace_icmp_send(skb_in, type, code);
> > >         icmp_push_reply(sk, &icmp_param, &fl4, &ipc, &rt);
> > >  ende:
> > >         ip_rt_put(rt);
> > > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > > index 1e650ec71d2f..d5963831280f 100644
> > > --- a/net/ipv4/tcp_ipv4.c
> > > +++ b/net/ipv4/tcp_ipv4.c
> > > @@ -2160,6 +2160,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
> > >  {
> > >         struct net *net =3D dev_net(skb->dev);
> > >         enum skb_drop_reason drop_reason;
> > > +       enum sk_rst_reason rst_reason;
> > >         int sdif =3D inet_sdif(skb);
> > >         int dif =3D inet_iif(skb);
> > >         const struct iphdr *iph;
> > > @@ -2355,7 +2356,8 @@ int tcp_v4_rcv(struct sk_buff *skb)
> > >  bad_packet:
> > >                 __TCP_INC_STATS(net, TCP_MIB_INERRS);
> > >         } else {
> > > -               tcp_v4_send_reset(NULL, skb);
> > > +               rst_reason =3D RST_REASON_NO_SOCKET;
> > > +               tcp_v4_send_reset(NULL, skb, rst_reason);
> > >         }
> > >
> > >  discard_it:
> > >
> > > As you can see, we need to add a new 'rst_reason' variable which
> > > actually is the same as drop reason. They are the same except for the
> > > enum type... Such rst_reasons/drop_reasons are all over the place.
> > >
> > > Eric, if you have a strong preference, I can do it as you said.
> > >
> > > Well, how about explicitly casting them like this based on the curren=
t
> > > series. It looks better and clearer and more helpful to people who is
> > > reading codes to understand:
> > > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > > index 461b4d2b7cfe..eb125163d819 100644
> > > --- a/net/ipv4/tcp_ipv4.c
> > > +++ b/net/ipv4/tcp_ipv4.c
> > > @@ -1936,7 +1936,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_bu=
ff *skb)
> > >         return 0;
> > >
> > >  reset:
> > > -       tcp_v4_send_reset(rsk, skb, (u32)reason);
> > > +       tcp_v4_send_reset(rsk, skb, (enum sk_rst_reason)reason);
> > >  discard:
> > >         kfree_skb_reason(skb, reason);
> > >         /* Be careful here. If this function gets more complicated an=
d
> >
> > It makes no sense to declare an enum sk_rst_reason and then convert it
> > to drop_reason
> > or vice versa.
> >
> > Next thing you know, compiler guys will add a new -Woption that will
> > forbid such conversions.
> >
> > Please add to tcp_v4_send_reset() an skb_drop_reason, not a new enum.
>
> Ah... It looks like I didn't make myself clear again. Sorry...
> Actually I wrote this part many times. My conclusion is that It's not
> feasible to do this.
>
> REASONS:
> If we __only__ need to deal with this passive reset in TCP, it's fine.
> We pass a skb_drop_reason which should also be converted to u32 type
> in tcp_v4_send_reset() as you said, it can work. People who use the
> trace will see the reason with the 'SKB_DROP_REASON' prefix stripped.
>
> But we have to deal with other cases. A few questions are listed here:
> 1) What about tcp_send_active_reset() in TCP/MPTCP? Passing weird drop
> reasons? There is no drop reason at all. I think people will get
> confused. So I believe we should invent new definitions to cope with
> it.
> 2) What about the .send_reset callback in the subflow_syn_recv_sock()
> in MPTCP? The reasons in MPTCP are only definitions (such as
> MPTCP_RST_EUNSPEC). I don't think we can convert them into the enum
> skb_drop_reason type.
>
> So where should we group those various reasons?
>
> Introducing a new enum is for extension and compatibility for all
> kinds of reset reasons.
>
> What do you think?

I will stop repeating myself.

enums are not what you think.

type safety is there for a reason.

Can you show me another place in networking stacks where we cast enums
to others ?
