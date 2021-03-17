Content-Type: multipart/mixed; boundary="===============4564003133869806729=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v3 mptcp-next 0/7] refactor mptcp_addr_info and
 cleanups
Date: Wed, 17 Mar 2021 15:36:15 +0800
Message-ID: <cover.1615966219.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 8179

--===============4564003133869806729==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v3:
 - Add new parameters flags and ifindex to __mptcp_subflow_connect.
 - Drop the patch "mptcp: drop unnecessary CONFIG_MPTCP_IPV6" in v2.
 - Add a new selftest patch.

v2:
 - Patch 1, avoid changing __mptcp_subflow_connect's parameter, use
 container_of to get the entry.
 - No change in patches 2-7.

The patch set refactored struct mptcp_addr_info, and use it in both
mptcp_out_options and mptcp_out_options. Then drop the duplicate code
and do cleanups.


Geliang Tang (7):
  mptcp: move flags and ifindex out of mptcp_addr_info
  mptcp: use mptcp_addr_info in mptcp_out_options
  mptcp: drop OPTION_MPTCP_ADD_ADDR6
  mptcp: use mptcp_addr_info in mptcp_options_received
  mptcp: drop MPTCP_ADDR_IPVERSION_4/6
  mptcp: unify add_addr(6)_generate_hmac
  selftests: mptcp: add the net device name testcase

 include/net/mptcp.h                           |  21 ++-
 net/mptcp/options.c                           | 169 ++++++------------
 net/mptcp/pm_netlink.c                        |  41 +++--
 net/mptcp/protocol.h                          |  38 +---
 net/mptcp/subflow.c                           |   7 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh |   8 +
 6 files changed, 110 insertions(+), 174 deletions(-)

-- =

2.30.2

--===============4564003133869806729==--
