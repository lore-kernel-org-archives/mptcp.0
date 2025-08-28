Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C55A2DAFA1
	for <mptcp@lists.linux.dev>; Thu, 28 Aug 2025 16:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756397637; cv=none; b=MYPpuLyMFOxzeIW4hdaSW4BD6s/5aGGFXoR5Tk/YVsgFuAqM+aI+x1+iGUnX1dEZSKThaVUIwrB19jsuckOGiPRsEYXlArZDLGPFqHrWkVu4PTjkKsoFplXzFTfusHMexwcU4b3hvWWHDQYu2G+le9D6kDE9DH9+cDnBg1IdRb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756397637; c=relaxed/simple;
	bh=r7kBGH+uodAtIgga4DOhH14nBvvnV8RlmM96migrT2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g7LgBVaBsWMf5xq0JuyrNhBRNGpaPmVNWmyX7jQlQhDHIldUJZGGnisyuBBQh7P/UsWwPQSmHW8C/c8k4ybRxv4ApdnS2SAKYKZxxgPgVWzjPKG6UdpwQSk73edHs4/daBXe6FiDamVm8y206Q9TISMiji+9+rzrGzklkZLeOQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=ZUzauaYl; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="ZUzauaYl"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55f6017004dso849360e87.0
        for <mptcp@lists.linux.dev>; Thu, 28 Aug 2025 09:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1756397634; x=1757002434; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0H8ltvyVwhD1/6Wm7N8/A8F22vWO8IK7wBsMO5uqGLM=;
        b=ZUzauaYlEuk3/7cmvESuZ7moNZ16gOzXdeHLx/sFntPOTLuzYcwe9LM6InJCos1DVA
         ntoXeNBNM1XABgnuvQ1GthnK+G1HY/kEkuQCgSLCXkQ+SMoD8btOhVoo9c0QMbLl1W3L
         KfoUE9t/cIjAZGpyxgu/1WJemmycXcvWh99Bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756397634; x=1757002434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0H8ltvyVwhD1/6Wm7N8/A8F22vWO8IK7wBsMO5uqGLM=;
        b=pM181q47OdUmNpL6wWqFp7YFP/yIKLqGVRpza2QkVbu66ujCqHvCir1G6cCPUCTGnQ
         65pKXDThPOuFYbrjvU09pT8G2yk99MWtPekCCft6PoyxO1XNbQ6ZD3i7UMKKmD+IaMKi
         CYnlwmWv1YZw86CDxHES09GowJ63mGhg8eJ9UP7K5nNQ+70+v/GgiJ/bjqmADDlYAocO
         kYJS0E1FMmA9DYl5YmBI+Fj+nFyiHewrwEWVfMf1L1u/pTOWw2eq6dezxY2o2+7CTpvA
         ZWad+YZ3cHS57BkN6VMbpc3HzzsqjYzLcvdhW3m56r4NBMwaDgdhyhPJvyejhNMxk35M
         NCPw==
X-Gm-Message-State: AOJu0Yyb4VSqPBQnQdPrlea4p+WCn2jmmu81mQLC2WH+xjNP1vwHXeQi
	+InuS8uQsZgpU+RMYBEV0Da1jYOVnOy5OC7QcratDUs7evlTwRk8UUG4ui/LZPcjfIxU4LNQhzu
	WnBFIO5u8bozz93StZdI7lW5u2v4Ee0LVXsAqA05uqg==
X-Gm-Gg: ASbGncv+oj4JCQ+RtymeHfdDVcq9/HP1wS85P5n848iK+afh10OVamBqMTmqsPvWgfE
	oHLyGV1/acUJ2jxcqnknf5k3NCGO5m2V4mdgTXy21OhPL2Agl/nNvjGfwsXCTieiZ8eG87+MYIm
	qzINRzNlpRV5thzi839BFMCedq1mLCkK0oBwbDHxXwihuL7kxJU4vAp7mOB9MUVwGrwwEYNuu9O
	j9aeoiTBGsS5qWK7A+oapdyTot43ij+Dqoe96FfRCMfUn2AL+rVEYkT8rCkeWg=
X-Google-Smtp-Source: AGHT+IEqYl5WlyeCDcwHwNkCMd9Oxd7kgA9d6Hxx0pa4rTMXicCk1sHX1/SkGWOozPHPJb+5VxJ3HK3QkFgVkw+4yhM=
X-Received: by 2002:a05:6512:4048:20b0:55f:34e8:b1b8 with SMTP id
 2adb3069b0e04-55f34e8ca2fmr4008236e87.55.1756397633637; Thu, 28 Aug 2025
 09:13:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250802-b4-mptcp_setsockopt-v1-0-50d4905a4c2b@openai.com>
 <20250802-b4-mptcp_setsockopt-v1-1-50d4905a4c2b@openai.com>
 <f15385c8-cbec-4434-9dcb-5a0e71581314@kernel.org> <CADg4-L9n4YeoTPU05rsNLqSW3+Q5aY-1xOSburpvi02uHbPQAA@mail.gmail.com>
 <f1882de4-a03f-4955-84cc-3ddd34e430a6@kernel.org> <70da4df6-d954-460b-a089-a1171d7b2dd9@kernel.org>
In-Reply-To: <70da4df6-d954-460b-a089-a1171d7b2dd9@kernel.org>
From: Christoph Paasch <cpaasch@openai.com>
Date: Thu, 28 Aug 2025 09:13:41 -0700
X-Gm-Features: Ac12FXzR4D8s0LYAvSPc20-8Y9yi7KUApYr2UPR0IqUaV0CzNnS0eEFfPDz5Qe8
Message-ID: <CADg4-L9yyiqhGkTSk0m2e5AXSzOuYM4q1-QTTUgUkgxjEW+v_A@mail.gmail.com>
Subject: Re: [PATCH mptcp-next 1/2] mptcp: Add support for SO_MAX_PACING_RATE
To: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 3:45=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi Christoph,
>
> On 04/08/2025 19:38, Matthieu Baerts wrote:
> > Hi Christoph,
> >
> > Thank you for your reply!
> >
> > On 04/08/2025 19:05, Christoph Paasch wrote:
> >> On Sun, Aug 3, 2025 at 5:01=E2=80=AFAM Matthieu Baerts <matttbe@kernel=
.org> wrote:
> >>>
> >>> Hi Christoph,
> >>>
> >>> Thank you for looking at that!
> >>>
> >>> On 03/08/2025 01:52, Christoph Paasch via B4 Relay wrote:
> >>>> From: Christoph Paasch <cpaasch@openai.com>
> >>>>
> >>>> Add support for SO_MAX_PACING_RATE. It will limit the rate of each
> >>>> individual TCP subflow to the specified rate.
> >>>
> >>> Applying the same rate for each subflow seems easier, but should we d=
o that?
> >>
> >> I guess the arguments can go both ways...
> >>
> >>> I mean: if I have an app and I set SO_MAX_PACING_RATE at 1Mbps, at th=
e
> >>> end, data will be sent at 1Mbps * number of subflows. Is it not stran=
ge?
> >>> On the other hand, implementing it globally with all the subflows mig=
ht
> >>> be quite complex I guess as currently, this rate limit is done by TC =
I
> >>> think, no?
> >>
> >> Yes, it is done by the fq-sch qdisc (which is the most efficient), but
> >> can also be done by TCP itself if fq is not present.
> >
> > Oh nice, I thought SO_MAX_PACING_RATE could only work with fq.
> >
> >>> I guess the scheduler could set sk_max_pacing_rate for each
> >>> subflow, but how to distribute it amongst all subflows? Equally? It
> >>> depends on the limit of each subflow I guess.
> >>
> >> I think that would be tricky to get right. I think a better approach
> >> would be what I outline below.
> >>
> >>> At the end, what's the "common" use case with SO_MAX_PACING_RATE? If =
the
> >>> goal is just to apply a "vague" max limit to avoid abuses, that's may=
be
> >>> OK with a limit per subflow. If the goal is to limit at a precise val=
ue,
> >>> that's possibly strange like that, e.g. using iperf3 with --fq-rate a=
nd
> >>> seeing more than expected.
> >>
> >> AFAICS, there are a few use-cases:
> >> - For things like streaming media where one knows the bitrate of the
> >> video/audio and one can reduce TCP burstiness by using
> >> SO_MAX_PACING_RATE (there is a netflix paper about that -
> >> https://brucespang.com/papers/sammy.pdf?utm_source=3Dchatgpt.com)
> >
> > (I wonder what source you are using :-D )
> >
> > Funny, this paper was mentioned recently at the IETF:
> >
> > https://datatracker.ietf.org/meeting/123/materials/agenda-123-iccrg-01
> >
> >> - When one wants to literally slow down the data-transfer speed in
> >> order to intentionally avoid competing with other flows along the
> >> paths (that's my use-case).
> >>
> >> I guess the question is what is the intention of SO_MAX_PACING_RATE ?
> >> I guess you are right that it is mostly about limiting the entire
> >> MPTCP-connection. Maybe it is even possible to implement it in such a
> >> way at the qdisc layer, but so that tcp_update_skb_after_send() takes
> >> information at the MPTCP-layer into account and/or __tcp_transmit_skb
> >> uses MPTCP-info when calling skb_set_delivery_time(). That's a whole
> >> new endeavour :-)
> >
> > That would be great to have such support at the qdisc layer!
> >
> >> Back to my use-case. I can see why we don't want to use
> >> SO_MAX_PACING_RATE for that, if that's what we (the community) agree
> >> on.
> >> In that case, I guess it needs to be a new MPTCP-specific option ?
> >
> > I guess we can support both behaviours: one to limit per MPTCP
> > connection, and the other one per subflow.
> >
> > One would be set via setsockopt(SOL_SOCKET, SO_MAX_PACING_RATE), and th=
e
> > other one with setsockopt(SOL_MPTCP, XXX). I guess SO_MAX_PACING_RATE
> > should be for the whole MPTCP connection, no? In this case, I guess we
> > should not change the behaviour: not doing a limit per subflow when
> > using SO_MAX_PACING_RATE in some versions, then switching to a limit pe=
r
> > connection, right?
> >
> > If so, would it be OK to limit per subflow via something like:
> >
> >   setsockopt(SOL_MPTCP, MPTCP_SUBFLOW_MAX_PACING_RATE)
> >
> > WDYT?
> >
> > Or directly implement SO_MAX_PACING_RATE? :)
>
> If that's easier, MPTCP_SUBFLOW_MAX_PACING_RATE (pacing per subflow) can
> be introduced first, then SO_MAX_PACING_RATE (pacing per connection)
> when someone has the opportunity to implement it later on. In this case,
> this series would only need a few adaptations to switch to SOL_MPTCP.

Yes, I will do that eventually. But right now, other things have
higher priority for me.

If you feel like it, feel free to pick these patches up :)


Christoph

>
> >>>> Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> >>>> ---
> >>>>  net/mptcp/sockopt.c | 31 ++++++++++++++++++++++++++++++-
> >>>>  1 file changed, 30 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> >>>> index 2c267aff95bec90d341de9f9e136b9d2df9b8e13..a79dfeb54a3fe0d8c26a=
1836ae5dda9fd2fdddea 100644
> >>>> --- a/net/mptcp/sockopt.c
> >>>> +++ b/net/mptcp/sockopt.c
> >>>> @@ -308,6 +308,7 @@ static int mptcp_setsockopt_sol_socket(struct mp=
tcp_sock *msk, int optname,
> >>>>
> >>>>               ret =3D sk_setsockopt(ssk, SOL_SOCKET, optname, optval=
, optlen);
> >>>>               if (ret =3D=3D 0) {
> >>>> +                     /* Record the option at the msk for subsequent=
 subflows */
> >>>
> >>> (unrelated: maybe not needed?)
> >>
> >> Just wanted to improve the readability of the code here :)
> >
> > ah ok :)
> >
> >>
> >>>>                       if (optname =3D=3D SO_REUSEPORT)
> >>>>                               sk->sk_reuseport =3D ssk->sk_reuseport=
;
> >>>>                       else if (optname =3D=3D SO_REUSEADDR)
> >>>> @@ -340,6 +341,25 @@ static int mptcp_setsockopt_sol_socket(struct m=
ptcp_sock *msk, int optname,
> >>>>                                                               optval=
, optlen);
> >>>>       case SO_LINGER:
> >>>>               return mptcp_setsockopt_sol_socket_linger(msk, optval,=
 optlen);
> >>>> +     case SO_MAX_PACING_RATE: {
> >>>> +             struct mptcp_subflow_context *subflow;
> >>>> +
> >>>> +             ret =3D sock_setsockopt(sk->sk_socket, SOL_SOCKET, opt=
name, optval, optlen);
> >>>> +             if (ret < 0)
> >>>> +                     return ret;
> >>>> +
> >>>> +             lock_sock(sk);
> >>>> +             sockopt_seq_inc(msk);
> >>>> +
> >>>> +             mptcp_for_each_subflow(msk, subflow) {
> >>>> +                     struct sock *ssk =3D mptcp_subflow_tcp_sock(su=
bflow);
> >>>> +
> >>>> +                     sk_setsockopt(ssk, SOL_SOCKET, optname, optval=
, optlen);
> >>>> +             }
> >>>> +
> >>>> +             release_sock(sk);
> >>>> +             break;
> >>>
> >>> It might be better to move this block in a generic helper.
> >>>
> >>> (and we should probably refactor more code to use such helpers, simil=
ar
> >>> to what was suggested there:
> >>> https://patchwork.kernel.org/project/mptcp/list/?series=3D763505&stat=
e=3D*)
> >>
> >> Yes - this entire file needs some love :-)
> >
> > True! :)
> >
> >>>> +     }
> >>>>       case SO_RCVLOWAT:
> >>>>       case SO_RCVTIMEO_OLD:
> >>>>       case SO_RCVTIMEO_NEW:
> >>>> @@ -373,7 +393,6 @@ static int mptcp_setsockopt_sol_socket(struct mp=
tcp_sock *msk, int optname,
> >>>>        * explicitly the sk_protocol field
> >>>>        *
> >>>>        * SO_PEEK_OFF is unsupported, as it is for plain TCP
> >>>> -      * SO_MAX_PACING_RATE is unsupported, we must be careful with =
subflows
> >>>>        * SO_CNX_ADVICE is currently unsupported, could possibly be r=
elevant,
> >>>>        * but likely needs careful design
> >>>>        *
> >>>> @@ -1532,6 +1551,7 @@ static void sync_socket_options(struct mptcp_s=
ock *msk, struct sock *ssk)
> >>>>  {
> >>>>       static const unsigned int tx_rx_locks =3D SOCK_RCVBUF_LOCK | S=
OCK_SNDBUF_LOCK;
> >>>>       struct sock *sk =3D (struct sock *)msk;
> >>>> +     unsigned long max_pacing_rate;
> >>>>
> >>>>       if (ssk->sk_prot->keepalive) {
> >>>>               if (sock_flag(sk, SOCK_KEEPOPEN))
> >>>> @@ -1579,6 +1599,15 @@ static void sync_socket_options(struct mptcp_=
sock *msk, struct sock *ssk)
> >>>>       tcp_sock_set_keepcnt(ssk, msk->keepalive_cnt);
> >>>>       tcp_sock_set_maxseg(ssk, msk->maxseg);
> >>>>
> >>>> +     /* Keep pacing settings in sync as well. */
> >>>> +     max_pacing_rate =3D READ_ONCE(sk->sk_max_pacing_rate);
> >>>> +
> >>>> +     WRITE_ONCE(ssk->sk_max_pacing_rate, max_pacing_rate);
> >>>> +     if (max_pacing_rate !=3D ~0UL)
> >>>> +             cmpxchg(&ssk->sk_pacing_status, SK_PACING_NONE, SK_PAC=
ING_NEEDED);
> >>>> +     if (READ_ONCE(ssk->sk_pacing_rate) > max_pacing_rate)
> >>>> +             WRITE_ONCE(ssk->sk_pacing_rate, max_pacing_rate);
> >>>
> >>> Would it not be easier for the maintenance to export some code from
> >>>
> >>>   net/core/sock.c
> >>>
> >>> doing the same, and calling it from there and here?
> >>
> >> IMO the cleanest way in sync_socket_options() would be that for each
> >> option we reconstruct a sockptr_t and call sk_setsockopt().
> >>
> >> WDYT ?
> >
> > Yes, that would be excellent. I didn't have the chance to explore this.
> > Also, I don't know if we can call sk_setsockopt() for each supported
> > option (or maybe fine?), maybe we should limit to the ones that have
> > been modified, no?
> >
> > Cheers,
> > Matt
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>
