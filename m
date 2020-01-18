Content-Type: multipart/mixed; boundary="===============1292049660705334369=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] Update commit message for "mptcp: cope with later TCP
 fallback"
Date: Fri, 17 Jan 2020 17:29:24 -0800
Message-ID: <20200118012924.23062-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 3420

--===============1292049660705334369==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 .topmsg | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/.topmsg b/.topmsg
index 58389f14ec17..542b142671a9 100644
--- a/.topmsg
+++ b/.topmsg
@@ -1,10 +1,10 @@
 From: Paolo Abeni <pabeni(a)redhat.com>
 Subject: [PATCH] mptcp: cope with later TCP fallback
 =

-With V1 passive connections can fallback TCP after that the
-subflow become established:
+With MPTCP v1, passive connections can fallback to TCP after the
+subflow becomes established:
 =

-syn+ MP_CAPABLE ->
+syn + MP_CAPABLE ->
                <- syn, ack + MP_CAPABLE
 =

 ack, seq =3D 3    ->
@@ -19,8 +19,8 @@ We can't use the 'subflow' socket fallback, as we don't h=
ave
 it available for passive connection.
 =

 Instead, when the fallback is detected, replace the mptcp
-socket with the underlining TCP subflow. Beyond covering
-the above scenario, it makes TCP fallback socket as efficient
+socket with the underlying TCP subflow. Beyond covering
+the above scenario, it makes a TCP fallback socket as efficient
 as plain TCP ones.
 =

 Co-developed-by: Florian Westphal <fw(a)strlen.de>
-- =

2.25.0

--===============1292049660705334369==--
