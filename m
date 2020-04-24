Content-Type: multipart/mixed; boundary="===============3435699307046267957=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 0/5] mptcp: more incoming option fixes
Date: Fri, 24 Apr 2020 19:14:07 +0200
Message-ID: <cover.1587738345.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4241

--===============3435699307046267957==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is a very early RFC showcasing the fix discussed in yday mtg - the
first 3 patches. It contains also fix/warkaround for the last warn() I'm
able to hit with syzbot repro provided by Christoph.

With this series and https://marc.info/?l=3Dlinux-netdev&m=3D15877269500915=
0&w=3D2
on top of -net I haven't hit any of the 'known' oops/warn so far, but
I'm hitting a WARN_ONCE("Bad mapping: "...) I'm unsure it's =

introduced here or not.

Paolo Abeni (5):
  mptcp: add and use wrappers to manipulate mptcp opt flags
  mptcp: use a single sub_option field in mptcp_incoming_option
  tcp: init MPTCP option before parsing.
  mptcp: avoid a WARN on bad input.
  mptcp: fix 'use_ack' option access.

 include/linux/tcp.h  | 27 +++++++++-----------
 net/ipv4/tcp_input.c |  1 +
 net/mptcp/options.c  | 41 +++++++++++++++---------------
 net/mptcp/protocol.c |  2 +-
 net/mptcp/protocol.h | 60 ++++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/subflow.c  | 23 ++++++++---------
 6 files changed, 105 insertions(+), 49 deletions(-)

-- =

2.21.1

--===============3435699307046267957==--
