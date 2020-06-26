Content-Type: multipart/mixed; boundary="===============4969039167835679173=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v2 0/4] mptcp: refactor token container
Date: Fri, 26 Jun 2020 19:29:58 +0200
Message-ID: <cover.1593192442.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4824

--===============4969039167835679173==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently the msk sockets are stored in a single radix tree, protected by a
global spin_lock. This series moves to an hash table, allocated at boot tim=
e,
with per bucker spin_lock - alike inet_hashtables, but using a different ke=
y:
the token itself.

The above improves scalability, as write operations will have a far later c=
hance
to compete for lock acquisition, allows lockless lookup, and will allow
easier msk traversing - e.g. for diag interface implementation's sake.

This also introduces trivial, related, kunit tests and move the existing in
kernel's one to kunit.

v1 -> v2:
 - fixed a few extra and sparse warns

Paolo Abeni (4):
  mptcp: add __init annotation on setup functions
  mptcp: refactor token container
  mptcp: move crypto test to KUNIT
  mptcp: introduce token KUNIT self-tests

 net/mptcp/Kconfig       |  20 ++-
 net/mptcp/Makefile      |   4 +
 net/mptcp/crypto.c      |  63 +--------
 net/mptcp/crypto_test.c |  72 +++++++++++
 net/mptcp/pm.c          |   2 +-
 net/mptcp/pm_netlink.c  |   2 +-
 net/mptcp/protocol.c    |  49 ++++---
 net/mptcp/protocol.h    |  24 ++--
 net/mptcp/subflow.c     |  21 ++-
 net/mptcp/token.c       | 280 ++++++++++++++++++++++++++++------------
 net/mptcp/token_test.c  | 140 ++++++++++++++++++++
 11 files changed, 487 insertions(+), 190 deletions(-)
 create mode 100644 net/mptcp/crypto_test.c
 create mode 100644 net/mptcp/token_test.c

-- =

2.26.2

--===============4969039167835679173==--
