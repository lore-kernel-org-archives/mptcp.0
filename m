Content-Type: multipart/mixed; boundary="===============1726256583879134702=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v1 0/12] pm netlink: followup and fixes
Date: Wed, 04 Mar 2020 16:01:59 +0100
Message-ID: <cover.1583334095.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 3849

--===============1726256583879134702==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series bring some fixes and improvement related to the PM netlink,
specifically:

- renames 4th_ack subflow field to 'fully_established':
  this is hopefully more accurate
- implements support to enforce the maximum number of subflows per msk
- implements MP_JOIN 3rd ack retransmission and 4th ack delivery:
  this [ab]use the TCP delack timer. I personally think the idea is nice and
  avoids changes to the core TCP stack, but I guess it could be disputed
- more accurare 'fully established' accounting as per RFC
- drop the msk level 'fully_established' field, as we can use the first sub=
flow
  status without additional locking instead. This simplify core PM event
  handling
- adds more MP_JOIN related mib counters
- update the PM netlink to enforce a configurable maximum number of subflows
  per msk
- extend the pm netlink self-tests to check the above APIs
- uses amost all the above to fix the currently disable mp join self-tests =
and
 re-enable them

Note: mp join self tests are still unstable, e.g. can fail randomly, due to=
 an
old race between mptcp_token_update_accept() and mptcp_token_get_sock(): e.=
g.
a client may legitly try to create a subflow after that the first one is fu=
lly
established but before the server has accepted the initial socket:
mptcp_token_get_sock() will fail and MP_JOIN will fail too, incrementing
MPTCP_MIB_JOINNOTOKEN.
I think the above should be addressed in a separate series - otherwise this=
 one
will be too big.

 include/uapi/linux/mptcp.h                      |   23 ++--
 net/mptcp/diag.c                                |    4 =

 net/mptcp/mib.c                                 |    3 =

 net/mptcp/mib.h                                 |    3 =

 net/mptcp/options.c                             |  135 ++++++++++++++++++-=
-----
 net/mptcp/pm.c                                  |   35 ++++--
 net/mptcp/pm_netlink.c                          |   93 +++++++++++-----
 net/mptcp/protocol.c                            |   23 ++--
 net/mptcp/protocol.h                            |    8 +
 net/mptcp/subflow.c                             |    9 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  100 ++++++++++++++---
 tools/testing/selftests/net/mptcp/pm_netlink.sh |   17 ++-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c   |   46 +++++---
 13 files changed, 363 insertions(+), 136 deletions(-)

--===============1726256583879134702==--
