Content-Type: multipart/mixed; boundary="===============4617335087159757316=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next 0/4] Squash to "ADD_ADDR: ports
 support v3"
Date: Tue, 10 Nov 2020 13:19:20 +0800
Message-ID: <CA+WQbwtoVm5PWo_PLsVVRiF+Z3qHfb-vW+pKXnaLFpP_tjnTog@mail.gmail.com>
In-Reply-To: cover.1604845519.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6641

--===============4617335087159757316==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Geliang Tang <geliangtang(a)gmail.com> =E4=BA=8E2020=E5=B9=B411=E6=9C=888=
=E6=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8B=E5=8D=8810:43=E5=86=99=E9=81=93=EF=BC=
=9A
>
> This patchset includes three squash-to patches and a new patch. They all
> should be squashed into the "ADD_ADDR: ports support" series.
>
> All three squash-to patches's commit massages need to be updated.
>
> The new patch should be inserted into the patchset after the 8th patch
> "mptcp: print out port and ahmac when receiving ADD_ADDR".
>

This patchset is obsolete. It have been merged into the "ADD_ADDR: ports
support" series v4.

-Geliang

>
> Geliang Tang (4):
>   Squash to "mptcp: add port support for ADD_ADDR suboption writing"
>   mptcp: add port number check for MP_JOIN
>   Squash to "mptcp: add the mib for ADD_ADDR with port"
>   Squash to "selftests: mptcp: add testcases for ADD_ADDR with port"
>
>  net/mptcp/mib.c                               |  3 +
>  net/mptcp/mib.h                               |  3 +
>  net/mptcp/options.c                           | 17 +++---
>  net/mptcp/pm_netlink.c                        | 12 ++++
>  net/mptcp/protocol.h                          |  1 +
>  net/mptcp/subflow.c                           | 37 ++++++++++++
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 56 ++++++++++++++++---
>  7 files changed, 114 insertions(+), 15 deletions(-)
>
> --
> 2.26.2
>
--===============4617335087159757316==--
