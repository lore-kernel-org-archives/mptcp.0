Content-Type: multipart/mixed; boundary="===============3020887659029888891=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 0/8] ADD_ADDR: ports support
Date: Thu, 29 Oct 2020 14:39:20 +0800
Message-ID: <cover.1603952836.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 6463

--===============3020887659029888891==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series is the first version of ADD_ADDR ports support. I have solved
the listener problem which I mentioned at the meeting on 15th of October
by adding a new listening socket from the userspace (see patch 8). Up to
now this patchset works well.

TODO:
I added 2 octets padding in ADD_ADDR port suboption for alignment. (see
patch 1). We need to drop this padding.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/54

Geliang Tang (8):
  mptcp: add ADD_ADDR port support for writing options
  mptcp: add the outgoing ADD_ADDR port support
  mptcp: send out ack for ADD_ADDR with port
  mptcp: add port argument for mptcp_pm_announce_addr
  mptcp: add the incoming ADD_ADDR port support
  mptcp: add ADD_ADDR port support for netlink
  selftests: mptcp: add ADD_ADDR port support for pm_nl_ctl
  selftests: mptcp: add testcases for ADD_ADDR with port

 include/net/mptcp.h                           |  1 +
 net/mptcp/options.c                           | 80 +++++++++++++++----
 net/mptcp/pm.c                                | 14 ++--
 net/mptcp/pm_netlink.c                        | 28 +++++--
 net/mptcp/protocol.h                          | 31 ++++---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 26 +++++-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 18 +++++
 7 files changed, 162 insertions(+), 36 deletions(-)

-- =

2.26.2

--===============3020887659029888891==--
