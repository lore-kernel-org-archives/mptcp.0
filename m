Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E053B1AB
	for <mptcp@lists.linux.dev>; Fri, 19 Apr 2024 07:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713510154; cv=none; b=Sbv9WuPwR1Mc0vDpRAejCPIlisNxCic/vsr3eFeksXvxVvdnx6B64iM5F8BUAHPxnsh0Yw6RXUZR57h3Of2ljK6bwg/P3rSgVExdwlwh8X5ZfTiLzqth4CyVLqkgGDlIYjD5QyPievXDd5yc9N31lerr/eZI8gnB12LC6LuEkX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713510154; c=relaxed/simple;
	bh=9gbg/ehbV8yzIMt+Gr3oETkExUgyAVE3H7ltyX1nDx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WvLD7Ogc83wuaVzi/OT7JeSKGXWY31qAwo/yERSHv6o/hOAt9dvA2JiLsnjgyakQ1erlpAYJdvGVhquolfw3APJI2ebBh1pg537kWBs0LBohq1jjI7xM16da54W9FlUxgP0TGs94UBR0vcumL4UXw5hKTfQW/dBa/LCajjYDZsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kqmhNRiC; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kqmhNRiC"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56fd95160e5so6898a12.0
        for <mptcp@lists.linux.dev>; Fri, 19 Apr 2024 00:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713510150; x=1714114950; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLHkiHrTlpdTps6ysTqOAyZCrLwQiuSrdW4pKXYb6fg=;
        b=kqmhNRiC97aAJl3tfsNnaObRx1U+h8gC+O2HHVOm5RnAohgzeGuyR/Va3KPe0YupR2
         4tq1QzozS6ljtAcCwYAepRqzbmqsdV3MqPrNxdCs1/jLUWEasQhkCUpkZxmIcrWvitk4
         FI07ecZDpjIFn9VgCMkThamEc/BnoJntgDHiVvQaaMd6GiTey68iZEHxSAjaAa9Hohzm
         CFI/ijVSGBq0xm6aFhUpSfcEx/tP+T6ml/s1BNvltYEATqkXjboxOR8jW8kJZ6Gx39uS
         RmTxOiesT2NcA60J7rsBIGoaqhrhQXiPl+sDM01V9QfHpg0N/LC3zEj1Q73hRW/4gjkO
         rhWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713510150; x=1714114950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wLHkiHrTlpdTps6ysTqOAyZCrLwQiuSrdW4pKXYb6fg=;
        b=Dfv9IGBeJYxFTxzVwp+jAuDB2cbXTBajeS4S0xv8MaYabnTMt+tQOI7vpfH/Tz2Z76
         6dr/IRG9AnZFrOC2jCmFbP/IkK+xrWDLDXqjEw/EzIeIOHMWnztDdDYgPAJ2s9qauQG7
         h2Apb6b9vPeHJKT/k6Be9fvAt+wsm1RTsqWjhSqlbdUvMXL6WBKryXbofGOtuZI6CmMJ
         K8I6AYUxd9ugP1PNrlSaAid+0B/UnglhINJQRogd+LyYttL2DJkNlL8VgX2dFLAj2kO7
         k6mQX88o88tSqqToom7dg3QWif+SUOowMgPneBqWL1HOcnyyuF0UZ1yfVtlk54Xqrvpp
         mHiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXlRaqdJRkqdf2WAz22ffg3eGyPGG4RoyiBBW87tGB0lw8Us7UECr8q3SfSvhbGDFiLbPWattGOUOKyK3VneuPwKVuF60=
X-Gm-Message-State: AOJu0YxDoFP7zIM3rMvfRENIGKyAQ+DxrWmgZzakFpKCMX/2Ik6H9fAV
	+ZRuxtnwwdpfC8B1DLvHAB5MpYI7NexXBPa51ZTqugi+gkH3jeFbZGGCakmSJoxYUu5xoaC24O3
	KldNz7pRJpeauKYXVuzqZyElL0X3AJvBbijq4
X-Google-Smtp-Source: AGHT+IFssgbt19Ud0j5wzyljXYaHnnidj4QCzNardhDoOQfW9g1s5Wv2bsNy8dfFKGX1BmofOHebjOwN7xzVqHIEaFM=
X-Received: by 2002:a50:fc18:0:b0:571:b2c2:5c3e with SMTP id
 i24-20020a50fc18000000b00571b2c25c3emr65390edr.1.1713510149689; Fri, 19 Apr
 2024 00:02:29 -0700 (PDT)
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
 <CAL+tcoBV77KmL8_d1PTk8muA6Gg3hPYb99BpAXD9W1RcFsg7Bw@mail.gmail.com> <CAL+tcoAEN-OQeqn3m3zLGUiPZEaoTjz0WHaNL-xm702aot_m-g@mail.gmail.com>
In-Reply-To: <CAL+tcoAEN-OQeqn3m3zLGUiPZEaoTjz0WHaNL-xm702aot_m-g@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 19 Apr 2024 09:02:18 +0200
Message-ID: <CANn89iL9OzD5+Y56F_8Jqyxwa5eDQPaPjhX9Y-Y_b9+bcQE08Q@mail.gmail.com>
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

On Fri, Apr 19, 2024 at 4:31=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Fri, Apr 19, 2024 at 7:26=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > > When I said "If you feel the need to put them in a special group, thi=
s
> > > is fine by me.",
> > > this was really about partitioning the existing enum into groups, if
> > > you prefer having a group of 'RES reasons'
> >
> > Are you suggesting copying what we need from enum skb_drop_reason{} to
> > enum sk_rst_reason{}? Why not reusing them directly. I have no idea
> > what the side effect of cast conversion itself is?
>
> Sorry that I'm writing this email. I'm worried my statement is not
> that clear, so I write one simple snippet which can help me explain
> well :)
>
> Allow me give NO_SOCKET as an example:
> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> index e63a3bf99617..2c9f7364de45 100644
> --- a/net/ipv4/icmp.c
> +++ b/net/ipv4/icmp.c
> @@ -767,6 +767,7 @@ void __icmp_send(struct sk_buff *skb_in, int type,
> int code, __be32 info,
>         if (!fl4.saddr)
>                 fl4.saddr =3D htonl(INADDR_DUMMY);
>
> +       trace_icmp_send(skb_in, type, code);
>         icmp_push_reply(sk, &icmp_param, &fl4, &ipc, &rt);
>  ende:
>         ip_rt_put(rt);
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 1e650ec71d2f..d5963831280f 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -2160,6 +2160,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
>  {
>         struct net *net =3D dev_net(skb->dev);
>         enum skb_drop_reason drop_reason;
> +       enum sk_rst_reason rst_reason;
>         int sdif =3D inet_sdif(skb);
>         int dif =3D inet_iif(skb);
>         const struct iphdr *iph;
> @@ -2355,7 +2356,8 @@ int tcp_v4_rcv(struct sk_buff *skb)
>  bad_packet:
>                 __TCP_INC_STATS(net, TCP_MIB_INERRS);
>         } else {
> -               tcp_v4_send_reset(NULL, skb);
> +               rst_reason =3D RST_REASON_NO_SOCKET;
> +               tcp_v4_send_reset(NULL, skb, rst_reason);
>         }
>
>  discard_it:
>
> As you can see, we need to add a new 'rst_reason' variable which
> actually is the same as drop reason. They are the same except for the
> enum type... Such rst_reasons/drop_reasons are all over the place.
>
> Eric, if you have a strong preference, I can do it as you said.
>
> Well, how about explicitly casting them like this based on the current
> series. It looks better and clearer and more helpful to people who is
> reading codes to understand:
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 461b4d2b7cfe..eb125163d819 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -1936,7 +1936,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *=
skb)
>         return 0;
>
>  reset:
> -       tcp_v4_send_reset(rsk, skb, (u32)reason);
> +       tcp_v4_send_reset(rsk, skb, (enum sk_rst_reason)reason);
>  discard:
>         kfree_skb_reason(skb, reason);
>         /* Be careful here. If this function gets more complicated and

It makes no sense to declare an enum sk_rst_reason and then convert it
to drop_reason
or vice versa.

Next thing you know, compiler guys will add a new -Woption that will
forbid such conversions.

Please add to tcp_v4_send_reset() an skb_drop_reason, not a new enum.

skb_drop_reason are simply values that are later converted to strings...

So : Do not declare a new enum.
