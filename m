Content-Type: multipart/mixed; boundary="===============0626816160947976496=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/3] mptcp: msk diag support
Date: Thu, 25 Jun 2020 12:22:27 +0200
Message-ID: <cover.1593080104.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4796

--===============0626816160947976496==
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

Paolo Abeni (3):
  inet_diag: support for wider protocol numbers
  mptcp: add msk interations helpers
  mptcp: add MPTCP socket diag interface

 include/uapi/linux/inet_diag.h |   1 +
 include/uapi/linux/mptcp.h     |  15 ++++
 net/core/sock.c                |   1 +
 net/ipv4/inet_diag.c           |  63 +++++++++----
 net/mptcp/Kconfig              |   4 +
 net/mptcp/Makefile             |   2 +
 net/mptcp/mptcp_diag.c         | 160 +++++++++++++++++++++++++++++++++
 net/mptcp/options.c            |   6 +-
 net/mptcp/protocol.h           |   3 +
 net/mptcp/token.c              |  83 +++++++++++++++++
 10 files changed, 318 insertions(+), 20 deletions(-)
 create mode 100644 net/mptcp/mptcp_diag.c

-- =

2.26.2

--===============0626816160947976496==--
