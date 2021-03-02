Content-Type: multipart/mixed; boundary="===============6234774434211690550=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v3 mptcp-next 0/3] remove id 0 address
Date: Tue, 02 Mar 2021 16:12:46 +0800
Message-ID: <cover.1614672171.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 7975

--===============6234774434211690550==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v3:
 - print subflow ids in patch 1;
 - add the initial subflow's ids check in patch 2;
 - update the test in patch 3;
 - tag: export/20210226T185626.

v2:
 - drop __mptcp_wr_shutdown in v1.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/140

Geliang Tang (3):
  mptcp: unify RM_ADDR and RM_SUBFLOW receiving
  mptcp: check the removing initial subflow
  DO-NOT-MERGE: mptcp: remove id 0 test

 net/mptcp/pm_netlink.c                        | 99 +++++++++----------
 .../testing/selftests/net/mptcp/mptcp_join.sh | 10 +-
 2 files changed, 52 insertions(+), 57 deletions(-)

-- =

2.29.2

--===============6234774434211690550==--
