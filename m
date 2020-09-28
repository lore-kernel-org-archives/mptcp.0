Content-Type: multipart/mixed; boundary="===============8532511131271038315=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v3 mptcp-next 0/2] add ADD_ADDR IPv6 support
Date: Mon, 28 Sep 2020 15:46:12 +0800
Message-ID: <cover.1601278543.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 6068

--===============8532511131271038315==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v3:
 - drop other MPTCP suboptions instead of OPTION_TS

v2:
 - avoid adding new field to tcp_sock, add new field in mptcp_pm_data.
 - drop OPTION_TS in mptcp_established_options_add_addr, not in
tcp_established_options.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/55

Geliang Tang (2):
  mptcp: send out dedicated ADD_ADDR packet
  selftests: mptcp: add subflow and ADD_ADDR IPv6 test cases

 net/mptcp/options.c                           | 25 ++++++++++++---
 net/mptcp/pm.c                                | 16 ++++++++--
 net/mptcp/protocol.h                          |  4 ++-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 32 ++++++++++++++++++-
 4 files changed, 69 insertions(+), 8 deletions(-)

-- =

2.17.1

--===============8532511131271038315==--
