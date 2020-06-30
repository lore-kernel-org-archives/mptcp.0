Content-Type: multipart/mixed; boundary="===============6170958536152912970=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 0/2] mptcp: add receive buffer auto-tuning
Date: Tue, 30 Jun 2020 21:24:43 +0200
Message-ID: <20200630192445.18333-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 4873

--===============6170958536152912970==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

First patch extends the test script to allow for reproducible results.
Second patch adds receive auto-tuning.  Its based on what TCP is doing,
only difference is that we use the largest RTT of any of the subflows
and that we will update all subflows with the new value.

Else, we get spurious packet drops because the mptcp work queue might
not be able to move packets from subflow socket to master socket
fast enough.  Without the adjustment, TCP may drop the packets because
the subflow socket is over its rcvbuffer limit.

Florian Westphal (2):
      selftests: mptcp: add option to specify size of file to transfer
      mptcp: add receive buffer auto-tuning

 net/mptcp/protocol.c                               | 123 +++++++++++++++++=
++--
 net/mptcp/protocol.h                               |   7 ++
 net/mptcp/subflow.c                                |   5 +-
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |  52 ++++++---
 4 files changed, 166 insertions(+), 21 deletions(-)

--===============6170958536152912970==--
