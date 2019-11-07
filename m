Content-Type: multipart/mixed; boundary="===============2276316717641569434=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/2] Implement MPTCPv1 Handshake
Date: Thu, 07 Nov 2019 07:28:25 -0800
Message-ID: <20191107152827.54549-1-cpaasch@apple.com>
X-Status: 
X-Keywords:                  
X-UID: 2438

--===============2276316717641569434==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Implement the MP_CAPABLE exchange from RFC6824bis, allowing for MPTCP to
work reliably with stateless servers (aka., those using TCP
SYN-cookies). The trick is to reliably transmit the keys from the client
to the server by combining them with data. As the data will be
retransmitted, the keys will reach the server as well.

Christoph Paasch (2):
  mptcp: parse and emit MP_CAPABLE option according to v1 spec.
  mptcp: process MP_CAPABLE data option.

 include/linux/tcp.h   |   3 +-
 include/net/mptcp.h   |  11 +-
 net/ipv4/tcp_input.c  |   2 +-
 net/ipv4/tcp_output.c |   2 +-
 net/mptcp/options.c   | 246 ++++++++++++++++++++++++++++++++----------
 net/mptcp/protocol.c  |  24 +++--
 net/mptcp/protocol.h  |  14 ++-
 net/mptcp/subflow.c   |  42 +++++++-
 8 files changed, 261 insertions(+), 83 deletions(-)

-- =

2.23.0

--===============2276316717641569434==--
