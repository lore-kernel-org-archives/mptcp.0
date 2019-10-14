Content-Type: multipart/mixed; boundary="===============5467548017386740969=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 0/2] mptcp: disallow setting the MPTCP ULP from
 userspace
Date: Mon, 14 Oct 2019 16:56:11 +0200
Message-ID: <522a00033466da18009813089ad908f86fdf0466.camel@redhat.com>
In-Reply-To: cover.1571061853.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2110

--===============5467548017386740969==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-10-14 at 16:46 +0200, Davide Caratti wrote:
> with this series we make
> =

> setscokopt(..., IPPROTO_TCP, TCP_ULP, "mptcp", sizeof("mptcp"));
> =

> return -1 and set errno to -EOPNOPSUPPORT.
> =

> this allows attaching MPTCP ULP only to a TCP socket that has been
> created through sock_create_kern().
> =

> - Patch 1/2 lets subflow_init() fail with -EOPNOTSUPPORT in case users
>   try to setsockopt(..., TCP_ULP) on a TCP socket that has been created
>   by a userspace program. I suggest squashing this patch in "mptcp:
>   Associate MPTCP context with TCP socket".
> - Patch 2/2 includes kselftest code. I suggest squashing it with "mptcp:
>   add basic kselftest for mptcp".
> =

> Changes since v1:
>  - don't redirect the selftest output to /dev/null =

>  - test output depends on the value of 'errno', to avoid false negative
>    in case kernel is built without CONFIG_MPTCP
> =

> Davide Caratti (2):
>   mptcp: subflow: disallow setsockopt(... TCP_ULP, "mptcp")
>   selftests: test setsockopt(..., TCP_ULP, "mptcp", ...)
> =

>  net/mptcp/subflow.c                           |  7 +++
>  .../selftests/net/mptcp/mptcp_connect.c       | 52 +++++++++++++++++--
>  .../selftests/net/mptcp/mptcp_connect.sh      | 19 +++++++
>  3 files changed, 75 insertions(+), 3 deletions(-)

The patches LGTM, thanks Davide!

/P

--===============5467548017386740969==--
