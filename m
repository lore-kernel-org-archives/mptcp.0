Content-Type: multipart/mixed; boundary="===============7567838463794661658=="
MIME-Version: 1.0
From: Geert Uytterhoeven <geert at linux-m68k.org>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: MPTCP_IPV6 should depend on IPV6 instead of
 selecting it
Date: Tue, 20 Oct 2020 09:38:39 +0200
Message-ID: <20201020073839.29226-1-geert@linux-m68k.org>
X-Status: 
X-Keywords:                  
X-UID: 6358

--===============7567838463794661658==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

MPTCP_IPV6 selects IPV6, thus enabling an optional feature the user may
not want to enable.  Fix this by making MPTCP_IPV6 depend on IPV6, like
is done for all other IPv6 features.

Fixes: f870fa0b5768842c ("mptcp: Add MPTCP socket stubs")
Signed-off-by: Geert Uytterhoeven <geert(a)linux-m68k.org>
---
 net/mptcp/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/Kconfig b/net/mptcp/Kconfig
index abb0a992d4a0855a..8936604b3bf9d76d 100644
--- a/net/mptcp/Kconfig
+++ b/net/mptcp/Kconfig
@@ -19,7 +19,7 @@ config INET_MPTCP_DIAG
 =

 config MPTCP_IPV6
 	bool "MPTCP: IPv6 support for Multipath TCP"
-	select IPV6
+	depends on IPV6
 	default y
 =

 config MPTCP_KUNIT_TESTS
-- =

2.17.1

--===============7567838463794661658==--
