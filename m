Content-Type: multipart/mixed; boundary="===============3602219322597243117=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 3/3] MAINTAINERS: Add MPTCP selftests to MPTCP section
Date: Thu, 05 Dec 2019 15:06:01 -0800
Message-ID: <20191205230601.21396-3-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20191205230601.21396-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2804

--===============3602219322597243117==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

squashto: mptcp: add basic kselftest for mptcp
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2e3995395f7d..8ed833d319e9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11544,6 +11544,7 @@ L:	netdev(a)vger.kernel.org
 S:	Maintained
 F:	include/net/mptcp.h
 F:	net/mptcp/
+F:	tools/testing/selftests/net/mptcp/
 =

 NETWORKING [TCP]
 M:	Eric Dumazet <edumazet(a)google.com>
-- =

2.24.0

--===============3602219322597243117==--
