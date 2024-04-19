Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A0B53372
	for <mptcp@lists.linux.dev>; Fri, 19 Apr 2024 08:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713514001; cv=none; b=LB9hLeHUy+l3t6CxoPdxKwkzfputVwATz6dFhAgavyNQWvzsKhQ6rSy91tTfvNqN9ToVxkRAXILQTaTvzfjbAUyFE2U74epDo9XV3ygD0zm292XBfP2xq9dIAGCmIR+I3T3ez+/F6XC350buzv24jJ+ustqddNSaCXOCnGaziy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713514001; c=relaxed/simple;
	bh=XTwnfm/sqlaZlJxN/MVFbKE3NWBojOwpSvveKtQy2Zs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f42TQ4KAywuQvG1m1zWI3uMR6wxUYt8N9cGausRMaWxw5buCpLznSfiaxaTwuBXWj1MSZH0t02y281Q2M8sdydGl/O5DV1qYmLd8OCNwrskAaHee4kFA6Sg3K0qgHS06k7BgxNSK0Sal0H2rzGCC01dX7iPvQkCfneZSGuYoajg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3zkhGtA; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3zkhGtA"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a52582ecde4so158440966b.0
        for <mptcp@lists.linux.dev>; Fri, 19 Apr 2024 01:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713513998; x=1714118798; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpH8yxR1dAAX8kI+0z0hIiJFPsZI7NQtWK4IOvFZ1C4=;
        b=Y3zkhGtAVgg6zRYATWWi7N+JE4LjxjuUp8sKlUYiz+UEZqJFoA/RWWf9FVpUTWToA9
         oRLQ6+TE9fcDkzI832rn3M+6dOS9Irx+cX6f1ub1Z6yJnzFuj1urZ3PrqYoPP+fR52Wz
         KHbr5NBsnqKMMZ5U6bnZW5WoIiZVcVW8yCsDjjyexdGA+L5SqWn5AXtACPuT7TWxnM9t
         6OMNW/RtwDwEphCz4yoZJmCFcn+Svfbn4UzwfKFWuM69Ci1o/ZATnmro5m+eA321KqBI
         6dox/fOxuxSvPvFoFYHZctnAuB14q83Xxf5VuQfgzF6sAu3n2gMD0iHZboCSPzVkiPA+
         T7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713513998; x=1714118798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hpH8yxR1dAAX8kI+0z0hIiJFPsZI7NQtWK4IOvFZ1C4=;
        b=rvXV4Efbay1x+wzy/+9CyXRmsVO7MA0O4A041PCVDlIntH3N0Qhs9GJrBmsFtFl+jg
         HqHdMV0X8kQY0BIVqHxCc3+elAdTq7Lfc52vgk865kiAbp+0aLhQumA2fhkfPaZJ1fUy
         qzX8Hm2/Zuq1Q4Mt7xxJdQ38D609+7civNpCeus2Q7MD/UYhYhW5FNYcvwvWiUlCGkgc
         Mnx7jVlnD+PZVNPCCs6xgEDl/o7uV/87azu9R2Nxpf1dRZGjZhkwMsX8W0Z962MCC+ea
         7iaoXzrsbqelk+ZTqvdzmi2fp/pXeTblYOn+j4+73Kg7sEkRBtcstYpIyavLCdOXksFA
         ayWw==
X-Forwarded-Encrypted: i=1; AJvYcCUnX/HLSrCa3NFoOQv+VCTLA1/QoiB5Xa53gubhcu07vObACUnbzTtKnpTb/ip5dgxH/0Hhjf56G6lbiqlRRSxqFsA11Ho=
X-Gm-Message-State: AOJu0YzUcYB0C6VYIz7N1zRuYiRZ6XOQo8SpOF05v72g/ddxRvYnMa9M
	MCvn/ffbr0K+pviSB0oAcTfHSNGRwd+ed6n9Uq+fNAG+08Er5CF9nGshPsvXi37ykNFFA7x7z2s
	o4NjIUOxkX5ZRxK/RVe7WYZHANko=
X-Google-Smtp-Source: AGHT+IFRBMQlloUTfaYbb2pImPH7ZlqroFysI+85pcZQ+0mk5gExk9aUl4Lr0bVlfcQ/9FCBkFh0RulSz3HIbWUj6+4=
X-Received: by 2002:a17:906:584e:b0:a51:e05f:2455 with SMTP id
 h14-20020a170906584e00b00a51e05f2455mr981297ejs.48.1713513998324; Fri, 19 Apr
 2024 01:06:38 -0700 (PDT)
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
 <CANn89iL9OzD5+Y56F_8Jqyxwa5eDQPaPjhX9Y-Y_b9+bcQE08Q@mail.gmail.com>
 <CAL+tcoBn8RHm8AbwMBJ6FM6PMLLotCwTxSgPS1ABd-_D7uBSxw@mail.gmail.com>
 <CANn89iJ4a5VE-_AV-wVrh9Zpu0yS=jtwJaR_s2cBX7pP_QGQXQ@mail.gmail.com> <CAL+tcoA_eU98hMoWA2UM2LD_fNp=geY0uUfc+4pDnbUCKK6=Ew@mail.gmail.com>
In-Reply-To: <CAL+tcoA_eU98hMoWA2UM2LD_fNp=geY0uUfc+4pDnbUCKK6=Ew@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 19 Apr 2024 16:06:01 +0800
Message-ID: <CAL+tcoBiJgOcVirH1O9Yn0B_4RqCj+e4735wf7uxse57Kqc_vQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 0/7] Implement reset reason mechanism to detect
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, dsahern@kernel.org, matttbe@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, atenart@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 4:00=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Fri, Apr 19, 2024 at 3:44=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Fri, Apr 19, 2024 at 9:29=E2=80=AFAM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > On Fri, Apr 19, 2024 at 3:02=E2=80=AFPM Eric Dumazet <edumazet@google=
.com> wrote:
> > > >
> > > > On Fri, Apr 19, 2024 at 4:31=E2=80=AFAM Jason Xing <kerneljasonxing=
@gmail.com> wrote:
> > > > >
> > > > > On Fri, Apr 19, 2024 at 7:26=E2=80=AFAM Jason Xing <kerneljasonxi=
ng@gmail.com> wrote:
> > > > > >
> > > > > > > When I said "If you feel the need to put them in a special gr=
oup, this
> > > > > > > is fine by me.",
> > > > > > > this was really about partitioning the existing enum into gro=
ups, if
> > > > > > > you prefer having a group of 'RES reasons'
> > > > > >
> > > > > > Are you suggesting copying what we need from enum skb_drop_reas=
on{} to
> > > > > > enum sk_rst_reason{}? Why not reusing them directly. I have no =
idea
> > > > > > what the side effect of cast conversion itself is?
> > > > >
> > > > > Sorry that I'm writing this email. I'm worried my statement is no=
t
> > > > > that clear, so I write one simple snippet which can help me expla=
in
> > > > > well :)
> > > > >
> > > > > Allow me give NO_SOCKET as an example:
> > > > > diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> > > > > index e63a3bf99617..2c9f7364de45 100644
> > > > > --- a/net/ipv4/icmp.c
> > > > > +++ b/net/ipv4/icmp.c
> > > > > @@ -767,6 +767,7 @@ void __icmp_send(struct sk_buff *skb_in, int =
type,
> > > > > int code, __be32 info,
> > > > >         if (!fl4.saddr)
> > > > >                 fl4.saddr =3D htonl(INADDR_DUMMY);
> > > > >
> > > > > +       trace_icmp_send(skb_in, type, code);
> > > > >         icmp_push_reply(sk, &icmp_param, &fl4, &ipc, &rt);
> > > > >  ende:
> > > > >         ip_rt_put(rt);
> > > > > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > > > > index 1e650ec71d2f..d5963831280f 100644
> > > > > --- a/net/ipv4/tcp_ipv4.c
> > > > > +++ b/net/ipv4/tcp_ipv4.c
> > > > > @@ -2160,6 +2160,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
> > > > >  {
> > > > >         struct net *net =3D dev_net(skb->dev);
> > > > >         enum skb_drop_reason drop_reason;
> > > > > +       enum sk_rst_reason rst_reason;
> > > > >         int sdif =3D inet_sdif(skb);
> > > > >         int dif =3D inet_iif(skb);
> > > > >         const struct iphdr *iph;
> > > > > @@ -2355,7 +2356,8 @@ int tcp_v4_rcv(struct sk_buff *skb)
> > > > >  bad_packet:
> > > > >                 __TCP_INC_STATS(net, TCP_MIB_INERRS);
> > > > >         } else {
> > > > > -               tcp_v4_send_reset(NULL, skb);
> > > > > +               rst_reason =3D RST_REASON_NO_SOCKET;
> > > > > +               tcp_v4_send_reset(NULL, skb, rst_reason);
> > > > >         }
> > > > >
> > > > >  discard_it:
> > > > >
> > > > > As you can see, we need to add a new 'rst_reason' variable which
> > > > > actually is the same as drop reason. They are the same except for=
 the
> > > > > enum type... Such rst_reasons/drop_reasons are all over the place=
.
> > > > >
> > > > > Eric, if you have a strong preference, I can do it as you said.
> > > > >
> > > > > Well, how about explicitly casting them like this based on the cu=
rrent
> > > > > series. It looks better and clearer and more helpful to people wh=
o is
> > > > > reading codes to understand:
> > > > > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > > > > index 461b4d2b7cfe..eb125163d819 100644
> > > > > --- a/net/ipv4/tcp_ipv4.c
> > > > > +++ b/net/ipv4/tcp_ipv4.c
> > > > > @@ -1936,7 +1936,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct s=
k_buff *skb)
> > > > >         return 0;
> > > > >
> > > > >  reset:
> > > > > -       tcp_v4_send_reset(rsk, skb, (u32)reason);
> > > > > +       tcp_v4_send_reset(rsk, skb, (enum sk_rst_reason)reason);
> > > > >  discard:
> > > > >         kfree_skb_reason(skb, reason);
> > > > >         /* Be careful here. If this function gets more complicate=
d and
> > > >
> > > > It makes no sense to declare an enum sk_rst_reason and then convert=
 it
> > > > to drop_reason
> > > > or vice versa.
> > > >
> > > > Next thing you know, compiler guys will add a new -Woption that wil=
l
> > > > forbid such conversions.
> > > >
> > > > Please add to tcp_v4_send_reset() an skb_drop_reason, not a new enu=
m.
> > >
> > > Ah... It looks like I didn't make myself clear again. Sorry...
> > > Actually I wrote this part many times. My conclusion is that It's not
> > > feasible to do this.
> > >
> > > REASONS:
> > > If we __only__ need to deal with this passive reset in TCP, it's fine=
.
> > > We pass a skb_drop_reason which should also be converted to u32 type
> > > in tcp_v4_send_reset() as you said, it can work. People who use the
> > > trace will see the reason with the 'SKB_DROP_REASON' prefix stripped.
> > >
> > > But we have to deal with other cases. A few questions are listed here=
:
> > > 1) What about tcp_send_active_reset() in TCP/MPTCP? Passing weird dro=
p
> > > reasons? There is no drop reason at all. I think people will get
> > > confused. So I believe we should invent new definitions to cope with
> > > it.
> > > 2) What about the .send_reset callback in the subflow_syn_recv_sock()
> > > in MPTCP? The reasons in MPTCP are only definitions (such as
> > > MPTCP_RST_EUNSPEC). I don't think we can convert them into the enum
> > > skb_drop_reason type.
> > >
> > > So where should we group those various reasons?
> > >
> > > Introducing a new enum is for extension and compatibility for all
> > > kinds of reset reasons.
> > >
> > > What do you think?
> >
> > I will stop repeating myself.
> >
> > enums are not what you think.
> >
> > type safety is there for a reason.
> >
> > Can you show me another place in networking stacks where we cast enums
> > to others ?
>
> No, I've checked this a month ago.
>
> BTW, I don't know the dangers of casting enum types. I know you will

s/will/won't/

> answer it, but I still insist on asking, hoping someone seeing this
> will help me.
>
> Using skb_drop_reason can only deal with the passive reset in TCP. It
> is just one of all kinds of reset cases :(
>
> Forgive me, I cannot come up with a good way to cover all the cases TT
>
> I've tried..Sorry...
>
> If other experts see this thread, please help me. I would appreciate
> it. I have strong interests and feel strong responsibility to
> implement something like this patch series. It can be very useful!!
>
> Thanks again.
