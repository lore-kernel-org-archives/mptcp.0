Content-Type: multipart/mixed; boundary="===============3024236176102582381=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 0/3] mptcp: use whitlist for sockopt
Date: Fri, 05 Mar 2021 18:20:41 +0100
Message-ID: <cover.1614964777.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 8045

--===============3024236176102582381==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is the first non RFC istallment of the patch series trying
to addressing issues/170.

Changes from RFC v2:

- move sockopt related helper in a new file
- rebased on top of the above

Paolo Abeni (3):
  mptcp: move sockopt function into a new file
  mptcp: only admit explicitly supported sockopt
  mptcp: revert "mptcp: provide subflow aware release function"

 net/mptcp/Makefile   |   2 +-
 net/mptcp/protocol.c | 165 +-------------------
 net/mptcp/protocol.h |   5 +
 net/mptcp/sockopt.c  | 351 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 359 insertions(+), 164 deletions(-)
 create mode 100644 net/mptcp/sockopt.c

-- =

2.26.2

--===============3024236176102582381==--
