Content-Type: multipart/mixed; boundary="===============0924418394659522871=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net 0/6] mptcp: Miscellaneous fixes
Date: Thu, 11 Feb 2021 15:30:36 -0800
Message-ID: <20210211233042.304878-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 7759

--===============0924418394659522871==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Here are some MPTCP fixes for the -net tree, addressing various issues
we have seen thanks to syzkaller and other testing:

Patch 1 correctly propagates errors at connection time and for TCP
fallback connections.

Patch 2 sets the expected poll() events on SEND_SHUTDOWN.

Patch 3 fixes a retranmit crash and unneeded retransmissions.

Patch 4 fixes possible uninitialized data on the error path during
socket creation.

Patch 5 addresses a problem with MPTCP window updates.

Patch 6 fixes a case where MPTCP retransmission can get stuck.


Paolo Abeni (6):
  mptcp: deliver ssk errors to msk
  mptcp: fix poll after shutdown
  mptcp: fix spurious retransmissions
  mptcp: init mptcp request socket earlier
  mptcp: better msk receive window updates
  mptcp: add a missing retransmission timer scheduling

 net/mptcp/options.c  | 10 +++---
 net/mptcp/protocol.c | 55 +++++++++++++++++++----------
 net/mptcp/protocol.h | 18 ++++------
 net/mptcp/subflow.c  | 83 +++++++++++++++++++++++++++++++-------------
 4 files changed, 107 insertions(+), 59 deletions(-)


base-commit: 8a28af7a3e85ddf358f8c41e401a33002f7a9587
-- =

2.30.1

--===============0924418394659522871==--
