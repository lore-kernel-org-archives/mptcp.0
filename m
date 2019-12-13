Content-Type: multipart/mixed; boundary="===============6196799899199338157=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] .topmsg: mptcp: recvmsg() can drain data from
 multiple subflows
Date: Thu, 12 Dec 2019 16:58:20 -0800
Message-ID: <20191213005822.29791-5-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20191213005822.29791-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2917

--===============6196799899199338157==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Remove outdated message about refcounting and rephrase sentence about
exit conditions.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 .topmsg | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/.topmsg b/.topmsg
index a85749abe8df..4dcec6101f4b 100644
--- a/.topmsg
+++ b/.topmsg
@@ -3,12 +3,9 @@ Subject: [PATCH] mptcp: recvmsg() can drain data from mult=
iple subflows
 =

 With the previous patch in place, the msk can detect which subflow
 has the current map with a simple walk, let's update the main
-loop to always select the 'current' subflow.
-
-Additionally:
-- changes the exit conditions to mirror closely tcp_recvmsg()
-this should fix unexpected behavior with timeout and signals.
-- avoid unneeded refcounting on ssk
+loop to always select the 'current' subflow. The exit conditions now
+closely mirror tcp_recvmsg() to get expected timeout and signal
+behavior.
 =

 Co-developed-by: Peter Krystad <peter.krystad(a)linux.intel.com>
 Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
-- =

2.24.1

--===============6196799899199338157==--
