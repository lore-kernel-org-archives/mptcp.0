Content-Type: multipart/mixed; boundary="===============0935775738242176284=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v3 0/7] mptcp: just another complete datapath refactor
Date: Wed, 18 Nov 2020 19:04:39 +0100
Message-ID: <cover.1605718134.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 6785

--===============0935775738242176284==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This iteration includes many optimizations using the msk
socket lock to reduce the number of mptcp_data_lock contentions.

It additionally cleans a bit the mptcp_lock_sock() macro definitions
and fix a few checkpatches issues.

Still using the backlog, as per ML discussion

Paolo Abeni (7):
  mptcp: open code mptcp variant for lock_sock
  mptcp: implement wmem reservation.
  mptcp: protect the rx path with the msk socket spinlock
  mptcp: allocate TX skbs in msk context.
  mptcp: avoid a few atomic ops in the rx path
  mptcp: simplify mptcp_nospace
  mptcp: use mptcp backlog.

 net/core/sock.c        |   2 +-
 net/mptcp/mptcp_diag.c |   2 +-
 net/mptcp/options.c    |  47 +--
 net/mptcp/protocol.c   | 721 ++++++++++++++++++++++++++++++-----------
 net/mptcp/protocol.h   |  39 ++-
 net/mptcp/subflow.c    |  31 +-
 6 files changed, 613 insertions(+), 229 deletions(-)

-- =

2.26.2

--===============0935775738242176284==--
