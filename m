Content-Type: multipart/mixed; boundary="===============6079745965524908200=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v4 mptcp-next 0/4] remove id 0 address
Date: Wed, 03 Mar 2021 15:48:57 +0800
Message-ID: <cover.1614757087.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 7985

--===============6079745965524908200==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v4:
 - add new function mptcp_nl_remove_id_zero_address.
 - add new testcases.
 - tag: export/20210226T185626.

v3:
 - print subflow ids in patch 1;
 - add the initial subflow's ids check in patch 2;
 - update the test in patch 3;
 - tag: export/20210226T185626.

v2:
 - drop __mptcp_wr_shutdown in v1.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/140

Geliang Tang (4):
  mptcp: remove all subflows involving id 0 address
  mptcp: unify RM_ADDR and RM_SUBFLOW receiving
  mptcp: remove id zero address
  selftests: mptcp: mptcp: remove id 0 address testcases

 net/mptcp/pm_netlink.c                        | 120 ++++++++++--------
 .../testing/selftests/net/mptcp/mptcp_join.sh |  29 ++++-
 2 files changed, 96 insertions(+), 53 deletions(-)

-- =

2.29.2

--===============6079745965524908200==--
