Content-Type: multipart/mixed; boundary="===============0444400208230094814=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/7] Minor patches
Date: Wed, 05 Jun 2019 17:36:25 -0700
Message-ID: <20190606003632.2863-1-peter.krystad@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 1295

--===============0444400208230094814==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Mostly responding to some of Paolo's comments on the MP_JOIN RFC.

Peter Krystad (7):
  mptcp: reduce number of pr_debug() calls.
  mptcp: reduce number of pr_debug() calls.
  mptcp: reduce number of pr_debug() calls.
  mptcp: reduce number of pr_debug() calls.
  mptcp: parsing DSS option should use own flags field.
  mptcp: Check flags in MP_CAPABLE option
  mptcp: Refactor mptcp_established_options() to single hook

 include/linux/tcp.h   |  1 +
 include/net/mptcp.h   | 30 +++-----------
 net/ipv4/tcp_output.c | 21 +++-------
 net/mptcp/options.c   | 95 ++++++++++++++++++++++++++++---------------
 net/mptcp/protocol.c  |  9 +---
 net/mptcp/protocol.h  | 15 +++++--
 net/mptcp/subflow.c   |  5 +--
 7 files changed, 91 insertions(+), 85 deletions(-)

-- =

2.17.2


--===============0444400208230094814==--
