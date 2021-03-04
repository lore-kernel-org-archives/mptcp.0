Content-Type: multipart/mixed; boundary="===============1252813110763293570=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v6 mptcp-next 0/5] remove id 0 address
Date: Thu, 04 Mar 2021 17:33:31 +0800
Message-ID: <cover.1614849685.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 8016

--===============1252813110763293570==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v6:
 - add addr argument for del_addr.
 - tag: export/20210226T185626
 - need to apply the squash-to patchset "avoid passing rm_list as a struct"
or the single patch "avoid passing rm_list as a struct" in v5 first.

v5:
 - add patch 1 "avoid passing rm_list as a struct".
 - re-use MPTCP_MIB_RMADDR/MPTCP_MIB_RMSUBFLOW in patch 3.
 - use (id =3D=3D 0) instead of (!id) in patch 4.

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
  mptcp: remove all subflows involving id 0 address
  mptcp: unify RM_ADDR and RM_SUBFLOW receiving
  mptcp: remove id 0 address
  selftests: mptcp: add addr argument for del_addr
  selftests: mptcp: remove id 0 address testcases

 net/mptcp/pm_netlink.c                        | 127 ++++++++++--------
 .../testing/selftests/net/mptcp/mptcp_join.sh |  35 ++++-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  33 ++++-
 3 files changed, 137 insertions(+), 58 deletions(-)

-- =

2.29.2

--===============1252813110763293570==--
