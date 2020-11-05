Content-Type: multipart/mixed; boundary="===============4058531089938091797=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][RFC PATCH mptcp-next 0/6] MP_PRIO support
Date: Thu, 05 Nov 2020 18:50:17 +0800
Message-ID: <cover.1604572610.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 6557

--===============4058531089938091797==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patchset implements the MP_PRIO logic according to the following lines
in RFC8684:

"""
Another use of the MP_PRIO option is to set the "B" flag on a subflow to
cleanly "retire" its use before closing it and removing it with RM_ADDR.
"""

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/51

Geliang Tang (6):
  mptcp: add the outgoing MP_PRIO support
  mptcp: add the incoming MP_PRIO support
  mptcp: add prio_changed flag
  mptcp: send out MP_PRIO before RM_ADDR
  mptcp: add the mib for MP_PRIO
  selftests: mptcp: add MP_PRIO check in chk_rm_nr

 include/net/mptcp.h                           |  1 +
 net/mptcp/mib.c                               |  1 +
 net/mptcp/mib.h                               |  1 +
 net/mptcp/options.c                           | 53 +++++++++++++++++++
 net/mptcp/pm.c                                | 11 ++++
 net/mptcp/pm_netlink.c                        | 32 +++++++++++
 net/mptcp/protocol.c                          |  4 +-
 net/mptcp/protocol.h                          | 14 +++++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 34 ++++++++----
 9 files changed, 139 insertions(+), 12 deletions(-)

-- =

2.26.2

--===============4058531089938091797==--
