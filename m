Content-Type: multipart/mixed; boundary="===============5805118363889765483=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 0/2] mptcp: Misc. updates for tests & lock
 annotation
Date: Thu, 04 Feb 2021 15:23:28 -0800
Message-ID: <20210204232330.202441-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 7624

--===============5805118363889765483==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Here are two fixes we've collected in the mptcp tree.

Patch 1 refactors a MPTCP selftest script to allow running a subset of
the tests.

Patch 2 adds some locking & might_sleep assertations.


Florian Westphal (1):
  mptcp: pm: add lockdep assertions

Geliang Tang (1):
  selftests: mptcp: add command line arguments for mptcp_join.sh

 net/mptcp/pm.c                                |    2 +
 net/mptcp/pm_netlink.c                        |   13 +
 net/mptcp/protocol.c                          |    4 +
 net/mptcp/protocol.h                          |    5 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 1068 +++++++++--------
 5 files changed, 614 insertions(+), 478 deletions(-)


base-commit: e93fac3b51617401df46332499daae000e322ff8
-- =

2.30.0

--===============5805118363889765483==--
