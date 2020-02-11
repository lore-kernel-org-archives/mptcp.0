Content-Type: multipart/mixed; boundary="===============7516145554791096171=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 0/6] dd locking to PM APis, implement PM netlink
Date: Tue, 11 Feb 2020 19:12:07 +0100
Message-ID: <cover.1581444137.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 3612

--===============7516145554791096171==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Sending as an early RFC to gather feedback, as this is proving to be more
intrusive that what I initially hoped for.

This implement the locking required by the PM to allow concurent subflow
accessing the msk PM data in a safe way. Such data is protected via a msk-l=
evel
spinlock. It relies on the Double checked locking to avoid contention in the
most common scenarion (no or very little PM "actions").

Overall the above adds quite a bit of code churn, is that a too premature
optimization? On the flip side, the whole PM processing should be quite
light on the CPU in most cases.

Additionally changes more than a bit the PM hooks/APIs, to be hopefully sim=
pler
and avoiding duplicate code (no v4/v6 variant, work queue management done b=
y the
core PM infra).

It also introduce the PM netlink - should replace the current basic ones.
Completely untested but please have a look at the specified netlink uAPI.

TODO:
 - implement U/S helper
 - self-tests
 - do we need NL dump operation to inspect the PM netlink status?

 include/uapi/linux/mptcp.h |   42 +++
 net/mptcp/Makefile         |    3 =

 net/mptcp/options.c        |   59 ++---
 net/mptcp/pm.c             |  340 +++++++++++++----------------
 net/mptcp/pm_netlink.c     |  524 ++++++++++++++++++++++++++++++++++++++++=
+++++
 net/mptcp/protocol.c       |    2 =

 net/mptcp/protocol.h       |  110 +++++----
 net/mptcp/subflow.c        |   63 +++--
 8 files changed, 872 insertions(+), 271 deletions(-)

--===============7516145554791096171==--
