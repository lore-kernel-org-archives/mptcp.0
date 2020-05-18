Content-Type: multipart/mixed; boundary="===============3380231952369941862=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH RFC net-next 0/2] improve MPTCP fallback
Date: Mon, 18 May 2020 18:37:26 +0200
Message-ID: <cover.1589819601.git.dcaratti@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4408

--===============3380231952369941862==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

- patch 1 refactors fallback code to allow infinite mapping
- patch 2 fixes a race between recvmsg() and shutdown(), it was there
  since earlier implementations but it became almost systematic =

  in case of fallback, after patch 1 was applied


Davide Caratti (1):
  net: mptcp: improve fallback to TCP

Paolo Abeni (1):
  mptcp: fix races between shutdown and recvmsg.

 net/mptcp/options.c  |   9 +++-
 net/mptcp/protocol.c | 125 ++++++++++++++++---------------------------
 net/mptcp/protocol.h |  14 +++++
 net/mptcp/subflow.c  |  63 +++++++++++++++-------
 4 files changed, 112 insertions(+), 99 deletions(-)

-- =

2.26.2

--===============3380231952369941862==--
