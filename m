Content-Type: multipart/mixed; boundary="===============1969139628674297683=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 0/5] mptcp: fallback socket cleanup
Date: Fri, 06 Dec 2019 13:22:42 +0100
Message-ID: <cover.1575634848.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 2811

--===============1969139628674297683==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is a quite early RFC to acquire as early feedback as possible.
I did self-tests a few times on 3/5 and on patch 5/5 without failure, but
likely some bugs are still present.

The first 3 patches in this series:
- clarify and cleanup the TCP fallback handling
- fixes setsockopt()/getsockopt() for connected/unbound sockets

The last 2 patches do more aggressive/invasive cleanup:
- drop the 'fallback' field so that we always use the conn_list
- drop the nested socket in mptcp_finish_connect()
- remove the lock/lookup/get/unlock dance in most case (due the the above)

After all the above, performance for connection fallen back to plain TCP sh=
ould
be almost the same of TCP connection on unpacked kernel.

Addittionally 'nc' and 'netperf' now run successfully when forced to MPTCP.
The latter still report a non fatal error at connection closing time as it
performs:

getsockopt(4, SOL_TCP, TCP_MAXSEG, //...);
getsockopt(4, SOL_TCP, TCP_INFO, //...);

which is still unsupported after that the mp capable handshake is started.

For the records on the debug build I'm using netperf scores better result
with MPTCP that with plain TCP ;) [agreed, completely irrelevant, still nic=
e]

The series applies at selftests and is unsquashed - will require quite a bit
of work there and more work to rebase/adjust the patches after kselftest.
I'll start that after the pending patches are in.

_Any_ feedback _very_ welcome!

Paolo Abeni (5):
  mptcp: clear 'is_tcp' socket flag when the MP_CAPABLE handshake fails
  mptcp: pass subflow to mptcp_finish_connect()
  mptcp: cleanup fallback handling
  mptcp: remove 'fallback' field
  mptcp: avoid acquiring the msk lock in mptcp_finisch_connect()

 net/mptcp/options.c  |   3 +
 net/mptcp/protocol.c | 342 +++++++++++++++++++++++--------------------
 net/mptcp/protocol.h |   4 +-
 net/mptcp/subflow.c  |   4 +-
 4 files changed, 189 insertions(+), 164 deletions(-)

-- =

2.21.0

--===============1969139628674297683==--
