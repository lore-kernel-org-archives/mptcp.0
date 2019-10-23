Content-Type: multipart/mixed; boundary="===============8961178953281728637=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 0/4] mptcp: switch mptcp_poll to use parent sock
 wait queue
Date: Wed, 23 Oct 2019 16:23:51 +0200
Message-ID: <20191023142355.31599-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 2285

--===============8961178953281728637==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

No major changes, except the rebase on current export branch.
Selftest still passes.

This series is needed for sendmsg refactor, without it we can't
make mptcp sendmsg wait on the mptcp socket wait queue because we don't
get the needed wakeup events from the subflow layer.

The following changes since commit 85c93de446d3fd90e47605ba8ff161bef7558f09:

  mptcp: Implement basic path manager (2019-10-23 01:31:04 +0000)

are available in the Git repository at:

  git://git.breakpoint.cc/fw/mptcp-next.git mptcp_poll_07

for you to fetch changes up to 864dd47df1293e4b8bfc70be0d459286b6dddc3a:

  mptcp: switch mptcp_poll to mptcp socket wait queue (2019-10-23 15:20:28 =
+0200)

----------------------------------------------------------------
Florian Westphal (4):
      mptcp: add and use subflow_write_space
      subflow: wake parent mptcp socket on subflow state change
      net: tcp: add __tcp_poll helper
      mptcp: switch mptcp_poll to mptcp socket wait queue

 include/net/tcp.h    |  1 +
 net/ipv4/tcp.c       | 12 ++++++++----
 net/mptcp/protocol.c |  4 +++-
 net/mptcp/subflow.c  | 34 ++++++++++++++++++++++++++++++++++
 4 files changed, 46 insertions(+), 5 deletions(-)


--===============8961178953281728637==--
