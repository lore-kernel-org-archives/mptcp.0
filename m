Content-Type: multipart/mixed; boundary="===============9083217159242017957=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 0/2] The current export branch suffers of the
 following issue:
Date: Wed, 14 Oct 2020 19:15:14 +0200
Message-ID: <cover.1602693911.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 6304

--===============9083217159242017957==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

https://github.com/multipath-tcp/mptcp_net-next/issues/97

To fix the above, MPTCP needs to be able to cope with memory allocation
failure in do_tcp_sendpages().

In this iteration the patches are rebased on top of:

"bpf:selftests: add bpf_mptcp_sock() verifier tests"

and should apply without fuzz on net-next.

patch 1/2 went through some lifting to be hopefully more acceptable
upstream.

This will cause a few conflicts in later patch, specifically in
"mptcp: move page frag allocation in mptcp_sendmsg()". Possibly the
simpler/better would be squashing 2/2 in there.

The plan is to send 1/2 and "tcp: factor out __tcp_close() helper"
as RFC upstream soon/while net-next is closed to try to understand
if that could be acceptable. The 2 TCP patches alone, without the full
series to hopefully make the review simpler/less cumbersome.

Any feedback more than welcome!!!

Paolo Abeni (2):
  tcp: factor out tcp_build_frag()
  mptcp: use tcp_build_frag()

 include/net/tcp.h    |   3 ++
 net/ipv4/tcp.c       | 119 ++++++++++++++++++++++++-------------------
 net/mptcp/protocol.c |  25 +++------
 3 files changed, 78 insertions(+), 69 deletions(-)

-- =

2.26.2

--===============9083217159242017957==--
