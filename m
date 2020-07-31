Content-Type: multipart/mixed; boundary="===============1299993326198236343=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 00/12] mptcp: multiple xmit substreams support
Date: Fri, 31 Jul 2020 19:39:15 +0200
Message-ID: <cover.1596216310.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 5407

--===============1299993326198236343==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is an early RFC to gather feedback and comments on the current status.

Needs the bugfix patch I sent before to avoid exploding badly on the first
packet - can still explode after a few ones.

It refactor send space notifications, introduces OoO handling via RBtree,
sndbuf autotuning, allows the PM to create non backup subflows and finally
a basic scheduler and some self-tests.

The pain point is the in-window check:

on the receiver side msk rcv window is set at tcp_space(msk) - which should=
 be
a quite rough over-estimante of a more correct value.

on the sender side no limit is imposed on the xmitted sequence number, exce=
pt
the one given by the sndbuf. The msk sndbuf is autotuned to the subflows
largest sndbuf size.

With all the above I observe several out of [MPTCP] window on the RX side, =
to
the point that if affects the bandwidth (self-tests fail, as they basically
looks at virtual link utilization).

Any comment more than welcome, especially about better mptcp window checks.

This has been quite painful, so I would propose to consider accepting on
export branch even a suboptimal version and then improve incrementally.

Paolo Abeni (12):
  mptcp: msk is writable according to msk write space
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
  mptcp: simult flow self-tests

 net/mptcp/mib.c                               |   5 +
 net/mptcp/mib.h                               |   5 +
 net/mptcp/pm_netlink.c                        |  38 +-
 net/mptcp/protocol.c                          | 459 ++++++++++++++----
 net/mptcp/protocol.h                          |  18 +-
 net/mptcp/subflow.c                           |  91 ++--
 .../selftests/net/mptcp/simult_flows.sh       | 290 +++++++++++
 7 files changed, 743 insertions(+), 163 deletions(-)
 create mode 100755 tools/testing/selftests/net/mptcp/simult_flows.sh

-- =

2.26.2

--===============1299993326198236343==--
