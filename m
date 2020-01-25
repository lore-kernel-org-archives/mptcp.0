Content-Type: multipart/mixed; boundary="===============2528670666031986619=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 0/2] MPTCP: Fixups for part 2
Date: Fri, 24 Jan 2020 16:04:01 -0800
Message-ID: <20200125000403.251894-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 3508

--===============2528670666031986619==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A few fixes for MPTCP code that are needed before more features are
added in part 3.

Florian Westphal (1):
  mptcp: do not inherit inet proto ops

Mat Martineau (1):
  mptcp: Fix code formatting

 include/net/ipv6.h   |  3 ++
 net/mptcp/protocol.c | 72 ++++++++++++++++++++++++++++++++------------
 net/mptcp/subflow.c  |  4 +--
 3 files changed, 57 insertions(+), 22 deletions(-)

-- =

2.25.0

--===============2528670666031986619==--
