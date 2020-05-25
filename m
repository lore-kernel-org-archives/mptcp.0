Content-Type: multipart/mixed; boundary="===============3961834723240580995=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 0/4] mptcp: token container refactor
Date: Mon, 25 May 2020 19:35:15 +0200
Message-ID: <cover.1590427813.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4494

--===============3961834723240580995==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series supersede the RTC patch for token refactor. The relevant patch
is unchanged, but this additional bring in some related minor cleanup
(patch 1/4) and KUNIT (!!!) self-tests (4/4). To make things cleaner it also
moves the existing in-kernel tests (crypto) to KUNIT.

The most relevant changes from v1 are in patch 2/4.

This addresses most of the issues raised by Christoph, Davide and Mat, with=
 the
notable exception of shirinking the hash table bucket size - I'm unable to =
do
that with the current fixes for the list curruption noted by Christoph.

I hope the trade-off beween the self-contained fix and the avoided memory
optimization is acceptable.

Paolo Abeni (4):
  mptcp: add __init annotation on setup functions
  mptcp: refactor token container.
  mptcp: move crypto test to KUNIT
  mptcp: introduce token KUNIT self-tests

 net/mptcp/Kconfig       |  19 ++-
 net/mptcp/Makefile      |   4 +
 net/mptcp/crypto.c      |  65 +---------
 net/mptcp/crypto_test.c |  72 +++++++++++
 net/mptcp/pm.c          |   2 +-
 net/mptcp/pm_netlink.c  |   2 +-
 net/mptcp/protocol.c    |  39 +++---
 net/mptcp/protocol.h    |  15 ++-
 net/mptcp/subflow.c     |  12 +-
 net/mptcp/token.c       | 258 ++++++++++++++++++++++++++++------------
 net/mptcp/token_test.c  | 138 +++++++++++++++++++++
 11 files changed, 453 insertions(+), 173 deletions(-)
 create mode 100644 net/mptcp/crypto_test.c
 create mode 100644 net/mptcp/token_test.c

-- =

2.21.3

--===============3961834723240580995==--
