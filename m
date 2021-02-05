Content-Type: multipart/mixed; boundary="===============7649882543788804832=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 0/2] Squash to "RM_ADDR: remove a
 list of addrs"
Date: Sat, 06 Feb 2021 00:32:10 +0800
Message-ID: <cover.1612542562.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 7647

--===============7649882543788804832==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These two patches should be squash into "RM_ADDR: remove a list of addrs"
patch set before patch 1/9 "mptcp: use rm_ids array in mptcp_out_options".

Geliang Tang (2):
  mptcp: reserve the MAX_ADDR_ID assignment
  selftests: mptcp: skip MAX_ADDR_ID in IDs assignment testcases

 net/mptcp/pm_netlink.c                        |  2 ++
 .../testing/selftests/net/mptcp/pm_netlink.sh | 24 +++++++++----------
 2 files changed, 14 insertions(+), 12 deletions(-)

-- =

2.29.2

--===============7649882543788804832==--
