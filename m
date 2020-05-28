Content-Type: multipart/mixed; boundary="===============0689102286393037734=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v3 0/4] mptcp: token container refactor
Date: Thu, 28 May 2020 20:01:50 +0200
Message-ID: <cover.1590688878.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4539

--===============0689102286393037734==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series supersede the RTC patch for token refactor. The relevant patch
is unchanged, but this additional bring in some related minor cleanup
(patch 1/4) and KUNIT (!!!) self-tests (4/4). To make things cleaner it also
moves the existing in-kernel tests (crypto) to KUNIT.

only changes from v2 are some comments in patch 2/4 and patch 3/4 rebased.

Paolo Abeni (4):
  mptcp: add __init annotation on setup functions
  mptcp: refactor token container.
  mptcp: move crypto test to KUNIT
  mptcp: introduce token KUNIT self-tests

 net/mptcp/Kconfig       |  19 ++-
 net/mptcp/Makefile      |   4 +
 net/mptcp/crypto.c      |  63 +---------
 net/mptcp/crypto_test.c |  72 +++++++++++
 net/mptcp/pm.c          |   2 +-
 net/mptcp/pm_netlink.c  |   2 +-
 net/mptcp/protocol.c    |  39 +++---
 net/mptcp/protocol.h    |  15 ++-
 net/mptcp/subflow.c     |  12 +-
 net/mptcp/token.c       | 263 +++++++++++++++++++++++++++++-----------
 net/mptcp/token_test.c  | 138 +++++++++++++++++++++
 11 files changed, 458 insertions(+), 171 deletions(-)
 create mode 100644 net/mptcp/crypto_test.c
 create mode 100644 net/mptcp/token_test.c

-- =

2.21.3

--===============0689102286393037734==--
