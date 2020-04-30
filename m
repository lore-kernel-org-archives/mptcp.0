Content-Type: multipart/mixed; boundary="===============7171214473055880755=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net v2 0/5] mptcp: fix incoming options parsing
Date: Thu, 30 Apr 2020 15:01:50 +0200
Message-ID: <cover.1588243786.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4283

--===============7171214473055880755==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series addresses a serious issue in MPTCP option parsing.

This is bigger than the usual -net change, but I was unable to find a
working, sane, smaller fix.

The core change is inside patch 2/5 which moved MPTCP options parsing from
the TCP code inside existing MPTCP hooks and clean MPTCP options status on
each processed packet.

The patch 1/5 is a needed pre-requisite, and patches 3,4,5 are smaller,
related fixes.

v1 -> v2:
 - cleaned-up patch 1/5
 - rebased on top of current -net

Paolo Abeni (5):
  mptcp: consolidate synack processing.
  mptcp: move option parsing into  mptcp_incoming_options()
  mptcp: avoid a WARN on bad input.
  mptcp: fix 'use_ack' option access.
  mptcp: initialize the data_fin field for mpc packets

 include/linux/tcp.h  | 51 ------------------------
 include/net/mptcp.h  |  3 --
 net/ipv4/tcp_input.c |  7 ----
 net/mptcp/options.c  | 95 +++++++++++++++++++-------------------------
 net/mptcp/protocol.c |  6 +--
 net/mptcp/protocol.h | 43 +++++++++++++++++++-
 net/mptcp/subflow.c  | 82 ++++++++++++++++++++++++--------------
 7 files changed, 138 insertions(+), 149 deletions(-)

-- =

2.21.1

--===============7171214473055880755==--
