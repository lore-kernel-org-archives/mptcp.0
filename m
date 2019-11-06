Content-Type: multipart/mixed; boundary="===============4820774395608362953=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 0/6] IPv6 support
Date: Tue, 05 Nov 2019 20:41:27 -0800
Message-ID: <20191106044133.14418-1-peter.krystad@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 2411

--===============4820774395608362953==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Implemented support for IPv6. selftests pass with ipv6=3Dtrue, but
they take twice as long to run...

With re-factoring the addition of IPv6 is very clean but I did not
split files yet as it will be hard to squash any changes after the
such a split.

Still to do: multiple subflows, handling IPv4-mapped connections.

v2: Added further re-factoring that makes IPv6 change even smaller
    Add mptcpv6_init() stub and verified build with IPv6=3Dn and m

    Kconfig changes submitted in earlier patch set, this set depends
    on those changes being merged.

    Squashing the final patch (6/6) so that IPv6 support occurs before
    the kselftests commit will be complicated.

Peter Krystad (6):
  mptcp: Reference icsk_af_ops routines through saved pointer
  mptcp: Reference inet_stream_ops routines through socket->ops
  mptcp: Re-factor mptcp_getname routine to be af-agnostic
  mptcp: Re-factor subflow_v4_conn_request to be af-agnostic
  mptcp: Export low-level routines for IPv6
  mptcp: Add IPv6 support

 include/net/mptcp.h  |  10 ++++
 include/net/tcp.h    |   3 ++
 net/ipv6/tcp_ipv6.c  |  16 ++++--
 net/mptcp/ctrl.c     |  11 ++++
 net/mptcp/protocol.c | 117 ++++++++++++++++++++++++++++++++-----------
 net/mptcp/protocol.h |   7 +++
 net/mptcp/subflow.c  |  94 +++++++++++++++++++++++++++++-----
 7 files changed, 213 insertions(+), 45 deletions(-)

-- =

2.17.2

--===============4820774395608362953==--
