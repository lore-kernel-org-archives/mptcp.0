Content-Type: multipart/mixed; boundary="===============6996938827946773417=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 0/8] MPTCP: Add MP_PRIO support and rework
 local address IDs
Date: Fri, 08 Jan 2021 16:47:54 -0800
Message-ID: <20210109004802.341602-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 7291

--===============6996938827946773417==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Here are some patches we've merged in the MPTCP tree that are ready for
net-next.

Patches 1 and 2 rework the assignment of local address IDs to allow them
to be assigned by a userspace path manager, and add corresponding self
tests.

Patches 2-8 add the ability to change subflow priority after a subflow
has been established. Each subflow in a MPTCP connection has a priority
level: "regular" or "backup". Data should only be sent on backup
subflows if no regular subflows are available. The priority level can be
set when the subflow connection is established (as was already
implemented), or during the life of the connection by sending MP_PRIO in
the TCP options (as added here). Self tests are included.


Geliang Tang (8):
  mptcp: add the address ID assignment bitmap
  selftests: mptcp: add testcases for setting the address ID
  mptcp: add the outgoing MP_PRIO support
  mptcp: add the incoming MP_PRIO support
  mptcp: add set_flags command in PM netlink
  selftests: mptcp: add set_flags command in pm_nl_ctl
  mptcp: add the mibs for MP_PRIO
  selftests: mptcp: add the MP_PRIO testcases

 include/uapi/linux/mptcp.h                    |   1 +
 net/mptcp/mib.c                               |   2 +
 net/mptcp/mib.h                               |   2 +
 net/mptcp/options.c                           |  56 ++++++
 net/mptcp/pm.c                                |   8 +
 net/mptcp/pm_netlink.c                        | 172 ++++++++++++++++--
 net/mptcp/protocol.h                          |  11 ++
 .../testing/selftests/net/mptcp/mptcp_join.sh |  72 +++++++-
 .../testing/selftests/net/mptcp/pm_netlink.sh |  41 ++++-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  87 ++++++++-
 10 files changed, 430 insertions(+), 22 deletions(-)


base-commit: 833d22f2f922bbee6430e558417af060db6bbe9c
-- =

2.30.0

--===============6996938827946773417==--
