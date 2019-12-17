Content-Type: multipart/mixed; boundary="===============0799985656742640492=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v3 00/11] Multipath TCP: Prerequisites
Date: Tue, 17 Dec 2019 12:37:56 -0800
Message-ID: <20191217203807.12579-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 3122

--===============0799985656742640492==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v2 -> v3: Ensure sk_type alignment in struct sock (patch 2)

v1 -> v2: sk_pacing_shift left as a regular struct member (patch 2), and
modified SACK space check based on recent -net fix (patch 9).


The MPTCP upstreaming community has been collaborating on an
upstreamable MPTCP implementation that complies with RFC 8684. A minimal
set of features to comply with the specification involves a sizeable set
of code changes, so David requested that we split this work in to
multiple, smaller patch sets to build up MPTCP infrastructure.

The minimal MPTCP feature set we are proposing for review in the v5.6
timeframe begins with these three parts:

Part 1 (this patch set): MPTCP prerequisites. Introduce some MPTCP
definitions, additional ULP and skb extension features, TCP option space
checking, and a few exported symbols.

Part 2: Single subflow implementation and self tests.

Part 3: Switch from MPTCP v0 (RFC 6824) to MPTCP v1 (new RFC 8684,
publication expected in the next few days).

We plan to send those over the next week. Additional patches for
multiple subflow support, path management, active backup, and other
features are in the pipeline for submission after making progress with
the above reviews.

Clone/fetch:
https://github.com/multipath-tcp/mptcp_net-next.git (tag: netdev-v3-part1)

Browse:
https://github.com/multipath-tcp/mptcp_net-next/tree/netdev-v3-part1

Thank you for your review. You can find us at mptcp(a)lists.01.org and
https://is.gd/mptcp_upstream


Mat Martineau (9):
  net: Make sock protocol value checks more specific
  sock: Make sk_protocol a 16-bit value
  tcp: Define IPPROTO_MPTCP
  tcp: Add MPTCP option number
  tcp, ulp: Add clone operation to tcp_ulp_ops
  mptcp: Add MPTCP to skb extensions
  tcp: Prevent coalesce/collapse when skb has MPTCP extensions
  tcp: Export TCP functions and ops struct
  tcp: Check for filled TCP option space before SACK

Paolo Abeni (2):
  tcp: clean ext on tx recycle
  skb: add helpers to allocate ext independently from sk_buff

 MAINTAINERS                     | 10 ++++++++
 include/linux/skbuff.h          |  6 +++++
 include/net/mptcp.h             | 43 +++++++++++++++++++++++++++++++++
 include/net/sock.h              | 12 ++++-----
 include/net/tcp.h               | 22 +++++++++++++++++
 include/trace/events/sock.h     |  5 ++--
 include/uapi/linux/in.h         |  2 ++
 net/ax25/af_ax25.c              |  2 +-
 net/core/skbuff.c               | 42 ++++++++++++++++++++++++++++++--
 net/decnet/af_decnet.c          |  2 +-
 net/ipv4/inet_connection_sock.c |  2 ++
 net/ipv4/tcp.c                  |  6 ++---
 net/ipv4/tcp_input.c            | 10 ++++++--
 net/ipv4/tcp_ipv4.c             |  2 +-
 net/ipv4/tcp_output.c           | 12 ++++++---
 net/ipv4/tcp_ulp.c              | 12 +++++++++
 net/ipv6/tcp_ipv6.c             |  6 ++---
 tools/include/uapi/linux/in.h   |  2 ++
 18 files changed, 173 insertions(+), 25 deletions(-)
 create mode 100644 include/net/mptcp.h

-- =

2.24.1

--===============0799985656742640492==--
