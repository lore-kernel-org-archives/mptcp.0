Content-Type: multipart/mixed; boundary="===============4124609529915643933=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v3 00/10] Implement outgoing MP_JOIN
Date: Wed, 07 Aug 2019 15:44:24 -0700
Message-ID: <20190807224434.2829-1-peter.krystad@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 1594

--===============4124609529915643933==
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

v2:
  - move mptcp_options_received formatting to options.c
  - resolve conflicts with Davide's crypto commit
  - make helper for setting request fields
  - fix locking in token_lookup()
  - move token_lookup() to "Implement path manager interface commands:
    (where it belongs)
  - split interim path manager out of final commit, will submit seperately
  - remove use of local_id in pm_create_subflow
  - restrict announcing addresses to server side only
  - add one more commit with get_local_id fix for incoming MP_JOIN

v3:
  - Revise nested if logic in options.c
  - set subflow->request_cksum correctly (do not support)
  - lock mptcp_sock in subflow_connect() and take ref
  - return EINPROGRESS from subflow_connect() in normal case
  - cleanup socket when bind()/connect() fails in subflow_connect()
  - take reference to mptcp_sock in token_join_request() and
    token_join_valid()
  - rename token_lookup() to token_lookup_get()
  - track remote token seperately in subflow (previously
    local token field was being overwritten, preventing cleanup)
  - take long-lived reference to mptcp_sock in token_new_subflow

Peter Krystad (10):
  Extend path manager interface
  Fix locking in mptcp_finish_join.
  Fix parsing MP_JOIN third ACK.
  Re-factor and fixes for crypto_hmac_sha1()
  Rename mptcp_attach_dss()
  Fix return value if no DSS option is created.
  Move setting request_ fields of subflow to MPTCP layer helper
  mptcp: Add handling of outgoing MP_JOIN requests
  Use pm_get_local_id() to get the real local address id.
  mptcp: Implement path manager interface commands

 include/net/mptcp.h  |  12 ++--
 net/ipv4/tcp_input.c |   4 +-
 net/mptcp/crypto.c   |  23 +++----
 net/mptcp/options.c  |  98 +++++++++++++++++++++++++++---
 net/mptcp/pm.c       | 140 +++++++++++++++++++++++++++++++++++++++----
 net/mptcp/protocol.c |  21 +++++--
 net/mptcp/protocol.h |  58 ++++++++++++++----
 net/mptcp/subflow.c  |  77 +++++++++++++++++++++---
 net/mptcp/token.c    | 111 +++++++++++++++++++++++++++-------
 9 files changed, 455 insertions(+), 89 deletions(-)

-- =

2.17.2


--===============4124609529915643933==--
