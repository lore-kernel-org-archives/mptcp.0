Content-Type: multipart/mixed; boundary="===============7948999205730451177=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/7] add locking to PM APis, implement PM netlink
Date: Mon, 17 Feb 2020 19:28:26 +0100
Message-ID: <cover.1581963738.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 3678

--===============7948999205730451177==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This implement the locking required by the PM to allow concurent subflow
accessing the msk PM data in a safe way. Such data is protected via a msk-l=
evel
spinlock. It relies on the Double checked locking to avoid contention in the
most common scenarion (no or very little PM "actions").

Additionally changes more than a bit the PM hooks/APIs, to be hopefully sim=
pler
and avoiding duplicate code (no v4/v6 variant, work queue management done b=
y the
core PM infra).

It also introduce the PM netlink - it should replace the current basic ones.

git tree available at:

https://github.com/pabeni/mptcp/tree/mptcp_net-next_part3_5

changes from RFC:
 - cleanup uAPIs
 - added self-tests for the uAPIs
 - fixed ton of bugs
 - included feedback from Mat

TODO:
 - implement MP_JOIN self-tests
---
 include/uapi/linux/mptcp.h                      |   51 +
 net/mptcp/Makefile                              |    3 =

 net/mptcp/options.c                             |   59 -
 net/mptcp/pm.c                                  |  325 ++++-----
 net/mptcp/pm_netlink.c                          |  799 +++++++++++++++++++=
+++++
 net/mptcp/protocol.c                            |    2 =

 net/mptcp/protocol.h                            |  112 ++-
 net/mptcp/subflow.c                             |   63 +
 tools/testing/selftests/net/mptcp/Makefile      |    4 =

 tools/testing/selftests/net/mptcp/pm_netlink.sh |  149 ++++
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c   |  556 ++++++++++++++++
 11 files changed, 1850 insertions(+), 273 deletions(-)

--===============7948999205730451177==--
