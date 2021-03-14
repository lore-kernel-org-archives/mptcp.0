Content-Type: multipart/mixed; boundary="===============4281052108696218164=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 0/7] refactor mptcp_addr_info and
 cleanups
Date: Sun, 14 Mar 2021 22:22:50 +0800
Message-ID: <cover.1615731165.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 8148

--===============4281052108696218164==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The patch set refactored struct mptcp_addr_info, and use it in both
mptcp_out_options and mptcp_out_options. Then drop the duplicate code
and do cleanups.

Geliang Tang (7):
  mptcp: move ifindex and flags out of mptcp_addr_info
  mptcp: use mptcp_addr_info in mptcp_out_options
  mptcp: use mptcp_addr_info in mptcp_options_received
  mptcp: drop MPTCP_ADDR_IPVERSION_4/6
  mptcp: unify add_addr(6)_generate_hmac
  mptcp: drop OPTION_MPTCP_ADD_ADDR6
  mptcp: drop unnecessary CONFIG_MPTCP_IPV6

 include/net/mptcp.h    |  21 +++--
 net/mptcp/options.c    | 175 +++++++++++++----------------------------
 net/mptcp/pm_netlink.c |  55 +++++--------
 net/mptcp/protocol.h   |  38 +++------
 net/mptcp/subflow.c    |   6 +-
 5 files changed, 104 insertions(+), 191 deletions(-)

-- =

2.30.2

--===============4281052108696218164==--
