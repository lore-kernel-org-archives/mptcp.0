Content-Type: multipart/mixed; boundary="===============3097493011682254235=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 0/3] mptcp: just another recvmsg refactor
Date: Sun, 13 Oct 2019 18:28:43 +0200
Message-ID: <cover.1570834035.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 2100

--===============3097493011682254235==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This start constructing the instrucutre to support pulling data from =

multiple subflow. At the current stage uses a very simply approach, dropping
any out-of-order data and reading from any subflow with valid data.

The above should work quite nicely in active backup scenario and possibly
even with multiple subflows sending data concurrently - with a low bwidth a=
nd
a huge number of retransmissions.

This is a not_so_early draft, shared as it may pave some ground and/or
partially overlap with DATA_FIN support effort

Note that this rewrite completely the recvmsg() main loop to mirror more cl=
osely
the TCP recvmsg() main loop, likely fixing some bug in respect to signal and
error condition handling.

Paolo Abeni (3):
  mptcp: move some helper into the header file
  mptcp: flush duplicate data at data_ready() time
  mptcp: recvmsg() can drain data from multiple subflows

 net/mptcp/protocol.c | 360 +++++++++++++------------------------------
 net/mptcp/protocol.h |  31 +++-
 net/mptcp/subflow.c  | 270 +++++++++++++++++++++++++++++++-
 3 files changed, 403 insertions(+), 258 deletions(-)

-- =

2.21.0

--===============3097493011682254235==--
