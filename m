Content-Type: multipart/mixed; boundary="===============5822664081251933554=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 0/3] mptcp: add fastclose option
Date: Wed, 25 Nov 2020 18:49:53 +0100
Message-ID: <20201125174956.9222-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 6931

--===============5822664081251933554==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series adds receive side support for fastclose processing.
First patch is needed to avoid UAF after enabling option processing
for tcp resets. Second patch calls mptcp option parsing also for
reset patckets so fastclose-on-tcp-reset is handled.

Last patch adds fastclose handling.

I've submitted a pull request vs. packetdrill to add test cases for
this: https://github.com/multipath-tcp/packetdrill/pull/25

Those are the three test cases i posted earlier to this list plus
a 4th test to also cover the 'two subflows closed via fastclose+reset' case.

I would send the fastclose tx side next.

I plan to hold the MPTCP reset patches back for the time being until
netlink + mptcpd are aware of its existence.

 include/net/tcp.h        |    2 +-
 net/ipv4/tcp_input.c     |   13 ++++++++-----
 net/ipv4/tcp_minisocks.c |    2 +-
 net/mptcp/options.c      |   15 +++++++++++++++
 net/mptcp/protocol.c     |   33 +++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h     |    4 ++++
 net/mptcp/subflow.c      |    7 ++++++-
 7 files changed, 68 insertions(+), 8 deletions(-)

--===============5822664081251933554==--
