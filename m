Content-Type: multipart/mixed; boundary="===============4054596965604103913=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] .topmsg mptcp: Associate MPTCP context with TCP socket
Date: Thu, 12 Dec 2019 16:58:18 -0800
Message-ID: <20191213005822.29791-3-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20191213005822.29791-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2915

--===============4054596965604103913==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Clarify that the added bind and connect functions are related to the
MPTCP subflow context code.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 .topmsg | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/.topmsg b/.topmsg
index 067bd9748a64..ac9e3fe89fef 100644
--- a/.topmsg
+++ b/.topmsg
@@ -1,8 +1,10 @@
 From: Peter Krystad <peter.krystad(a)linux.intel.com>
 Subject: [PATCH] mptcp: Associate MPTCP context with TCP socket
 =

-Use ULP to associate a subflow_context structure with each TCP
-subflow socket.
+Use ULP to associate a subflow_context structure with each TCP subflow
+socket. Creating these sockets requires new bind and connect functions
+to make sure ULP is set up immediately when the subflow sockets are
+created.
 =

 Co-developed-by: Florian Westphal <fw(a)strlen.de>
 Signed-off-by: Florian Westphal <fw(a)strlen.de>
@@ -12,4 +14,5 @@ Co-developed-by: Davide Caratti <dcaratti(a)redhat.com>
 Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
 Co-developed-by: Paolo Abeni <pabeni(a)redhat.com>
 Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
+Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
 Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
-- =

2.24.1

--===============4054596965604103913==--
