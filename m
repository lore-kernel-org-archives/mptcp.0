Content-Type: multipart/mixed; boundary="===============7948284145764439847=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 0/6] mptcp: refactor incoming options parsing
Date: Tue, 28 Apr 2020 16:11:23 +0200
Message-ID: <cover.1588082498.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4257

--===============7948284145764439847==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is an alternative solution for the pending option parsing solution,
previous attempt here:

https://lists.01.org/hyperkitty/list/mptcp(a)lists.01.org/thread/7FW4C3W4WS=
42GWTRWFQWCTCUYGKLIHFJ/

instead of adding (many) explicitly 'clear MPTCP options' operation to the
TCP code, it moves completely the options parsing into the MPTCP code - see
patch 2/6.

This addresses also the problems with the previois attempt for no-mptcp-opt
pkts.

patch 1/6 is a needed pre-requisites, while patch 3,4,5 are smaller somewhat
releated fixes.

patch 6/6 is just a minor clean-up and likely could be squashed into 6/6.

Stress test with syzkaller repro survived a few hours run without any splas=
h,
while I can hit WARN_ON() on top of current export branch + pending -net
fixes in a few mins with the same test.

Overall I'm personally more confident in this approach than in the previous=
 one.
Any comments more than welcome! Specifically I'm wondering if this should
target -net or net-next...

Paolo Abeni (6):
  mptcp: consolidate synack processing.
  mptcp: move option parsing into mptcp_incoming_options()
  mptcp: avoid a WARN on bad input.
  mptcp: fix 'use_ack' option access.
  mptcp: initialize data_fin field for mpc packets
  mptcp: cleanup option parsing

 include/linux/tcp.h  | 51 ------------------------
 include/net/mptcp.h  |  3 --
 net/ipv4/tcp_input.c |  7 ----
 net/mptcp/options.c  | 95 +++++++++++++++++++-------------------------
 net/mptcp/protocol.c |  6 +--
 net/mptcp/protocol.h | 43 +++++++++++++++++++-
 net/mptcp/subflow.c  | 81 +++++++++++++++++++++++--------------
 7 files changed, 137 insertions(+), 149 deletions(-)

-- =

2.21.1

--===============7948284145764439847==--
