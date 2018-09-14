Content-Type: multipart/mixed; boundary="===============2731264018768114469=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 00/20] Forward-ports of lockless subflow establishment
Date: Fri, 14 Sep 2018 10:25:02 -0700
Message-ID: <20180914172524.67961-1-cpaasch@apple.com>
X-Status: 
X-Keywords:                  
X-UID: 733

--===============2731264018768114469==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

As the fixes have now landed in mptcp_trunk, here are the forward-ports
of the lockless subflow establishment.

Tested it a bit and it seems to work fine.

Christoph Paasch (20):
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
  mptcp: Build-Fix
  mptcp: Reset sk_it to NULL as we keep on iterating
  mptcp: Close remaining subflows when falling back in
    mptcp_verif_dss_csum
  mptcp: Restart subflow-selection when we force a re-evaluation
  mptcp: Don't free skb when tcp_transmit_skb without cloning
  mptcp: Use spin_lock_bh where appropriate for mpcb_list_lock

 include/net/mptcp.h          | 132 ++++++++++++++-----------------
 net/ipv4/af_inet.c           |   9 ++-
 net/ipv4/ip_sockglue.c       |   7 +-
 net/ipv4/tcp.c               |  31 +++++---
 net/ipv4/tcp_ipv4.c          |  41 +---------
 net/ipv4/tcp_minisocks.c     |   9 ++-
 net/ipv6/tcp_ipv6.c          |  41 +---------
 net/mptcp/mptcp_ctrl.c       | 184 ++++++++++++++++++++++++++++-----------=
----
 net/mptcp/mptcp_fullmesh.c   |  30 ++++---
 net/mptcp/mptcp_input.c      | 154 +++++++++++++-----------------------
 net/mptcp/mptcp_ipv4.c       |  34 +++-----
 net/mptcp/mptcp_ipv6.c       |  15 ++--
 net/mptcp/mptcp_ndiffports.c |   2 +-
 net/mptcp/mptcp_output.c     |  65 ++++++++++-----
 net/mptcp/mptcp_sched.c      |  43 +++++-----
 15 files changed, 388 insertions(+), 409 deletions(-)

-- =

2.16.2


--===============2731264018768114469==--
