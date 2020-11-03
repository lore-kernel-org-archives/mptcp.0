Content-Type: multipart/mixed; boundary="===============6805136411773236734=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v2 0/7] mptcp: Miscellaneous MPTCP fixes
Date: Tue, 03 Nov 2020 11:05:02 -0800
Message-ID: <20201103190509.27416-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 6527

--===============6805136411773236734==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is a collection of small fixup and minor enhancement patches that
have accumulated in the MPTCP tree while net-next was closed. These are
prerequisites for larger changes we have queued up.

Patch 1 refines receive buffer autotuning.

Patches 2 and 4 are some minor locking and refactoring changes.

Patch 3 improves GRO and RX coalescing with MPTCP skbs.

Patches 5-7 add a sysctl for tuning ADD_ADDR retransmission timeout,
corresponding test code, and documentation.


v2: Add sysctl documentation and fix signoff tags.


Florian Westphal (3):
  mptcp: adjust mptcp receive buffer limit if subflow has larger one
  mptcp: use _fast lock version in __mptcp_move_skbs
  mptcp: split mptcp_clean_una function

Geliang Tang (2):
  mptcp: add a new sysctl add_addr_timeout
  selftests: mptcp: add ADD_ADDR timeout test case

Mat Martineau (1):
  docs: networking: mptcp: Add MPTCP sysctl entries

Paolo Abeni (1):
  tcp: propagate MPTCP skb extensions on xmit splits

 Documentation/networking/index.rst            |  1 +
 Documentation/networking/mptcp-sysctl.rst     | 26 +++++
 MAINTAINERS                                   |  1 +
 include/net/mptcp.h                           | 21 ++++-
 net/ipv4/tcp_output.c                         |  3 +
 net/mptcp/ctrl.c                              | 14 +++
 net/mptcp/pm_netlink.c                        |  8 +-
 net/mptcp/protocol.c                          | 67 +++++++++----
 net/mptcp/protocol.h                          |  1 +
 tools/testing/selftests/net/mptcp/config      | 10 ++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 94 ++++++++++++++-----
 11 files changed, 199 insertions(+), 47 deletions(-)
 create mode 100644 Documentation/networking/mptcp-sysctl.rst


base-commit: 6d89076e6ef09337a29a7b1ea4fdf2d892be9650
-- =

2.29.2

--===============6805136411773236734==--
