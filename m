Content-Type: multipart/mixed; boundary="===============7973414429122688133=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH RFC v3 00/10] mptcp: add syn cookie support
Date: Thu, 30 Jul 2020 02:12:31 +0200
Message-ID: <20200730001241.3037-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 5372

--===============7973414429122688133==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

TL;DR: patch #8 implements Paolos suggestion, a state table to keep
MP_JOIN data to reconstruct the request socket for join requests.

----

At this time, when syn-cookies are used and the SYN had an
MPTCP-option, the cookie is sent with MPTCP option cleared,
as the code path that creates a request socket based off a valid ACK
token lacks the needed changes to construct MPTCP request sockets.

After this series, if SYN carries an MPTCP option, the MPTCP option is
not cleared anymore and reconstruction will be done using the MPTCP option
that is re-sent with the ACK:

no additional state gets encoded into the syn cookie or the timestamp.

There are several differences from the normal (syn queue) case with
MPTCP.

I. When syn-cookies are used, the server-generated key is not stored,
   it is best-effort only: Storing state would defeat the purpose of
   cookies.

The drawback is that the next connection request that comes in before
the cookie-ACK has a small chance that it will generate the same
local_key.

If this happens, the cookie ACK that comes in "second" (which contains
the local and remote key in mptcp options) will compute the token hash
and then detects that this is already in use.

When this happens, late TCP fallback occurs, i.e. the connection sock
is not marked as mptcp capable.

II). SYN packets containing a MP_JOIN requests cannot be handled without
     storing state.  This is because the SYN contains a nonce value that
     we need to store to validate the HMAC of the MP_JOIN ACK that
     completes 3whs.

There are only 2 ways to solve this:
 a). Do not support JOINs when cookies are in effect.
 b). Store the nonce somewhere.

The approach chosen here is b).  Patch #8 adds a small state table (1024
slots) to store the MP_JOIN syn mptcp option data.

This takes a total of 16kbyte of statically allocated memory

State storage is subject to following constraints:
1. The token in the JOIN request is valid (i.e. there is an
   established MPTCP connection).
2. The MPTCP connection can still accept a new subflow.

Unless there are objects I will drop RFC tag and pass this to
net-next.

 drivers/crypto/chelsio/chtls/chtls_cm.c            |    1 =

 include/net/mptcp.h                                |   11 +
 include/net/request_sock.h                         |    3 =

 include/net/tcp.h                                  |    5 =

 net/ipv4/syncookies.c                              |   44 ++++++-
 net/ipv4/tcp_input.c                               |    7 -
 net/ipv4/tcp_ipv4.c                                |    3 =

 net/ipv4/tcp_output.c                              |    2 =

 net/ipv6/syncookies.c                              |    5 =

 net/ipv6/tcp_ipv6.c                                |    3 =

 net/mptcp/Makefile                                 |    1 =

 net/mptcp/protocol.h                               |   19 +++
 net/mptcp/subflow.c                                |  131 ++++++++++++++++=
+----
 net/mptcp/syncookies.c                             |  118 ++++++++++++++++=
++
 net/mptcp/token.c                                  |   38 ++++--
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |   47 +++++++
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |   66 ++++++++++
 17 files changed, 450 insertions(+), 54 deletions(-)

Florian Westphal (10):
      tcp: remove cookie_ts bit from request_sock
      mptcp: token: move retry to caller
      mptcp: subflow: split subflow_init_req
      mptcp: rename and export mptcp_subflow_request_sock_ops
      tcp: pass want_cookie down to req_init function
      mptcp: subflow: add mptcp_subflow_init_cookie_req helper
      tcp: syncookies: create mptcp request socket for ACK cookies with MPT=
CP option
      mptcp: enable JOIN requests even if cookies are in use
      selftests: mptcp: make 2nd net namespace use tcp syn cookies uncondit=
ionally
      selftests: mptcp: add test cases for mptcp join tests with syn cookies

--===============7973414429122688133==--
