Content-Type: multipart/mixed; boundary="===============1099865968966119397=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 00/11] Multipath TCP part 1: Prerequisites
Date: Fri, 13 Dec 2019 13:39:09 -0800
Message-ID: <5b54656cd885600580eb2dae7c1742d4477f2250.camel@linux.intel.com>
In-Reply-To: 20191213204824.2464461-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3021

--===============1099865968966119397==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Other than my one comment on 8/11 these look good to go.

Peter.

On Fri, 2019-12-13 at 21:48 +0100, Matthieu Baerts wrote:
> The MPTCP upstreaming community has been collaborating on an
> upstreamable MPTCP implementation that complies with RFC 8684. A minimal
> set of features to comply with the specification involves a sizeable set
> of code changes, so David requested that we split this work in to
> multiple, smaller patch sets to build up MPTCP infrastructure.
> =

> The minimal MPTCP feature set we are proposing for the v5.6 timeframe is
> split in to these parts for review:
> =

> Part 1 (this patch set): MPTCP prerequisites. Introduce some MPTCP
> definitions, additional ULP and skb extension features, TCP option space
> checking, and a few exported symbols.
> =

> Part 2: Single subflow implementation and self tests.
> =

> Part 3: Switch from MPTCP v0 (RFC 6824) to MPTCP v1 (new RFC 8684,
> publication expected in the next few days).
> =

> Clone/fetch:
> https://github.com/multipath-tcp/mptcp_net-next.git (tag: netdev-v1-part1)
> =

> Browse:
> https://github.com/multipath-tcp/mptcp_net-next/tree/netdev-v1-part1
> =

> Thank your for your review. You can find us at mptcp(a)lists.01.org and
> https://is.gd/mptcp_upstream
> =

> Mat Martineau (9):
>   net: Make sock protocol value checks more specific
>   sock: Make sk_protocol a 16-bit value
>   tcp: Define IPPROTO_MPTCP
>   tcp: Add MPTCP option number
>   tcp, ulp: Add clone operation to tcp_ulp_ops
>   mptcp: Add MPTCP to skb extensions
>   tcp: Prevent coalesce/collapse when skb has MPTCP extensions
>   tcp: Export TCP functions and ops struct
>   tcp: Check for filled TCP option space before SACK
> =

> Paolo Abeni (2):
>   tcp: clean ext on tx recycle
>   skb: add helpers to allocate ext independently from sk_buff
> =

>  MAINTAINERS                     | 10 ++++++++
>  include/linux/skbuff.h          |  6 +++++
>  include/net/mptcp.h             | 43 +++++++++++++++++++++++++++++++++
>  include/net/sock.h              |  6 ++---
>  include/net/tcp.h               | 22 +++++++++++++++++
>  include/trace/events/sock.h     |  5 ++--
>  include/uapi/linux/in.h         |  2 ++
>  net/ax25/af_ax25.c              |  2 +-
>  net/core/skbuff.c               | 42 ++++++++++++++++++++++++++++++--
>  net/decnet/af_decnet.c          |  2 +-
>  net/ipv4/inet_connection_sock.c |  2 ++
>  net/ipv4/tcp.c                  |  6 ++---
>  net/ipv4/tcp_input.c            | 10 ++++++--
>  net/ipv4/tcp_ipv4.c             |  2 +-
>  net/ipv4/tcp_output.c           |  5 +++-
>  net/ipv4/tcp_ulp.c              | 12 +++++++++
>  net/ipv6/tcp_ipv6.c             |  6 ++---
>  tools/include/uapi/linux/in.h   |  2 ++
>  18 files changed, 166 insertions(+), 19 deletions(-)
>  create mode 100644 include/net/mptcp.h
>=20

--===============1099865968966119397==--
