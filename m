Content-Type: multipart/mixed; boundary="===============0861931693460132548=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 0/8] mptcp: Add genl events for connection
 info
Date: Fri, 12 Feb 2021 15:59:53 -0800
Message-ID: <20210213000001.379332-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 7783

--===============0861931693460132548==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series from the MPTCP tree adds genl multicast events that are
important for implementing a userspace path manager. In MPTCP, a path
manager is responsible for adding or removing additional subflows on
each MPTCP connection. The in-kernel path manager (already part of the
kernel) is a better fit for many server use cases, but the additional
flexibility of userspace path managers is often useful for client
devices.

Patches 1, 2, 4, 5, and 6 do some refactoring to streamline the netlink
event implementation in the final patch.

Patch 3 improves the timeliness of subflow destruction to ensure the
'subflow closed' event will be sent soon enough.

Patch 7 allows use of the GENL_UNS_ADMIN_PERM flag on genl mcast groups
to mandate CAP_NET_ADMIN, which is important to protect token information
in the MPTCP events. This is a genetlink change.

Patch 8 adds the MPTCP netlink events.


Florian Westphal (8):
  mptcp: move pm netlink work into pm_netlink
  mptcp: split __mptcp_close_ssk helper
  mptcp: schedule worker when subflow is closed
  mptcp: move subflow close loop after sk close check
  mptcp: pass subflow socket to a few helpers
  mptcp: avoid lock_fast usage in accept path
  genetlink: add CAP_NET_ADMIN test for multicast bind
  mptcp: add netlink event support

 include/net/genetlink.h    |   1 +
 include/uapi/linux/mptcp.h |  74 +++++++++
 net/mptcp/options.c        |   2 +-
 net/mptcp/pm.c             |  24 ++-
 net/mptcp/pm_netlink.c     | 310 ++++++++++++++++++++++++++++++++++++-
 net/mptcp/protocol.c       |  72 ++++-----
 net/mptcp/protocol.h       |  20 +--
 net/mptcp/subflow.c        |  27 +++-
 net/netlink/genetlink.c    |  32 ++++
 9 files changed, 491 insertions(+), 71 deletions(-)


base-commit: c3ff3b02e99c691197a05556ef45f5c3dd2ed3d6
-- =

2.30.1

--===============0861931693460132548==--
