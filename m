Content-Type: multipart/mixed; boundary="===============6192926546676211280=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v3 00/19] Multipath TCP part 2: Single
 subflow & RFC8684 support
Date: Tue, 21 Jan 2020 16:56:14 -0800
Message-ID: <20200122005633.21229-1-cpaasch@apple.com>
X-Status: 
X-Keywords:                  
X-UID: 3470

--===============6192926546676211280==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v2 -> v3: Added RFC8684-style handshake (see below fore more details) and s=
ome minor fixes
v1 -> v2: Rebased on latest "Multipath TCP: Prerequisites" v3 series

This set adds MPTCP connection establishment, writing & reading MPTCP
options on data packets, a sysctl to allow MPTCP per-namespace, and self
tests. This is sufficient to establish and maintain a connection with a
MPTCP peer, but will not yet allow or initiate establishment of
additional MPTCP subflows.

We also add the necessary code for the RFC8684-style handshake.
RFC8684 obsoletes the experimental RFC6824 and makes MPTCP move-on to
version 1.

Originally our plan was to submit single-subflow and RFC8684 support in
two patchsets, but to simplify the merging-process and ensure that a cohere=
nt
MPTCP-version lands in Linux we decided to merge the two sets into a single
one.

The MPTCP patchset exclusively supports RFC 8684. Although all MPTCP
deployments are currently based on RFC 6824, future deployments will be
migrating to MPTCP version 1. 3GPP's 5G standardization also solely supports
RFC 8684. In addition, we believe that this initial submission of MPTCP wil=
l be
cleaner by solely supporting RFC 8684. If later on support for the old
MPTCP-version is required it can always be added in the future.

The major difference between RFC 8684 and RFC 6824 is that it has a better
support for servers using TCP SYN-cookies by reliably retransmitting the
MP_CAPABLE option.

Before ending this cover letter with some refs, it is worth mentioning
that we promise David Miller that merging this series will be rewarded by
Twitter dopamine hits :-D

Clone/fetch:
https://github.com/multipath-tcp/mptcp_net-next.git (tag: netdev-v3-part2)

Browse:
https://github.com/multipath-tcp/mptcp_net-next/tree/netdev-v3-part2

Thank you for your review. You can find us at mptcp(a)lists.01.org and
https://is.gd/mptcp_upstream


Christoph Paasch (2):
  mptcp: parse and emit MP_CAPABLE option according to v1 spec
  mptcp: process MP_CAPABLE data option

Florian Westphal (2):
  mptcp: add subflow write space signalling and mptcp_poll
  mptcp: add basic kselftest for mptcp

Mat Martineau (3):
  mptcp: Add MPTCP socket stubs
  mptcp: Write MPTCP DSS headers to outgoing data packets
  mptcp: Implement MPTCP receive path

Matthieu Baerts (1):
  mptcp: new sysctl to control the activation per NS

Paolo Abeni (4):
  mptcp: recvmsg() can drain data from multiple subflows
  mptcp: allow collapsing consecutive sendpages on the same substream
  mptcp: move from sha1 (v0) to sha256 (v1)
  mptcp: cope with later TCP fallback

Peter Krystad (7):
  mptcp: Handle MPTCP TCP options
  mptcp: Associate MPTCP context with TCP socket
  mptcp: Handle MP_CAPABLE options for outgoing connections
  mptcp: Create SUBFLOW socket for incoming connections
  mptcp: Add key generation and token tree
  mptcp: Add shutdown() socket operation
  mptcp: Add setsockopt()/getsockopt() socket operations

 MAINTAINERS                                   |    2 +
 include/linux/tcp.h                           |   35 +
 include/net/mptcp.h                           |  105 +-
 net/Kconfig                                   |    1 +
 net/Makefile                                  |    1 +
 net/ipv4/tcp.c                                |    2 +
 net/ipv4/tcp_input.c                          |   19 +-
 net/ipv4/tcp_output.c                         |   57 +
 net/ipv6/tcp_ipv6.c                           |   13 +
 net/mptcp/Kconfig                             |   26 +
 net/mptcp/Makefile                            |    4 +
 net/mptcp/crypto.c                            |  152 ++
 net/mptcp/ctrl.c                              |  130 ++
 net/mptcp/options.c                           |  586 ++++++++
 net/mptcp/protocol.c                          | 1244 +++++++++++++++++
 net/mptcp/protocol.h                          |  240 ++++
 net/mptcp/subflow.c                           |  860 ++++++++++++
 net/mptcp/token.c                             |  195 +++
 tools/testing/selftests/Makefile              |    1 +
 tools/testing/selftests/net/mptcp/.gitignore  |    2 +
 tools/testing/selftests/net/mptcp/Makefile    |   13 +
 tools/testing/selftests/net/mptcp/config      |    4 +
 .../selftests/net/mptcp/mptcp_connect.c       |  832 +++++++++++
 .../selftests/net/mptcp/mptcp_connect.sh      |  595 ++++++++
 tools/testing/selftests/net/mptcp/settings    |    1 +
 25 files changed, 5118 insertions(+), 2 deletions(-)
 create mode 100644 net/mptcp/Kconfig
 create mode 100644 net/mptcp/Makefile
 create mode 100644 net/mptcp/crypto.c
 create mode 100644 net/mptcp/ctrl.c
 create mode 100644 net/mptcp/options.c
 create mode 100644 net/mptcp/protocol.c
 create mode 100644 net/mptcp/protocol.h
 create mode 100644 net/mptcp/subflow.c
 create mode 100644 net/mptcp/token.c
 create mode 100644 tools/testing/selftests/net/mptcp/.gitignore
 create mode 100644 tools/testing/selftests/net/mptcp/Makefile
 create mode 100644 tools/testing/selftests/net/mptcp/config
 create mode 100644 tools/testing/selftests/net/mptcp/mptcp_connect.c
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_connect.sh
 create mode 100644 tools/testing/selftests/net/mptcp/settings

-- =

2.23.0

--===============6192926546676211280==--
