Content-Type: multipart/mixed; boundary="===============7095845214533003570=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/5] IPv6 prerequisite patches
Date: Tue, 15 Oct 2019 16:06:08 -0700
Message-ID: <20191015230613.16981-1-peter.krystad@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 2157

--===============7095845214533003570==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

IPv6 changes to the path manager and option handling. May all
be squashed as specified in each patch.

Peter Krystad (5):
  mptcp: Update path manager interface for IPv6
  mptcp: Add missing ADD_ADDR handling
  mptcp: Make mptcp_subflow_connect() IPv4/6 agnostic
  mptcp: Update path manager interface commands for IPv6
  mptcp: Update basic path manager for IPv6

 net/mptcp/basic.c    |  40 ++++++++++------
 net/mptcp/options.c  |  24 ++++++----
 net/mptcp/pm.c       | 106 ++++++++++++++++++++++++++++++++++++-------
 net/mptcp/protocol.h |  15 +++---
 net/mptcp/subflow.c  |  16 ++++---
 5 files changed, 150 insertions(+), 51 deletions(-)

-- =

2.17.2

--===============7095845214533003570==--
