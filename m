Content-Type: multipart/mixed; boundary="===============1169937992437959126=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 0/2] Minor patches [Remaining two]
Date: Tue, 11 Jun 2019 10:51:46 -0700
Message-ID: <20190611175148.11832-1-peter.krystad@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 1334

--===============1169937992437959126==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Responding to comments and rebase.

v2 - fix mp_opt usage and remove changes to mptcp_write_options logic.

Peter Krystad (2):
  mptcp: reduce number of pr_debug() calls.
  mptcp: Refactor mptcp_established_options() to single hook

 include/net/mptcp.h   | 21 ++++---------
 net/ipv4/tcp_output.c | 20 ++++---------
 net/mptcp/options.c   | 70 +++++++++++++++++++++++++++++--------------
 3 files changed, 58 insertions(+), 53 deletions(-)

-- =

2.17.2


--===============1169937992437959126==--
