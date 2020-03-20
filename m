Content-Type: multipart/mixed; boundary="===============7130388770515400045=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] topmsg: mptcp: Implement path manager interface
 commands
Date: Thu, 19 Mar 2020 17:23:04 -0700
Message-ID: <20200320002307.89947-2-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 4005

--===============7130388770515400045==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 .topmsg | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/.topmsg b/.topmsg
index 4e07f2eb6511..950299549f45 100644
--- a/.topmsg
+++ b/.topmsg
@@ -1,9 +1,8 @@
 From: Peter Krystad <peter.krystad(a)linux.intel.com>
 Subject: [PATCH] mptcp: Implement path manager interface commands
 =

-Use the addr_signal flag to indicate to the subflow layer
-that a local address may be announced, and call subflow_connect()
-to initiate a secondary subflow.
+Fill in more path manager functionality by adding a worker function and
+modifying the related stub functions to schedule the worker.
 =

 Co-developed-by: Florian Westphal <fw(a)strlen.de>
 Signed-off-by: Florian Westphal <fw(a)strlen.de>
-- =

2.25.2

--===============7130388770515400045==--
