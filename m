Content-Type: multipart/mixed; boundary="===============5035340476875077998=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-net 0/5] mptcp: mix fixes
Date: Fri, 05 Feb 2021 17:55:09 +0100
Message-ID: <cover.1612543972.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 7650

--===============5035340476875077998==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This includes new versions of 2 already posted patches (1/5 && 2/5)
a rewrite of an already posted RFC patch (3/5) and a new fix.

Patch 1 should address issues/126
Patch 2 should address issues/130 && 125
Patch 3 is mostly a clean-up, possibly could land to net-next
Patch 4 should fix issue 146
Finally patch 5 allow mptcp_connect to dump more info when errors happen

Paolo Abeni (5):
  mptcp: fix spurious retransmissions
  mptcp: init mptcp request socket earlier
  mptcp: better msk receive window updates
  mptcp: add a missing retransmission timer scheduling
  selftests: mptcp: dump more info on errors

 net/mptcp/options.c                           | 10 ++---
 net/mptcp/protocol.c                          | 44 +++++++++++--------
 net/mptcp/protocol.h                          | 14 ++----
 net/mptcp/subflow.c                           | 40 +++++++----------
 .../selftests/net/mptcp/mptcp_connect.sh      | 11 +++--
 5 files changed, 58 insertions(+), 61 deletions(-)

-- =

2.26.2

--===============5035340476875077998==--
