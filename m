Content-Type: multipart/mixed; boundary="===============7327218746180273260=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v4 mptcp-next 0/2] drop rm_addr_signal flag
 and more
Date: Thu, 26 Nov 2020 11:02:38 +0800
Message-ID: <CA+WQbwsvcF+80kw6R4FTskw_kdQfyby1tXm1wntHgM_XXrw4xA@mail.gmail.com>
In-Reply-To: cover.1605866519.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6942

--===============7327218746180273260==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matt,

The two patches of v4 are all reviewed by Mat, please help me to merge them
into the export breach with Mat's Reviewed-by tags.

Thanks.

-Geliang

Geliang Tang <geliangtang(a)gmail.com> =E4=BA=8E2020=E5=B9=B411=E6=9C=8820=
=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=886:06=E5=86=99=E9=81=93=EF=BC=
=9A

>
> v4:
>  - add the current add_addr/rm_addr value for pm_warn
>
> v3:
>  - use pr_warn
>
> v2:
>  - use pr_err instead of WARN_ON_ONCE
>
> Geliang Tang (2):
>   mptcp: drop rm_addr_signal flag
>   mptcp: rename add_addr_signal and mptcp_add_addr_status
>
>  net/mptcp/pm.c         | 26 +++++++++++++++++++-------
>  net/mptcp/pm_netlink.c |  4 ++--
>  net/mptcp/protocol.h   | 16 ++++++++--------
>  3 files changed, 29 insertions(+), 17 deletions(-)
>
> --
> 2.26.2
>
--===============7327218746180273260==--
