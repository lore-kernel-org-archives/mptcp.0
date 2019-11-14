Content-Type: multipart/mixed; boundary="===============4570054396475310189=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC] mptcp: wmem accounting and nonblocking io support
Date: Thu, 14 Nov 2019 18:32:11 +0100
Message-ID: <20191114173225.21199-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 2528

--===============4570054396475310189==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This (large, sigh) series fixes poll handling in mptcp.

The first patch extends the test suite with a mmap-based mode to
check large, blocking writes.  This uncovered a minor problem with the
earlier v2 wmem accounting patch series -- we would happily take a lot
more data than sndbuf allowed, as we only limited based on what the subflow
could accept.  So with a 4k sndbuf we could easily accept 256kb or even mor=
e.

This patch doesn't change anything in the test suite behaviour however,
you need to use "-b 4096" and/or "-m mmap" to enable this mode.

Second patch changes test suite to move to nonblocking io, this breaks mptcp
because mptcp_poll can signal EPOLLIN when it shouldn't, so userspace gets
-EAGAIN even though poll told it otherwise.

Patches 3/4/5/6 are an update vs. last wmem accounting series.
Remaining patches fix the nonblocking io behaviour.

mptcp_poll is made to be stand-alone, i.e. it no longer calls
__tcp_poll on the subflow sockets and only considers mptcp_sk state.

After this series the selftest works again and mptcp sk rtx queue is
limited by msk wmem.

The patches can't easily be rebased/merged so I propose that I would
squash this myself and send a pull request when done.

The following changes since commit d1dbb32dc58df543e89f4004c1a0b96fe8acf99b:

  subflow: wake parent mptcp socket on subflow state change (2019-11-14 13:=
03:44 +0000)

are available in the Git repository at:

  git://git.breakpoint.cc/fw/mptcp-next.git tcp_poll_removal_06

for you to fetch changes up to fa583a84bcf9550783ac6a229ab584d68764659e:

  sendmsg: truncate source buffer if mptcp sndbuf size was set from userspa=
ce (2019-11-14 17:56:13 +0100)

----------------------------------------------------------------
Florian Westphal (14):
      selftest: add mmap-write support
      selftests: make sockets non-blocking for default poll mode
      mptcp: add wmem_queued accounting
      mptcp: allow partial cleaning of rtx head dfrag
      mptcp: add and use mptcp RTX flag
      sendmsg: block until mptcp sk is writeable
      subflow: sk_data_ready: make wakeup on tcp sock conditional
      mptcp: add and use mptcp_subflow_get_retrans
      mptcp: sendmsg: transmit on backup if other subflows have been closed
      recv: make DATA_READY reflect ssk in-sequence state
      sendmsg: clear SEND_SPACE if write caused wmem to grow too large
      mptcp_poll: don't consider subflow socket state anymore
      sendmsg: don't restart mptcp_sendmsg_frag
      sendmsg: truncate source buffer if mptcp sndbuf size was set from use=
rspace

 net/mptcp/options.c                                |   2 +-
 net/mptcp/protocol.c                               | 295 ++++++++++++++++-=
----
 net/mptcp/protocol.h                               |   4 +-
 net/mptcp/subflow.c                                |  12 +-
 tools/testing/selftests/net/mptcp/mptcp_connect.c  | 268 +++++++++++++++++=
+-
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |  36 ++-
 6 files changed, 544 insertions(+), 73 deletions(-)

--===============4570054396475310189==--
