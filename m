Content-Type: multipart/mixed; boundary="===============7705256116883194857=="
MIME-Version: 1.0
From: Geert Uytterhoeven <geert at linux-m68k.org>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: MPTCP_KUNIT_TESTS should depend on MPTCP
 instead of selecting it
Date: Mon, 19 Oct 2020 13:32:40 +0200
Message-ID: <20201019113240.11516-1-geert@linux-m68k.org>
X-Status: 
X-Keywords:                  
X-UID: 6350

--===============7705256116883194857==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

MPTCP_KUNIT_TESTS selects MPTCP, thus enabling an optional feature the
user may not want to enable.  Fix this by making the test depend on
MPTCP instead.

Fixes: a00a582203dbc43e ("mptcp: move crypto test to KUNIT")
Signed-off-by: Geert Uytterhoeven <geert(a)linux-m68k.org>
---
 net/mptcp/Kconfig | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/mptcp/Kconfig b/net/mptcp/Kconfig
index 698bc35251609755..abb0a992d4a0855a 100644
--- a/net/mptcp/Kconfig
+++ b/net/mptcp/Kconfig
@@ -22,11 +22,8 @@ config MPTCP_IPV6
 	select IPV6
 	default y
 =

-endif
-
 config MPTCP_KUNIT_TESTS
 	tristate "This builds the MPTCP KUnit tests" if !KUNIT_ALL_TESTS
-	select MPTCP
 	depends on KUNIT
 	default KUNIT_ALL_TESTS
 	help
@@ -39,3 +36,4 @@ config MPTCP_KUNIT_TESTS
 =

 	  If unsure, say N.
 =

+endif
-- =

2.17.1

--===============7705256116883194857==--
