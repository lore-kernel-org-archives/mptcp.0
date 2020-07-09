Content-Type: multipart/mixed; boundary="===============8124990304666062901=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 0/4] mptcp: introduce msk diag interface
Date: Thu, 09 Jul 2020 15:12:38 +0200
Message-ID: <cover.1594292774.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4956

--===============8124990304666062901==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series implements the diag interface for the MPTCP sockets.

Since the MPTCP protocol value can't be represented with the
current diag uAPI, the first patch introduces an extended attribute
allowing user-space to specify lager protocol values.

The token APIs are then extended to allow traversing the
whole token container.

Patch 3 carries the actual diag interface implementation, and =

later patch bring-in some functional self-tests.

Paolo Abeni (4):
  inet_diag: support for wider protocol numbers
  mptcp: add msk interations helper
  mptcp: add MPTCP socket diag interface
  selftests/mptcp: add diag interface tests

 include/uapi/linux/inet_diag.h                |   1 +
 include/uapi/linux/mptcp.h                    |  17 ++
 net/core/sock.c                               |   1 +
 net/ipv4/inet_diag.c                          |  65 +++++--
 net/mptcp/Kconfig                             |   4 +
 net/mptcp/Makefile                            |   2 +
 net/mptcp/mptcp_diag.c                        | 169 ++++++++++++++++++
 net/mptcp/protocol.h                          |   2 +
 net/mptcp/token.c                             |  61 ++++++-
 tools/testing/selftests/net/mptcp/Makefile    |   2 +-
 tools/testing/selftests/net/mptcp/diag.sh     | 122 +++++++++++++
 .../selftests/net/mptcp/mptcp_connect.c       |  22 ++-
 12 files changed, 445 insertions(+), 23 deletions(-)
 create mode 100644 net/mptcp/mptcp_diag.c
 create mode 100755 tools/testing/selftests/net/mptcp/diag.sh

-- =

2.26.2

--===============8124990304666062901==--
