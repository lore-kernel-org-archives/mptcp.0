Content-Type: multipart/mixed; boundary="===============3154639190776950483=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 0/2] mptcp: cope better with MP_JOIN failure
Date: Thu, 07 May 2020 08:56:44 -0700
Message-ID: <20200507155644.GF38702@MacBook-Pro-64.local>
In-Reply-To: cover.1588861016.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4343

--===============3154639190776950483==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Looks good overall! Just had one comment on patch 2.


Christoph

On 07/05/20 - 16:30:22, Paolo Abeni wrote:
> This is an attempt to fix the weird behavior we currently have on MP JOIN
> failures.
> In the end I was unable to find a way to address the thing without touchi=
ng
> tcp_check_req(), but this is an attempt to keep the impact for !MPTCP bui=
ld
> null, and the MPTCP overhead as low as possible.
> =

> Paolo Abeni (2):
>   mptcp: add new sock flag to deal with join subflows
>   mptcp: cope better with MP_JOIN failure
> =

>  include/linux/tcp.h      |  1 +
>  include/net/mptcp.h      | 17 ++++++++++-------
>  net/ipv4/tcp_minisocks.c |  2 +-
>  net/mptcp/protocol.c     |  7 -------
>  net/mptcp/subflow.c      | 19 +++++++++++++------
>  5 files changed, 25 insertions(+), 21 deletions(-)
> =

> -- =

> 2.21.1
>=20
--===============3154639190776950483==--
