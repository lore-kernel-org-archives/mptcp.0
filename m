Content-Type: multipart/mixed; boundary="===============2378782675401890762=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/9] Implement outgoing MP_JOIN
Date: Wed, 17 Jul 2019 15:12:47 -0700
Message-ID: <20190717221256.7358-1-peter.krystad@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 1511

--===============2378782675401890762==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is several accumulated fixes that are required for MP_JOIN
(secondary subflows) plus the outgoing code.

Both outgoing and incoming MP_JOIN now inter-operate
with the multipath.org implementation although there is
still a deadlock when incoming is fully established.
Since the incoming direction did not work at all before
this is an improvement. I have not yet tested running our
implmentation against itself.

The final patch in the set is an "interim path manager", this
is throw-away code that I include for testing purposes. For an
incoming connection it is necessary for the server to advertise
a secondary address and for my testing I have been hard-coding the IP
address of my secondary interface when I build the kernel.
Obviously not the final solution but we need to discuss what
approach to use for the self tests. I also think we may not want
to publish this patch on our net-next branch.

Peter Krystad (9):
  Extend path manager interface
  Fix locking in mptcp_finish_join.
  Fix parsing MP_JOIN third ACK.
  Re-factor and fixes for crypto_hmac_sha1()
  Rename mptcp_attach_dss()
  Fix return value if no DSS option is created.
  Move setting request_ fields of subflow to MPTCP layer
  mptcp: Add handling of outgoing MP_JOIN requests
  mptcp: Implement interim path manager

 include/net/mptcp.h  |  12 +--
 net/ipv4/tcp_input.c |   4 +-
 net/mptcp/crypto.c   |  23 +++---
 net/mptcp/options.c  |  77 ++++++++++++++++---
 net/mptcp/pm.c       | 171 +++++++++++++++++++++++++++++++++++++++++--
 net/mptcp/protocol.c |  29 ++++++--
 net/mptcp/protocol.h |  54 +++++++++++---
 net/mptcp/subflow.c  |  72 ++++++++++++++++--
 net/mptcp/token.c    |  82 ++++++++++++++++++---
 9 files changed, 452 insertions(+), 72 deletions(-)

-- =

2.17.2


--===============2378782675401890762==--
