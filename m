Content-Type: multipart/mixed; boundary="===============2604895354995614566=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 0/4] mptcp: msk diag support
Date: Fri, 26 Jun 2020 19:33:31 +0200
Message-ID: <cover.1593192703.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4828

--===============2604895354995614566==
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

v1 -> v2
 - fixed dump issue on large dump
 - use flags for fallback, etc
 - patch 4

Paolo Abeni (4):
  inet_diag: support for wider protocol numbers
  mptcp: add msk interations helpers
  mptcp: add MPTCP socket diag interface
  selftests/mptcp: add diag interface tests

 include/uapi/linux/inet_diag.h                |   1 +
 include/uapi/linux/mptcp.h                    |  17 ++
 net/core/sock.c                               |   1 +
 net/ipv4/inet_diag.c                          |  63 +++++--
 net/mptcp/Kconfig                             |   4 +
 net/mptcp/Makefile                            |   2 +
 net/mptcp/mptcp_diag.c                        | 167 ++++++++++++++++++
 net/mptcp/protocol.h                          |   3 +
 net/mptcp/token.c                             |  83 +++++++++
 tools/testing/selftests/net/mptcp/Makefile    |   2 +-
 tools/testing/selftests/net/mptcp/diag.sh     | 122 +++++++++++++
 .../selftests/net/mptcp/mptcp_connect.c       |  14 +-
 12 files changed, 457 insertions(+), 22 deletions(-)
 create mode 100644 net/mptcp/mptcp_diag.c
 create mode 100755 tools/testing/selftests/net/mptcp/diag.sh

-- =

2.26.2

--===============2604895354995614566==--
