Content-Type: multipart/mixed; boundary="===============1122182085515108844=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/4] mptcp: token container refactor
Date: Fri, 22 May 2020 12:10:09 +0200
Message-ID: <cover.1590142022.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4452

--===============1122182085515108844==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series supersede the RTC patch for token refactor. The relevant patch
is unchanged, but this additional bring in some related minor cleanup
(patch 1/4) and KUNIT (!!!) self-tests (4/4). To make things cleaner it also
moves the existing in-kernel tests (crypto) to KUNIT.

Paolo Abeni (4):
  mptcp: add __init annotation on setup functions
  mptcp: refactor token container.
  mptcp: move crypto test to KUNIT
  mptcp: introduce token KUNIT self-tests

 net/mptcp/Kconfig       |  19 ++-
 net/mptcp/Makefile      |   4 +
 net/mptcp/crypto.c      |  65 +---------
 net/mptcp/crypto_test.c |  71 +++++++++++
 net/mptcp/protocol.c    |  21 +---
 net/mptcp/protocol.h    |  14 ++-
 net/mptcp/subflow.c     |  12 +-
 net/mptcp/token.c       | 255 ++++++++++++++++++++++++++++------------
 net/mptcp/token_test.c  | 138 ++++++++++++++++++++++
 9 files changed, 431 insertions(+), 168 deletions(-)
 create mode 100644 net/mptcp/crypto_test.c
 create mode 100644 net/mptcp/token_test.c

-- =

2.21.3

--===============1122182085515108844==--
