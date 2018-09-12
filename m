Content-Type: multipart/mixed; boundary="===============6359209746249298033=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/2] Forward-ports from mptcp_trunk
Date: Wed, 12 Sep 2018 11:16:38 -0700
Message-ID: <20180912181640.6663-1-cpaasch@apple.com>
X-Status: 
X-Keywords:                  
X-UID: 718

--===============6359209746249298033==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Christoph Paasch (1):
  mptcp: Iterate over subflow-list while holding the lock in
    tcp_splice_read

Patrick Havelange (1):
  mptcp: avoid removing useful skbs from the reinject queue.

 net/ipv4/tcp.c           | 15 ++++++++-------
 net/mptcp/mptcp_output.c |  3 +++
 2 files changed, 11 insertions(+), 7 deletions(-)

-- =

2.16.2


--===============6359209746249298033==--
