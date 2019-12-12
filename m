Content-Type: multipart/mixed; boundary="===============1140375111623701672=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/2] Optimize struct mptcp_options_received
Date: Wed, 11 Dec 2019 21:08:18 -0800
Message-ID: <20191212050820.29792-1-peter.krystad@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 2882

--===============1140375111623701672==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Changes for part 1 commits. Conflicts are straightforward
when squashed.

Peter Krystad (2):
  mptcp: Move struct mptcp_options_received
  mptcp: Remove version field from mptcp_options_received

 include/linux/tcp.h  | 19 +++++++++++--------
 net/mptcp/options.c  |  7 ++++---
 net/mptcp/protocol.h |  2 ++
 3 files changed, 17 insertions(+), 11 deletions(-)

-- =

2.17.2

--===============1140375111623701672==--
