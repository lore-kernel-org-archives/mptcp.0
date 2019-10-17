Content-Type: multipart/mixed; boundary="===============0862615531655934744=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC 0/2] IPv6 support
Date: Wed, 16 Oct 2019 17:02:04 -0700
Message-ID: <20191017000206.10559-1-peter.krystad@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 2195

--===============0862615531655934744==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Sharing IPv6 work so far. Simple test shows connection establishment
and data transfer works for a single subflow over link-local IPv6
between two VMs.

Still to do:
- Add selftests.
- Multiple subflows. ADD_ADDR option does not fit in TCP header with DSS,
need to send independent ACK to carry it.
- Possibly split IPv4 and IPv6-specific portions into separate files, or
at least reduce some of the excessive copy-paste in this version.
- Is special handling needed for IPv4-mapped addresses.

Peter Krystad (2):
  mptcp: Export low-level routines for IPv6
  mptcp: Add IPv6 support

 include/net/mptcp.h  |   3 +
 include/net/tcp.h    |   8 ++
 net/ipv6/tcp_ipv6.c  |  29 ++++--
 net/mptcp/ctrl.c     |  11 +++
 net/mptcp/protocol.c | 152 ++++++++++++++++++++++++++---
 net/mptcp/protocol.h |   9 +-
 net/mptcp/subflow.c  | 225 +++++++++++++++++++++++++++++++++++++------
 7 files changed, 388 insertions(+), 49 deletions(-)

-- =

2.17.2

--===============0862615531655934744==--
