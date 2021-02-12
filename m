Content-Type: multipart/mixed; boundary="===============2764873185904909232=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 0/4] mptcp: Selftest enhancement and fixes
Date: Fri, 12 Feb 2021 15:20:26 -0800
Message-ID: <20210212232030.377261-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 7778

--===============2764873185904909232==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is a collection of selftest updates from the MPTCP tree.

Patch 1 uses additional 'ss' command line parameters and 'nstat' to
improve output when certain MPTCP tests fail.

Patches 2 & 3 fix a copy/paste error and some output formatting.

Patch 4 makes sure tests still pass if certain connection-related
packets are retransmitted.

Matthieu Baerts (3):
  selftests: mptcp: fix ACKRX debug message
  selftests: mptcp: display warnings on one line
  selftests: mptcp: fail if not enough SYN/3rd ACK

Paolo Abeni (1):
  selftests: mptcp: dump more info on errors

 .../selftests/net/mptcp/mptcp_connect.sh      | 94 +++++++++++++------
 1 file changed, 66 insertions(+), 28 deletions(-)


base-commit: c3ff3b02e99c691197a05556ef45f5c3dd2ed3d6
-- =

2.30.1

--===============2764873185904909232==--
