Content-Type: multipart/mixed; boundary="===============5795639958246805097=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/3] mptcp: just another recvmsg refactor
Date: Tue, 15 Oct 2019 17:44:41 +0200
Message-ID: <cover.1571152990.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 2152

--===============5795639958246805097==
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

Note that this rewrite completely the recvmsg() main loop to mirror more cl=
osely
the TCP recvmsg() main loop, likely fixing some bug in respect to signal and
error condition handling.

I think this 3 patches should be squashed into
"mptcp: Implement MPTCP receive path", but the resulting one will be likely
too huge; possibly splitting the resulting code in 2 different patches would
be nicer. Additionally "mptcp: Implement MPTCP receive path" has some chunks
that should be likely moved to some other patches (e.g. ULP RCU fixes).

What if - after the eventuall accept - I publish the resulting code of the =

above squashing somewhere?


RFC -> v1
 - address Mat's comment on patch 2/3, see individual changelog for the det=
ails

Paolo Abeni (3):
  mptcp: move some helper into the header file
  mptcp: flush duplicate data at data_ready() time
  mptcp: recvmsg() can drain data from multiple subflows

 net/mptcp/protocol.c | 360 +++++++++++++------------------------------
 net/mptcp/protocol.h |  31 +++-
 net/mptcp/subflow.c  | 289 +++++++++++++++++++++++++++++++++-
 3 files changed, 422 insertions(+), 258 deletions(-)

-- =

2.21.0

--===============5795639958246805097==--
