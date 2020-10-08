Content-Type: multipart/mixed; boundary="===============0189159985109171077=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net 0/2] mptcp: mp join fallback fixes.
Date: Thu, 08 Oct 2020 22:34:57 +0200
Message-ID: <cover.1602189151.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 6252

--===============0189159985109171077==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This solves issues/91 for me at least. Targeting upstream -net.
As such, patches based on the "bottom" of current export branch,
so that should apply cleanly on current -net.

Note that rebasing on top of patch 2 "mptcp: refactor shutdown and close",
we must change the value of the macro MPTCP_WORKER_RUNNING (5 -> 6)

The problem fixed by patch 2/2 already exist in the curren export/net =

branches - is quite rare, but is more visible after patch 1/2.

This iteration addresses the comment from Mat on patch 2/2

Paolo Abeni (2):
  mptcp: fix fallback for MP_JOIN subflows
  mptcp: subflows garbage collection

 net/mptcp/options.c  | 32 +++++++++++++++++++++++++-------
 net/mptcp/protocol.c | 18 ++++++++++++++++++
 net/mptcp/protocol.h |  2 ++
 net/mptcp/subflow.c  | 16 ++++++++++++++--
 4 files changed, 59 insertions(+), 9 deletions(-)

-- =

2.26.2

--===============0189159985109171077==--
