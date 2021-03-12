Content-Type: multipart/mixed; boundary="===============4012204496753772459=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] Squash to "selftests: mptcp: add addr
 argument for del_addr"
Date: Fri, 12 Mar 2021 22:50:07 +0800
Message-ID: <CA+WQbwucg0LrQMikAjWSLxH8XwemL5K2qaaMv_hXx7smsXENmQ@mail.gmail.com>
In-Reply-To: 06e6c623-6f6f-d1b4-247e-020f4e65295c@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 8119

--===============4012204496753772459==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts(a)tessares.net> =E4=BA=8E2021=E5=B9=B43=E6=
=9C=8812=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=8810:36=E5=86=99=E9=81=
=93=EF=BC=9A
>
> Hi Geliang,
>
> On 12/03/2021 15:28, Geliang Tang wrote:
> > Matthieu Baerts <matthieu.baerts(a)tessares.net> =E4=BA=8E2021=E5=B9=B4=
3=E6=9C=8812=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=8810:11=E5=86=99=E9=
=81=93=EF=BC=9A
> >> On 12/03/2021 15:06, Geliang Tang wrote:
> >>> Matthieu Baerts <matthieu.baerts(a)tessares.net> =E4=BA=8E2021=E5=B9=
=B43=E6=9C=8812=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=888:54=E5=86=99=
=E9=81=93=EF=BC=9A
>
> (...)
>
> >>>> Notes:
> >>>>       to be squashed in "selftests: mptcp: add addr argument for del=
_addr"
> >>>
> >>> I think this patch should be a single standalone patch, not a squash-=
to
> >>> one.
> >>
> >> If I do the modification you propose, should I not keep this as a
> >> squash-to patch?
> >
> > I think a standalone patch is better. Or squash to the other commit
> > "selftests: mptcp: remove id 0 address testcases", not "selftests: mptc=
p:
> > add addr argument for del_addr", WDYT?
>
> The issue was visible with "selftests: mptcp: add addr argument for
> del_addr" but I understand the issue was already there before.
>
> I can write a new patch to place before "selftests: mptcp: remove id 0
> address testcases".

Thanks Matt, please add my tag on the new patch:

Acked-by: Geliang Tang <geliangtang(a)gmail.com>

-Geliang

>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
--===============4012204496753772459==--
