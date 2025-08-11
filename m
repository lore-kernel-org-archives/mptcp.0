Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6664C2D6E51
	for <mptcp@lists.linux.dev>; Mon, 11 Aug 2025 15:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754926456; cv=none; b=kdNLldMDYktP6XbkpLN4ncFKVUGwBYMmvhTgMVnnLe5LaTiuABImVI2z/SW1sB+jByMsPU4vhoooi0CbdvQplo6Vdx58dHWMkAngJuYRiwzkQEnVUtckjB9ZtnI4PTwI5gBlCW4El6h8NlxJ+3OmO84ZPNkGNH5rfPV+gLakFrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754926456; c=relaxed/simple;
	bh=QiKiQLIUqkTX93+P/ywIK74GSyzM+IzQ1xiVEzsMGAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IudV+ogz+T1C0fkOPmBiIPPM04a7k9pP1YjQJtoLzm4hfuernYAis2vOnfIe56ATvLFoI7gxF5djCH1ERxqrcyEmHUhIi37+VO4eiAAbKD/2xIQBm4YkKfnqj4pHJnoy2DgihPyWajeVSDNrI5awsCjsd/5AMB0/2uYjLrVYMyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=K6NuaYQk; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="K6NuaYQk"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5561ab55c4dso4611589e87.2
        for <mptcp@lists.linux.dev>; Mon, 11 Aug 2025 08:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1754926452; x=1755531252; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZGH79QtDA7/NxXttT5as7w1OrQqF7B8yd0EU1u6QGs=;
        b=K6NuaYQk9aXnuPL1y1yoR5gav4OwERaypOCimWfxRA0NLwvTFUmGLuOjXmJHSnpKQS
         bKjSU+5zKTPV6xWtRz8XcSXPEKAS/ioSD+cupUoHwdIkl+8vQ2uRhKYhhbZzn+CW5obI
         jK1NsmfokuLlN57MhAlChnn8tbPZRapV3bM64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754926452; x=1755531252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DZGH79QtDA7/NxXttT5as7w1OrQqF7B8yd0EU1u6QGs=;
        b=IErcFXmi6Txv158mZZiSd7bkXcJCQjZzscuCC0mvAw/9XXNnzj6F2u/WvCVG5gq2/p
         pRncNVk72Vv6LALr9vT7dqJw0HVosrfPIsiF5ml7gJlBlimvJKER+kMrryszcJxMz0Fs
         LiDWgPp9XlTZSmXu1m8ZMta9+FZBmFStDyVqlUMgB8dAuzEwygD1yarICiDaXFRUqWai
         qdfSJOLMNJCO55jYRNPJHuafV6tU43uV7qmheD7Hx3TGwzHJk4o3y5Y2UCVukt6tnrpA
         xxQ2zt0uZ8ho5hASKGLcbpccnHFddqxhiFPfhT8rvlGgR3bFAkAcOOhPlm4zmQsclY7J
         XHmA==
X-Forwarded-Encrypted: i=1; AJvYcCVum1XUQH20v7gen1MT8FKgVr2xp5sgnpeop0aCh4FE/crs1/nmnUUulQqVN6UqCMP5FQiWCw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwOh1Xwbg8v1KW5q7g87WCYAwLss74Rw2i7XUPFBNzg6qdH9EXS
	ATEVe6CQTdzkLfw0Z3nmoQWBR9h0M9mJnfj6aCjAIvHzMNh6AnlCzVgE7do9PyLQRhjcpYhgI7p
	hC9WigcIRvxMS7IHj9W2qMvU4uMFZJ5JRnVxoMMghpJHdG8JMqi4jO3g=
X-Gm-Gg: ASbGncsx2C2fJHWyrgbRxjYtUw2jr0s7iNlX0b/9cFiJLBgsDl9jP4QuqVLm4W2brFe
	ieg6IY9h+nJE8TtKdWmqx1/6Da2fGWRQ25QdoxzCVIHmFiuhh1ZVMDEgB4cWa3xqIaF3ipo2Sxn
	FXxd2xlIiVDfXvpvbnHARCItq8m+IaNoMhv21VEJwozlKApLJ6eMPeGaloLNpA23yqNXB279WIw
	d1/HeaJAywfRagX
X-Google-Smtp-Source: AGHT+IF3IL1OdqJSSfa/mpvkrqfNZEb3qjXkWxZKW/2cE+AyB+18PcBb+SvxscqLkRYE6VPuLDDORt7BiZg842FdOU8=
X-Received: by 2002:a05:6512:3183:b0:55b:93f2:6b4d with SMTP id
 2adb3069b0e04-55cd76312ebmr81085e87.45.1754926452374; Mon, 11 Aug 2025
 08:34:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1754449947.git.tanggeliang@kylinos.cn> <c559f29eea1e019b6d25a35f05bbeb85fdd578e1.1754449947.git.tanggeliang@kylinos.cn>
 <eb6c0e4d-938c-4712-83b2-ee12bd70aa12@kernel.org> <f42defcb7fe7db02283fed5def29623cbc6a24d7.camel@kernel.org>
 <b0a4ebe8-0dfd-4c15-89bf-98c4f7cfebc0@kernel.org> <78799855faff1bb19cdec5210ca5edf302d39974.camel@kernel.org>
 <5d4dfa60-7604-4b45-becf-8df8bd0667ed@kernel.org>
In-Reply-To: <5d4dfa60-7604-4b45-becf-8df8bd0667ed@kernel.org>
From: Christoph Paasch <cpaasch@openai.com>
Date: Mon, 11 Aug 2025 08:34:01 -0700
X-Gm-Features: Ac12FXzuQJf0OfGIeN2fiTU7wTr7AnxjCS-eRpQJZVTnko9Ayhhw1W6FQCOFlAc
Message-ID: <CADg4-L8iLwmp6GCscWCq9vwPTyavgi54i5KSjLPneULQHvwB9Q@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v3 2/3] mptcp: make ADD_ADDR retransmission
 timeout adaptive
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev, 
	Geliang Tang <tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 7:51=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi Geliang,
>
> On 10/08/2025 03:13, Geliang Tang wrote:
> > Hi Matt,
> >
> > On Thu, 2025-08-07 at 13:56 +0200, Matthieu Baerts wrote:
> >> Hi Geliang,
> >>
> >> On 07/08/2025 05:25, Geliang Tang wrote:
> >>> Hi Matt,
> >>>
> >>> On Wed, 2025-08-06 at 17:34 +0200, Matthieu Baerts wrote:
> >>>> Hi Geliang,
> >>>>
> >>>> On 06/08/2025 05:17, Geliang Tang wrote:
> >>>>> From: Geliang Tang <tanggeliang@kylinos.cn>
> >>>>>
> >>>>> Replace the fixed ADD_ADDR retransmission timeout with an
> >>>>> adaptive
> >>>>> mechanism that uses the maximum RTO among existing subflows.
> >>>>> This
> >>>>> improves responsiveness when establishing new subflows while
> >>>>> maintaining
> >>>>> an upper bound through the configured add_addr_timeout value.
> >>>>>
> >>>>> Key changes:
> >>>>> 1. Compute timeout as min(max_subflow_RTO,
> >>>>> configured_max_timeout)
> >>>>> 2. Apply exponential backoff based on retransmission count
> >>>>> 3. Maintain fallback to configured max timeout when no subflows
> >>>>> exist
> >>>>> 4. Update documentation to clarify add_addr_timeout is now the
> >>>>> maximum
> >>>>> value
> >>>>>
> >>>>> Closes:
> >>>>> https://github.com/multipath-tcp/mptcp_net-next/issues/576
> >>>>> Reviewed-by: Christoph Paasch <cpaasch@openai.com>
> >>>>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> >>>>> ---
> >>>>>  Documentation/networking/mptcp-sysctl.rst |  4 +--
> >>>>>  net/mptcp/pm.c                            | 30
> >>>>> ++++++++++++++++++++---
> >>>>>  2 files changed, 29 insertions(+), 5 deletions(-)
> >>>>>
> >>>>> diff --git a/Documentation/networking/mptcp-sysctl.rst
> >>>>> b/Documentation/networking/mptcp-sysctl.rst
> >>>>> index 1683c139821e..2b8e8fb99ee2 100644
> >>>>> --- a/Documentation/networking/mptcp-sysctl.rst
> >>>>> +++ b/Documentation/networking/mptcp-sysctl.rst
> >>>>> @@ -8,8 +8,8 @@ MPTCP Sysfs variables
> >>>>>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>>
> >>>>>  add_addr_timeout - INTEGER (seconds)
> >>>>> - Set the timeout after which an ADD_ADDR control
> >>>>> message
> >>>>> will be
> >>>>> - resent to an MPTCP peer that has not acknowledged a
> >>>>> previous
> >>>>> + Set the maximum value of timeout after which an
> >>>>> ADD_ADDR
> >>>>> control message
> >>>>> + will be resent to an MPTCP peer that has not
> >>>>> acknowledged
> >>>>> a previous
> >>>>>   ADD_ADDR message.
> >>>>>
> >>>>>   Do not retransmit if set to 0.
> >>>>> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> >>>>> index 1330af6a2154..34cc4f45bc7d 100644
> >>>>> --- a/net/mptcp/pm.c
> >>>>> +++ b/net/mptcp/pm.c
> >>>>> @@ -268,6 +268,30 @@ int mptcp_pm_mp_prio_send_ack(struct
> >>>>> mptcp_sock *msk,
> >>>>>   return -EINVAL;
> >>>>>  }
> >>>>>
> >>>>> +static unsigned int mptcp_adjust_add_addr_timeout(struct
> >>>>> mptcp_sock *msk)
> >>>>> +{
> >>>>> + struct mptcp_subflow_context *subflow;
> >>>>> + struct sock *sk =3D (struct sock *)msk;
> >>>>> + unsigned int max_rto =3D 0;
> >>>>> + unsigned int timeout;
> >>>>> +
> >>>>> + timeout =3D mptcp_get_add_addr_timeout(sock_net(sk));
> >>>>> +
> >>>>> + mptcp_for_each_subflow(msk, subflow) {
> >>>>> +         struct sock *ssk =3D
> >>>>> mptcp_subflow_tcp_sock(subflow);
> >>>>> +         unsigned int subflow_rto;
> >>>>> +
> >>>>> +         subflow_rto =3D __tcp_set_rto(tcp_sk(ssk)) * 2;
> >>>>
> >>>> Why "* 2"? Is it what TCP is doing?
> >>>>
> >>>> (Probably best to add a comment here above, and in the commit
> >>>> message.)
> >>>>
> >>>> (Also, I guess the compiler will do the optimisation, but you
> >>>> could
> >>>> write: ">> 1" instead of "* 2".
> >>>
> >>> Yes, "<< 1" is much better. I added a comment here:
> >>>
> >>> +               /*
> >>> +                * icsk->icsk_rto is not used directly since
> >>> +                * it's not updated frequently enough.
> >>> +                *
> >>> +                * subflow_rto is twice of rto, and allow
> >>> +                * some tolerance for add_addr echo.
> >>> +                */
> >>> +               subflow_rto =3D __tcp_set_rto(tcp_sk(ssk)) << 1;
> >>>
> >>> Is this okay?
> >>
> >> No :)
> >>
> >> I don't think the comment explain why it is twice the default TCP
> >> RTO.
> >> Why having an exception here for the ADD_ADDR? I mean: I'm OK with
> >> the
> >> idea of doubling the RTO, but only if there is a reason behind that
> >> :)
> >
> > How about this one (answered by DeepSeek, an AI from China):
> >
> >         /*
> >          * icsk->icsk_rto is not used directly since it's not
> >          * updated frequently enough.
>
> What about: (...) since it might not have been updated recently.
>
> >          * Setting subflow_rto to twice of RTO provides a safety
> >          * buffer for RTT estimation variance, kernel RTO update
> >          * delays, and a full transmission retry cycle while
> >          * minimizing false failures.
>
> A bit long and not clear (typical AI, making commit messages too
> verbose, it almost force me to use one to give me the summary :) )
>
> What about:
>
>   Setting this RTO to twice of TCP one, not to be too agressive for this
>   notification that might take longer to process than "simple" data.
>
> Still, is icsk_rto not already "long" enough by default? I mean: when I
> see your description in the related packetdrill PR [1] where the delay
> is supposed to be 0.01 sec, but "subflow_rto" (or was it isck_rto?) is
> 0.65 sec, that's quite different, and half of it would be more than
> enough :)
>
> But maybe that's different when it happens later during the connection?

Why wouldn't icsk_rto not be good enough ? We just need a reasonable
number here. And, I must say that 2 x __tcp_set_rto() seems a bit
arbitrary. Let's just use icsk_rto. Does it really matter that it is
not updated very frequently ?


Christoph

>
> [1] https://github.com/multipath-tcp/packetdrill/pull/166
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>
