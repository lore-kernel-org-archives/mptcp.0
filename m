Content-Type: multipart/mixed; boundary="===============4290475869125304859=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/4] mptcp: token refactor follow-up
Date: Thu, 04 Jun 2020 19:40:02 +0200
Message-ID: <cover.1591291903.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4588

--===============4290475869125304859==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

First patch clean-up a bit the token container refactor
2nd adapt the tests cases, 3rd one fixes a long standing
bug which become apparent with token refactor and the =

last one helps debugging with kasan

patch 3 will target -net tree hopefully soon (adapted
to the current -net token apis). will need a little
rebasing of export branch after that.

@Christph: this series should replace any pending export branch fixes share=
d on
pastebin/mails/whatever (excluding the -net patch submitted little time ago)

Paolo Abeni (4):
  Squash-to: "mptcp: refactor token container."
  Squash-to: "mptcp: introduce token KUNIT self-tests"
  mptcp: don't leak msk in token container
  [DO-NOT-MERGE] mptcp: use kmalloc on kasan build

 net/ipv4/af_inet.c     |  3 +++
 net/mptcp/protocol.c   | 21 ++++++++++++-----
 net/mptcp/protocol.h   |  9 ++++++--
 net/mptcp/subflow.c    |  8 ++++---
 net/mptcp/token.c      | 51 ++++++++++++++++++++++--------------------
 net/mptcp/token_test.c | 11 ++++-----
 6 files changed, 64 insertions(+), 39 deletions(-)

-- =

2.21.3

--===============4290475869125304859==--
