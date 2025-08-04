Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC9E19F11E
	for <mptcp@lists.linux.dev>; Mon,  4 Aug 2025 17:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754327140; cv=none; b=LMyFfsdF8doSt5bD5sm/TzAA+3TQJn6ZkuN57EQ/HvJ+PTxzs4ZuzkJWXW5jLwrh6e7Sn4w5v1vpz75zYDGCdRr8d4q+o+knp3w97k+/v7yVvzh89kxjyViQQ3PqxBPwbwbVnS+964/w8oDncbmMgmQq8MBfwJWQHZXQb2EQk00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754327140; c=relaxed/simple;
	bh=pGieqkOTD1jkWe9nDsJnVb90ew18YFJA7ShIdKwfm1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FfsXLRHGFRjUD7lpE74XOJhLoWms4Dvle1Xn49jVxTTN00vaJr3se4QjD1hZsPgeHtR4UzgyvQ+3YuVknMZ21JEgkpTNov6UzGuvp5CGhq6t1A1HwB6rcLBd6t2JY0WfERQr8bb9WnnrkHBYlTpelaoQgDDea3K9JJbo6pMu1/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=enJOwG7u; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="enJOwG7u"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55b82db8fd4so4768618e87.2
        for <mptcp@lists.linux.dev>; Mon, 04 Aug 2025 10:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1754327136; x=1754931936; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ZThvULJdWP7Rgp2X/+vC0XA6BVXXqfgJ8nRh/t5Uxk=;
        b=enJOwG7up8tM0lhCfxAUOVO71PbZCQXCv6LWSbfxH2/ppZk9fKisHL+K310rEWzbYh
         eAgyTkfNi+EMJJQiNJwlLni1hvrDz/y2mgqYT9t862038hBTfY0PwOclzwwaiCY7k9FI
         q/Ja3Yh14Ox9mcOB34VqKzscAwzFIu0WyuzYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754327136; x=1754931936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ZThvULJdWP7Rgp2X/+vC0XA6BVXXqfgJ8nRh/t5Uxk=;
        b=r+mvCPXmdLj6rTItR3IlhL96+4Yk1k4j8kd0SYPUd5MH6kJwveh7PePIF2+KP/RUvh
         SS3uy7C1QE696zHTVXQH4ULcPCPh6iwUQz0mmZy6DkVw9NaU855Tb7JHfLK9r2fACTLR
         qP1BAa9n1MCkkIemZgyMgNcwRthwCYVSOSuM9aIBISvQ2vM/glEDGmbC2zR+hmZZgc8j
         UTPTlY1gEciduq2X8T5GHT/K579iAvR23I0mLsa5w7739dxDSxe1p1V1PS1Qr4TRWPhj
         FlvET6ZMKH/cKDmvikJ1yQzWxHIPUDNO+92Yqhezoido6+4kY5tTy3AYl1Wq97xseyzz
         P+5A==
X-Gm-Message-State: AOJu0YwRVBfzO+kVissiHW8CgnF6Vkz4rdCJcjOK+zyde0n20YAyIihO
	K67oRjHIZ9FKLGc8MwXUqbV//jrJ+AGOePg6S8RTCE7eFGAURZeX6XURiLCGZz8PwkEJjvV3Gny
	GbaYLDhCkk/nrm+HzmALCSzNMJ0FU+RyDRKFn5fMIqKN5L7mIxqKuuJRJdQ==
X-Gm-Gg: ASbGncucf/SsaMs4a9uMnL1DMdC84Ypd1OrP3g0x4G1l8ggVfF5fPfwNZ30yxeAGWah
	mnfJaIUtx+9DPS9wMs3o8zpngz5+PYjlYVXdsvNuG3G7bcJ/qICiP/wqI/s+bIhfvi2ZpEJa5GI
	KoGwuuuPoPFZly1dJz1CcLOvoXbmHi/ZM1snK4h3UFEUZNAjkfUerYChuV6znbw9qGExB6Sb7ed
	Mxo2cEy
X-Google-Smtp-Source: AGHT+IGom4tuN1M8YTuAcjol2s2c77nE46bdTDwphl8Kt7T8ar4AIaJ8dJfFfFuhHTSaaMCoD21WG/Y6eorZjToK/RM=
X-Received: by 2002:a05:6512:2390:b0:553:3172:1c23 with SMTP id
 2adb3069b0e04-55b97ac4559mr3178964e87.17.1754327136161; Mon, 04 Aug 2025
 10:05:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250802-b4-mptcp_setsockopt-v1-0-50d4905a4c2b@openai.com>
 <20250802-b4-mptcp_setsockopt-v1-1-50d4905a4c2b@openai.com> <f15385c8-cbec-4434-9dcb-5a0e71581314@kernel.org>
In-Reply-To: <f15385c8-cbec-4434-9dcb-5a0e71581314@kernel.org>
From: Christoph Paasch <cpaasch@openai.com>
Date: Mon, 4 Aug 2025 10:05:24 -0700
X-Gm-Features: Ac12FXwuAvVFrglHDqXwFcH6uFfQFXkSoOz6I6PWFAqmWa9ijo5hb1Prhn6jHpw
Message-ID: <CADg4-L9n4YeoTPU05rsNLqSW3+Q5aY-1xOSburpvi02uHbPQAA@mail.gmail.com>
Subject: Re: [PATCH mptcp-next 1/2] mptcp: Add support for SO_MAX_PACING_RATE
To: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 3, 2025 at 5:01=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org>=
 wrote:
>
> Hi Christoph,
>
> Thank you for looking at that!
>
> On 03/08/2025 01:52, Christoph Paasch via B4 Relay wrote:
> > From: Christoph Paasch <cpaasch@openai.com>
> >
> > Add support for SO_MAX_PACING_RATE. It will limit the rate of each
> > individual TCP subflow to the specified rate.
>
> Applying the same rate for each subflow seems easier, but should we do th=
at?

I guess the arguments can go both ways...

> I mean: if I have an app and I set SO_MAX_PACING_RATE at 1Mbps, at the
> end, data will be sent at 1Mbps * number of subflows. Is it not strange?
> On the other hand, implementing it globally with all the subflows might
> be quite complex I guess as currently, this rate limit is done by TC I
> think, no?

Yes, it is done by the fq-sch qdisc (which is the most efficient), but
can also be done by TCP itself if fq is not present.

> I guess the scheduler could set sk_max_pacing_rate for each
> subflow, but how to distribute it amongst all subflows? Equally? It
> depends on the limit of each subflow I guess.

I think that would be tricky to get right. I think a better approach
would be what I outline below.

> At the end, what's the "common" use case with SO_MAX_PACING_RATE? If the
> goal is just to apply a "vague" max limit to avoid abuses, that's maybe
> OK with a limit per subflow. If the goal is to limit at a precise value,
> that's possibly strange like that, e.g. using iperf3 with --fq-rate and
> seeing more than expected.

AFAICS, there are a few use-cases:
- For things like streaming media where one knows the bitrate of the
video/audio and one can reduce TCP burstiness by using
SO_MAX_PACING_RATE (there is a netflix paper about that -
https://brucespang.com/papers/sammy.pdf?utm_source=3Dchatgpt.com)
- When one wants to literally slow down the data-transfer speed in
order to intentionally avoid competing with other flows along the
paths (that's my use-case).

I guess the question is what is the intention of SO_MAX_PACING_RATE ?
I guess you are right that it is mostly about limiting the entire
MPTCP-connection. Maybe it is even possible to implement it in such a
way at the qdisc layer, but so that tcp_update_skb_after_send() takes
information at the MPTCP-layer into account and/or __tcp_transmit_skb
uses MPTCP-info when calling skb_set_delivery_time(). That's a whole
new endeavour :-)

Back to my use-case. I can see why we don't want to use
SO_MAX_PACING_RATE for that, if that's what we (the community) agree
on.
In that case, I guess it needs to be a new MPTCP-specific option ?

> > Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> > ---
> >  net/mptcp/sockopt.c | 31 ++++++++++++++++++++++++++++++-
> >  1 file changed, 30 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> > index 2c267aff95bec90d341de9f9e136b9d2df9b8e13..a79dfeb54a3fe0d8c26a183=
6ae5dda9fd2fdddea 100644
> > --- a/net/mptcp/sockopt.c
> > +++ b/net/mptcp/sockopt.c
> > @@ -308,6 +308,7 @@ static int mptcp_setsockopt_sol_socket(struct mptcp=
_sock *msk, int optname,
> >
> >               ret =3D sk_setsockopt(ssk, SOL_SOCKET, optname, optval, o=
ptlen);
> >               if (ret =3D=3D 0) {
> > +                     /* Record the option at the msk for subsequent su=
bflows */
>
> (unrelated: maybe not needed?)

Just wanted to improve the readability of the code here :)

> >                       if (optname =3D=3D SO_REUSEPORT)
> >                               sk->sk_reuseport =3D ssk->sk_reuseport;
> >                       else if (optname =3D=3D SO_REUSEADDR)
> > @@ -340,6 +341,25 @@ static int mptcp_setsockopt_sol_socket(struct mptc=
p_sock *msk, int optname,
> >                                                               optval, o=
ptlen);
> >       case SO_LINGER:
> >               return mptcp_setsockopt_sol_socket_linger(msk, optval, op=
tlen);
> > +     case SO_MAX_PACING_RATE: {
> > +             struct mptcp_subflow_context *subflow;
> > +
> > +             ret =3D sock_setsockopt(sk->sk_socket, SOL_SOCKET, optnam=
e, optval, optlen);
> > +             if (ret < 0)
> > +                     return ret;
> > +
> > +             lock_sock(sk);
> > +             sockopt_seq_inc(msk);
> > +
> > +             mptcp_for_each_subflow(msk, subflow) {
> > +                     struct sock *ssk =3D mptcp_subflow_tcp_sock(subfl=
ow);
> > +
> > +                     sk_setsockopt(ssk, SOL_SOCKET, optname, optval, o=
ptlen);
> > +             }
> > +
> > +             release_sock(sk);
> > +             break;
>
> It might be better to move this block in a generic helper.
>
> (and we should probably refactor more code to use such helpers, similar
> to what was suggested there:
> https://patchwork.kernel.org/project/mptcp/list/?series=3D763505&state=3D=
*)

Yes - this entire file needs some love :-)

> > +     }
> >       case SO_RCVLOWAT:
> >       case SO_RCVTIMEO_OLD:
> >       case SO_RCVTIMEO_NEW:
> > @@ -373,7 +393,6 @@ static int mptcp_setsockopt_sol_socket(struct mptcp=
_sock *msk, int optname,
> >        * explicitly the sk_protocol field
> >        *
> >        * SO_PEEK_OFF is unsupported, as it is for plain TCP
> > -      * SO_MAX_PACING_RATE is unsupported, we must be careful with sub=
flows
> >        * SO_CNX_ADVICE is currently unsupported, could possibly be rele=
vant,
> >        * but likely needs careful design
> >        *
> > @@ -1532,6 +1551,7 @@ static void sync_socket_options(struct mptcp_sock=
 *msk, struct sock *ssk)
> >  {
> >       static const unsigned int tx_rx_locks =3D SOCK_RCVBUF_LOCK | SOCK=
_SNDBUF_LOCK;
> >       struct sock *sk =3D (struct sock *)msk;
> > +     unsigned long max_pacing_rate;
> >
> >       if (ssk->sk_prot->keepalive) {
> >               if (sock_flag(sk, SOCK_KEEPOPEN))
> > @@ -1579,6 +1599,15 @@ static void sync_socket_options(struct mptcp_soc=
k *msk, struct sock *ssk)
> >       tcp_sock_set_keepcnt(ssk, msk->keepalive_cnt);
> >       tcp_sock_set_maxseg(ssk, msk->maxseg);
> >
> > +     /* Keep pacing settings in sync as well. */
> > +     max_pacing_rate =3D READ_ONCE(sk->sk_max_pacing_rate);
> > +
> > +     WRITE_ONCE(ssk->sk_max_pacing_rate, max_pacing_rate);
> > +     if (max_pacing_rate !=3D ~0UL)
> > +             cmpxchg(&ssk->sk_pacing_status, SK_PACING_NONE, SK_PACING=
_NEEDED);
> > +     if (READ_ONCE(ssk->sk_pacing_rate) > max_pacing_rate)
> > +             WRITE_ONCE(ssk->sk_pacing_rate, max_pacing_rate);
>
> Would it not be easier for the maintenance to export some code from
>
>   net/core/sock.c
>
> doing the same, and calling it from there and here?

IMO the cleanest way in sync_socket_options() would be that for each
option we reconstruct a sockptr_t and call sk_setsockopt().

WDYT ?


Christoph

>
> > +
> >       inet_assign_bit(TRANSPARENT, ssk, inet_test_bit(TRANSPARENT, sk))=
;
> >       inet_assign_bit(FREEBIND, ssk, inet_test_bit(FREEBIND, sk));
> >       inet_assign_bit(BIND_ADDRESS_NO_PORT, ssk, inet_test_bit(BIND_ADD=
RESS_NO_PORT, sk));
> >
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>
