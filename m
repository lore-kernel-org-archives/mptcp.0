Content-Type: multipart/mixed; boundary="===============5215850118859787974=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp 0/7] mptcp netlink event support
Date: Thu, 14 Jan 2021 18:36:47 +0100
Message-ID: <20210114173654.7618-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 7381

--===============5215850118859787974==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series adds netlink event support.
The format is largely identical to the one used by the out-of-tree
kernel, with the exception of the genl name.

Out of tree kernel uses "mptcp", while this used the existing
"mptcp_pm".

The initial two patches are preparation patches not related
to the rest, so they could be applied independently.

The other patches make little sense without the actual netlink
patch.

Comments welcome.  I'll send a iproute2 patch to help with
debugging in a bit.

Florian Westphal (7):
  mptcp: pm: add lockdep assertions
  mptcp: move pm netlink work into pm_netlink
  mptcp: split __mptcp_close_ssk helper
  mptcp: pass subflow socket to a few helpers
  mptcp: avoid lock_fast usage in accept path
  genetlink: add CAP_NET_ADMIN test for multicast bind
  mptcp: add netlink event support

 include/net/genetlink.h    |   1 +
 include/uapi/linux/mptcp.h |  70 +++++++++
 net/mptcp/options.c        |   2 +-
 net/mptcp/pm.c             |  26 +++-
 net/mptcp/pm_netlink.c     | 296 ++++++++++++++++++++++++++++++++++++-
 net/mptcp/protocol.c       |  65 ++++----
 net/mptcp/protocol.h       |  24 +--
 net/mptcp/subflow.c        |   2 +-
 net/netlink/genetlink.c    |  32 ++++
 9 files changed, 452 insertions(+), 66 deletions(-)

-- =

2.26.2

--===============5215850118859787974==--
