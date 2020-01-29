Content-Type: multipart/mixed; boundary="===============8627277521453462222=="
MIME-Version: 1.0
From: Geert Uytterhoeven <geert at linux-m68k.org>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: MPTCP_HMAC_TEST should depend on MPTCP
Date: Wed, 29 Jan 2020 19:02:24 +0100
Message-ID: <20200129180224.700-1-geert@linux-m68k.org>
X-Status: 
X-Keywords:                  
X-UID: 3554

--===============8627277521453462222==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

As the MPTCP HMAC test is integrated into the MPTCP code, it can be
built only when MPTCP is enabled.  Hence when MPTCP is disabled, asking
the user if the test code should be enabled is futile.

Wrap the whole block of MPTCP-specific config options inside a check for
MPTCP.  While at it, drop the "default n" for MPTCP_HMAC_TEST, as that
is the default anyway.

Fixes: 65492c5a6ab5df50 ("mptcp: move from sha1 (v0) to sha256 (v1)")
Signed-off-by: Geert Uytterhoeven <geert(a)linux-m68k.org>
---
 net/mptcp/Kconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/Kconfig b/net/mptcp/Kconfig
index 5db56d2218c518c8..49f6054e7f4ebc15 100644
--- a/net/mptcp/Kconfig
+++ b/net/mptcp/Kconfig
@@ -10,17 +10,19 @@ config MPTCP
 	  uses the TCP protocol, and TCP options carry header information for
 	  MPTCP.
 =

+if MPTCP
+
 config MPTCP_IPV6
 	bool "MPTCP: IPv6 support for Multipath TCP"
-	depends on MPTCP
 	select IPV6
 	default y
 =

 config MPTCP_HMAC_TEST
 	bool "Tests for MPTCP HMAC implementation"
-	default n
 	help
 	  This option enable boot time self-test for the HMAC implementation
 	  used by the MPTCP code
 =

 	  Say N if you are unsure.
+
+endif
-- =

2.17.1

--===============8627277521453462222==--
