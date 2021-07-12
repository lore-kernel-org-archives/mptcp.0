Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DAD168
	for <mptcp@lists.linux.dev>; Mon, 12 Jul 2021 10:35:04 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id 21so15997030pfp.3
        for <mptcp@lists.linux.dev>; Mon, 12 Jul 2021 03:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0kNQVhzQ4VoAKd7y9F5CRhw6Uh8QOWhwQbVaOC+Lf1U=;
        b=j+j+70E3BM4tdVlkJ5FcsKZM/b7/B5KyWJrEBrIEeI4jJo49X53WTg/Yr+dGQxJVEW
         MZFblYWkgJgnacGkK3M/iFo1y0KdKNamCflytQQtoSGaUN+Zv1O6ziPab5ldrnGixOyH
         H/+p6Sv9AvO8XWOUDKeHT5O7MBb0eeGOm/G2Lg4IEmGZ2AFN0w8AekX/uN/xDTA9f+Il
         /Vdy1vVxdsJPU9hqCfFTpR2BByvdtR9qkidXlihVOp8yFnBF9BUlQpED3AA4UO/IG94E
         ql60warx+VPmMMZ5c6WjLmjriqRKTEbYSvBDfYbHOKMWwC/xb9lYXsQapMGasm2jehbF
         VA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0kNQVhzQ4VoAKd7y9F5CRhw6Uh8QOWhwQbVaOC+Lf1U=;
        b=Off35GP/JQrp21d8H3/82HXNl/iDvlwaTVjh8Wg0QrvE37MHjUqDcAmCl6hg9z4xZE
         QcU0pJMSCDGJxX2iYwyfl56WudJP4GWUX4QUNT9FT7EqYr7bnx7EHXvB8TXmjDE0VR7l
         dYvSWcUrK4RX257bYZq7vdl/o+vjZChexsH2dJ2lmU2OQe3jvboy03T2fmz+5JezDkzm
         O1z540B3RQCeFMx2ggk4E75Fvrjabk/7cKcaXIP/0gmTVpP5/22H5Sla59rf7ccPlmrq
         aXQg7phC2v1dUYAkYuOPeYisrx8jNhAdikhVfeqSwx9WXX4yvE93CVGNwzMNaidOviCH
         TgAg==
X-Gm-Message-State: AOAM5338rhcbiVX+SiocY4uqjfMDoNUfbH5MZjLDf0FM3+3zEkWtX78j
	I0tv3SoEwpS54GH3JDqYUwKo4i3awnTMcy32w90=
X-Google-Smtp-Source: ABdhPJznPKHS5O7PTcLNQlTzZWI/UoPT9xcCJqvGkV9ZxU7YTK1M/VVVCEfQsWBU7GpPT3Fj18jFjYiJ3TioybVNgpQ=
X-Received: by 2002:a63:5a4b:: with SMTP id k11mr53326555pgm.289.1626086104387;
 Mon, 12 Jul 2021 03:35:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <9365b79b245b8a87af18ca458c67820d47de2515.1626016228.git.geliangtang@gmail.com>
 <5802c6e8aac9d3a6502fd3a8e9cdda01f658dbcf.1626016245.git.geliangtang@gmail.com>
 <11cc4e68-8daa-0148-15ef-6b3bbccabc96@chinatelecom.cn>
In-Reply-To: <11cc4e68-8daa-0148-15ef-6b3bbccabc96@chinatelecom.cn>
From: Geliang Tang <geliangtang@gmail.com>
Date: Mon, 12 Jul 2021 18:34:53 +0800
Message-ID: <CA+WQbwuTi7iqN-2=b0kehULSABvVJ_ayS-w+ahbBPQq8i7mGgg@mail.gmail.com>
Subject: Re: [MPTCP][PATCH mptcp-next] Squash to "mptcp: fix ADD_ADDR and
 RM_ADDR maybe flush addr_signal each other"
To: Yonglong Li <liyonglong@chinatelecom.cn>
Cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yonglong Li <liyonglong@chinatelecom.cn> =E4=BA=8E2021=E5=B9=B47=E6=9C=8812=
=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=885:55=E5=86=99=E9=81=93=EF=BC=
=9A
>
>
>
> On 2021/7/11 23:15, Geliang Tang wrote:
> > Add READ_ONCE() for reading msk->pm.addr_signal.
> >
> > Use mptcp_pm_should_add_signal_echo instead of open coding.
> >
> > Use '&=3D' to clear flag.
> >
> > Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> > ---
> >  net/mptcp/pm.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> > index c9622696716e..be16da2dcb6b 100644
> > --- a/net/mptcp/pm.c
> > +++ b/net/mptcp/pm.c
> > @@ -257,6 +257,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *ms=
k, unsigned int remaining,
> >                             struct mptcp_addr_info *saddr, bool *echo, =
bool *port)
> >  {
> >       int ret =3D false;
> > +     u8 add_addr;
> >
> >       spin_lock_bh(&msk->pm.lock);
> >
> > @@ -271,10 +272,12 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *=
msk, unsigned int remaining,
> >               goto out_unlock;
> >
> >       *saddr =3D msk->pm.local;
> > -     if ((msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_ECHO)))
> > -             WRITE_ONCE(msk->pm.addr_signal, msk->pm.addr_signal & ~BI=
T(MPTCP_ADD_ADDR_ECHO));
> > +     add_addr =3D READ_ONCE(msk->pm.addr_signal);
> > +     if (mptcp_pm_should_add_signal_echo(msk))
> > +             add_addr &=3D ~BIT(MPTCP_ADD_ADDR_ECHO);
> >       else
> > -             WRITE_ONCE(msk->pm.addr_signal, msk->pm.addr_signal & ~BI=
T(MPTCP_ADD_ADDR_SIGNAL));
> > +             add_addr &=3D ~BIT(MPTCP_ADD_ADDR_SIGNAL);
> > +     WRITE_ONCE(msk->pm.addr_signal, add_addr);
> >       ret =3D true;
> >
> >  out_unlock:
> > @@ -294,7 +297,8 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk=
, unsigned int remaining,
> >       if (!mptcp_pm_should_rm_signal(msk))
> >               goto out_unlock;
> >
> > -     rm_addr =3D msk->pm.addr_signal & ~BIT(MPTCP_RM_ADDR_SIGNAL);
> > +     rm_addr =3D READ_ONCE(msk->pm.addr_signal);
> > +     rm_addr &=3D ~BIT(MPTCP_RM_ADDR_SIGNAL);
> >       len =3D mptcp_rm_addr_len(&msk->pm.rm_list_tx);
> >       if (len < 0) {
> >               WRITE_ONCE(msk->pm.addr_signal, rm_addr);
> >
>
> These chunk of code is under the pm.lock so It is no need to use READ_ONC=
E() as Paolo saied before.

I'll drop this READ_ONCE() in v2.

>
> --
> Li YongLong
