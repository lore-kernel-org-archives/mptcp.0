Content-Type: multipart/mixed; boundary="===============6537683018989703897=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/6] IPv6 support
Date: Wed, 30 Oct 2019 16:38:38 -0700
Message-ID: <20191030233844.4790-1-peter.krystad@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 2364

--===============6537683018989703897==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Implemented support for IPv6. selftests pass with ipv6=3Dtrue, but
they take twice as long to run...

With re-factoring the addition of IPv6 is very clean but I did not
split files yet as it will be hard to squash any changes after the
such a split.

Still to do: multiple subflows, handling IPv4-mapped connections.

Peter Krystad (6):
  mptcp: Reference af_ops routines through struct ipv4_specific
  mptcp: Re-factor create socket/subflow routines to be af-agnostic
  mptcp: Re-factor mptcp_stream_ops routines to be af-agnostic
  mptcp: Re-factor subflow routines to be af-agnostic
  mptcp: Export low-level routines for IPv6
  mptcp: Add IPv6 support

 include/net/mptcp.h  |   3 +
 include/net/tcp.h    |   3 +
 net/ipv6/tcp_ipv6.c  |  16 +++-
 net/mptcp/ctrl.c     |  11 +++
 net/mptcp/protocol.c | 174 +++++++++++++++++++++++++++++++--------
 net/mptcp/protocol.h |   9 +-
 net/mptcp/subflow.c  | 191 +++++++++++++++++++++++++++++++++++++------
 7 files changed, 342 insertions(+), 65 deletions(-)

-- =

2.17.2

--===============6537683018989703897==--
