Content-Type: multipart/mixed; boundary="===============7633278896649567233=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net 0/4] mptcp: a bunch of fixes
Date: Fri, 19 Feb 2021 18:35:36 +0100
Message-ID: <cover.1613755058.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 7862

--===============7633278896649567233==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series bundle a few MPTCP fixes for the current net tree.
They have been detected via syzkaller and packetdrill

Patch 1 fixes a slow close for orphaned sockets

Patch 2 fixes another hangup at close time, when no
data was actually transmitted before close

Patch 3 fixes a memory leak with unusual sockopts

Patch 4 fixes stray wake-ups on listener sockets

Florian Westphal (1):
  mptcp: provide subflow aware release function

Paolo Abeni (3):
  mptcp: fix DATA_FIN processing for orphaned sockets
  mptcp: fix DATA_FIN generation on early shutdown
  mptcp: do not wakeup listener for MPJ subflows

 net/mptcp/options.c  | 23 +++++++++-------
 net/mptcp/protocol.c | 64 +++++++++++++++++++++++++++++++++++++++-----
 net/mptcp/subflow.c  |  6 +++++
 3 files changed, 77 insertions(+), 16 deletions(-)

-- =

2.26.2

--===============7633278896649567233==--
