Content-Type: multipart/mixed; boundary="===============7749373457106683593=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-net-next 0/9] Remove some MPTCP-modules
Date: Tue, 01 May 2018 13:35:29 -0700
Message-ID: <20180501203538.95477-1-cpaasch@apple.com>
X-Status: 
X-Keywords:                  
X-UID: 585

--===============7749373457106683593==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I had a bit of time, so just went through the code and removed some
modules. These patches are based off of the mptcp-net-next repo's master.

I would like to get rid of fullmesh/ndiffports as well, but need to see
if I can do it such that I can run the net-next kernel on the
server-side and still have my test-scripts succeed.

Also, a next series could get rid of the scheduler module-selector.

2500 lines of code gone! ;-)

Christoph Paasch (9):
  mptcp: Remove Balia congestion control
  mptcp: Remove wVegas congestion control
  mptcp: Remove OLIA congestion control
  mptcp: Remove Coupled congestion control
  mptcp: Remove MCTCP Desync congestion control
  mptcp: Remove Redundant scheduler
  mptcp: Remove RoundRobin Scheduler
  mptcp: Remove Binder Path-Manager
  mptcp: Cleanup after removals

 include/net/mptcp.h         |  12 +-
 net/ipv4/Kconfig            |  45 ----
 net/mptcp/Kconfig           |  40 +---
 net/mptcp/Makefile          |   8 -
 net/mptcp/mctcp_desync.c    | 189 -----------------
 net/mptcp/mptcp_balia.c     | 268 ------------------------
 net/mptcp/mptcp_binder.c    | 486 ----------------------------------------=
----
 net/mptcp/mptcp_coupled.c   | 271 ------------------------
 net/mptcp/mptcp_ctrl.c      |   3 -
 net/mptcp/mptcp_ipv4.c      |   3 -
 net/mptcp/mptcp_ipv6.c      |   3 -
 net/mptcp/mptcp_olia.c      | 310 ----------------------------
 net/mptcp/mptcp_redundant.c | 301 ---------------------------
 net/mptcp/mptcp_rr.c        | 301 ---------------------------
 net/mptcp/mptcp_sched.c     |  20 +-
 net/mptcp/mptcp_wvegas.c    | 270 ------------------------
 16 files changed, 10 insertions(+), 2520 deletions(-)
 delete mode 100644 net/mptcp/mctcp_desync.c
 delete mode 100644 net/mptcp/mptcp_balia.c
 delete mode 100644 net/mptcp/mptcp_binder.c
 delete mode 100644 net/mptcp/mptcp_coupled.c
 delete mode 100644 net/mptcp/mptcp_olia.c
 delete mode 100644 net/mptcp/mptcp_redundant.c
 delete mode 100644 net/mptcp/mptcp_rr.c
 delete mode 100644 net/mptcp/mptcp_wvegas.c

-- =

2.16.2


--===============7749373457106683593==--
