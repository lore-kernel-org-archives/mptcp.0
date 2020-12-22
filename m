Content-Type: multipart/mixed; boundary="===============5731927642613355977=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [mptcp-net 0/2] mptcp: fix for issue/121
Date: Tue, 22 Dec 2020 10:26:49 +0100
Message-ID: <cover.1608628900.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 7237

--===============5731927642613355977==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The mentioned issues is fixed by any of this 2 patches.

The first one is a minimal fix that could land to stable,
the second one addresses the an underlaying state-management
bug, which needs some more complex changes.

The plan is to send them both to -net.

Paolo Abeni (2):
  mptcp: more strict state checking for acks
  mptcp: better msk-level shutdown.

 net/mptcp/protocol.c | 64 +++++++++++++-------------------------------
 1 file changed, 18 insertions(+), 46 deletions(-)

-- =

2.26.2

--===============5731927642613355977==--
