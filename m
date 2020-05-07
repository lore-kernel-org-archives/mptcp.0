Content-Type: multipart/mixed; boundary="===============4805467826348329618=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 0/2] mptcp: cope better with MP_JOIN failure
Date: Thu, 07 May 2020 16:30:22 +0200
Message-ID: <cover.1588861016.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4337

--===============4805467826348329618==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is an attempt to fix the weird behavior we currently have on MP JOIN
failures.
In the end I was unable to find a way to address the thing without touching
tcp_check_req(), but this is an attempt to keep the impact for !MPTCP build
null, and the MPTCP overhead as low as possible.

Paolo Abeni (2):
  mptcp: add new sock flag to deal with join subflows
  mptcp: cope better with MP_JOIN failure

 include/linux/tcp.h      |  1 +
 include/net/mptcp.h      | 17 ++++++++++-------
 net/ipv4/tcp_minisocks.c |  2 +-
 net/mptcp/protocol.c     |  7 -------
 net/mptcp/subflow.c      | 19 +++++++++++++------
 5 files changed, 25 insertions(+), 21 deletions(-)

-- =

2.21.1

--===============4805467826348329618==--
