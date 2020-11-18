Content-Type: multipart/mixed; boundary="===============8085721471195042404=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v4 0/7] mptcp: just another complete datapath refactor
Date: Wed, 18 Nov 2020 23:30:09 +0100
Message-ID: <cover.1605737932.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 6796

--===============8085721471195042404==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This iteration drops completely backlog usage, as per Mat suggestions.

The only updated patch WRT the previous iteration is the last one:
 7/7 mptcp: use mptcp backlog.

Only lighlty tested, but at least it does not explode badly on the first
self-test iteration :)

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
 net/mptcp/protocol.c   | 706 ++++++++++++++++++++++++++++++-----------
 net/mptcp/protocol.h   |  36 ++-
 net/mptcp/subflow.c    |  31 +-
 6 files changed, 596 insertions(+), 228 deletions(-)

-- =

2.26.2

--===============8085721471195042404==--
