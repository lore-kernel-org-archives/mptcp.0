Content-Type: multipart/mixed; boundary="===============5859078789774222979=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 0/5] MP_PRIO support
Date: Fri, 20 Nov 2020 15:07:49 +0800
Message-ID: <cover.1605855783.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 6862

--===============5859078789774222979==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v1:
 - add MP_PRIO PM netlink support

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/51

Geliang Tang (5):
  mptcp: add the outgoing MP_PRIO support
  mptcp: add the incoming MP_PRIO support
  mptcp: deal with MPTCP_PM_ADDR_FLAG_BACKUP in PM netlink
  mptcp: add the mibs for MP_PRIO
  selftests: mptcp: add the MP_PRIO testcases

 net/mptcp/mib.c                               |  2 +
 net/mptcp/mib.h                               |  2 +
 net/mptcp/options.c                           | 56 +++++++++++++
 net/mptcp/pm.c                                | 19 +++++
 net/mptcp/pm_netlink.c                        | 81 +++++++++++++++++++
 net/mptcp/protocol.h                          | 11 +++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 81 ++++++++++++++++++-
 7 files changed, 251 insertions(+), 1 deletion(-)

-- =

2.26.2

--===============5859078789774222979==--
