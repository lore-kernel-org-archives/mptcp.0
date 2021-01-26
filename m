Content-Type: multipart/mixed; boundary="===============8037121675417226955=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][RFC mptcp-next 0/6] add trace events
Date: Tue, 26 Jan 2021 21:21:47 +0800
Message-ID: <cover.1611667027.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 7482

--===============8037121675417226955==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patchset addressed issues 131, replace some/most pr_debug with trace
events.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/131

Geliang Tang (6):
  mptcp: add tracepoints for data operations
  mptcp: add echo field in mptcp_out_options
  mptcp: add tracepoints for options operations
  mptcp: add mptcpi_local_addr_* in mptcp_info
  mptcp: add tracepoints for PM operations
  mptcp: add tracepoints for subflow operations

 include/net/mptcp.h          |   1 +
 include/trace/events/mptcp.h | 408 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/mptcp.h   |   4 +-
 net/mptcp/mptcp_diag.c       |   4 +-
 net/mptcp/options.c          |  11 +-
 net/mptcp/pm.c               |   3 +
 net/mptcp/pm_netlink.c       |   6 +-
 net/mptcp/protocol.c         |   5 +
 net/mptcp/protocol.h         |   1 +
 net/mptcp/subflow.c          |   6 +
 10 files changed, 445 insertions(+), 4 deletions(-)
 create mode 100644 include/trace/events/mptcp.h

-- =

2.29.2

--===============8037121675417226955==--
