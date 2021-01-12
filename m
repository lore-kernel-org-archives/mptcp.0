Content-Type: multipart/mixed; boundary="===============1600953658545956121=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 0/2] mptcp: delegate actions
Date: Tue, 12 Jan 2021 19:24:30 +0100
Message-ID: <cover.1610474482.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 7331

--===============1600953658545956121==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is a somewhat less untested iteration.
There are a few changes in patch 1, including dummy netdev usage
instead of loopback, deferred -> delegated name change, and a few
bugfixes.

Paolo Abeni (2):
  mptcp: implement delegated action infrastructure
  mptcp: leverage the deferred actions for packet scheduling

 net/mptcp/protocol.c | 83 +++++++++++++++++++++++++++++++++++++++++---
 net/mptcp/protocol.h | 52 +++++++++++++++++++++++++++
 net/mptcp/subflow.c  | 39 +++++++++++++++++++++
 3 files changed, 170 insertions(+), 4 deletions(-)

-- =

2.26.2

--===============1600953658545956121==--
