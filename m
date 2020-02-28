Content-Type: multipart/mixed; boundary="===============2212153138966389991=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net 0/3] DATA_FIN fixes proposed for net tree
Date: Thu, 27 Feb 2020 16:29:38 -0800
Message-ID: <20200228002941.99393-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 3817

--===============2212153138966389991==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

More changes are needed for multi-subflow DATA_FIN support, but these
fixes may be worth applying to the 5.6 tree for single subflow. Self
tests pass, and I checked the headers with DATA_FIN for both the
DATA_FIN-only DSS option and packet with a full mapping and DATA_FIN.

I'll send to netdev following review on this list.

RFC -> v1: Rebased on current net tree

Mat Martineau (3):
  mptcp: Check connection state before attempting send
  mptcp: Use per-subflow storage for DATA_FIN sequence number
  mptcp: Only send DATA_FIN with final mapping

 net/mptcp/options.c  | 16 ++++++++--------
 net/mptcp/protocol.c | 32 +++++++++++++++++++++++++++-----
 net/mptcp/protocol.h |  2 ++
 3 files changed, 37 insertions(+), 13 deletions(-)


base-commit: 3ee339eb28959629db33aaa2b8cde4c63c6289eb
-- =

2.25.1

--===============2212153138966389991==--
