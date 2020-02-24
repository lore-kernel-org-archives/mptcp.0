Content-Type: multipart/mixed; boundary="===============8693246462094656776=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v4 0/9] add locking to PM APis, implement PM netlink
Date: Mon, 24 Feb 2020 16:51:03 +0100
Message-ID: <cover.1582558805.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 3751

--===============8693246462094656776==
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

It also introduce the PM netlink - it replace the current basic ones, the
related patch has been dropped locally.

git tree available at:

https://github.com/pabeni/mptcp/tree/mptcp_net-next_part3_7

changes from v3:
 - many cleanup and netlink fixes (Matt) - see individual patches changelog
   for the details

changes from v2:
 - hook the new tests into the self-tests infra

changes from v1:
 - 2 new patches: mp_join self-tests (9/9) and a specific mp_join fix (6/9)
 - fixed several bugs as pointed out by the above tests
 - added support for bind to interface

changes from RFC:
 - cleanup uAPIs
 - added self-tests for the uAPIs
 - fixed ton of bugs
 - included feedback from Mat

 include/uapi/linux/mptcp.h                        |   53 +
 net/mptcp/Makefile                                |    3 =

 net/mptcp/options.c                               |   60 -
 net/mptcp/pm.c                                    |  361 +++------
 net/mptcp/pm_netlink.c                            |  829 +++++++++++++++++=
+++++
 net/mptcp/protocol.c                              |   14 =

 net/mptcp/protocol.h                              |  113 +-
 net/mptcp/subflow.c                               |   65 +
 tools/testing/selftests/net/mptcp/Makefile        |    9 =

 tools/testing/selftests/net/mptcp/mptcp_connect.c |   19 =

 tools/testing/selftests/net/mptcp/mptcp_join.sh   |  296 +++++++
 tools/testing/selftests/net/mptcp/pm_netlink.sh   |  123 +++
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c     |  604 ++++++++++++++++
 13 files changed, 2230 insertions(+), 319 deletions(-)

--===============8693246462094656776==--
