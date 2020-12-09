Content-Type: multipart/mixed; boundary="===============5903344803849385238=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v4 mptcp-next 0/2] mptcp: add the address ID
 assignment bitmap and testcases
Date: Wed, 09 Dec 2020 16:04:32 +0800
Message-ID: <cover.1607500712.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 7083

--===============5903344803849385238==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v4:
 - update the find_next code

v3:
 - call find_next_zero_bit() again for the invalid id.
 - use "for (i =3D id; ..." in mptcp_nl_cmd_dump_addrs.
 - add a wrap around testcase.

v2:
 - use BITS_PER_LONG macro.
 - add back the callback argument in cmd_dump_addrs.
 - add a testcase.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/117

Geliang Tang (2):
  mptcp: add the address ID assignment bitmap
  selftests: mptcp: add testcases for setting the address ID

 net/mptcp/pm_netlink.c                        | 71 ++++++++++++++-----
 .../testing/selftests/net/mptcp/pm_netlink.sh | 41 ++++++++++-
 2 files changed, 92 insertions(+), 20 deletions(-)

-- =

2.26.2

--===============5903344803849385238==--
