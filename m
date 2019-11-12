Content-Type: multipart/mixed; boundary="===============8463067316381436942=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 0/4] mptcp: add and use wmem_queued accounting
Date: Tue, 12 Nov 2019 15:10:34 +0100
Message-ID: <20191112141038.19213-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 2483

--===============8463067316381436942==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is v2 of the wmem accouting patch set.

I've dropped the ack_seq patches, we can resurrect them later on if needed.

After adding wmem thresholds, mptcp can deadlock at connection level when
both sides call write() at the same time and sndbuf is exhausted.

This won't happen in the selftests because it only sends small amounts
of data at a time and will always call read() if data is available.
It could happen with code that sends large amount of data at once
though, or when sndbuf is reduced via setsockopt:

Unlike TCP, which acknowledges in-sequence bytes queued to the socket, MPTCP
updates its ack_seq only when recv() is called.

In case both peers are blocked in write, no updates of the mptcp ack
sequence space occurs.  This in turn can prevent both peers from making
any progress: even if all data is queued on the peer, it will look like no
data arrived and thus no wmem can be freed up for the write() to complete.

Resolving this will need more work to get pushed into the data_ready
callback, which is hard because of need to synchronize with other subflows
used by same mptcp socket.

The following changes since commit 6e61dd3c078fe69ac2e442a9251d771a61dcc62f:

  subflow: wake parent mptcp socket on subflow state change (2019-11-08 15:=
22:58 +0000)

are available in the Git repository at:

  git://git.breakpoint.cc/fw/mptcp-next.git wmem_acct_06

for you to fetch changes up to eea081f8828bbe2c503873319374a7666c6b6af2:

  sendmsg: block until mptcp sk is writeable (2019-11-12 14:53:29 +0100)

----------------------------------------------------------------
Florian Westphal (4):
      mptcp: add wmem_queued accounting
      mptcp: allow partial cleaning of rtx head dfrag
      mptcp: add and use mptcp RTX flag
      sendmsg: block until mptcp sk is writeable

 net/mptcp/options.c  |  2 +-
 net/mptcp/protocol.c | 77 +++++++++++++++++++++++++++++++++++++++++++++---=
----
 net/mptcp/protocol.h |  3 +-
 3 files changed, 70 insertions(+), 12 deletions(-)

--===============8463067316381436942==--
