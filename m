Content-Type: multipart/mixed; boundary="===============4497724312718019110=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 0/6] mptcp: Miscellaneous MPTCP fixes
Date: Fri, 30 Oct 2020 15:45:00 -0700
Message-ID: <20201030224506.108377-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 6491

--===============4497724312718019110==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is a collection of small fixup and minor enhancement patches that
have accumulated in the MPTCP tree while net-next was closed. These are
prerequisites for larger changes we have queued up.

Patch 1 refines receive buffer autotuning.

Patches 2 and 4 are some minor locking and refactoring changes.

Patch 3 improves GRO and RX coalescing with MPTCP skbs.

Patches 5 and 6 add a sysctl for tuning ADD_ADDR retransmission timeout
and corresponding test code.

Florian Westphal (3):
  mptcp: adjust mptcp receive buffer limit if subflow has larger one
  mptcp: use _fast lock version in __mptcp_move_skbs
  mptcp: split mptcp_clean_una function

Geliang Tang (2):
  mptcp: add a new sysctl add_addr_timeout
  selftests: mptcp: add ADD_ADDR timeout test case

Paolo Abeni (1):
  tcp: propagate MPTCP skb extensions on xmit splits

 include/net/mptcp.h                           | 21 ++++-
 net/ipv4/tcp_output.c                         |  3 +
 net/mptcp/ctrl.c                              | 14 +++
 net/mptcp/pm_netlink.c                        |  8 +-
 net/mptcp/protocol.c                          | 67 +++++++++----
 net/mptcp/protocol.h                          |  1 +
 tools/testing/selftests/net/mptcp/config      | 10 ++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 94 ++++++++++++++-----
 8 files changed, 171 insertions(+), 47 deletions(-)


base-commit: 1fb74191988fd1cc340c4b2fdaf4c47d2a7d1d17
-- =

2.29.2

--===============4497724312718019110==--
