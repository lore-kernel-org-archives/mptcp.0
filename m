Content-Type: multipart/mixed; boundary="===============5939719631694332707=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net 0/4] mptcp: a bunch of assorted fixes
Date: Wed, 16 Dec 2020 12:48:31 +0100
Message-ID: <cover.1608114076.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 7188

--===============5939719631694332707==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series pulls a few fixes for the MPTCP datapath.
Most issues addressed here has been recently introduced
with the recent reworks, with the notable exception of
the first patch, which addresses an issue present since
the early days

Paolo Abeni (4):
  mptcp: fix security context on server socket
  mptcp: properly annotate nested lock
  mptcp: push pending frames when subflow has free space
  mptcp: fix pending data accounting

 net/mptcp/options.c                               | 13 ++++++++-----
 net/mptcp/protocol.c                              | 11 ++++++-----
 net/mptcp/protocol.h                              |  2 +-
 tools/testing/selftests/net/mptcp/simult_flows.sh |  6 +++---
 4 files changed, 18 insertions(+), 14 deletions(-)

-- =

2.26.2

--===============5939719631694332707==--
