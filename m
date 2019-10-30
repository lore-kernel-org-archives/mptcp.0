Content-Type: multipart/mixed; boundary="===============2744267960345300606=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 0/2] mptcp: add primitive scheduler
Date: Wed, 30 Oct 2019 15:03:55 +0100
Message-ID: <20191030140357.11880-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 2352

--===============2744267960345300606==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is a simplified version of a sendmsg ssk selection strategy,
so sendmsg or retransmit could also occur on a backup subflow.

In the initial submission it was pointed out that we should not
send more data when a retransmission is happening.

As this isn't directly related to this I've decided to send those two
patches now and work on sendmsg moderation next.

The plan is to add wmem_queued accounting to the mptcp socket and
then make sendmsg/mptcp_poll consider mptcp socket wmem limits to
avoid sending more data if there are no mptcp-level acknowledgements.

This however might take some time because msk->ack_seq update occurs only
at recvmsg time and not during mptcp ack processing.
For this to work properly, mptcp-level ack update should not depend on
a recvmsg call.

The following changes since commit dcb69525165804b78e07ed7875d33463a3fde7c8:

  subflow: wake parent mptcp socket on subflow state change (2019-10-30 02:=
24:34 +0000)

are available in the Git repository at:

  git://git.breakpoint.cc/fw/mptcp-next.git sendmsg_refactor_19

for you to fetch changes up to a1cb9992e1f55156914dc0e6727f92463fb96938:

  mptcp: sendmsg: transmit on backup if other subflows have been closed (20=
19-10-30 14:42:48 +0100)

----------------------------------------------------------------
Florian Westphal (2):
      mptcp: add and use mptcp_subflow_get_retrans
      mptcp: sendmsg: transmit on backup if other subflows have been closed

 net/mptcp/protocol.c | 102 ++++++++++++++++++++++++++++++++++++++++++++++-=
----
 net/mptcp/protocol.h |   1 +
 net/mptcp/subflow.c  |   7 +++-
 3 files changed, 100 insertions(+), 10 deletions(-)


--===============2744267960345300606==--
