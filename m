Content-Type: multipart/mixed; boundary="===============3859778372900874294=="
MIME-Version: 1.0
From: rao.shoaib at oracle.com
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC 0/1] MPTCP patch requested by Peter Krystad
Date: Thu, 22 Mar 2018 16:21:27 -0700
Message-ID: <1521760888-19026-1-git-send-email-rao.shoaib@oracle.com>
X-Status: 
X-Keywords:                  
X-UID: 402

--===============3859778372900874294==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Rao Shoaib <rao.shoaib(a)oracle.com>

This patch has been created at the request of Peter Krystad. This is not a =
submission, nor code review. The code does not meet Linux coding style stan=
dards. It does work and has been tested against latest MPTCP. This is based=
 on mptcp_v0.91.

I will be happy to answer any questions. Please report any issues.
I do have plans to clean it up and make more modifications.

Rao Shoaib (1):
  MPTCP changes that work with the modified network code

 include/net/mptcp.h         | 343 +++++++--------
 include/net/mptcp_v4.h      |  14 +-
 include/net/mptcp_v6.h      |  13 -
 net/mptcp/mptcp_ctrl.c      | 600 +++++++++++++++++++-------
 net/mptcp/mptcp_fullmesh.c  |  20 +-
 net/mptcp/mptcp_input.c     | 996 ++++++++++++++++++++++++++++++++--------=
----
 net/mptcp/mptcp_ipv4.c      | 232 ++---------
 net/mptcp/mptcp_ipv6.c      | 288 ++-----------
 net/mptcp/mptcp_ofo_queue.c | 306 +++++---------
 net/mptcp/mptcp_output.c    | 475 +++++++++++----------
 net/mptcp/mptcp_redundant.c |   6 +-
 net/mptcp/mptcp_rr.c        |   4 +-
 net/mptcp/mptcp_sched.c     |  55 ++-
 13 files changed, 1793 insertions(+), 1559 deletions(-)

-- =

2.7.4


--===============3859778372900874294==--
