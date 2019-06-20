Content-Type: multipart/mixed; boundary="===============0352912414390499549=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/3] mptcp: move MPTCP option bits to internal header
Date: Thu, 20 Jun 2019 16:13:52 +0200
Message-ID: <20190620141355.17923-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1429

--===============0352912414390499549==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

All these OPTION_MPTCP_* are only used in files from net/mptcp.

There are 3 commits to ease the squash.

Matthieu Baerts (3):
  mptcp: move MPTCP option bits to internal header
  mptcp: move MPTCP option bits to internal header
  mptcp: move MPTCP option bits to internal header

 include/net/mptcp.h  | 11 -----------
 net/mptcp/protocol.h | 12 ++++++++++++
 2 files changed, 12 insertions(+), 11 deletions(-)
-- =

2.20.1


--===============0352912414390499549==--
