Content-Type: multipart/mixed; boundary="===============8468251645350623152=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/4] Move MPTCP #defines to internal header
Date: Thu, 13 Jun 2019 15:24:50 -0700
Message-ID: <20190613222454.10728-1-peter.krystad@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 1366

--===============8468251645350623152==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Like it says...

Peter Krystad (4):
  mptcp: Move TCPOLEN #defines to protocol.h
  mptcp: Move TCPOLEN #defines to protocol.h
  mptcp: Move TCPOLEN #defines to protocol.h
  mptcp: make flag field naming consistent

 include/net/tcp.h    |  9 ---------
 net/mptcp/options.c  |  4 ++--
 net/mptcp/protocol.h | 16 +++++++++++++---
 3 files changed, 15 insertions(+), 14 deletions(-)

-- =

2.17.2


--===============8468251645350623152==--
