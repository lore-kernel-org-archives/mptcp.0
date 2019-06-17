Content-Type: multipart/mixed; boundary="===============0593252934383203391=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/3] MP_JOIN handling: v3 from Peter
Date: Mon, 17 Jun 2019 16:11:39 +0200
Message-ID: <20190617141142.6782-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1415

--===============0593252934383203391==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Peter recently sent a v3 of his patch-set but I had already applied it in t=
he
repo. Here is what I extracted from the v3 using diff.

If Paolo (or others) is OK, I can include this in what we are going to send=
 to
Eric.

Peter Krystad (3):
  squash to: mptcp: Add path manager interface
  squash to: mptcp: Add ADD_ADDR handling
  squash to: mptcp: Add handling of incoming MP_JOIN requests

 include/linux/tcp.h  |  9 +++++--
 include/net/mptcp.h  |  6 +++--
 net/mptcp/options.c  | 56 +++++++++++++++++++++-----------------------
 net/mptcp/pm.c       | 23 +++++++++---------
 net/mptcp/protocol.c |  2 +-
 net/mptcp/protocol.h |  9 +++++++
 net/mptcp/subflow.c  |  9 ++++---
 7 files changed, 65 insertions(+), 49 deletions(-)

-- =

2.20.1


--===============0593252934383203391==--
