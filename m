Content-Type: multipart/mixed; boundary="===============7347264186803563232=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v3 0/3] mptcp: support for rfc6824 MP CAPABLE hanshake
Date: Thu, 05 Dec 2019 11:36:09 -0800
Message-ID: <20191205193612.1781-1-cpaasch@apple.com>
X-Status: 
X-Keywords:                  
X-UID: 2798

--===============7347264186803563232==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Third iteration of the v1 MP_CAPABLE handshake, incorporating the
feedback we got from Peter & Matt.

The patches apply just before "mptcp: add basic kselftest for mptcp".

Christoph Paasch (2):
  mptcp: parse and emit MP_CAPABLE option according to v1 spec.
  mptcp: process MP_CAPABLE data option.

Paolo Abeni (1):
  mptcp: move from sha1 (v0) to sha256 (v1)

 include/linux/tcp.h   |   3 +-
 include/net/mptcp.h   |  11 +-
 net/ipv4/tcp_input.c  |   2 +-
 net/ipv4/tcp_output.c |   2 +-
 net/mptcp/Kconfig     |  10 ++
 net/mptcp/crypto.c    | 139 +++++++++++++++----------
 net/mptcp/options.c   | 232 ++++++++++++++++++++++++++++++++----------
 net/mptcp/protocol.c  |  22 ++--
 net/mptcp/protocol.h  |  20 ++--
 net/mptcp/subflow.c   |  43 +++++++-
 10 files changed, 354 insertions(+), 130 deletions(-)

-- =

2.23.0

--===============7347264186803563232==--
