Content-Type: multipart/mixed; boundary="===============3907986164322600956=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp 0/4] four small cleanups and fixes
Date: Tue, 05 Nov 2019 18:05:27 +0100
Message-ID: <20191105170531.30407-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 2393

--===============3907986164322600956==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

1. cleanup: mptcp_subflow_get_map_offset arg can be const.
2. fix: don't advance snd_una past the write sequence.
3. cleanup: use existing helper rather than open-coding it
4. fix: avoid blocking kworker forever when polling mptcp socket.

All paches can be squashed, I've added squashto hints.

The following changes since commit 512f0321ae8a2679c15915b68f8a5cd98f190288:

  subflow: wake parent mptcp socket on subflow state change (2019-11-05 02:=
27:34 +0000)

are available in the Git repository at:

  git://git.breakpoint.cc/fw/mptcp-next.git mptcp_fixes_04

for you to fetch changes up to 50a570bb03f61cb5e2344e1d3f8d959c40d7b520:

  poll: release lock before waiting (2019-11-05 17:58:28 +0100)

----------------------------------------------------------------
Florian Westphal (4):
      protocol.h: mptcp_subflow_get_map_offset arg can be const
      options: ignore mptcp-level ack that is ahead of write_seq
      protocol: use sk_wait_event helper
      poll: release lock before waiting

 net/mptcp/options.c  |  6 ++++++
 net/mptcp/protocol.c | 16 ++++------------
 net/mptcp/protocol.h |  4 ++--
 3 files changed, 12 insertions(+), 14 deletions(-)


--===============3907986164322600956==--
