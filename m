Content-Type: multipart/mixed; boundary="===============6839057324481669816=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 0/2] mptcp: cope better with tcp_sendpage
 allocation
Date: Tue, 06 Oct 2020 13:18:05 +0200
Message-ID: <cover.1601982978.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 6211

--===============6839057324481669816==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The current export branch suffers of the following issue:

https://github.com/multipath-tcp/mptcp_net-next/issues/97

To fix the above, MPTCP needs to be able to cope with memory allocation
failure in do_tcp_sendpages().

In this attempt, the relevant code is factored out of do_tcp_sendpages(),
in a smaller helper, so that mptcp_sendmsg_frag() can avoid touching
ssk->sk_socket.

There are other possible alternatives:
- add an explicit check in do_tcp_sendpages() for NULL sk->sk_socket
  pro: very simple and little invasive
  cons: hackysh?!?
- inline/open-code the relevant part of do_tcp_sendpages in mptcp_sendmsg_f=
rag()
  pro: no need to change core TCP code
  cons: code duplication, need to change the scope for a couple of TCP inte=
rnal
        helpers (removing the 'static' keyword)

As a follow-up I would try to pre-allocate skbs and extensions, so that
push_pending could be called in BH context and we could avoid using the =

work queue.

I'm looking for feedback on the less ugly/more upstreamable approach =


Paolo Abeni (2):
  tcp: factor out do_tcp_sendfrag()
  mptcp: use do_tcp_sendfrag()

 include/net/tcp.h    |   3 ++
 net/ipv4/tcp.c       | 120 ++++++++++++++++++++++++-------------------
 net/mptcp/protocol.c |  21 ++++----
 3 files changed, 80 insertions(+), 64 deletions(-)

-- =

2.26.2

--===============6839057324481669816==--
