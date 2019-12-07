Content-Type: multipart/mixed; boundary="===============5472300771272334463=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 4/4] MAINTAINERS: Add uapi header to MPTCP section
Date: Fri, 06 Dec 2019 16:12:44 -0800
Message-ID: <20191207001244.20339-4-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20191207001244.20339-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2843

--===============5472300771272334463==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

squashto: mptcp: allow dumping subflow context to userspace
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4e33511d1d78..a0eaff0c8bbc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11546,6 +11546,7 @@ W:	https://github.com/multipath-tcp/mptcp_net-next/=
wiki
 B:	https://github.com/multipath-tcp/mptcp_net-next/issues
 S:	Maintained
 F:	include/net/mptcp.h
+F:	include/uapi/linux/mptcp.h
 F:	net/mptcp/
 F:	tools/testing/selftests/net/mptcp/
 =

-- =

2.24.0

--===============5472300771272334463==--
