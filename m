Content-Type: multipart/mixed; boundary="===============2424395967524534168=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v3 mptcp-next 0/6] MP_PRIO support
Date: Wed, 09 Dec 2020 16:15:40 +0800
Message-ID: <cover.1607501232.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 7086

--===============2424395967524534168==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v3:
 - drop the MPTCP_PM_ADDR_FLAG_NOBACKUP flag

v2:
 - add set_flags command

v1:
 - add MP_PRIO PM netlink support

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/51

Geliang Tang (6):
  mptcp: add the outgoing MP_PRIO support
  mptcp: add the incoming MP_PRIO support
  mptcp: add set_flags command in PM netlink
  selftests: mptcp: add set_flags command in pm_nl_ctl
  mptcp: add the mibs for MP_PRIO
  selftests: mptcp: add the MP_PRIO testcases

 include/uapi/linux/mptcp.h                    |   1 +
 net/mptcp/mib.c                               |   2 +
 net/mptcp/mib.h                               |   2 +
 net/mptcp/options.c                           |  56 ++++++++++
 net/mptcp/pm.c                                |   8 ++
 net/mptcp/pm_netlink.c                        | 100 ++++++++++++++++++
 net/mptcp/protocol.h                          |  13 ++-
 .../testing/selftests/net/mptcp/mptcp_join.sh |  72 ++++++++++++-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  85 ++++++++++++++-
 9 files changed, 336 insertions(+), 3 deletions(-)

-- =

2.26.2

--===============2424395967524534168==--
