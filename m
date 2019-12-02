Content-Type: multipart/mixed; boundary="===============8667608668456492673=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/3] mptcp: support for rfc6824 MP CAPABLE hanshake
Date: Mon, 02 Dec 2019 09:15:01 -0800
Message-ID: <20191202171504.88739-1-cpaasch@apple.com>
X-Status: 
X-Keywords:                  
X-UID: 2745

--===============8667608668456492673==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Second iteration of the v1 MP_CAPABLE handshake, adding the handling of
the option-space issue.

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
 net/mptcp/options.c   | 229 ++++++++++++++++++++++++++++++++----------
 net/mptcp/protocol.c  |  22 ++--
 net/mptcp/protocol.h  |  18 ++--
 net/mptcp/subflow.c   |  43 +++++++-
 10 files changed, 349 insertions(+), 130 deletions(-)

-- =

2.23.0

--===============8667608668456492673==--
