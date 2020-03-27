Content-Type: multipart/mixed; boundary="===============8414828488788023775=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/6] mptcp: remove all "inline" in foo.c files
Date: Fri, 27 Mar 2020 16:53:21 +0100
Message-ID: <20200327155327.605375-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 4089

--===============8414828488788023775==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This remove all the "inline" in net/mptcp/*.c files as requested by davem.

Matthieu Baerts (6):
  Squash-to: "mptcp: queue data for mptcp level retransmission"
  topmsg: mptcp: queue data for mptcp level retransmission
  Squash-to: "mptcp: rework mptcp_sendmsg_frag to accept optional dfrag"
  topmsg: mptcp: rework mptcp_sendmsg_frag to accept optional dfrag
  Squash-to: "mptcp: add and use MIB counter infrastructure"
  topmsg: mptcp: add and use MIB counter infrastructure

 .topmsg              | 7 +++++--
 net/mptcp/protocol.c | 8 ++++----
 2 files changed, 9 insertions(+), 6 deletions(-)
 .topmsg              | 3 +++
 net/mptcp/protocol.c | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)
 .topmsg             | 3 +++
 net/mptcp/subflow.c | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

-- =

2.25.1

--===============8414828488788023775==--
