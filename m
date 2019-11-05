Content-Type: multipart/mixed; boundary="===============3453125162924707884=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/5] mptcp: Make MPTCP IPv6 support depend on
 CONFIG_IPV6=y
Date: Tue, 05 Nov 2019 11:05:53 -0800
Message-ID: <20191105190557.6405-1-peter.krystad@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 2401

--===============3453125162924707884==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Do not allow MPTCP IPv6 support if IPv6 is included as a module.

squashto: Add MPTCP socket stubs

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/Kconfig | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/Kconfig b/net/mptcp/Kconfig
index f21190a4f7e9..c1a99f07a4cd 100644
--- a/net/mptcp/Kconfig
+++ b/net/mptcp/Kconfig
@@ -1,6 +1,6 @@
 =

 config MPTCP
-	bool "Multipath TCP"
+	bool "MPTCP: Multipath TCP"
 	depends on INET
 	select SKB_EXTENSIONS
 	help
@@ -9,3 +9,8 @@ config MPTCP
 	  uses the TCP protocol, and TCP options carry header information for
 	  MPTCP.
 =

+config MPTCP_IPV6
+	bool "MPTCP: IPv6 support for Multipath TCP"
+	depends on MPTCP
+	select IPV6
+	default y
-- =

2.17.2

--===============3453125162924707884==--
