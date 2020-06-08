Content-Type: multipart/mixed; boundary="===============3884592716740319590=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 0/3] mptcp: more token follow-up
Date: Mon, 08 Jun 2020 23:51:29 +0200
Message-ID: <cover.1591652866.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4621

--===============3884592716740319590==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The patch 1 addesses a race on close which may possibly fix
issues/36 && issues/29, the 2nd patch is resolve conflicts and the 3rd one
is a follow-up cleanup.

Patch 3 should be inserted just after "mptcp: refactor token container."

v1 -> v2:
 - hopefully includes the correct patches

 protocol.c |    9 ++++---
 subflow.c  |   69 ++++++++++++++++++++++----------------------------------=
-----
 2 files changed, 30 insertions(+), 48 deletions(-)

--===============3884592716740319590==--
