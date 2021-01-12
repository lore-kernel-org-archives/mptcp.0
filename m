Content-Type: multipart/mixed; boundary="===============7661841861207638005=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net 0/2] mptcp: a couple of fixes
Date: Tue, 12 Jan 2021 18:25:22 +0100
Message-ID: <cover.1610471474.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 7328

--===============7661841861207638005==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series includes two related fixes addressing potential divide by 0
bugs in the MPTCP datapath.

Paolo Abeni (2):
  mptcp: more strict state checking for acks
  mptcp: better msk-level shutdown.

 net/mptcp/protocol.c | 64 +++++++++++++-------------------------------
 1 file changed, 18 insertions(+), 46 deletions(-)

-- =

2.26.2

--===============7661841861207638005==--
