Content-Type: multipart/mixed; boundary="===============2376818218714203569=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC v2 0/3] MP_JOIN handling WIP
Date: Wed, 12 Jun 2019 16:21:24 -0700
Message-ID: <20190612232127.3647-1-peter.krystad@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 1350

--===============2376818218714203569==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Current state of MP_JOIN handling. As I mentioned this is not
functional yet but am sharing for visibility. The intent of this
patchset is to complete the handshake for a second subflow in the
incoming direction. Sending an outgoing SYN with MP_JOIN and the
data path is not addressed.

v2 - pr_debug() cleanup and single mptcp_established() hook were
     address in other already-merged patchsets
   - split path manager skeleton into its own commit
   - cleaned up logic in subflow_syn_recv_sock
   - rebase onto Florian's locking change
   - namespace for token table NOT addressed

Peter Krystad (3):
  mptcp: Add path manager interface
  mptcp: Add ADD_ADDR handling
  mptcp: Add handling of incoming MP_JOIN requests

 include/linux/tcp.h      |  12 ++++
 include/net/mptcp.h      |  28 +++++++-
 include/net/tcp.h        |   6 ++
 net/ipv4/tcp_minisocks.c |   6 ++
 net/mptcp/Makefile       |   2 +-
 net/mptcp/options.c      | 150 ++++++++++++++++++++++++++++++++++++---
 net/mptcp/pm.c           |  67 +++++++++++++++++
 net/mptcp/protocol.c     |  25 +++++++
 net/mptcp/protocol.h     |  53 +++++++++++++-
 net/mptcp/subflow.c      |  54 ++++++++++++--
 net/mptcp/token.c        | 124 ++++++++++++++++++++++++++++++++
 11 files changed, 503 insertions(+), 24 deletions(-)
 create mode 100644 net/mptcp/pm.c

-- =

2.17.2


--===============2376818218714203569==--
