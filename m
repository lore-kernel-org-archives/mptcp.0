Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287F870
	for <mptcp@lists.linux.dev>; Sat,  8 May 2021 02:58:56 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id lp4so6257108pjb.1
        for <mptcp@lists.linux.dev>; Fri, 07 May 2021 19:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PgcfNTAswK0HX0UART+myHszZ4DAqTfvNUL6mW6q12o=;
        b=cqeG+WqwLWy9uYmDwxneJeXLmKCbAh9D3zsDrLbKRKafkm4Q8TjNHwqKc0o5e4sX7Y
         FqqWKpI62rr4H/kOgsVpLuIJSK/pBdJT9r37aFcmyhZNdJINj+u/p4qLwb1GEDx+Oj5X
         AWZrX8254Nk79//deZtBt1yweThzW6tP2BA2+Y6jXuVWiNutjtmmVnm+owbVtdcWsirA
         5t0WwaipX6rGnDu3p2I+lhtGjl7X8PsqW0mlMig8bZhlVyKJ3r5QEJDUydr1S2rCJRps
         /d5dm5n0gW3jppuiouNh3Mvw1QKBGDeUVy08lwehH1GRoTfIwFIUbZ/17Pgd45jnnxI+
         bz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PgcfNTAswK0HX0UART+myHszZ4DAqTfvNUL6mW6q12o=;
        b=slafi0gnIf2BIjLbj4I55+rqoDuaLFzI2RT1i0ELGA+SCPyTYjoqM4V/Yoy4d/w8GU
         eBMYH7Nn0HqYHjtJOh3buu7XHtuj4QBK+zLzk/4x9a3E1RTvSFgeuThOclgRjgw1yy/s
         hw5KzJmZkUwKIvmr8NkZJlTv4FPKvT2CAiUg8X7SP0hxyE5z2wN4UXrSgwoQ+GlR+tRQ
         12ukzf+pN+TaH4EiZRS46pHoGfMDeFAUMyfRI7GOrS8hJPy5d18SaCKAj8pphoVybl8I
         j2xOBqTvjskVQ0e9yQy3EyGoNGZ0wBlhOP/oIytW0c4DNkHTeKb0XKyi14CoequkimSI
         SkkQ==
X-Gm-Message-State: AOAM5325xWKY3TNKKkQuy//LtjxZ26mYC0cSkeuIDEIwBdOF6IOI+rJ3
	iV3THJ6Y3uedycnSa+0jtdKK2rgIk8+bBsXEk3Vsv/YO+T8=
X-Google-Smtp-Source: ABdhPJyRjS2FxGd0FnwTGWYl2E1m1zt7vnWB/obt5CRiXYwYBMDUNJoNvjhOKySiME4ZdWpbTBMJ/Gzj2fY+17XZ3xo=
X-Received: by 2002:a17:90b:34a:: with SMTP id fh10mr27965152pjb.123.1620442735694;
 Fri, 07 May 2021 19:58:55 -0700 (PDT)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <c8b33d7b10e063f3bd93d25955d539a6af7f0372.1620374286.git.geliangtang@gmail.com>
 <c92941a2-d629-ae34-23e3-18faec2a3750@tessares.net> <CA+WQbwvfLSqK5uWUmNrPwzazwXV2HNUXU_8HUz6dxifYmRTGCw@mail.gmail.com>
 <619cd782-bb39-c284-b59e-546a0aea3e3d@tessares.net> <6b70c2a8-f705-219f-8b1a-ff74a1261a8d@tessares.net>
In-Reply-To: <6b70c2a8-f705-219f-8b1a-ff74a1261a8d@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Sat, 8 May 2021 10:58:44 +0800
Message-ID: <CA+WQbwupHRDX29f7=eCb-9UxD_r19ypn0Cz523doN-+EK-9UQQ@mail.gmail.com>
Subject: Re: [MPTCP][PATCH mptcp-next] mptcp: don't fallback when data_fin enabled
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt, Paolo,

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2021=E5=B9=B45=E6=
=9C=887=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=8811:23=E5=86=99=E9=81=
=93=EF=BC=9A
>
> On 07/05/2021 14:19, Matthieu Baerts wrote:
> > Hi Geliang,
> >
> > On 07/05/2021 11:08, Geliang Tang wrote:
> >> Hi Matt,
> >>
> >> Thanks for your review.
> >>
> >> Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2021=E5=B9=B45=
=E6=9C=887=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=884:51=E5=86=99=E9=81=
=93=EF=BC=9A
> >>>
> >>> Hi Geliang,
> >>>
> >>> On 07/05/2021 09:58, Geliang Tang wrote:
> >>>> This patch fixed this fallback error:
> >>>
> >>> Thank you for the patch!
> >>>
> >>>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> >>>> index f3e379a0f08d..940b32511443 100644
> >>>> --- a/net/mptcp/options.c
> >>>> +++ b/net/mptcp/options.c
> >>>> @@ -901,7 +901,7 @@ static bool check_fully_established(struct mptcp=
_sock *msk, struct sock *ssk,
> >>>>        * MP_JOIN subflows.
> >>>>        */
> >>>>       if (!mp_opt->mp_capable) {
> >>>> -             if (subflow->mp_join)
> >>>> +             if (subflow->mp_join || mptcp_data_fin_enabled(msk))> =
                  goto reset;
> >>>
> >>> I don't think we should send a reset here. For me this behaviour is n=
ormal.
> >>
> >> Yes, we don't need to send a reset here. What about just return here?
> >> Something like this:
> >>
> >> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> >> index 3428c163299b..bd62dadfefdb 100644
> >> --- a/net/mptcp/options.c
> >> +++ b/net/mptcp/options.c
> >> @@ -905,6 +905,8 @@ static bool check_fully_established(struct
> >> mptcp_sock *msk, struct sock *ssk,
> >>         if (!mp_opt->mp_capable) {
> >>                 if (subflow->mp_join)
> >>                         goto reset;
> >> +               if (mptcp_data_fin_enabled(msk))
> >> +                       return false;
> >>                 subflow->mp_capable =3D 0;
> >>                 pr_fallback(msk);
> >>                 __mptcp_do_fallback(msk);
> >
> > I think we still need to do a fallback here not to expect a DATA_ACK.
> > For example in __mptcp_check_send_data_fin(), we change the state
> > because we will not get a DATA_ACK.
> >
> > So I think everything is OK there.
> >
> > Just one thing: should we send a DATA_FIN if we were not "fully
> > established" when closing the socket?
>
> Paolo shared this answer on IRC:
>
>   I would say yes. The server side could have already allocated the msk
> socket (and the 4th ack could have been lost)
>
> Which makes sense.
>
> So I think we should not do anything here. Except maybe a comment here
> in the code? e.g.
>

I think it's a little strange to include only a comment in a patch. Let's
just drop this patch (mptcp: don't fallback when data_fin enabled), and
close the ticket #176.

Thanks.

-Geliang

>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 3428c163299b..43d55039743a 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -905,6 +905,14 @@ static bool check_fully_established(struct
> mptcp_sock *msk, struct sock *ssk,
>         if (!mp_opt->mp_capable) {
>                 if (subflow->mp_join)
>                         goto reset;
> +
> +               /* We also want to fallback if the connection is closed
> while we
> +                * were not in fully established mode.
> +                * But we still want to send the DATA_FIN if the
> userspace has
> +                * closed the connection at this stage, just in case the
> server
> +                * side has already allocated the msk socket or if the
> 4th ACK
> +                * has been lost.
> +                */
>                 subflow->mp_capable =3D 0;
>                 pr_fallback(msk);
>                 __mptcp_do_fallback(msk);
>
>
> Cheers,
> Matt
>
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
