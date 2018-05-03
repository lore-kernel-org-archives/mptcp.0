Content-Type: multipart/mixed; boundary="===============8811413192043116720=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-net-next 00/14] Forward-ports from mptcp_trunk
 to mptcp-net-next
Date: Thu, 03 May 2018 14:04:44 -0700
Message-ID: <20180503210458.21524-1-cpaasch@apple.com>
X-Status: 
X-Keywords:                  
X-UID: 614

--===============8811413192043116720==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Here are some forward-ports from mptcp_trunk to mptcp-net-next of the
lockless subflows patches and the two bug-fixes.

Christoph Paasch (14):
  mptcp: Cleanup
  mptcp: Improved debugging
  mptcp: Use correct tcp_queue when calling mptcp_fragment
  mptcp: Use mptcp_can_new_subflow where possible
  mptcp: Render mptcp_sub_inherit_sockopts lockless
  mptcp: Make mptcp_set_new_pathindex lockless
  mptcp: Remove cnt_subflows
  mptcp: Remove cnt_established
  mptcp: Rename tw_lock to mpcb_list_lock
  mptcp: Make subflow-list an RCU-list
  mptcp: Don't take meta-lock when receiving third ACK
  mptcp: Make mptcp_do_join_short and mptcp_lookup_join lockless
  mptcp: Reset tsorted_anchor after call to tcp_fragment
  mptcp: Pick correct sk when iterating in mptcp_set_rto

 include/net/mptcp.h          | 127 ++++++++++++-----------------
 net/ipv4/af_inet.c           |   9 ++-
 net/ipv4/ip_sockglue.c       |   7 +-
 net/ipv4/tcp.c               |  31 +++++---
 net/ipv4/tcp_ipv4.c          |  41 +---------
 net/ipv4/tcp_minisocks.c     |   9 ++-
 net/ipv6/tcp_ipv6.c          |  41 +---------
 net/mptcp/mptcp_ctrl.c       | 186 ++++++++++++++++++++++++++++-----------=
----
 net/mptcp/mptcp_fullmesh.c   |  30 ++++---
 net/mptcp/mptcp_input.c      | 150 ++++++++++++----------------------
 net/mptcp/mptcp_ipv4.c       |  34 +++-----
 net/mptcp/mptcp_ipv6.c       |  15 ++--
 net/mptcp/mptcp_ndiffports.c |   2 +-
 net/mptcp/mptcp_output.c     |  61 ++++++++++----
 net/mptcp/mptcp_sched.c      |  32 ++++----
 15 files changed, 371 insertions(+), 404 deletions(-)

-- =

2.16.2


--===============8811413192043116720==--
