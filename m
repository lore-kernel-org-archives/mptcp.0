Content-Type: multipart/mixed; boundary="===============1875734296218305275=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/8] Add IPv6 Support 
Date: Tue, 12 Nov 2019 22:45:10 -0800
Message-ID: <20191113064518.4823-1-peter.krystad@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 2489

--===============1875734296218305275==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patchset is a replacement for the single "Add IPv6 Support"
commit, with the chunks broken into seperate squash-able commits.

Peter Krystad (8):
  mptcp: Add IPv6 support for MPTCP socket stubs
  mptcp: Add IPv6 support for Associate MPTCP context
  mptcp: Add IPV6 support for outgoing connections
  mptcp: Add IPv6 support for mptcp_poll
  mptcp: Add IPV6 support for incoming connections
  mptcp: Add IPv6 support for key generation
  mptcp: Add IPv6 support for shutdown()
  mptcp: Add IPv6 support for new sysctl initialization

 include/net/mptcp.h  | 10 +++++++
 net/ipv6/tcp_ipv6.c  |  7 +++++
 net/mptcp/ctrl.c     | 11 ++++++++
 net/mptcp/protocol.c | 62 +++++++++++++++++++++++++++++++++++++++++---
 net/mptcp/protocol.h |  6 +++++
 net/mptcp/subflow.c  | 61 +++++++++++++++++++++++++++++++++++++++++--
 6 files changed, 151 insertions(+), 6 deletions(-)

-- =

2.17.2

--===============1875734296218305275==--
