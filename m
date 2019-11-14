Content-Type: multipart/mixed; boundary="===============4995525662865174332=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC 0/1] Optimize mptcp_received_options
Date: Wed, 13 Nov 2019 22:01:53 -0800
Message-ID: <20191114060154.3451-1-peter.krystad@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 2523

--===============4995525662865174332==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This reduces the size from 104 to 32, at the cost of some loss of
clarity. I deliberately did not change the names of any fields,
reducing the impact on code (and the squasher).

This also seems like a good opportunity to remove all of the pr_debug()
statements from options processing which occupy so much of the log.

Peter Krystad (1):
  mptcp: Optimize struct mptcp_received_options.

 include/linux/tcp.h  |  97 ++++++++++++++++++++++++----------------
 net/mptcp/options.c  | 102 ++++++++++++++++++++++++-------------------
 net/mptcp/pm.c       |   2 +-
 net/mptcp/protocol.h |   2 +-
 4 files changed, 118 insertions(+), 85 deletions(-)

-- =

2.17.2

--===============4995525662865174332==--
