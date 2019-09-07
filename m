Content-Type: multipart/mixed; boundary="===============3854348323718241070=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/2] Interim Path Manager
Date: Fri, 06 Sep 2019 18:30:00 -0700
Message-ID: <20190907013002.2759-1-peter.krystad@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 1794

--===============3854348323718241070==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Patchset includes the interim path manager plus sysctl setting of
the announce address and binding local address when creating subflows.
I also split the path manager into a seperate file.

Peter Krystad (2):
  mptcp: Minor changes to path manager interface
  mptcp: Implement interim path manager

 net/mptcp/Makefile   |   2 +-
 net/mptcp/interim.c  | 247 +++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/pm.c       |  38 +++++--
 net/mptcp/protocol.c |   2 +-
 net/mptcp/protocol.h |  14 ++-
 5 files changed, 290 insertions(+), 13 deletions(-)
 create mode 100644 net/mptcp/interim.c

-- =

2.17.2


--===============3854348323718241070==--
