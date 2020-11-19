Content-Type: multipart/mixed; boundary="===============8052793407409390672=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v5 0/6] mptcp: just another complete datapath refactor
Date: Thu, 19 Nov 2020 13:38:20 +0100
Message-ID: <cover.1605789317.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 6828

--===============8052793407409390672==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This iteration introduces some improvement for the wake-up/poll code
as discussed on the ML.

The last 2 patches in the previous iterations has been merged in a single
one, with all the relevant deltas noted there.

Looking for merge now ;)

Paolo Abeni (6):
  mptcp: open code mptcp variant for lock_sock
  mptcp: implement wmem reservation.
  mptcp: protect the rx path with the msk socket spinlock
  mptcp: allocate TX skbs in msk context.
  mptcp: avoid a few atomic ops in the rx path
  mptcp: use mptcp release_cb for delayed tasks.

 net/core/sock.c        |   2 +-
 net/mptcp/mptcp_diag.c |   2 +-
 net/mptcp/options.c    |  47 +--
 net/mptcp/protocol.c   | 734 ++++++++++++++++++++++++++++++-----------
 net/mptcp/protocol.h   |  36 +-
 net/mptcp/subflow.c    |  14 +-
 6 files changed, 600 insertions(+), 235 deletions(-)

-- =

2.26.2

--===============8052793407409390672==--
