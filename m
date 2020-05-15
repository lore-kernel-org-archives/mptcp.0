Content-Type: multipart/mixed; boundary="===============4540946946720702251=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v2 0/3] mptcp: fix MP_JOIN failure handling
Date: Fri, 15 May 2020 19:22:14 +0200
Message-ID: <cover.1589558049.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4393

--===============4540946946720702251==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently if we hit an MP_JOIN failure on the third ack, the child socket is
closed with reset, but the request socket is not deleted, causing weird
behaviors.

The main problem is that MPTCP's MP_JOIN code needs to plug it's own
'valid 3rd ack' checks and the current TCP callbacks do not allow that.

This series tries to address the above shortcoming introducing a new MPTCP
specific bit in a 'struct tcp_request_sock' hole, and leveraging that to al=
low
tcp_check_req releasing the request socket when needed.

The above allows cleaning-up a bit current MPTCP hooking in tcp_check_req().

An alternative solution, possibly cleaner but more invasive, would be
changing the 'bool *own_req' syn_recv_sock() argument into 'int *req_status'
and let MPTCP set it to 'REQ_DROP'.

v1 -> v2:
 - be more conservative about drop_req initialization

RFC -> v1:
 - move the drop_req bit inside tcp_request_sock (Eric)

Paolo Abeni (3):
  mptcp: add new sock flag to deal with join subflows
  inet_connection_sock: factor out destroy helper.
  mptcp: cope better with MP_JOIN failure

 include/linux/tcp.h                |  3 +++
 include/net/inet_connection_sock.h |  8 ++++++++
 include/net/mptcp.h                | 17 ++++++++++-------
 net/ipv4/inet_connection_sock.c    |  6 +-----
 net/ipv4/tcp_minisocks.c           |  2 +-
 net/mptcp/protocol.c               |  7 -------
 net/mptcp/subflow.c                | 18 ++++++++++++------
 7 files changed, 35 insertions(+), 26 deletions(-)

-- =

2.21.3

--===============4540946946720702251==--
