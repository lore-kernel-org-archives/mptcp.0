Content-Type: multipart/mixed; boundary="===============5034837162534962324=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 0/3] DATA_FIN fixes
Date: Tue, 04 Feb 2020 18:06:45 -0800
Message-ID: <20200205020648.72997-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 3587

--===============5034837162534962324==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

More changes are needed for multi-subflow DATA_FIN support, but these
fixes (especially the first two) may be worth applying to the 5.6 tree
for single subflow. Self tests pass, and I checked the headers with
DATA_FIN for both the DATA_FIN-only DSS option and packet with a full
mapping and DATA_FIN.

Mat Martineau (3):
  mptcp: Check connection state before attempting send
  mptcp: Use per-subflow storage for DATA_FIN sequence number
  mptcp: Only send DATA_FIN with final mapping

 net/mptcp/options.c  | 16 ++++++++--------
 net/mptcp/protocol.c | 31 ++++++++++++++++++++++++++-----
 net/mptcp/protocol.h |  2 ++
 3 files changed, 36 insertions(+), 13 deletions(-)

-- =

2.25.0

--===============5034837162534962324==--
