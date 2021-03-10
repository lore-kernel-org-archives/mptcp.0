Content-Type: multipart/mixed; boundary="===============6246517460607428277=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][RFC PATCH 0/2] DSS checksum and MP_FAIL support
Date: Wed, 10 Mar 2021 20:39:32 +0800
Message-ID: <cover.1615378283.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 8088

--===============6246517460607428277==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is the first RFC version of adding DSS checksum and MP_FAIL support,
addressed issue #134 and #52. It's not finish yet. Patch 1 had a bug in
it. The self test script mptcp_join.sh could pass, but mptcp_connect.sh
will fail sometimes. Patch 2 didn't implement the logic of receiving the
MP_FAIL, where I marked it with a TODO label.
 =

I need some suggestions to improve this patchset.

Thanks.

Geliang Tang (2):
  mptcp: DSS checksum support
  mptcp: add MP_FAIL support

 include/net/mptcp.h  |   2 +
 net/mptcp/options.c  | 122 +++++++++++++++++++++++++++++++++++++++----
 net/mptcp/protocol.h |  13 +++++
 net/mptcp/subflow.c  |  42 ++++++++++++++-
 4 files changed, 169 insertions(+), 10 deletions(-)

-- =

2.29.2

--===============6246517460607428277==--
