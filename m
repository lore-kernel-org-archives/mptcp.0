Content-Type: multipart/mixed; boundary="===============1610138409750316761=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/2] Minor patches [Remaining two]
Date: Fri, 07 Jun 2019 17:40:38 -0700
Message-ID: <20190608004040.3426-1-peter.krystad@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 1317

--===============1610138409750316761==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Responding to comments and rebase.

Peter Krystad (2):
  mptcp: reduce number of pr_debug() calls.
  mptcp: Refactor mptcp_established_options() to single hook

 include/net/mptcp.h   | 21 ++++---------
 net/ipv4/tcp_output.c | 20 +++---------
 net/mptcp/options.c   | 73 ++++++++++++++++++++++++++++---------------
 3 files changed, 59 insertions(+), 55 deletions(-)

-- =

2.17.2


--===============1610138409750316761==--
