Content-Type: multipart/mixed; boundary="===============6667351061507008495=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] Squash-to: "mptcp: cope with later TCP fallback"
Date: Tue, 21 Jan 2020 21:40:59 +0100
Message-ID: <f1b14c29e7ccf456d0316203db679a9641f8f91b.camel@redhat.com>
In-Reply-To: aa9bbf76-4c32-eee8-bc4e-25c73169f5fb@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3455

--===============6667351061507008495==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-01-21 at 18:20 +0100, Matthieu Baerts wrote:
> Hi Paolo, Mat,
> =

> On 21/01/2020 17:32, Paolo Abeni wrote:
> > kbuildbot reported a build breakage with IPV6 disabled.
> =

> Do you know why my CI didn't get the issue?
> =

> It runs:
> =

>    make defconfig
>    echo | scripts/config -d (...) ## to disable DRM, SOUND, USB, etc.
>    echo | scripts/config -e MPTCP -e MPTCP_IPV6
>    echo | scripts/config -d IPV6 -d MPTCP_IPV6
>    make
> =

> MPTCP is enabled and IPV6 is not.
> =

> Which combination did I miss?

weird. I can reproduce the build failure with

CONFIG_MPTCP=3Dy
# CONFIG_IPV6 is not set
# CONFIG_MPTCP_IPV6 is not set


net/mptcp/protocol.o: In function `__mptcp_fallback_to_tcp':
/home/pabeni/linux-net/net/mptcp/protocol.c:63: undefined reference to
`inet6_stream_ops'

the inet6_stream_ops struct is unconditionally referenced by the mptcp
code.

/P


--===============6667351061507008495==--
