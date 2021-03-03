Content-Type: multipart/mixed; boundary="===============0322381754999506201=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v5 mptcp-next 0/5] remove id 0 address
Date: Wed, 03 Mar 2021 21:13:15 +0800
Message-ID: <cover.1614776769.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 7994

--===============0322381754999506201==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v5:
 - add patch 1 "avoid passing rm_list as a struct".
 - re-use MPTCP_MIB_RMADDR/MPTCP_MIB_RMSUBFLOW in patch 3.
 - use (id =3D=3D 0) instead of (!id) in patch 4.
 - tag: export/20210226T185626.

v4:
 - add new function mptcp_nl_remove_id_zero_address.
 - add new testcases.

v3:
 - print subflow ids in patch 1;
 - add the initial subflow's ids check in patch 2;
 - update the test in patch 3;

v2:
 - drop __mptcp_wr_shutdown in v1.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/140

Geliang Tang (5):
  mptcp: avoid passing rm_list as a struct
  mptcp: remove all subflows involving id 0 address
  mptcp: unify RM_ADDR and RM_SUBFLOW receiving
  mptcp: remove id 0 address
  selftests: mptcp: remove id 0 address testcases

 net/mptcp/options.c                           |   4 +-
 net/mptcp/pm.c                                |  23 ++--
 net/mptcp/pm_netlink.c                        | 128 ++++++++++--------
 net/mptcp/protocol.h                          |  16 ++-
 .../testing/selftests/net/mptcp/mptcp_join.sh |  29 +++-
 5 files changed, 122 insertions(+), 78 deletions(-)

-- =

2.29.2

--===============0322381754999506201==--
