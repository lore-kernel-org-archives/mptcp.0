Content-Type: multipart/mixed; boundary="===============3352363143918453128=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC v3 0/3] MP_JOIN handling WIP
Date: Sun, 16 Jun 2019 21:38:11 -0700
Message-ID: <20190617043814.3470-1-peter.krystad@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 1408

--===============3352363143918453128==
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

v3 - revise IPv6 handling for ADD_ADDR
   - macro for option word
   - fix indentation
   - mp_join vs mp_capable else statement cleanup

Peter Krystad (3):
  mptcp: Add path manager interface
  mptcp: Add ADD_ADDR handling
  mptcp: Add handling of incoming MP_JOIN requests

 include/linux/tcp.h      |  17 +++++
 include/net/mptcp.h      |  30 +++++++-
 net/ipv4/tcp_minisocks.c |   6 ++
 net/mptcp/Makefile       |   2 +-
 net/mptcp/options.c      | 156 +++++++++++++++++++++++++++++++++++----
 net/mptcp/pm.c           |  66 +++++++++++++++++
 net/mptcp/protocol.c     |  25 +++++++
 net/mptcp/protocol.h     |  69 ++++++++++++++++-
 net/mptcp/subflow.c      |  61 ++++++++++++---
 net/mptcp/token.c        | 124 +++++++++++++++++++++++++++++++
 10 files changed, 526 insertions(+), 30 deletions(-)
 create mode 100644 net/mptcp/pm.c

-- =

2.17.2


--===============3352363143918453128==--
