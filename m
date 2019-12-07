Content-Type: multipart/mixed; boundary="===============6885468286112782701=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 3/4] MAINTAINERS: Add MPTCP selftests to MPTCP
 section
Date: Fri, 06 Dec 2019 16:12:43 -0800
Message-ID: <20191207001244.20339-3-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20191207001244.20339-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2842

--===============6885468286112782701==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

squashto: mptcp: add basic kselftest for mptcp
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c08f6646b850..4e33511d1d78 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11547,6 +11547,7 @@ B:	https://github.com/multipath-tcp/mptcp_net-next/=
issues
 S:	Maintained
 F:	include/net/mptcp.h
 F:	net/mptcp/
+F:	tools/testing/selftests/net/mptcp/
 =

 NETWORKING [TCP]
 M:	Eric Dumazet <edumazet(a)google.com>
-- =

2.24.0

--===============6885468286112782701==--
