Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96A22F80
	for <mptcp@lists.linux.dev>; Wed, 28 Apr 2021 15:38:45 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id d10so6623688pgf.12
        for <mptcp@lists.linux.dev>; Wed, 28 Apr 2021 08:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eZ3neTuJddVjc4hSPeBnmewmFg45J2+2wmbyRY+s9mc=;
        b=rKQgoxoXJdQccjeePfTrfIcbQyVWdk7EzHcjVh//VNm8WQEtZtY7WaWp4O1kn0rmml
         zD7pS9wyA4v4fj3g1xQ52XgtT5SD6mICpYfgx1PnwCEdu47ajBsC5qmXRNfjwRCr28GP
         AVE+orJw9dyquBuE/UH0x5kstYUH9dT/uRsN+SG1TFNVkAAxJiZ0N1tCGovBaMWsTfDT
         Bbs/lx52xrIH8auqPdm/3t5btX/KK3mecPT6RR/sfXZfAEOrwMht4ZqXaYD2XKFB7koA
         RsgYmf1oIYLW5sWhrlRu52iZVJelWxWp+jcupUIVlEzEUe90YjrtdSdTkyk1JN/jylGm
         Fgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eZ3neTuJddVjc4hSPeBnmewmFg45J2+2wmbyRY+s9mc=;
        b=MdfV6s7lRV5DsvYsFQG9aMUntpJfRbNTeD+sJAksWSI/e0XAsoX3JomARQG2jy7WnQ
         tn1fFm7aruEf/u7Uh70AI8iP4jZZFaitweitRoznYZvcpJi3LCxfcKr1OmxvVMdHyrgL
         Pd6WnNZgCVH0RQaYhYnDC90e39tYmSnnzOr2V7dlfJFhDfr79ChtDntTvHmz95u0chRU
         wwtooWbUQ6mxfOPu7D0m/Hk8D8VoC+kE8oX0641X0QVaDnWQi7VPooz3cmOCKXbArmBZ
         opEbXoq+R4Hy7s0lb5KRljjFHT+fpMtRkO/D6RQIAIsb2Cpjm9r2Jdtm+d1uhc5YMWcp
         nyrQ==
X-Gm-Message-State: AOAM533dLBRryAdfyGmTdbsL4QhWLXOyBqQVLSf0DviyifqpKpp5HgSf
	oDEmn8VCU4fWNQQEvXgMVJQhy9K5E2dnCpbISp+3xI3M
X-Google-Smtp-Source: ABdhPJyddUrcC4+CZCAvbqUI08XY1clwtgStKoEDSIRWgaiQD1SPWuYbBIm0RvILkyWK4fyAQlFuDBrRwukTcRaTroM=
X-Received: by 2002:a65:6282:: with SMTP id f2mr27184299pgv.289.1619624325185;
 Wed, 28 Apr 2021 08:38:45 -0700 (PDT)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1619592361.git.geliangtang@gmail.com> <51758a7f629764dc91186acbf09665992e5b8e69.1619592361.git.geliangtang@gmail.com>
 <65d1e4e729dfbeb5d0e51760affe2745e211cb50.1619592361.git.geliangtang@gmail.com>
 <c166cd5a8d0a2357650f0bb83f987deb4140ed23.1619592361.git.geliangtang@gmail.com>
 <20210428094312.GD975@breakpoint.cc>
In-Reply-To: <20210428094312.GD975@breakpoint.cc>
From: Geliang Tang <geliangtang@gmail.com>
Date: Wed, 28 Apr 2021 23:38:34 +0800
Message-ID: <CA+WQbwtZcOR=Wpfd-PAcJ_VeM85+MvqXxmCEE2rM+phQucNFgg@mail.gmail.com>
Subject: Re: [MPTCP][PATCH v2 mptcp-next 3/4] mptcp: add deny_join_id0 in mptcp_options_received
To: Florian Westphal <fw@strlen.de>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Florian,

Florian Westphal <fw@strlen.de> =E4=BA=8E2021=E5=B9=B44=E6=9C=8828=E6=97=A5=
=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=885:43=E5=86=99=E9=81=93=EF=BC=9A
>
> Geliang Tang <geliangtang@gmail.com> wrote:
> > diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> > index 9d00fa6d22e9..e3489766caf3 100644
> > --- a/net/mptcp/pm.c
> > +++ b/net/mptcp/pm.c
> > @@ -247,6 +247,15 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8=
 bkup)
> >       mptcp_event(MPTCP_EVENT_SUB_PRIORITY, mptcp_sk(subflow->conn), sk=
, GFP_ATOMIC);
> >  }
> >
> > +void mptcp_pm_deny_join_id0_received(struct mptcp_sock *msk)
> > +{
> > +     struct mptcp_pm_data *pm =3D &msk->pm;
> > +
> > +     spin_lock_bh(&pm->lock);
> > +     WRITE_ONCE(pm->deny_join_id0, true);
> > +     spin_unlock_bh(&pm->lock);
>
> Spinlock isn't needed.

Thanks for your review, updated it in v3.

-Geliang
