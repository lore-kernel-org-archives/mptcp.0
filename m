Content-Type: multipart/mixed; boundary="===============4255273722389395762=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v2 00/13] mptcp: introduce support for real
 multipath xmit
Date: Mon, 14 Sep 2020 10:01:06 +0200
Message-ID: <cover.1599854632.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 5831

--===============4255273722389395762==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series enable MPTCP socket to transmit data on multiple subflows
concurrently in a load balancing scenario.

First the receive code path is refactored to better deal with out-of-order
data (patches 1-7). An RB-tree is introduced to queue MPTCP-level out-of-or=
der
data, closely resembling the TCP level OoO handling.

When data is sent on multiple subflows, the peer can easily see OoO - "futu=
re"
data at the MPTCP level, especially if speeds, delay, or jitter are not
symmetric.

The other major change regards the netlink PM, which is extended to allow
creating non backup subflows in patches 9-11.

There are a few smaller additions, like the introduction of OoO related mib=
s,
send buffer autotuning and better ack handling.

Finally a bunch of new self-tests is introduced. The new feature is tested
ensuring that the B/W used by an MPTCP socket using multiple subflows match=
es
the link aggregated B/W - we use low B/W virtual links, to ensure the tests
are not CPU bounded.

v1 -> v2:
  - fix 32 bit build breakage
  - fix a bunch of checkpatch issues

Paolo Abeni (13):
  mptcp: rethink 'is writable' conditional
  mptcp: set data_ready status bit in subflow_check_data_avail()
  mptcp: trigger msk processing even for OoO data
  mptcp: basic sndbuf autotuning
  mptcp: introduce and use mptcp_try_coalesce()
  mptcp: move ooo skbs into msk out of order queue.
  mptcp: cleanup mptcp_subflow_discard_data()
  mptcp: add OoO related mibs
  mptcp: move address attribute into mptcp_addr_info
  mptcp: allow creating non-backup subflows
  mptcp: allow picking different xmit subflows
  mptcp: call tcp_cleanup_rbuf on subflows
  mptcp: simult flow self-tests

 include/net/tcp.h                             |   2 +
 net/ipv4/tcp.c                                |   2 +-
 net/mptcp/mib.c                               |   5 +
 net/mptcp/mib.h                               |   5 +
 net/mptcp/pm_netlink.c                        |  39 +-
 net/mptcp/protocol.c                          | 511 ++++++++++++++----
 net/mptcp/protocol.h                          |  21 +-
 net/mptcp/subflow.c                           |  99 ++--
 tools/testing/selftests/net/mptcp/Makefile    |   3 +-
 .../selftests/net/mptcp/simult_flows.sh       | 293 ++++++++++
 10 files changed, 798 insertions(+), 182 deletions(-)
 create mode 100755 tools/testing/selftests/net/mptcp/simult_flows.sh

-- =

2.26.2

--===============4255273722389395762==--
