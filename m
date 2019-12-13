Content-Type: multipart/mixed; boundary="===============8729430643217410999=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 00/15] Multipath TCP part 2: Single subflow
Date: Fri, 13 Dec 2019 21:50:51 +0100
Message-ID: <20191213205106.2467313-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 2993

--===============8729430643217410999==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These patches depend on the "Multipath TCP part 1: Prerequisites" patch
set sent earlier.

This set adds MPTCP connection establishment, writing & reading MPTCP
options on data packets, a sysctl to allow MPTCP per-namespace, and self
tests. This is sufficient to establish and maintain a connection with a
MPTCP peer, but will not yet allow or initiate establishment of
additional MPTCP subflows.

Clone/fetch:
https://github.com/multipath-tcp/mptcp_net-next.git (tag: netdev-v1-part2)

Browse:
https://github.com/multipath-tcp/mptcp_net-next/tree/netdev-v1-part2

Thank your for your review. You can find us at mptcp(a)lists.01.org and
https://is.gd/mptcp_upstream

Florian Westphal (2):
  mptcp: add subflow write space signalling and mptcp_poll
  mptcp: add basic kselftest for mptcp

Mat Martineau (3):
  mptcp: Add MPTCP socket stubs
  mptcp: Write MPTCP DSS headers to outgoing data packets
  mptcp: Implement MPTCP receive path

Matthieu Baerts (1):
  mptcp: new sysctl to control the activation per NS

Paolo Abeni (2):
  mptcp: recvmsg() can drain data from multiple subflows
  mptcp: allow collapsing consecutive sendpages on the same substream

Peter Krystad (7):
  mptcp: Handle MPTCP TCP options
  mptcp: Associate MPTCP context with TCP socket
  mptcp: Handle MP_CAPABLE options for outgoing connections
  mptcp: Create SUBFLOW socket for incoming connections
  mptcp: Add key generation and token tree
  mptcp: Add shutdown() socket operation
  mptcp: Add setsockopt()/getsockopt() socket operations

 MAINTAINERS                                   |    2 +
 include/linux/tcp.h                           |   34 +
 include/net/mptcp.h                           |   98 ++
 net/Kconfig                                   |    1 +
 net/Makefile                                  |    1 +
 net/ipv4/tcp.c                                |    2 +
 net/ipv4/tcp_input.c                          |   19 +-
 net/ipv4/tcp_output.c                         |   57 +
 net/ipv6/tcp_ipv6.c                           |    7 +
 net/mptcp/Kconfig                             |   16 +
 net/mptcp/Makefile                            |    4 +
 net/mptcp/crypto.c                            |  122 ++
 net/mptcp/ctrl.c                              |  130 ++
 net/mptcp/options.c                           |  520 ++++++++
 net/mptcp/protocol.c                          | 1160 +++++++++++++++++
 net/mptcp/protocol.h                          |  220 ++++
 net/mptcp/subflow.c                           |  763 +++++++++++
 net/mptcp/token.c                             |  195 +++
 tools/testing/selftests/Makefile              |    1 +
 tools/testing/selftests/net/mptcp/.gitignore  |    2 +
 tools/testing/selftests/net/mptcp/Makefile    |   13 +
 tools/testing/selftests/net/mptcp/config      |    2 +
 .../selftests/net/mptcp/mptcp_connect.c       |  832 ++++++++++++
 .../selftests/net/mptcp/mptcp_connect.sh      |  595 +++++++++
 tools/testing/selftests/net/mptcp/settings    |    1 +
 25 files changed, 4796 insertions(+), 1 deletion(-)
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

2.24.0

--===============8729430643217410999==--
