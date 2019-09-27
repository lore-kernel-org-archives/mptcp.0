Content-Type: multipart/mixed; boundary="===============1765122857034227535=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/2] Add prefix to path management routines
Date: Fri, 27 Sep 2019 16:42:08 -0700
Message-ID: <20190927234210.3000-1-peter.krystad@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 1943

--===============1765122857034227535==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Make minor changes as proposed in Interim Path Manager patchset,
and then add mptcp_ prefix to all path management api routines.

squashto: Implement path manager interface commands

Peter Krystad (2):
  mptcp: Minor changes to path manager interface
  mptcp: Prefix path management routines with mptcp_

 net/mptcp/options.c  | 10 ++++---
 net/mptcp/pm.c       | 63 ++++++++++++++++++++++++++------------------
 net/mptcp/protocol.c |  5 ++--
 net/mptcp/protocol.h | 35 +++++++++++++++---------
 net/mptcp/subflow.c  |  2 +-
 5 files changed, 69 insertions(+), 46 deletions(-)

-- =

2.17.2

--===============1765122857034227535==--
