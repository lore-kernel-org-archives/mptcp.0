Content-Type: multipart/mixed; boundary="===============6207954487187492352=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC 0/3] MP_JOIN handling WIP
Date: Wed, 22 May 2019 14:38:22 -0700
Message-ID: <20190522213825.4057-1-peter.krystad@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 1224

--===============6207954487187492352==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Current state of MP_JOIN handling. As I mentioned this is not
functional yet but am sharing for visibility. The intent of this
patchset is to complete the handshake for a second subflow in the
incoming direction. Sending an outgoing SYN with MP_JOIN and the
data path is not addressed.

It will already need some refactor due to Florian's changes to
subflow list locking.

Peter Krystad (3):
  mptcp: Slightly refactor mptcp_established_options_xxx()
  mptcp: Add ADD_ADDR handling
  mptcp: Add handling of incoming MP_JOIN requests

 include/linux/tcp.h      |   6 ++
 include/net/mptcp.h      |  44 ++++++++++++--
 include/net/tcp.h        |   6 ++
 net/ipv4/tcp_minisocks.c |   6 ++
 net/ipv4/tcp_output.c    |  31 ++++++----
 net/mptcp/Makefile       |   2 +-
 net/mptcp/options.c      | 127 ++++++++++++++++++++++++++++++++++++---
 net/mptcp/pm.c           |  24 ++++++++
 net/mptcp/protocol.c     |  24 ++++++++
 net/mptcp/protocol.h     |  45 +++++++++++++-
 net/mptcp/subflow.c      |  42 +++++++++++++
 net/mptcp/token.c        | 124 ++++++++++++++++++++++++++++++++++++++
 12 files changed, 451 insertions(+), 30 deletions(-)
 create mode 100644 net/mptcp/pm.c

-- =

2.17.2


--===============6207954487187492352==--
