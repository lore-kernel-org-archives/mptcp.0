Content-Type: multipart/mixed; boundary="===============5683485539367571832=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/3] Fix issues in prerequisite patches
Date: Mon, 21 Oct 2019 16:41:49 -0700
Message-ID: <20191021234152.3091-1-peter.krystad@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 2243

--===============5683485539367571832==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix issues found by Mat in the "IPv6 prerequisite" patch series
when running against the multipath.org implementation.

Peter Krystad (3):
  mptcp: fix mistake in path manager interface
  mptcp: Save address family when creating socket
  mptcp: Use correct address family when creating subflows

 net/mptcp/basic.c    | 28 ++++++++++++++++------------
 net/mptcp/pm.c       |  4 ++--
 net/mptcp/protocol.c |  1 +
 net/mptcp/protocol.h |  1 +
 4 files changed, 20 insertions(+), 14 deletions(-)

-- =

2.17.2

--===============5683485539367571832==--
