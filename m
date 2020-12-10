Content-Type: multipart/mixed; boundary="===============3180803630911336218=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 0/9] mptcp: Another set of miscellaneous
 MPTCP fixes
Date: Thu, 10 Dec 2020 14:24:57 -0800
Message-ID: <20201210222506.222251-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 7127

--===============3180803630911336218==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is another collection of MPTCP fixes and enhancements that we have
tested in the MPTCP tree:

Patch 1 cleans up cgroup attachment for in-kernel subflow sockets.

Patches 2 and 3 make sure that deletion of advertised addresses by an
MPTCP path manager when flushing all addresses behaves similarly to the
remove-single-address operation, and adds related tests.

Patches 4 and 8 do some minor cleanup.

Patches 5-7 add MPTCP_FASTCLOSE functionality. Note that patch 6 adds MPTCP
option parsing to tcp_reset().

Patch 9 optimizes skb size for outgoing MPTCP packets.


Florian Westphal (3):
  mptcp: hold mptcp socket before calling tcp_done
  tcp: parse mptcp options contained in reset packets
  mptcp: parse and act on incoming FASTCLOSE option

Geliang Tang (3):
  mptcp: remove address when netlink flushes addrs
  selftests: mptcp: add the flush addrs testcase
  mptcp: use MPTCPOPT_HMAC_LEN macro

Nicolas Rybowski (1):
  mptcp: attach subflow socket to parent cgroup

Paolo Abeni (2):
  mptcp: pm: simplify select_local_address()
  mptcp: let MPTCP create max size skbs

 include/net/tcp.h                             |  2 +-
 net/ipv4/tcp_input.c                          | 13 +++--
 net/ipv4/tcp_minisocks.c                      |  2 +-
 net/mptcp/options.c                           | 17 +++++++
 net/mptcp/pm_netlink.c                        | 21 ++++----
 net/mptcp/protocol.c                          | 47 +++++++++++++++--
 net/mptcp/protocol.h                          |  6 ++-
 net/mptcp/subflow.c                           | 34 ++++++++++++-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 50 +++++++++++++------
 9 files changed, 155 insertions(+), 37 deletions(-)


base-commit: 51e13685bd93654e0e9b2559c8e103d6545ddf95
-- =

2.29.2

--===============3180803630911336218==--
