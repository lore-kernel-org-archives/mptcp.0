Content-Type: multipart/mixed; boundary="===============0656315320511996325=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 0/3] add tracepoints
Date: Mon, 22 Feb 2021 15:30:30 +0800
Message-ID: <cover.1613978710.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 7884

--===============0656315320511996325==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patchset addressed issues 131, replace some/most pr_debug with trace
events. As Paolo suggested, we should add the tracepoints at "the packet
scheduler and the mapping status" first.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/131

Geliang Tang (3):
  mptcp: add tracepoint for mptcp_subflow_get_send
  mptcp: add tracepoint for get_mapping_status
  mptcp: add tracepoint for subflow_check_data_avail

 include/trace/events/mptcp.h | 122 +++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.c         |   9 ++-
 net/mptcp/subflow.c          |  15 ++---
 3 files changed, 132 insertions(+), 14 deletions(-)
 create mode 100644 include/trace/events/mptcp.h

-- =

2.29.2

--===============0656315320511996325==--
