Content-Type: multipart/mixed; boundary="===============2339256341352220313=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 net 0/2] mptcp: fix subflow's
 local_id/remote_id issues
Date: Tue, 08 Sep 2020 10:49:37 +0800
Message-ID: <cover.1599532593.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 5753

--===============2339256341352220313==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v2:
 - add Fixes tags;
 - simply with 'return addresses_equal';
 - use 'reversed Xmas tree' way.

Geliang Tang (2):
  mptcp: fix subflow's local_id issues
  mptcp: fix subflow's remote_id issues

 net/mptcp/pm_netlink.c | 17 +++++++++++++++--
 net/mptcp/subflow.c    |  7 +++++--
 2 files changed, 20 insertions(+), 4 deletions(-)

-- =

2.17.1

--===============2339256341352220313==--
