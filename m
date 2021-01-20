Content-Type: multipart/mixed; boundary="===============1201247160998462044=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 mptcp-next 0/5] mptcp: netlink event support
Date: Wed, 20 Jan 2021 16:43:32 +0100
Message-ID: <20210120154337.27997-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 7453

--===============1201247160998462044==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is round 2 of the netlink event series.
No changes here except in patch 4 (minor checkpatch format nit)
and patch 5.

Changes since v1:
- add missing export of ssk->sk_err.
  This is now done for subflow related events (Mathieu)
- fix a few indendations (Mathieu)
- Update uapi comments (Mathieu)
- fix checkpatch complaints
- fix REM/LOC_ID, its NLA_U8 (Mat, Mathieu)

Florian Westphal (5):
  mptcp: split __mptcp_close_ssk helper
  mptcp: pass subflow socket to a few helpers
  mptcp: avoid lock_fast usage in accept path
  genetlink: add CAP_NET_ADMIN test for multicast bind
  mptcp: add netlink event support

 include/net/genetlink.h    |   1 +
 include/uapi/linux/mptcp.h |  73 ++++++++++
 net/mptcp/options.c        |   2 +-
 net/mptcp/pm.c             |  24 +++-
 net/mptcp/pm_netlink.c     | 265 ++++++++++++++++++++++++++++++++++++-
 net/mptcp/protocol.c       |  30 +++--
 net/mptcp/protocol.h       |  14 +-
 net/mptcp/subflow.c        |   2 +-
 net/netlink/genetlink.c    |  32 +++++
 9 files changed, 418 insertions(+), 25 deletions(-)

-- =

2.26.2

--===============1201247160998462044==--
