Content-Type: multipart/mixed; boundary="===============0188201781086151340=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 0/2] remove address when netlink
 flush addrs and testcase
Date: Mon, 30 Nov 2020 14:48:20 +0800
Message-ID: <cover.1606718512.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 6979

--===============0188201781086151340==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patchset removes address when netlink do flush addrs command, and
adds the testcase for flush addrs command.

Geliang Tang (2):
  mptcp: remove address when netlink flush addrs
  selftests: mptcp: add the flush addrs testcase

 net/mptcp/pm_netlink.c                        | 15 ++++--
 .../testing/selftests/net/mptcp/mptcp_join.sh | 52 +++++++++++++------
 2 files changed, 47 insertions(+), 20 deletions(-)

-- =

2.26.2

--===============0188201781086151340==--
