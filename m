Content-Type: multipart/mixed; boundary="===============0440902679927216747=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next 0/2] remove address when netlink
 flush addrs and testcase
Date: Mon, 30 Nov 2020 15:11:24 +0800
Message-ID: <cover.1606719598.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 6982

--===============0440902679927216747==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v2:
 - update the testcase.

This patchset removes address when netlink do flush addrs command, and
adds the testcase for flush addrs command.

Geliang Tang (2):
  mptcp: remove address when netlink flush addrs
  selftests: mptcp: add the flush addrs testcase

 net/mptcp/pm_netlink.c                        | 15 ++++--
 .../testing/selftests/net/mptcp/mptcp_join.sh | 50 +++++++++++++------
 2 files changed, 46 insertions(+), 19 deletions(-)

-- =

2.26.2

--===============0440902679927216747==--
