Content-Type: multipart/mixed; boundary="===============0562267357446647520=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 0/2] Fix issues in prerequisite patches
Date: Tue, 29 Oct 2019 09:55:55 -0700
Message-ID: <20191029165557.7029-1-peter.krystad@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 2344

--===============0562267357446647520==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix issues found by Mat in the "IPv6 prerequisite" patch series
when running against the multipath.org implementation.

v2: Only announce address if same family as listener
    Only bind local address if same family as remote
    Patch 1 of v1 set already merged.

Peter Krystad (2):
  mptcp: Save address family when creating socket
  mptcp: Use correct address family when creating subflows

 net/mptcp/basic.c    | 36 ++++++++++++++++++++++--------------
 net/mptcp/protocol.c |  1 +
 net/mptcp/protocol.h |  1 +
 3 files changed, 24 insertions(+), 14 deletions(-)

-- =

2.17.2

--===============0562267357446647520==--
