Content-Type: multipart/mixed; boundary="===============6116274632951098835=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] docs: networking: mptcp: Add MPTCP
 sysctl entries
Date: Tue, 03 Nov 2020 10:54:19 +0800
Message-ID: <CA+WQbwsnTcMwBNwzbJXrGohBHosAsJsguJrQQBS97Dz5uNmoRw@mail.gmail.com>
In-Reply-To: 20201103015542.16615-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 6519

--===============6116274632951098835==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

Mat Martineau <mathew.j.martineau(a)linux.intel.com> =E4=BA=8E2020=E5=B9=B4=
11=E6=9C=883=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=889:55=E5=86=99=E9=
=81=93=EF=BC=9A
>
> Describe the two MPTCP sysctls, what the values mean, and the default
> settings.
>
> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> ---
>
> Jakub requested sysctl documentation for the 'add_addr_timeout' setting,
> and we didn't have our 'enabled' sysctl documented either.
>
> If this looks good to everyone I can add it to v2 the miscellaneous
> series on the netdev list.
>

Thanks for your help.

Acked-by: Geliang Tang <geliangtang(a)gmail.com>

-Geliang

>
>  Documentation/networking/index.rst        |  1 +
>  Documentation/networking/mptcp-sysctl.rst | 24 +++++++++++++++++++++++
>  MAINTAINERS                               |  1 +
>  3 files changed, 26 insertions(+)
>  create mode 100644 Documentation/networking/mptcp-sysctl.rst
>
> diff --git a/Documentation/networking/index.rst b/Documentation/networkin=
g/index.rst
> index 63ef386afd0a..70c71c9206e2 100644
> --- a/Documentation/networking/index.rst
> +++ b/Documentation/networking/index.rst
> @@ -70,6 +70,7 @@ Contents:
>     lapb-module
>     mac80211-injection
>     mpls-sysctl
> +   mptcp-sysctl
>     multiqueue
>     netconsole
>     netdev-features
> diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/ne=
tworking/mptcp-sysctl.rst
> new file mode 100644
> index 000000000000..70c076eb361d
> --- /dev/null
> +++ b/Documentation/networking/mptcp-sysctl.rst
> @@ -0,0 +1,24 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +MPTCP Sysfs variables
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +/proc/sys/net/mptcp/* Variables:
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> +
> +enabled - INTEGER
> +       Control whether MPTCP sockets can be created.
> +
> +       MPTCP sockets can be created if the value is nonzero.
> +
> +       Default: 1
> +
> +add_addr_timeout - INTEGER (seconds)
> +       Set the timeout after which an ADD_ADDR control message will be
> +       resent to an MPTCP peer that has not acknowledged a previous
> +       ADD_ADDR message.
> +
> +       The default value matches TCP_RTO_MAX.
> +
> +       Default: 120
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 17f5571788c9..badaaa815aa3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12265,6 +12265,7 @@ L:      mptcp(a)lists.01.org
>  S:     Maintained
>  W:     https://github.com/multipath-tcp/mptcp_net-next/wiki
>  B:     https://github.com/multipath-tcp/mptcp_net-next/issues
> +F:     Documentation/networking/mptcp-sysctl.rst
>  F:     include/net/mptcp.h
>  F:     include/uapi/linux/mptcp.h
>  F:     net/mptcp/
> --
> 2.29.2
>
--===============6116274632951098835==--
