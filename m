Content-Type: multipart/mixed; boundary="===============7517914807545645399=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 0/2] tcp: factor out a couple of helpers
Date: Fri, 16 Oct 2020 12:51:06 +0200
Message-ID: <cover.1602840570.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 6328

--===============7517914807545645399==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Upcoming improvement in MPTCP subflows management will require to keep write
data enqueued at the MPTCP level. As a side effect, such data could be sent
via orphaned TCP subflows after close().

To implement the above MPTCP needs to cope directly with memory allocation
failures in do_tcp_sendpages(). The solution proposed in patch 1/2 =

is to factor-out the relevant slice of do_tcp_sendpages().

Other possible alternatives could be:
- duplicating the relevant code inside MPTCP (will require exposing a few
  additional TCP helpers) =

or
- add an explicit check for orphaned socket in do_tcp_sendpages()

Additionally, due to the above, we will need to dispose of already orphaned
TCP subflows, avoiding racing with tcp_done(). We need to check the
subflow status and destroy it atomically. The solution proposed in patch 2/2
is to factor-out the unlocked body of tcp_close().

These changes are part of a quite larger MPTCP series, with all the other
patches touching only MPTCP code. To hopefully simplify the review, such
patches are not included here. Please advice if you prefer otherwise
- e.g. the whole series as RFC.

Paolo Abeni (2):
  tcp: factor out tcp_build_frag()
  tcp: factor out __tcp_close() helper

 include/net/tcp.h |   4 ++
 net/ipv4/tcp.c    | 128 +++++++++++++++++++++++++++-------------------
 2 files changed, 78 insertions(+), 54 deletions(-)

-- =

2.26.2

--===============7517914807545645399==--
