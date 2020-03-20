Content-Type: multipart/mixed; boundary="===============4463122475229245039=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/2] Correctly handle port field in ADD_ADDR option
Date: Fri, 20 Mar 2020 10:51:49 -0700
Message-ID: <20200320175151.4665-1-peter.krystad@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 4023

--===============4463122475229245039==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Existing code allows ADD_ADDR option lengths that include the port field,
so we should correctly parse options with those lengths.


Peter Krystad (2):
  mptcp: Parse optional port field of ADD_ADDR
  mptcp: Include ADD_ADDR port value for path manager

 include/linux/tcp.h |  1 +
 net/mptcp/options.c | 11 +++++++++++
 2 files changed, 12 insertions(+)

-- =

2.17.2

--===============4463122475229245039==--
