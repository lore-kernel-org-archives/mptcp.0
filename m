Content-Type: multipart/mixed; boundary="===============1784173997436224119=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 8/9] selftests: add PM netlink functional tests
Date: Fri, 21 Feb 2020 17:25:35 +0100
Message-ID: <caf990180194bbfbd30dbb12abe0854b36d4070c.camel@redhat.com>
In-Reply-To: e4307bf91c05a491555683174a076c51425afa92.1582297150.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3727

--===============1784173997436224119==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-02-21 at 17:17 +0100, Paolo Abeni wrote:
> This introduces basic self-tests for the PM netlink,
> checking the basic APIs and possible exceptional
> values.
> =

> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
>  tools/testing/selftests/net/mptcp/Makefile    |   5 +-
>  .../testing/selftests/net/mptcp/pm_netlink.sh | 123 ++++
>  tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 600 ++++++++++++++++++
>  3 files changed, 726 insertions(+), 2 deletions(-)
>  create mode 100755 tools/testing/selftests/net/mptcp/pm_netlink.sh
>  create mode 100644 tools/testing/selftests/net/mptcp/pm_nl_ctl.c
> =

> diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/s=
elftests/net/mptcp/Makefile
> index 93de52016dde..c47069c18e41 100644
> --- a/tools/testing/selftests/net/mptcp/Makefile
> +++ b/tools/testing/selftests/net/mptcp/Makefile
> @@ -1,12 +1,13 @@
>  # SPDX-License-Identifier: GPL-2.0
>  =

>  top_srcdir =3D ../../../../..
> +KSFT_KHDR_INSTALL :=3D 1
>  =

> -CFLAGS =3D  -Wall -Wl,--no-as-needed -O2 -g
> +CFLAGS =3D  -Wall -Wl,--no-as-needed -O2 -g  -I$(top_srcdir)/usr/include
>  =

>  TEST_PROGS :=3D mptcp_connect.sh
>  =

> -TEST_GEN_FILES =3D mptcp_connect
> +TEST_GEN_FILES =3D mptcp_connect pm_nl_ctl
>  =

>  EXTRA_CLEAN :=3D *.pcap
>  =


Dumb me! I forgot to update $TEST_PROGS. I did not notice, since I
always execute the tests script outside the self-tests suite. =


I'll send a v3 soon.

Sorry for the noise,

Paolo

--===============1784173997436224119==--
