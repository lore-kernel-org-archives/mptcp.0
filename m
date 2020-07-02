Content-Type: multipart/mixed; boundary="===============0570134696219865874=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v3 0/4] mptcp: msk diag support
Date: Thu, 02 Jul 2020 13:32:29 +0200
Message-ID: <cover.1593689328.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4896

--===============0570134696219865874==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This introduces basic mptcp sockets diag support.
As IPPROTO_MPTCP excedes 8 bits, we need some changes at the inet_diag leve=
l:
a new attribute is introduced to allow user-space providing u32 protocol
values.

Patch 2 introduces new token APIs to allow traversing the existing msks, wh=
ile
patch 3 bring in the actual diag implementation.

Patch 4 includes some basic functional tests

v2 -> v3:
 - changed token iterator APIs: use RCU && get_sock
 - tests cleanup

v1 -> v2
 - fixed dump issue on large dump
 - use flags for fallback, etc
 - patch 4

Paolo Abeni (4):
  inet_diag: support for wider protocol numbers
  mptcp: add msk interations helper
  mptcp: add MPTCP socket diag interface
  selftests/mptcp: add diag interface tests

 include/uapi/linux/inet_diag.h                |   1 +
 include/uapi/linux/mptcp.h                    |  17 ++
 net/core/sock.c                               |   1 +
 net/ipv4/inet_diag.c                          |  63 +++++--
 net/mptcp/Kconfig                             |   4 +
 net/mptcp/Makefile                            |   2 +
 net/mptcp/mptcp_diag.c                        | 169 ++++++++++++++++++
 net/mptcp/protocol.h                          |   2 +
 net/mptcp/token.c                             |  59 ++++++
 tools/testing/selftests/net/mptcp/Makefile    |   2 +-
 tools/testing/selftests/net/mptcp/diag.sh     | 122 +++++++++++++
 .../selftests/net/mptcp/mptcp_connect.c       |  22 ++-
 12 files changed, 442 insertions(+), 22 deletions(-)
 create mode 100644 net/mptcp/mptcp_diag.c
 create mode 100755 tools/testing/selftests/net/mptcp/diag.sh

-- =

2.26.2

--===============0570134696219865874==--
