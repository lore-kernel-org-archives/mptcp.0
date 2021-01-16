Content-Type: multipart/mixed; boundary="===============5304812453699039015=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] Squash to "mptcp: drop *_max fields in
 mptcp_pm_data"
Date: Sat, 16 Jan 2021 19:51:11 +0800
Message-ID: <CA+WQbwv7Wj6sPYbbzZnfEEmH0-wKDuC52-KveNRVCFVAZK3ZJw@mail.gmail.com>
In-Reply-To: efaecd93-680c-77f0-7b0b-65a15ec35c73@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 7411

--===============5304812453699039015==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Matthieu Baerts <matthieu.baerts(a)tessares.net> =E4=BA=8E2021=E5=B9=B41=E6=
=9C=8816=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=887:49=E5=86=99=E9=81=
=93=EF=BC=9A
>
> Hi
>
> On 16/01/2021 12:36, Matthieu Baerts wrote:
> > We need to export these functions that are also used in mptcp_diag.c
> > which can be part of a separated module.
> >
> > We can then avoid these errors:
> >
> >    ERROR: modpost: "mptcp_pm_get_add_addr_accept_max" [net/mptcp/mptcp_=
diag.ko] undefined!
> >    ERROR: modpost: "mptcp_pm_get_add_addr_signal_max" [net/mptcp/mptcp_=
diag.ko] undefined!
> >    ERROR: modpost: "mptcp_pm_get_subflows_max" [net/mptcp/mptcp_diag.ko=
] undefined!
>
> This is now applied in our git repo.
>

Thanks for this fix.

-Geliang

> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
--===============5304812453699039015==--
